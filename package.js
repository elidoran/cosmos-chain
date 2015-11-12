Package.describe({
  name: 'cosmos:chain',
  version: '0.4.0',
  summary: 'Maintain ordered chains of actions',
  git: 'http://github.com/elidoran/cosmos-chain',
  documentation: 'README.md'
});

Npm.depends({
  'chain-builder':'0.7.1',
       'ordering':'0.4.1',
            'had':'0.6.1'
});

var client = 'client';
var server = 'server';
var cs     = [ 'client', 'server' ];

Package.onUse(function(api) {
  api.versionsFrom('1.2');

  api.use('cosmos:browserify@0.8.3', client);

  api.use(['coffeescript@1.0.11'], cs);

  api.addFiles(['export.js'], cs);

  api.addFiles('client.browserify.js', client);

  api.addFiles(['chain.coffee'], cs);


  api.export('Chain', cs);
});

Package.onTest(function(api) {
  api.use(['tinytest', 'coffeescript@1.0.11']);

  api.use('cosmos:chain@0.4.0');

  api.addFiles([
    'test/chain-tests.coffee'
  ], cs);
});
