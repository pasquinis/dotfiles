#!/bin/bash

echo "insert the name you want to visualize the commits in GIT"
read name

echo "insert the email you want to associate to your account in your GIT commit"
read email

echo "git config --global user.name $name ; git config --global user.email $email  , is this correct ? (y/n)"
read answer

if [ $answer = 'y' ]
then
    git config --global user.name "$name"
    git config --global user.email "$email"
    git config --global color.ui auto
    git config --global core.editor vim
else
    echo "your answer was different from (y):$answer, leaving, bye..."
    exit 1
fi

