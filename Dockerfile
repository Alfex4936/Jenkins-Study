# Use a base image with Rust already installed
FROM rust:1.68.2-slim-buster

# Install cross and its dependencies
RUN cargo install cross && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc-multilib \
        g++-multilib \
        libc6-dev-i386

# Set the working directory
WORKDIR /usr/src/app

# Copy the source code
COPY . .
