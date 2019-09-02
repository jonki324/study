# 機械学習環境構築
## ホストマシン環境
### OS
```
$ cat /etc/os-release
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```

### GPU
```
$ lspci | grep -i nvidia
01:00.0 VGA compatible controller: NVIDIA Corporation GP102 [GeForce GTX 1080 Ti] (rev a1)

$ nvidia-smi
Fri Aug 30 10:49:54 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 390.116                Driver Version: 390.116                   |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 108...  Off  | 00000000:01:00.0  On |                  N/A |
|  0%   36C    P8    10W / 250W |    248MiB / 11177MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
```

### フォルダ構成
```
mlenv
├── README.md
├── docker
│   ├── Dockerfile
│   ├── matplotlibrc
│   ├── mlenv.yml
│   ├── mlenv_frozen.yml
│   ├── notebook.json
│   └── rcmod.py
├── docker-compose.yml
└── src
```

## Dockerfile
```Dockerfile
FROM nvidia/cuda:9.0-cudnn7-runtime

SHELL ["/bin/bash", "-c"]

# 日本語化
RUN apt-get update && apt-get install -y language-pack-ja-base language-pack-ja && \
    locale-gen ja_JP.UTF-8

ENV LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8

# Miniconda
ENV CONDAENV base
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git fonts-ipaexfont graphviz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo 'conda activate ${CONDAENV}' >> ~/.bashrc

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

# パッケージインストール
ENV CONDAENV mlenv

COPY mlenv_frozen.yml ./

RUN conda update -n base conda && \
    conda env create --file mlenv_frozen.yml

COPY matplotlibrc ./
COPY notebook.json ./
COPY rcmod.py ./

RUN /opt/conda/envs/mlenv/bin/jupyter contrib nbextension install --user && \
    /opt/conda/envs/mlenv/bin/jupyter nbextensions_configurator enable --user && \
    cp notebook.json /root/.jupyter/nbconfig/ && \
    cp matplotlibrc /opt/conda/envs/mlenv/lib/python3.6/site-packages/matplotlib/mpl-data/ && \
    cp rcmod.py /opt/conda/envs/mlenv/lib/python3.6/site-packages/seaborn/

WORKDIR /src

VOLUME /src

EXPOSE 6006 8888

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD /opt/conda/envs/mlenv/bin/jupyter notebook --notebook-dir=/src --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```

## docker-compose
```yaml
version: '3'
services:
  mlenv:
    build: ./docker
    ports:
      - "6006:6006"
      - "8888:8888"
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./.keras_datasets:/root/.keras/datasets
      - ./src:/src
```

