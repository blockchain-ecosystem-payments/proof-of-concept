Schematic diagramm of the proof of concept:

![POC](/images/poc.png)

The proof of concept was deployed on the Ethereum Ropsten testnet under the following addresses:

PES buyer account 
[ 0x37D148701557ae93694b190EA73a5a27e8F0acCc ] (http://ropsten.etherscan.io/address/0x37D148701557ae93694b190EA73a5a27e8F0acCc)
- PES seller account: [0x8626cb4a28182CbeE8947734FC2Df26dC82086B9] (https://ropsten.etherscan.io/address/0x8626cb4a28182cbee8947734fc2df26dc82086b9)
- PES smart contract: [0x213427C10786b5220DDC6149c731a29841d8aDdd] (https://ropsten.etherscan.io/address/0x213427c10786b5220ddc6149c731a29841d8addd)

A test run was executed resulting in the following transactions:

- Initializing PES function: [0xc3ce00fa3445fa207548541608afa5329141a6bcf0ba9ebba6dc39cb6119c50d] (https://ropsten.etherscan.io/tx/0xc3ce00fa3445fa207548541608afa5329141a6bcf0ba9ebba6dc39cb6119c50d)
- Oraclize call-back: [0xc3ce00fa3445fa207548541608afa5329141a6bcf0ba9ebba6dc39cb6119c50d](https://ropsten.etherscan.io/tx/0xc3ce00fa3445fa207548541608afa5329141a6bcf0ba9ebba6dc39cb6119c50d#internal)
- Executing PES transfer and returning leftover balance: [0x71e7075e58ee541214a9015424c7146b11d5c51aafae70039ca2fc9b9fb0d581] (https://ropsten.etherscan.io/tx/0x71e7075e58ee541214a9015424c7146b11d5c51aafae70039ca2fc9b9fb0d581)
