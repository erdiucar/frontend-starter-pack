#!/bin/bash

# ----------------------
# Color Variables
# ----------------------
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# ----------------------
# Perform Configuration
# ----------------------

# Starting script
echo
echo -e "${GREEN}Configuring your frontend development environment... ${NC}"

# Git installation
echo
echo -e "1/19 ${LCYAN}Git installation... ${NC}"
echo
git init

# Building gitignore file for node_modules
echo -e "2/19 ${LCYAN}Building gitignore file... ${NC}"
  > .gitignore # truncates existing file (or creates empty)
  echo 'node_modules
' >> .gitignore
echo

# Default Npm installation
echo
echo -e "3/19 ${LCYAN}Default Npm installation... ${NC}"
echo
npm init -y

# JQuery installation
echo
echo -e "4/19 ${LCYAN}JQuery installation... ${NC}"
echo
npm i -D jquery

# Popper.js installation
echo
echo -e "5/19 ${LCYAN}Popper.js installation... ${NC}"
echo
npm i -D popper.js

# Bootstrap installation
echo
echo -e "6/19 ${LCYAN}Bootstrap installation... ${NC}"
echo
npm i -D bootstrap

# Font Awesome installation
echo
echo -e "7/19 ${LCYAN}Fontawesome installation... ${NC}"
echo
npm i -D @fortawesome/fontawesome-free

# ESLint & Prettier installation
echo
echo -e "8/19 ${LCYAN}ESLint & Prettier installation... ${NC}"
echo
npm i -D eslint prettier

# Airbnb's JavaScript style guide packages installation
echo
echo -e "9/19 ${LCYAN}Airbnb's JavaScript style guide packages installation... ${NC}"
echo
npm i -D eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-react babel-eslint

# Prettier's Eslint packages installation
echo
echo -e "10/19 ${LCYAN}Prettier's Eslint packages installation... ${NC}"
echo
npm i -D eslint-config-prettier eslint-plugin-prettier

# Building eslintrc.json file
echo
echo -e "11/19 ${LCYAN}Building eslintrc.json file...${NC}"
> ".eslintrc.json" # truncates existing file (or creates empty)

echo '{
  "extends": [
    "airbnb",
    "plugin:prettier/recommended",
    "prettier/react"
  ],
  "env": {
    "browser": true,
    "commonjs": true,
    "es6": true,
    "jest": true,
    "node": true
  },
  "rules": {
    "jsx-a11y/href-no-hash": ["off"],
    "react/jsx-filename-extension": ["warn", { "extensions": [".js", ".jsx"] }],
    "max-len": [
      "warn",
      {
        "code": 80,
        "tabWidth": 2,
        "comments": 80,
        "ignoreComments": false,
        "ignoreTrailingComments": true,
        "ignoreUrls": true,
        "ignoreStrings": true,
        "ignoreTemplateLiterals": true,
        "ignoreRegExpLiterals": true
      }
    ]
  }
}' >> .eslintrc.json
echo

# Building prettierrc.json file
echo -e "12/19 ${LCYAN}Building your prettierrc.json file... ${NC}"
  > .prettierrc.json # truncates existing file (or creates empty)

  echo '{
  "singleQuote": true,
  "trailingComma": "es5"
}' >> .prettierrc.json
echo

# Gulp packages installation
echo -e "13/19 ${LCYAN}Gulp packages installation... ${NC}"
npm i -D gulp gulp-concat gulp-concat-css gulp-uglify gulp-rename gulp-sass gulp-babel @babel/core @babel/preset-env gulp-browserify gulp-sourcemaps gulp-clean-css del
echo

# Building gulp file
echo -e "14/19 ${LCYAN}Building gulpfile.js... ${NC}"
  > gulpfile.js # truncates existing file (or creates empty)

  echo "'use strict';

// Assign programs to variables
const gulp = require('gulp'),
  babel = require('gulp-babel'),
  concat = require('gulp-concat'),
  concatCss = require('gulp-concat-css'),
  uglify = require('gulp-uglify'),
  browserify = require('gulp-browserify'),
  rename = require('gulp-rename'),
  sass = require('gulp-sass'),
  maps = require('gulp-sourcemaps'),
  cleanCss = require('gulp-clean-css'),
  del = require('del');

// Babelify and concat js files
gulp.task('concat-script', function() {
  return gulp
    .src([
      'node_modules/jquery/dist/jquery.js',
      'node_modules/popper.js/dist/popper.js',
      'node_modules/bootstrap/dist/js/bootstrap.js',
      'js/main.js',
    ])
    .pipe(maps.init())
    .pipe(
      babel({
        presets: ['@babel/preset-env'],
      })
    )
    .pipe(concat('app.js'))
    .pipe(maps.write('./'))
    .pipe(gulp.dest('js'));
});

