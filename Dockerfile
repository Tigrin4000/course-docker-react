# Use node:alpine as base image for the builder stage.
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Use nginx as base image for the run stage, the new FROM command ends the previous stage.
FROM nginx

# Copy the created /app/build folder from the image created in the builder stage.
# The nginx documentation shows that the webpage should be put in /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
