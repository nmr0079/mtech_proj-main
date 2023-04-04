<script>
    import { Router, Route } from "svelte-routing";
  
    // components for this layout
    import AdminNavbar from "components/Navbars/AdminNavbar.svelte";
    import InstructorNavbar from "components/Navbars/InstructorNavbar.svelte";
    import ISidebar from "components/Sidebar/ISidebar.svelte";
    import IHeaderStats from "components/Headers/IHeaderStats.svelte";
    import FooterAdmin from "components/Footers/FooterAdmin.svelte";
  
    // pages for this layout
    import Dashboard from "views/instructor/IDashboard.svelte";
    import Settings from "views/instructor/ISettings.svelte";
    import Tables from "views/instructor/Tables.svelte";
    //import Maps from "views/admin/Maps.svelte";
    import Tokens from "views/instructor/IToken.svelte";
    import UploadSection from "views/instructor/IUploadSection.svelte";
    import AdminNftCollect from "views/instructor/InstructorNFTCollect.svelte";
    import Calculator from "views/instructor/ICalculator.svelte";
    import BookRecommender from "views/instructor/IBook_recommender.svelte";
    import BookSearch from "views/instructor/IBook_search.svelte";
    import Courses from "views/instructor/Courses.svelte";
  
    export let location;
    export let instructor = "";
  </script>
  
  <div>
    <ISidebar location={location}/>
    <div class="relative md:ml-64 bg-blueGray-100">
      <InstructorNavbar />
      <IHeaderStats />
      <div class="px-4 md:px-10 mx-auto w-full -m-24">
        <Router url="instructor">
          <Route path="idashboard" component="{Dashboard}" />
         <Route path="itoken" component="{Tokens}" />
         <Route path="iuploaddocs" component="{UploadSection}" />
         <Route path="inftcollect" component="{AdminNftCollect}" />
         <Route path="ibookrec" component="{BookRecommender}" />
         <Route path="icolabbook" component="{BookSearch}" />
         <Route path="icalculator" component="{Calculator}" />
          <Route path="isettings" component="{Settings}" />
          <Route path="icourses" component="{Courses}" />
          <Route path="itables" component="{Tables}" />
        </Router>
        <FooterAdmin />
      </div>
    </div>
  </div>
  