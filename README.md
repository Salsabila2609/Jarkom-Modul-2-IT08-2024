# **Kelompok IT08**

## Anggota

- Salsabila Amalia Harjanto (5027221023)
- Ditya Wahyu ()

## Laporan Resmi Modul 2

### Topologi
---
### Config
- Erangel
  ```
  auto eth0
  iface eth0 inet dhcp
  
  auto eth1
  iface eth1 inet static
          address 192.237.1.1
          netmask 255.255.255.0
  
  auto eth2
  iface eth2 inet static
          address 192.237.2.1
          netmask 255.255.255.0
  ```
- Pochinki
  ```
  auto eth0
  iface eth0 inet static
        address 192.237.1.2
        netmask 255.255.255.0
        gateway 192.237.1.1
  ```
- GatkaTrenches
  ```
  auto eth0
  iface eth0 inet static
        address 192.237.1.3
        netmask 255.255.255.0
        gateway 192.237.1.1
  ```
- GatkaRadio
  ```
  auto eth0
  iface eth0 inet static
        address 192.237.1.4
        netmask 255.255.255.0
        gateway 192.237.1.1
  ```
- Georgopol
  ```
  auto eth0
  iface eth0 inet static
        address 192.237.1.5
        netmask 255.255.255.0
        gateway 192.237.1.1
  ```
- Stalber
  ```
  auto eth0
  iface eth0 inet static
        address 192.237.2.2
        netmask 255.255.255.0
        gateway 192.237.2.1
  ```
- Serverny
  ```
  auto eth0
  iface eth0 inet static
        address 192.237.2.3
        netmask 255.255.255.0
        gateway 192.237.2.1
  ```
- Lipovka
  ```
  auto eth0
  iface eth0 inet static
        address 192.237.2.4
        netmask 255.255.255.0
        gateway 192.237.2.1
  ```
- Mylta
  ```
  auto eth0
  iface eth0 inet static
        address 192.237.2.5
        netmask 255.255.255.0
        gateway 192.237.2.1
  ```
- Notes
  ```
  Erangel          : 192.237.1.1
  Pochinki         : 192.237.1.2
  GatkaTrenches    : 192.237.1.3
  GatkaRadio       : 192.237.1.4
  Georgopol        : 192.237.1.5
  Erangel          : 192.237.2.1
  Stalber          : 192.237.2.2
  Severny          : 192.237.2.3
  Lipovka          : 192.237.2.4
  Mylta            : 192.237.2.5
  ```
---
### Setup awal
- Router
  ```
  apt-get update
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.237.0.0/16
  ```
- DNS Master dan DNS Slave
  ```
  echo 'nameserver 192.168.122.1' > /etc/resolv.conf
  apt-get update
  apt-get install bind9 -y
  ```
- Web Server 
  ```
  echo 'nameserver 192.168.122.1' > /etc/resolv.conf
  apt-get update 
  apt-get install apache2 -y
  apt-get install php -y
  apt-get install unzip -y
  apt install nginx php php-fpm -y
  ```
- Load Balancer
  ```
  echo 'nameserver 192.168.122.1' > /etc/resolv.conf
  apt-get update 
  apt-get install apache2 -y
  apt install nginx php php-fpm -y
  ```
- Client
  ```
  nameserver 192.237.1.2 # IP Pochinki
  nameserver 192.237.1.5 # IP georgopol
  nameserver 192.168.122.1
  ' > /etc/resolv.conf
  apt-get update
  apt-get install dnsutils -y
  apt-get install lynx -y
  apt-get install apache2-utils -y
  ```
---

### Soal 1
> Untuk membantu pertempuran di Erangel, kamu ditugaskan untuk membuat jaringan komputer yang akan digunakan sebagai alat komunikasi. Sesuaikan rancangan Topologi dengan rancangan dan pembagian yang berada di link yang telah disediakan, dengan ketentuan nodenya sebagai berikut :
> - DNS Master akan diberi nama Pochinki, sesuai dengan kota tempat dibuatnya server tersebut
> - Karena ada kemungkinan musuh akan mencoba menyerang Server Utama, maka buatlah DNS Slave Georgopol yang mengarah ke Pochinki
> - Markas pusat juga meminta dibuatkan tiga Web Server yaitu Severny, Stalber, dan Lipovka. Sedangkan Mylta akan bertindak sebagai Load Balancer untuk server-server tersebut

#### Script
**Client (GatkaTrenches/GatkaRadio)**
```
ping google.com
```
---

### Soal 2
> Karena para pasukan membutuhkan koordinasi untuk mengambil airdrop, maka buatlah sebuah domain yang mengarah ke Stalber dengan alamat airdrop.xxxx.com dengan alias www.airdrop.xxxx.com dimana xxxx merupakan kode kelompok. Contoh : airdrop.it01.com

#### Script
**Pochinki**
```
echo 'zone "airdrop.it08.com" {
        type master;
        file "/etc/bind/jarkom/airdrop.it08.com";
};' >> /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/airdrop.it08.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     airdrop.it08.com. root.airdrop.it08.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      airdrop.it08.com.
@       IN      A       192.237.2.2     ; IP Stalber
www             IN      CNAME   airdrop.it08.com.
' > /etc/bind/jarkom/airdrop.it08.com

service bind9 restart
```
---

### Soal 3
> Para pasukan juga perlu mengetahui mana titik yang sedang di bombardir artileri, sehingga dibutuhkan domain lain yaitu redzone.xxxx.com dengan alias www.redzone.xxxx.com yang mengarah ke Severny

#### Script
**Pochinki**
```
echo 'zone "redzone.it08.com" {
        type master;
        file "/etc/bind/jarkom/redzone.it08.com";
};' >> /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/redzone.it08.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     redzone.it08.com. root.redzone.it08.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      redzone.it08.com.
@       IN      A       192.237.2.3     ; IP Severny
www     IN      CNAME   redzone.it08.com.
' > /etc/bind/jarkom/redzone.it08.com

service bind9 restart
```
---

### Soal 4
#### Script
> Markas pusat meminta dibuatnya domain khusus untuk menaruh informasi persenjataan dan suplai yang tersebar. Informasi persenjataan dan suplai tersebut mengarah ke Mylta dan domain yang ingin digunakan adalah loot.xxxx.com dengan alias www.loot.xxxx.com

**Pochinki**
```
echo 'zone "loot.it08.com" {
        type master;
        file "/etc/bind/jarkom/loot.it08.com";
};' >> /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/loot.it08.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     loot.it08.com. root.loot.it08.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      loot.it08.com.
@       IN      A       192.237.2.5     ; IP Mylta
www             IN      CNAME   loot.it08.com.
' > /etc/bind/jarkom/loot.it08.com

service bind9 restart
```
---

### Soal 5
> Pastikan domain-domain tersebut dapat diakses oleh seluruh komputer (client) yang berada di Erangel

#### Script
**Client (GatkaTrenches/GatkaRadio)**
```
ping airdrop.it08.com
ping www.airdrop.it08.com
```
```
ping redzone.it08.com
ping www.redzone.it08.com
```
```
ping loot.it08.com
ping www.loot.it08.com
```
---

### Soal 6
> Beberapa daerah memiliki keterbatasan yang menyebabkan hanya dapat mengakses domain secara langsung melalui alamat IP domain tersebut. Karena daerah tersebut tidak diketahui secara spesifik, pastikan semua komputer (client) dapat mengakses domain redzone.xxxx.com melalui alamat IP Severny (Notes : menggunakan pointer record)

















  
  

