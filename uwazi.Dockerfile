# FROM redhat/ubi8:latest
FROM ubuntu:24.04

ENV WRK_DIR=uwazi

RUN apt update && apt install -y sendmail

# Install useful tools and get Uwazi latest version
RUN apt-get update && \
    apt-get install -y curl wget gnupg lsb-release ca-certificates software-properties-common poppler-utils tar && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn && \
    mkdir /${WRK_DIR} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install mongosh
RUN curl -LO https://downloads.mongodb.com/compass/mongosh-2.0.2-linux-x64.tgz && \
    tar -xzf mongosh-2.0.2-linux-x64.tgz && \
    mv mongosh-2.0.2-linux-x64 /opt/mongosh && \
    ln -s /opt/mongosh/bin/mongosh /usr/local/bin/mongosh && \
    rm -f mongosh-2.0.2-linux-x64.tgz

# Install mongorestore (MongoDB tools)
RUN curl -LO https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-100.9.4.tgz && \
    tar -xzf mongodb-database-tools-ubuntu2004-x86_64-100.9.4.tgz && \
    mv mongodb-database-tools-ubuntu2004-x86_64-100.9.4 /opt/mongodb-tools && \
    ln -s /opt/mongodb-tools/bin/* /usr/local/bin/ && \
    rm mongodb-database-tools-ubuntu2004-x86_64-100.9.4.tgz

WORKDIR /${WRK_DIR}

CMD [ "sleep","infinity"]