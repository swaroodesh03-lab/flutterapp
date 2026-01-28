FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY build/web /usr/share/nginx/html

EXPOSE 8080
RUN sed -i 's/80/8080/g' /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]