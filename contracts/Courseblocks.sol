//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

// import "./Student.sol";
// import "./Instructor.sol";
import "./SaiCreditToken.sol";
// import "./AccessControl.sol";

contract Courseblocks is SaiCreditToken{
//     Student public student1;
//     Instructor public instructor1;
    SaiCreditToken public saitoken;
//     AccessControl public access;

//    constructor(address _saitoken,address _access,address _student,address _instructor){
//         saitoken = SaiCreditToken(_saitoken);
//         access = AccessControl(_access);
//         student1 = Student(_student);
//         instructor1 = Instructor(_instructor);
//     }
   constructor(address _saitoken){
        saitoken = SaiCreditToken(_saitoken);
    }
    struct Course {
        uint256 id;
        string name;
        string description;
        string author_name;
        address author_id;
        uint256 price;
        uint256 users;
        uint256 deadline;
        string thumbnail_hash;
        string file_hash;
        string[] assignment_hash;
    }

    struct StudentCourse{
        uint256[] courses_id;
        uint256[] courses_deadline;
        uint256[] marks;
        string[] submission_hash;
        mapping(uint256 => bool) bought;
    }

    uint256 studentCount;
    uint256 educatorCount;
    uint256 public courseCount;


    mapping(uint256 => Course) courses;
    mapping(address => StudentCourse) students;
    mapping(address => bool) hasAccount;
    mapping(address =>  mapping(uint256 => Course)) instrCourseIDs;
    mapping(address => uint256) instrCourseCount;

    function addCourse(
        string memory n,
        string memory desc,
        string memory auth,
        uint256 p,
        uint256 d,
        address e_id
    ) public {
       // require(access.hasInstrRoleWADD(e_id), "Not authorized to add course"); //check if it's an Educator account
        courses[courseCount].id = courseCount;
        courses[courseCount].name = n;
        courses[courseCount].description = desc;
        courses[courseCount].author_name = auth;
        courses[courseCount].author_id = e_id;
        courses[courseCount].price = p;
        courses[courseCount].users = 0;
        courses[courseCount].deadline = d * 1 days;
        instrCourseIDs[e_id][courseCount] = courses[courseCount];
        instrCourseCount[e_id]++;
        courseCount++;
        //adding course ID to educator struct
       // instructor1.addCourseID(e_id,courseCount);
    }

    function buyCourse(
        address s_id,
        uint256 c_id,
        uint256 _time
    ) public {
        // require(access.hasStudRoleWADD(s_id), "Not authorized to buy course"); //check if it's a Student account
        courses[c_id].users++;
        students[s_id].courses_id.push(c_id);
        students[s_id].courses_deadline.push(courses[c_id].deadline + _time);
        students[s_id].marks.push(0); //initializing marks for course
        students[s_id].bought[c_id] = true;
        // student1.addCourseID(s_id, c_id);
        // student1.addDeadline(s_id, courses[c_id].deadline + _time);
        // saitoken.transferFrom(s_id, e_id, courses[c_id].price);
        // student1.addMarks(s_id, 0); //initializing marks for course
    }

    function boughtornot(address s_id,uint256 c_id) public view returns(bool) {
        return students[s_id].bought[c_id];
    }

    function getauthID(uint256 c_id) public view returns(address) {
        return courses[c_id].author_id;
    }

    function reviewAssignment(
        address s_id,
        uint256 c_id,
        uint256 _m
    ) public returns(string memory){
         uint256 totalCourses = students[s_id].courses_id.length;
        for (uint256 i = 0; i < totalCourses; i++) {
            if (students[s_id].courses_id[i] == c_id) {
                students[s_id].marks[i] = _m;
            }
        }
        if (_m >= 90) {
            saitoken.transfer(s_id, 20);
            // return 20;
        } else if (_m >= 80) {
            saitoken.transfer(s_id, 10);
            // return 10;
        } else if (_m >= 70) {
            saitoken.transfer(s_id, 5);
            // return 5;
        } else if (_m < 40) {
            revert("Sorry, you have failed.");
        }
        // require(access.hasInstrRoleWADD(msg.sender), "Not authorized to review course"); //only educator can review assignments
        // uint256 totalCourses = student1.getTotalCourses(s_id);
        // for (uint256 i = 0; i < totalCourses; i++) {
        //     if (student1.getCourseID(s_id, i) == c_id) {
        //         student1.addMarksWI(s_id, _m, i);
        //     }
        // }
        // if (_m >= 90) {
        //     saitoken.transfer(s_id, 20);
        // } else if (_m >= 80) {
        //     saitoken.transfer(s_id, 10);
        // } else if (_m >= 70) {
        //     saitoken.transfer(s_id, 5);
        // } else if (_m < 40) {
        //     revert("Sorry, you have failed.");
        // }
        return "Assignment reviewed successfully";
    }

    function submitAssignment(
        address s_id,
        uint256 c_id,
        uint256 _time,
        string memory _hash
    ) public returns (bool bol) {
         uint256 totalCourses = students[s_id].courses_id.length;
        for (uint256 i = 0; i < totalCourses; i++) {
            if (students[s_id].courses_id[i] == c_id) {
                if (_time <= students[s_id].courses_deadline[i]) {
                    bol = true;
                    students[s_id].submission_hash.push(_hash);
                    return (true);
                }
                //if deadline passed,set marks=0
                else {
                    students[s_id].marks[i] = 0;
                    bol = false;
                    return (false);
                }
            }
        }
        // require(access.hasStudRoleWADD(s_id), "Not authorized to submit course"); //check if it's a Student account
        // uint256 totalCourses = student1.getTotalCourses(s_id);
        // for (uint256 i = 0; i < totalCourses; i++) {
        //     if (student1.getCourseID(s_id, i) == c_id) {
        //         if (_time <= student1.getDeadline(s_id,i)) {
        //             return (true);
        //         }
        //         //if deadline passed,set marks=0
        //         else {
        //             student1.addMarksWI(s_id, 0, i);
        //             return (false);
        //         }
        //     }
        // }
    }

    function getCourse(uint256 _id) public view returns (Course memory) {
        return (courses[_id]);
    }

    function getCourseIds(address s_id, uint256 idx) public view returns(uint256){
        return students[s_id].courses_id[idx];
    }

    function getNoCoursesBought(address s_id) public view returns(uint256){
        return students[s_id].courses_id.length;
    }


    function getCourseCount() public view returns (uint256) {
        return (courseCount);
    }

     function setThumbhash(string memory _hash)public returns(string memory){
        courses[courseCount].thumbnail_hash = _hash;
        return "IPFS hash added successfully";

    }

     function getThumbHash(uint256 c_id) public view returns (string memory) {
        return courses[c_id].thumbnail_hash;
    }

    function setFilehash(string memory _hash)public returns(string memory){
        courses[courseCount].file_hash = _hash;
        return "IPFS hash added successfully";

    }

     function getFileHash(uint256 c_id) public view returns (string memory) {
        return courses[c_id].file_hash;
    } 
    function getName(uint256 c_id) public view returns (string memory) {
        return courses[c_id].name;
    } 

    function getDesc(uint256 c_id) public view returns (string memory) {
        return courses[c_id].description;
    } 

    function getAuthName(uint256 c_id) public view returns (string memory) {
        return courses[c_id].author_name;
    }

    function getUsers(uint256 c_id) public view returns (uint256) {
        return courses[c_id].users;
    }  

    function getPrice(uint256 c_id) public view returns (uint256) {
        return courses[c_id].price;
    } 

    function setAssignmentHash(string memory _hash)public returns(string memory){
        courses[courseCount].assignment_hash.push(_hash);
        return "IPFS hash added successfully";

    }
    function setSubmissionHah(address s_id,string memory _hash) public returns(string memory) {
        students[s_id].submission_hash.push(_hash);
        return "IPFS hash added successfully";
    }

     function getSubmissionHah(address s_id) public view returns(string memory) {
        return students[s_id].submission_hash[0];
    }

    function getAssignmentHash(uint256 c_id)public view returns(string memory){
        return courses[c_id].assignment_hash[0];
    }

    function getNoAssignments(uint256 c_id) public view returns(uint256){
        return courses[c_id].assignment_hash.length;
    }


}