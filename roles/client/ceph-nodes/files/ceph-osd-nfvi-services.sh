
HOSTNAME="${COLLECTD_HOSTNAME:-`hostname -f`}"
#INTERVAL="${COLLECTD_INTERVAL:-10}"
INTERVAL=30
# For all the following commands HOME should be set to the directory that has -my.cnf file with password information.

# Flexible parameter to grab global variables- On the frontend side, use keys like mysql.status[Com_insert].
# Key syntax is mysql-status[variable].
while sleep "$INTERVAL" ; do
  #Read more https://linux-die.net/man/5/collectd-exec
  #An Identifier is of the form " host / plugin - instance / type - instance "
  #Refer for all typesdb to use like links-cinder  https://github-com/collectd/collectd/blob/master/src/types.db

  val=$(sudo systemctl list-units |grep -i ntpd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ntpd-service\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i sshd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-sshd-service\" interval=$INTERVAL N:$val"

  val=$(sudo ps aux | awk '{ print $8 " " $2 }' | grep -w Z | wc -l)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-zombieprocess-process\" interval=$INTERVAL N:$val"

  #val=$(/usr/local/sbin/netif_discovery.sh)
  #val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-net-phys-if-discovery\" interval=$INTERVAL N:$val"

  #val=$(if [ $(cat /sys/class/net/$1/operstate)= "up" ]; then cat /sys/class/net/$1/carrier; else echo "0"; fi;)
  #val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-net-if-carrier-status \" interval=$INTERVAL N:$val"

  #val=$(/usr/local/sbin/discover_disk.sh)
  #val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-disk-discovery\" interval=$INTERVAL N:$val"

  #val= $(/usr/local/sbin/smart-temp.sh /dev/$1 Temperature_Celsius)
  #val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-smart-temp\" interval=$INTERVAL N:$val"

  #val=$(/usr/local/sbin/smart-health.sh /dev/$1)
  #val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-smart-health\" interval=$INTERVAL N:$val"

  val=$(if [ $(sudo ceph health | awk '{print $1}') == "HEALTH_OK" ]; then echo "0"; else echo "1"; fi;)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-health\" interval=$INTERVAL N:$val"

  val=$(sudo ceph osd tree | grep -w down | wc -l)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-osd\" interval=$INTERVAL N:$val"

  #val=$($(ceph status |sed -n '/monmap/s/-* \([0-9]*\) mons.*/\1/p'); if [[ "$ACTIVE" != "" ]]; then echo "0"; else echo "1"; fi;)
  #val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-mon\" interval=$INTERVAL N:$val"

  #val= $(ceph osd df | awk '{print $7}' | grep -v USE | sed 's/\-[0-9]*//g' | awk 'NF' > OSDUSE ; for i in `cat OSDUSE` ; do if [ $(echo " $i > 85" | bc) -eq 1 ]; then echo "1"; else echo "0"; fi; done)
  #val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-capacity\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh total)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-total\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh in)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-osd_in\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh up)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-osd_up\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh active)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-active\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh backfill)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-backfill\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh clean)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-clean\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh creating)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-creating\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh degraded)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-degraded\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh down)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-down\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh deep)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-deep\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh incomplete)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-incomplete\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh inconsistent)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-inconsistent\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh peering)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-peering\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh peered)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-peered\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh undersized)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-undersized\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh recovering)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-recovering\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh remapped)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-remapped\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh repair)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-repair\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh scrubbing)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-scrubbing\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh stale)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-stale\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh waitBackfill)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-waitBackfill\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh totalrados)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-rados_total\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh usedrados)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-rados_used\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh freerados)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-rados_free\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh wrbps)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-wrbps\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh rdbps)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-rdbps\" interval=$INTERVAL N:$val"

  val=$(sudo /usr/local/sbin/ceph-status.sh ops)
  val=$(if [ -z $val ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ceph-ops\" interval=$INTERVAL N:$val"
done
