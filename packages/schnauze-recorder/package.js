Package.describe({
  name: "schnauze:recorder",
  summary: "Schnauze recorder package",
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
    'client/utils/countdowntimer.coffee',
    'client/settings/recorder.coffee',
    'client/recorder.coffee',
    'client/views/recorder.html',
    'client/views/recorder.coffee'
  ], ['client']);


  // api.addFiles([
  // ], ['server']);

});