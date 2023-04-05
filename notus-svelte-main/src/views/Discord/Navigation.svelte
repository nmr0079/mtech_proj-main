<script>
    import { ethers } from "ethers";
  
    // export let account;
    // export let setAccount;
    let account;
    let connectedAccount = "";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    
    const connectHandler = async () => {
    //   const accounts = await window.ethereum.request({
    //     method: "eth_requestAccounts",
    //   });
    //   const account = ethers.utils.getAddress(accounts[0]);
    connectedAccount = await signer.getAddress();
    account = connectedAccount;
    
    //   setAccount(account);
    };
  </script>
  
  <!-- <nav>
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
  </nav> -->
  <!-- Navbar -->
<nav
class="absolute top-0 left-0 w-full z-10 bg-transparent md:flex-row md:flex-nowrap md:justify-start flex items-center p-4"
>
<div
  class="w-full mx-autp items-center flex justify-between md:flex-nowrap flex-wrap md:px-10 px-4"
>
  <!-- Brand -->
  <a
    class="text-white text-sm uppercase hidden lg:inline-block font-semibold"
    href="#pablo" on:click={(e) => e.preventDefault()}
  >
    Dappcord
  </a>
  <!-- Form -->
  <!-- <form
    class="md:flex hidden flex-row flex-wrap items-center lg:ml-auto mr-3"
  >
    <div class="relative flex w-full flex-wrap items-stretch">
      <span
        class="z-10 h-full leading-snug font-normal absolute text-center text-blueGray-300 absolute bg-transparent rounded text-base items-center justify-center w-8 pl-3 py-3"
      >
        <i class="fas fa-search"></i>
      </span>
      <input
        type="text"
        placeholder="Search here..."
        class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 relative bg-white bg-white rounded text-sm shadow outline-none focus:outline-none focus:ring w-full pl-10"
      />
    </div>
  </form> -->
  <!-- User -->
  <ul class="flex-col md:flex-row list-none items-center hidden md:flex">
    {#if account}
    <!-- <button type="button" class="nav__connect">
      {account.slice(0, 6) + "..." + account.slice(38, 42)}
    </button> -->
    <a
    class="text-white text-sm uppercase hidden lg:inline-block font-semibold"
    href="#pablo"
  >
  {account.slice(0, 6) + "..." + account.slice(38, 42)}
  </a>
  {:else}
  <div
        class="w-full lg:w-4/12 px-4 lg:order-3 lg:text-right lg:self-center"
      >
        <div class="py-6 px-3 mt-32 sm:mt-0">
          <button
            class="bg-red-400 active:bg-red-500 uppercase text-white font-bold hover:shadow-md shadow text-xs px-4 py-2 rounded outline-none focus:outline-none sm:mr-2 mb-1 ease-linear transition-all duration-150"
            type="button"
            on:click={connectHandler}
          >
            Connect
          </button>
        </div>
      </div>
    <!-- <button type="button" class="nav__connect" on:click={connectHandler}>
      Connect
    </button> -->
  {/if}
  </ul>
</div>
</nav>
<!-- End Navbar -->

  