# Note: when the rust version is changed also modify
# ci/rust-version.sh to pick up the new image tag
FROM rust:1.57.0

# Set user as root
USER root

# Add Google Protocol Buffers for Libra's metrics library.
ENV PROTOC_VERSION 3.8.0
ENV PROTOC_ZIP protoc-$PROTOC_VERSION-linux-x86_64.zip
ENV USER root

RUN set -x \
 && apt update \
 && apt-get install apt-transport-https \
 && echo deb https://apt.buildkite.com/buildkite-agent stable main > /etc/apt/sources.list.d/buildkite-agent.list \
 && apt-key adv --no-tty --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 32A37959C2FA5C3C99EFBC32A79206696452D198 \
 && curl -fsSL https://deb.nodesource.com/setup_current.x | bash - \
 && apt update \
 && apt install -y \
      buildkite-agent \
      clang \
      cmake \
      lcov \
      libudev-dev \
      mscgen \
      nodejs \
      net-tools \
      rsync \
      sudo \
      golang \
      unzip \
      \
 && apt remove -y libcurl4-openssl-dev \
 && rm -rf /var/lib/apt/lists/* \
 && node --version \
 && npm --version \
 && rustup component add rustfmt \
 && rustup component add clippy \
 && rustup target add wasm32-unknown-unknown \
 && cargo install cargo-audit \
 && cargo install mdbook \
 && cargo install mdbook-linkcheck \
 && cargo install svgbob_cli \
 && cargo install wasm-pack \
 && rustc --version \
 && cargo --version \
 && curl -OL https://github.com/google/protobuf/releases/download/v$PROTOC_VERSION/$PROTOC_ZIP \
 && unzip -o $PROTOC_ZIP -d /usr/local bin/protoc \
 && unzip -o $PROTOC_ZIP -d /usr/local include/* \
 && rm -f $PROTOC_ZIP

# Install the solana dev tools
RUN sh -c "$(curl -sSfL https://release.solana.com/v1.9.2/install)"

# Update PATH to take in account the new installation of solana
ENV PATH="/$USER/.local/share/solana/install/active_release/bin:$PATH"

# Set working directory
WORKDIR /home/$USER

# Create solana-bpf-program-template
RUN mkdir -p ./solana-bpf-program-template && mkdir -p ./solana-bpf-program-template/src

# Copy src folder to /home/solana-bpf
COPY src ./solana-bpf-program-template/src

# Copy Cargo.toml file
COPY Cargo.toml ./solana-bpf-program-template

# Add start up shell script
COPY docker/start.sh ./

# Run start up script
ENTRYPOINT ["./start.sh"]
