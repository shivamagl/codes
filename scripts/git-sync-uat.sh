#!/bin/bash
cd /home/ubuntu/GIT/project-demo
git checkout testing
git pull origin testing
git checkout uat
git pull origin uat
git merge testing
git commit -am " abcde "
git push origin uat

git checkout master
