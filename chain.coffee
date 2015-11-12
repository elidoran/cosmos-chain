class Chain

  constructor: () ->
    # build a chain to use
    @_chain = buildChain()
    # we want to reorder the chain's array when fn's are added/removed
    # phantomjs disliked my using: reorder = @_reorder.bind(this), so, use self:
    self = this
    @_chain.on 'add', -> self._reorder()
    @_chain.on 'remove', -> self._reorder()
    # same as for chain-builder above.
    @_orderer  = ordering ? Npm.require 'ordering'

  # TODO: allow (string, action) to specify the ID as first param
  add: (action) ->
    # TODO: verify action is a function
    # TODO: verify action has a name in options or on itself
    action.options = id:action.name unless action?.options?
    @_chain.add action

  remove: (actionOrId) ->
    switch typeof actionOrId
      when 'function' then action = actionOrId
      when 'string'
        action = a for a in @_chain.array when actionOrId is a.options.id

    @_chain.remove action

  execute: (context, done) -> @_chain.run context:context, done:done

  _reorder: ->
    result = @_order @_chain.array
    @_printError result, 'Error ordering actions' if result?.error?
    @_chain.array = result.array
    return

  _order: (array) -> @_orderer.order array:array

  _printError: (result, message) ->
    console.log message if message?
    # TODO: format had errors into an error string
    if result?.errors?
      console.log each for each in result.errors
    else
      console.log result
