<script setup lang="ts">
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";
import vs from "assets/shaders/test.vs.glsl?raw";
import fs from "assets/shaders/test.fs.glsl?raw";
import { TextureLoader } from "three";
import gsap from "gsap";

const myCanvas = ref();

onMounted(async () => {
  const textureLoader = new TextureLoader();
  // Scene
  const scene = new THREE.Scene(); //建立場景
  const ambientLight = new THREE.AmbientLight(0xffffff, 1.0);
  scene.add(ambientLight);
  // Object
  var geometry = new THREE.PlaneGeometry(3, 2); //矩形平面
  /**
   * 创建纹理对象的像素数据
   */
  var width = 128; //纹理宽度
  var height = 64; //纹理高度
  var size = width * height; //像素大小
  var data = new Uint8Array(size * 4); //size*4：像素在缓冲区占用空间
  for (let i = 0; i < size * 4; i += 4) {
    // 随机设置RGB分量的值
    data[i] = 255 * Math.random();
    data[i + 1] = 255 * Math.random();
    data[i + 2] = 255 * Math.random();
    // 设置透明度分量A
    data[i + 3] = 255;
  }
  // 创建数据文理对象   RGBA格式：THREE.RGBAFormat
  var uTexture = await textureLoader.loadAsync("1.jpg");
  var dTexture = new THREE.DataTexture(data, width, height, THREE.RGBAFormat);

  dTexture.needsUpdate = true; //纹理更新
  //打印纹理对象的image属性

  var material = new THREE.ShaderMaterial({
    fragmentShader: fs,
    vertexShader: vs,
    uniforms: {
      uTexture: { value: uTexture },
      dTexture: { value: dTexture },
      uDim: { value: 1 },
    },
    // map: texture, // 设置纹理贴图
    transparent: true, //允许透明设置
  });

  // console.log(.data);

  gsap.to(material.uniforms.uDim, {
    value: 0,
    duration: 0.5,
    onUpdate: () => {
      material.needsUpdate = true;
    },
  });

  var mesh = new THREE.Mesh(geometry, material);

  scene.add(mesh);

  // Sizes
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  };
  console.log(sizes);

  // Camera
  const camera = new THREE.PerspectiveCamera(75, sizes.width / sizes.height);
  camera.position.z = 3;
  scene.add(camera);

  // Renderer
  const renderer = new THREE.WebGLRenderer({
    canvas: myCanvas.value,
    antialias: true,
  });
  renderer.setSize(sizes.width, sizes.height);

  // Control

  //以下為最簡短操作需求
  const orbitControl = new OrbitControls(camera, myCanvas.value);

  // Animate
  const tick = () => {
    //Controls
    orbitControl.update();
    // Render
    renderer.render(scene, camera);
  };

  window.addEventListener("resize", () => {
    //Controls
    orbitControl.update();
    // Update sizes
    sizes.width = window.innerWidth;
    sizes.height = window.innerHeight;
    // Update renderer
    renderer.setSize(sizes.width, sizes.height);
    // Update camera
    camera.aspect = sizes.width / sizes.height; //這個值是預防圖像扭曲
    camera.updateProjectionMatrix(); //然後執行這個來更新camera內部數值
  });
  renderer.setAnimationLoop(tick);
});
</script>

<template>
  <div>
    <canvas ref="myCanvas"> </canvas>
  </div>
</template>
