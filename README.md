# Solar token

This project was created during the hackathon at the [Blockchain summer school in Copenhagen](http://blockchainschool.eu/) on 16-17 August and presented on 18 August 2017 ([video](https://www.youtube.com/watch?v=ZDm7V16NNpo)). The idea was to create a P2P marketplace for energy trading.

This repository only implements a simple demo, where residents of a building can vote on whether to approve the installation of the solar panel on their roof. The scenario of the demo is the following:

1. The owner of the building wants to hire a solar panel company to install solar panels, but needs support of the residents.
2. The owner allocates funds in a smart contract initiales the voting.
3. Owners vote. 
4. Only after more than 50% residents approve the project, the solar panel company can withdraw the funds from the smart contract.

The token functionality is not yet implemented.

## Usage

Addresses are hard-coded (it's a hackathon, after all). To try the demo, you have to initialize both testrpc (`testrpc -m "twelve words seed"`) and Metamask ("Import existing DEN") with the same seed (see `seed.txt`). 

1. First run `truffle compile`, then run `truffle migrate` to deploy the contracts onto your network of choice (default "development").
1. Then run `npm run dev` to build the app and serve it on http://localhost:8080

