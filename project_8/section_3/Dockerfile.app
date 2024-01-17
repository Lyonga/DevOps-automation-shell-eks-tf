# Base image and build stage
FROM node:14-alpine as build
# Set the working directory
WORKDIR /app
# Copy package.json (and package-lock.json, if available) to the working directory
COPY package.json package-lock.json* ./
# Install the dependencies
RUN npm install
# Copy the rest of the application code
COPY . .

# Start the production stage
FROM node:14-alpine as prod
# Set the working directory
WORKDIR /app
# Copy only the necessary files from the previous stage
COPY --from=build /app ./
# Expose the app port
EXPOSE 3000
# Start the app
CMD ["npm", "start"]
