<script>
    // import Calculator from "svelte-calculator";
    /*let total = 0;
    let console = "";
    let state = null;

    function resolveState(){
          switch(state){
            case "add":
                total += parseFloat(console);
                console = "0";
                break;

            case "substract":
                total -= parseFloat(console);
                console = "0";
                break;

            case "multiply":
                total *= parseFloat(console);
                console = "0";
                break;

            case "divide":
                total /= parseFloat(console);
                console = "0";
                break;

            default:
                total = parseFloat(console);
                console = "0";
                break;
          }
    }

    function setOperation(operation){
            resolveState();
            state = operation;

    }

    function setValue(value){
        if(console.toString() == "0" || state == "equal"){
            console = "";
        }
        if(state == "equal"){
            state = null;
        }
        if(value == "C"){
            total = 0;
            state = null;
            console = "";
            return;
        }
        console = console + value;

    }
    function equal(){
        resolveState();
        console = total;
        state = "equal";
    }*/
</script>
<div
class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0"
>
<div class="rounded-t bg-white mb-0 px-6 py-6">
  <div class="text-center flex justify-between">
    <h6 class="text-blueGray-700 text-xl font-bold">Calculator</h6>
  </div>
</div>
<div class="flex-auto px-4 lg:px-10 py-10 pt-0">
   <!-- <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>-->
<!--<div class = "calculator">
    <input type="text" bind:value={console} readonly="true" />
    <div class="buttons">
        <div class="operations">
            <button on:click={()=>{setOperation('add');}}>
               +
            </button>
            <button on:click={()=>{setOperation('substract');}}>
                -
             </button>
             <button on:click={()=>{setOperation('multiply');}}>
                &times;
             </button>
             <button on:click={()=>{setOperation('division');}}>
                &divide;
             </button>
        </div>
        <div class="numbers">
            <div>
                <button on:click={()=>{setValue(7);}}>
                    7
                 </button>
                 <button on:click={()=>{setValue(8);}}>
                    8
                 </button>
                 <button on:click={()=>{setValue(9);}}>
                    9
                 </button>
            </div>
            <div>
                <button on:click={()=>{setValue(4);}}>
                    4
                 </button>
                 <button on:click={()=>{setValue(5);}}>
                    5
                 </button>
                 <button on:click={()=>{setValue(6);}}>
                    6
                 </button>
            </div>
            <div>
                <button on:click={()=>{setValue(1);}}>
                    1
                 </button>
                 <button on:click={()=>{setValue(2);}}>
                    2
                 </button>
                 <button on:click={()=>{setValue(3);}}>
                    3
                 </button>
            </div>
            <div>
                <button on:click={()=>{setValue(0);}}>
                    0
                 </button>
                 <button on:click={()=>{setValue('.');}}>
                    .
                 </button>
                 <button on:click={()=>{setValue('C');}}>
                    C
                 </button>
            </div>

        </div>
        <div class="equal">
            <button on:click={equal}>
               =
            </button>

        </div>

    </div>
</div>-->
<!-- <Calculator
  size={"200"}
  normalKeyColor="white"
  operatorKeyColor="red"
  Class={"calculatorClass"}
  animation={true}
  calculatorBackground={"rgba(0,0,0,0.1)"}
  inputBackground={"#DDE5B6"}
/> -->
</div>
</div>

<style>
    /*.calculator{
        position: relative;
        top: 100%;
        left: 50%;
        transform: translate(-50%,-50%);
        width: 100%;
        height: 400%;
        border: 2px solid rgb(225, 225, 225);
        box-shadow: 2px 2px 2px #eee;
        padding: 10px;
    }

    .calculator input{
        width: 100%;
        padding: 20px;
        outline: none;
        text-align: right;
        border: 2px solid rgba(225, 225, 225, 0);
        font-size: 20px;
    }

    .calculator .buttons{
        display: flex;
        flex-wrap: wrap;
    }

    .calculator .buttons .operations{
        display: flex;
        justify-content: space-between;
        width: 100%;
    }

    .calculator .buttons .operations button {
        width:100%;
        background: black;
        color: white;
    }

    .calculator .buttons .numbers {
        width: 75%;
        background: black;
        color: white;
    }

    .calculator .buttons .numbers > div {
        display: flex;
        justify-content: space-between;
    }
    .calculator .buttons .numbers > div button{
        width: 32%;
    }

    .calculator .equal {
        flex:1;
    }

    .calculator .equal button {
        margin-left: 5%;
        width: 95%;
        height: 95%;
        background: #ee003b;
        color: #eee;
    }

    .calculator button {
        outline: none;
    }*/
</style>