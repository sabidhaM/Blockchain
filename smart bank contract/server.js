require('dotenv').config();
const ethers = require('ethers');
const { Network, Alchemy } = require('alchemy-sdk');
const { Contract } = require('@ethersproject/contracts');
const express = require("express");
const app =express();
app.use(express.json());




async function main() {
    const tokenAddress = "0xD8Eeb5D1D1E84E40311359ec65739Acff6774C97"
    const settings = {
        apiKey: '4Mlupd-cA7x125ipUlkHBhVuoHRKpr55', // Replace with your Alchemy API Key.
        network: Network.ETH_SEPOLIA, // Replace with your network.
      };
    const alchemy = new Alchemy(settings);
    alchemy.core.getBlockNumber("0xD8Eeb5D1D1E84E40311359ec65739Acff6774C97").then(console.log);
    //Get token metadata with Alchemy API endpoint
    const metadata = await alchemy.core.getTokenMetadata(tokenAddress);
    console.log("TOKEN METADATA:");
    console.log(metadata);

    app.get('/contract/:address', async (req, res)=>{
        const {address} = req.params;
        try {
            const contractInfo = await alchemy.core.getTokenMetadata(tokenAddress);
            res.json(contractInfo);
        } catch (error) {
            res.status(500).send(error.message);
        }
     }); 

    

}
main()

app.listen(3002, ()=> {
    console.log('server is running on port 3002');
})
