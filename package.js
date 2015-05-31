Package.describe({
  name: 'cosmos:chain',
  version: '0.1.0',
  summary: 'Maintain ordered chains of actions',
  git: 'http://github.com/elidoran/cosmos-chain',
  documentation: 'README.md'
});

Npm.depends({
  'chain-builder':'0.6.2',
       'ordering':'0.4.1'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1');

  api.use('cosmos:browserify@0.3.0', 'client');

  api.use(['coffeescript@1.0.6'], ['client', 'server']);

  api.addFiles('client.browserify.js', 'client');
  
  api.addFiles(['export.js', 'chain.coffee'], ['client', 'server']);

  api.export('Chain', ['client', 'server']);
});

Package.onTest(function(api) {
  api.use(['tinytest', 'coffeescript@1.0.6']);

  api.use('cosmos:chain@0.1.0');

  api.addFiles([
    'test/chain-tests.coffee'
  ], ['client', 'server']);
});
