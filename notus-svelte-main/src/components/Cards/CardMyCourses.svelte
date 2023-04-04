<script>
     import { link , navigate } from "svelte-routing";
    import { ethers } from "ethers";
    import Student from "../../../../build/contracts/Student.json";
    import Instructor from "../../../../build/contracts/Instructor.json";
    import Courseblocks from "../../../../build/contracts/Courseblocks.json";
    import StudentAddress from "../../../contractsData/Student-address.json";
    import InstructorAddress from "../../../contractsData/Instructor-address.json";
    import CourseblocksAddress from "../../../contractsData/Courseblocks-address.json";
    import SaiCreditToken from "../../../../build/contracts/SaiCreditToken.json";
    import SaiCredit_Address from "../../../contractsData/SaiCreditToken-address.json";
    import { courseId } from '../../stores/course.js';
   
    
    

    let pdfDoc;
    let currentPage = 1;
    let numPages = 0;
    let pdfViewer;
    // import PdfViewer from 'svelte-pdf';
    // import InstructorNavbar from '../../Navbars/InstructorNavbar.svelte';
    let showModal = false;
    let minimized = true; // boolean to track if PDF is minimized or not
    let shouldRoute = false;

    function togglePDF() {
        minimized = !minimized;
    }

    function toggleModal() {
        showModal = !showModal;
    }

    const API_KEY =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDdDMTIwZDE0QWJGMzFCNzU5NzJDODkwNTYzRDc1QmRlNTQ2RWYzZUEiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2NjMxMzUyMTY5OTgsIm5hbWUiOiJFSFJ0b2tlbiJ9.qf_TPOWIqbXJVSsOhv0oywTJCYNsuJ3VVYOX-qA0H6g";
    const API = "https://api.web3.storage";
    let connectedAccount = "";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();

    const STUDENT_ADDRESS = StudentAddress.address;
    const StudentContract = new ethers.Contract(
        STUDENT_ADDRESS,
        Student.abi,
        signer
    );

    const InstructorContract = new ethers.Contract(
        InstructorAddress.address,
        Instructor.abi,
        signer
    );

    const CourseblocksContract = new ethers.Contract(
        CourseblocksAddress.address,
        Courseblocks.abi,
        signer
    );
    const SaiCreditContract = new ethers.Contract(
      SaiCredit_Address.address,
      SaiCreditToken.abi,
      signer
    );

    let title = "";
    let price = 0;
    let question = "";
    let deadline = 0;
    let auth_name = "";
    let files;
    let img_cid;
    let doc_cid;
    let pub_key = "";
    let currentTime = new Date();
    let timeInSeconds = Math.floor(currentTime.getTime() / 1000);

    let items_list = [];
    let bought = [];
    //items_list.push({name: "EHR_paper"})
    let name = "Some NFT";
    let description = "";
    const loadCourses = async () => {
        //await window.ethereum.request({ method: 'eth_requestAccounts' })
        connectedAccount = await signer.getAddress();
        console.log("success");
        // Load all unsold items
        const courseCount = await CourseblocksContract.courseCount({
            from: connectedAccount,
        });
        //console.log(itemCount)
        // items = []
        let items = [];
        let prev_id = "";
        let prev_cid = "";
        for (let i = 0; i < courseCount; i++) {
            let bornot = await CourseblocksContract.boughtornot(connectedAccount,i, {from : connectedAccount});
            //console.log("entered the loop with i")
            if(bornot)
            {
                    const course = await CourseblocksContract.getCourse(i, {
                            from: connectedAccount,
                    });
            //console.log(item)
            // get uri url from nft contract
            // const uri = await NFTContract.tokenURI(item.tokenId, {from: connectedAccount})
            // //console.log(uri)
            // // use uri to fetch the nft metadata stored on ipfs
            // const response = await fetch(uri)
            // const metadata = await response.json()
            // //console.log(metadata)
            // // get total price of item (item price + fee)
            // const totalPrice = await MarketplaceContract.getTotalPrice(item.itemId, {from: connectedAccount})
            // Add item to items array
                    let img_cid = await CourseblocksContract.getThumbHash(i,{from: connectedAccount});
                    let file_cid = await CourseblocksContract.getFileHash(i,{from: connectedAccount})
                    console.log(course.name);
                    console.log(course.thumbnail_hash);
            // const img_url = `https://${course.thumbnail_hash}.ipfs.w3s.link/`;
            // const content = `https://${course.file_hash}.ipfs.w3s.link/`;
                    const img_url =  `https://${img_cid}.ipfs.w3s.link/`;
                    const content =  `https://${file_cid}.ipfs.w3s.link/`;
            //let auth_name = await InstructorContract.getInstrName(course.author_id, {from : connectedAccount})
            items.push({
                c_id : course.id,
                c_title: course.name,
                c_desc: course.description,
                c_authname: course.author_name,
                c_price: course.price,
                c_users: course.users,
                c_image: img_url,
                c_file: content
            });
            items_list = items;
        }
        }
    };
    loadCourses();
    items_list = items_list;
    

    //             async function getDetails(){
    //     connectedAccount = await signer.getAddress();
    //     data_cid = await InstructorContract.getaboutHash({from: connectedAccount})
    //     const uri = `https://${data_cid}.ipfs.w3s.link/`;
    //             //console.log(uri)
    //             // use uri to fetch the nft metadata stored on ipfs
    //     const response = await fetch(uri)
    //     const metadata = await response.json()
    //     auth_name = metadata.firstname;

    //   }
    function opencourse(courseIdValue) {
            // window.open(link, "_blank");
            courseId.set(courseIdValue);
            navigate("/course/content");
        }
