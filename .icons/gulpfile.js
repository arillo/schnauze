// Requirements
// ==============================================

'use strict';

var gulp        = require('gulp');
var fs          = require('fs');
var svgSprite   = require('gulp-svg-sprite');
var plumber     = require('gulp-plumber');
var template    = require('gulp-template');
var del         = require('del');
var svgmin      = require('gulp-svgmin');
var merge       = require('merge-stream');


// Config
// ==============================================

var svgGlob = '**/*.svg';
var baseDirInline = './src/img-inline';
var outDirInline  = './dist';

var sassDest = './../packages/schnauze-styles/client/sass';
var htmlDest = './../packages/schnauze-styles/client/views/sprite';

var configInline = {
  'mode': {
    'symbol': {
      'dest': '.',
      'sprite': 'sprite',
      'inline': true,
      'render': {
        'scss': {
          'template': './src/tpl/sprite-inline.scss',
          'dest': './_sprite-inline.scss'
        }
      }
    }
  },
  'variables': {
    'common': 'i'
  }
};


// Sprite
// ==============================================

gulp.task('sprite:inline', function() {
  return gulp.src(svgGlob, {cwd: baseDirInline})
    .pipe(plumber())
    .pipe(svgSprite(configInline)).on('error', function(error){ console.log(error); })
    .pipe(gulp.dest(outDirInline))
});


// Create template
// ==============================================

gulp.task('sprite:write', ['sprite:inline'], function () {
  var data = fs.readFileSync('./dist/sprite.svg', 'utf8');
  return gulp.src('./src/tpl/sprite.html')
      .pipe(template({sprite: data}))
      .pipe(gulp.dest('./dist'));
});


// Move files
// ==============================================

gulp.task('sprite:move', ['sprite:write'], function () {
  var sass = gulp.src(outDirInline + '/*.scss')
    .pipe(gulp.dest(sassDest));

  var html = gulp.src(outDirInline + '/*.html')
    .pipe(gulp.dest(htmlDest));

  return merge(sass, html);
});


// Default
// ==============================================

gulp.task('default', ['sprite:move'], function (){});


// Compress all regular svg images
// ==============================================

gulp.task('compress', function () {
  return gulp.src('./../public/images/**/*.svg')
    .pipe(svgmin())
    .pipe(gulp.dest('./../public/images'));
});













// Tasks - Bg
// ==============================================


// gulp.task('sprite:clean', function(cb){
//   del(['./../public/images/sprite-bg-*.svg'], {force: true}, cb);
// });

// gulp.task('sprite:bg', ['sprite:clean'] , function() {
//   return gulp.src(svgGlob, {cwd: baseDirBg})
//     .pipe(plumber())
//     .pipe(svgSprite(configBg)).on('error', function(error){ console.log(error); })
//     .pipe(gulp.dest(outDirBg))
// });

// Config - Bg
// ==============================================

// var baseDirBg = './src/img-bg';
// var outDirBg  = './';

// var configBg = {
//   'mode' : {
//     'css': {
//       'layout': 'horizontal',
//       'prefix': '.i-%s',
//       'common': 'i',
//       'dimensions': '-s',
//       'sprite': '../../public/images/sprite-bg.svg',
//       'render': {
//         'scss': {
//           'template': './src/tpl/sprite-bg.scss',
//           'dest': '../../packages/tronko-mobile/client/sass/_sprite-bg.scss'
//         }
//       }
//     }
//   },
//    'variables': {
//     'path': function() {
//       return function(sprite, render) {
//         return render(sprite).replace('../../public', '');
//       }
//     }
//   }
// };




// var gulp = require('gulp');
// var svgSprite = require('gulp-svg-sprite');
// var del = require('del');


// // Vars
// // ==============================================

// var config = {
//   // 'shape': {
//   //   'spacing': {
//   //     'padding': 10
//   //   }
//   // },
//   'mode': {
//     'css': {
//       'layout': 'horizontal',
//       'prefix': '.i-%s',
//       'common': 'i',
//       'dimensions': '-s',
//       'sprite': '../../public/images/sprite.svg',
//       'render': {
//         'scss': {
//           'template': './src/tpl/sprite.scss',
//           'dest': '../../client/scss/_sprite.scss'
//         }
//       }
//     }
//   },
//   'variables': {
//     'path': function() {
//       return function(sprite, render) {
//         return render(sprite).replace('../../public', '');
//       }
//     }
//   }
// }


// // Clean
// // ==============================================



// // Svg
// // ==============================================

// gulp.task('sprite', ['sprite:clean'], function (){
//   return gulp.src('./src/img/*.svg')
//     .pipe(svgSprite(config)).on('error', function(error){ console.log(error); })
//     .pipe(gulp.dest('./'));
// });


// // Default
// // ==============================================

// gulp.task('default', ['sprite'], function (){});
