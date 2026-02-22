# Use a lightweight Node.js base image
FROM node:lts-alpine

# Install mosh and necessary networking tools
RUN apk add --no-cache mosh

# Install Northflank CLI globally via npm
RUN npm install -g @northflank/cli

# Set working directory
WORKDIR /app

# Optional: Copy package files and install application dependencies
# COPY package*.json ./
# RUN npm install

# Copy the rest of the application code
# COPY . .

# Default command
CMD ["bash"]
