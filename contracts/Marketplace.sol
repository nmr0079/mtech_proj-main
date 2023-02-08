//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "../notus-svelte-main/node_modules/@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "../notus-svelte-main/node_modules/@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Marketplace is ReentrancyGuard {
    //state variables
    address payable public immutable feeAccount; //the account that receives fees
    uint public immutable feePercent; //the fee percentage on sales
    uint public itemCount;

    struct Item {
        uint itemId;
        IERC721 nft; //an instance of the nft contract
        uint tokenId;
        uint price;
        address payable seller;
        bool sold;

    }

    event Offered(
        uint _itemId,
        address indexed nft,
        uint _tokenId,
        uint price,
        address indexed seller

    );

     event Bought(
        uint _itemId,
        address indexed nft,
        uint _tokenId,
        uint price,
        address indexed seller,
        address indexed buyer

    );


    //itemId -> Item
    mapping(uint => Item) public items;

    constructor(uint _feePercent) {
        feeAccount = payable(msg.sender);
        feePercent = _feePercent;

    }

    function makeItems(IERC721 _nft, uint _tokenId,uint _price) external nonReentrant {
        require(_price > 0, "price must be greater than 0");
        //increment itemcount
        itemCount += 1;
        //transfer nft
        _nft.transferFrom(msg.sender, address(this), _tokenId);
        //add new items to the items mapping
        items[itemCount] = Item (
            itemCount,
            _nft,
            _tokenId,
            _price,
            payable(msg.sender),
            false
        );

        emit Offered( itemCount,address(_nft),_tokenId,_price,msg.sender);

    }

    function purchaseItem(uint _itemId) external payable nonReentrant {
        uint totalPrice = getTotalPrice(_itemId);
        Item storage item = items[_itemId];
        require(_itemId > 0 && _itemId <= itemCount, "item doesn't exist");
        require(msg.value >= totalPrice, "not enough ether to cover the nft price and market fee");
        require(!item.sold, "item is already sold");

        //pay seller and feeAccount
        item.seller.transfer(item.price);
        feeAccount.transfer(totalPrice - item.price);

        //update the item as sold
        item.sold = true;

        //transfer nft to buyer
        item.nft.transferFrom(address(this), msg.sender, item.tokenId);

        //emit a bought event
        emit Bought( _itemId,address(item.nft),item.tokenId, item.price,item.seller,msg.sender);
    }

    function getTotalPrice(uint _itemId) view public returns(uint){
        return (items[_itemId].price * ( 100 * feePercent ) / 100);
    }

}