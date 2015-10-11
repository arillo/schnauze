Package.describe({
  name: "schnauze:home",
  summary: "Schnauze home package",
  version: "0.0.1",
  git: ""
});

Package.onUse(function(api) {

  api.versionsFrom("METEOR@1.0");

  var packages = [
    'schnauze:lib',
  ];

  api.use(packages);

  api.imply(packages);

  api.addFiles([
  ], ['client', 'server']);

  api.addFiles([
    'client/home.html',
    'client/home.js'
  ], ['client']);

  // api.addFiles([
  // ], ['server']);

});