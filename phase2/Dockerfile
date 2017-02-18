FROM centos:7
MAINTAINER "Matt Spurlin" <mattsp1290@gmail.com>

ENV container docker
ENV HOME /root
EXPOSE 80/tcp 443/tcp

# Install EPEL
RUN yum install -y epel-release yum-utils
RUN yum-config-manager --enable epel

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
                    nginx \
                    openssl-devel \
                    passenger \
                    patch \
                    readline-devel \
                    sqlite-devel \
                    systemd \
                    which \
                    zlib-devel

# Update packages
RUN yum update -y

# Copy config files
COPY docker/config/nginx.conf /etc/nginx/nginx.conf
COPY docker/config/passenger.conf /etc/nginx/conf.d/passenger.conf
COPY docker/config/app.conf /etc/nginx/conf.d/app.conf

RUN useradd app -g nginx -d /home/app
RUN mkdir -p /usr/share/nginx/app
RUN chown app:nginx /usr/share/nginx/app


# Install RVM
ENV rubyver 2.3.1
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN usermod -aG rvm app

# Change the working directory
USER app
WORKDIR /usr/share/nginx/app


# Install ruby
RUN source /etc/profile.d/rvm.sh
RUN bash -l -c "rvm install $rubyver"
RUN bash -l -c "rvm default $rubyver"

# Copy Rails Application
COPY app /usr/share/nginx/app/app
COPY bin /usr/share/nginx/app/bin
COPY config /usr/share/nginx/app/config
COPY db/migrate /usr/share/nginx/app/db/migrate
COPY db/schema.rb /usr/share/nginx/app/db/schema.rb
COPY db/seeds.rb /usr/share/nginx/app/db/seeds.rb
COPY lib /usr/share/nginx/app/lib
COPY public /usr/share/nginx/app/public
COPY config.ru /usr/share/nginx/app/config.ru
COPY Gemfile /usr/share/nginx/app/Gemfile
COPY Rakefile /usr/share/nginx/app/Rakefile

# Make log and tmp directories
RUN mkdir /usr/share/nginx/app/log
RUN mkdir /usr/share/nginx/app/tmp

# Install gems and prepare assets
RUN gem install bundler
RUN bundle install
RUN bundle exec rake assets:precompile RAILS_ENV=production
RUN bundle exec rake assets:environment RAILS_ENV=production
RUN bundle exec rake db:migrate RAILS_ENV=production
RUN bundle exec rake db:seed RAILS_ENV=production

# Start Nginx and keep it running
USER nginx
CMD /usr/sbin/nginx -g 'daemon off;'
