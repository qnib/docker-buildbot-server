#!/usr/local/bin/dumb-init /bin/bash

BB_DIR=/var/lib/buildbot/
cd /var/lib/buildbot/
if [ ! -f ${BB_DIR}/buildbot.tac ];then
    buildbot create-master --db="postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@postgres/$POSTGRES_DB" ${BB_DIR}
    cp /usr/src/buildbot/contrib/docker/master/buildbot.tac ${BB_DIR}
    echo
    echo buildbot is now setup on the docker host in /var/lib/buildbot
    echo
    echo You can now edit the configuration file there to sweet your needs!
    echo
    echo
fi
consul-template -once -template "/etc/consul-templates/buildbot/master.cfg.ctmpl:/var/lib/buildbot/master.cfg"
# wait for pg to start by trying to upgrade the master
for i in `seq 100`
do
    buildbot upgrade-master ${BB_DIR} && break
    sleep 1
done
exec twistd -ny ${BB_DIR}/buildbot.tac
