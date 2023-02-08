const Student = artifacts.require("Student");
//const RoleAssign  = artifacts.require("RoleAssign");
const SaiCreditToken = artifacts.require('SaiCreditToken');
const AccessControl = artifacts.require('AccessControl');
const BloomFilter = artifacts.require('BloomFilter');
const NFT = artifacts.require('NFT');
const Marketplace = artifacts.require('Marketplace')

module.exports = async function (deployer) {
  await deployer.deploy(Student);
  await deployer.deploy(SaiCreditToken);
  await deployer.deploy(BloomFilter);
  await deployer.deploy(AccessControl);
  await deployer.deploy(NFT);
  await deployer.deploy(Marketplace, 1);

  const student = await Student.deployed();
  const saicredittoken = await SaiCreditToken.deployed();
  const bloomfilter = await BloomFilter.deployed();
  const accesscontrol = await AccessControl.deployed();
  const nft = await NFT.deployed();
  const marketplace = await Marketplace.deployed();

  saveFrontendFiles(nft, "NFT");
  saveFrontendFiles(marketplace, "Marketplace");
  saveFrontendFiles(student, "Student");
  saveFrontendFiles(saicredittoken, "SaiCreditToken");
  saveFrontendFiles(bloomfilter, "BloomFilter");
  saveFrontendFiles(accesscontrol, "AccessControl");
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