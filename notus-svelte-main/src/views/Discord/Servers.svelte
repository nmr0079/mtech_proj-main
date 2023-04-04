<!-- Servers.svelte -->
<script>
    import ethereum from "../../../public/assets/img/ethereum.svg";
    import plus from "../../../public/assets/img/plus.svg";
    import search from "../../../public/assets/img/search.svg";
  </script>
  
  <div class="servers">
    <div class="server">
      <img src={ethereum} alt="Ethereum Logo" />
    </div>
    <div class="server">
      <img src={plus} alt="Add Server" />
    </div>
    <div class="server">
      <img src={search} alt="Add Server" />
    </div>
  </div>
  
  <style>
    .servers {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 8px;
      background-color: #2f3136;
    }
    
    .server img {
      height: 24px;
      width: 24px;
    }
  </style>
  