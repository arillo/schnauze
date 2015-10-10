Package.describe({
  name: "schnauze:lib",
  summary: "Schnauze lib package",
  version: "0.0.1",
  git: ""
});

Package.onUse(function(api) {

  api.versionsFrom("METEOR@1.0");
  
  var packages = [

    // meter core packages
    'meteor-base',
    'mobile-experience',
    'mongo',
    'blaze-html-templates',
    'session',
    'jquery',
    'tracker',
    'standard-minifiers',

    // development
    'coffeescript',
    'fourseven:scss',

    // file handling
    'cfs:standard-packages',
    'cfs:gridfs',

    // utilities
    'mrt:q',
    'raix:eventemitter',
    'momentjs:moment',
    'flyandi:reactive-countdown'
  ];

  api.use(packages);
  
  api.imply(packages);

  api.addFiles([
    'both/namespace.coffee',
  ], ['client', 'server']);

  api.addFiles([
    'client/eventemitter.coffee'
  ], ['client']);


  // api.addFiles([
  // ], ['server']);

  api.export([
    'Schnauze'
  ]);

});