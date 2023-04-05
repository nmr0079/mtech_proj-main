<script>
    import { onMount, onDestroy, setContext } from "svelte";
    import { ethers } from "ethers";
    import { io } from "socket.io-client";
    // import Student from "../../../../build/contracts/Student.json";
    // import Instructor from "../../../../build/contracts/Instructor.json";
    // import Courseblocks from "../../../../build/contracts/Courseblocks.json";
    // import StudentAddress from "../../../contractsData/Student-address.json";
    // import InstructorAddress from "../../../contractsData/Instructor-address.json";
    // import CourseblocksAddress from "../../../contractsData/Courseblocks-address.json";
    // import SaiCreditToken from "../../../../build/contracts/SaiCreditToken.json";
    // import SaiCredit_Address from "../../../contractsData/SaiCreditToken-address.json";
    import Dappcord from "../../../build/contracts/Dappcord.json";
    import DappcordAddress from "../../contractsData/Dappcord-address.json";
  
    // Components
    import Navigation from "../views/Discord/Navigation.svelte";
    import Servers from "../views/Discord/Servers.svelte";
    import Channels from "../views/Discord/Channels.svelte";
    import Messages from "../views/Discord/Messages.svelte";
  
  
    // Config
    // import config from "./config.json";
  
    // Socket
    const socket = io("ws://localhost:3030");
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
  
    let account, dappcord, channels, currentChannel, messages;
  
    const loadBlockchainData = async () => {
      connectedAccount = await signer.getAddress();
      const totalChannels = await DappcordContract.totalChannels();
      channels = [];
  
      for (let i = 1; i <= totalChannels; i++) {
        const channel = await DappcordContract.getChannel(i);
        channels.push(channel);
      }
  
    //   window.ethereum.on("accountsChanged", async () => {
    //     window.location.reload();
    //   });
    };
  
    onMount(() => {
      loadBlockchainData();
  
    //   socket.on("connect", () => {
    //     socket.emit("get messages");
    //   });
  
    //   socket.on("new message", (messages) => {
    //     setContext("messages", messages);
    //   });
  
    //   socket.on("get messages", (messages) => {
    //     setContext("messages", messages);
    //   });
    });
  
    onDestroy(() => {
      socket.off("connect");
      socket.off("new message");
      socket.off("get messages");
    });
  </script>
  
  <Navigation account={account} setAccount={connectedAccount} />
  
  <main>
    <!-- <Servers /> -->
  
    <Channels channels={channels}/>
  
    <Messages
      messages={$messages}
      currentChannel={currentChannel}
    />
  </main>
  