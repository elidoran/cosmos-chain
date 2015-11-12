Tinytest.add 'test creation', (test) ->
  error = null

  try
    new Chain()
  catch e
    error = e

  test.equal error, null, 'error shouldn\'t occur'


Tinytest.add 'test single function executes', (test) ->

  chain = new Chain()

  ran = false

  fn1 = -> ran = true

  chain.add fn1

  chain.execute()

  test.equal ran, true, 'chain execution should cause fn1 to set ran to true'


Tinytest.add 'test single function using context via this', (test) ->

  chain = new Chain()

  context = ran:false

  fn1 = -> this.ran = true

  chain.add fn1

  chain.execute context

  test.equal context.ran, true, 'chain execution should cause fn1 to set context.ran to true'

Tinytest.add 'test single function using context via context var', (test) ->

  chain = new Chain()

  context = ran:false

  fn1 = (_, ctx) -> ctx.ran = true

  chain.add fn1

  chain.execute context

  test.equal context.ran, true, 'chain execution should cause fn1 to set context.ran to true'


Tinytest.add 'test two functions executing', (test) ->

  chain = new Chain()

  context = ran1:false, ran2:false

  fn1 = -> this.ran1 = true
  fn1.options = id:'fn1'

  fn2 = -> this.ran2 = true
  fn2.options = id:'fn2'

  chain.add fn1
  chain.add fn2

  chain.execute context

  test.equal context.ran1, true, 'chain execution should cause fn1 to set context.ran1 to true'
  test.equal context.ran2, true, 'chain execution should cause fn2 to set context.ran2 to true'


Tinytest.add 'test two functions executing in order (before)', (test) ->

  chain = new Chain()

  context = ran1:false, ran2:false

  fn1 = -> this.ran1 = true ; this.second = this.ran2
  fn1.options = id:'fn1'

  fn2 = -> this.ran2 = true
  fn2.options = id:'fn2', before:['fn1']

  chain.add fn1
  chain.add fn2

  test.equal chain._chain.array.length, 2
  test.equal chain._chain.array[0], fn2
  test.equal chain._chain.array[1], fn1

  chain.execute context

  test.equal context.ran1, true, 'chain execution should cause fn1 to set context.ran1 to true'
  test.equal context.ran2, true, 'chain execution should cause fn2 to set context.ran2 to true'
  test.equal context.second, true, 'chain should execute fn1 second (when context.ran2 is true)'


Tinytest.add 'test two functions executing in order (after)', (test) ->

  chain = new Chain()

  context = ran1:false, ran2:false

  fn1 = -> this.ran1 = true ; this.second = this.ran2
  fn1.options = id:'fn1', after:['fn2']

  fn2 = -> this.ran2 = true
  fn2.options = id:'fn2'

  chain.add fn1
  chain.add fn2

  test.equal chain._chain.array.length, 2
  test.equal chain._chain.array[0], fn2
  test.equal chain._chain.array[1], fn1

  chain.execute context

  test.equal context.ran1, true, 'chain execution should cause fn1 to set context.ran1 to true'
  test.equal context.ran2, true, 'chain execution should cause fn2 to set context.ran2 to true'
  test.equal context.second, true, 'chain should execute fn1 second (when context.ran2 is true)'


Tinytest.add 'test two functions executing in order (complementary before/after)', (test) ->

  chain = new Chain()

  context = ran1:false, ran2:false

  fn1 = -> this.ran1 = true ; this.second = this.ran2
  fn1.options = id:'fn1', after:['fn2']

  fn2 = -> this.ran2 = true
  fn2.options = id:'fn2', before:['fn1']

  chain.add fn1
  chain.add fn2

  test.equal chain._chain.array.length, 2
  test.equal chain._chain.array[0], fn2, 'fn2 should be first in the array'
  test.equal chain._chain.array[1], fn1, 'fn1 should be second in the array'

  chain.execute context

  test.equal context.ran1, true, 'chain execution should cause fn1 to set context.ran1 to true'
  test.equal context.ran2, true, 'chain execution should cause fn2 to set context.ran2 to true'
  test.equal context.second, true, 'chain should execute fn1 second (when context.ran2 is true)'
