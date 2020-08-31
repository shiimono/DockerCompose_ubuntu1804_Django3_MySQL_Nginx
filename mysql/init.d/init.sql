# データベース作成
CREATE DATABASE IF NOT EXISTS django_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
# ユーザー作成
CREATE USER IF NOT EXISTS 'django_user'@'%' IDENTIFIED BY 'djangopass';
# django_dbへのアクセス権を付与
GRANT ALL PRIVILEGES ON django_db.* TO 'django_user'@'%';
# 権限を反映
FLUSH PRIVILEGES;