## mlenv_frozen
```yaml
name: mlenv
channels:
  - conda-forge
  - defaults
dependencies:
  - _libgcc_mutex=0.1=main
  - asn1crypto=0.24.0=py36_0
  - attrs=19.1.0=py36_1
  - autopep8=1.4.4=py_0
  - backcall=0.1.0=py36_0
  - beautifulsoup4=4.8.0=py36_0
  - blas=1.0=mkl
  - bleach=3.1.0=py36_0
  - ca-certificates=2019.5.15=1
  - certifi=2019.6.16=py36_1
  - cffi=1.12.3=py36h2e261b9_0
  - chardet=3.0.4=py36_1003
  - cryptography=2.7=py36h1ba5d50_0
  - cycler=0.10.0=py36_0
  - dbus=1.13.6=h746ee38_0
  - decorator=4.4.0=py36_1
  - defusedxml=0.6.0=py_0
  - entrypoints=0.3=py36_0
  - expat=2.2.6=he6710b0_0
  - fontconfig=2.13.0=h9420a91_0
  - freetype=2.9.1=h8a8886c_1
  - glib=2.56.2=hd408876_0
  - gmp=6.1.2=h6c8ec71_1
  - gst-plugins-base=1.14.0=hbbd80ab_1
  - gstreamer=1.14.0=hb453b48_1
  - icu=58.2=h9c2bf20_1
  - idna=2.8=py36_0
  - intel-openmp=2019.4=243
  - ipykernel=5.1.2=py36h39e3cac_0
  - ipython=7.8.0=py36h39e3cac_0
  - ipython_genutils=0.2.0=py36_0
  - ipywidgets=7.5.1=py_0
  - isort=4.3.21=py36_0
  - jedi=0.15.1=py36_0
  - jinja2=2.10.1=py36_0
  - joblib=0.13.2=py36_0
  - jpeg=9b=h024ee3a_2
  - jsonschema=3.0.2=py36_0
  - jupyter=1.0.0=py36_7
  - jupyter_client=5.3.1=py_0
  - jupyter_console=6.0.0=py36_0
  - jupyter_contrib_core=0.3.3=py_2
  - jupyter_contrib_nbextensions=0.5.1=py36_0
  - jupyter_core=4.5.0=py_0
  - jupyter_highlight_selected_word=0.2.0=py36_1000
  - jupyter_latex_envs=1.4.4=py36_1000
  - jupyter_nbextensions_configurator=0.4.1=py36_0
  - kiwisolver=1.1.0=py36he6710b0_0
  - libedit=3.1.20181209=hc058e9b_0
  - libffi=3.2.1=hd88cf55_4
  - libgcc-ng=9.1.0=hdf63c60_0
  - libgfortran-ng=7.3.0=hdf63c60_0
  - libpng=1.6.37=hbc83047_0
  - libsodium=1.0.16=h1bed415_0
  - libstdcxx-ng=9.1.0=hdf63c60_0
  - libtiff=4.0.10=h2733197_2
  - libuuid=1.0.3=h1bed415_2
  - libxcb=1.13=h1bed415_1
  - libxml2=2.9.9=hea5a465_1
  - libxslt=1.1.33=h7d1a2b0_0
  - lxml=4.4.1=py36hefd8a0e_0
  - markupsafe=1.1.1=py36h7b6447c_0
  - matplotlib=3.1.1=py36h5429711_0
  - mistune=0.8.4=py36h7b6447c_0
  - mkl=2019.4=243
  - mkl-service=2.0.2=py36h7b6447c_0
  - mkl_fft=1.0.14=py36ha843d7b_0
  - mkl_random=1.0.2=py36hd81dba3_0
  - mlxtend=0.17.0=py_0
  - nbconvert=5.5.0=py_0
  - nbformat=4.4.0=py36_0
  - ncurses=6.1=he6710b0_1
  - notebook=6.0.0=py36_0
  - numpy=1.16.4=py36h7e9f1db_0
  - numpy-base=1.16.4=py36hde5b4d6_0
  - olefile=0.46=py36_0
  - openssl=1.1.1c=h7b6447c_1
  - pandas=0.25.1=py36he6710b0_0
  - pandoc=2.2.3.2=0
  - pandocfilters=1.4.2=py36_1
  - parso=0.5.1=py_0
  - patsy=0.5.1=py36_0
  - pcre=8.43=he6710b0_0
  - pexpect=4.7.0=py36_0
  - pickleshare=0.7.5=py36_0
  - pillow=6.1.0=py36h34e0f95_0
  - pip=19.2.2=py36_0
  - prometheus_client=0.7.1=py_0
  - prompt_toolkit=2.0.9=py36_0
  - ptyprocess=0.6.0=py36_0
  - pycodestyle=2.5.0=py36_0
  - pycparser=2.19=py36_0
  - pydotplus=2.0.2=py36_1
  - pygments=2.4.2=py_0
  - pyopenssl=19.0.0=py36_0
  - pyparsing=2.4.2=py_0
  - pyqt=5.9.2=py36h05f1152_2
  - pyrsistent=0.14.11=py36h7b6447c_0
  - pysocks=1.7.0=py36_0
  - python=3.6.9=h265db76_0
  - python-dateutil=2.8.0=py36_0
  - pytz=2019.2=py_0
  - pyyaml=5.1.2=py36h516909a_0
  - pyzmq=18.1.0=py36he6710b0_0
  - qt=5.9.7=h5867ecd_1
  - qtconsole=4.5.4=py_0
  - readline=7.0=h7b6447c_5
  - requests=2.22.0=py36_0
  - scikit-learn=0.21.2=py36hd81dba3_0
  - scipy=1.3.1=py36h7c811a0_0
  - seaborn=0.9.0=py36_0
  - send2trash=1.5.0=py36_0
  - setuptools=41.0.1=py36_0
  - sip=4.19.8=py36hf484d3e_0
  - six=1.12.0=py36_0
  - soupsieve=1.9.2=py36_0
  - sqlite=3.29.0=h7b6447c_0
  - statsmodels=0.10.1=py36hdd07704_0
  - terminado=0.8.2=py36_0
  - testpath=0.4.2=py36_0
  - tk=8.6.8=hbc83047_0
  - tornado=6.0.3=py36h7b6447c_0
  - traitlets=4.3.2=py36_0
  - urllib3=1.24.2=py36_0
  - wcwidth=0.1.7=py36_0
  - webencodings=0.5.1=py36_1
  - wheel=0.33.4=py36_0
  - widgetsnbextension=3.5.1=py36_0
  - xlrd=1.2.0=py36_0
  - xz=5.2.4=h14c3975_4
  - yaml=0.1.7=h14c3975_1001
  - yapf=0.28.0=py_0
  - zeromq=4.3.1=he6710b0_3
  - zlib=1.2.11=h7b6447c_3
  - zstd=1.3.7=h0b5b093_0
  - pip:
    - absl-py==0.8.0
    - astor==0.8.0
    - gast==0.2.2
    - grpcio==1.23.0
    - h5py==2.9.0
    - keras==2.2.5
    - keras-applications==1.0.8
    - keras-preprocessing==1.1.0
    - markdown==3.1.1
    - protobuf==3.9.1
    - tensorboard==1.12.2
    - tensorflow-gpu==1.12.0
    - termcolor==1.1.0
    - werkzeug==0.15.5
prefix: /opt/conda/envs/mlenv
```

