// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract SolCar {
    struct Customer {
        address customerAddress;
        string name;
        string phoneNum;
    }

    mapping(uint => Customer) public customerInfo;
    address payable public owner;
    address[10] public customers;
    bytes[] private ipfsHashs;

    event LogBuyCar(
        address _customer,
        uint _id
    );

    constructor() public {
        owner =  msg.sender;
        ipfsHashs.push("not-available");
    }

    function uploadContract(bytes memory ipfsHash) public returns(bool success) {
        ipfsHashs.push(ipfsHash);

        return true;
    }

    function buyCar(uint _id, string memory _name, string memory _phoneNumber) public payable {
        require(_id>=0 && _id<=9);
        customers[_id] = msg.sender;
        customerInfo[_id] = Customer(msg.sender, _name, _phoneNumber);

        owner.transfer(msg.value);
        //emit LogBuyRealEstate(msg.sender, _id);        
    }

    function getBuyerInfo(uint _id) public view returns (address, string memory, string memory) {
        Customer memory customer = customerInfo[_id];

        return (customer.customerAddress, customer.name, customer.phoneNum);
    }

    function getAllCustomers() public view returns (address[10] memory) {

        return customers;
    }
}