<script>
    // core components
    import { link , navigate} from "svelte-routing";
  import { ethers } from "../../../node_modules/ethers";
  import SaiToken from "../../../../build/contracts/SaiCreditToken.json";
  import Student from "../../../../build/contracts/Student.json";
  import SaiCreditTokenAddress from "../../../contractsData/SaiCreditToken-address.json";
  import StudentAddress from "../../../contractsData/Student-address.json";
  import Instructor from "../../../../build/contracts/Instructor.json";
  import Courseblocks from "../../../../build/contracts/Courseblocks.json";
  import InstructorAddress from "../../../contractsData/Instructor-address.json";
  import CourseblocksAddress from "../../../contractsData/Courseblocks-address.json";
  import { courseId } from '../../stores/course.js';
  import { BigNumber } from 'bignumber.js';
  console.log(BigNumber);
    let courseIdValue;
    courseId.subscribe(value => {
		courseIdValue = value;
	});
  let connectedAccount = "";
  let files;

  let data_cid;

  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();


    const STUDENT_ADDRESS = StudentAddress.address;
     const StudentContract = new ethers.Contract(
      STUDENT_ADDRESS,
      Student.abi,
      signer
    );
    const CourseblocksContract = new ethers.Contract(
        CourseblocksAddress.address,
        Courseblocks.abi,
        signer
    );

    const img = "/assets/img/Timer.gif"
  async function connectWallet() {
    	if (window.ethereum) {
     	 await window.ethereum.request({ method: 'eth_requestAccounts' })
     	 connectedAccount = await signer.getAddress();
       balance = await SaiCreditContract.balanceOf(connectedAccount);
  		} else {
        alert('You need to install metamask');
        }
  }

  async function uploadAssignmentFile() {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        connectedAccount = await signer.getAddress();
        const response = await fetch(API + "/upload", {
            method: "POST", // *GET, POST, PUT, DELETE, etc.
            headers: {
                "Content-Type": "blob/file",
                Authorization: "Bearer " + API_KEY,
            },
            referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
            body: files[0],
            //body: App.encrypt(fileInput.value) // body data type must match "Content-Type" header
        })
            .then((response) => response.json())
            .then((data) => {
                data_cid = data.cid;
                return;
            });
        // console.log(response.json()) // parses JSON response into native JavaScript objects
    }
    let assignment_deadline;
    let deadlineInDays = 0;
    const loadAssignmentFile = async () => {
        //await window.ethereum.request({ method: 'eth_requestAccounts' })
        let deadline;
        connectedAccount = await signer.getAddress();
        console.log("success");
        const course = await CourseblocksContract.getCourse(courseIdValue, {
                            from: connectedAccount,
        });

        deadline = course.deadline;
        assignment_deadline = deadline;
        deadlineInDays = new BigNumber(assignment_deadline.toString()).dividedBy(86400).toFixed(0);
      
    };
    loadAssignmentFile();
    assignment_deadline = assignment_deadline;
    console.log(assignment_deadline);
    const bn = new BigNumber(assignment_deadline);
    console.log(bn.isNaN());
    console.log(bn.toFixed()); 
    //const deadlineInDays = assignment_deadline / 86400;
    
    console.log(deadlineInDays);
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
              src="{img}"
              class="shadow-xl rounded-full h-auto align-middle border-none absolute -m-16 -ml-20 lg:-ml-16 max-w-150-px"
            />
          </div>
        </div>
        <div
        class="w-full lg:w-4/12 px-4 lg:order-3 lg:text-right lg:self-center"
      >
     
      </div>
        <div class="w-full px-4 text-center mt-20">
          <div class="flex justify-center py-4 lg:pt-4 pt-8">
            <div class="mr-4 p-3 text-center">
              <span
                class="text-xl font-bold block uppercase tracking-wide text-blueGray-600"
              >
              {deadlineInDays} days
              </span>
              <span class="text-sm text-blueGray-400">Assignment Deadline</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="text-center mt-12">
        <h6
        class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase"
    >
        Assignment Submission
    </h6>
        <div class="relative w-full mb-3">
            <label for="myfile">Select a file:</label>
            <input
                bind:files
                type="file"
                id="myfile"
                name="myfile"
            />
        </div>
        <button
      class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
      type="button"
      on:click={uploadAssignmentFile}
  >
      Submit
  </button>
        </div>
  </div>