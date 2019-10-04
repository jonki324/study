# Pipenv
## インストール
```
$ pip install pipenv
```

## 仮想環境の作成
```
$ pipenv --python 3.7
```

## 仮想環境に入る
```
$ pipenv shell
```

## 仮想環境から出る
```
$ exit
```

## 仮想環境の削除
```
$ pipenv --rm
```

## 仮想環境のパス
```
$ pipenv --venv
```

## 仮想環境をプロジェクトのディレクトリに作成
```
$ export PIPENV_VENV_IN_PROJECT=true
$ pipenv --python 3.7
```

## パッケージのインストール
```
$ pipenv install flask

$ pipenv install flask==1.0.0

$ pipenv install --dev autopep8 flake8
```

## パッケージのアンインストール
```
$ pipenv uninstall flask
```

## パッケージのアップデート
```
$ pipenv update
```

## パッケージの一覧
```
$ pipenv graph
```

## 仮想環境の再現
### Pipfileから再現
```
$ pipenv install

$ pipenv install --dev
```

### Pipfile.lockから再現
```
$ pipenv sync

$ pipenv sync --dev
```

### requirements.txtから再現
```
$ pipenv install -r ./requirements.txt
```

## スクリプトの登録
Pipfileに下記を追記
```
[scripts]
start = "python main.py runserver"
test = "python -m unittest discover -v"
format = "autopep8 -ivr ."
lint = "flake8 --show-source ."
```

```
$ pipenv run start

# スクリプトに登録しない場合
$ pipenv run python run.py
```
