FROM node:12-alpine as builder

WORKDIR /app
COPY ["package.json","yarn.lock", "./"]

RUN yarn install --frozen-lockfile
RUN rm -f .npmrc
COPY . .
RUN yarn build

FROM nginx:1.20.1-alpine
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build  /usr/share/nginx/html
EXPOSE 80