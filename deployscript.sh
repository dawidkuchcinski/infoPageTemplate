#!/bin/bash

sudo apt-get update
sudo apt-get install -y python3-pip apache2 libapache2-mod-wsgi-py3 git

sudo pip3 install virtualenv

mkdir ~/fake_wix
cd ~/fake_wix

git clone https://github.com/dawidkuchcinski/infoPageTemplate.git

virtualenv fake_wixenv

source fake_wixenv/bin/activate

cd infoPageTemplate

pip3 install -r requirements.txt

python ./manage.py makemigrations
python ./manage.py migrate

python ./manage.py createsuperuser