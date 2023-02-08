<script>
    // core components
    import { link , navigate} from "svelte-routing";
  import { ethers } from "../../../node_modules/ethers";
  import SaiToken from "../../../../build/contracts/SaiCreditToken.json";
  import SaiCreditTokenAddress from "../../../contractsData/SaiCreditToken-address.json";
  import StudentAddress from "../../../contractsData/Student-address.json";
  let connectedAccount = "";
  let balance = 0;
  let pub_key = "";
  let num_tokens = 0;
  let tot_tokens_trans = 0;
  const team2 = "/assets/img/student.jpg";

  const SAICREDIT_ADDRESS = SaiCreditTokenAddress.address;
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
   
   
   
    const SaiCreditContract = new ethers.Contract(
      SAICREDIT_ADDRESS,
      SaiToken.abi,
      signer
    );


  async function connectWallet() {
    	if (window.ethereum) {
     	 await window.ethereum.request({ method: 'eth_requestAccounts' })
     	 connectedAccount = await signer.getAddress();
       balance = await SaiCreditContract.balanceOf(connectedAccount);
  		} else {
        alert('You need to install metamask');
        }
  }

  async function transferTokens() {
    await SaiCreditContract.transfer(pub_key, num_tokens, {from: connectedAccount});
    tot_tokens_trans += num_tokens;
  }
  export let location;
  </script>
  
  <div
    class="relative flex flex-col min-w-0 break-words bg-white w-full mb-6 shadow-xl rounded-lg mt-16"
  >
    <div class="px-6">
      <div class="flex flex-wrap justify-center">
        <div class="w-full px-4 flex justify-center">
          <div class="relative">
            <img
              alt="..."
              src="{team2}"
              class="shadow-xl rounded-full h-auto align-middle border-none absolute -m-16 -ml-20 lg:-ml-16 max-w-150-px"
            />
          </div>
        </div>
        <div
        class="w-full lg:w-4/12 px-4 lg:order-3 lg:text-right lg:self-center"
      >
        <div class="py-6 px-3 mt-32 sm:mt-0">
          <button
            class="bg-red-400 active:bg-red-500 uppercase text-white font-bold hover:shadow-md shadow text-xs px-4 py-2 rounded outline-none focus:outline-none sm:mr-2 mb-1 ease-linear transition-all duration-150"
            type="button"
            on:click={connectWallet}
          >
            Connect
          </button>
        </div>
      </div>
        <div class="w-full px-4 text-center mt-20">
          <div class="flex justify-center py-4 lg:pt-4 pt-8">
            <div class="mr-4 p-3 text-center">
              <span
                class="text-xl font-bold block uppercase tracking-wide text-blueGray-600"
              >
              {balance} SaiEth
              </span>
              <span class="text-sm text-blueGray-400">Token Balance</span>
            </div>
          </div>
        </div>
      </div>
      <div class="text-center mt-12">
        <h3 class="text-xl font-semibold leading-normal mb-2 text-blueGray-700 mb-2">
          Nithin
        </h3>
        <div
          class="text-sm leading-normal mt-0 mb-2 text-blueGray-400 font-bold uppercase"
        >
          <i class="fas fa-map-marker-alt mr-2 text-lg text-blueGray-400"></i>
          Thiruvananthapuram, Kerala
        </div>
        <div class="mb-2 text-blueGray-600 mt-10">
          <i class="fas fa-briefcase mr-2 text-lg text-blueGray-400"></i>
          II MTech-ComputerScience
        </div>
        <div class="mb-2 text-blueGray-600">
          <i class="fas fa-university mr-2 text-lg text-blueGray-400"></i>
          Sri Sathya Sai Institute of Higher Learning
        </div>
      </div>
      <div class="mt-10 py-10 border-t border-blueGray-200 text-center">
        <div class="flex flex-wrap justify-center">
          <div class="w-full lg:w-9/12 px-4">
            <p class="mb-4 text-lg leading-relaxed text-blueGray-700">
              A student of SSSIHL.
            </p>
            <a href="#pablo" on:click={(e) => e.preventDefault()} class="font-normal text-red-500">
              Show more
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>