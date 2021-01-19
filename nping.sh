#!/bin/bash
#cat downnodes >> downnodes.log
filename=$(date +%Y%m%d)_$(date +%H%M%S)
catnewlist=$(cat ./newlist)
catlastlist=$(cat ./lastlist)
while [ 1 -eq 1 ]
do
gawk '{ print $1,$2,$3,$4,$5 }' hostlist|bash newping.sh
sleep 5
break
#将屏幕输出为名称为date的文件和newlist文件
done 2>&1 |tee $filename|tee newlist
#为了推送server酱格式美观，添加换行
sed -i "s/$/\n\n/g" newlist

if [ "$catnewlist" = "$catlastlist" ] ;then
sleep 2
else curl -d "text=宕机列表更新了&desp=${catnewlist}" "https://sc.ftqq.com/SCU*******************************************.send" >/dev/null 2>&1 &
fi

cat ./newlist > lastlist
exit 0
