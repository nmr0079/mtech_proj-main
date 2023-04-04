//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BloomFilter.sol";


contract AccessControl {
    event GRANTROLE(bytes32 indexed role, address indexed account);
    event REVOKEROLE(bytes32 indexed role, address indexed account);
    event GROUPGRANTROLE(bytes32 indexed role, uint256 number);
    //role => account => bool
    mapping(bytes32 => mapping(address => bool)) public roles;
    //bytes32 instead of string because it saves gas
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 private constant STUDENT = keccak256(abi.encodePacked("STUDENT"));
    bytes32 private constant INSTRUCTOR = keccak256(abi.encodePacked("INSTRUCTOR"));

    using BloomFilter for BloomFilter.Filter;
    BloomFilter.Filter filter;

    modifier onlyRole(bytes32 _role) {
            require(roles[_role][msg.sender], "not authorized");
            _;
    }

    constructor() {
        _grantRole(ADMIN, msg.sender);
        filter.init(100);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GRANTROLE(_role, _account);
    }

    function _grantStuRoleArr(address[] memory _account) external onlyRole(ADMIN){
        uint i = 0;
        uint size = _account.length;
        
        while(i < size){
             bytes32 key = keccak256(abi.encodePacked(_account));
             filter.add(key);
             bool falsePositive = filter.check(key);
             if(roles[STUDENT][_account[i]] == false){
                roles[STUDENT][_account[i]] = true;
                emit GRANTROLE(STUDENT, _account[i]);
             }
            ++i;
        }
        emit GROUPGRANTROLE(STUDENT, size);
    }


    function grantAdminRole() external {
        _grantRole(ADMIN, msg.sender);
    }

    function grantStudRole(address _account) external onlyRole(ADMIN) {
        bytes32 key = keccak256(abi.encodePacked(_account));
        filter.add(key);
        bool falsePositive = filter.check(key);
        require(roles[STUDENT][_account] == false, "Already assigned role");
        _grantRole(STUDENT, _account);
    }

     function revokeStudRole(address _account) external onlyRole(ADMIN) {
        roles[STUDENT][_account] = false;
        emit REVOKEROLE(STUDENT, _account);
    }
 
    function grantInstrRole(address _account) external onlyRole(ADMIN) {
        _grantRole(INSTRUCTOR, _account);
    }

     function revokeInstrRole(address _account) external onlyRole(ADMIN) {
        roles[INSTRUCTOR][_account] = false;
        emit REVOKEROLE(INSTRUCTOR, _account);
    }

    function hasStudRole() external view {
        require(roles[STUDENT][msg.sender], "not an authorized student");
    }

    function hasInstrRole() external view {
        require(roles[INSTRUCTOR][msg.sender], "not an authorized instructor");
    }

    function hasInstrRoleWADD(address _instradd) external view returns(bool) {
        return roles[INSTRUCTOR][_instradd];
    }

    function hasStudRoleWADD(address _studaddr) external view returns(bool) {
        return roles[STUDENT][_studaddr];
    }

}