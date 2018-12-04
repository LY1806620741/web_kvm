#!/bin/sh

if [ ! -f "/webvirtmgr/webvirtmgr.sqlite3" ]; then

/usr/bin/python /webvirtmgr/manage.py syncdb --noinput
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@localhost', 'admin')" | /usr/bin/python /webvirtmgr/manage.py shell

fi

