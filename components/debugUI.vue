<script setup lang="ts">
onMounted(async () => {
  console.log(mobileConsole);
  mobileConsole.init();
});

function ShowDebug() {
  mobileConsole.toggle();
}
</script>

<template>
  <div>
    <Head>
      <Script src="hnl.mobileConsole.js"></Script>
    </Head>
    <div class="fixed top-0 right-0 z-50 bg-white shadow-md w-fit">
      <button @click="ShowDebug">show debug</button>
    </div>
  </div>
</template>
