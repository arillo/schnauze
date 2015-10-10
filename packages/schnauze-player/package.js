Package.describe({
  name: 'schnauze:player',
  summary: 'Schnauze player package',
  version: '0.0.1',
  git: ''
});

Package.onUse(function(api) {
 var packages = [
    'schnauze:lib'
  ];

  api.use(packages);
  api.imply(packages);

  // api.addFiles([
  //   'lib/wavesurfer/wavesurfer.js',
  //   'player.coffee'
  // ], ['client']);
});