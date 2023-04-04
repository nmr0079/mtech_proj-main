<script>
  import { link , navigate} from "svelte-routing";
  import { ethers } from "../../../node_modules/ethers";
  import AccessControl from "../../../../build/contracts/AccessControl.json";
  import SaiToken from "../../../../build/contracts/SaiCreditToken.json";
  import MarketplaceAddress from "../../../contractsData/Marketplace-address.json";
  import NFTAddress from "../../../contractsData/NFT-address.json";
  import SaiCreditTokenAddress from "../../../contractsData/SaiCreditToken-address.json";
  import StudentAddress from "../../../contractsData/Student-address.json";
  import AccessControlADDRESS from "../../../contractsData/AccessControl-address.json";
  //const { ethers } = require("ethers");
  
  let roles = [
		 `Admin` ,
		 `Student`,
		`Instructor`
	];

  const SAICREDIT_ADDRESS = SaiCreditTokenAddress.address;
   const AccessControl_ADDRESS = AccessControlADDRESS.address;

   // A Web3Provider wraps a standard Web3 provider, which is
// what MetaMask injects as window.ethereum into each page
const provider = new ethers.providers.Web3Provider(window.ethereum)
const signer = provider.getSigner();

 const SaiCreditContract = new ethers.Contract(
      SAICREDIT_ADDRESS,
      SaiToken.abi,
      signer
    );
    const AccessControlContract = new ethers.Contract(
      AccessControl_ADDRESS,
      AccessControl.abi,
      signer
    );


   let connectedAccount = "";
   let sage = 0;
   let scity = "";
   let email = "";
   let password = "";
   let errors = {};
   var studentDetails = "";
   let success = true;
   let tot_supply = 0;
   let balance = 0;
   let stud_pub_key = "";
   const img1 = "../assets/img/admin.png";
   const img2 = "../assets/img/student_login2.png";
   const img3 = "../assets/img/instructor.png";
   let role = "";


  	async function connectAdminWallet() {
    	if (window.ethereum) {
     	 //await window.ethereum.request({ method: 'eth_requestAccounts' })
        await provider.send("eth_requestAccounts", []);
     	 connectedAccount = await signer.getAddress();
       
       //success = await RoleContract.check_admin(connectedAccount);
        //console.log(success);
       tot_supply = await SaiCreditContract.totalSupply();
       // console.log(tot_supply.toNumber());
      //  if(success == true){
        navigate("/admin/dashboard", { replace: true });
        //}
  		} else {
        alert('You need to install metamask');
        }
  }

  async function connectStudentWallet() {
    if (window.ethereum) {
    // MetaMask requires requesting permission to connect users accounts
await provider.send("eth_requestAccounts", []);

// The MetaMask plugin also allows signing transactions to
// send ether and pay to change state within the blockchain.
// For this, you need the account signer...

     	 connectedAccount = await signer.getAddress();
        //const roleassign = new ethers.Contract(address, abi, signer);
       // await RoleContract.check_student(stud_pub_key);
        await AccessControlContract.hasStudRole({from: connectedAccount});
        navigate("/admin/dashboard", { replace: true });
      } else {
        alert('You need to install metamask');
        }
     
  }

  async function connectInstrWallet() {
    	if (window.ethereum) {
     	 //await window.ethereum.request({ method: 'eth_requestAccounts' })
     	 //const signer = provider.getSigner();
        await provider.send("eth_requestAccounts", []);
     	 connectedAccount = await signer.getAddress();
        tot_supply = await SaiCreditContract.totalSupply();
        await AccessControlContract.hasInstrRole({from: connectedAccount});
        navigate("/instructor/idashboard", { replace: true });
  		} else {
        alert('You need to install metamask');
        }
  }
  // core components
  const github = "../assets/img/github.svg";
  const google = "../assets/img/google.svg";
  const metamask = "../assets/img/metamask.png";
  export let location;
</script>

