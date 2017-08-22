# Solar token

This project was created during the hackathon at the [Blockchain summer school in Copenhagen](http://blockchainschool.eu/) on 16-17 August 2017. The idea was to create a P2P marketplace for energy trading.

This repository only implements a simple demo, where residents of a building can vote on whether to approve the installation of the solar panel on their roof. The scenario of the demo is the following:

1. The owner of the building wants to hire a solar panel company to install solar panels, but needs support of the residents.
2. The owner allocates funds in a smart contract initiales the voting.
3. Owners vote. 
4. Only after more than 50% residents approve the project, the solar panel company can withdraw the funds from the smart contract.

The token functionality is not yet implemented.

## Usage

To initialize a project with this example, run `truffle init webpack` inside an empty directory.

## Building and the frontend

1. First run `truffle compile`, then run `truffle migrate` to deploy the contracts onto your network of choice (default "development").
1. Then run `npm run dev` to build the app and serve it on http://localhost:8080

## Possible upgrades

* Use the webpack hotloader to sense when contracts or javascript have been recompiled and rebuild the application. Contributions welcome!

## Common Errors

* **Error: Can't resolve '../build/contracts/MetaCoin.json'**

This means you haven't compiled or migrated your contracts yet. Run `truffle compile` and `truffle migrate` first.

Full error:

```
ERROR in ./app/main.js
Module not found: Error: Can't resolve '../build/contracts/MetaCoin.json' in '/Users/tim/Documents/workspace/Consensys/test3/app'
 @ ./app/main.js 11:16-59
```
