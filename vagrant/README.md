# Vagrantまとめ
## インストール
```
$ brew cask install virtualbox
$ brew cask install vagrant
$ vagrant -v
Vagrant 2.2.4
```
## Vagrant操作
### ubuntuのBoxファイル取得と設定ファイルの初期化
```
$ vagrant init ubuntu/bionic64
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
```

### 仮想マシンの起動
```
$ vagrant up
```

### 状態確認
```
$ vagrant status
```

### 全仮想マシンの状態確認
```
$ vagrant global-status
```

### 接続
```
$ vagrant ssh
```

### 停止
```
$ vagrant halt
```

### 再起動
```
$ vagrant reload
```

### 一時停止
```
$ vagrant suspend
```

### 再開
```
$ vagrant resume
```

### 仮想マシンの破棄
```
$ vagrant destroy
```
## Box関連操作
### Box取得
```
$ vagrant box add {title} {url}
$ vagrant init {title}
```

### Box一覧
```
$ vagrant box list
centos/7        (virtualbox, 1804.02)
ubuntu/bionic64 (virtualbox, 20180802.0.0)
```

### Box更新
```
$ vagrant box update
```

### Box削除
```
$ vagrant box remove ubuntu/bionic64 --box-version 20180802.0.0
```

### Box作成
```
$ vagrant package
```

## Vagrantfile

### 内容の検証
```
$ vagrant validate
```

### ネットワーク設定
- ポートフォワード
- プライベート
- パブリック
```
config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
```
```
config.vm.network "private_network", ip: "192.168.33.10"
```
```
config.vm.network "public_network"
```

### 共有フォルダ
```
config.vm.synced_folder "../data", "/vagrant_data"
```

### GUI設定、メモリの容量変更
```
config.vm.provider "virtualbox" do |vb|
  # Display the VirtualBox GUI when booting the machine
  vb.gui = true

  # Customize the amount of memory on the VM:
  vb.memory = "1024"
end
```

### プロビジョニング
#### インライン(1行)
```
config.vm.provision "shell", inline: "echo hello"
```

#### インライン(複数行)
```
config.vm.provision "shell", inline: <<-SHELL
  apt-get update
  apt-get install -y apache2
SHELL
```

#### スクリプトを実行
```
config.vm.provision "shell", path: "script.sh"
```

#### プロビジョニング再実行
```
$ vagrant provision
```

#### プロビジョニング実行しない
```
$ vagrant up --no-provision
$ vagrant reload --no-provision
```

## スナップショット
### スナップショット一覧
```
$ vagrant snapshot list
```

### スナップショット作成
```
$ vagrant snapshot push

# 保存名指定
$ vagrant snapshot save snap1
```

### スナップショット復元
```
$ vagrant snapshot pop

# 保存名指定
$ vagrant snapshot restore snap1
```

### スナップショット削除
```
$ vagrant snapshot delete snap1
```

## 複数の仮装マシン操作
Vagrantfileに設定を記述する
```
$ vi Vagrantfile
```
```
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.define :web do | web |
    web.vm.hostname = "web"
    web.vm.network :private_network, ip: "192.168.33.10"
    
    # vagrant-hostsの設定
    web.vm.provision :hosts
  end

  config.vm.define :db do | db |
    db.vm.hostname = "db"
    db.vm.network :private_network, ip: "192.168.33.20"

    # vagrant-hostsの設定
    db.vm.provision :hosts
  end

end
```

### それぞれのステータス確認
```
$ vagrant status web
```

### 接続
```
$ vagrant ssh web
```

## プラグイン関連操作
### プラグインの追加
```
$ vagrant plugin install vagrant-hostsupdater  # ゲストOSの情報をホストOSのhostsに追加
$ vagrant plugin install vagrant-hosts  # ゲストOSのhostsに自動追加
$ vagrant plugin install vagrant-vbguest  # Guest Additionの自動更新
$ vagrant plugin install vagrant-proxyconf  # ゲストOSにホストOSのプロキシー情報を設定
```

### プラグインの一覧
```
$ vagrant plugin list
```

### プラグインの更新
```
$ vagrant plugin update
```

### プラグインの削除
```
$ vagrant plugin uninstall vagrant-hostsupdater
```

## プロキシー設定(vagrant-proxyconf)
```
$ vi Vagrantfile
```
```
if Vagrant.has_plugin?("vagrant-proxyconf") && ENV['http_proxy']
    puts '- Proxy Setting ----------------------------------'
    puts ENV['http_proxy']
    config.proxy.http     = ENV['http_proxy']
    config.proxy.https    = ENV['https_proxy']
    config.proxy.no_proxy = "localhost,127.0.0.1"
    puts '--------------------------------------------------'
end
```
