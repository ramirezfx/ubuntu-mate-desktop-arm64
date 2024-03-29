# Renove Snap-Version of Firefox and Install latest DEB-Version
# ------------------------------

snap remove firefox
apt-get remove -y firefox
add-apt-repository -y ppa:mozillateam/ppa
echo "Package: *" > /etc/apt/preferences.d/mozilla-firefox
echo "Pin: release o=LP-PPA-mozillateam" >> /etc/apt/preferences.d/mozilla-firefox
echo "Pin-Priority: 1001" >> /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
apt install -y firefox
mv /usr/share/applications/firefox.desktop /usr/share/applications/static-firefox.desktop

# Download and install Chromium Webbrowser
# ----------------------------------------
apt-get remove -y chromium-browser
add-apt-repository -y ppa:saiarcot895/chromium-beta
apt-get update -y
apt-get install -y chromium-browser

# Install Seafile-Cloud-Sync-Client
# ---------------------------------

wget https://linux-clients.seafile.com/seafile.asc -O /usr/share/keyrings/seafile-keyring.asc
OSRELEASE=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d "=" -f2)
if [ $OSRELEASE == 'jammy'  ]
then
 echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/seafile-keyring.asc] https://linux-clients.seafile.com/seafile-deb/jammy/ stable main' > /etc/apt/sources.list.d/seafile.list
fi
apt update
apt install -y seafile-gui

# Install Visual Studio
# -----------------------
# To Get the download-link, install the Video-Download-Helper-Plugin for your browser. Navigate to https://code.visualstudio.com.
# Navigate to the bottom and dowload the arm-64 Version manually. Then use the Video-Download-Helper to get the link and paste it below:

wget -O /tmp/vstudio.deb "https://az764295.vo.msecnd.net/stable/97dec172d3256f8ca4bfb2143f3f76b503ca0534/code_1.74.3-1673284080_arm64.deb" && apt-get install /tmp/vstudio.deb

# Install duplicati-backup

wget -O /tmp/duplicati.deb "https://updates.duplicati.com/beta/duplicati_2.0.6.3-1_all.deb" && apt-get install -y /tmp/duplicati.deb

# Install Webapp-Manager
# ----------------------

wget -O /tmp/webapp-manager.deb "http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.2.8_all.deb" && apt-get install -y http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.2.8_all.deb

# Install KMyMoney
# ----------------

apt install -y kmymoney breeze

# Cleanup
# -------
apt remove snapd
rm -Rf /var/cache/apt/archives
rm -Rf /var/lib/snapd
