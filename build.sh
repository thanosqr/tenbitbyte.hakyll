#!/usr/bin/env bash

cabal clean
cabal build
dist/build/site/site clean
dist/build/site/site build
dist/build/site/site watch
