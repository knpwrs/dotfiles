#!/usr/bin/env bash

for file in $DOTLIB/spell/*.add; do
  cat $file | sort > $file.tmp
  mv -f $file.tmp $file
done
