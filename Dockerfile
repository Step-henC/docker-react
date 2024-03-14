FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
#output of build is in .../app/build


# copy into directory on nginx docker hub page instructions
# starting container starts nginx for us
# multistep process avoids bulky node_modules and source code

FROM nginx

#need to expose for elasticbeanstalk
#does nothing for us as developer
#just informs dev on what port to map
#but elasticbeanstalk uses it to port map
EXPOSE 80 

COPY --from=builder /app/build /usr/share/nginx/html

# remember nginx uses port 80
# so in port mapping -p <my port>:80




