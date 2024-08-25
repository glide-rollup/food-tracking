// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MemberManagement {

    struct MemberInput {
        string name;
        string legalId;
        string addr;
        string email;
        address ethAddress;
    }

    enum MemberType { Manufacturer, Vendor, School, PublicGoods, NormalPeople, Logistics }

    struct Member {
        string name;
        string legalId;
        string addr;
        string email;
        address ethAddress;
        MemberType memberType;
    }

    mapping(address => Member) public members;
    mapping(string => address) public legalIdToAddress;

    function createMember(MemberInput memory input, MemberType _memberType) public {
        members[input.ethAddress] = Member({
            name: input.name,
            legalId: input.legalId,
            addr: input.addr,
            email: input.email,
            ethAddress: input.ethAddress,
            memberType: _memberType
        });
        legalIdToAddress[input.legalId] = input.ethAddress;
    }

    function updateMember(
        address _ethAddress,
        string memory _name,
        string memory _legalId,
        string memory _addr,
        string memory _email
    ) public {
        Member storage member = members[_ethAddress];
        member.name = _name;
        member.legalId = _legalId;
        member.addr = _addr;
        member.email = _email;
    }

    function transferOwnership(address _newOwner) public {
        require(members[msg.sender].ethAddress == msg.sender, "Only owner can transfer ownership");
        members[_newOwner] = members[msg.sender];
        delete members[msg.sender];
    }
}
