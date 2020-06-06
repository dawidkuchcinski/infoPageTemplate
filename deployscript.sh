#!/bin/bash

sudo apt-get update
sudo apt-get install python3-pip apache2 libapache2-mod-wsgi-py3 git

sudo pip install virtualenv

mkdir ~/fake_wix
cd ~/fake_wix

pip install -r requirements.txt

