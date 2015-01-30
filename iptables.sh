#!/bin/bash
#iptables script
#run it in the root user
#by Z
#2015.01.27

#清除所有的规则
echo "clean rules"
#一个接一个的删除所有table中的规则
iptables -F
#删除用户定义链条上的规则
iptables -X
#重置数据包的统计
iptables -Z

#设置默认的策略
echo "default rules"
#禁止所有数据包的流入流出
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
#如果想要允许该主机访问其他主机可以将OUPUT链ACCEPT
#iptables -P OUTPUT ACCEPT

#设定INPUT的规则
echo "input chain"
#以下的规则都默认放到filter表中
iptables -A INPUT -i lo -j ACCEPT #允许本地的数据包流通 -in-interface lo 数据包接收
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT #允许已经建立连接或有关联的数据包流入.
iptables -A INPUT -p tcp -s 10.10.10.0/24 -j ACCEPT #允许这个10.10.10.1-10.10.10.254的计算机访问该主机开放的服务.
iptables -A INPUT -p tcp --dport 80 -j ACCEPT #允许任何主机访问该主机的80端口(web服务端口)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT #允许任何主机访问该主机的22端口(ssh远程连接端口) 推荐进行更换
iptables -A INPUT -p icmp -j ACCEPT #ping 

#设定OUTPUT的规则
echo "output chain"
# 以下的规则也是都默认放到filter表中
iptables -A OUTPUT -o lo -j ACCEPT #允许本地数据包的流通 -out-interface lo 数据包发送
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT #允许已经建立连接或有关联的数据包流出.
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT #允许ssh其他主机
iptables -A OUTPUT -p tcp --dport 3306 -j ACCEPT #允许mysql连接其他主机
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT #HTTP
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT #ntp时间 udp协议
iptables -A OUTPUT -p tcp --dport 23 -j ACCEPT #TELNET
iptables -A OUTPUT -p tcp --dport 21 -j ACCEPT #FTP
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT #DNS DNS udp协议
iptables -A OUTPUT -p tcp --dport 3389 -j ACCEPT #远程桌面
iptables -A OUTPUT -p icmp -j ACCEPT #ping

#保存iptables 规则
echo "save.."
service iptables save #将iptables 的数据保存到 /etc/iptables 中 下次启动的时候自动在/etc/iptables中读取
#展示规则
iptables -nvL

