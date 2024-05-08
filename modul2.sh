#!/bin/bash
if [[ $(hostname) = "Erangel" ]]; then
    apt-get update
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.237.0.0/16

elif [[ $(hostname) = "Pochinki" ]]; then
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y

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

# nomor 20

echo 'zone "tamat.it08.com" {
        type master;
        file "/etc/bind/jarkom/tamat.it08.com";
};' >> /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/jarkom/tamat.it08.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     tamat.it08.com. root.tamat.it08.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      tamat.it08.com.
@       IN      A       192.237.2.2     ; IP Stalber
www             IN      CNAME   tamat.it08.com.
' > /etc/bind/jarkom/tamat.it08.com

service bind9 restart

# nomor 2 & 8
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
medkit  IN      A       192.237.2.4     ; IP Lipovka 
' > /etc/bind/jarkom/airdrop.it08.com

service bind9 restart

# nomor 3 & 9
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
ns1     IN      A       192.237.1.5     ; IP Georgopol 
siren   IN      NS      ns1
' > /etc/bind/jarkom/redzone.it08.com

service bind9 restart

# nomor 4
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

# nomor 6

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


# nomor 7

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

zone "2.237.192.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/2.237.192.in-addr.arpa";
};

zone "mylta.it08.com" {
        type master;
        file "/etc/bind/jarkom/mylta.it08.com";
};

zone "tamat.it08.com" {
        type master;
        file "/etc/bind/jarkom/tamat.it08.com";
};
' > /etc/bind/named.conf.local

service bind9 restart

# nomor 9
echo "options {
    directory \"/var/cache/bind\";

    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

service bind9 restart

# nomor 11
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

elif [[ $(hostname) = "Georgopol" ]]; then
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y

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

echo 'zone "siren.redzone.it08.com" {
        type master;
        file "/etc/bind/siren/siren.redzone.it08.com";
};' >> /etc/bind/named.conf.local

mkdir /etc/bind/siren

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

# nomor 10
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

elif [[ $(hostname) = "Stalber" ]]; then
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

# service apache2 start

# nomor 14

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


elif [[ $(hostname) = "Severny" ]]; then
echo 'nameserver 192.168.122.1' > /etc/resolv.conf

# nomor 12
apt-get update 
apt-get install apache2 -y
apt-get install php -y
apt-get install unzip -y

curl -L -o lb.zip --insecure "https://drive.google.com/uc?export=download&id=1xn03kTB27K872cokqwEIlk8Zb121HnfB"

unzip lb.zip
rm /var/www/html/index.html
cp worker/index.php /var/www/html/index.php
apt-get install libapache2-mod-php7.0

# service apache2 start

apt install nginx php php-fpm -y

service php7.0-fpm start

# nomor 14

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

elif [[ $(hostname) = "Lipovka" ]]; then
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

# service apache2 start

# nomor 14

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

# nomor 13
elif [[ $(hostname) = "Mylta" ]]; then
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

# service apache2 restart

# nomor 14

apt install nginx php php-fpm -y

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

elif [[ $(hostname) = "GatkaTrenches" ]]; then
echo -e '
nameserver 192.237.1.2 # IP Pochinki
nameserver 192.237.1.5 # IP georgopol
nameserve 192.168.122.1
' > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
apt-get install apache2-utils -y

# nomor 15

# ab -n 1000 -c 100 http://192.237.2.5/

elif [[ $(hostname) = "GatkaRadio" ]]; then
echo -e '
nameserver 192.237.1.2 # IP Pochinki
nameserver 192.237.1.5 # IP georgopol
nameserver 192.168.122.1
' > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
apt-get install apache2-utils -y

# nomor 15

# ab -n 1000 -c 100 http://192.237.2.5/

fi
