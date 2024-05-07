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
**Result**
![1](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/2e1bdbf0-0f0b-4b52-aac4-1f510c6e96e8)

![1 1](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/ed3ada31-a41d-4733-b5fc-ff2e7e82ac21)
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
**Result**
![2](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/d5e4b3a8-1e31-4c41-91f4-2ed45c04fc1d)
```
ping redzone.it08.com
ping www.redzone.it08.com
```
**Result**
![3](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/0f4885cd-2a8c-4926-a115-cce300a6ad7f)
```
ping loot.it08.com
ping www.loot.it08.com
```
**Result**
![4](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/30a17681-9ef5-446b-853e-7e76ba890e17)
---

### Soal 6
> Beberapa daerah memiliki keterbatasan yang menyebabkan hanya dapat mengakses domain secara langsung melalui alamat IP domain tersebut. Karena daerah tersebut tidak diketahui secara spesifik, pastikan semua komputer (client) dapat mengakses domain redzone.xxxx.com melalui alamat IP Severny (Notes : menggunakan pointer record)

#### Script
**Pochinki**
```
echo 'zone "2.237.192.in-addr.arpa" {
      type master;
      file "/etc/bind/jarkom/2.237.192.in-addr.arpa";
};
' > /etc/bind/named.conf.local
```
```
echo ';
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
2.237.192.in-addr.arpa. IN      NS      redzone.it08.com.
3       IN      PTR     redzone.it08.com.
' > /etc/bind/jarkom/2.237.192.in-addr.arpa

service bind9 restart
````
**Client (GatkaTrenches/GatkaRadio)**
```
host -t PTR 192.237.2.3
```
**Result**
![6](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/591a509b-16d8-43c2-a78e-d1070587097e)

---

### Soal 7
> Akhir-akhir ini seringkali terjadi serangan siber ke DNS Server Utama, sebagai tindakan antisipasi kamu diperintahkan untuk membuat DNS Slave di Georgopol untuk semua domain yang sudah dibuat sebelumnya

#### Script
**Pochinki**
```
echo 'zone "airdrop.it08.com" {
        type master;
        file "/etc/bind/jarkom/airdrop.it08.com";
        also-notify { 192.237.1.5; }; // IP Georgopol
        allow-transfer { 192.237.1.5; }; // IP Georgopol
};

zone "redzone.it08.com" {
        type master;
        file "/etc/bind/jarkom/redzone.it08.com";
        also-notify { 192.237.1.5; }; // IP Georgopol
        allow-transfer { 192.237.1.5; }; // IP Georgopol
};

zone "loot.it08.com" {
        type master;
        file "/etc/bind/jarkom/loot.it08.com";
        also-notify { 192.237.1.5; }; // IP Georgopol
        allow-transfer { 192.237.1.5; }; // IP Georgopol
};
' > /etc/bind/named.conf.local

