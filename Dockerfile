FROM nginx

RUN apt-get update -y \
    && apt-get install -y curl

WORKDIR /usr/share/nginx/html

COPY application/index.html .

EXPOSE 80
