import { expect } from "chai";
import { Contract, Signer } from "ethers";
import { ethers } from "hardhat";

describe("Token contract", function () {

  let erc721;
  let erc721Contract : Contract;
  
  let owner: Signer;
  let addr1: Signer;





  beforeEach(async function () {



    erc721 = await ethers.getContractFactory("Dna");
    [owner, addr1] = await ethers.getSigners();
    erc721Contract = await erc721.deploy();

    


  });

  describe("main flow", function () {

    it("main flow test", async function () {
      await erc721Contract.connect(owner).setBaseTokenURI("masha/superGirl")
      expect(await erc721Contract.connect(owner).getBaseUri()).to.equal("masha/superGirl")
      await erc721Contract.connect(owner).awardItem(await addr1.getAddress())
      expect(await erc721Contract.ownerOf(1)).equal(await addr1.getAddress())
      await erc721Contract.connect(owner).awardItem(await addr1.getAddress())
      await expect(erc721Contract.connect(owner).mergeDna(1,2)).to.be.revertedWith("not an owner")
      await erc721Contract.connect(addr1).mergeDna(1,2)
      expect(await erc721Contract.ownerOf(3)).equal(await addr1.getAddress())






      


    });
    
  });

 

});