service bind9 restart
service bind9 stop
```
![7 1](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/65f3b4ce-6af9-4891-9835-0c02d75a09f8)
**Georgopol**
```
echo 'zone "airdrop.it08.com" {
    type slave;
    masters { 192.237.1.2; }; // Masukan IP Pochinki
    file "/var/lib/bind/airdrop.it08.com";
};
zone "redzone.it08.com" {
    type slave;
    masters { 192.237.1.2; }; // Masukan IP Pochinki
    file "/var/lib/bind/redzone.it08.com";
};
zone "loot.it08.com" {
    type slave;
    masters { 192.237.1.2; }; // Masukan IP Pochinki
    file "/var/lib/bind/loot.it08.com";
};
' > /etc/bind/named.conf.local
```
**Client (GatkaTrenches/GatkaRadio)**
```
ping airdrop.it08.com
ping www.airdrop.it08.com
```
**Result**
![7 2](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/52c878f2-effb-44f7-9245-a37659dc08e3)
```
ping redzone.it08.com
ping www.redzone.it08.com
```
**Result**
![7 3](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/bc8a45d6-4436-482f-9d1b-a45815234a11)
```
ping loot.it08.com
ping www.loot.it08.com
```
**Result**
![7 4](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/9944a2a7-84ca-45a8-893c-9a67d60016f3)
---

### Nomor 8
> Kamu juga diperintahkan untuk membuat subdomain khusus melacak airdrop berisi peralatan medis dengan subdomain medkit.airdrop.xxxx.com yang mengarah ke Lipovka

#### Script
**Pochinki**
```
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
medkit  IN      A       192.237.2.4     ; IP Lipovka 
' > /etc/bind/jarkom/airdrop.it08.com
```
**Client (GatkaTrenches/GatkaRadio)**
```
ping medkit.airdrop.it08.com
```
**Result**
![8](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/5e5c3347-04c9-402d-8b7b-0409e6605016)
---

### Nomor 9
> Terkadang red zone yang pada umumnya di bombardir artileri akan dijatuhi bom oleh pesawat tempur. Untuk melindungi warga, kita diperlukan untuk membuat sistem peringatan air raid dan memasukkannya ke subdomain siren.redzone.xxxx.com dalam folder siren dan pastikan dapat diakses secara mudah dengan menambahkan alias www.siren.redzone.xxxx.com dan mendelegasikan subdomain tersebut ke Georgopol dengan alamat IP menuju radar di Severny

#### Script
**Pochinki**
```
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
ns1     IN      A       192.237.1.5     ; IP Georgopol 
siren   IN      NS      ns1
' > /etc/bind/jarkom/redzone.it08.com

echo "options {
    directory \"/var/cache/bind\";

    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options
```
**Georgopol**
```
echo 'zone "siren.redzone.it08.com" {
        type master;
        file "/etc/bind/siren/siren.redzone.it08.com";
};' >> /etc/bind/named.conf.local
cp /etc/bind/db.local /etc/bind/siren/siren.redzone.it08.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     siren.redzone.it08.com. root.siren.redzone.it08.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      siren.redzone.it08.com.
@       IN      A       192.237.2.3     ; IP Severny
www     IN      CNAME   siren.redzone.it08.com.
' > /etc/bind/siren/siren.redzone.it08.com

echo "options {
    directory \"/var/cache/bind\";
    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

service bind9 restart
```
**Client (GatkaTrenches/GatkaRadio)**
```
ping siren.redzone.it08.com
ping www.siren.redzone.it08.com
```
**Result**
![9](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/d24e86c7-ace2-45a6-9428-c7e8d7034e98)
---

### Nomor 10
> Markas juga meminta catatan kapan saja pesawat tempur tersebut menjatuhkan bom, maka buatlah subdomain baru di subdomain siren yaitu log.siren.redzone.xxxx.com serta aliasnya www.log.siren.redzone.xxxx.com yang juga mengarah ke Severny

### Script
**Pochinki**
```
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     siren.redzone.it08.com. root.siren.redzone.it08.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      siren.redzone.it08.com.
@       IN      A       192.237.2.3     ; IP Severny
www     IN      CNAME   siren.redzone.it08.com.
log     IN      A       192.237.2.3     ; IP Severny 
www.log IN      CNAME   log.siren.redzone.it08.com. 
' > /etc/bind/siren/siren.redzone.it08.com

service bind9 restart
```
**Client (GatkaTrenches/GatkaRadio)**
```
ping log.siren.redzone.it08.com
ping www.log.siren.redzone.it08.com
```
**Result**
![10](https://github.com/Salsabila2609/Jarkom-Modul-2-IT08-2024/assets/128382995/e2147477-9135-4a5c-bbae-a1a084f08b7e)
---

### Nomor 11
> Setelah pertempuran mereda, warga Erangel dapat kembali mengakses jaringan luar, tetapi hanya warga Pochinki saja yang dapat mengakses jaringan luar secara langsung. Buatlah konfigurasi agar warga Erangel yang berada diluar Pochinki dapat mengakses jaringan luar melalui DNS Server Pochinki

#### Script
**Pochinki**
```
echo "options {
    directory \"/var/cache/bind\";
    forwarders {
        "192.168.122.1";
    };
    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

