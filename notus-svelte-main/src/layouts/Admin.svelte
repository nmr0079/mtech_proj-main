<script>
  import { Router, Route } from "svelte-routing";

  // components for this layout
  import AdminNavbar from "components/Navbars/AdminNavbar.svelte";
  import Sidebar from "components/Sidebar/Sidebar.svelte";
  import HeaderStats from "components/Headers/HeaderStats.svelte";
  import FooterAdmin from "components/Footers/FooterAdmin.svelte";

  // pages for this layout
  import Dashboard from "views/admin/Dashboard.svelte";
  import Settings from "views/admin/Settings.svelte";
  import Tables from "views/admin/Tables.svelte";
  import Maps from "views/admin/Maps.svelte";
  import Tokens from "views/admin/Token.svelte";
  import UploadSection from "views/admin/UploadSection.svelte";
  import AdminNftCollect from "views/admin/AdminNFTCollect.svelte";
  import CourseRecommender from "views/admin/Recommender.svelte";
  import Calculator from "views/admin/Calculator.svelte";
  import BookRecommender from "views/admin/Book_recommender.svelte";
  import BookSearch from "views/admin/Book_search.svelte";
  import CourseMarketplace from "views/admin/CourseMarketplace.svelte";
  import MyCourses from "views/admin/MyCourses.svelte";

  export let location;
  export let admin = "";
</script>

<div>
  <Sidebar location={location}/>
  <div class="relative md:ml-64 bg-blueGray-100">
    <AdminNavbar />
    <HeaderStats />
    <div class="px-4 md:px-10 mx-auto w-full -m-24">
      <Router url="admin">
        <Route path="dashboard" component="{Dashboard}" />
       <Route path="token" component="{Tokens}" />
       <Route path="uploaddocs" component="{UploadSection}" />
       <Route path="nftcollect" component="{AdminNftCollect}" />
       <Route path="courserec" component="{CourseRecommender}" />
       <Route path="bookrec" component="{BookRecommender}" />
       <Route path="colabbook" component="{BookSearch}" />
       <Route path="calculator" component="{Calculator}" />
        <Route path="settings" component="{Settings}" />
        <Route path="coursemarket" component="{CourseMarketplace}" />
        <Route path="mycourses" component="{MyCourses}" />
        <Route path="tables" component="{Tables}" />
        <Route path="maps" component="{Maps}" />
      </Router>
      <FooterAdmin />
    </div>
  </div>
</div>
