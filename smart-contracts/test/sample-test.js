const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Gas test", function () {
  it("Should return the the new tokenId", async function () {
    //DEPLOY COLLECTIONBASE
    const baseFactory = await hre.ethers.getContractFactory('CollectionBase');
    const baseContract = await baseFactory.deploy();
    await baseContract.deployed();
    //DEPLOY FACTORY
    const facFactory = await hre.ethers.getContractFactory('Factory');
    const facContract = await facFactory.deploy();
    await facContract.deployed();
    //DEPLOY ANCIENT
    const dataFactory = await hre.ethers.getContractFactory('AncientData');
    const dataContract = await dataFactory.deploy();
    await dataContract.deployed();
    //DEPLOY IDE
    const asterIDEFactory = await hre.ethers.getContractFactory('AsterIDE');
    const ideContract = await asterIDEFactory.deploy();
    await ideContract.deployed();

    //DEPLOY SVGs
    const asterSVGFactory = await hre.ethers.getContractFactory('SymbolsSVGs1');
    const svgContract = await asterSVGFactory.deploy();
    await svgContract.deployed();

    //DEPLOY METADATA
    const asterMetadataFactory = await hre.ethers.getContractFactory('AsterMetadata');
    const metadataContract = await asterMetadataFactory.deploy(svgContract.address);
    await metadataContract.deployed();

    //DEPLOY ANCIENT CONTRACT
    const ancientFactory = await hre.ethers.getContractFactory('Aster');
    const ancientContract = await ancientFactory.deploy(facContract.address, dataContract.address, ideContract.address, metadataContract.address);
    await ancientContract.deployed();

    /*
    await ethers.provider.send('evm_increaseTime', [1649841314]);
    await ethers.provider.send('evm_mine');
    */



    //mint artifact
    let struct = {symbols: [1, 2, 3, 4], values1: [0, 3, 4], values2: [1, 12, 34, 55], values3: [1], values4: [2, 3], keyTokenAddress: facContract.address, useStellarClock: true};
    let txn0 = await ancientContract.programmingV1(struct);
    await txn0.wait();

    /*
    expect(await ancientContract.nextToken()).to.equal(2);

    let rs = await ancientContract.nextToken();
    console.log("TOKEN: ", rs);
    */

    let tokenUri = await ancientContract.tokenURI(1);
    console.log("TOKEN: ", tokenUri)
  });
});
