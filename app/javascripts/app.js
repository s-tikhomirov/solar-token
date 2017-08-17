// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import metacoin_artifacts from '../../build/contracts/Voting.json'

var ROLE_BUILDING_OWNER = 0;
var ROLE_COMPANY = 1;
var ROLE_RESIDENT = 2;
var ids = {
    "0x0120fe6e3aa2c936e6d2f88062b266c46c408f98": {"role": ROLE_BUILDING_OWNER, "name": "Name 1", "approved": false},
    "0xa8fc189694dc8ba03c027d470b77c09b7d13471e": {"role": ROLE_COMPANY, "name": "Name 2", "approved": false},
    "0xdbf73038f3e4a5d27e38004c36dc6ce82165794f": {"role": ROLE_RESIDENT, "name": "Name 3", "approved": false},
    "0x692b50dc6d0021a73ec50fcd3ad78d3c121be360": {"role": ROLE_RESIDENT, "name": "Name 4", "approved": false},
    "0xc396dfc357c849c5e4fbbe1f130eb469675af895": {"role": ROLE_RESIDENT, "name": "Name 5", "approved": false},
    "0x07efc80760137f58a43e44a9bede15da8053d730": {"role": ROLE_RESIDENT, "name": "Name 6", "approved": false},
    "0xfe8699b505180f51966e56f118e66544dea311bd": {"role": ROLE_RESIDENT, "name": "Name 7", "approved": false},
    "0x276ae02aa2710bebc571f3647d64d9b440f998d6": {"role": ROLE_RESIDENT, "name": "Name 8", "approved": false},
    "0x43882f2be5ccf7ba1cf848e202683385d5fb93bb": {"role": ROLE_RESIDENT, "name": "Name 9", "approved": false},
    "0x76c780eb591481c086e1a0574b16c4f52e5aa352": {"role": ROLE_RESIDENT, "name": "Name 10", "approved": false},
};

// MetaCoin is our usable abstraction, which we'll use through the code below.
var MetaCoin = contract(metacoin_artifacts);

// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;

window.App = {
  start: function() {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    MetaCoin.setProvider(web3.currentProvider);

    // Get the initial account balance so it can be displayed.
    web3.eth.getAccounts(function(err, accs) {
      if (err != null) {
        alert("There was an error fetching your accounts.");
        return;
      }

      if (accs.length == 0) {
        alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
        return;
      }

      accounts = accs;
      account = accounts[0];
        
        MetaCoin.deployed().then(function(instance) {
            document.getElementById("contract_addr").innerHTML = instance.address;
            
            console.log(instance);
            instance.state.call({from: account}).then(function(amount) {
                console.log(amount);
            });
        });

      self.updateUI();
      //self.refreshBalance();
    });
  },

    updateUI: function() {
        // Update table
        var residents_table = document.getElementById("residents_table");
        console.log(residents_table);
        for(var id in ids) {
            console.log(id);
        
            if(ids[id].role == ROLE_RESIDENT) {
                var tr = document.createElement("tr");
                var td_name = document.createElement("td");
                var td_shares = document.createElement("td");
                var td_approved = document.createElement("td");
                name = ids[id].name + " (" + id + ")";
                td_name.appendChild(document.createTextNode(name));
                td_shares.appendChild(document.createTextNode(ids[id].shares));
                td_approved.appendChild(document.createTextNode(ids[id].approved));
                tr.appendChild(td_name);
                tr.appendChild(td_shares);
                tr.appendChild(td_approved);
                residents_table.appendChild(tr);
                console.log(tr);
            }
        }
        
      // Get account type
      if(ids[account] !== null) {
          var building_owner_area = document.getElementById("building_owner_area");
          var company_area = document.getElementById("company_area");
          var residents_area = document.getElementById("residents_area");
          building_owner_area.classList.add("hidden");
          company_area.classList.add("hidden");
          residents_area.classList.add("hidden");
          if(ids[account].role === ROLE_BUILDING_OWNER) {
              building_owner_area.classList.remove("hidden");
          } else if(ids[account].role === ROLE_COMPANY) {
              company_area.classList.remove("hidden");
          } else if(ids[account].role === ROLE_RESIDENT) {
              residents_area.classList.remove("hidden");
          }
      }
    },

    refreshVoting: function() {
        var self = this;
        var meta;
        MetaCoin.deployed().then(function(instance) {
            meta = instance;
            return meta.getVoting.call({from: account});
        }).then(function(value) {
            console.log(value);
            self.updateUI();
        }).catch(function(e) {
            console.log(e);
        });
    },

    startCampaign: function() {
        var start_campaign_btn = document.getElementById("start_compaign_btn");
        start_campaign_btn.disabled = true;
        
      MetaCoin.deployed().then(function(instance) {
          return instance.startVoting({from: account})
      }).then(function() {
          start_campaign_btn.value = "Campaign started!";
          //self.updateUI();
      }).catch(function(e) {
          console.log(e);
          start_campaign_btn.value = "Error! See log.";
          //self.setStatus("Error sending coin; see log.");
      });
  },

  setStatus: function(message) {
    var status = document.getElementById("status");
    //status.innerHTML = message;
  },

  transfer: function() {
    var self = this;

    var amount = parseInt(document.getElementById("amount").value);
    var receiver = document.getElementById("receiver").value;

    this.setStatus("Initiating transaction... (please wait)");

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.transfer(receiver, amount, {from: account});
    }).then(function() {
      self.setStatus("Transaction complete!");
      self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      self.setStatus("Error sending coin; see log.");
    });
  }
};

window.addEventListener('load', function() {
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn("No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask");
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
  }

  App.start();
});
