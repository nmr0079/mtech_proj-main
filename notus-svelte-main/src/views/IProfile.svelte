<script>
    // core components
  import AuthNavbar from "components/Navbars/AuthNavbar.svelte";
  import Footer from "components/Footers/Footer.svelte";
  import { link , navigate} from "svelte-routing";
  import { ethers } from "../../node_modules/ethers";
  import AccessControl from "../../../build/contracts/AccessControl.json";
  import SaiToken from "../../../build/contracts/SaiCreditToken.json";
  import Instructor from "../../../build/contracts/Instructor.json";
  import MarketplaceAddress from "../../contractsData/Marketplace-address.json";
  import NFTAddress from "../../contractsData/NFT-address.json";
  import SaiCreditTokenAddress from "../../contractsData/SaiCreditToken-address.json";
  import InstructorAddress from "../../contractsData/Instructor-address.json";
  import AccessControlADDRESS from "../../contractsData/AccessControl-address.json";
  //const { ethers } = require("ethers");

  const API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDdDMTIwZDE0QWJGMzFCNzU5NzJDODkwNTYzRDc1QmRlNTQ2RWYzZUEiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2NjMxMzUyMTY5OTgsIm5hbWUiOiJFSFJ0b2tlbiJ9.qf_TPOWIqbXJVSsOhv0oywTJCYNsuJ3VVYOX-qA0H6g"
  const API = "https://api.web3.storage"

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
    const Instructor_ADDRESS = InstructorAddress.address;
     const InstructorContract = new ethers.Contract(
      Instructor_ADDRESS,
      Instructor.abi,
      signer
    );

   let connectedAccount = "";
  let balance = 0;
  let pub_key = "";
  let num_tokens = 0;
  let tot_supply = 0;
  let tot_tokens_trans = 0;
  let username = '';
  let firstname = '';
  let lastname = '';
  let emailaddress = '';
  let city = '';
  let state = '';
  let country = '';
  let poscode;
  let about = '';
  let img_cid;
  let img;
  let course = '';
  let subject = '';
  let institution = '';
  let studata;

  let data_cid;
  const team2 = "/assets/img/student.jpg";
  const Saitokenpic = "/assets/img/SaiToken.gif";
  async function connectWallet() {
    	if (window.ethereum) {
     	 await window.ethereum.request({ method: 'eth_requestAccounts' })
     	 connectedAccount = await signer.getAddress();
       
       //success = await RoleContract.check_admin(connectedAccount);
        //console.log(success);
       balance = await SaiCreditContract.balanceOf(connectedAccount);
       // console.log(tot_supply.toNumber());
      //  if(success == true){
        await push('/auth/register');
        //}
  		} else {
        alert('You need to install metamask');
        }
  }
  async function getDetails(){
    connectedAccount = await signer.getAddress();
    data_cid = await InstructorContract.getaboutHash({from: connectedAccount})
    const uri = `https://${data_cid}.ipfs.w3s.link/`;
            //console.log(uri)
            // use uri to fetch the nft metadata stored on ipfs 
    const response = await fetch(uri)
    const metadata = await response.json()
    username = metadata.username;
    firstname = metadata.firstname;
    lastname = metadata.lastname;
    emailaddress = metadata.emailaddress;
    city = metadata.city;
    state = metadata.state;
    country = metadata.country;
    poscode = metadata.poscode;
    about = metadata.about;
    img = metadata.img;
    course = metadata.course;
    subject = metadata.subject;
    institution = metadata.institution;

  }

  getDetails();
//style="background-image: url(https://images.unsplash.com/photo-1499336315816-097655dcfbda?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2710&q=80);"
  export let location;
</script>

