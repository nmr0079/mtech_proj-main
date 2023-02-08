<script>
	import CardUploadFile from './../../components/Cards/CardUploadFile.svelte';
    // core components
    import CardProfileToken from "components/Cards/CardProfileToken.svelte";
    export let location;
  </script>
  
  <div class="flex flex-wrap">
    <div class="w-full lg:w-8/12 px-4">
      <CardUploadFile />
    </div>
    <div class="w-full lg:w-4/12 px-4">
      <CardProfileToken />
    </div>
  </div>