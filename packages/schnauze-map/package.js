Package.describe({
  name: "schnauze:map",
  summary: "Schnauze map package",
  version: "0.0.1",
  git: ""
});

Package.onUse(function(api) {

  api.versionsFrom("METEOR@1.0");

  var packages = [
    'schnauze:lib',
    'schnauze:styles'
  ];

  api.use(packages);

  api.imply(packages);

  api.addFiles([
  ], ['client', 'server']);

  api.addFiles([
    'client/views/map.html',
    'client/views/map.coffee'
  ], ['client']);


  // api.addFiles([
  // ], ['server']);

});