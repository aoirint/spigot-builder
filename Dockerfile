# syntax=docker/dockerfile:1.4
FROM eclipse-temurin:17-jre

RUN <<EOF
  set -eu

  apt-get update
  apt-get install -y \
    wget \
    git
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOF

ARG BUILD_TOOLS_URL="https://hub.spigotmc.org/jenkins/job/BuildTools/152/artifact/target/BuildTools.jar"
RUN <<EOF
  set -eu

  mkdir /data
  wget -O "/data/BuildTools.jar" "${BUILD_TOOLS_URL}"
EOF

WORKDIR /work
ENTRYPOINT [ "java", "-jar", "/data/BuildTools.jar" ]
