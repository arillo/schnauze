App.info({
  id: 'io.schnauze.app',
  name: 'Schnauze',
  description: 'Location based audio snippets',
  version: '0.0.1',
  // buildNumber: process.env.BUILD_NUMBER,
  author: 'Arillo GmbH',
  email: 'we@arillo.net',
  website: 'https://schnauze.meteor.com'
});

App.accessRule("blob:*");

// ACCESS RULES
App.accessRule('http://*.meteor.com/*');
App.accessRule('https://*.meteor.com/*');

App.accessRule('*.google.com/*');
App.accessRule('*.googleapis.com/*');
App.accessRule('*.gstatic.com/*');

// App.accessRule('http://*.kadira.io/*');
// App.accessRule('https://*.kadira.io/*');

// App.accessRule('https://enginex.kadira.io/*', false);

// App.accessRule('http://www.google-analytics.com/*');
// App.accessRule('https://www.google-analytics.com/*');

// App.accessRule('http://*.doubleclick.net/*');
// App.accessRule('https://*.doubleclick.net/*');

// App.accessRule('http://*.gstatic.com/*');
// App.accessRule('https://*.gstatic.com/*');

// App.accessRule('http://*.google.com/*');
// App.accessRule('https://*.google.com/*');

App.icons({
  // iOS
  'iphone'    : 'resources/iphone/appicon.png',
  'iphone_2x' : 'resources/iphone/appicon-60@2x.png',
  'iphone_3x' : 'resources/iphone/appicon-60@3x.png',
  'ipad'      : 'resources/iphone/appicon-76.png',
  'ipad_2x'   : 'resources/iphone/appicon-76@2x.png',
  // Android
  'android_ldpi'  : 'resources/icons/res/drawable-ldpi/appicon.png',
  'android_mdpi'  : 'resources/icons/res/drawable-mdpi/appicon.png',
  'android_hdpi'  : 'resources/icons/res/drawable-hdpi/appicon.png',
  'android_xhdpi' : 'resources/icons/res/drawable-xhdpi/appicon.png'});

App.launchScreens({
  // iOS
  'iphone'              : 'resources/iphone/Default.png',
  'iphone_2x'           : 'resources/iphone/Default@2x.png',
  'iphone5'             : 'resources/iphone/Default-568h@2x.png',
  'iphone6'             : 'resources/iphone/Default-667h@2x.png',
  'iphone6p_portrait'   : 'resources/iphone/Default-736h@3x.png',
  // 'iphone6p_landscape'  : 'resources/iphone/Default-Landscape-736h@3x.png',
  'ipad_portrait'       : 'resources/iphone/Default-Portrait.png',
  'ipad_portrait_2x'    : 'resources/iphone/Default-Portrait@2x.png',
  // 'ipad_landscape'      : 'resources/iphone/Default-Landscape.png',
  // 'ipad_landscape_2x'   : 'resources/iphone/Default-Landscape@2x.png',

  // Android
  // 'android_ldpi_portrait'    : 'resources/android/images/res-long-port-ldpi/default.png',
  // 'android_ldpi_landscape'   : 'resources/android/images/res-long-land-ldpi/default.png',
  'android_mdpi_portrait'    : 'resources/android/images/res-long-port-mdpi/default.png',
  // 'android_mdpi_landscape'   : 'resources/android/images/res-long-land-mdpi/default.png',
  'android_hdpi_portrait'    : 'resources/android/images/res-long-port-hdpi/default.png',
  // 'android_hdpi_landscape'   : 'resources/android/images/res-long-land-hdpi/default.png',
  'android_xhdpi_portrait'   : 'resources/android/images/res-long-port-xhdpi/default.png'
  // 'android_xxhdpi_portrait'  : 'resources/android/images/res-long-port-xxhdpi/default.png',
  // 'android_xxxhdpi_portrait' : 'resources/android/images/res-long-port-xxxhdpi/default.png'
  // ,'android_xhdpi_landscape'  : 'resources/android/images/res-long-land-xhdpi/default.png'
});

App.setPreference('Orientation', 'portrait');


// App.setPreference('BackgroundColor', '0xfff2f2f2');
// App.setPreference('ShowSplashScreenSpinner', false);

// com.ionic.keyboard
// App.setPreference('HideKeyboardFormAccessoryBar', true);
// App.setPreference('KeyboardShrinksView', true);


// org.apache.cordova.statusbar
App.setPreference('StatusBarOverlaysWebView', 'true');
// App.setPreference('StatusBarBackgroundColor', '#1a1a1a');
App.setPreference('StatusBarStyle', 'lightcontent');