sed "s/my/lucida's/" pet.txt

sed "s/my/lucida's/" pet.txt > lucida-pet.txt
cat lucida-pet.txt

sed -i "" "s/my/lucida's/" pet.txt
cat pet.txt

sed -i "" "s/^/# /" pet.txt

sed -i "" "s/$/ -- /" pet.txt

cat sed-test.html
sed "s/<.*>//g" sed-test.html # Error
sed "s/<[^>]*>//g" sed-test.html # Correct

sed "3,6s/lucida's/your/g" pet.txt

cat > my.txt << EOF
This is my cat, my cat's name is betty
This is my dog, my dog's name is frank
This is my fish, my fish's name is george
This is my goat, my goat's name is adam
EOF
sed 's/s/S/1' my.txt
sed 's/s/S/2' my.txt
sed 's/s/S/3g' my.txt

sed '1,3s/my/your/g; 3,$s/This/That/g' my.txt
sed -e '1,3s/my/your/g' -e '3,$s/This/That/g' my.txt

sed 's/my/[&]/g' my.txt

sed 's/This is my \([^,&]*\),.*is \(.*\)/\1:\2/g' my.txt

# N 命令把下一行的内容纳入当成缓冲区做匹配。
sed 'N;s/my/your/' pet.txt
sed 'N;s/\n/,/' pets.txt

# a: append, i：insert
sed -i "1 i This is my monkey, my monkey's name is wukong" my.txt
sed -i "$ a This is my monkey, my monkey's name is wukong" my.txt
sed "/fish/a This is my monkey, my monkey's name is wukong" my.txt
sed "/my/a ----" my.txt

# c 命令是替换匹配行
sed "2 c This is my monkey, my monkey's name is wukong" my.txt
sed "/fish/c This is my monkey, my monkey's name is wukong" my.txt

# d 删除行
sed '/fish/d' my.txt
sed '2d' my.txt
sed '2,$d' my.txt

# p 命令打印
sed '/fish/p' my.txt
sed -n '/fish/p' my.txt
sed -n '/dog/,/fish/p' my.txt
sed -n '1,/fish/p' my.txt

sed '/dog/,+3 s/^/# /g' pets.txt

# 命令嵌套
sed '3,6 {/This/d}' pets.txt
sed '3,6 {/This/{/fish/d}}' pets.txt # 对3行到第6行，匹配/This/成功后，再匹配/fish/，成功后执行d命令
sed '1,${/This/d;s/^ *//g}' pets.txt