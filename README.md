# Frontend Starter Pack

<p align="center">
  <img width="300" height="300" src="img/frontend-starter-pack-logo.png">
</p>

Preparing project files and downloading packages takes a lot of time. This starter pack allows you to start a frontend project quickly.

## Getting started

1. Navigate your app directory.

   ```sh
   cd app-directory
   ```

2. Run this command in the app-directory.

   ```sh
   exec 3<&1;bash <&3 <(curl https://raw.githubusercontent.com/erdiucar/frontend-starter-pack/master/frontend-starter-pack.sh 2> /dev/null)
   ```

## Packages

* [JQuery](https://jquery.com/)
* [Bootstrap](https://getbootstrap.com/)
* [Popper.js](https://popper.js.org/)
* [Font Awesome](https://fontawesome.com/)
* [Gulp](https://gulpjs.com/) and plugins
* [Sass](https://sass-lang.com/)
* [ESLint](https://eslint.org/) and plugins (Airbnb React JavaScript style)
* [Prettier](https://prettier.io/) and plugins (Airbnb React JavaScript style)

## How it works

When you run the command, bash script works. It downloads the packages and configure the project folder to start to work. When the package downloads are finished, `gulp serve` command runs. The pack configures css and js paths in the index.html file. You can immediately start your project!

Gulp helps you to minify css and js files. When you type the `gulp serve` in your command line, gulp starts to watch "scss" folder and "main.js" file. If you save the project when "serve" command running, Gulp see your changes on the files and minify all of that.

When your production is finished, you can type `gulp build` command. It creates the "dist" files in the dist folder (.html files, style.min.css file, app.min.js file, img folder, font folder and libraries).

## ESLint and Prettier configuration settings

I use the default configuration settings prepared by Paulo Ramos. I only add "JQuery" to "env settings" and add the "no-console: off" rule to ".eslintrc.json" file. You can review the settings from his [project](https://github.com/paulolramos/eslint-prettier-airbnb-react).

## License

[MIT](LICENSE)

---
This script was inspired by Paulo Ramos's [script](https://github.com/paulolramos/eslint-prettier-airbnb-react).
