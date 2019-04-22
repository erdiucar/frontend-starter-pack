# Frontend Starter Pack
Preparing project files and downloading packages takes a lot of time. This starter pack allows you to quickly start a frontend project.

## Installation

1. Navigate your app directory.

   ```sh
   cd app-directory
   ```

2. Run this command in the app-directory.

   ```sh
   exec 3<&1;bash <&3 <(curl https://raw.githubusercontent.com/erdiucar/frontend-starter-pack/master/frontend-starter-pack.sh 2> /dev/null)
   ```

---

This script was inspired by Paulo Ramos's [script](https://github.com/paulolramos/eslint-prettier-airbnb-react).
