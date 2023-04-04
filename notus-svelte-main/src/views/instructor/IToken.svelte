<script>
  // core components
  import CardTransferToken from "components/Cards/ForInstr/ICardTransferToken.svelte";
  import CardProfileToken from "components/Cards/ForInstr/ICardProfileToken.svelte";
  export let location;
</script>

<div class="flex flex-wrap">
  <div class="w-full lg:w-8/12 px-4">
    <CardTransferToken />
  </div>
  <div class="w-full lg:w-4/12 px-4">
    <CardProfileToken />
  </div>
</div>
          