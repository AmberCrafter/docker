echo `service mysql status`
echo `MySQL設定導入中...`
mysql < /root/mysql.sql
mysql < /root/privileges.sql
echo `MySQL設定導入完畢`
service mysql restart