<script>
    import { ethers } from "ethers";
    import Student from "../../../../../build/contracts/Student.json";
    import Instructor from "../../../../../build/contracts/Instructor.json";
    import Courseblocks from "../../../../../build/contracts/Courseblocks.json";
    import StudentAddress from "../../../../contractsData/Student-address.json";
    import InstructorAddress from "../../../../contractsData/Instructor-address.json";
    import CourseblocksAddress from "../../../../contractsData/Courseblocks-address.json";
    

    let pdfDoc;
    let currentPage = 1;
    let numPages = 0;
    let pdfViewer;
    // import PdfViewer from 'svelte-pdf';
    // import InstructorNavbar from '../../Navbars/InstructorNavbar.svelte';
    let showModal = false;
    let minimized = true; // boolean to track if PDF is minimized or not

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

    let title = "";
    let price = 0;
    let question = "";
    let deadline = 0;
    let auth_name = "";
    let files;
    let img_cid;
    let doc_cid;
    let pub_key = "";

    let items_list = [];
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
            //console.log("entered the loop with i")
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
            let auth_name = await InstructorContract.getInstrName(connectedAccount, {from : connectedAccount})
            items.push({
                c_title: course.name,
                c_desc: course.description,
                c_authname: course.author_name,
                c_price: course.price,
                c_users: course.users,
                c_image: img_url,
                c_file: content,
            });

            items_list = items;
        }
    };
    loadCourses();
    items_list = items_list;

    async function uploadcoursetmb() {
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
                img_cid = data.cid;
                return CourseblocksContract.setThumbhash(data.cid, {
                    from: connectedAccount,
                });
            });
        // console.log(response.json()) // parses JSON response into native JavaScript objects
    }

    async function uploadFile() {
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
                doc_cid = data.cid;
                return CourseblocksContract.setFilehash(data.cid, {
                    from: connectedAccount,
                });
            });
        // console.log(response.json()) // parses JSON response into native JavaScript objects
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
                doc_cid = data.cid;
                return CourseblocksContract.setAssignmentHash(data.cid, {
                    from: connectedAccount,
                });
            });
        // console.log(response.json()) // parses JSON response into native JavaScript objects
    }

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

    async function addCourses() {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        connectedAccount = await signer.getAddress();
        let message = await CourseblocksContract.addCourse(
            title,
            description,
            auth_name,
            price,
            deadline,
            connectedAccount,
            { from: connectedAccount }
        );
        console.log(message);
    }
    console.log("Added Courses");
    console.log(items_list);

  function initViewer(canvas) {
    pdfViewer = new pdfjsLib.PDFViewer({
      container: canvas,
    });
  }

  async function loadPDF() {
    const url = 'your_pdf_file.pdf';
    const loadingTask = pdfjsLib.getDocument(url);
    pdfDoc = await loadingTask.promise;
    numPages = pdfDoc.numPages;

    pdfViewer.setDocument(pdfDoc);
  }

  function goToPage(pageNum) {
    currentPage = pageNum;
    pdfViewer.currentPageNumber = pageNum;
  }
</script>

