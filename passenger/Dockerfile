FROM centos:7
MAINTAINER "Matt Spurlin" <mattsp1290@gmail.com>

ENV rubyver 2.3.1
ENV container docker
EXPOSE 80/tcp 443/tcp

# Install EPEL
RUN yum install -y epel-release yum-utils
RUN yum-config-manager --enable epel
RUN yum clean all && yum update -y

# Install Various Repositories
RUN yum install -y  autoconf \
                    automake \
                    bison \
                    bzip2\
                    curl \
                    gcc-c++ \
                    git \
                    glibc-devel \
                    glib-headers \
                    initscripts \
                    libffi-devel \
                    libtool \
                    libyaml-devel \
                    openssl-devel \
                    patch \
                    pygpgme \
                    readline-devel \
                    sqlite-devel \
                    systemd \
                    which \
                    zlib-devel

# Update packages
RUN yum update -y

# Install Nginx with Passenger modules
RUN curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
RUN yum install -y nginx passenger || yum-config-manager --enable cr && yum install -y nginx passenger

# Give nginx a nice comfy directory to store its pid
RUN mkdir /run/nginx
RUN chown nginx:nginx /run/nginx
RUN chown nginx:nginx /run/passenger-instreg

# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable


# Create app user
RUN useradd -m -g nginx -s /bin/bash app
RUN usermod -g wheel app
RUN usermod -g rvm app
RUN usermod -g rvm nginx

USER app
# Install ruby
RUN bash -l -c "rvm install $rubyver"
RUN bash -l -c "rvm default $rubyver"
RUN bash -l -c "gem install bundler"

# Copy config files
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/passenger.conf /etc/nginx/conf.d/passenger.conf
COPY config/app.conf /etc/nginx/conf.d/app.conf

USER root
RUN mkdir -p /usr/share/nginx/app
RUN chown app:nginx /usr/share/nginx/app

# Start Nginx and keep it running
USER nginx
CMD /usr/sbin/nginx -g 'daemon off;'
