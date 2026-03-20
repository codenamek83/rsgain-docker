# ------------------------------
# Stage 1: Build the rsgain binary
# ------------------------------
FROM alpine:3.23 AS build

# Set build argument for the upstream tag
ARG RSGAIN_VERSION

# Install build dependencies
RUN apk add --no-cache \
    ca-certificates \
    git \
    cmake \
    build-base \
    pkgconfig \
    libebur128-dev \
    taglib-dev \
    ffmpeg-dev \
    fmt-dev \
    inih-dev \
    zlib-dev && \
    rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /app

# Clone specific tag of rsgain and checkout
RUN git clone https://github.com/complexlogic/rsgain.git . && \
    git checkout ${RSGAIN_VERSION}

# Create build directory
RUN mkdir build
WORKDIR /app/build

# Build the project using CMake
RUN cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make

# ------------------------------
# Stage 2: Runtime image
# ------------------------------
FROM alpine:3.23

# Install runtime dependencies
RUN apk add --no-cache \
    libebur128-dev \
    taglib-dev \
    ffmpeg-dev \
    fmt-dev \
    inih-dev && \
    rm -rf /var/cache/apk/*

# Copy the compiled binary from build stage
COPY --from=build /app/build/rsgain /usr/bin/rsgain

# Copy configuration presets from build stage
COPY --from=build /app/config/presets /usr/local/share/rsgain/presets

# Copy your custom preset
COPY custom-preset01.ini /usr/local/share/rsgain/presets/custom-preset01.ini

# Set metadata label for version tracking
ARG RSGAIN_VERSION
LABEL org.opencontainers.image.version=$RSGAIN_VERSION

# Set the default command
ENTRYPOINT ["/usr/bin/rsgain"]