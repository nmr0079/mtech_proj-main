<script>

    //export let location;
    let pop_books = [{ book_title: "",book_author:"",image_url:"",avg_ratings:0}]
    // Defining async function

  async function getTrendingBooks() {
      fetch("/trendingbooks").then((res) =>
            res.json().then((data) => {
                // Setting a data from api
                //data.forEach(({course_title, sim_score, price, num_subscribers}) => recomm_cs.addRow([course_title, sim_score, price, num_subscribers]));
                for (let i = 0; i < data.length; i++) {
                    pop_books[i] ={
                        book_title : data[i].book_title,
                        book_author : data[i].book_author,
                        image_url : data[i].image_url,
                        avg_ratings : data[i].avg_ratings
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
      <button
        on:click={getTrendingBooks}
        class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
        type="button"
      >
        Get Trending Books
      </button>
    </div>
  </div>
  <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
      <!--<h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">-->
     <!-- <div class="d-flex justify-center mt-4 mb-4">
        <ul>
            {#each recomm_cs as course}                        
              <li>Course Title : {course.course_title}</li>
              <li>Similarity score : {course.sim_score}</li>
              <li>Price : {course.price}</li>
              <li>Num of Subscribers : {course.num_subscribers}</li>
            {:else}
              <li>No Recommendations</li>
            {/each}
        </ul> 
    </div>-->
      <!-- <div class="d-flex justify-center mt-4 mb-4">
          <div class="rounded elevation-2 theme--dark pa-4" style="flex-grow:1;max-width:400px;">
            {#each recomm_cs as course, i}
            <Card href="/cards">
                <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{course.course_title}</h5>
                <p class="font-normal text-gray-700 dark:text-gray-400 leading-tight">
                  Similarity Score : {course.sim_score}
                </p>
                <p class="font-normal text-gray-700 dark:text-gray-400 leading-tight">
                    Price : {course.price}
                  </p>
                  <p class="font-normal text-gray-700 dark:text-gray-400 leading-tight">
                    Num of subscribers : {course.num_subscribers}
                  </p>
              </Card>
              <br />
              <br/>
              {:else}
              <li>No Recommendations</li>
            {/each}
          </div>
        </div>-->
       <!-- <div class="card-deck">
        {#each pop_books as books, i}
            <div class="card">
              <img class="card-img-top" src="{books.image_url}" alt="Card image cap">
              <div class="card-body">
                <h5 class="card-title">{books.book_title}</h5>
                <p class="card-text"><span style="color:black;">&#129492 Author:</span>{books.book_author}</p>
                <p class="card-text"><span style="color:black;">📈 Avg_Ratings :</span>{books.avg_ratings}</p>
              </div>
            </div>
        {/each}
        </div>-->
          
           {#each pop_books as books, i}
                  <div style="width:90%;height:100%;margin:1px;padding:5px;position:relative;border-radius:5px;border-bottom-right-radius: 60px;
                  box-shadow:0 0 15px 5px #ccc; background-color: #a8f0c6;
                    border-left: 5px solid #6c6c6c;">
                  <h4>{books.book_title}</h4>
                  <img src="{books.image_url}" width="200" height="40" alt="book image">
                  <p style="color:blue;"><span style="color:black;">&#129492 Author:</span>{books.book_author}</p>
                  <p style="color:blue;"><span style="color:black;">📈 Avg_Ratings :</span>{books.avg_ratings}</p>
                  <br/>
                 </div>
            {/each}
       
        </div>
  </div>
  <style>
  </style>