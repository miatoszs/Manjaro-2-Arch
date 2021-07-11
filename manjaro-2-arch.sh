#!/bin/bash

print_err() {
    echo ""
    echo "$*"
    echo ""
}
uid=$(id -u)
if [ $uid -ne 0 ]; then
    print_err "Please use sudo or run the script as root."
    exit 1
fi



echo '#' > /etc/pacman.conf
echo '# /etc/pacman.conf' >> /etc/pacman.conf
echo '#'
echo '# See the pacman.conf(5) manpage for option and repository directives' >> /etc/pacman.conf
echo '#' >> /etc/pacman.conf
echo '# GENERAL OPTIONS' >> /etc/pacman.conf
echo '#' >> /etc/pacman.conf
echo '[options]' >> /etc/pacman.conf
echo '# The following paths are commented out with their default values listed.' >> /etc/pacman.conf
echo '# If you wish to use different paths, uncomment and update the paths.' >> /etc/pacman.conf
echo '#RootDir     = /' >> /etc/pacman.conf
echo '#DBPath      = /var/lib/pacman/' >> /etc/pacman.conf
echo 'CacheDir = /var/cache/pacman/pkg/' >> /etc/pacman.conf
echo '#LogFile     = /var/log/pacman.log' >> /etc/pacman.conf
echo '#GPGDir      = /etc/pacman.d/gnupg/' >> /etc/pacman.conf
echo '#HookDir     = /etc/pacman.d/hooks/' >> /etc/pacman.conf
echo 'HoldPkg      = pacman glibc' >> /etc/pacman.conf
echo '# If upgrades are available for these packages they will be asked for first' >> /etc/pacman.conf
echo '# SyncFirst    = manjaro-system archlinux-keyring manjaro-keyring' >> /etc/pacman.conf
echo '#XferCommand = /usr/bin/curl -C - -f %u > %o' >> /etc/pacman.conf
echo '#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u' >> /etc/pacman.conf
echo '#CleanMethod = KeepInstalled' >> /etc/pacman.conf
echo '#UseDelta    = 0.7' >> /etc/pacman.conf
echo 'Architecture = auto' >> /etc/pacman.conf
echo "# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup" >> /etc/pacman.conf
echo '#IgnorePkg   =' >> /etc/pacman.conf
echo '#IgnoreGroup =' >> /etc/pacman.conf
echo "#NoUpgrade   =" >> /etc/pacman.conf
echo '#NoExtract   =' >> /etc/pacman.conf
echo '# Misc options' >> /etc/pacman.conf
echo '#UseSyslog' >> /etc/pacman.conf
echo 'Color' >> /etc/pacman.conf
echo '#TotalDownload' >> /etc/pacman.conf
echo '# We cannot check disk space from within a chroot environment' >> /etc/pacman.conf
echo 'CheckSpace' >> /etc/pacman.conf
echo 'SigLevel    = Never' >> /etc/pacman.conf
echo 'LocalFileSigLevel = Optional' >> /etc/pacman.conf
echo '[core]' >> /etc/pacman.conf
echo 'SigLevel = PackageRequired' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
echo '[extra]' >> /etc/pacman.conf
echo 'SigLevel = PackageRequired' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
echo '[community]' >> /etc/pacman.conf
echo 'SigLevel = PackageRequired' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
echo '[multilib]' >> /etc/pacman.conf
echo 'SigLevel = PackageRequired' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf







echo '##' > /etc/pacman.d/mirrolist
echo '## Arch Linux repository mirrorlist' >> /etc/pacman.d/mirrolist
echo '## Generated on 2021-07-11' >> /etc/pacman.d/mirrolist
echo '##' >> /etc/pacman.d/mirrolist
echo '## Hungary' >> /etc/pacman.d/mirrolist
echo 'Server = http://ftp.ek-cer.hu/pub/mirrors/ftp.archlinux.org/$repo/os/$arch' >> /etc/pacman.d/mirrolist
echo 'Server = http://archmirror.hbit.sztaki.hu/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrolist
echo 'Server = http://nova.quantum-mirror.hu/mirrors/pub/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrolist
echo 'Server = http://quantum-mirror.hu/mirrors/pub/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrolist
echo 'Server = http://super.quantum-mirror.hu/mirrors/pub/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrolist
echo 'Server = https://nova.quantum-mirror.hu/mirrors/pub/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrolist
echo 'Server = https://quantum-mirror.hu/mirrors/pub/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrolist
echo 'Server = https://super.quantum-mirror.hu/mirrors/pub/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrolist

sudo cp /etc/manjaro-release /etc/manjaro-release.bak
sudo pacman -Rns manjaro-release
sudo mv /etc/pacman-mirrors.conf /etc/pacman-mirrors.conf.bak


echo 'NAME="Arch Linux"' > /etc/os-release
echo 'PRETTY_NAME="Arch Linux"' >> /etc/os-release
echo 'ID=arch' >> /etc/os-release
echo 'BUILD_ID=rolling' >> /etc/os-release
echo 'ANSI_COLOR="20;2;20;222;202"' >> /etc/os-release
echo 'HOME_URL="https://www.archlinux.org/"' >> /etc/os-release
echo 'DOCUMENTATION_URL="https://wiki.archlinux.org/"' >> /etc/os-release
echo 'SUPPORT_URL="https://bbs.archlinux.org/"' >> /etc/os-release
echo 'BUG_REPORT_URL="https://bugs.archlinux.org/"' >> /etc/os-release
echo 'LOGO=archlinux' >> /etc/os-release


echo "Arch Linux \r (\l)" > etc/issue


echo 'LSB_VERSION=1.4' > /etc/lsb-release
echo 'DISTRIB_ID=Arch' >> /etc/lsb-release
echo 'DISTRIB_RELEASE=rolling' >> /etc/lsb-release
echo 'DISTRIB_DESCRIPTION="Arch Linux"' >> /etc/lsb-release

sudo pacman -Syyu 
sudo pacman -Scc && sudo pacman -S linux-lts linux-lts-headers acpi_call-dkms tlp pacman-mirrors grub 

sed -i s/Manjaro/Arch/g /etc/default/grub
update-grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot
