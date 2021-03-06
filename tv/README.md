#TV Support

##Raspberry Pi

###Initial Configuration

Via UI, set the following:
- WIFI Country - Poland
- Timezone - Warsaw
- Keyboard - English US (Polish OK as well)
- Locale - English US (Polish OK as well)

###Disable Screen Saver / Screen Blank

Update the /etc/lightdm/lightdm.conf file and add in the [SeatDefaults] section the following command:

```
[SeatDefaults]
xserver-command=X -s 0 -dpms
```


###Install Chromium

```
sudo apt-get update

wget -qO - http://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -

echo "deb http://dl.bintray.com/kusti8/chromium-rpi jessie main" | sudo tee -a /etc/apt/sources.list

sudo apt-get update

sudo apt-get install chromium-browser -y
```

###Start Chromium in Kiosk Mode on Startup

Create a new .desktop file in ~/.config/autostart/, e.g.

```
sudo nano ~/.config/autostart/autoChromium.desktop
```

Add the following (replace id in the arkadia link with the correct display id):

```
[Desktop Entry]
Type=Application
Exec=/usr/bin/chromium-browser --noerrdialogs --disable-session-crashed-bubble --disable-infobars --kiosk https://apps.arkadiahotel.com.pl/cafe/kitchen_display?id=1
Hidden=false
X-GNOME-Autostart-enabled=true
Name[en_US]=AutoChromium
Name=AutoChromium
Comment=Start Chromium when GNOME starts
```

###Hide Mouse Cursor on Startup

Install unclutter:

```
sudo apt-get install x11-xserver-utils unclutter
```

Configure unclutter to hide mouse cursor by adding the following to /etc/xdg/lxsession/LXDE/autostart :

```
@unclutter -idle 0.1 -root
```
