## Set our base image ##
FROM sgtcoder/cups-core:latest

COPY configs/sources.list /etc/apt/sources.list

## Install Required Packages ##
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --no-install-recommends wget curl nano vim gnupg gnupg2

## Install gpg keys ##
RUN mkdir -p /root/.gnupg && chmod 700 /root/.gnupg
RUN mkdir -p /etc/apt/keyrings && install -m 0755 -d /etc/apt/keyrings
RUN gpg --no-default-keyring --keyring /etc/apt/keyrings/sgtcoder.gpg --recv-keys --keyserver keys.openpgp.org C8474B01E3419C94
RUN chown _apt /etc/apt/keyrings/*.gpg

## Setup Repos ##
RUN echo "deb [arch=amd64,i386 signed-by=/etc/apt/keyrings/sgtcoder.gpg] https://repo.sgtcoder.com/debian stable main" > /etc/apt/sources.list.d/sgtcoder.list

## Install Packages ##
RUN apt-get update && apt-get install -y --no-install-recommends dcp7065dnlpr cupswrapperdcp7065dn \
    apt-utils \
    usbutils \
    printer-driver-all \
    printer-driver-cups-pdf \
    printer-driver-foo2zjs \
    openprinting-ppds \
    hpijs-ppds \
    hp-ppd \
    hplip

## Cleanup ##
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
