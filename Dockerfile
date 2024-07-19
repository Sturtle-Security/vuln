FROM node:22.0.0-bullseye

# Set workdir
WORKDIR /app

# Install dependencies
RUN apt update -y && \
 apt install -y nmap sqlmap curl wget unzip && \
 mkdir -p reports

# Install nuclei
RUN wget https://github.com/projectdiscovery/nuclei/releases/download/v3.3.0/nuclei_3.3.0_linux_386.zip && \
 unzip nuclei_3.3.0_linux_386.zip && \
 mv nuclei /usr/local/bin/ && \
 nuclei -update-templates && \
 rm nuclei_3.3.0_linux_386.zip

# COPY code
COPY . /app

# Install node modules
RUN npm install

# Expose port
EXPOSE 3000

# Set ENTRYPOINT
ENTRYPOINT ["node", "server.js"]