</script>

<div
    class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
    <div class="rounded-t bg-white mb-0 px-6 py-6">
        <div class="text-center flex justify-between">
            <h6 class="text-blueGray-700 text-xl font-bold">My Courses</h6>
            <!-- <button
      class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
      type="button"
      on:click={loadCourses}
    >
      Load Courses
    </button> -->
        </div>
    </div>
    <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
        <br />
        <br />
        <div class="d-flex justify-center mt-4 mb-4">
            <div class="course-grid">
            {#each items_list as course, i}
                <!-- {#if i%4 == 0}
                <hr class="solid">
            {/if} -->
                <div class="course-card">
                    <div class="course-image-container">
                      <img src={course.c_image} alt="{course.c_title} thumbnail" class="course-image" />
                    </div>
                    <div class="course-details">
                      <h2 class="course-title">{course.c_title}</h2>
                      <p class="course-instructor"><strong>Author</strong> : {course.c_authname}</p>
                      <p class="course-description"><strong>Description</strong> : {course.c_desc}</p>
                      <div class="course-meta">
                        <p class="course-rating"><strong>Users</strong> : {course.c_users}</p>
                        <p class="course-price"><strong>Price</strong> : {course.c_price} SaiETH</p>
                      </div>
                        <button
                            class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
                            type="button"
                            on:click={() => opencourse(course.c_id)}
                        >
                        Open the Course
                        </button>
                        <!-- <li class="items-center">
                            <a
                              use:link
                              href="/course"
                              class="text-xs uppercase py-3 font-bold block {location.href.indexOf('/course') !== -1 ? 'text-red-500 hover:text-red-600':'text-blueGray-700 hover:text-blueGray-500'}"
                            >
                              <i
                                class="fas fa-tools mr-2 text-sm {location.href.indexOf('/course') !== -1 ? 'opacity-75' : 'text-blueGray-300'}"
                              ></i>
                              Open Course
                            </a>
                          </li> -->

                    </div>
                  </div>
               
            {/each}
            </div>
        </div>
    </div>
</div>
<!-- Modal toggle -->


<style>
    hr.solid {
        border-top: 3px solid #bbb;
    }
    .course-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 2rem;
    margin: 2rem 0;
  }
  
  @media screen and (max-width: 768px) {
    .course-grid {
      justify-content: center;
    }
  }
    .course-card {
    display: flex;
    flex-direction: column;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: transform 0.2s ease-in-out;
    overflow: hidden;
  }

  .course-image-container {
    position: relative;
    height: 200px;
    overflow: hidden;
  }

  .course-image {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 100%;
    height: auto;
  }

  .course-details {
    padding: 1rem;
    flex: 1;
  }

  .course-title {
    margin-top: 0;
    margin-bottom: 0.5rem;
    font-size: 1.5rem;
    font-weight: bold;
  }

  .course-instructor {
    margin-top: 0;
    margin-bottom: 0.5rem;
    font-size: 1rem;
  }

  .course-description {
    margin-top: 0;
    margin-bottom: 1rem;
    font-size: 1rem;
  }

  .course-meta {
    display: flex;
    justify-content: space-between;
    font-size: 1rem;
    color: #666;
  }

  .course-rating {
    margin-top: 0;
    margin-bottom: 0;
    font-size: 1rem;
    color: #f39c12;
    font-weight: bold;
  }

  .course-price {
    margin-top: 0;
    margin-bottom: 0;
    font-size: 1rem;
    font-weight: bold;
  }

  .course-card:hover {
    transform: translateY(-4px);
  }
</style>
