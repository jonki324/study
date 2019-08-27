# ufw
## インストール

### Raspberry pi
```bash
$ apt-get install ufw
```

### CentOS
- デフォルトのファイアーウォール無効
```bash
$ sudo systemctl status firewalld

$ sudo systemctl stop firewalld

$ sudo systemctl disable firewalld
```

- ダウンロードしてインストール
```
$ tar zxf ufw-0.35.tar.gz

$ cd ufw-0.35

$ python ./setup.py install

$ sudo chmod -R g-w /etc/ufw /lib/ufw /etc/default/ufw /usr/sbin/ufw
```

- 自動起動設定
```
$ vi /etc/rc.local
```
```
/lib/ufw/ufw-init start
```
```
$ chmod u+x /etc/rc.d/rc.local
```

## 起動
```bash
$ ufw enable
```

## 終了
```bash
$ ufw disable
```

## 再起動
```bash
$ ufw reload
```

## ステータス
```bash
$ ufw status

$ ufw status numbered
```

## デフォルト拒否
```bash
$ ufw default reject

$ ufw default deny
```

## 許可
```bash
$ ufw allow 22

$ ufw allow 22/tcp

$ ufw allow from 192.168.1.0/24 to any port 22

$ ufw allow from 192.168.1.0/24 to any port 22/tcp
```

## 削除
```bash
$ ufw delete 1
```

## よく使う設定一覧
```bash
# DNS
$ ufw allow from 192.168.1.0/24 to any port 53

# DHCP
$ ufw allow 67
$ ufw allow 68

# ssh
$ ufw allow from 192.168.1.0/24 to any port 22

# http
$ ufw allow 80
$ ufw allow 443

# Samba
$ ufw allow 137
$ ufw allow 138
$ ufw allow 139
$ ufw allow 445

# VPN
$ ufw allow 500
$ ufw allow 4500
$ ufw allow 5555
```
