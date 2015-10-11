Package.describe({
  name: "schnauze:app",
  summary: "Schnauze app package",
  version: "0.0.1",
  git: ""
});

Package.onUse(function(api) {

  api.versionsFrom("METEOR@1.0");

  var packages = [
    'schnauze:lib',
    'schnauze:styles',
    'schnauze:recorder',
    'schnauze:geo',
    'schnauze:map',
    'schnauze:list',
    'schnauze:player',
    'schnauze:menu',
    'schnauze:list',
    'schnauze:home'
  ];

  api.use(packages);

  api.imply(packages);

  api.addFiles([
    'both/collections/audioSnippets.coffee',
  ], ['client', 'server']);

  api.addFiles([
    'client/views/errors/geolocationError.html',
    'client/views/errors/recorderError.html',
    'client/utils/helpers.coffee',
    'client/views/mainLayout/mainLayout.html',
    'client/views/mainLayout/mainLayout.coffee',
    'client/app.html',
    'client/app.coffee',
    'client/audioSnippets.coffee'
  ], ['client']);


  api.addFiles([
    'server/security.coffee',
    'server/publications/audioSnippets.coffee'
  ], ['server']);

});