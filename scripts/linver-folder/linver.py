#!/usr/bin/python3
"""
Forked from linver 1.0.0 - made by @techguy16 
Probably the best recreation of Winver for Linux
"""

import sys
import os
import socket
import distro

from PyQt6.QtWidgets import QApplication, QWidget, QLabel, QPushButton
from PyQt6.QtGui import QPixmap, QFont

# Sistem bilgilerini dosyalardan alıyoruz.
os.system('uname -r > version.txt')
with open('version.txt') as version_file:
    version = "Kernel build " + version_file.read().strip()

os.system('echo $USER > username.txt')
with open('username.txt') as user_file:
    username = user_file.read().strip()

hostname = socket.gethostname()
distrov = distro.name()
titlebartext = "About " + distrov
distrover = distro.version()
distrocode = distro.codename()
distroversion = "Version " + distrover + " (" + distrocode + ")"

# Distro isimlerine göre düzenleme
if distrov == 'Pop!_OS':
    distrov = 'System76 Pop!_OS'
elif distrov == 'Ubuntu':
    distrov = 'Canonical Ubuntu'
elif distrov == 'Kali GNU/Linux':
    distrov = 'Offensive Security Kali Linux'
elif distrov == 'openSUSE':
    distrov = 'SUSE openSUSE'

# Uygulama ve ana pencere
app = QApplication(sys.argv)
window = QWidget()
window.setWindowTitle(titlebartext)
window.setFixedSize(450, 420)

# Resim seçimi: distrov'ya göre uygun resmi yüklüyoruz.
if distrov == 'System76 Pop!_OS':
    pixmap = QPixmap('assets/PopOS.png')
elif distrov == 'Canonical Ubuntu':
    pixmap = QPixmap('assets/Ubuntu.png')
elif distrov == 'Linux Mint':
    pixmap = QPixmap('assets/LinuxMint.png')
elif distrov == 'Manjaro':
    pixmap = QPixmap('assets/Manjaro.png')
elif distrov == 'Arch Linux':
    pixmap = QPixmap('assets/ArchLinux.png')
else:
    pixmap = QPixmap("assets/Linux.png")

# Resim için etiket oluşturma
label_image = QLabel(window)
label_image.setPixmap(pixmap.scaled(430, 90))
label_image.setGeometry(10, 10, 430, 90)

# Diğer etiketler ve konumlandırmaları
distrolabel = QLabel(distrov, window)
distrolabel.setGeometry(20, 115, 400, 20)
distrolabel.setFont(QFont("Arial", 10))

distrover_label = QLabel(distroversion, window)
distrover_label.setGeometry(20, 135, 400, 20)
distrover_label.setFont(QFont("Arial", 10))

kernelver_label = QLabel(version, window)
kernelver_label.setGeometry(20, 155, 400, 20)
kernelver_label.setFont(QFont("Arial", 10))

licensetext = QLabel("The Linux kernel is protected under the GNU General Public\nLicence in the United States and other countries/regions.", window)
licensetext.setGeometry(20, 200, 410, 40)
licensetext.setWordWrap(True)
licensetext.setFont(QFont("Arial", 9))

tolicense = QLabel("This product is registered to:", window)
tolicense.setGeometry(20, 260, 400, 20)
tolicense.setFont(QFont("Arial", 10))

usernametext = QLabel(username, window)
usernametext.setGeometry(50, 280, 400, 20)
usernametext.setFont(QFont("Arial", 10))

hostnametext = QLabel(hostname, window)
hostnametext.setGeometry(50, 300, 400, 20)
hostnametext.setFont(QFont("Arial", 10))

# Kapatma düğmesi
okbutton = QPushButton('OK', window)
okbutton.setGeometry(345, 377, 80, 30)
okbutton.clicked.connect(window.close)

window.show()
sys.exit(app.exec())
