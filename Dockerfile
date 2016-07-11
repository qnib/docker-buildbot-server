FROM qnib/buildbot-base

ENV BUILDBOT_URL=localhost \
    BUILDBOT_WWW_PORT=8010 \
    BUILDBOT_TITLE_URL=http://blog.qnib.org \
    BUILDBOT_TITLE="QNIB Solutions"
RUN mkdir -p /usr/src \
 && curl -fsL https://github.com/buildbot/buildbot/archive/v${BUILDBOT_VER}.tar.gz |tar xfz - -C /tmp/ \
 && mv /tmp/buildbot-${BUILDBOT_VER}/master /usr/src/buildbot \
 && rm -rf /tmp/buildbot-${BUILDBOT_VER} \
 && pip install  "/usr/src/buildbot/" \
 && rm -r /root/.cache

VOLUME /var/lib/buildbot
ADD opt/qnib/buildbot/master/bin/start.sh /opt/qnib/buildbot/master/bin/
ADD etc/supervisord.d/buildbot-master.ini /etc/supervisord.d/
ADD etc/consul.d/buildbot-master.json /etc/consul.d/
ADD etc/consul-templates/buildbot/master.cfg.ctmpl /etc/consul-templates/buildbot/
