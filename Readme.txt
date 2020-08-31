参考：https://chibashi.me/development/docker-compose-django-202004/

【自分の情報】
◆ホスト環境
　Windows 10 home 2004 64bit
　VSCode 1.48.2
　Docker version 19.03.13-beta2
　docker-compose version 1.26.2
◆コンテナ環境
　Python(ubuntu 18.04 LTS)
　　python==3.6
　　django==3.1
　　uwsgi==2.0.19.1
　　mysqlclient==2.0.1
　MySQL
　　MySQL 5.7
　Nginx
　　nginx 1.17

「Djangoプロジェクトを作成」までは参考通り

Remote-Container
django-admin.pyが存在しないので、
vscodeでRemote-containerを開いてから　django-admin startproject mysite　でプロジェクトを作成する
※Remote-containerを開く際、mysqlclientライブラリのインストールに必要なmysql_configを用意するために
　pythonディレクトリのDockerfileに下記コマンドの追加が必要だった
        RUN apt-get install -y mysql-server
        RUN apt-get install -y libmysqlclient-dev


【VSCodeでのリモート開発手順】
・Docker Desktopを起動
・VSCodeでプロジェクトフォルダにコード一式クローン
・VSCodeにRemote-development拡張機能を追加
・VSCode左下の緑のボタンを押し、Remote-ContainerのOpen folderを選択し、出てきた画面がプロジェクトフォルダ直下であることを確認しOK
・VSCodeでリモートコンテナに入れたら完了
【Djangoでの開発手順】
・VSCodeでリモートコンテナに入った後、Djangoプロジェクトを立ち上げる
        django-admin startproject プロジェクト名
・docker-compose.ymlの「mysite」を上記で設定したプロジェクト名に変更
・プロジェクト内のsettings.pyを編集
        # データベースへの接続設定を変更
        DATABASES = {
        'default': {
                'ENGINE': 'django.db.backends.mysql',
                'NAME': 'django_db',
                'USER': 'django_user',
                'PASSWORD': 'djangopass',
                'PORT': '3306',
                'HOST': 'db',
        }
        }

        # Static files (CSS, JavaScript, Images)
        STATIC_URL = '/static/'
        STATIC_ROOT = '/static/'　# ←追加します
・プロジェクト内のsettings.pyを編集2(IPアドレスを設定して管理者はトップページも見れるようにする)
        ALLOWED_HOSTS = ["192.168.64.8",]
・Djangoのデータベース構築と管理者ユーザー作成
        # DBマイグレーション
        python manage.py migrate
        # 管理者の設定
        python manage.py createsuperuser
・静的ファイルをコピー
        cssやjavascriptなどの静的ファイルがあればstaticディレクトリにコピー
・VSCodeの左下の緑のボタンから Remote-ContainerのRebuildを実行しコンテナに設定を反映させる
------------------------------