<div>
  <AuthNavbar />
  <main class="profile-page">
    <section class="relative block h-500-px">
      <div
        class="absolute top-0 w-full h-full bg-center bg-cover"
        style="background-image: url(https://images.unsplash.com/photo-1499336315816-097655dcfbda?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2710&q=80);"
      >
        <span
          id="blackOverlay"
          class="w-full h-full absolute opacity-50 bg-orange-500"
        ></span>
      </div>
      <div
        class="top-auto bottom-0 left-0 right-0 w-full absolute pointer-events-none overflow-hidden h-70-px"
        style="transform: translateZ(0);"
      >
        <svg
          class="absolute bottom-0 overflow-hidden"
          xmlns="http://www.w3.org/2000/svg"
          preserveAspectRatio="none"
          version="1.1"
          viewBox="0 0 2560 100"
          x="0"
          y="0"
        >
          <polygon
            class="text-blueGray-200 fill-current"
            points="2560 0 2560 100 0 100"
          ></polygon>
        </svg>
      </div>
    </section>
    <section class="relative py-16 bg-blueGray-200">
      <div class="container mx-auto px-4">
        <div
          class="relative flex flex-col min-w-0 break-words bg-white w-full mb-6 shadow-xl rounded-lg -mt-64"
        >
          <div class="px-6">
            <div class="flex flex-wrap justify-center">
              <div class="w-full lg:w-3/12 px-4 lg:order-2 flex justify-center">
                <div class="relative">
                  <img
                    alt="..."
                    src="{img}"
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
              <div class="w-full lg:w-4/12 px-4 lg:order-1">
                <div class="flex justify-center py-4 lg:pt-4 pt-8">
                  <div class="mr-4 p-3 text-center">
                    <span
                      class="text-xl font-bold block uppercase tracking-wide text-blueGray-600"
                    >
                      22
                    </span>
                    <span class="text-sm text-blueGray-400">Friends</span>
                  </div>
                  <div class="mr-4 p-3 text-center">
                    <span
                      class="text-xl font-bold block uppercase tracking-wide text-blueGray-600"
                    >
                      10
                    </span>
                    <span class="text-sm text-blueGray-400">Courses completed</span>
                  </div>
                  <div class="lg:mr-4 p-3 text-center">
                    <span
                      class="text-xl font-bold block uppercase tracking-wide text-blueGray-600"
                    >
                      4
                    </span>
                    <span class="text-sm text-blueGray-400">Ongoing courses</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="text-center mt-12">
              <h3
                class="text-4xl font-semibold leading-normal mb-2 text-blueGray-700 mb-2"
              >
                {firstname} {lastname}
              </h3>
              <div class="mb-2 text-blueGray-600 mt-10">
                Username : {username}
              </div>
              <div class="mb-2 text-blueGray-600 mt-10">
                Email ID: {emailaddress}
              </div>
              <div
                class="text-sm leading-normal mt-0 mb-2 text-blueGray-400 font-bold uppercase"
              >
                <i class="fas fa-map-marker-alt mr-2 text-lg text-blueGray-400"></i>
                {city}, {state}, {country}
                   PINCODE : {poscode}
              </div>
              <div class="mb-2 text-blueGray-600 mt-10">
                <i class="fas fa-briefcase mr-2 text-lg text-blueGray-400"></i>
                {course} - {subject} 
              </div>
              <div class="mb-2 text-blueGray-600 mt-10">
                Metamask public key: {connectedAccount}
              </div>
              <div class="mb-2 text-blueGray-600 mt-10">
                Current SaiETH Token balance: {balance}
              </div>
              <div class="mb-2 text-blueGray-600">
                <i class="fas fa-university mr-2 text-lg text-blueGray-400"></i>
                {institution}
              </div>
            </div>
            <div class="mt-10 py-10 border-t border-blueGray-200 text-center">
              <div class="flex flex-wrap justify-center">
                <div class="w-full lg:w-9/12 px-4">
                  <p class="mb-4 text-lg leading-relaxed text-blueGray-700">
                   {about}
                  </p>
                  <a
                    href="#pablo"
                    on:click={(e) => e.preventDefault()}
                    class="font-normal text-red-500"
                  >
                    Show more
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
  <Footer />
</div>
