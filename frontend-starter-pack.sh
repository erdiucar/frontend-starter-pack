#!/bin/bash

# ----------------------
# Color Variables
# ----------------------
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
RED="\033[0;31m"
NC='\033[0m' # No Color

# ----------------------
# Perform Configuration
# ----------------------

# Icon font choice
echo -e "${RED}Do you want to install Font Awesome to your project? ${NC}"
select iconFontChoise in "Yes" "No"; do
  case $iconFontChoise in
    Yes) 
      fontAwesomeInstalled=true
      break ;;
    No) 
      fontAwesomeInstalled=false
      break ;;
  esac
done
echo

# Starting script
echo -e "${GREEN}Configuring your frontend development environment... ${NC}"
echo

# Git installation
echo -e "1/19 ${LCYAN}Git installation... ${NC}"
git init
echo

# Building gitignore file for node_modules
echo -e "2/19 ${LCYAN}Building gitignore file... ${NC}"
> .gitignore # truncates existing file (or creates empty)
echo 'node_modules
' >> .gitignore
echo

# Default Npm installation
echo -e "3/19 ${LCYAN}Default Npm installation... ${NC}"
npm init -y
echo

# Building pack folders and files
echo -e "4/19 ${LCYAN}Building project folders and files... ${NC}"
mkdir "css"
mkdir "css/libraries"
mkdir "js"
mkdir "js/libraries"
mkdir "img"
mkdir "font"
mkdir "scss"
mkdir "scss/layout"
mkdir "scss/layout/general"
touch "scss/layout/general/_header.scss"
touch "scss/layout/general/_main.scss"
touch "scss/layout/general/_footer.scss"
touch "scss/layout/general/_layout.scss"
touch "scss/layout/general/_displays.scss"
mkdir "scss/utilities"
touch "scss/utilities/_mixins.scss"
touch "scss/utilities/_extends.scss"
touch "scss/utilities/_variables.scss"
echo

# JQuery installation
echo -e "5/19 ${LCYAN}JQuery installation... ${NC}"
npm i -D jquery
cp node_modules/jquery/dist/jquery.slim.min.js js/libraries/jquery.slim.min.js
echo

# Popper.js installation
echo -e "6/19 ${LCYAN}Popper.js installation... ${NC}"
npm i -D popper.js
cp node_modules/popper.js/dist/umd/popper.min.js js/libraries/popper.min.js
echo

# Bootstrap installation
echo -e "7/19 ${LCYAN}Bootstrap installation... ${NC}"
npm i -D bootstrap
cp node_modules/bootstrap/dist/css/bootstrap.min.css css/libraries/bootstrap.min.css
cp node_modules/bootstrap/dist/js/bootstrap.min.js js/libraries/bootstrap.min.js
echo

# Font Awesome installation
if $fontAwesomeInstalled
then
  echo -e "8/19 ${LCYAN}Font Awesome installation... ${NC}"
  npm i -D @fortawesome/fontawesome-free
  cp node_modules/@fortawesome/fontawesome-free/css/all.min.css css/libraries/all.min.css
else
  echo -e "8/19 ${LCYAN}Font Awesome doesn't installed... ${NC}"
fi
echo

# ESLint & Prettier installation
echo -e "9/19 ${LCYAN}ESLint & Prettier installation... ${NC}"
npm i -D eslint prettier
echo


# Airbnb's JavaScript style guide packages installation
echo -e "10/19 ${LCYAN}Airbnb's JavaScript style guide packages installation... ${NC}"
npm i -D eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-react babel-eslint
echo

# Prettier's Eslint packages installation
echo -e "11/19 ${LCYAN}Prettier's Eslint packages installation... ${NC}"
npm i -D eslint-config-prettier eslint-plugin-prettier
echo

# Building eslintrc.json file
echo -e "12/19 ${LCYAN}Building eslintrc.json file...${NC}"
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
    "node": true,
    "jquery": true
  },
  "rules": {
    "no-console": "off",
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
echo -e "13/19 ${LCYAN}Building your prettierrc.json file... ${NC}"
> .prettierrc.json # truncates existing file (or creates empty)
echo '{
  "singleQuote": true,
  "trailingComma": "es5"
}' >> .prettierrc.json
echo

