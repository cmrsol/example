FROM python:3.6
ARG VERSION
ARG BUCKET

RUN apt-get update; \
    apt-get -y install nginx; \
    pip install uwsgi; \
    mkdir /sock; \
    chmod 777 /sock;

COPY run_example_app.sh /run_example_app.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY app /app
RUN chmod 644 /app/*.ini

RUN mkdir -p /var/lib/nginx/tmp; \
    chmod 777 /var/lib/nginx/tmp

RUN pip install http://${BUCKET}/artifacts/example/example-${VERSION}-py3-none-any.whl

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["/run_example_app.sh"]
