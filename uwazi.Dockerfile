FROM redhat/ubi8:latest

ENV WRK_DIR=uwazi

# Install useful tools and get UWAZI latest version
RUN dnf install -y wget tar curl gnupg epel-release poppler-utils && \
    dnf module install -y nodejs:20 && \
    npm install --global yarn &&\
    mkdir /${WRK_DIR} && \
    cd /${WRK_DIR} && \
    wget https://github.com/huridocs/uwazi/releases/latest/download/uwazi.tgz && \
    tar xvf uwazi.tgz && \
    mv prod latest && rm uwazi.tgz && \
    dnf clean all


######################
# we also need to add the installation of pdftotext 
# **pdftotext (Poppler)** tested to work on version 0.86 but it's recommended to use the [latest available for your platform](https://poppler.freedesktop.org/). 
######################

# Install mongosh
RUN curl -LO https://downloads.mongodb.com/compass/mongosh-2.0.2-linux-x64.tgz && \
    tar -xzf mongosh-2.0.2-linux-x64.tgz && \
    mv mongosh-2.0.2-linux-x64 /opt/mongosh && \
    ln -s /opt/mongosh/bin/mongosh /usr/local/bin/mongosh && \
    rm -f mongosh-2.0.2-linux-x64.tgz

# Install mongorestore (MongoDB tools)
RUN curl -LO https://fastdl.mongodb.org/tools/db/mongodb-database-tools-rhel80-x86_64-100.9.4.tgz && \
    tar -xzf mongodb-database-tools-rhel80-x86_64-100.9.4.tgz && \
    mv mongodb-database-tools-rhel80-x86_64-100.9.4 /opt/mongodb-tools && \
    ln -s /opt/mongodb-tools/bin/* /usr/local/bin/ && \
    rm mongodb-database-tools-rhel80-x86_64-100.9.4.tgz

WORKDIR /${WRK_DIR}/latest

CMD [ "node","server.js","--no-experimental-fetch" ]