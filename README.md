# Cosmos Chain [![Build Status](https://travis-ci.org/elidoran/cosmos-chain.svg?branch=master)](https://travis-ci.org/elidoran/cosmos-chain)

Maintain ordered chains of actions in a Meteor app.

## Install

    $ meteor add cosmos:chain


## API

### new Chain(options)

Create a chain instance which will maintain actions in order as they are added/removed.

Options:

1. `type`: `chain` or `pipeline` depending on which kind of actions you want. See [chain-builder module](http://www.npmjs.com/package/chain-builder) for more information on the difference between the two types.

### chain.add(fn)

Add a function to the chain. The ordering of the chain is specified by options set on each function added to the chain.

1. `id`: a unique identifier for the function within the chain
2. `before`: the IDs of the functions it should be *before*
3. `after`: the IDs of the functions it should be *after*

You may avoid setting an `id` when passing a *named function*. It will use the functions `name`.

See [ordering module](https://www.npmjs.com/package/ordering) for more details and examples.

### chain.remove(fn/id)

Remove a function from the chain. Parameter is either the function object or the ID in its `options` object.

### chain.execute(context)

Runs the chain's member functions providing the specified `context` to the chain.

See [chain-builder module](http://www.npmjs.com/package/chain-builder) for more details on how to write your functions and how the context is used and the `this` value. Also tells the differences when using a *pipeline* instead of the usual *chain of command*.

## MIT License
