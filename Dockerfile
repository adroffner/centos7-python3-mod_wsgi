# CentOS 7 - Python 3 and Apache/MOD_WSGI (See mod_wsgi-express)
# =============================================================================
# Use Docker Hub Base Image.
# =============================================================================
FROM centos/python-38-centos7

# HTTP Proxy Settings
# =============================================================================
# These may be needed to reach public repositories.
# =============================================================================
## ENV http_proxy="http://one.proxy.example.com:8080"
## ENV https_proxy="http://one.proxy.example.com:8080"
## ENV HTTP_PROXY="http://one.proxy.example.com:8080"
## ENV HTTPS_PROXY="http://one.proxy.example.com:8080"

USER root

# Install Apache2 for use from port 80.
# =============================================================================
RUN yum -y install httpd
RUN yum -y install httpd-devel
RUN systemctl enable httpd.service

# Install mod_wsgi-express over Apache2.
# =============================================================================
RUN pip install mod_wsgi

RUN yum -y clean all

# "apache" runs a sample "hello world" WSGI script.
# =============================================================================
WORKDIR /home/apache
COPY ./hello.wsgi ./hello.wsgi

# Start an "application container"
# =============================================================================
# Web service is run by "apache" user (No USER apache required)
# =============================================================================
EXPOSE 8001
ENTRYPOINT mod_wsgi-express start-server hello.wsgi \
    --user apache --maximum-requests=250 \
    --access-log \
    --access-log-format "[hello-world][%>s] %h %l %u %b \"%{Referer}i\" \"%{User-agent}i\" \"%r\"" \
    --error-log-format  "[hello-world][%l] %M" \
    --log-to-terminal --log-level DEBUG \
    --host 0.0.0.0 --port 8001
