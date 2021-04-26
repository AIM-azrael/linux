[root@Shell project]# cat mysql_ .install. sh
#!/usr/bin/bash
#1.检查是否存在mysq1对应的软件包
rpm .install. _mysql(){
    rpm_ .check_ mysql=$(rpm -qalgrep mysql -community-serverlwc -1)
    rpm_ .check mysqL version= =$(rpm -qa I grep mysql -conmuni ty- server)
    if [ $rpm check _mysql -eq 0 ] ; then
        cat >/etc/yum. repos . d/mysql . repo<<- EOF
        [mysql57-communityJ
        name=MySQL 5.7 Community Server
        baseurl=http://repo.sysql.com/yum/mysql-5.7-community/e1/7/x86. .64
        enabled=1
        gpgcheck=1
        gpgkey=file///etc/pkl/rpm-gpg/RPM-GPG-XUY-mysql
        EOF
        yum clean all && yum makecache
        yum install -y mysql-community-server
    else
        echo “${rpm_check_mysql_version%-*) Installed Ok"
    fi
}
#初始fySQL数据库
clear_ mysql(){
    systemctl start mysqld
    if [ $? -eq 0 ];then
        Mysql_old_pass=$(grep "temporary passwond" /var/log/mysqld.1og |tall -n1|awk -F '[ :]' '{
        mysqledmin -uroot -p"$Mysql_old_pass" password "xul1angwe1.com123"
    fi
    }
rpm_install_mysql
clear_mysql

