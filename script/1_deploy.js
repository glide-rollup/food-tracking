// scripts/deploy.js
const { ethers, hre } = require("hardhat"); // Import 'hre' along with 'ethers' for Hardhat runtime environment

async function main() {
    // Get the contract factories
    const ProductManagement = await ethers.getContractFactory("ProductManagement");
    const MemberManagement = await ethers.getContractFactory("MemberManagement");
    const LogisticsManagement = await ethers.getContractFactory("LogisticsManagement");
  
    // Deploy contracts
    const productManagement = await ProductManagement.deploy();
    await productManagement.waitForDeployment();
    console.log("ProductManagement deployed to:",await productManagement.getAddress());
  
    const memberManagement = await MemberManagement.deploy();
    await memberManagement.waitForDeployment();
    console.log("MemberManagement deployed to:",await memberManagement.getAddress());
  
    const logisticsManagement = await LogisticsManagement.deploy();
    await logisticsManagement.waitForDeployment();
    console.log("LogisticsManagement deployed to:",await logisticsManagement.getAddress());
  }
  
  // Main function call
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });