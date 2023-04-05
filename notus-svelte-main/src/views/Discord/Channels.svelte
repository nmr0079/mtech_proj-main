<script>
   import { link } from "svelte-routing";

// core components
import NotificationDropdown from "components/Dropdowns/NotificationDropdown.svelte";
import UserDropdown from "components/Dropdowns/UserDropdown.svelte";

let collapseShow = "hidden";

function toggleCollapseShow(classes) {
  collapseShow = classes;
}

export let location;
  import { ethers } from "ethers";
  import { onMount } from "svelte";
  let currentChannel = null;
  // export let channels;
  import Dappcord from "../../../../build/contracts/Dappcord.json";
  import DappcordAddress from "../../../contractsData/Dappcord-address.json";

  const API_KEY =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDdDMTIwZDE0QWJGMzFCNzU5NzJDODkwNTYzRDc1QmRlNTQ2RWYzZUEiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2NjMxMzUyMTY5OTgsIm5hbWUiOiJFSFJ0b2tlbiJ9.qf_TPOWIqbXJVSsOhv0oywTJCYNsuJ3VVYOX-qA0H6g";
    const API = "https://api.web3.storage";
    let connectedAccount = "";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();

    const DappcordContract = new ethers.Contract(
        DappcordAddress.address,
        Dappcord.abi,
        signer
    );
    
    let channels = [];
    const loadChannels = async () => {
      console.log("loading channels")
      connectedAccount = await signer.getAddress();
      const totalChannels = await DappcordContract.totalChannels({from : connectedAccount});
      console.log("total channels")
      console.log(totalChannels)
      let channels_list = [];
      for (let i = 1; i <= totalChannels; i++) {
        const channel = await DappcordContract.getChannel(i,{from : connectedAccount});
        console.log(channel.name)
        channels_list.push(channel);
      }
      channels = channels_list
    } 
    channels = channels

  const channelHandler = async (channel) => {
    // Check if user has joined
    // If they haven't allow them to mint.
    const hasJoined = await DappcordContract.hasJoined(channel.id, account);

    if (hasJoined) {
      // setCurrentChannel(channel);
      currentChannel = channel
    } else {
      // const signer = await provider.getSigner();
      const transaction = await DappcordContract
        .connect(signer)
        .mint(channel.id, { value: channel.cost });
      await transaction.wait();
      // setCurrentChannel(channel);
      currentChannel = channel
    }
  };
  
  onMount(() => {
    loadChannels();
    if (currentChannel) {
      channelHandler(currentChannel);
    }
  });
</script>

<!-- <div class="channels">
  <div class="channels__text">
    <h2>Text Channels</h2>

    <ul>
      {#each channels as channel, index}
        <li
          on:click={() => channelHandler(channel)}
          class:selected={currentChannel && currentChannel.id.toString() === channel.id.toString()}
          key={index}
        >
          {channel.name}
        </li>
      {/each}
    </ul>
  </div>

  <div class="channels__voice">
    <h2>Voice Channels</h2>

    <ul>
      <li>Channel 1</li>
      <li>Channel 2</li>
      <li>Channel 3</li>
    </ul>
  </div>
</div> -->

<nav
  class="md:left-0 md:block md:fixed md:top-0 md:bottom-0 md:overflow-y-auto md:flex-row md:flex-nowrap md:overflow-hidden shadow-xl bg-white flex flex-wrap items-center justify-between relative md:w-64 z-10 py-4 px-6"
>
  <div
    class="md:flex-col md:items-stretch md:min-h-full md:flex-nowrap px-0 flex flex-wrap items-center justify-between w-full mx-auto"
  >
    <!-- Toggler -->
    <button
      class="cursor-pointer text-black opacity-50 md:hidden px-3 py-1 text-xl leading-none bg-transparent rounded border border-solid border-transparent"
      type="button"
      on:click={() => toggleCollapseShow('bg-white m-2 py-3 px-6')}
    >
      <i class="fas fa-bars"></i>
    </button>
    <!-- Brand -->
    <a
      use:link
      class="md:block text-left md:pb-2 text-blueGray-600 mr-0 inline-block whitespace-nowrap text-sm uppercase font-bold p-4 px-0"
      href="/"
    >
      Dappcord
    </a>
    <!-- User -->
    <ul class="md:hidden items-center flex flex-wrap list-none">
      <li class="inline-block relative">
        <NotificationDropdown />
      </li>
      <li class="inline-block relative">
        <UserDropdown />
      </li>
    </ul>
    <!-- Collapse -->
    <div
      class="md:flex md:flex-col md:items-stretch md:opacity-100 md:relative md:mt-4 md:shadow-none shadow absolute top-0 left-0 right-0 z-40 overflow-y-auto overflow-x-hidden h-auto items-center flex-1 rounded {collapseShow}"
    >
      <!-- Collapse header -->
      <div
        class="md:min-w-full md:hidden block pb-4 mb-4 border-b border-solid border-blueGray-200"
      >
        <div class="flex flex-wrap">
          <div class="w-6/12">
            <a
              use:link
              class="md:block text-left md:pb-2 text-blueGray-600 mr-0 inline-block whitespace-nowrap text-sm uppercase font-bold p-4 px-0"
              href="/"
            >
              Dappcord
            </a>
          </div>
          <div class="w-6/12 flex justify-end">
            <button
              type="button"
              class="cursor-pointer text-black opacity-50 md:hidden px-3 py-1 text-xl leading-none bg-transparent rounded border border-solid border-transparent"
              on:click={() => toggleCollapseShow('hidden')}
            >
              <i class="fas fa-times"></i>
            </button>
          </div>
        </div>
      </div>
      <!-- Form -->
      <form class="mt-6 mb-4 md:hidden">
        <div class="mb-3 pt-0">
          <input
            type="text"
            placeholder="Search"
            class="border-0 px-3 py-2 h-12 border border-solid border-blueGray-500 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-base leading-snug shadow-none outline-none focus:outline-none w-full font-normal"
          />
        </div>
      </form>

      <!-- Divider -->
      <hr class="my-4 md:min-w-full" />
      <!-- Heading -->
      <h6
        class="md:min-w-full text-blueGray-500 text-xs uppercase font-bold block pt-1 pb-4 no-underline"
      >
        Text Channels
      </h6>
      <!-- Navigation -->

      <ul class="md:flex-col md:min-w-full flex flex-col list-none">
        {#each channels as channel, index}
        <li class="items-center"  on:click={() => channelHandler(channel)}
          class:selected={currentChannel && currentChannel.id.toString() === channel.id.toString()}
          key={index}>
            {channel.name}
        </li>
        {/each}
        </ul>
    </div>
  </div>
</nav>


  