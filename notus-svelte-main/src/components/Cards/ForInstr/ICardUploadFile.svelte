<script>
        import { create } from 'ipfs-http-client';
        import { ethers } from 'ethers';
        import SaiToken from "../../../../build/contracts/SaiCreditToken.json";
        import Student from "../../../../../build/contracts/Student.json";
        import NFT from "../../../../../build/contracts/NFT.json";
        import Marketplace from "../../../../../build/contracts/Marketplace.json";
        import StudentAddress from "../../../../contractsData/Student-address.json";
        import NFTAddress from "../../../../contractsData/NFT-address.json";
        import MarketplaceAddress from "../../../../contractsData/Marketplace-address.json";

        const API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDdDMTIwZDE0QWJGMzFCNzU5NzJDODkwNTYzRDc1QmRlNTQ2RWYzZUEiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2NjMxMzUyMTY5OTgsIm5hbWUiOiJFSFJ0b2tlbiJ9.qf_TPOWIqbXJVSsOhv0oywTJCYNsuJ3VVYOX-qA0H6g"
        const API = "https://api.web3.storage"
        let connectedAccount = "";
        let doc_cid;
        let nftdata;
        // const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDdDMTIwZDE0QWJGMzFCNzU5NzJDODkwNTYzRDc1QmRlNTQ2RWYzZUEiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2NzU2NjE5NzI2ODYsIm5hbWUiOiJORlRfdG9rZW4ifQ.DmG0uJDNUb0KH7zsohEi3RgkBk0uO-vJmp7o3ACKnag";
        // const client = new Web3Storage({ token })

        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        let files;
        let nftname = '';
        let nftdescription = ''; 
        let nftprice;
        let nftfile;
        let nftcid;

        const gid = x => document.getElementById(x);
        const fileInput = document.getElementById("myfile")
        const upload = gid('upload-to-ipfs')
   /*  async function upload(){
         const client = create({url:"http://127.0.0.1:5001/api/v0"})
         const input = document.querySelector('input[type="file"]')
         const cid = await client.add(input.files[0])
         return cid
     }*/
     const STUDENT_ADDRESS = StudentAddress.address;
     const StudentContract = new ethers.Contract(
      STUDENT_ADDRESS,
      Student.abi,
      signer
    );

    const NFTContract = new ethers.Contract(
      NFTAddress.address,
      NFT.abi,
      signer
    );

    const MarketplaceContract = new ethers.Contract(
      MarketplaceAddress.address,
      Marketplace.abi,
      signer
    );


 /*function uploadFile(){
     alert('sairam')
     upload().then((data)=>{
         alert(data)
         console.log(data);
     });
    }*/
  async function uploadFile() {
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
        doc_cid = data.cid;
        return StudentContract.setIPFShash(data.cid,{from: connectedAccount});
    
    })
   // console.log(response.json()) // parses JSON response into native JavaScript objects  
}

// async function storeFiles () {

//     const files = await getFilesFromPath('/path/to/file')

//     const cid = await client.put(files)

//     console.log(cid)
//     return cid;

// }
const createNFT = async () => {
  nftfile = `https://${doc_cid}.ipfs.w3s.link/`;
  nftdata = JSON.stringify({nftfile, nftprice, nftname, nftdescription});
  await window.ethereum.request({ method: 'eth_requestAccounts' })
  connectedAccount = await signer.getAddress();
  const response = await fetch(API+'/upload', {
      method: 'POST', // *GET, POST, PUT, DELETE, etc.
      headers: {
        'Content-Type': 'blob/file' ,
        "Authorization" : "Bearer "+API_KEY
      },
      referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
      body: nftdata
      //body: App.encrypt(fileInput.value) // body data type must match "Content-Type" header
    }).then((response) => response.json())
    .then((data) => {
        nftcid = data.cid;
        mintThenList();
        return StudentContract.setIPFShash(data.cid,{from: connectedAccount});
    
    })
}

const mintThenList = async () => {
    const uri = `https://${nftcid}.ipfs.w3s.link/`
    // mint nft 
    await(await NFTContract.mint(uri)).wait()
    // get tokenId of new nft 
    const id = await NFTContract.tokenCount()
    // approve marketplace to spend nft
    await(await NFTContract.setApprovalForAll(MarketplaceAddress.address, true)).wait()
    // add nft to marketplace
    const listingPrice = ethers.utils.parseEther(nftprice.toString())
    await(await MarketplaceContract.makeItems(NFTAddress.address, id, listingPrice)).wait()
}
const team2 = "/assets/img/certificatenft.png";
</script>

<div
  class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
  <div class="rounded-t bg-white mb-0 px-6 py-6">
    <div class="text-center flex justify-between">
      <h6 class="text-blueGray-700 text-xl font-bold">Student NFT Creation Section</h6>
      <button
        class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
        type="button"
        on:click={uploadFile}
      >
        Upload File
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
      <br/>
      <br/>
    <form>
      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Upload your documents
      </h6>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-6/12 px-4">
            <div class="relative w-full mb-3">
                <label for="myfile">Select a file:</label>
                <input bind:files type="file" id="myfile" name="myfile"> 

          </div>
          </div>
      </div>
      </form>
      </div>
     <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
        <form>
          <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
            NFT Metadata Section
          </h6>
          <div class="flex flex-wrap">
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label
                  class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                  for="grid-username"
                >
                  Name
                </label>
                <input 
                  id="grid-username"
                  bind:value={nftname}
                  type="text"
                  class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                  placeholder="DegreeCertNFT"
                />
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label
                  class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                  for="grid-email"
                >
                  Description
                </label>
                <input
                  id="grid-email"
                  bind:value={nftdescription}
                  type="text"
                  class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                  placeholder="It's a degree certificate converted to an NFT"
                />
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label
                  class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                  for="grid-first-name"
                >
                  Price
                </label>
                <input
                  id="grid-first-name"
                  bind:value={nftprice}
                  type=number 
                  min=0 
                  class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                />
              </div>
            </div>
            <!--<div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label
                  class="block uppercase text-blueGray-600 text-xs font-bold mb-2"
                  for="grid-first-name"
                >
                  Upload an image
                </label>
                <input
                  id="grid-first-name"
                  bind:value={nftprice}
                  type=number 
                  min=0 
                  class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150"
                />
              </div>
            </div>-->
          </form>
          <button
          class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
          type="button"
          on:click={createNFT}
        >
          Create NFT
        </button>
          </div>
    
      </div>
      