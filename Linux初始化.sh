#!/usr/bin/bash
#1.配置yum源，安装基础软件
RepO(){
rm -rf /etc/yum.repos.d/*.repo
wget -0 /etc/yum.repos.d/Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -0 /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7. repo
yum clean all && yum makecache
yum install vim nc iotop iftop glances dstat telnet wget -y
yum update && rm -rf /etc/yum. repos.d/Cent0S*
}
#2.调整文件描述符
limit(){
cat > /etc/security/Limits.d/20-nproc.conf<<-EOF
		* soft nproc 65535
		* hard nproc 65535
		* soft nofile 65535
		* hard nofile 65535
		EOF
}

#3.调整基本配置
Mod(){
#调整时区
test -f /etc/localtime && rm -f /etc/localtime
ln -S /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#调整语言
sed -i 's#LANG=.*#LANG="en_US.UTF-8"#g' /etc/locale. conf
#关闭ipv6
cd /etc/modprobe.d/ && touch ipv6.conf
cat >/etc/modprobe.d/ipv6.conf <<-EOF
	alias net-pf-10 off
	alias ipv6 off
EOF
#调整历史命令
sed -i '/HISTSIZE=/cHISTSIZE=100000' /etc/profile
grep -q 'HISTTIMEFORMAT' /etc/profile
	if [ $? -eq 0 ];then
		sed -i 's/^HISTTIMEFORMAT=.*$/HISTTIMEFORMAT="%F %T"/' /etc/profile
	else
		echo 'HISTTIMEFORMAT="%F %T "' >> /etc/profile
	fi
}
#4.调整防火墙与Selinux
Firewalld(){
#Selinux
sed -i '/SELINUX=/cSELINUX=disabled' /etc/selinux/config
#Firewalld
systemctl disable firewalld
systemctl stop firewalld
}
}
#5.调整内核参数
Kernel(){
cat >> /etc/sysctl.conf <<-EOF
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_tw_recycle=0
EOF
}

