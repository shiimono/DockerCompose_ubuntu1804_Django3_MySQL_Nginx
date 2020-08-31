# Dockerfileの基本構文：https://qiita.com/soushiy/items/0945bcbc7ecce4822985
# PYTHONBUFFERED 1を入れる理由：https://hodalog.com/run-django-app-using-docker-compose/

FROM ubuntu:18.04

RUN apt-get update

# pythonをインストール
RUN apt-get install -y python3 python3-pip
ENV PYTHONUNBUFFERED 1
# mysqlclientライブラリのインストールに必要なmysql_configを用意するために必要
RUN apt-get install -y mysql-server
RUN apt-get install -y libmysqlclient-dev
# IPアドレスを見れるようにするために必要
RUN apt-get install -y iproute2
# ソースコードをcodeディレクトリに格納しマウントする & ライブラリインストール
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
# RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

ADD . /code/

