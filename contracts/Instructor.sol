// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Instructor{

    struct instructor {
        string name;
        string designation;
        string city;
        string email;
        address[] studentaccessList;
        int256[] courses_id;
        string about_hash;
        string prof_pic_hash;
        //address[] certAccessList;
        string record_hash;
        
    }

    address owner_p;
    address[] public p_List;
    uint public instructorsCount;

  //  mapping (address => student) public instructorInfo;
  mapping (address => instructor) public instructorInfo;

    mapping (address => bool) public students;
     
    mapping (address => bool) public teachers;

    mapping (address => bool) public university;

  //  mapping(address => mapping(string => string)) prescriptions;

    event detailsAdded(address _student, string message);
    event accessGiven(address _teacher, string message);
    event accessRevoked(address _teacher, string message);
    event prescrAdded(address _teacher, string message);

     modifier only_owner(){
        require(owner_p == msg.sender);
        _;
    }

    constructor() {
        owner_p = msg.sender;
        //studentsCount = 0;
    }
    
    function addDetails(string memory _name, string memory _des, string memory _city) public returns (string memory)
    {
        instructor memory p;
        p.name = _name;
        p.designation = _des;
        p.city = _city;
        instructorInfo[msg.sender] = p;
        //p_List.push(msg.sender)-1;
        //p_List[studentsCount] = msg.sender;
        instructorsCount++;
        teachers[msg.sender] = true;

        emit detailsAdded(msg.sender, "Student has been added successfully");
        return "Student Registration complete";
    }

    function addCourseID(address e_id,int256 _c_id) public returns (string memory){
        instructorInfo[e_id].courses_id.push(_c_id);
        return "Added course id";
    }

    function getinstrDet(address paddr) view public returns (string memory, string memory, string memory, string memory) {
        return (instructorInfo[paddr].name,instructorInfo[paddr].designation,instructorInfo[paddr].city,instructorInfo[paddr].record_hash);
    }
    
    function giveAccess(address _teacher_address) public returns (string memory) {
       
        require(teachers[_teacher_address] == false, "Access already given to the teacher");
        teachers[_teacher_address] = true;
        //instructorInfo[msg.sender].teacherAccessList.push(_teacher_address)-1;
        //an event can be added
        emit accessGiven(_teacher_address, "Access given to the above addressed teacher");
        return "Access granted";
    }
    
    function getInstrName(address e_id) public view returns(string memory) {
        return instructorInfo[e_id].name;
    }
    // //only owner is removed temporarily
    // function revokeAccess(address _teacher_address) public returns (string memory) {
       
    //     //if(teachers[_teacher_address]){
    //     //    teachers[_teacher_address] = false;
    //     //}
    //     require(teachers[_teacher_address] == true, "The teacher doesn't have any access");
    //     teachers[_teacher_address] = false;
    //     instructorInfo[msg.sender].teacherAccessList.pop();
    //     //can add an event
    //     emit accessRevoked(_teacher_address, "Access has been revoked from the teacher");
    //     return "Access is revoked";
    // }

    // function getAccessList(address paddr) view public returns (address[] memory){
    //     return instructorInfo[paddr].teacherAccessList;
    // }

//     /*function getPhAccessList(address paddr) view public returns (address[] memory){
//         return instructorInfo[paddr].prescAccessList;
//     }*/

//     /*function getHash(address paddr, address _teacher_address) public view returns (string memory) {
//         require(teachers[_teacher_address] == true, "The teacher doesn't have any access");
//         return instructorInfo[paddr].record_hash;
//     }

//    /* function addPrescriptions(address daddr, string memory disease_name, string memory medications) public returns(string memory){
//         require(teachers[daddr] == true, "The teacher doesn't have the permission to give out prescriptions");
//         prescriptions[daddr][disease_name] = medications;
//         emit prescrAdded(daddr, 'Prescriptions added');
//         return 'Prescriptions added';

//     }*/

//     /*function giveAccessPrescr(address _pharma_address) public returns (string memory) {
//         require(pharmacy[_pharma_address] == false, "Access to the prescriptions already given to the pharmacy");
//         pharmacy[_pharma_address] = true;
//         instructorInfo[msg.sender].prescAccessList.push(_pharma_address)-1;
//         //an event can be added
//         emit accessGiven(_pharma_address, "Access to the prescriptions given to the above addressed pharmacy");
//         return "Access granted";
//     }

//     function revokeAccessPrescr(address _pharma_address) public returns (string memory) {
//         require(pharmacy[_pharma_address] == true, "This particular pharmacy doesn't have any access");
//         pharmacy[_pharma_address] = false;
//         instructorInfo[msg.sender].prescAccessList.pop();
//         //can add an event
//         emit accessRevoked(_pharma_address, "Access has been revoked from the pharmacy");
//         return "Access is revoked";
//     }

//     function getPrescriptions(address _doc_addr, address _ph_addr, string memory _disease_name) public view returns (string memory){
//          require(pharmacy[_ph_addr] == true, "The pharmacy doesn't have the permission to access the prescriptions");
//          return prescriptions[_doc_addr][_disease_name];   
//     }*/

//  /*   function setIPFShash(string memory _hash)public returns(string memory){
//         instructorInfo[msg.sender].record_hash = _hash;
//         return "IPFS hash added successfully";

//     }

     function getIPFSHash() public view returns (string memory) {
        return instructorInfo[msg.sender].record_hash;
    }

  
    function setIPFShash(string memory _hash)public returns(string memory){
        instructorInfo[msg.sender].record_hash = _hash;
        return "IPFS hash added successfully";

    }

    function setabouthash(string memory _hash)public returns(string memory){
        instructorInfo[msg.sender].about_hash = _hash;
        return "IPFS hash added successfully";

    }

     function getaboutHash() public view returns (string memory) {
        return instructorInfo[msg.sender].about_hash;
    }

     function setprofpichash(string memory _hash)public returns(string memory){
        instructorInfo[msg.sender].prof_pic_hash = _hash;
        return "IPFS hash added successfully";

    }

     function getprofpictHash() public view returns (string memory) {
        return instructorInfo[msg.sender].prof_pic_hash;
    }
 }

// contract Student {
//     function addDetails(string memory _name, uint _age, string memory _city) public returns (string memory);
//     function getstudentDet(address paddr) view public returns (string memory, uint, string memory, string memory);
//     function getAccessList(address paddr) view public returns (address[] memory);
//     function getHash(address paddr, address _teacher_address) public view returns (string memory);
//     function setIPFShash(string memory _hash)public returns(string memory);

// }