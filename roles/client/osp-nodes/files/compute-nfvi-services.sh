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

  val=$(systemctl list-units |grep -i openstack-ceilometer-compute |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-ceilometer-compute\"  interval=$INTERVAL N:$val"

  val=$(systemctl list-units |grep -i openstack-nova-compute |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-nova-compute\" interval=$INTERVAL N:$val"

   val=$(systemctl list-units |grep -i ntpd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ntpd-service\" interval=$INTERVAL N:$val"

  val=$(systemctl list-units |grep -i sshd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-sshd-service\" interval=$INTERVAL N:$val"

  val=$(systemctl list-units |grep -i libvirtd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-libvirtd-service\" interval=$INTERVAL N:$val"

  val=$(ps aux | awk '{ print $8 " " $2 }' | grep -w Z | wc -l)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-zombieprocess-process\" interval=$INTERVAL N:$val"

  val=$(/usr/local/sbin/netif_discovery.sh)
  val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-net-phys-if-discovery\" interval=$INTERVAL N:$val"

  val=$(if [ $(cat /sys/class/net/$1/operstate)= "up" ]; then cat /sys/class/net/$1/carrier; else echo "0"; fi;)
  val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-net-if-carrier-status \" interval=$INTERVAL N:$val"

  val=$(/usr/local/sbin/discover_disk.sh)
  val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-disk-discovery\" interval=$INTERVAL N:$val"

  val= $(/usr/local/sbin/smart-temp.sh /dev/$1 Temperature_Celsius)
  val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-smart-temp\" interval=$INTERVAL N:$val"

  val=$(/usr/local/sbin/smart-health.sh /dev/$1)
  val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-smart-health\" interval=$INTERVAL N:$val"
done
