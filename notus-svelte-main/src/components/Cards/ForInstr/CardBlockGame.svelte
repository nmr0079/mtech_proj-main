<script>
     import { ethers } from 'ethers';
        import SaiToken from "../../../../build/contracts/SaiCreditToken.json";
        import Student from "../../../../build/contracts/Student.json";
        import NFT from "../../../../build/contracts/NFT.json";
        import Marketplace from "../../../../build/contracts/Marketplace.json";
        import StudentAddress from "../../../contractsData/Student-address.json";
        import NFTAddress from "../../../contractsData/NFT-address.json";
        import MarketplaceAddress from "../../../contractsData/Marketplace-address.json";

        let connectedAccount = "";
        const provider = new ethers.providers.Web3Provider(window.ethereum);

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

    const CARD_ARRAY = [
  {
    name: 'fries',
    img: '../assets/img/fries.png'
  },
  {
    name: 'cheeseburger',
    img: '../assets/img/cheeseburger.png'
  },
  {
    name: 'ice-cream',
    img: '../assets/img/ice-cream.png'
  },
  {
    name: 'pizza',
    img: '../assets/img/pizza.png'
  },
  {
    name: 'milkshake',
    img: '../assets/img/milkshake.png'
  },
  {
    name: 'hotdog',
    img: '../assets/img/hotdog.png'
  }
]


</script>