FROM ubuntu:22.04

# Update package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    apt-transport-https \
    wget \
    gnupg

# Add UniFi source list
RUN echo 'deb [ arch=amd64 ] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list

# Add GPG key
RUN wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg

# Install MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | apt-key add - && \
    echo "deb [trusted=yes] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Install UniFi
RUN apt-get update && apt-get install -y unifi

# Expose necessary ports
EXPOSE 8080 8443 8880 8843 6789

# Start UniFi service
CMD ["/bin/bash", "-c", "service unifi start && tail -f /dev/null"]