<div class="container mx-auto px-4 h-full">
  <div class="flex content-center items-center justify-center h-full">
    <div class="w-full lg:w-4/12 px-4">
      <div
        class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-200 border-0"
      >
        <div class="rounded-t mb-0 px-6 py-6">
          <div class="text-center mb-3">
            <h6 class="text-blueGray-500 text-sm font-bold">
              Sign in with
            </h6>
          </div>
          <div class="btn-wrapper text-center">
            <button
              class="bg-white active:bg-blueGray-50 text-blueGray-700 font-normal px-4 py-2 rounded outline-none focus:outline-none mr-2 mb-1 uppercase shadow hover:shadow-md inline-flex items-center font-bold text-xs ease-linear transition-all duration-150"
              type="button"
            >
              <img alt="..." class="w-5 mr-1" src="{metamask}" />
              Metamask
            </button>
            <button
              class="bg-white active:bg-blueGray-50 text-blueGray-700 font-normal px-4 py-2 rounded outline-none focus:outline-none mr-1 mb-1 uppercase shadow hover:shadow-md inline-flex items-center font-bold text-xs ease-linear transition-all duration-150"
              type="button"
            >
              <img alt="..." class="w-5 mr-1" src="{google}" />
              Google
            </button>
          </div>
          <hr class="mt-6 border-b-1 border-blueGray-300" />
        </div>
        <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
          <div class="text-blueGray-400 text-center mb-3 font-bold">
            <small>Enter your metamask account address</small>
          </div>
          <form>
            <div class="relative w-full mb-3">
              <label
                class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                for="grid-password"
              >
                Public_Key
              </label>
              <input
                id="grid-password"
                bind:value={stud_pub_key} 
                type= "text"
                class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                placeholder="Enter your metamask account address"
              />
            </div>
            <div class="relative w-full mb-3">
              <label
                class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                for="grid-password"
              >
                Select your role
              </label>
              {#each roles as rolesel}
	            <label>
		            <input type=checkbox bind:group={role} name="flavours" value={rolesel}>
		            {rolesel}
	            </label>
             {/each}
              <!--<select bind:value={role} >
                {#each roles as rolesel}
                  <option value={rolesel}>
                    {rolesel.text}
                  </option>
                {/each}
              </select>-->
              <!--<label
                class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                for="grid-password"
              >
                Role
              </label>
              <input
                id="grid-password"
                bind:value={role} 
                type= "text"
                class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                placeholder="Enter your metamask account address"
              />-->
            </div>
            <div>
              <label class="inline-flex items-center cursor-pointer">
                <input
                  id="customCheckLogin"
                  type="checkbox"
                  class="form-checkbox border-0 rounded text-blueGray-700 ml-1 w-5 h-5 ease-linear transition-all duration-150"
                />
                <span class="ml-2 text-sm font-semibold text-blueGray-600">
                  Remember me
                </span>
              </label>
            </div>
            {#if role == "Student"}
                 <div class="text-center mt-6">
                    <button
                     class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
                     type="button"
                      on:click={connectStudentWallet}

                   >
                      Sign In
                  </button>
                </div>
          {:else if role == "Instructor"}
                <div class="text-center mt-6">
                   <button
                       class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
                       type="button"
                       on:click={connectInstrWallet}

                   >
                Sign In
                </button>
              </div>
          {:else if role == "Admin"}
                <div class="text-center mt-6">
                   <button
                       class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
                       type="button"
                       on:click={connectAdminWallet}

                   >
                Sign In
                </button>
              </div>
         {:else}
         <div class="text-center mt-6">
          <button
              class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
              type="button"
          >
          Sign In
       </button>
       </div>
    {/if}
            
          </form>
        </div>
      </div>
      <div class="flex flex-wrap mt-6 relative">
        <div class="w-1/2">
          <a href="#pablo" on:click={(e) => e.preventDefault()} class="text-blueGray-200">
            <small>Forgot password?</small>
          </a>
        </div>
        <div class="w-1/2 text-right">
          <a use:link href="/auth/register" class="text-blueGray-200">
            <small>Create new account</small>
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
