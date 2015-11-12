
Chain = {};
if (Meteor.isServer)
  buildChain = Npm.require('chain-builder');
