<script>
    import { ethers } from "ethers";
  
    export let account;
    export let setAccount;
    
    const connectHandler = async () => {
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      const account = ethers.utils.getAddress(accounts[0]);
      setAccount(account);
    };
  </script>
  
  <nav>
    <div class="nav__brand">
      <h1>Dappcord</h1>
    </div>
  
    {#if account}
      <button type="button" class="nav__connect">
        {account.slice(0, 6) + "..." + account.slice(38, 42)}
      </button>
    {:else}
      <button type="button" class="nav__connect" on:click={connectHandler}>
        Connect
      </button>
    {/if}
  </nav>
  