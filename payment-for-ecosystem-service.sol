pragma solidity ^0.5.0;
import "github.com/oraclize/ethereum-api/oraclizeAPI_0.5.sol";

// Contract PaymentForEcosystemService is a child of contract usingOraclize to include Oraclize API
contract PaymentForEcosystemServices is usingOraclize {
    
    // Define state variables
    uint constant public payment_for_ecosystem_service = 1 ether;
    uint public percentage_landcover_change;
    address payable constant PES_buyer = 0x2C1179A512156F0d937ce30ef315046e3B9E50Aa;
    address payable constant PES_seller = 0xEEF8Acd8C3530f28b61549fA5012E0A462E8A67F;
    
    // Oraclize callback function
    function __callback(bytes32 _myid, string memory _result) public {
        if(msg.sender != oraclize_cbAddress()) revert();
        percentage_landcover_change = parseInt(_result);
        TransferPES();
    }
    
    // Initialize PES payment by querying the Oraclize computation datasource
    function InitializePES () public payable {
        if(msg.sender != PES_buyer) revert();
        oraclize_query("computation", ["BAisPZsJU/Tkn4zfquD+ByizlGfntI5Ej3qgREdbG3Lt54c6MjG2HgYcNcx6yifbr1Sa3UE33dVlrz3w8xCwIkkgLcd13GQPuLC8m/mWmR0Pv/lMCh8BXNWAMsG3dFLk8m8luccncIwfVjtqNwDNcKqoAk8RqNZT3+2LO5cqxQ=="]);
    }
    
    // Executing the payment and transfer remaining balance back to PES buyer's account
    function TransferPES () internal {
        if (percentage_landcover_change <= 10) {
            PES_seller.transfer(payment_for_ecosystem_service);
        }
        PES_buyer.transfer(address(this).balance);
    }
    
    
}