// Minify the app.js file
gulp.task('minify-script', function() {
  return gulp
    .src('js/app.js')
    .pipe(
      browserify({
        insertGlobals: true,
      })
    )
    .pipe(maps.init())
    .pipe(uglify())
    .pipe(rename('app.min.js'))
    .pipe(maps.write('./'))
    .pipe(gulp.dest('js'));
});

// Compile Sass, than write .map
gulp.task('compile-sass', function() {
  return gulp
    .src('scss/style.scss')
    .pipe(maps.init())
    .pipe(sass())
    .pipe(maps.write('./'))
    .pipe(gulp.dest('css'));
});

// Concat Css files
gulp.task('concat-css', function() {
  return gulp
    .src([
      'css/style.css',
      'node_modules/bootstrap/dist/css/bootstrap.css',
      'node_modules/@fortawesome/fontawesome-free/css/all.css',
    ])
    .pipe(concatCss('app.css'))
    .pipe(gulp.dest('css'));
});

// Minify css and create min.map
gulp.task('minify-css', function() {
  return gulp
    .src('css/app.css')
    .pipe(maps.init())
    .pipe(cleanCss())
    .pipe(rename('app.min.css'))
    .pipe(maps.write('./'))
    .pipe(gulp.dest('css'));
});

// Create dist folder
gulp.task('dist', function() {
  return gulp
    .src(['css/app.min.css', 'js/app.min.js', 'index.html', 'img/**'], {
      base: './',
    })
    .pipe(gulp.dest('dist'));
});

// Clean dist, css folders and app*.js* files
gulp.task('clean', function() {
  return del(['dist', 'css', 'js/app*.js*']);
});

// Watch Task
gulp.task('watch-files', function() {
  gulp.watch(
    'scss/**/*.scss',
    gulp.series('compile-sass', 'concat-css', 'minify-css')
  );
  gulp.watch('js/main.js', gulp.series('concat-script', 'minify-script'));
});

// Multiple Tasks
gulp.task(
  'build',
  gulp.series(
    'concat-script',
    'minify-script',
    'compile-sass',
    'concat-css',
    'minify-css',
    'dist'
  )
);

// Watch files with serve command
gulp.task('serve', gulp.series('watch-files'));

// Default task for multiple tasks
gulp.task('default', gulp.series('clean', 'build'));
" >> gulpfile.js
echo

# Building pack folders
echo -e "15/19 ${LCYAN}Building pack folders and files... ${NC}"
mkdir "css"
mkdir "js"
mkdir "img"
mkdir "scss"
mkdir "scss/layout"
mkdir "scss/layout/general"
touch "scss/layout/general/_header.scss"
touch "scss/layout/general/_main.scss"
touch "scss/layout/general/_footer.scss"
touch "scss/layout/general/_layout.scss"
touch "scss/layout/general/_displays.scss"
mkdir "scss/libraries"
mkdir "scss/utilities"
touch "scss/utilities/_mixins.scss"
touch "scss/utilities/_extends.scss"
touch "scss/utilities/_variables.scss"
echo

# Building main.js file
echo -e "16/19 ${LCYAN}Building your main.js file... ${NC}"
  > js/main.js # truncates existing file (or creates empty)

  echo "// For using jquery
global.$ = require('jquery');
" >> js/main.js
echo

# Building index.html file
echo -e "17/19 ${LCYAN}Building your index.html file... ${NC}"
  > index.html # truncates existing file (or creates empty)

  echo '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

    <!-- Title -->
    <title>Document</title>
    <!-- /Title -->

    <!-- Minified CSS File -->
    <link rel="stylesheet" href="css/app.min.css" />
    <!-- /Minified CSS File -->
  </head>

  <body>
    <!-- Minified JavaScript Sources -->
    <script src="js/app.min.js"></script>
    <!-- /Minified JavaScript Sources -->
  </body>
</html>
' >> index.html
echo

# Building style.scss file
echo -e "18/19 ${LCYAN}Building your style.scss file... ${NC}"
  > scss/style.scss # truncates existing file (or creates empty)

  echo '// ------------------------------ */
// ----- PARTIAL IMPORTS ----- */
// ------------------------------ */

// Libraries
// @import "", "";

// Utilities
@import "utilities/variables", "utilities/mixins", "utilities/extends";

// ------ //
// LAYOUT //
// ------ //

// General styles
@import "layout/general/layout", "layout/general/header", "layout/general/main",
    "layout/general/footer", "layout/general/displays";
' >> scss/style.scss
echo

# Building dist folder
echo -e "19/19 ${LCYAN}Building the dist folder... ${NC}"
mkdir "dist"
gulp build
echo

# Finishing the script
echo
echo -e "${GREEN}Frontend Starter Pack installation is finished!${NC}"
echo
