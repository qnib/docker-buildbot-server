FROM qnib/buildbot-base

ENV BUILDBOT_URL=localhost \
    BUILDBOT_WWW_PORT=8010 \
    BUILDBOT_TITLE_URL=http://blog.qnib.org \
    BUILDBOT_TITLE="QNIB Solutions"

ADD opt/qnib/buildbot/master/bin/start.sh /opt/qnib/buildbot/master/bin/
ADD etc/supervisord.d/buildbot-master.ini /etc/supervisord.d/
ADD etc/consul.d/buildbot-master.json /etc/consul.d/
ADD etc/consul-templates/buildbot/master.cfg.ctmpl /etc/consul-templates/buildbot/
ADD opt/qnib/buildbot/etc/builders.cfg \
    opt/qnib/buildbot/etc/changesources.cfg \
    opt/qnib/buildbot/etc/schedulers.cfg \
    opt/qnib/buildbot/etc/status_targets.cfg \
    opt/qnib/buildbot/etc/workers.cfg \
    /opt/qnib/buildbot/etc/
RUN mkdir -p /var/lib/buildbot/
