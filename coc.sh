#!/bin/bash

mkdir -p ~/.config/coc/extensions && cd ~/.config/coc/extensions
npm install \
  coc-snippets \
  coc-tsserver \
  coc-html \
  coc-json \
  coc-css \
  coc-solargraph \
  --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