service bind9 restart
```
**Client (GatkaTrenches/GatkaRadio)**
```
ping google.com
```
---

### Nomor 12
> Karena pusat ingin sebuah website yang ingin digunakan untuk memantau kondisi markas lainnya maka deploy lah webiste ini (cek resource yg lb) pada severny menggunakan apache

#### Script
**Severny**
```
apt-get update 
apt-get install apache2 -y
apt-get install php -y
apt-get install unzip -y

curl -L -o lb.zip --insecure "https://drive.google.com/uc?export=download&id=1xn03kTB27K872cokqwEIlk8Zb121HnfB"

unzip lb.zip
rm /var/www/html/index.html
cp worker/index.php /var/www/html/index.php
apt-get install libapache2-mod-php7.0

service apache2 start
```
**Client (GatkaTrenches/GatkaRadio)**
```
lynx http://192.237.2.3
```
---

### Nomor 13
> Tapi pusat merasa tidak puas dengan performanya karena traffic yag tinggi maka pusat meminta kita memasang load balancer pada web nya, dengan Severny, Stalber, Lipovka sebagai worker dan Mylta sebagai Load Balancer menggunakan apache sebagai web server nya dan load balancernya

#### Script
**Worker (Stalber/Severny/Lipovka)**
```
echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update 
apt-get install apache2 -y
apt-get install php -y
apt-get install unzip -y

curl -L -o lb.zip --insecure "https://drive.google.com/uc?export=download&id=1xn03kTB27K872cokqwEIlk8Zb121HnfB"

unzip lb.zip
rm /var/www/html/index.html
cp worker/index.php /var/www/html/index.php
apt-get install libapache2-mod-php7.0

service apache2 start
```
**Load balancer (Mylta)**
```
echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update 
apt-get install apache2 -y

a2enmod proxy
a2enmod proxy_balancer
a2enmod proxy_http
a2enmod lbmethod_byrequests

echo '<VirtualHost *:80>

<Proxy balancer://mycluster>
BalancerMember http://192.237.2.2/
BalancerMember http://192.237.2.3/
BalancerMember http://192.237.2.4/
ProxySet lbmethod=byrequests
</Proxy>

ProxyPass / balancer://mycluster/
ProxyPassReverse / balancer://mycluster/
</VirtualHost>
' > /etc/apache2/sites-available/000-default.conf

service apache2 start
```
**Client (GatkaTrenches/GatkaRadio)**
```
lynx http://192.173.2.2
lynx http://192.173.2.3
lynx http://192.173.2.4
lynx http://192.173.2.5
```
---

### Nomor 14
> Mereka juga belum merasa puas jadi pusat meminta agar web servernya dan load balancer nya diubah menjadi nginx

#### Script
**Worker (Stalber/Severny/Lipovka)**
```
service apache2 stop

apt install nginx php php-fpm -y

service php7.0-fpm start

echo 'server {
listen 80;

root /var/www/html;
index index.php index.html index.htm index.nginx-debian.html;

server_name _;

location / {
try_files $uri $uri/ /index.php?$query_string;
}

location ~ \.php$ {
include snippets/fastcgi-php.conf;
fastcgi_pass unix:/run/php/php7.0-fpm.sock;
}

location ~ /\.ht {
deny all;
}
}' > /etc/nginx/sites-enabled/default

service php7.0-fpm restart

service nginx restart
```
**Load balancer (Mylta)**
```
service apache2 stop

apt install nginx php php-fpm -y