<div
    class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
    <div class="rounded-t bg-white mb-0 px-6 py-6">
        <div class="text-center flex justify-between">
            <h6 class="text-blueGray-700 text-xl font-bold">Courses</h6>
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
            <!-- <ul>
            {#each items_list as item}                        
              <li>{item.name}</li>
            {:else}
              <li>No items</li>
            {/each}
            </ul> -->
            <!-- {#each items_list as item, i}
            <Card style="max-width:350px;">
                <Row>
                    <Col cols={8}>
                      <img src="{item.image}" alt="background" />
                      <CardTitle>{item.name}</CardTitle>
                      <CardSubtitle>{item.description}</CardSubtitle>
                      <CardSubtitle>Price : {ethers.utils.formatEther(item.totalPrice)} ETH</CardSubtitle>
                      <CardActions>
                        <Button onClick={() => buyMarketItem(item)} >Buy NFT</Button>
                      </CardActions>
                    </Col>
                    <Col cols={4}></Col>
                  </Row>
            </Card>
            <br />
            {/each}-->
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
                    </div>
                  </div>
                <!-- <div class="flex justify-center">
                    <div
                        class="block max-w-sm rounded-lg bg-white shadow-lg dark:bg-neutral-700"
                    >
                        <a
                            href="#!"
                            data-te-ripple-init
                            data-te-ripple-color="light"
                        >
                            <img src={course.c_image} alt="Course thumbnail" />
                        </a>
                        <div class="p-6">
                            <h5
                                class="mb-2 text-xl font-medium leading-tight text-neutral-800 dark:text-neutral-50"
                            >
                                {course.c_title}
                            </h5>
                            <p
                                class="mb-4 text-base text-neutral-600 dark:text-neutral-200"
                            >
                                {course.c_desc}
                            </p>
                            <p
                                class="mb-4 text-base text-neutral-600 dark:text-neutral-200"
                            >
                                author : {course.c_authname}
                            </p>
                            <p
                                class="mb-4 text-base text-neutral-600 dark:text-neutral-200"
                            >
                                price : {course.c_price}
                            </p>
                            <p
                                class="mb-4 text-base text-neutral-600 dark:text-neutral-200"
                            >
                                users : {course.c_users}
                            </p> -->
                            <!-- <p class="mb-4 text-base text-neutral-600 dark:text-neutral-200">
                    img_url : {course.c_image}
                  </p> -->
                            <!-- <button
                    type="button"
                    class="inline-block rounded bg-primary px-6 pt-2.5 pb-2 text-xs font-medium uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)]"
                    data-te-ripple-init
                    data-te-ripple-color="light">
                    Open Course
                  </button> -->
                            <!-- <button
                    class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
                    type="button">
                        Open Course
                  </button> -->
                            <!-- <button
                                class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
                                type="button"
                                on:click={togglePDF}
                            >
                            </button>
                            {#if minimized}
                                    Open Course
                                {:else}
                                    Hide Course
                                {/if}
                                PDF display
                                <div style="height: 200px;">
                                    {#if !minimized}
                                        <iframe
                                            src={course.c_file}
                                            style="height: 100%; width: 100%;"
                                            frameborder="0"
                                        />
                                    {/if}
                                </div>
                        </div>  
                    </div>
                </div> -->
            {/each}
            </div>
            <!--<div class="mt-6 space-y-12 lg:grid lg:grid-cols-3 lg:gap-x-6 lg:space-y-0">
            {#each items_list as item, i}
            <div class="group relative">
                <div class="min-h-80 aspect-w-1 aspect-h-1 w-full overflow-hidden rounded-md bg-gray-200 group-hover:opacity-75 lg:aspect-none lg:h-80">
                  <img src="{item.image}" alt="Front of men&#039;s Basic Tee in black." class="h-full w-full object-cover object-center lg:h-full lg:w-full">
                </div>
                <div class="mt-4 flex justify-between">
                  <div>
                    <h3 class="text-sm text-gray-700">
                      <a href="#">
                        <span aria-hidden="true" class="absolute inset-0"></span>
                        {item.name}
                      </a>
                    </h3>
                    <p class="mt-1 text-sm text-gray-500">{item.description}</p>
                  </div>
                  <p class="text-sm font-medium text-gray-900">{ethers.utils.formatEther(item.totalPrice)} ETH</p>
               </div>
               </div>
              {/each}
          </div>-->
        </div>
    </div>
</div>
<!-- Modal toggle -->
<button
    class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
    type="button"
    on:click={toggleModal}
>
    Add Course
</button>
{#if showModal}
    <div
        class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-200 border-0"
    >
        <div class="rounded-t mb-0 px-6 py-6">
            <div class="text-center mb-3">
                <h6 class="text-blueGray-500 text-sm font-bold">
                    Add Course Details
                </h6>
            </div>
            <hr class="mt-6 border-b-1 border-blueGray-300" />
        </div>
        <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
            <div class="text-blueGray-400 text-center mb-3 font-bold">
                <small>Course Details</small>
            </div>
            <!-- <div class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex">
    <div class="relative w-auto my-6 mx-auto max-w-sm">
      content
      <div class="border-0 rounded-lg shadow-lg relative flex flex-col w-full bg-white outline-none focus:outline-none">
        header
        <div class="flex items-start justify-between p-5 border-b border-solid border-blueGray-200 rounded-t">
          <h3>
            <strong>Fill in the Course Details</strong>
          </h3>
          <button class="p-1 ml-auto bg-transparent border-0 text-black opacity-5 float-right text-3xl leading-none font-semibold outline-none focus:outline-none" on:click={toggleModal}>
            <span class="bg-transparent text-black opacity-5 h-6 w-6 text-2xl block outline-none focus:outline-none">
              ×
            </span>
          </button>
        </div> -->
            <!--body-->
            <form>
                <div class="relative w-full mb-3">
                    <label
                        class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                        for="grid-name"
                    >
                        Title
                    </label>
                    <input
                        id="grid-name"
                        type="text"
                        class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                        placeholder="Course Title"
                        bind:value={title}
                    />
                </div>
                <div class="relative w-full mb-3">
                    <label
                        class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                        for="grid-desc"
                    >
                        Description
                    </label>
                    <input
                        id="grid-name"
                        type="text"
                        class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                        placeholder="Course Description"
                        bind:value={description}
                    />
                </div>
                <div class="relative w-full mb-3">
                    <label
                        class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                        for="grid-name"
                    >
                        Author Name
                    </label>
                    <input
                        id="grid-name"
                        type="text"
                        class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                        placeholder="Course Description"
                        bind:value={auth_name}
                    />
                </div>
                <div class="relative w-full mb-3">
                    <label
                        class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                        for="grid-price"
                    >
                        Price
                    </label>
                    <input
                        id="grid-name"
                        type="number"
                        class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                        placeholder="Course Price"
                        min="0"
                        bind:value={price}
                    />
                </div>

                <!-- <div class="relative w-full mb-3">
                    <label
                        class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                        for="grid-price"
                    >
                        Question
                    </label>
                    <input
                        id="grid-name"
                        type="text"
                        class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                        placeholder="Assignment Question"
                        bind:value={question}
                    />
                </div> -->
                <div class="relative w-full mb-3">
                    <label
                        class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                        for="grid-price"
                    >
                        Deadline
                    </label>
                    <input
                        id="grid-name"
                        type="number"
                        class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                        placeholder="Course Price"
                        min="1"
                        bind:value={deadline}
                    />
                </div>
                <h6
                    class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase"
                >
                    Upload your course files
                </h6>
                <div class="flex flex-wrap">
                    <div class="w-full lg:w-6/12 px-4">
                        <div class="relative w-full mb-3">
                            <label for="myfile">Select a file:</label>
                            <input
                                bind:files
                                type="file"
                                id="myfile"
                                name="myfile"
                            />
                        </div>
                    </div>
                </div>
                <button
                    class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
                    type="button"
                    on:click={uploadcoursetmb}
                >
                    Upload subject thumbnail
                </button>
                <div class="flex flex-wrap">
                    <div class="w-full lg:w-6/12 px-4">
                        <div class="relative w-full mb-3">
                            <label for="myfile">Select a file:</label>
                            <input
                                bind:files
                                type="file"
                                id="myfile"
                                name="myfile"
                            />
                        </div>
                    </div>
                </div>
                <button
                    class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
                    type="button"
                    on:click={uploadFile}
                >
                    Upload Course content
                </button>
                <div class="flex flex-wrap">
                    <div class="w-full lg:w-6/12 px-4">
                        <div class="relative w-full mb-3">
                            <label for="myfile">Select a file:</label>
                            <input
                                bind:files
                                type="file"
                                id="myfile"
                                name="myfile"
                            />
                        </div>
                    </div>
                </div>
                <button
                    class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
                    type="button"
                    on:click={uploadAssignmentFile}
                >
                    Upload First Assignment File
                </button>
            </form>
            <!--footer-->
            <div
                class="flex items-center justify-end p-6 border-t border-solid border-blueGray-200 rounded-b"
            >
                <button
                    class="text-red-500 background-transparent font-bold uppercase px-6 py-2 text-sm outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
                    type="button"
                    on:click={toggleModal}
                >
                    Close
                </button>
                <button
                    class="bg-emerald-500 text-white active:bg-emerald-600 font-bold uppercase text-sm px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
                    type="button"
                    on:click={addCourses}
                >
                    Publish Course
                </button>
            </div>
        </div>
    </div>
    <div class="opacity-25 fixed inset-0 z-40 bg-black" />
{/if}

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
