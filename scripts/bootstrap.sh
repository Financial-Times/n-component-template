#!/bin/sh

rename_cwd() {
  cd . || return
  new_dir=${PWD%/*}/$1
  mv -- "$PWD" "$new_dir" &&
    cd -- "$new_dir"
}

if [ -z "$1" ]; then
  echo ""
  echo "Please specify the name of the component. For example:"
  echo ""
  echo "  make bootstrap my-component-name"
  echo ""
else
  echo Setting up project as $1

  sed -i "" "s/n-component-template/$1/" package.json
  sed -i "" "s/n-component-template/$1/" README.md

  rename_cwd $1

  if test -d .git; then
    echo ""
  else
    echo Setting up git...
    git init
    git add .
    git commit -m "Initial commit"
  fi
fi