echo 'upstream backend {
server 192.237.2.2; # IP Stalber
server 192.237.2.3; # IP Severny
server 192.237.2.4; # IP Lipovka
}

server {
listen 80;

location / {
proxy_pass http://backend;
}
}
' > /etc/nginx/sites-enabled/default

service nginx restart
```
**Client (GatkaTrenches/GatkaRadio)**
```
lynx http://192.173.2.2
lynx http://192.173.2.3
lynx http://192.173.2.4
lynx http://192.173.2.5
```
---

### Nomor 15
> Markas pusat meminta laporan hasil benchmark dengan menggunakan apache benchmark dari load balancer dengan 2 web server yang berbeda tersebut dan meminta secara detail dengan ketentuan:
> - Nama Algoritma Load Balancer
> - Report hasil testing apache benchmark 
> - Grafik request per second untuk masing masing algoritma
> - Analisis

#### Script
**Client (GatkaTrenches/GatkaRadio)**
```
ab -n 1000 -c 100 http://192.237.2.5/
```
---

### Nomor 16
> Karena dirasa kurang aman karena masih memakai IP, markas ingin akses ke mylta memakai mylta.xxx.com dengan alias www.mylta.xxx.com (sesuai web server terbaik hasil analisis kalian)

#### Script
**Pochinki**
```

echo 'zone "mylta.it08.com" {
        type master;
        file "/etc/bind/jarkom/mylta.it08.com";
};' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/mylta.it08.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     mylta.it08.com. root.mylta.it08.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      mylta.it08.com.
@       IN      A       192.237.2.5     ; IP Stalber
www             IN      CNAME   mylta.it08.com.
' > /etc/bind/jarkom/mylta.it08.com

service bind9 restart
```
**Mylta**
```
echo 'upstream backend {
server 192.237.2.2; # IP Stalber
server 192.237.2.3; # IP Severny
server 192.237.2.4; # IP Lipovka
}

server {
listen 80;
server_name mylta.it08.com www.mylta.it08.com; 

location / {
proxy_pass http://backend;
}
}
' > /etc/nginx/sites-enabled/default

service nginx restart
```
#### Script
**Client (GatkaTrenches/GatkaRadio)**
```
lynx http://mylta.it08.com
lynx http://www.mylta.it08.com
```
---

### Nomor 17
> Agar aman, buatlah konfigurasi agar mylta.xxx.com hanya dapat diakses melalui port 14000 dan 14400.

#### Script
**Mylta**
```
echo 'upstream backend {
server 192.237.2.2; # IP Stalber
server 192.237.2.3; # IP Severny
server 192.237.2.4; # IP Lipovka
}

server {
listen 14000;
listen 14400;
server_name mylta.it08.com www.mylta.it08.com; 

location / {
proxy_pass http://backend;
}
}
' > /etc/nginx/sites-enabled/default

service nginx restart
```
**Client (GatkaTrenches/GatkaRadio)**
```
lynx http://mylta.it08.com:14000
lynx http://www.mylta.it08.com:14000
lynx http://mylta.it08.com:14400
lynx http://www.mylta.it08.com:14400
```
---

### Nomor 18
> Apa bila ada yang mencoba mengakses IP mylta akan secara otomatis dialihkan ke www.mylta.xxx.com

#### Script
**Mylta**
```
echo 'upstream backend {
server 192.237.2.2; # IP Stalber
server 192.237.2.3; # IP Severny
server 192.237.2.4; # IP Lipovka
}

server {
listen 14000;
listen 14400; # nomor 17
server_name mylta.it08.com www.mylta.it08.com; # nomor 16

location / {
proxy_pass http://backend;
if ($host = 192.237.2.5) {
return 301 http://www.mylta.it08.com:14000$request_uri;
}
}
}
' > /etc/nginx/sites-enabled/default

service nginx restart
```
**Client (GatkaTrenches/GatkaRadio)**
```
lynx http://192.237.2.5:14000
```
---























  
  

