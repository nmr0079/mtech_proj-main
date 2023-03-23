<script>

    //export let location;
    let recomm_cs = [{rec_title: "",course_title:"",sim_score:0,diff_lvl:""}]
    let rand
    let data1 = {name:"",age:0,programming:""}
    let rectitle
    // Defining async function

    async function getRecommends() {
      fetch("/recommend").then((res) =>
            res.json().then((data) => {
                rectitle = data[0].rectitle
                // Setting a data from api
                //data.forEach(({course_title, sim_score, price, num_subscribers}) => recomm_cs.addRow([course_title, sim_score, price, num_subscribers]));
                for (let i = 0; i < data.length; i++) {
                    recomm_cs[i] ={
                        rec_title : data[i].rectitle,
                        course_title : data[i].course_title,
                        sim_score : data[i].sim_score,
                        diff_lvl : data[i].diff_lvl
                    }
                }
        }))
  }

  const team2 = "../assets/img/index.png";
  </script>
  <div
  class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
  <div class="rounded-t bg-white mb-0 px-6 py-6">
    <div class="text-center flex justify-between">
      <h6 class="text-blueGray-700 text-xl font-bold">Course Recommender</h6>
      <button
        on:click={getRecommends}
        class="bg-red-400 text-white active:bg-red-500 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
        type="button"
      >
        Get Recommendations
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
          
            {#each recomm_cs as course, i}
              {#if i%4 == 0}
                 <h2>
                  Since you took <strong>{course.rec_title}</strong> course 
                </h2>
                {/if}
                  <div style="width:90%;height:100%;margin:1px;padding:5px;position:relative;border-radius:5px;border-bottom-right-radius: 60px;
                  box-shadow:0 0 15px 5px #ccc; background-color: #a8f0c6;
                    border-left: 5px solid #6c6c6c;">
                  <h4>{course.course_title}</h4>
                  <p style="color:blue;"><span style="color:black;">📈Score::</span>{course.sim_score}</p>
                 <!-- <p style="color:blue;"><span style="color:black;">🔗</span><a href="{course.url}",target="_blank">Link</a></p>-->
                  <!--<p style="color:blue;"><span style="color:black;">💲Price:</span>{course.price}</p>-->
                  <p style="color:blue;"><span style="color:black;">Level :</span>{course.diff_lvl}</p>
                  <!--<p style="color:blue;"><span style="color:black;">🧑‍🎓👨🏽‍🎓 Student:</span>{course.num_subs}</p>-->
                  <br/>
                 </div>
            {/each}
       
        </div>
  </div>