class Chain

  constructor: (@type = 'chain') ->
    @_actions = []
    # client has `builder` browserified, server uses Npm.require
    @_builder  = builder ? Npm.require 'chain-builder'
    # same as for builder above.
    @_orderer  = ordering ? Npm.require 'ordering'
    @_build()

  # TODO: allow (string, action) to specify the ID as first param
  add: (action) ->
    # TODO: verify action is a function
    # TODO: verify action has a name in options or on itself
    action.options = id:action.name unless action?.options?
    @_actions.push action
    @_build()

  remove: (actionOrId) ->

    index = -1

    switch typeof actionOrId
      when 'function'
        index = @_actions.indexOf actionOrId
      when 'string'
        index = i for action,i in @_actions when actionOrId is action.options.id

    @_actions.splice index, 1 if index > -1 if index isnt -1

    @_build()

  execute: (context) -> @_chain context

  _build: ->
    result = @_order @_actions
    @_printError result, 'Error ordering actions' if result?.error?
    result = @_builder[@type] result.array
    @_printError result, 'Error building actions chain' if result?.error?
    @_chain = result[@type] if result?[@type]?
    return

  _order: (array) -> @_orderer.order array:array

  _printError: (result, message) ->
    console.log message if message?
    # TODO: format had errors into an error string
    if result?.errors?
      console.log each for each in result.errors
    else
      console.log result
