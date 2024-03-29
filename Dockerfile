ARG VER=latest
FROM ramirezfx/ubuntu-mate-baseimage-arm64:$VER
ENV SHELL=/bin/bash

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y git cups wget curl

# Create DATA-DIR
RUN mkdir /data && chmod 777 /data

# Install Multimedia-Codecs:
RUN apt-get install -y libxvidcore4 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-alsa gstreamer1.0-libav

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
