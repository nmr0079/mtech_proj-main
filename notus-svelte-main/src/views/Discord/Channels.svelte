<script>
  import { ethers } from "ethers";
  import { onMount } from "svelte";
  let currentChannel = null;

  const channelHandler = async (channel) => {
    // Check if user has joined
    // If they haven't allow them to mint.
    const hasJoined = await dappcord.hasJoined(channel.id, account);

    if (hasJoined) {
      setCurrentChannel(channel);
    } else {
      const signer = await provider.getSigner();
      const transaction = await dappcord
        .connect(signer)
        .mint(channel.id, { value: channel.cost });
      await transaction.wait();
      setCurrentChannel(channel);
    }
  };
  
  onMount(() => {
    if (currentChannel) {
      channelHandler(currentChannel);
    }
  });
</script>

<div class="channels">
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
</div>

  