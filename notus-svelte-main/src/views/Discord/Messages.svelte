<!-- Messages.svelte -->
<script>
    import { onMount} from "svelte";
    import { io } from "socket.io-client";
    import {ethers} from "ethers";
    
    // Assets
    // import person from "../assets/person.svg";
    // import send from "../assets/send.svg";
    const person = "/assets/img/person.svg";
    const send =  "/assets/img/send.svg";
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
    
    
    // Socket
    const socket = io("ws://localhost:3030");
    
    // export let account;
    let account;
    export let messages;
    export let currentChannel;
    
    let message = "";
  
    let messageEndRef;
  
    const sendMessage = async (e) => {
      e.preventDefault();
      connectedAccount = await signer.getAddress();
      account = connectedAccount;
  
      const messageObj = {
        channel: currentChannel.id.toString(),
        account: connectedAccount,
        text: message,
      };
  
      if (message !== "") {
        socket.emit("new message", messageObj);
      }
  
      message = "";
    };
  
    const scrollHandler = () => {
      setTimeout(() => {
        messageEndRef.scrollIntoView({ behavior: "smooth" });
      }, 500);
    };
    
    onMount(() => {
      scrollHandler();
    });
    
    // onCleanup(() => {
    //   socket.disconnect();
    // });
  </script>
  
  <div class="text">
    <div class="messages">
      {#if currentChannel}
        {#each messages.filter(message => message.channel === currentChannel.id.toString()) as message, index}
          <div class="message" key={index}>
            <img src={person} alt="Person" />
            <div class="message_content">
              <h3>
                {message.account.slice(0, 6) + "..." + message.account.slice(38, 42)}
              </h3>
              <p>{message.text}</p>
            </div>
          </div>
        {/each}
      {/if}
  
      <div bind:this={messageEndRef} />
    </div>
  
    <form on:submit={sendMessage}>
      {#if currentChannel && account}
        <input
          type="text"
          bind:value={message}
          placeholder={`Message #${currentChannel.name}`}
          on:input={(e) => message = e.target.value}
        />
      {:else}
        <input
          type="text"
          value=""
          placeholder={`Please Connect Wallet / Join the Channel`}
          disabled
        />
      {/if}
  
      <button type="submit">
        <div class="flex flex-wrap justify-center">
            <div class="w-6/12 sm:w-4/12 px-4">
              <img src={send} alt="Send Message" class="shadow rounded-full max-w-full h-auto align-middle border-none" />
            </div>
          </div>
      </button>
    </form>
  </div>
  
  <style>
    .text {
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: calc(100% - 72px);
    }
    
    .messages {
      flex-grow: 1;
      overflow-y: scroll;
      padding: 16px;
      background-color: #2f3136;
    }
    
    .message {
      display: flex;
      margin-bottom: 16px;
    }
    
    .message img {
      height: 32px;
      width: 32px;
      margin-right: 8px;
    }
    
    .message_content {
      display: flex;
      flex-direction: column;
      justify-content: center;
      background-color: #40444b;
      padding: 8px;
      border-radius: 8px;
    }
    
    .message_content h3 {
      margin: 0;
      color: #fff;
      font-weight: 500;
      font-size: 16px;
    }
    
    .message_content p {
      margin: 4px 0 0 0;
      color: #b9bbbe;
      font-weight: 400;
    }
    </style>
  