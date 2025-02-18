FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# The EXPOSE instruction serves multiple purposes:
# - Documents which port(s) the container will listen on at runtime
# - Acts as a form of documentation between image builder and image runner
# - Port 80 is the default HTTP port used by nginx
# - Does NOT actually publish the port to the host
# - Must still use -p or -P with 'docker run' to actually expose the port
# - In this case, exposes nginx's default HTTP port

COPY --from=builder /app/build /usr/share/nginx/html
