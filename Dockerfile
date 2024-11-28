# Etapa 1: Build de la app Angular
FROM node:18.19.0 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm install -g @angular/cli
RUN ng build --configuration production

# Etapa 2: Configuración de Nginx
FROM nginx:stable
COPY --from=build /app/dist/hola/browser /usr/share/nginx/html
COPY --from=build /app/dist/hola/browser/index.csr.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
