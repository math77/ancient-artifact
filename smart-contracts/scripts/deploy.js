async function main () {

  //DEPLOY COLLECTIONBASE

  const baseFactory = await hre.ethers.getContractFactory('CollectionBase');
  const baseContract = await baseFactory.deploy();

  await baseContract.deployed();


  //DEPLOY FACTORY
  const facFactory = await hre.ethers.getContractFactory('Factory');
  const facContract = await facFactory.deploy();

  await facContract.deployed();


  //DEPLOY ANCIENT CONTRACT
  const ancientFactory = await hre.ethers.getContractFactory('Aster');
  const ancientContract = await ancientFactory.deploy(facContract.address);

  await ancientContract.deployed();

  console.log("CONTRACTS DEPLOYED TO");
  console.log("--------------------------------------------------------");

  console.log("Ancient: ", ancientContract.address);
  console.log("CollectionBase: ", baseContract.address);
  console.log("Factory: ", facContract.address);

  //mint artifact
  let txn0 = await ancientContract.claim({value: ethers.utils.parseEther("0.00001")});
  await txn0.wait();

  //mint artwork
  /*
  let txn1 = await ancientContract.newComb({value: ethers.utils.parseEther("0.00001")});
  await txn1.wait();

  let txn2 = await ancientContract.getToken({value: ethers.utils.parseEther("0.00001")});
  await txn2.wait();


  let res = await ancientContract.getResults();
  */

  console.log("RESULTS: ", res);
}


main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
