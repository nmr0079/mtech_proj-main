<script>
	// import PdfViewer from 'svelte-pdf';
    import { pdfurl } from '../../stores/pdfviewer.js';
    // import { Document, Page } from 'react-pdf-fix';
    let url;
    pdfurl.subscribe(value => {
		url = value;
	});
</script>

<!-- <PdfViewer url='{pdfurl}' /> -->
<!-- <iframe src="{pdfurl}" width="100%" height="600px"></iframe> -->
<!-- <embed src="{pdfurl}" width="100%" height="600px" type="application/pdf"> -->
    <!-- <Document file="{pdfurl}">
        <Page pageNumber={1} />
      </Document> -->
 <!-- svelte-ignore a11y-missing-attribute -->
 <!-- <object data="https://bafybeife26zs6avdgerq5jl462gn4rd24vk5qhzj7hqyixnnmhsk322gqe.ipfs.w3s.link" type="application/pdf" style="width:100%;height:100%;">
        <p>Sorry, your browser doesn't support embedded PDFs.</p>
 </object> -->
 <!-- <br/>
 <br/> -->
 <!-- <div class="flex flex-wrap">
    <div class="w-full lg:w-8/12 px-4">
        <div
  class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
  <div class="rounded-t bg-white mb-0 px-6 py-6">
    <div class="text-center flex justify-between">
      <h6 class="text-blueGray-700 text-xl font-bold">PDF Viewer</h6>
    </div>
  </div>
  <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
    <iframe src="https://mrcet.com/downloads/digital_notes/ECE/III%20Year/DATABASE%20MANAGEMENT%20SYSTEMS.pdf" width="90%" height="6000px"></iframe>
    </div>
    </div>
    </div>
</div> -->

<div class="flex flex-wrap mt-4">
    <div class="w-full mb-12 px-4">
<div
    class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
    <div class="rounded-t bg-white mb-0 px-6 py-6">
        <div class="text-center flex justify-between">
            <h6 class="text-blueGray-700 text-xl font-bold">PDF Viewer</h6>
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
        <div class="d-flex justify-center mt-4 mb-4">
            <!-- <iframe src="{url}" width="100%" height="6000px"></iframe> -->
            <embed src="{url}" width="100%" height="6000px" type="application/pdf">
            </div>
            </div>
            </div>
            </div>
            </div>

      