#!/bin/bash

function git-apply() {
  local commit=$1
  git pull
  git pullr origin staging
  git cp -m 1 $commit
  git push origin staging
}
