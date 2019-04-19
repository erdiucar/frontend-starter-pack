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
echo -e "${GREEN}Configuring your development environment... ${NC}"

# Git installation
echo
echo -e "1/10 ${LCYAN}Git installation... ${NC}"
echo
git init

# ESLint & Prettier installation
echo
echo -e "2/10 ${LCYAN}ESLint & Prettier installation... ${NC}"
echo
npm install -D eslint prettier

# Airbnb's JavaScript style guide packages installation
echo
echo -e "3/10 ${LCYAN}Airbnb's JavaScript style guide packages installation... ${NC}"
echo
npm install -D eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-react babel-eslint

# Prettier's Eslint packages installation
echo
echo -e "4/10 ${LCYAN}Prettier's Eslint packages installation... ${NC}"
echo
npm install -D eslint-config-prettier eslint-plugin-prettier

# Building eslintrc.json file
echo
echo -e "5/10 ${LCYAN}Building eslintrc.json file...${NC}"
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
echo -e "6/10 ${LCYAN}Building your prettierrc.json file... ${NC}"
  > .prettierrc.json # truncates existing file (or creates empty)

  echo '{
  "singleQuote": true,
  "trailingComma": "es5"
}' >> .prettierrc.json
echo

# # Building gulp file
# echo -e "7/11 ${LCYAN}Building gulpfile.js... ${NC}"
# touch gulpfile.js

# Building pack folders
echo -e "8/10 ${LCYAN}Building pack folders and files... ${NC}"
mkdir "css"
mkdir "img"
mkdir "js"
touch "js/main.js"
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

# Building gitignore file for node_modules
echo -e "9/10 ${LCYAN}Building gitignore file... ${NC}"
  > .gitignore # truncates existing file (or creates empty)
  echo 'node_modules
package-lock.json
.prettierrc.json
.eslintrc.json
' >> .gitignore
echo

# Building style.scss file
echo -e "10/10 ${LCYAN}Building your style.scss file... ${NC}"
  > scss/style.scss # truncates existing file (or creates empty)

  echo '// ------------------------------ */
// ----- PARTIAL IMPORTS ----- */
// ------------------------------ */

// Libraries
// @import "libraries/slick/slick.scss", "libraries/bootstrap/bootstrap.scss";

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

# Finishing the script
echo
echo -e "${GREEN}Finished setting up!${NC}"
echo