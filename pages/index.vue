<script setup lang="ts">
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";

const myCanvas = ref();

onMounted(() => {
  // Scene
  const scene = new THREE.Scene(); //建立場景

  // Object
  const geometry = new THREE.BoxGeometry(1, 1, 1);
  // const material = new THREE.MeshBasicMaterial({ color: 0xff0000 });
  const material = new THREE.MeshNormalMaterial();
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
