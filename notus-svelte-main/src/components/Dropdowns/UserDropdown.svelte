<script>
  // library for creating dropdown menu appear on click
  import { createPopper } from "@popperjs/core";
  import { ethers } from "../../../node_modules/ethers";
  import Student from "../../../../build/contracts/Student.json";
  import StudentAddress from "../../../contractsData/Student-address.json";
  let connectedAccount = "";
  // let username = '';
  // let firstname = '';
  // let lastname = '';
  // let emailaddress = '';
  // let city = '';
  // let state = '';
  // let country = '';
  // let poscode;
  // let about = '';
  // let img_cid;
  let img;

  let data_cid;
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
   

    const STUDENT_ADDRESS = StudentAddress.address;
     const StudentContract = new ethers.Contract(
      STUDENT_ADDRESS,
      Student.abi,
      signer
    );

  async function getDetails(){
    connectedAccount = await signer.getAddress();
    data_cid = await StudentContract.getaboutHash({from: connectedAccount})
    const uri = `https://${data_cid}.ipfs.w3s.link/`;
            //console.log(uri)
            // use uri to fetch the nft metadata stored on ipfs 
    const response = await fetch(uri)
    const metadata = await response.json()
    // username = metadata.username;
    // firstname = metadata.firstname;
    // lastname = metadata.lastname;
    // emailaddress = metadata.emailaddress;
    // city = metadata.city;
    // state = metadata.state;
    // country = metadata.country;
    // poscode = metadata.poscode;
    // about = metadata.about;
    img = metadata.img;

  }

  getDetails();
  // core components

  const image = "../assets/img/student.jpg";

  let dropdownPopoverShow = false;

  let btnDropdownRef;
  let popoverDropdownRef;

  const toggleDropdown = (event) => {
    event.preventDefault();
    if (dropdownPopoverShow) {
      dropdownPopoverShow = false;
    } else {
      dropdownPopoverShow = true;
      createPopper(btnDropdownRef, popoverDropdownRef, {
        placement: "bottom-start",
      });
    }
  };
</script>

<div>
  <a
    class="text-blueGray-500 block"
    href="#pablo"
    bind:this="{btnDropdownRef}"
    on:click="{toggleDropdown}"
  >
    <div class="items-center flex">
      <span
        class="w-12 h-12 text-sm text-white bg-blueGray-200 inline-flex items-center justify-center rounded-full"
      >
        <img
          alt="..."
          class="w-full rounded-full align-middle border-none shadow-lg"
          src="{img}"
        />
      </span>
    </div>
  </a>
  <div
    bind:this="{popoverDropdownRef}"
    class="bg-white text-base z-50 float-left py-2 list-none text-left rounded shadow-lg min-w-48 {dropdownPopoverShow ? 'block':'hidden'}"
  >
    <a
      href="#pablo" on:click={(e) => e.preventDefault()}
      class="text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent text-blueGray-700"
    >
      Action
    </a>
    <a
      href="#pablo" on:click={(e) => e.preventDefault()}
      class="text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent text-blueGray-700"
    >
      Another action
    </a>
    <a
      href="#pablo" on:click={(e) => e.preventDefault()}
      class="text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent text-blueGray-700"
    >
      Something else here
    </a>
    <div class="h-0 my-2 border border-solid border-blueGray-100" />
    <a
      href="#pablo" on:click={(e) => e.preventDefault()}
      class="text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent text-blueGray-700"
    >
      Seprated link
    </a>
  </div>
</div>
