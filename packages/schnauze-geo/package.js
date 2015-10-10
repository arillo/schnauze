Package.describe({
  name: "schnauze:geo",
  summary: "Schnauze geo package",
  version: "0.0.1",
  git: ""
});

Package.onUse(function(api) {

  api.versionsFrom("METEOR@1.0");
  
  var packages = [
    'schnauze:lib',
    'mdg:geolocation'
  ];

  api.use(packages);
  
  api.imply(packages);

  api.addFiles([
  ], ['client', 'server']);

  api.addFiles([
    'client/geolocator.coffee'
  ], ['client']);


  // api.addFiles([
  // ], ['server']);

});