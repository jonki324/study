# Ubuntu 18.04 LTS

## インストールUSB作成
1. USBを接続後、デバイスパスを確認
```bash
$ diskutil list
```
2. USBをアンマウント（Nはデバイスパス番号）
```bash
$ diskutil unMountDisk /dev/diskN
```
3. ddコマンドでインストールUSBの作成（Nはデバイスパス番号）
```bash
$ cd ~/Downloads
$ sudo dd if=xxxxx.iso of=/dev/rdiskN bs=1m
```
4. USBの取り外し（Nはデバイスパス番号）
```bash
$ diskutil eject /dev/diskN
```

## インストール
1. BIOSの設定でUSB起動を有効にする
1. [Ubuntuをインストール]を選択
1. [キーボードレイアウト]日本語を設定
1. [アップデートをその他のソフトウェア]下記をチェック
    - 最小インストール
    - Ubuntuのインストール中にアップデートをダウンロードする
    - グラフィックスとWi-Fiハードウェアと追加のメディアフォーマットのサードパーティ製ソフトウェアをインストールする
1. [インストールの種類]下記をチェック
    - ディスクを削除してUbuntuをインストール
1. タイムゾーンをTokyo（日本標準時）に設定
1. ユーザー情報を入力

## 初期設定

### パッケージのアップデート
```bash
$ sudo apt update && sudo apt upgrade -y

$ sudo add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"
```

### rootのパスワード設定
```bash
$ sudo passwd root
```

### SSH設定
```bash
$ sudo apt install -y ssh

$ sudo vi /etc/ssh/sshd_config

Port 22
PermitRootLogin no

$ sudo systemctl restart sshd
```
### ファイアーウォール設定
```bash
$ ufw enable

$ ufw default deny

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

$ ufw reload
```

### Wake On Lan
- インストール
```bash
$ sudo apt install ethtool
```
- 現在の状態確認
```bash
$ sudo ethtool enp3s0
```
- 設定
```bash
$ sudo ethtool -s enp3s0 wol g
```
- 自動起動設定
```bash
# 設定スクリプト作成
$ sudo vi ~/wol/wakeonlan.sh
```
```
#! /bin/bash
ethtool -s enp3s0 wol g
```
```bash
$ sudo chmod 755 ~/wol/wakeonlan.sh
```
```bash
# Service登録
$ sudo vi /etc/systemd/system/wakeonlan.service
```
```
[Unit]
Description = wake on lan daemon

[Service]
ExecStart = /home/user/wol/wakeonlan.sh
Restart = always
Type = simple

[Install]
WantedBy = multi-user.target
```
```bash
# 自動起動設定
$ sudo systemctl list-unit-files --type=service | grep wakeonlan

$ sudo systemctl enable wakeonlan

$ sudo systemctl start wakeonlan

$ sudo systemctl status wakeonlan
```
- 起動方法
```bash
$ sudo apt install wakeonlan

$ wakeonlan XX:XX:XX:XX:XX:XX
```

## GPUドライバインストール
```bash
$ sudo ubuntu-drivers autoinstall

$ sudo reboot

# ドライバの確認
$ nvidia-smi
```

## Dockerインストール
- リポジトリの追加
```bash
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo apt-key fingerprint 0EBFCD88
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
- Dockerのインストール
```bash
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io

# Dockerの確認
$ sudo docker run hello-world
```
- ユーザーをdockerグループへ追加
```bash
$ sudo usermod -aG docker $USER
```
## Nvidia-Docker構築
- リポジトリの追加
```bash
$ curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
$ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```
- nvidia-docker2インストール
```bash
$ sudo apt-get update
$ sudo apt-get install nvidia-docker2
$ sudo pkill -SIGHUP dockerd

$ sudo systemctl restart docker
```
- インストール確認
```bash
$ vi Dockerfile
```
```
FROM nvidia/cuda:9.0-cudnn7-runtime

RUN apt update && apt install -y python3-pip
RUN pip3 install tensorflow-gpu==1.12.0 keras

RUN apt install -y wget
RUN wget https://raw.githubusercontent.com/fchollet/keras/master/examples/mnist_cnn.py

CMD ["python3", "/mnist_cnn.py"]
```
- 起動して確認
```bash
$ docker build . -t mnist
$ docker run --runtime=nvidia --rm -it mnist
```
- 別ターミナルでGPUの使用率確認すること
```bash
$ nvidia-smi
```

## docker-composeインストール
- インストール
```bash
$ sudo apt install docker-compose
$ docker-compose -v
```
- デフォルトランタイム変更
```bash
$ sudo vi /etc/docker/daemon.json
```
```
{
    "default-runtime": "nvidia",  # この行を追加
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```
- 起動確認
```bash
$ vi docker-compose.yml
```
```
version: '3'
services:
  mnist:
    build: .
```

## 参考
- [Mac で Ubuntu 18.04 のインストールUSBメモリスティックの作成](https://qiita.com/sei1tani/items/d731d1a7165a42c0df65)
- [Ubuntu 18.04 LTSインストールガイド【スクリーンショットつき解説】](https://linuxfan.info/ubuntu-18-04-install-guide)
- [nvidia-dockerを使用してGPU環境構築](https://qiita.com/gen10nal/items/1e7fe8a1b2e9ad1e7919)
- [Docker公式ドキュメント](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- [Nvidia-Docker公式ドキュメント](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-2.0))
