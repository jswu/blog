#!/bin/bash
# Stolen from http://grepalex.com/2012/08/17/full-jekyll-VM-setup/
# with some obvious modifications

send_email_and_exit() {
  recipient=$1
  message=$2

  echo "Sending email and exiting due to error"

  /bin/mail -s "Blog generation failure" "${recipient}" << EOF
${message}
EOF

  exit 1
}

echo "========== Running at `date` =========="

basedir=/home/sandy/github
gitdir=${basedir}/blog
nginxdir=/usr/share/nginx/www
stagingdir=$(mktemp)
githubrepo=https://github.com/jswu/blog.git
emailto="jiayisandywumail@gmail.com"

if [ ! -d ${gitdir} ]; then
  echo "Checking out repo for the first time"
  mkdir -p ${gitdir}
  cd ${basedir}
  git clone ${githubrepo}
else
  cd ${gitdir}
  git pull
fi

# TODO: Generalize this
(cd ${nginxdir} && rm -rf `ls | grep -v "^tmp$"`)

cd ${gitdir}
jekyll build --destination ${stagingdir}/
cp -r ${stagingdir}/* ${nginxdir}/
echo "Final destination: ${nginxdir}"

exitCode=$?

if [ ${exitCode} != "0" ]; then
  send_email_and_exit "${emailto}" "Jekyll failed with exit code ${exitCode}"
fi

curl http://0.0.0.0:80/ >/dev/null 2>&1

exitCode=$?

if [ ${exitCode} != "0" ]; then
  send_email_and_exit "${emailto}" "Curl failed with exit code ${exitCode}"
fi
