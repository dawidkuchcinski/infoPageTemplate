#!/bin/bash

adduser opr
usermod -aG sudo opr

su - opr

sudo apt-get update
sudo apt-get install -y python3-pip apache2 libapache2-mod-wsgi-py3 git mc htop software-properties-common python-certbot-apache

sudo source /etc/apache2/envvars

sudo pip3 install virtualenv

cd ~
mkdir ~/fake_wix
cd ~/fake_wix

git clone https://github.com/dawidkuchcinski/infoPageTemplate.git

virtualenv fake_wixenv

source fake_wixenv/bin/activate

cd infoPageTemplate

pip3 install -r requirements.txt

python3 ./manage.py makemigrations
python3 ./manage.py migrate

python3 ./manage.py createsuperuser --username davvi

deactivate

sudo su

echo "<VirtualHost *:80>
    # The ServerName directive sets the request scheme, hostname and port that
    # the server uses to identify itself. This is used when creating
    # redirection URLs. In the context of virtual hosts, the ServerName
    # specifies what hostname must appear in the request's Host: header to
    # match this virtual host. For the default virtual host (this file) this
    # value is not decisive as it is used as a last resort host regardless.
    # However, you must set it for any further virtual host explicitly.
    ServerName dawex-pol.pl
    ServerAlias www.dawex-pol.pl

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
    # error, crit, alert, emerg.
    # It is also possible to configure the loglevel for particular
    # modules, e.g.
    #LogLevel info ssl:warn

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    # For most configuration files from conf-available/, which are
    # enabled or disabled at a global level, it is possible to
    # include a line for only one particular virtual host. For example the
    # following line enables the CGI configuration for this host only
    # after it has been globally disabled with 'a2disconf'.
    #Include conf-available/serve-cgi-bin.conf

    Alias /static /home/opr/fake_wix/infoPageTemplate/static
    <Directory /home/opr/fake_wix/infoPageTemplate/static>
        Require all granted
    </Directory>

    Alias /media /home/opr/fake_wix/infoPageTemplate/media
    <Directory /home/opr/fake_wix/infoPageTemplate/media>
        Require all granted
    </Directory>

    <Directory /home/opr/fake_wix/infoPageTemplate/infopagetemplate>
        <Files wsgi.py>
            Require all granted
        </Files>
    </Directory>

    WSGIDaemonProcess infoPageTemplate python-home=/home/opr/fake_wix/fake_wixenv python-path=/home/opr/fake_wix/infoPageTemplate
    WSGIProcessGroup infoPageTemplate
    WSGIScriptAlias / /home/opr/fake_wix/infoPageTemplate/infopagetemplate/wsgi.py

</VirtualHost>

<VirtualHost *:443>
    # The ServerName directive sets the request scheme, hostname and port that
    # the server uses to identify itself. This is used when creating
    # redirection URLs. In the context of virtual hosts, the ServerName
    # specifies what hostname must appear in the request's Host: header to
    # match this virtual host. For the default virtual host (this file) this
    # value is not decisive as it is used as a last resort host regardless.
    # However, you must set it for any further virtual host explicitly.
    ServerName dawex-pol.pl
    ServerAlias www.dawex-pol.pl

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
    # error, crit, alert, emerg.
    # It is also possible to configure the loglevel for particular
    # modules, e.g.
    #LogLevel info ssl:warn

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    # For most configuration files from conf-available/, which are
    # enabled or disabled at a global level, it is possible to
    # include a line for only one particular virtual host. For example the
    # following line enables the CGI configuration for this host only
    # after it has been globally disabled with 'a2disconf'.
    #Include conf-available/serve-cgi-bin.conf

    Alias /static /home/opr/fake_wix/infoPageTemplate/static
    <Directory /home/opr/fake_wix/infoPageTemplate/static>
        Require all granted
    </Directory>

    Alias /media /home/opr/fake_wix/infoPageTemplate/media
    <Directory /home/opr/fake_wix/infoPageTemplate/media>
        Require all granted
    </Directory>

    <Directory /home/opr/fake_wix/infoPageTemplate/infopagetemplate>
        <Files wsgi.py>
            Require all granted
        </Files>
    </Directory>

    WSGIDaemonProcess infoPageTemplateSSL python-home=/home/opr/fake_wix/fake_wixenv python-path=/home/opr/fake_wix/infoPageTemplate
    WSGIProcessGroup infoPageTemplateSSL
    WSGIScriptAlias / /home/opr/fake_wix/infoPageTemplate/infopagetemplate/wsgi.py

</VirtualHost>" > "/etc/apache2/sites-available/dawex-pol.conf"

sudo a2ensite dawex-pol

echo "<VirtualHost *:80>
    # The ServerName directive sets the request scheme, hostname and port that
    # the server uses to identify itself. This is used when creating
    # redirection URLs. In the context of virtual hosts, the ServerName
    # specifies what hostname must appear in the request's Host: header to
    # match this virtual host. For the default virtual host (this file) this
    # value is not decisive as it is used as a last resort host regardless.
    # However, you must set it for any further virtual host explicitly.
    ServerName centrumangi.pl
    ServerAlias www.centrumangi.pl
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
    # error, crit, alert, emerg.
    # It is also possible to configure the loglevel for particular
    # modules, e.g.
    #LogLevel info ssl:warn

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    # For most configuration files from conf-available/, which are
    # enabled or disabled at a global level, it is possible to
    # include a line for only one particular virtual host. For example the
    # following line enables the CGI configuration for this host only
    # after it has been globally disabled with 'a2disconf'.
    #Include conf-available/serve-cgi-bin.conf

    <Directory /home/opr/fake_wix/testowy/testowy>
        <Files wsgi.py>
            Require all granted
        </Files>
    </Directory>

    WSGIDaemonProcess testowy python-home=/home/opr/fake_wix/fake_wixenv python-path=/home/opr/fake_wix/testowy
    WSGIProcessGroup testowy
    WSGIScriptAlias / /home/opr/fake_wix/testowy/testowy/wsgi.py

</VirtualHost>" > "/etc/apache2/sites-available/centrumangi.conf"

sudo a2ensite centrumangi

systemctl reload apache2

chmod 777 /home/opr/fake_wix/infoPageTemplate/db.sqlite3
chown :www-data /home/opr/fake_wix/infoPageTemplate/db.sqlite3
chown :www-data /home/opr/fake_wix/infoPageTemplate

apache2ctl configtest

systemctl restart apache2
exit
