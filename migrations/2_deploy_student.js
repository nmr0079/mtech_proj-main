const Student = artifacts.require("Student");
//const RoleAssign  = artifacts.require("RoleAssign");
const SaiCreditToken = artifacts.require('SaiCreditToken');
const AccessControl = artifacts.require('AccessControl');
const BloomFilter = artifacts.require('BloomFilter');
const NFT = artifacts.require('NFT');
const Marketplace = artifacts.require('Marketplace')
const Courseblocks = artifacts.require('Courseblocks')
const Instructor = artifacts.require('Instructor')
const CourseRecommender = artifacts.require('CourseRecommender')

module.exports = async function (deployer) {
  await deployer.deploy(Student);
  await deployer.deploy(SaiCreditToken);
  await deployer.deploy(BloomFilter);
  await deployer.deploy(AccessControl);
  await deployer.deploy(NFT);
  await deployer.deploy(Marketplace, 1);
  await deployer.deploy(Instructor);
  await deployer.deploy(Courseblocks);
  await deployer.deploy(CourseRecommender);

  const student = await Student.deployed();
  const saicredittoken = await SaiCreditToken.deployed();
  const bloomfilter = await BloomFilter.deployed();
  const accesscontrol = await AccessControl.deployed();
  const nft = await NFT.deployed();
  const marketplace = await Marketplace.deployed();
  const instructor = await Instructor.deployed();
  const courseblocks = await Courseblocks.deployed();
  const courserecommender = await CourseRecommender.deployed();

  saveFrontendFiles(nft, "NFT");
  saveFrontendFiles(marketplace, "Marketplace");
  saveFrontendFiles(student, "Student");
  saveFrontendFiles(saicredittoken, "SaiCreditToken");
  saveFrontendFiles(bloomfilter, "BloomFilter");
  saveFrontendFiles(accesscontrol, "AccessControl");
  saveFrontendFiles(instructor, "Instructor");
  saveFrontendFiles(courseblocks, "Courseblocks");
  saveFrontendFiles(courserecommender, "CourseRecommender");
  console.log("NFT contract address " ,nft.address);
  console.log("Marketplace contract address ", marketplace.address);
};

function saveFrontendFiles(contract, name) {
  var fs = require("fs");
  const contractsDir = "../notus-svelte-main/contractsData";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + `/${name}-address.json`,
    JSON.stringify({ address: contract.address }, undefined, 2)
  );

  // const contractArtifact = artifacts.readArtifactSync(name);

  // fs.writeFileSync(
  //   contractsDir + `/${name}.json`,
  //   JSON.stringify(contractArtifact, null, 2)
  // );
}