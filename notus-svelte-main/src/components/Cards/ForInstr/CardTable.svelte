<script>
  // core components
  import TableDropdown from "components/Dropdowns/TableDropdown.svelte";

  const bootstrap = "../assets/img/english.png";
  const angular = "../assets/img/science.png";
  const sketch = "../assets/img/socialscience.png";
  const react = "../assets/img/economics.png";
  const vue = "../assets/img/computerscience.png";

  const team1 = "../assets/img/student.jpg";
  const team2 = "../assets/img/team-2-800x800.jpg";
  const team3 = "../assets/img/team-3-800x800.jpg";
  const team4 = "../assets/img/team-4-470x470.png";

  // can be one of light or dark
  export let color = "light";
</script>

<div
  class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded {color === 'light' ? 'bg-white' : 'bg-red-800 text-white'}"
>
  <div class="rounded-t mb-0 px-4 py-3 border-0">
    <div class="flex flex-wrap items-center">
      <div class="relative w-full px-4 max-w-full flex-grow flex-1">
        <h3
          class="font-semibold text-lg {color === 'light' ? 'text-blueGray-700' : 'text-white'}"
        >
          Courses Progress Table
        </h3>
      </div>
    </div>
  </div>
  <div class="block w-full overflow-x-auto">
    <!-- Projects table -->
    <table class="items-center w-full bg-transparent border-collapse">
      <thead>
        <tr>
          <th
            class="px-6 align-middle border border-solid py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left {color === 'light' ? 'bg-blueGray-50 text-blueGray-500 border-blueGray-100' : 'bg-red-700 text-red-200 border-red-600'}"
          >
            Subjects
          </th>
         <th
            class="px-6 align-middle border border-solid py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left {color === 'light' ? 'bg-blueGray-50 text-blueGray-500 border-blueGray-100' : 'bg-red-700 text-red-200 border-red-600'}"
          >
            Tokens Awarded
          </th>
          <th
            class="px-6 align-middle border border-solid py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left {color === 'light' ? 'bg-blueGray-50 text-blueGray-500 border-blueGray-100' : 'bg-red-700 text-red-200 border-red-600'}"
          >
            Status
          </th>
          <th
            class="px-6 align-middle border border-solid py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left {color === 'light' ? 'bg-blueGray-50 text-blueGray-500 border-blueGray-100' : 'bg-red-700 text-red-200 border-red-600'}"
          >
            Students
          </th>
          <th
            class="px-6 align-middle border border-solid py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left {color === 'light' ? 'bg-blueGray-50 text-blueGray-500 border-blueGray-100' : 'bg-red-700 text-red-200 border-red-600'}"
          >
            Completion
          </th>
          <th
            class="px-6 align-middle border border-solid py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left {color === 'light' ? 'bg-blueGray-50 text-blueGray-500 border-blueGray-100' : 'bg-red-700 text-red-200 border-red-600'}"
          ></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left flex items-center"
          >
            <img
              src="{bootstrap}"
              class="h-12 w-12 bg-white rounded-full border"
              alt="..."
            />
            <span
              class="ml-3 font-bold {color === 'light' ? 'btext-blueGray-600' : 'text-whit'}"
            >
              English Literature
            </span>
          </th>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            50 SAIETH
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <i class="fas fa-circle text-orange-500 mr-2"></i> pending
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex">
              <img
                src="{team1}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow"
              />
              <img
                src="{team2}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team3}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team4}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex items-center">
              <span class="mr-2">60%</span>
              <div class="relative w-full">
                <div
                  class="overflow-hidden h-2 text-xs flex rounded bg-red-200"
                >
                  <div
                    style="width: 60%;"
                    class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-red-500"
                  ></div>
                </div>
              </div>
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-right"
          >
            <TableDropdown />
          </td>
        </tr>
        <tr>
          <th
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left flex items-center"
          >
            <img
              src="{angular}"
              class="h-12 w-12 bg-white rounded-full border"
              alt="..."
            />
            <span
              class="ml-3 font-bold {color === 'light' ? 'btext-blueGray-600' : 'text-whit'}"
            >
              Science
            </span>
          </th>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            70 SAIETH
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <i class="fas fa-circle text-emerald-500 mr-2"></i>
            completed
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex">
              <img
                src="{team1}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow"
              />
              <img
                src="{team2}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team3}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team4}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex items-center">
              <span class="mr-2">100%</span>
              <div class="relative w-full">
                <div
                  class="overflow-hidden h-2 text-xs flex rounded bg-emerald-200"
                >
                  <div
                    style="width: 100%;"
                    class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-emerald-500"
                  ></div>
                </div>
              </div>
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-right"
          >
            <TableDropdown />
          </td>
        </tr>
        <tr>
          <th
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left flex items-center"
          >
            <img
              src="{sketch}"
              class="h-12 w-12 bg-white rounded-full border"
              alt="..."
            />
            <span
              class="ml-3 font-bold {color === 'light' ? 'btext-blueGray-600' : 'text-whit'}"
            >
              Social Science
            </span>
          </th>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            40 SAIETH
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <i class="fas fa-circle text-red-500 mr-2"></i> delayed
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex">
              <img
                src="{team1}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow"
              />
              <img
                src="{team2}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team3}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team4}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex items-center">
              <span class="mr-2">73%</span>
              <div class="relative w-full">
                <div
                  class="overflow-hidden h-2 text-xs flex rounded bg-red-200"
                >
                  <div
                    style="width: 73%;"
                    class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-red-500"
                  ></div>
                </div>
              </div>
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-right"
          >
            <TableDropdown />
          </td>
        </tr>
        <tr>
          <th
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left flex items-center"
          >
            <img
              src="{react}"
              class="h-12 w-12 bg-white rounded-full border"
              alt="..."
            />
            <span
              class="ml-3 font-bold {color === 'light' ? 'btext-blueGray-600' : 'text-whit'}"
            >
              Economics
            </span>
          </th>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            80 SAIETH
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <i class="fas fa-circle text-teal-500 mr-2"></i> on schedule
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex">
              <img
                src="{team1}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow"
              />
              <img
                src="{team2}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team3}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team4}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex items-center">
              <span class="mr-2">90%</span>
              <div class="relative w-full">
                <div
                  class="overflow-hidden h-2 text-xs flex rounded bg-teal-200"
                >
                  <div
                    style="width: 90%;"
                    class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-teal-500"
                  ></div>
                </div>
              </div>
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-right"
          >
            <TableDropdown />
          </td>
        </tr>
        <tr>
          <th
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left flex items-center"
          >
            <img
              src="{vue}"
              class="h-12 w-12 bg-white rounded-full border"
              alt="..."
            />
            <span
              class="ml-3 font-bold {color === 'light' ? 'btext-blueGray-600' : 'text-whit'}"
            >
              Computer Science
            </span>
          </th>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            60 SAIETH
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <i class="fas fa-circle text-emerald-500 mr-2"></i>
            completed
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex">
              <img
                src="{team1}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow"
              />
              <img
                src="{team2}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team3}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
              <img
                src="{team4}"
                alt="..."
                class="w-10 h-10 rounded-full border-2 border-blueGray-50 shadow -ml-4"
              />
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
          >
            <div class="flex items-center">
              <span class="mr-2">100%</span>
              <div class="relative w-full">
                <div
                  class="overflow-hidden h-2 text-xs flex rounded bg-emerald-200"
                >
                  <div
                    style="width: 100%;"
                    class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-emerald-500"
                  ></div>
                </div>
              </div>
            </div>
          </td>
          <td
            class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-right"
          >
            <TableDropdown />
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