# Gulp packages installation
echo -e "14/19 ${LCYAN}Gulp packages installation... ${NC}"
npm i -D gulp gulp-concat gulp-uglify gulp-rename gulp-sass gulp-babel @babel/core @babel/preset-env gulp-sourcemaps gulp-clean-css del
echo

# Building gulp file
echo -e "15/19 ${LCYAN}Building gulpfile.js... ${NC}"
> gulpfile.js # truncates existing file (or creates empty)

echo "/* eslint-disable strict */

'use strict';

// Assign programs to variables
const gulp = require('gulp');
const babel = require('gulp-babel');
const concat = require('gulp-concat');
const uglify = require('gulp-uglify');
const rename = require('gulp-rename');
const sass = require('gulp-sass');
const maps = require('gulp-sourcemaps');
const cleanCss = require('gulp-clean-css');
const del = require('del');

// Babelify and concat js files
gulp.task('concat-script', () => {
  return gulp
    .src(['js/main.js'])
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
gulp.task('minify-script', () => {
  return gulp
    .src('js/app.js')
    .pipe(maps.init())
    .pipe(uglify())
    .pipe(rename('app.min.js'))
    .pipe(maps.write('./'))
    .pipe(gulp.dest('js'));
});

// Compile Sass, than write .map
gulp.task('compile-sass', () => {
  return gulp
    .src('scss/style.scss')
    .pipe(maps.init())
    .pipe(sass())
    .pipe(maps.write('./'))
    .pipe(gulp.dest('css'));
});

// Minify css and create min.map
gulp.task('minify-css', () => {
  return gulp
    .src('css/style.css')
    .pipe(maps.init())
    .pipe(cleanCss())
    .pipe(rename('style.min.css'))
    .pipe(maps.write('./'))
    .pipe(gulp.dest('css'));
});

// Create dist folder
gulp.task('dist', () => {
  return gulp
    .src(
      [
        'css/style.min.css',
        'css/libraries/**',
        'js/app.min.js',
        'js/libraries/**',
        '*.html',
        'img/**',
        'font/**',
      ],
      {
        base: './',
      }
    )
    .pipe(gulp.dest('dist'));
});

// Clean dist, css folders and app*.js* files
gulp.task('clean', () => {
  return del(['dist', 'css', 'js/app*.js*']);
});

// Watch Task
gulp.task('watch-files', () => {
  gulp.watch('scss/**/*.scss', gulp.series('compile-sass', 'minify-css'));
  gulp.watch('js/main.js', gulp.series('concat-script', 'minify-script'));
});

// Multiple Tasks
gulp.task(
  'build',
  gulp.series(
    'concat-script',
    'minify-script',
    'compile-sass',
    'minify-css',
    'dist'
  )
);

// Watch files with serve command
gulp.task('serve', gulp.series('watch-files'));

// Default task for multiple tasks
gulp.task('default', gulp.series('clean', 'build'));" >> gulpfile.js
echo

# Building main.js file
echo -e "16/19 ${LCYAN}Building your main.js file... ${NC}"
touch js/main.js
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
    <title>Frontend Starter Pack</title>
    <!-- /Title -->

    <!-- Minified CSS File -->' > index.html

if $fontAwesomeInstalled 
then    
  echo '    <link rel="stylesheet" href="css/libraries/all.min.css" />' >> index.html
fi      

echo '    <link rel="stylesheet" href="css/libraries/bootstrap.min.css" />
    <link rel="stylesheet" href="css/style.min.css" />
    <!-- /Minified CSS File -->
  </head>

  <body>

    <!-- Minified JavaScript Sources -->
    <script src="js/libraries/jquery.slim.min.js"></script>
    <script src="js/libraries/popper.min.js"></script>
    <script src="js/libraries/bootstrap.min.js"></script>
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

// Utilities
@import "utilities/variables", "utilities/mixins", "utilities/extends";

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
echo -e "${GREEN}Frontend Starter Pack installation is finished!${NC}"
echo

# Start watching the project
echo -e "${LCYAN}Starting to watch the project with gulp... ${NC}"
echo
gulp serve