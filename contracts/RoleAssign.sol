// SPDX-License-Identifier: MIT
/*pragma solidity ^0.5.0;
import "../dapp_frontend/node_modules/openzeppelin-contracts/contracts/access/AccessControl.sol";

contract RoleAssign is AccessControl {
    uint256 public studentscount;
    uint256 public teacherscount;
    bytes32 public constant INSTRUCTOR_ROLE = keccak256("INSTRUCTOR_ROLE");
    bytes32 public constant STUDENT_ROLE = keccak256("STUDENT_ROLE");
    bytes32 public constant UNIVERSITY_ROLE = keccak256("UNIVERSITY_ROLE");
    bytes32 public constant COMPANY_ROLE = keccak256("COMPANY_ROLE");

    struct student_reg {
        string name;
        string email;
        address stud_addr;
    }

    struct teacher_reg {
        string name;
        string email;
        address teacher_addr;
    }

     event detailsAdded(address _addr, string message);

    constructor() {
        // Grant the contract deployer the default admin role: it will be able
        // to grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function assignStudentRole(address student) public onlyRole(DEFAULT_ADMIN_ROLE) returns (bool success){
            _setupRole(STUDENT_ROLE, student);
            emit detailsAdded(student, "Role assigned to the student");
            return true;
    }

    function assignTeacherRole(address teacher) public onlyRole(DEFAULT_ADMIN_ROLE) returns (bool success){
            _setupRole(INSTRUCTOR_ROLE, teacher);
            return true;
    }

    function assignUniversityRole(address university) public onlyRole(DEFAULT_ADMIN_ROLE) returns (bool success){
            _setupRole(UNIVERSITY_ROLE, university);
            return true;
    }

    function assignCompanyRole(address company) public onlyRole(DEFAULT_ADMIN_ROLE) returns (bool success){
            _setupRole(COMPANY_ROLE, company);
            return true;
    }

    function studRegistration(address studentaddr,string memory _name,string memory _email) public returns (string memory)
    {
        require(hasRole(STUDENT_ROLE, studentaddr), "Error: must have Student Role");
        student_reg memory s;
        s.name = _name;
        s.email = _email;
        s.stud_addr = studentaddr;
        studentscount++;

        emit detailsAdded(studentaddr, "Student has been added successfully");
        return "Student Registration complete";
    }

    function teacherRegistration(address teacher_addr,string memory _name,string memory _email) public returns (string memory)
    {
        require(hasRole(INSTRUCTOR_ROLE, teacher_addr), "Error: must have Student Role");
        teacher_reg memory t;
        t.name = _name;
        t.email = _email;
        t.teacher_addr = teacher_addr;
        teacherscount++;

        emit detailsAdded(teacher_addr, "Instructor has been added successfully");
        return "Student Registration complete";
    }

    function check_admin(address pub_key) public view returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, pub_key);
    }

    function check_student(address pub_key) public view returns (bool) {
        require(hasRole(STUDENT_ROLE, pub_key), "Error: must have Student Role");
        return true;
    }

}*/