ARG VER=latest
FROM ramirezfx/ubuntu-mate-baseimage-arm64:$VER
ENV SHELL=/bin/bash

RUN apt-get update
RUN apt-get install -y git cups wget

# Create DATA-DIR
RUN mkdir /data && chmod 777 /data


# Download latest nomachine-server
RUN wget -O /tmp/nomachine.deb "https://www.nomachine.com/free/arm/v8/deb" && apt-get install -y /tmp/nomachine.deb

# ADD nxserver.sh
RUN wget -O /nxserver.sh https://github.com/ramirezfx/ubuntu-mate-desktop-arm64/raw/main/nxserver.sh && chmod +x /nxserver.sh

# Custom Packages And Sripts:
RUN wget -O /custom.sh https://github.com/ramirezfx/ubuntu-mate-desktop-arm64/raw/main/custom.sh && chmod +x /custom.sh

# Add Language-Support:
RUN wget -O /tmp/languages.txt https://github.com/ramirezfx/ubuntu-mate-desktop-arm64/raw/main/languages.txt && xargs -a /tmp/languages.txt apt-get install -y
RUN rm -Rf /etc/localtime

RUN /custom.sh

ENTRYPOINT ["/nxserver.sh"]
