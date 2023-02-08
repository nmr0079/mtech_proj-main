<script>
   import { link , navigate} from "svelte-routing";
   import { ethers } from "../../../node_modules/ethers";
   import AccessControl from "../../../../build/contracts/AccessControl.json";
   import SaiToken from "../../../../build/contracts/SaiCreditToken.json";
   import UploadCSV from 'upload-csv-svelte';
   import MarketplaceAddress from "../../../contractsData/Marketplace-address.json";
   import NFTAddress from "../../../contractsData/NFT-address.json";
   import SaiCreditTokenAddress from "../../../contractsData/SaiCreditToken-address.json";
   import StudentAddress from "../../../contractsData/Student-address.json";
   import AccessControlADDRESS from "../../../contractsData/AccessControl-address.json";
  //murmurhash = require('murmurhash');

  let roles = [
		 `Admin` ,
		 `Student`,
		`Instructor`,
    `Group Registration`
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


  // core components
  const github = "../assets/img/github.svg";
  const google = "../assets/img/google.svg";
  const metamask = "../assets/img/metamask.png";
  let pub_key = "";
  let role = "";
  let stud_addresses = [];
  let filedata;
  let selected;
  export let location;

  async function submitAdmin() {
        const connectedAccount = await signer.getAddress();
        console.log(connectedAccount);
        await AccessControlContract.grantAdminRole({from: connectedAccount});
        navigate("/auth/login", { replace: true });
        
    }

    $: submitStudent = async () => {
        
      if (window.ethereum) {
     	 await window.ethereum.request({ method: 'eth_requestAccounts' })
        const connectedAccount = await signer.getAddress();
        console.log(pub_key);
        await AccessControlContract.grantStudRole(pub_key, {from: connectedAccount});
        //await RBAC_Contract.assignStudentRole(stud_address, stud_ID, {from: connectedAccount});
        //await push('/login');
        navigate("/auth/login", { replace: true });
      }
      else {
        alert('You need to install metamask');
        }
        
    }

    $: submitGroupStudent = async () => {
        
        
          const connectedAccount = await signer.getAddress();
          stud_addresses.shift();
          stud_addresses.pop();
          console.log(stud_addresses)
          //var filedata1 = JSON.stringify(filedata);
          console.log(filedata)
          //studArray.update((currentData) => {
            // return [filedata,...currentData];
          //});
          
          await AccessControlContract._grantStuRoleArr(stud_addresses, {from: connectedAccount});
          //await RBAC_Contract.assignStudentRole(stud_address, stud_ID, {from: connectedAccount});
          await push('/login');
      }

    $: submitInstructor = async () => {
      if (window.ethereum) {
     	 await window.ethereum.request({ method: 'eth_requestAccounts' })
        const connectedAccount = await signer.getAddress();
        await AccessControlContract.grantInstrRole(pub_key, {from: connectedAccount});
       // await RBAC_Contract.assignInstructorRole(instr_address, instr_ID, {from: connectedAccount});
       navigate("/auth/login", { replace: true });
      }
      else {
        alert('You need to install metamask');
        }
        
    }
</script>

<div class="container mx-auto px-4 h-full">
  <div class="flex content-center items-center justify-center h-full">
    <div class="w-full lg:w-6/12 px-4">
      <div
        class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-200 border-0"
      >
        <div class="rounded-t mb-0 px-6 py-6">
          <div class="text-center mb-3">
            <h6 class="text-blueGray-500 text-sm font-bold">
              Sign up with
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
            <small>Enter your metamask account address and role</small>
          </div>
          <form>
            <div class="relative w-full mb-3">
              <label
                class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                for="grid-name"
              >
                Name
              </label>
              <input
                id="grid-name"
                type="email"
                class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                placeholder="Name"
              />
            </div>

            <div class="relative w-full mb-3">
              <label
                class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                for="grid-password"
              >
                Public_Key
              </label>
              <input
                id="grid-password"
                bind:value={pub_key} 
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
             <!-- <select bind:value={role} >
                {#each roles as rolesel}
                  <option value={rolesel}>
                    {rolesel}
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
                  I agree with the
                  <a href="#pablo" on:click={(e) => e.preventDefault()} class="text-red-500">
                    Privacy Policy
                  </a>
                </span>
              </label>
            </div>
            {#if role == "Student"}
            <div class="text-center mt-6">
              <button
                class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
                type="button"
                on:click={submitStudent}
              >
                Create Account
              </button>
            </div>
          {:else if role == "Instructor"}
          <div class="text-center mt-6">
            <button
              class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
              type="button"
              on:click={submitInstructor}
            >
              Create Account
            </button>
          </div>
     {:else if role == "Admin"}
     <div class="text-center mt-6">
      <button
        class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
        type="button"
        on:click={submitAdmin}
      >
        Create Account
      </button>
    </div>
    {:else if role == "Group Registration"}
    <h3>Upload .csv file containing new entrant details</h3>
    <UploadCSV onUpload={(file) => {stud_addresses=file.map(function(value,index) { return value[2]; });filedata = file}} />
     <div class="text-center mt-6">
      <button
        class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
        type="button"
        on:click={submitGroupStudent}
      >
        Create Account
      </button>
    </div>
    {:else}
      <div class="text-center mt-6">
        <button
          class="bg-blueGray-800 text-white active:bg-blueGray-600 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full ease-linear transition-all duration-150"
          type="button"
        >
          Create Account
        </button>
      </div>
    {/if}
        
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
