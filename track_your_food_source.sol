// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract TrackingTheExactLocationOfShipment{

    enum allQualities {
        PERFECT,
        GOOD,
        NORMAL
    }

    struct packageDetails{
        uint packageId;
        address senderAddress;
        address receiverAddress;
        string foodInsidePackage;
        uint foodQuality;
        string locationOfSenderAddress;
        string locationOfReceiverAddress;
        uint amount;
        bool isDelivered;
    }

    mapping(uint => packageDetails) allPackages;

    packageDetails[] private allPackagesList;

    function shipAPackage(address receiverAddress, string memory foodInsidePackage, uint foodQuality, string memory locationOfSenderAddress, string memory locationOfReceiverAddress, uint amount) public returns(packageDetails memory){
        require(foodQuality < 3, "Food quality can be 0: perfect, 1: good, 2: normal");
        uint packageId = allPackagesList.length + 1;
        allPackagesList.push(packageDetails(packageId, msg.sender, receiverAddress, foodInsidePackage, foodQuality, locationOfSenderAddress, locationOfReceiverAddress, amount, false));
        allPackages[packageId] = packageDetails(packageId, msg.sender, receiverAddress, foodInsidePackage, foodQuality, locationOfSenderAddress, locationOfReceiverAddress, amount, false);
        return allPackages[packageId];
    }

    function getPackageByPackgeId(uint packageId) public view returns(packageDetails memory){
        require(allPackages[packageId].packageId != 0 ,"Package not exists against this pacakge ID");
        require(allPackages[packageId].senderAddress == msg.sender || allPackages[packageId].receiverAddress == msg.sender, "You don't have permision to access this package details");
        return allPackages[packageId];
    }

    function markPackageAsDelivered(uint packageId) public returns(string memory){
        require(allPackages[packageId].packageId != 0 ,"Package not exists against this pacakge ID");
        require(allPackages[packageId].senderAddress == msg.sender || allPackages[packageId].receiverAddress == msg.sender, "You don't have permision to update this package details"); 
        allPackages[packageId].isDelivered = true;
        return "Package successfully marked as delivered";
    }

    // function trackMyAllPackages() public returns(packageDetails[] memory){
    // }

}