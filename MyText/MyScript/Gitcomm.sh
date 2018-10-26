#/bin/bash
######################################

#init
init() {
echo 正在执行初始化操作...
sleep 2
a=$0
if [ $a == './Gitcommi.sh' ];then
	a=`dirname $(pwd -P)`
	echo $a
elif [ $a == "*/Gitcommi.sh" ];then
	echo test
fi
echo $0
chmod +x $0 2> /dev/null
check01=$?
#echo $check01
rm -rf /usr/local/bin/Gitcomm
echo $(dirname $0)
ln -s $(dirname $0) /usr/local/bin/Gitcomm
check02=$?
#echo $check2
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
#echo $location
basedir=`dirname $location`
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
;;
esac
#git add .
#git commit
#git push
#read -p "请输入" a
#echo  < $a
