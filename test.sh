# https://mp.weixin.qq.com/s/Moj_ccVrS_x9ljNlWMQMVg
echo hello > test
echo world >> test
echo '——————————————————————' >> test
seq 10 20 >> test


cat a b > c
cat > index.html <<EOF
<html>
    <head><title></title></head>
    <body></body>
</html>
EOF

seq 1000000 > large-file
less large-file

head -100 large-file
tail -100f large-file

find . | grep .js$ | xargs cat

# ; 顺序执行，如 
mkdir a;rmdir a
# && 条件执行，如
mkdir a && rmdir a

# || 条件执行，如
mkdir a || rmdir a，后面的命令将不执行

# | 管道，前面命令的输出，将作为后面命令的输入
seq 20 100 | head -n 50 | tail -n 1

# 0 表示stdin标准输入
# 
# 1 表示stdout标准输出
# 
# 2 表示stderr标准错误

# 错误信息无法输出到文件
cat errorDir > error
cat: errorDir: No such file or directory
cat error

# 错误信息被重定向了
cat errorDir > b 2>&1
cat error
cat: errorDir: No such file or directory

cat > sort.txt <<EOF
1 11
3 22
2 44
4 33
5 55
6 66
6 66
EOF

# 根据第一列倒序排序
cat sort.txt | sort  -n -k1 -r
# 统计每一行出现的次数，并根据出现次数倒序排序
cat sort.txt | sort  | uniq -c  | sort -n -k1 -r

find ~/performance-sdk | grep performance* | xargs cat -n

cat > 996 <<EOF
996: 996 is a funcking thing . which make woman as man , man as ass .
we all on the bus , bus bus on the way . 996
way to icu. icuuuuuu......
The greedy green boss rides on the pity programmer
EOF