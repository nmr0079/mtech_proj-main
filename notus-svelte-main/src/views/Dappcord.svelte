<script>
    import { onMount, onDestroy, setContext } from "svelte";
    import { ethers } from "ethers";
    import { io } from "socket.io-client";
  
    // Components
    import Navigation from "../views/Discord/Navigation.svelte";
    import Servers from "../views/Discord/Servers.svelte";
    import Channels from "../views/Discord/Channels.svelte";
    import Messages from "../views/Discord/Messages.svelte";
  
  
    // Config
    import config from "./config.json";
  
    // Socket
    const socket = io("ws://localhost:3030");
  
    let provider, account, dappcord, channels, currentChannel, messages;
  
    const loadBlockchainData = async () => {
  
      const totalChannels = await dappcord.totalChannels();
      channels = [];
  
      for (let i = 1; i <= totalChannels; i++) {
        const channel = await dappcord.getChannel(i);
        channels.push(channel);
      }
  
      window.ethereum.on("accountsChanged", async () => {
        window.location.reload();
      });
    };
  
    onMount(() => {
      loadBlockchainData();
  
      socket.on("connect", () => {
        socket.emit("get messages");
      });
  
      socket.on("new message", (messages) => {
        setContext("messages", messages);
      });
  
      socket.on("get messages", (messages) => {
        setContext("messages", messages);
      });
    });
  
    onDestroy(() => {
      socket.off("connect");
      socket.off("new message");
      socket.off("get messages");
    });
  </script>
  
  <Navigation account={account} setAccount={setAccount} />
  
  <main>
    <Servers />
  
    <Channels
      provider={provider}
      account={account}
      dappcord={dappcord}
      channels={channels}
      currentChannel={currentChannel}
      setCurrentChannel={(channel) => {
        currentChannel = channel;
      }}
    />
  
    <Messages
      account={account}
      messages={$messages}
      currentChannel={currentChannel}
    />
  </main>
  