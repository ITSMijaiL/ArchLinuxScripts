#EXECUTE THIS AFTER:
# - EXITTING CHROOT USING "exit"
# - UNMOUNTING /MNT USING "umount -R /mnt"
# - REBOOTING WITHOUT THE INSTALLATION MEDIA USING "reboot" (YOU CAN ALSO SHUTDOWN THE PC/VM USING "shutdown now" SO THAT YOU CAN REMOVE THE MEDIA)
# - BOOTING INTO THE NEW SYSTEM

#(THIS FILE IS COMPLETELY OPTIONAL)

#Make user
echo "Input username:"
read username_useradd
useradd $username_useradd -m -G wheel

#Download/install packages
pacman -S --noconfirm nano
pacman -S --noconfirm xorg
pacman -S --noconfirm linux-headers base-devel
pacman -S --noconfirm xfce4

pacman -S --noconfirm firefox
pacman -S --noconfirm sudo
pacman -S --noconfirm xorg-xinit

cat > /home/$username_useradd/.profile << "EOF"
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
EOF

#Make xinitrc so that xfce4 executes on boot
cat > /home/$username_useradd/.xinitrc << "EOF"
exec startxfce4
EOF

echo "You're good to go! Restart to boot into xfce4."
