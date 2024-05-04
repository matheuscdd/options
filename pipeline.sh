#!/bin/bash

USER=$(ls /home)
sudo apt update && sudo apt upgrade -y
sudo apt remove -y xfce4-terminal
sudo snap refresh
sudo flatpak update -y
sudo apt install -y jq bat xclip flameshot gpick wmctrl xdotool xbindkeys playerctl fonts-cascadia-code

sudo flatpak install --noninteractive flathub io.dbeaver.DBeaverCommunity rest.insomnia.Insomnia org.chromium.Chromium com.obsproject.Studio us.zoom.Zoom com.mongodb.Compass com.github.hluk.copyq com.vixalien.sticky com.brave.Browser org.onlyoffice.desktopeditors

sudo snap install code --classic 
sudo snap install code-insiders --classic 
sudo snap install node --classic 
sudo snap install shotcut --classic 
sudo snap install gh --classic 

# ulaucher
sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt install ulauncher -y

# python
sudo apt install -y software-properties-common 
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.10 python3.10-venv python3.10-dev
python3.10 --version

# Firefox Dev
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt update && sudo apt install firefox-devedition 

# chrome-dev
https://www.google.com/chrome/dev/next-steps.html?installdataindex=empty&statcb=0&defaultbrowser=0

# Docker
sudo apt update
sudo apt install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
sudo usermod -aG docker claus

# aws
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure


# Atalhos de teclado
sudo wget -P "/home/$USER/.config/xfce4/xfconf/xfce-perchannel-xml" 'https://raw.githubusercontent.com/matheuscdd/options/main/xfce4-keyboard-shortcuts.xml'

# Ícone menu iniciar
wget 'https://raw.githubusercontent.com/matheuscdd/options/main/assets/xfce4-zorinmenulite-symbolic.svg'
sudo cp xfce4-zorinmenulite-symbolic.svg /usr/share/icons/hicolor/scalable/apps
sudo cp xfce4-zorinmenulite-symbolic.svg /usr/share/icons/hicolor/symbolic/apps

# Ícone notas
wget 'https://raw.githubusercontent.com/matheuscdd/options/main/assets/com.vixalien.sticky.svg'
sudo cp com.vixalien.sticky.svg /var/lib/flatpak/exports/share/icons/hicolor/scalable/apps
gtk-update-icon-cache -ft "/home/$USER/.local/share/icons/hicolor"

# Ajustar atalho mongo e firefox
str=$(cat <<EOF
#!/bin/bash

rawWindow=$(xdotool getactivewindow getwindowname)
IFS="-"
read -ra handleWindow <<< "$rawWindow"
xbindkeys
if [[ "${handleWindow[0]}" == "MongoDB Compass " ]]; then
	sleep 0.1 && xdotool key 0xff0d
else
	killall xbindkeys
	sleep 0.1
	xdotool key --clearmodifiers "Control+Return"
fi
IFS=""
sleep 0.1
xbindkeys

EOF
)

sudo echo "$str" > /usr/local/bin/mongoenter.sh && sudo chmod +x /usr/local/bin/mongoenter.sh

str=$(cat <<EOF
#!/bin/bash

has=$(xdotool getactivewindow getwindowname | grep -q "Firefox" && echo "1" || "2")

xbindkeys
if [[ -n "$has" ]]; then
	sleep 0.1 && xdotool key --clearmodifiers "Control+Shift+P"
else
	killall xbindkeys
	sleep 0.1
	xdotool key --clearmodifiers "Control+Shift+N"
fi
sleep 0.1
xbindkeys

EOF
)

sudo echo "$str" > /usr/local/bin/firo.sh
sudo chmod +x /usr/local/bin/firo.sh

str=$(cat <<EOF
"/usr/local/bin/mongoenter.sh"
  Control + Return
  
"/usr/local/bin/mongoenter.sh"
  Control + KP_Enter
  
"/usr/local/bin/firo.sh"
  Control + Shift + N
EOF
)

sudo echo "$str" > "/home/$USER/.xbindkeysrc"

# Ajustar atalhos de teclado
str=$(cat <<EOF
keycode 18 = parenleft
keycode 19 = parenright
keycode 134 = braceleft
keycode 135 = braceright
EOF
)

sudo echo "$str" > "/home/$USER/.Xmodmap"
xmodmap "/home/$USER/.Xmodmap"

# Sticky
str=$(cat <<EOF
#!/bin/bash

sleep 30 && 
EOF
)

sudo echo "$str" > /usr/local/bin/sticky.sh
sudo chmod 777 /usr/local/bin/sticky.sh

str=$(cat <<EOF
[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=Sticky
Comment=
Exec=/usr/local/bin/sticky.sh
OnlyShowIn=XFCE;
RunHook=0
StartupNotify=false
Terminal=false
Hidden=false
EOF
)
sudo echo "$str" > "/home/$USER/.config/autostart/Sticky.desktop"
sudo chmod +x "/home/$USER/.config/autostart/Sticky.desktop"

# numlock
str=$(cat <<EOF
[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=numlock
Comment=
Exec=sleep 20 && numlockx on
OnlyShowIn=XFCE;
RunHook=0
StartupNotify=false
Terminal=false
Hidden=false
EOF
)
sudo echo "$str" > "/home/$USER/.config/autostart/numlock.desktop"
sudo chmod +x "/home/$USER/.config/autostart/numlock.desktop"

# Atualizar o bashrc
# TODO preciso ajustar para só dar o append no atual
sudo wget -P "/home/$USER/" 'https://raw.githubusercontent.com/matheuscdd/options/main/.bashrc'

# Inserir ícones
ICONS="/home/$USER/Desktop"
wget -P "$ICONS" 'https://raw.githubusercontent.com/matheuscdd/options/main/icons_l/Firefox%20Developer%20Edition.desktop'
file="$ICONS/Firefox Developer Edition.desktop"
sudo chmod +x "$file" 
sudo mv "$file" '/usr/share/applications/'
wget -P "$ICONS" 'https://raw.githubusercontent.com/matheuscdd/options/main/icons_l/com.mongodb.Compass.desktop'
wget -P "$ICONS" 'https://raw.githubusercontent.com/matheuscdd/options/main/icons_l/com.slack.Slack.desktop'
wget -P "$ICONS" 'https://raw.githubusercontent.com/matheuscdd/options/main/icons_l/google-chrome-unstable.desktop'
wget -P "$ICONS" 'https://raw.githubusercontent.com/matheuscdd/options/main/icons_l/io.dbeaver.DBeaverCommunity.desktop'
wget -P "$ICONS" 'https://raw.githubusercontent.com/matheuscdd/options/main/icons_l/xfce4-terminal-emulator.desktop'

sudo reboot