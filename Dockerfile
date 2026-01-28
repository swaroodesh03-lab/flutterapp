# ---------- Stage 1: Build Flutter Web ----------
FROM cirrusci/flutter:stable AS build

WORKDIR /app
COPY . .

RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web

# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 8080
RUN sed -i 's/80/8080/g' /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
