Docker Image: CentOS - Python 3 and Apache with MOD WSGI
========================================================

Create a new docker image based on a Docker Hub **centos python3.x** one.
This image adds the Apache2 **httpd** server, **mod_wsgi** and **Python mod_wsgi Express**.

Python WSGI Applications
------------------------

This image may be used to build **Python WSGI applications**, such as **Django servers**.
Use **Python WSGI**, **Django**, or even **Flask** to make a Webserver.

Hello World WSGI Application
----------------------------

There is a sample **hello world** WSGI application service.

```bash
[user] docker compose up
```

Click on the [Hello World on localhost:8001](http://localhost:8001/) link.

```bash
[user] docker compose down
```

