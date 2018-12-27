###########################
# version kyan/centos_lnmp:1.0
# description: centos上安装LNMP.org一键安装包
###########################
ARG CENTOS_VERSION
FROM centos:${CENTOS_VERSION}

RUN echo "~~~开始安装依赖~~~" \
    && yum install -y wget \
    && echo "~~~获取lnmp.org安装包~~~" \
    && wget http://soft.vpser.net/lnmp/lnmp1.5.tar.gz -cO /tmp/lnmp1.5.tar.gz \
    && tar zxf /tmp/lnmp1.5.tar.gz -C /home \
    && cd /home/lnmp1.5 \
    && echo "~~~喝杯咖啡稍等片刻...开始安装lnmp.org包~~~" \
    && echo "~~~设置安装参数：数据库不安装，PHP版本5.6，内存分配器不安装~~~" \
    # 设置无人值守安装参数：不安装mysql，php安装版本5.6 开始安装
    && LNMP_Auto="y" DBSelect="0" PHPSelect="5" SelectMalloc="1" ./install.sh lnmp \
    && echo "~~~清理下载包~~~" \
    && rm -rf /tmp/lnmp1.5.tar.gz \
    && rm -rf /home/lnmp1.5

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh \
    && chmod 755 usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80