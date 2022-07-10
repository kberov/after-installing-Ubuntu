# This is a log of executed commands, which can be sourced on your machine.
# The commands were collected over the internet.
# I log them for my self to execute ithem later on other newly installed machines.
# 2022-07-10 00:03 EEST
# Get this script:
cd ~/Downloads
wget https://raw.githubusercontent.com/kberov/after-installing-Ubuntu/main/xubuntu22_04.sh
# OR Install the gnome browser to get to this page and lately to easily "install web applications" with it.
# List all the snaps installed on your system
sudo apt install epiphany-browser

sudo apt udate
sudo apt upgrade
snap list
# Remove all installed snaps
sudo snap remove firefox gnome-3-38-2004 gtk-common-themes
sudo snap remove  bare
sudo snap remove  core20
snap list
# Remove any other snap package left...
sudo snap remove  snapd
# Disable and stop the service, and remove related apt packages
sudo systemctl disable snap
sudo systemctl stop snapd
# If the configs are left, apparmor crashes on startup in this case.
sudo apt remove --purge --assume-yes snapd gnome-software-plugin-snap
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
sudo rm -rf /var/cache/snapd/
# After successfully uninstalling snapd, make sure that it doesn't get
# installed again.
sudo apt-mark hold snapd
sudo apt remove --autoremove firefox

# Now Install Firefox and make the repo preferred for updates.
# Sources:
# https://www.omgubuntu.co.uk/2022/04/how-to-install-firefox-deb-apt-ubuntu-22-04
# https://fostips.com/ubuntu-21-10-two-firefox-remove-snap/
# https://balintreczey.hu/blog/firefox-on-ubuntu-22-04-from-deb-not-from-snap/

sudo add-apt-repository ppa:mozillateam/ppa
echo '
# Alter the Firefox package priority to ensure the PPA/deb/apt version of
# Firefox is preferred.
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

# And the lines below will block Firefox from Ubuntu’s own repository. Without
# this section, Firefox will go back SNAP once you disabled/removed the PPA and
# run system update. 

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

# Since you’ll (hopefully) want future Firefox upgrades to be installed
# automatically, Balint Reczey shares a concise command on his blog that
# ensures it happens:

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# Finally, install Firefox via apt by running this command:

sudo apt install firefox

# Install additional software - optional
sudo apt install vim-gtk3 exuberant-ctags fonts-dejavu-extra vim-doc \
    vlc gparted gnote gkbd-keyboard-display htop build-essential gcc


