<script setup lang="ts">
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";
import vs from "assets/shaders/test.vs.glsl?raw";
import fs from "assets/shaders/test.fs.glsl?raw";
import { Clock, TextureLoader } from "three";

const myCanvas = ref();
const clock = new Clock();
const textureLoader = new TextureLoader();
onMounted(async () => {
  // main();
  // Scene
  const scene = new THREE.Scene(); //建立場景
  const texture = await textureLoader.loadAsync("1.jpg");
  // Object
  const geometry = new THREE.PlaneBufferGeometry(2, 2);
  // const material = new THREE.MeshBasicMaterial({ color: 0xff0000 });

  const material = new THREE.ShaderMaterial({
    vertexShader: vs,
    fragmentShader: fs,
    uniforms: {
      iTime: { value: 0 },
      uFrequency: { value: 10 },
      uTexture: {
        value: texture,
      },
      iResolution: {
        value: { x: myCanvas.value.width, y: myCanvas.value.height, z: 1 },
      },
    },
  });

  // Mesh
  const mesh = new THREE.Mesh(geometry, material);

  scene.add(mesh);

  // Sizes
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  };
  console.log(sizes);

  // Camera
  const camera = new THREE.OrthographicCamera(
    -1, // left
    1, // right
    1, // top
    -1, // bottom
    -1, // near,
    1 // far
  );

  // Renderer
  const renderer = new THREE.WebGLRenderer({
    canvas: myCanvas.value,
    antialias: true,
  });
  renderer.autoClearColor = false;
  renderer.setSize(sizes.width, sizes.height);

  // Control

  //以下為最簡短操作需求
  const orbitControl = new OrbitControls(camera, myCanvas.value);

  // Animate
  const tick = () => {
    // console.log(material.uniforms.time.value);
    resizeRendererToDisplaySize(renderer);

    material.uniforms.iResolution.value = {
      x: myCanvas.value.width,
      y: myCanvas.value.height,
      z: 1,
    };

    material.uniforms.iTime.value = clock.getElapsedTime();

    renderer.render(scene, camera);

    material.needsUpdate = true;
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
    // camera.aspect = sizes.width / sizes.height; //這個值是預防圖像扭曲
    camera.updateProjectionMatrix(); //然後執行這個來更新camera內部數值
  });
  renderer.setAnimationLoop(tick);
});

function resizeRendererToDisplaySize(renderer) {
  const canvas = renderer.domElement;
  const width = canvas.clientWidth;
  const height = canvas.clientHeight;
  const needResize = canvas.width !== width || canvas.height !== height;
  if (needResize) {
    renderer.setSize(width, height, false);
  }
  return needResize;
}
</script>

<template>
  <div>
    <canvas ref="myCanvas"> </canvas>
  </div>
</template>
