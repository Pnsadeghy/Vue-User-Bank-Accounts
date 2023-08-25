# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
RUN npm i -g npm-run-all
COPY package*.json ./
RUN npm i

COPY . .
ENV NODE_ENV=production
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]