FROM node:24-slim AS build
WORKDIR /app
COPY src/package*.json .
RUN npm install
COPY src/ .
ARG REACT_APP_API_URL=http://localhost:8080
ENV REACT_APP_API_URL=$REACT_APP_API_URL
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80