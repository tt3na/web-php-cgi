FROM almalinux:9

ENV LANG ja_JP.UTF-8
ENV TZ Asia/Tokyo

RUN groupadd -g 1000 pi
RUN useradd --uid 1000 --gid 1000 --shell /bin/bash -G pi pi

RUN ulimit -n 1024000 && yum update -y
RUN yum install -y httpd python3 php nodejs mysql vim

COPY ./php.ini /etc/php.ini
COPY ./www.conf /etc/php-fpm.d/www.conf
RUN mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.bak

WORKDIR /home/pi

CMD ["/home/pi/entrypoint.sh"]
