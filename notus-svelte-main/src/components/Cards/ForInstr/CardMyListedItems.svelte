<div
  class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
  <div class="rounded-t bg-white mb-0 px-6 py-6">
    <div class="text-center flex justify-between">
      <h6 class="text-blueGray-700 text-xl font-bold">NFT Collectibles</h6>
      <button
      class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
      type="button"
      on:click={loadMarketplaceItems}
    >
      Load NFTs
    </button>
</div>
</div>
<div class="flex-auto px-4 lg:px-10 py-10 pt-0">
  <br/>
  <br/>
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
            {#each items_list as item, i}
            {#if i%4 == 0}
                <hr class="solid">
            {/if} 
            
            <div class="flex justify-center">
              <div
                class="block max-w-sm rounded-lg bg-white shadow-lg dark:bg-neutral-700">
                <a href="#!" data-te-ripple-init data-te-ripple-color="light">
                  <img
                    class="rounded-t-lg"
                    src="{item.image}"
                    width="200" height="40"
                    alt="" />
                </a>
                <div class="p-6">
                  <h5
                    class="mb-2 text-xl font-medium leading-tight text-neutral-800 dark:text-neutral-50">
                    {item.name}
                  </h5>
                  <p class="mb-4 text-base text-neutral-600 dark:text-neutral-200">
                    {item.description}
                  </p>
                  <button
                    type="button"
                    class="inline-block rounded bg-primary px-6 pt-2.5 pb-2 text-xs font-medium uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)]"
                    data-te-ripple-init
                    data-te-ripple-color="light">
                    Buy NFT
                  </button>
                </div>
              </div>
            </div>
            {/each}
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


<script>
        import { ethers } from 'ethers';
        import SaiToken from "../../../../build/contracts/SaiCreditToken.json";
        import Student from "../../../../build/contracts/Student.json";
        import NFT from "../../../../build/contracts/NFT.json";
        import Marketplace from "../../../../build/contracts/Marketplace.json";
        import StudentAddress from "../../../contractsData/Student-address.json";
        import NFTAddress from "../../../contractsData/NFT-address.json";
        import MarketplaceAddress from "../../../contractsData/Marketplace-address.json";
        import {
                Card,
                CardTitle,
                CardSubtitle,
                CardActions,
                Button,
                Icon,
                Divider,
                Row,
                Col,
                MaterialApp } from 'svelte-materialify';

        const API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDdDMTIwZDE0QWJGMzFCNzU5NzJDODkwNTYzRDc1QmRlNTQ2RWYzZUEiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2NjMxMzUyMTY5OTgsIm5hbWUiOiJFSFJ0b2tlbiJ9.qf_TPOWIqbXJVSsOhv0oywTJCYNsuJ3VVYOX-qA0H6g"
        const API = "https://api.web3.storage"
        let connectedAccount = "";
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        let img1 =  "../assets/img/EHR_BLCK.png";
        let img2 = "../assets/img/Graph_algo.png";
        let img3 =  "../assets/img/mining_mass.png";
        let img4 =  "../assets/img/KMeans.png";
        let team2 = "../assets/img/nft_img.jpeg";
        const signer = provider.getSigner();
        let list_img = [img1,img2,img3,img4, team2]

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
    let items_list = [];
    //items_list.push({name: "EHR_paper"})
    let name = "Some NFT";
    let description = "Some description about,some random thing"
    const loadMarketplaceItems = async () => {
        //await window.ethereum.request({ method: 'eth_requestAccounts' })
        connectedAccount = await signer.getAddress();
        console.log("loaMarketplace called successfully")
        // Load all unsold items
        const itemCount = await MarketplaceContract.itemCount({from: connectedAccount})
        //console.log(itemCount)
        // items = []
        let items = []
        let j = 0;
        for (let i = 1; i <= itemCount; i++) {
            //console.log("entered the loop with i")
        const item = await MarketplaceContract.items(i, {from: connectedAccount})
        //console.log(item)
        if (!item.sold) {
            // get uri url from nft contract
            const uri = await NFTContract.tokenURI(item.tokenId, {from: connectedAccount})
            //console.log(uri)
            // use uri to fetch the nft metadata stored on ipfs 
            const response = await fetch(uri)
            const metadata = await response.json()
            //console.log(metadata)
            // get total price of item (item price + fee)
            const totalPrice = await MarketplaceContract.getTotalPrice(item.itemId, {from: connectedAccount})
            // Add item to items array
            items.push({totalPrice, itemId: item.itemId, seller: item.seller, name: metadata.nftname, description: metadata.nftdescription,
            image: list_img[j]
            });
            j = j + 1;
        }
        items_list = items;
        }
        
    }
    loadMarketplaceItems();
    console.log(items_list)
    //console.log(items)
const buyMarketItem = async (item) => {
    await window.ethereum.request({ method: 'eth_requestAccounts' })
    connectedAccount = await signer.getAddress();
    await (await MarketplaceContract.purchaseItem(item.itemId, { value: item.totalPrice })).wait()
    loadMarketplaceItems()
  }
  
</script>
<style>
  hr.solid {
  border-top: 3px solid #bbb;
}
</style>

