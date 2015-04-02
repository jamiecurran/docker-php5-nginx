FROM ubuntu:latest
MAINTAINER jay.curran@gmail.com
RUN apt-get -qq update
RUN apt-get -qq -y install php5-common php5-cli php5-fpm nginx supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf
RUN sed -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' -i /etc/php5/fpm/php.ini
RUN rm -v /etc/nginx/sites-available/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD default /etc/nginx/sites-available/
ADD php /usr/share/nginx/html/
EXPOSE 80
CMD ["/usr/bin/supervisord"]
