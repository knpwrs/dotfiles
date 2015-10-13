#!/usr/bin/env zsh

hash npm 2>/dev/null || { nvm install stable && nvm alias default stable }
npm i -g jshint nd nws
