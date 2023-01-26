# syntax=docker/dockerfile:1.4
FROM eclipse-temurin:17-jre

RUN <<EOF
  set -eu

  apt-get update
  apt-get install -y \
    wget \
    git \
    gosu
  apt-get clean
  rm -rf /var/lib/apt/lists/*

  groupadd -o -g 1000 user
  useradd -o -m -u 1000 -g user user
EOF

ARG BUILD_TOOLS_URL="https://hub.spigotmc.org/jenkins/job/BuildTools/152/artifact/target/BuildTools.jar"
RUN <<EOF
  set -eu

  mkdir /data
  wget -O "/data/BuildTools.jar" "${BUILD_TOOLS_URL}"
EOF

WORKDIR /work
ENTRYPOINT [ "gosu", "user", "java", "-jar", "/data/BuildTools.jar" ]
