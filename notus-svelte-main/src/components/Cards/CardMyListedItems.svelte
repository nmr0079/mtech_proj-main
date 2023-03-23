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
       {#each items_list as item, i}
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
            {/each}
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

