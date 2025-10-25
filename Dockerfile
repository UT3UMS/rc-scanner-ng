# rc-scanner/Dockerfile
FROM node:18-bullseye

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    portaudio19-dev \
    python3 \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set environment flags to bypass Naudiodon compile issues
ENV CXXFLAGS="-Wno-error -Wno-unused-variable -Wno-mismatched-new-delete"

# Set working directory
WORKDIR /usr/src/app

# Copy package.json first for caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the app
COPY . .

# Default command
CMD ["npm", "run", "start"]
