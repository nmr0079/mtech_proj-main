<script>
   import Instructor from "../../../../../build/contracts/Instructor.json";
  import InstructorAddress from "../../../../contractsData/Instructor-address.json";
  import { ethers } from 'ethers';
  const API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDdDMTIwZDE0QWJGMzFCNzU5NzJDODkwNTYzRDc1QmRlNTQ2RWYzZUEiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2NjMxMzUyMTY5OTgsIm5hbWUiOiJFSFJ0b2tlbiJ9.qf_TPOWIqbXJVSsOhv0oywTJCYNsuJ3VVYOX-qA0H6g"
  const API = "https://api.web3.storage"

  const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();

  let connectedAccount = "";
  let files;
  let username = '';
  let firstname = '';
  let lastname = '';
  let emailaddress = '';
  let city = '';
  let state = '';
  let country = '';
  let poscode;
  let about = '';
  let course = '';
  let subject = '';
  let institution = '';
  let img_cid;
  let img;
  let studata;

  let data_cid;

     
     const InstructorContract = new ethers.Contract(
      InstructorAddress.address,
      Instructor.abi,
      signer
    );

  async function uploadprofilepic() {
    await window.ethereum.request({ method: 'eth_requestAccounts' })
    connectedAccount = await signer.getAddress();
  const response = await fetch(API+'/upload', {
      method: 'POST', // *GET, POST, PUT, DELETE, etc.
      headers: {
        'Content-Type': 'blob/file' ,
        "Authorization" : "Bearer "+API_KEY
      },
      referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
      body: files[0]
      //body: App.encrypt(fileInput.value) // body data type must match "Content-Type" header
    }).then((response) => response.json())
    .then((data) => {
        img_cid = data.cid;
        return InstructorContract.setprofpichash(data.cid,{from: connectedAccount});
    
    })
   // console.log(response.json()) // parses JSON response into native JavaScript objects  
}
  const datasubmission = async () => {
  img = `https://${img_cid}.ipfs.w3s.link/`;
  studata = JSON.stringify({username,firstname,lastname,emailaddress,city,state,country,poscode,about,img, course,subject,institution});
  await window.ethereum.request({ method: 'eth_requestAccounts' })
  connectedAccount = await signer.getAddress();
  const response = await fetch(API+'/upload', {
      method: 'POST', // *GET, POST, PUT, DELETE, etc.
      headers: {
        'Content-Type': 'blob/file' ,
        "Authorization" : "Bearer "+API_KEY
      },
      referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
      body: studata
      //body: App.encrypt(fileInput.value) // body data type must match "Content-Type" header
    }).then((response) => response.json())
    .then((data) => {
        data_cid = data.cid;
        return InstructorContract.setabouthash(data.cid,{from: connectedAccount});
    
    })
}
</script>

<div
  class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
  <div class="rounded-t bg-white mb-0 px-6 py-6">
    <div class="text-center flex justify-between">
      <h6 class="text-blueGray-700 text-xl font-bold">My account</h6>
      <button
        class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
        type="button"
        on:click={datasubmission}
      >
        Upload your details
      </button>
    </div>
  </div>
  <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
    <form>
      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Upload your profile pic
      </h6>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-6/12 px-4">
            <div class="relative w-full mb-3">
                <label for="myfile">Select a file:</label>
                <input bind:files type="file" id="myfile" name="myfile"> 

          </div>
          </div>
      </div>
      <button
          class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
          type="button"
          on:click={uploadprofilepic}
        >
          Upload your pic
        </button>
      </form>
    <form>
      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Instructor Information
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
              bind:value={username}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
            />
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-first-name"
            >
              First Name
            </label>
            <input
              id="grid-first-name"
              type="text"
              bind:value={firstname}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              
            />
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-last-name"
            >
              Last Name
            </label>
            <input
              id="grid-last-name"
              type="text"
              bind:value={lastname}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              
            />
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-email"
            >
              Email address
            </label>
            <input
              id="grid-email"
              type="email"
              bind:value={emailaddress}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
            />
          </div>
        </div>
      </div>
      <hr class="mt-6 border-b-1 border-blueGray-300" />

      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Job Details
      </h6>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-city"
            >
              Designation
            </label>
            <input
              id="grid-city"
              type="text"
              bind:value={course}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              
            />
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-city"
            >
              Subject
            </label>
            <input
              id="grid-city"
              type="text"
              bind:value={subject}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              
            />
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-city"
            >
            Institute
            </label>
            <input
              id="grid-city"
              type="text"
              bind:value={institution}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              
            />
          </div>
        </div>
        </div>
      <hr class="mt-6 border-b-1 border-blueGray-300" />

      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Address Information
      </h6>
      <div class="flex flex-wrap">
       <!-- <div class="w-full lg:w-12/12 px-4">
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
        </div>-->
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
              type="text"
              bind:value={city}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              
            />
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label
              class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
              for="grid-state"
            >
              State
            </label>
            <input
              id="grid-state"
              type="text"
              bind:value={state}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
          
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
              bind:value={country}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              
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
              bind:value={poscode}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              
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
              bind:value={about}
              class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
              rows="4"
            />
          </div>
        </div>
      </div>
    </form>
  </div>
</div>


