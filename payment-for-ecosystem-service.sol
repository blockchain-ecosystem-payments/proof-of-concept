pragma solidity ^0.5.0;
import "github.com/oraclize/ethereum-api/oraclizeAPI_0.5.sol";

// Contract PaymentForEcosystemService is a child of contract usingOraclize to include Oraclize API
contract PaymentForEcosystemServices is usingOraclize {
    
    // Define state variables
    uint constant public payment_for_ecosystem_service = 1 ether;
    uint public percentage_landcover_change;
    address payable constant PES_buyer = 0x37D148701557ae93694b190EA73a5a27e8F0acCc;
    address payable constant PES_seller = 0x8626cb4a28182CbeE8947734FC2Df26dC82086B9;
    
    // Initialize PES payment by querying the Oraclize computation datasource
    function InitializePES () public payable {
        if(msg.sender != PES_buyer) revert();
        oraclize_query(1553008500, "computation", ["BAisPZsJU/Tkn4zfquD+ByizlGfntI5Ej3qgREdbG3Lt54c6MjG2HgYcNcx6yifbr1Sa3UE33dVlrz3w8xCwIkkgLcd13GQPuLC8m/mWmR0Pv/lMCh8BXNWAMsG3dFLk8m8luccncIwfVjtqNwDNcKqoAk8RqNZT3+2LO5cqxQ=="]);
    }
    
    // Oraclize callback function
    function __callback(bytes32 _myid, string memory _result) public {
        if(msg.sender != oraclize_cbAddress()) revert();
        percentage_landcover_change = parseInt(_result);
        TransferPES();
    }
    
    // Executing the payment and transfer remaining balance back to PES buyer's account
    function TransferPES () internal {
        if (percentage_landcover_change <= 10) {
            PES_seller.transfer(payment_for_ecosystem_service);
        }
        PES_buyer.transfer(address(this).balance);
    }
    
    
}
