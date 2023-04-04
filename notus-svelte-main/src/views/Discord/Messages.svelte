<!-- Messages.svelte -->
<script>
    import { onMount, onCleanup } from "svelte";
    import { io } from "socket.io-client";
    
    // Assets
    import person from "../assets/person.svg";
    import send from "../assets/send.svg";
  
    // Socket
    const socket = io("ws://localhost:3030");
    
    export let account;
    export let messages;
    export let currentChannel;
    
    let message = "";
  
    let messageEndRef;
  
    const sendMessage = async (e) => {
      e.preventDefault();
  
      const messageObj = {
        channel: currentChannel.id.toString(),
        account: account,
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
    
    onCleanup(() => {
      socket.disconnect();
    });
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
        <img src={send} alt="Send Message" />
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
  