Package.describe({
  name: "schnauze:styles",
  summary: "Schnauze base styles package",
  version: "0.0.1",
  git: ""
});

Package.onUse(function(api) {

  api.versionsFrom("METEOR@1.0");

  var packages = [
    'schnauze:lib'
  ];

  api.use(packages);

  api.imply(packages);

  api.addFiles([
    'client/views/sprite/sprite.html'
  ], ['client']);

  api.addFiles([
    'client/sass/app.sass',
    'client/sass/_sprite-inline.scss',

    'client/sass/base/_defaults.sass',
    'client/sass/base/_fonts.sass',
    'client/sass/base/_form.sass',
    'client/sass/base/_vars.scss',

    'client/sass/layout/_layout.sass',

    'client/sass/lib/_center-transform.sass',
    'client/sass/lib/_center.sass',
    'client/sass/lib/_clear.sass',
    'client/sass/lib/_clearfix.sass',
    'client/sass/lib/_colors.sass',
    'client/sass/lib/_decimal-round.sass',
    'client/sass/lib/_dimensions.sass',
    'client/sass/lib/_grid.sass',
    'client/sass/lib/_icons.sass',
    'client/sass/lib/_lib.sass',
    'client/sass/lib/_mq.sass',
    'client/sass/lib/_overflow.sass',
    'client/sass/lib/_position.sass',
    'client/sass/lib/_size.sass',
    'client/sass/lib/_truncate.sass',

    'client/sass/module/_icon.sass',
    'client/sass/module/_map.sass',
    'client/sass/module/_rec-btn.sass',
    'client/sass/module/_menu.sass',
    'client/sass/module/_list.sass',
    'client/sass/module/_listItem.sass',
    'client/sass/module/_brand.sass',

    'client/sass/utilities/_animation.sass',
    'client/sass/utilities/_cursor.sass',
    'client/sass/utilities/_dimensions.scss',
    'client/sass/utilities/_layout.sass',
    'client/sass/utilities/_opacity.sass',
    'client/sass/utilities/_position.sass',
    'client/sass/utilities/_typography.sass',

    'client/sass/vendor/_normalize.scss'
  ], ['client'], {isImport: true});




  // api.addFiles([
  // ], ['server']);

});