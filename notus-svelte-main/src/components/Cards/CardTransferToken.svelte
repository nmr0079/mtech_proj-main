<script>
    import { ethers } from 'ethers';
    import SaiToken from "../../../../build/contracts/SaiCreditToken.json";
    import Student from "../../../../build/contracts/Student.json";
    import SaiCreditTokenAddress from "../../../contractsData/SaiCreditToken-address.json";
  import StudentAddress from "../../../contractsData/Student-address.json";
  
    let connectedAccount = "";
    let pub_key = "";
    let num_tokens = 0;
    let tot_tokens_trans = 0;
    const team2 = "/assets/img/transfer_tokens.png";
   
   const STUDENT_ADDRESS = StudentAddress.address;
   const SAICREDIT_ADDRESS = SaiCreditTokenAddress.address;
  

   const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
   
   /*const RBAC_Contract = new ethers.Contract(
      RBAC_ADDRESS,
      RBAC.abi,
      signer
    );*/
    const StudentContract = new ethers.Contract(
      STUDENT_ADDRESS,
      Student.abi,
      signer
    );
    const SaiCreditContract = new ethers.Contract(
      SAICREDIT_ADDRESS,
      SaiToken.abi,
      signer
    );


 
  async function transferTokens() {
    await SaiCreditContract.transfer(pub_key, num_tokens, {from: connectedAccount});
    tot_tokens_trans += num_tokens;
  }
</script>


<div
  class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
  <div class="rounded-t bg-white mb-0 px-6 py-6">
    <div class="text-center flex justify-between">
      <h6 class="text-blueGray-700 text-xl font-bold">Token Transfer Section</h6>
      <button
        class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
        type="button"
        on:click={transferTokens}
      >
        Transfer
      </button>
    </div>
  </div>
  <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
    <br/>
    <br/>
    <div class="w-full px-4 flex justify-center">
        <div class="relative">
          <img
            alt="..."
            src="{team2}"
            class="shadow-xl rounded-full h-auto align-middle border-none absolute -m-16 -ml-20 lg:-ml-16 max-w-150-px"
          />
        </div>
      </div>
      <br/>
      <br/>
    <form>
      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Token Transfer Details
      </h6>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-username"
            >
              Username
            </label>
            <input
              id="grid-username"
              type="text"
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              value="nmr007"
            />
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-email"
            >
             Receiver Public_Key
            </label>
            <input
              id="grid-email"
              type="text"
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              input bind:value={pub_key}
              placeholder="Enter Public key"
            />
        </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
            <div class="relative w-full mb-3">
              <label
                class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                for="grid-email"
              >
               Number of Tokens
              </label>
              <input
                id="grid-email"
                class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                input bind:value={num_tokens}
                placeholder="Enter the token amount to send"
              />
          </div>
          </div>
          <div class="lg:mr-4 p-3 text-center">
            <span
              class="text-xl font-bold block uppercase tracking-wide text-blueGray-600"
            >
            {tot_tokens_trans} SaiEth
            </span>
            <span class="text-sm text-blueGray-400">Total Transfered amount</span>
          </div>
      </div>
     <!-- <hr class="mt-6 border-b-1 border-blueGray-300" />

      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Contact Information
      </h6>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-12/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-address"
            >
              Address
            </label>
            <input
              id="grid-address"
              type="text"
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              value="Bld Mihail Kogalniceanu, nr. 8 Bl 1, Sc 1, Ap 09"
            />
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-city"
            >
              City
            </label>
            <input
              id="grid-city"
              type="email"
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              value="New York"
            />
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-country"
            >
              Country
            </label>
            <input
              id="grid-country"
              type="text"
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              value="United States"
            />
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-postal-code"
            >
              Postal Code
            </label>
            <input
              id="grid-postal-code"
              type="text"
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              value="Postal Code"
            />
          </div>
        </div>
      </div>

      <hr class="mt-6 border-b-1 border-blueGray-300" />

      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        About Me
      </h6>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-12/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-about-me"
            >
              About me
            </label>
            <textarea
              id="grid-about-me"
              type="text"
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              rows="4"
              value="A beautiful UI Kit and Admin for Svelte & Tailwind CSS. It is Free
                and Open Source."
            />
          </div>
        </div>
      </div>-->
    </form>
  </div>
</div>
