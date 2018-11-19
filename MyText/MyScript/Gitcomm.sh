#/bin/bash
######################################

#init
init() {
echo 正在执行初始化操作...
sleep 2
a=$0
check01=0
check02=0
if [ $a == './Gitcomm.sh' ];then
	a=$(pwd -P)
	chmod +x "$a/Gitcomm.sh"
	check01=$?
	rm -rf /usr/local/bin/Gitcomm
	ln -s "$a/Gitcomm.sh" /usr/local/bin/Gitcomm
	check02=$?
elif [ $a == '/usr/local/bin/Gitcomm' ];then
	location=`ls -l $(dirname $0) | grep Gitcomm | awk '{print $NF}'`
	rm -rf /usr/local/bin/Gitcomm
	chmod +x $location
        check01=$?
        ln -s $location /usr/local/bin/Gitcomm
        check02=$?
else
	echo '请切换至脚本目录，使用./Gitcomm.sh init初始化'
	exit 1
	break
fi
if [[ "$check01" -eq 0 && "$check02" -eq 0 ]];then
	echo '初始化成功，可使用"Gitcomm"命令同步'
	exit 0
else
	echo 初始化失败
	exit 1
fi
}

########################################################

#commit
commit() {

location=`ls -l $(dirname $0) | grep Gitcomm | awk '{print $NF}'`
basedir=`dirname $location`
sleep 1
cd $basedir
cd ../..
echo 切换到`pwd -P`
git pull
git add -A .
git config --global user.email "593664243@qq.com"
git commit
git push
#read -p "请输入" a
#echo  < $a
#echo $location
#echo $basedir

#cd $(dirname $0) && cd ../.. && echo "切换到
#`pwd -P`"
#sleep 2
}

############################################################
case $1 in
init)
init
;;
commit)
commit
;;
*)
echo 请输入选项
exit 99
;;
esac
