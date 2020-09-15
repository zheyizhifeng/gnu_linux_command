# 输出第1列和第4列，$1..$n表示第几列。注：$0表示整个行
awk '{print $1, $4}' netstat.txt
# Proto Local
# tcp4 192.168.13.204.50256
# tcp4 192.168.13.204.50254
# tcp4 192.168.13.204.50253
# tcp4 192.168.13.204.50251
# tcp4 192.168.13.204.50246

# awk的格式化输出，和C语言的printf没什么两样
awk '{printf "%-8s %-8s %-8s %-18s %-22s %-15s\n",$1,$2,$3,$4,$5,$6}' netstat.txt

# 过滤记录: 第三列的值为0 && 第6列的值为LISTEN
# 其中的“==”为比较运算符。其他比较运算符：!=, >, <, >=, <=
awk '$3==0 && $6=="LISTEN"' netstat.txt 
# 带表头，内建变量NR【行号】{此文件表头在第二行}
awk '$3==0 && $6=="LISTEN" || NR==2 ' netstat.txt
# 加上格式化输出
awk '$3==0 && $6=="LISTEN" || NR==2 {printf "%-20s %-20s %s\n",$4,$5,$6}' netstat.txt

# 内建变量
# $0	当前记录（这个变量中存放着整个行的内容）
# $1~$n	当前记录的第n个字段，字段间由FS分隔
# FS	输入字段分隔符 默认是空格或Tab
# NF	当前记录中的字段个数，就是有多少列
# NR	已经读出的记录数，就是行号，从1开始，如果有多个文件话，这个值也是不断累加中。
# FNR	当前记录数，与NR不同的是，这个值会是各个文件自己的行号
# RS	输入的记录分隔符， 默认为换行符 【输入的行分隔符】
# OFS	输出字段分隔符， 默认也是空格【输出的列分隔符】
# ORS	输出的记录分隔符，默认为换行符【输出的行分隔符】
# FILENAME	当前输入文件的名字

# 打印行号
awk '$3==0 && $6=="ESTABLISHED" || NR==1 {printf "%02s %s %-20s %-20s %s\n",NR ") ", FNR, $4,$5,$6}' netstat.txt
# 指定分隔符
awk 'BEGIN{FS=":"} {print $1,$3,$6}' /etc/passwd # 等价于 awk -F '' {print $1,$3,$6} /etc/passwd
# 指定多分隔符 awk -F '[;:]'

# 指定输出列用\t 分隔
awk  -F: '{print $1,$3,$6}' OFS="\t" /etc/passwd

# 字符串匹配
# 示例匹配FIN状态， ~ 表示模式开始。/ /中是模式，是一个正则表达式的匹配。
awk '$6 ~ /FIN/ || NR==1 {print NR,$4,$5,$6}' OFS="\t" netstat.txt
# 匹配WAIT字样的状态
awk '$6 ~ /WAIT/ || NR==1 {print NR,$4,$5,$6}' OFS="\t" netstat.txt
# 模式取反，或者 awk '!/WAIT/' netstat.txt
awk '$6 !~ /WAIT/ || NR==1 {print NR,$4,$5,$6}' OFS="\t" netstat.txt

# 拆分文件
awk 'NR > 2 {print > $6}' netstat.txt
# ls
# CLOSE_WAIT  ESTABLISHED FIN_WAIT_2  LISTEN      SYN_SENT    awk-demo.sh awk.sh      netstat.txt
# 输出指定列到文件
awk 'NR!=1{print $4,$5 > $6}' netstat.txt

# if else 复杂脚本, 按条件输出到不同文件
awk 'NR!=1{if($6 ~ /TIME|ESTABLISHED/) print > "1.txt";
else if($6 ~ /LISTEN/) print > "2.txt";
else print > "3.txt" }' netstat.txt

# 计算所有的C文件，CPP文件和H文件的文件大小总和。
ls -l | awk '{sum+=$5} END {print sum}' # ls -l 第五列为文件字节数大小

# 统计各个connection状态的用法，数组用法
awk 'NR!=1{a[$6]++;} END {for (i in a) print i ", " a[i];}' netstat.txt
# TIME_WAIT, 3
# FIN_WAIT1, 1
# ESTABLISHED, 6
# FIN_WAIT2, 3
# LAST_ACK, 1
# LISTEN, 4

# 统计每个用户的进程的占了多少内存
ps aux | awk 'NR!=1{a[$1]+=$6;} END { for(i in a) print i ", " a[i]"KB";}'
# dbus, 540KB
# mysql, 99928KB
# www, 3264924KB
# root, 63644KB
# hchen, 6020KB

cat score.txt
# Marry   2143 78 84 77
# Jack    2321 66 78 45
# Tom     2122 48 77 71
# Mike    2537 87 97 95
# Bob     2415 40 57 62
./cal.awk score.txt # 也可以 awk -f cal.awk score.txt
# NAME    NO.   MATH  ENGLISH  COMPUTER   TOTAL
# ---------------------------------------------
# Marry  2143     78       84       77      239
# Jack   2321     66       78       45      189
# Tom    2122     48       77       71      196
# Mike   2537     87       97       95      279
# Bob    2415     40       57       62      159
# ---------------------------------------------
#   TOTAL:       319      393      350 
# AVERAGE:     63.80    78.60    70.00

# 和环境变量交互
x = 5 # $x
y = 10 # $y
export y # ENVIRON
awk -v val=$x '{print $1, $2, $3, $4+val, $5+ENVIRON["y"]}' OFS="\t" score.txt
# Marry   2143    78      89      87
# Jack    2321    66      83      55
# Tom     2122    48      82      81
# Mike    2537    87      102     105
# Bob     2415    40      62      72

#从file文件中找出长度大于80的行
awk 'length>80' file

#按连接数查看客户端IP
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr

#打印99乘法表
seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf("%dx%d=%d%s", i, NR, i*NR, i==NR?"\n":"\t")}' 