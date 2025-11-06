
<!-- slide-bottom.vue -->
<template>
 

  <div class="abs-bl m-6 flex gap-2">
    <a href="https://fr.linkedin.com/company/peaksys" target="_blank" alt="Peaksys recrute" class="text-xl icon-btn opacity-50 !border-none !hover:text-white">
        <img src="/resources/peaksys_logo.png" class="h-8">
    </a>
    <a href="https://github.com/nicolas-boisseau/bdx-io-windows-on-kubernetes" target="_blank" alt="GitHub Profile" class="text-xl icon-btn opacity-50 !border-none !hover:text-white">
        <carbon-logo-github />
    </a>   
    <a href="https://bdxio.fr" target="_blank" alt="BDX.IO Website">
        <img src="/resources/bdxio-kit-communication/logo/logo-blanc.png" class="h-8">
    </a>
     
  </div>

  <img v-if="$page > 1 && $page < 15 && $page % 2 == 0" src="/resources/bdxio-kit-communication/illustrations/scribble-turquoise.png" class="h-10 absolute right-10 bottom-6" />
  <img v-if="$page > 1 && $page < 15 && $page % 2 == 1" src="/resources/bdxio-kit-communication/illustrations/scribble-yellow.png" class="h-10 absolute right-10 bottom-6" />

</template>



