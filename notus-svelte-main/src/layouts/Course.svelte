<script>
	import PDFViewer from './../views/Course/PDFViewer.svelte';
    import { Router, Route } from "svelte-routing";
  
    // components for this layout
    import AdminNavbar from "components/Navbars/AdminNavbar.svelte";
    // import InstructorNavbar from "components/Navbars/InstructorNavbar.svelte";
    import CSidebar from "components/Sidebar/CSidebar.svelte";
    import HeaderStats from "components/Headers/HeaderStats.svelte";
    import FooterAdmin from "components/Footers/FooterAdmin.svelte";
  
    // pages for this layout
    import Content from "views/Course/Content.svelte";
    import AssignmentCorner from "views/Course/AssignmentCorner.svelte";
    import PdfViewer from "views/Course/PDFViewer.svelte";
  
    export let location;
    export let course= "";
  </script>
  
  <div>
    <CSidebar location={location}/>
    <div class="relative md:ml-64 bg-blueGray-100">
      <AdminNavbar />
      <HeaderStats />
      <div class="px-4 md:px-10 mx-auto w-full -m-24">
        <Router url="course">
          <Route path="content" component="{Content}" />
         <Route path="assignment" component="{AssignmentCorner}" />
         <Route path="pdfviewer" component="{PdfViewer}" />
        </Router>
        <FooterAdmin />
      </div>
    </div>
  </div>
  