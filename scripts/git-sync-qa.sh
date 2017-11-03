#!/bin/bash
cd /home/ubuntu/GIT/project-demo
git checkout testing
git pull origin testing
git checkout qa
git pull origin qa
git merge testing
git commit -am " abcde "
git push origin qa

git checkout master
