#TV Support

##Raspberry Pi


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
