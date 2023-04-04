<script>

    //export let location;
    let rec_books = [{ book_title: "",book_author:"",image_url:""}]
    // Defining async function
    let title;

  async function getRecommendedBooks() {
    //   const request = new XMLHttpRequest()
    //   request.open('POST', `/BookRecommender/${JSON.stringify(title)}`)
    //   request.send();
    // fetch(`/passing/${title}`)
    //   .then(function (response) {
    //       return response.text();
    //   }).then(function (text) {
    //       console.log('GET response text:');
    //       console.log(text); 
    //   });
      fetch(`/passing/${title}`).then((res) =>
            res.json().then((data) => {
                // Setting a data from api
                //data.forEach(({course_title, sim_score, price, num_subscribers}) => recomm_cs.addRow([course_title, sim_score, price, num_subscribers]));
                for (let i = 0; i < data.length; i++) {
                    rec_books[i] ={
                        book_title : data[i].book_title,
                        book_author : data[i].book_author,
                        image_url : data[i].image_url
                    }
                }
        }))
  }

  const team2 = "../assets/img/Harry_Potter3.jpg";
  </script>
  <div
  class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
  <div class="rounded-t bg-white mb-0 px-6 py-6">
    <div class="text-center flex justify-between">
      <h6 class="text-blueGray-700 text-xl font-bold">Book Recommender</h6>
      <form>
        <input type="text" name="title" id="title"  input bind:value={title} placeholder="Enter title here..." class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 relative bg-white bg-white rounded text-sm shadow outline-none focus:outline-none focus:ring w-full pl-10">
        <button
        on:click={getRecommendedBooks}
        class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
        type="button"
        >
        Search Similar Books
      </button>
      </form>
    </div>
  </div>
  <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
          
           {#each rec_books as books, i}
                  <div style="width:90%;height:100%;margin:1px;padding:5px;position:relative;border-radius:5px;border-bottom-right-radius: 60px;
                  box-shadow:0 0 15px 5px #ccc; background-color: #a8f0c6;
                    border-left: 5px solid #6c6c6c;">
                  <h4>{books.book_title}</h4>
                  <img src="{books.image_url}" width="200" height="40" alt="book image">
                  <p style="color:blue;"><span style="color:black;">&#129492 Author:</span>{books.book_author}</p>
                  <br/>
                 </div>
            {/each}
       
        </div>
  </div>
  <style>
  </style>