## matplotlibrc
matplotlibの日本語化対応
```
# 193行目をコメントアウトし、下記を追記
font.family : IPAexGothic
```

## notebook.json
```json
{
  "load_extensions": {
    "jupyter-js-widgets/extension": true,
    "nbextensions_configurator/config_menu/main": true,
    "contrib_nbextensions_help_item/main": true,
    "codefolding/main": true,
    "livemdpreview/livemdpreview": true,
    "hinterland/hinterland": true,
    "execute_time/ExecuteTime": true,
    "varInspector/main": true,
    "toggle_all_line_numbers/main": true,
    "code_prettify/autopep8": true,
    "code_prettify/code_prettify": true,
    "code_prettify/isort": true,
    "highlight_selected_word/main": true,
    "ruler/main": true,
    "export_embedded/main": true,
    "snippets_menu/main": true,
    "collapsible_headings/main": true,
    "nbTranslate/main": true
  },
  "isort": {
    "button_icon": "fa-sort"
  },
  "code_prettify": {
    "button_icon": "fa-align-left"
  },
  "nbTranslate": {
    "sourceLang": "ja",
    "targetLang": "en",
    "displayLangs": [
      "en",
      "ja"
    ]
  }
}
```

## rcmod.py
seabornの日本語化対応
```
# 92, 93行目をコメントアウトし、下記を追記
def set(context="notebook", style="darkgrid", palette="deep",
        font="IPAexGothic", font_scale=1, color_codes=True, rc=None):

# 204, 205行目をコメントアウトし、下記を追記
"font.family": ["IPAexGothic"],
                    "Bitstream Vera Sans", "IPAexGothic"],
```

## インストールしたパッケージ
```
$ conda install -y numpy pandas matplotlib jupyter seaborn scikit-learn Pillow requests beautifulsoup4 lxml xlrd pydotplus autopep8 yapf isort
$ conda install -y -c conda-forge mlxtend jupyter_contrib_nbextensions
$ pip install -y tensorflow-gpu==1.12.0 keras
```
