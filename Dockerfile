# Use a base image with Rust already installed
FROM rust:1.68.2-slim-buster

# Install dependencies for Windows cross-compilation
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc-mingw-w64-x86-64 \
    gcc-mingw-w64-i686

# Install the Windows targets
RUN rustup target add x86_64-pc-windows-gnu i686-pc-windows-gnu

# Set up environment variables for Windows cross-compilation
ENV CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc \
    CARGO_TARGET_I686_PC_WINDOWS_GNU_LINKER=i686-w64-mingw32-gcc
    
# Set the working directory
WORKDIR /usr/src/app

# Copy the source code
COPY . .
