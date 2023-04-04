<script>
  // core components
  import { ethers } from "../../../../node_modules/ethers";
  import SaiToken from "../../../../../build/contracts/SaiCreditToken.json";
  import Instructor from "../../../../../build/contracts/Instructor.json";
  import InstructorAddress from "../../../../contractsData/Instructor-address.json";
  import SaiCreditTokenAddress from "../../../../contractsData/SaiCreditToken-address.json";
  let connectedAccount = "";
  let balance = 0;
  
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

  const SAICREDIT_ADDRESS = SaiCreditTokenAddress.address;
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
   

  const SaiCreditContract = new ethers.Contract(
      SAICREDIT_ADDRESS,
      SaiToken.abi,
      signer
    );

     
    const InstructorContract = new ethers.Contract(
      InstructorAddress.address,
      Instructor.abi,
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

  async function getDetails(){
    connectedAccount = await signer.getAddress();
    data_cid = await InstructorContract.getaboutHash({from: connectedAccount})
    console.log(data_cid)
    const uri = `https://${data_cid}.ipfs.w3s.link/`;
            //console.log(uri)
            // use uri to fetch the nft metadata stored on ipfs
    console.log(uri) 
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
  const team2 = "../assets/img/student.jpg";
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
            src="{img}"
            class="shadow-xl rounded-full h-auto align-middle border-none absolute -m-16 -ml-20 lg:-ml-16 max-w-150-px"
          />
        </div>
      </div>
      <div class="w-full px-4 text-center mt-20">
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
            <span class="text-sm text-blueGray-400">Courses Completed</span>
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
      <h3 class="text-xl font-semibold leading-normal mb-2 text-blueGray-700 mb-2">
        {firstname}
      </h3>
      <div
        class="text-sm leading-normal mt-0 mb-2 text-blueGray-400 font-bold uppercase"
      >
        <i class="fas fa-map-marker-alt mr-2 text-lg text-blueGray-400"></i>
        {city}, {state}, {country}
      </div>
      <div class="mb-2 text-blueGray-600 mt-10">
        <i class="fas fa-briefcase mr-2 text-lg text-blueGray-400"></i>
        {course}-{subject}
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
          <a href="#pablo" on:click={(e) => e.preventDefault()} class="font-normal text-red-500">
            Show more
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
