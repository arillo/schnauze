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
  ];

  api.use(packages);
  
  api.imply(packages);

  // api.addFiles([
  // ], ['client', 'server']);

  api.addFiles([
    'client/app.html'
  ], ['client']);


  // api.addFiles([
  // ], ['server']);

});