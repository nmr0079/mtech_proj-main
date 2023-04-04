<!-- NFTCard.svelte -->

<div class="nft-card">
    <img src={imageUrl} alt={name} class="nft-image">
    <div class="nft-details">
      <h2>{name}</h2>
      <p>{description}</p>
      <!-- <p class="nft-price">{price} ETH</p> -->
    </div>
  </div>
  
  <style>
    .nft-card {
      border: 1px solid #ccc;
      border-radius: 5px;
      display: flex;
      flex-direction: column;
      height: 100%;
      overflow: hidden;
      position: relative;
    }
  
    .nft-image {
      object-fit: cover;
      height: 200px;
      width: 100%;
    }
  
    .nft-details {
      padding: 10px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: 100%;
    }
  
    h2 {
      font-size: 20px;
      margin: 0;
    }
  
    .nft-price {
      font-size: 18px;
      font-weight: bold;
      margin-top: 10px;
    }
  
    p {
      font-size: 16px;
      margin: 0;
    }
  </style>
  