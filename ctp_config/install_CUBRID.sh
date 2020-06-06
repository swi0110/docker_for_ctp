# !/bin/bash
buildFile=`ls CUBRID_engine`
echo "$buildFile"
mkdir -p ${HOME}/CUBRID

cp CUBRID_engine/$buildFile ${HOME}/CUBRID
cd ${HOME}/CUBRID

sh  $buildFile >/dev/null <<EOF
y
n

EOF

sleep 3;

rm -rf $buildFile

. ${HOME}/.cubrid.sh
