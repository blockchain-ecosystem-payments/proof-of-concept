pragma solidity ^0.5.0;
import "github.com/oraclize/ethereum-api/oraclizeAPI_0.5.sol";

// The contract PaymentForEcosystemService is a child of the contract usingOraclize to import the Oraclize API
contract PaymentForEcosystemServices is usingOraclize {
    
    // State variables
    uint constant public payment_for_ecosystem_service = 1 ether;
    uint public percentage_landcover_change;
    address payable constant PES_buyer = 0x37D148701557ae93694b190EA73a5a27e8F0acCc;
    address payable constant PES_seller = 0x8626cb4a28182CbeE8947734FC2Df26dC82086B9;
    
    // This is the Oraclize callback function
    function __callback(bytes32 _myid, string memory _result) public {
        if(msg.sender != oraclize_cbAddress()) revert();
        percentage_landcover_change = parseInt(_result);
        TransferFunction();
    }
    
    // This function initializes the PES payment by querying the Oraclize computation datasource
    function initialize_PES () public payable {
        if(msg.sender != PES_buyer) revert();
        oraclize_query(1553008500, "computation", ["BAisPZsJU/Tkn4zfquD+ByizlGfntI5Ej3qgREdbG3Lt54c6MjG2HgYcNcx6yifbr1Sa3UE33dVlrz3w8xCwIkkgLcd13GQPuLC8m/mWmR0Pv/lMCh8BXNWAMsG3dFLk8m8luccncIwfVjtqNwDNcKqoAk8RqNZT3+2LO5cqxQ=="]);
    }
    
    // This function executing the payment and transfers the remaining balance back to the PES buyer's account
    function TransferFunction () internal {
        if (percentage_landcover_change <= 10) {
            PES_seller.transfer(payment_for_ecosystem_service);
        }
        PES_buyer.transfer(address(this).balance);
    }
    
    
}
