// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract RBAC {
  event RoleCreated(uint256 role);
  event BearerAdded(address account, uint256 role);
  event BearerRemoved(address account, uint256 role);  uint256 constant NO_ROLE = 0;  
     struct Role {
    string description;
    uint256 admin;
    mapping (address => bool) bearers;
  }  
   uint no_roles = 0;
  Role[] public roles;  
  
  constructor() {
  // addRootRole("NO_ROLE");
  } 


  function addRootRole(string memory _roleDescription)
    public 
    returns(uint256)
  {
    uint256 role = addRole(_roleDescription, roles.length);
    roles[role].bearers[msg.sender] = true;
    emit BearerAdded(msg.sender, role);
    return role;
  } 


  function addRole(string memory _roleDescription, uint256 _admin)
    public
    returns(uint256)
  {
    require(_admin <= roles.length, "Admin role doesn't exist.");
   /*uint256 role = roles.push(
      Role({
        description: _roleDescription,
        admin: _admin
      })
    ) - 1;*/
    Role storage role = roles[no_roles++];
    role.description = _roleDescription;
    role.admin = _admin;
    emit RoleCreated(no_roles-1);
    return no_roles-1;
  }  

  function totalRoles()
    public
    view
    returns(uint256)
  {
    return roles.length - 1;
  }  


  function hasRole(address _account, uint256 _role)
    public
    view
    returns(bool)
  {
    return _role < roles.length && roles[_role].bearers[_account];
  }  
  

  function addBearer(address _account, uint256 _role)
    public
  {
    require(
      _role < roles.length,
      "Role doesn't exist."
    );
    require(
      hasRole(msg.sender, roles[_role].admin),
      "User can't add bearers."
    );
    require(
      !hasRole(_account, _role),
      "Account is bearer of role."
    );    roles[_role].bearers[_account] = true;
    emit BearerAdded(_account, _role);
  } 

   
  function removeBearer(address _account, uint256 _role)
    public
  {
    require(
      _role < roles.length,
      "Role doesn't exist."
    );
    require(
      hasRole(msg.sender, roles[_role].admin),
      "User can't remove bearers."
    );
    require(
      hasRole(_account, _role),
      "Account is not bearer of role."
    );    delete roles[_role].bearers[_account];
    emit BearerRemoved(_account, _role);
  }
   
    function addStudentRole(uint256 _univ_ID) public returns (uint256){
        uint256 studRole_ID = addRole("STUDENT_ROLE", _univ_ID);
        return studRole_ID;
    }
  

  function assignStudentRole(address studentaddr, uint256 _studRole_ID) public{
            addBearer(studentaddr, _studRole_ID);
    }

   function addInstructorRole(uint256 _univ_ID) public returns (uint256){
        uint256 instr_RoleID = addRole("INSTRUCTOR_ROLE", _univ_ID);
        return instr_RoleID;
    }
  

  function assignInstructorRole(address instr_addr, uint256 _instr_RoleID) public{
            addBearer(instr_addr, _instr_RoleID);
    }

    function check_student(address studentaddr,uint256 _studRole_ID) public view returns(bool)
     {    require(hasRole(studentaddr, _studRole_ID),"This Account is not a bearer of STUDENT_ROLE.");
    return true;
    }

     function check_instr(address instraddr,uint256 _instrRole_ID) public view returns(bool)
     {    require(hasRole(instraddr, _instrRole_ID),"This Account is not a bearer of INSTRUCTOR_ROLE.");
    return true;
    }



}