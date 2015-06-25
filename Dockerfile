FROM node:0.12.5

# Add source
ADD gulpfile.coffee package.json /src/
COPY client/partials /src/client/partials
COPY client/src /src/client/src
COPY client/styles /src/client/styles
COPY client/vendor /src/client/vendor
COPY server/src /src/server/src
COPY server/views /src/server/views

ENV PORT 8080
EXPOSE $PORT

# Build
WORKDIR /src/
RUN npm install --production --unsafe-perm

CMD ["npm", "run", "production"]
