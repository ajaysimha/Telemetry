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

  #val=$(sudo systemctl list-units |grep -i openstack-ceilometer-central |grep -ic running)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-ceilometer-central\"  interval=$INTERVAL N:$val"  
  
  #val=$(sudo systemctl list-units |grep -i openstack-ceilometer-collector |grep -ic running)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-ceilometer-collector\"  interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-aodh-notifier |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-aodh-notifier\"  interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-aodh-evaluator |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-aodh-evaluator\" interval=$INTERVAL N:\" interval=INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i neutron-openvswitch-agent |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-neutron-openvswitch-agent\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-nova-api |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-nova-api\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-nova-conductor |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-nova-conductor\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-nova-consoleauth |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-nova-consoleauth\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-nova-novncproxy |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-nova-novncproxy\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-nova-scheduler |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-nova-scheduler\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-cinder-api |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-cinder-api\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-cinder-scheduler |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-cinder-scheduler\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-glance-api |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-glance-api\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-glance-registry |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-glance-registry\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-heat-api-cfn |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-heat-api-cfn\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-heat-api |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-heat-api\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-heat-engine |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-heat-engine\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-account-auditor |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-account-auditor\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-account-reaper |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-account-reaper\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-account-replicator |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-account-replicator\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-account |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-account\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-container-auditor |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-container-auditor\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-container-replicator |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-container-replicator\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-container |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-container\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-container-updater |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-container-updater\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-object-auditor |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-object-auditor\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-object-replicator |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-object-replicator\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-object |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-object\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-object-updater |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-object-updater\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-swift-proxy |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-swift-proxy\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i ntpd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-ntpd-service\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i sshd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-sshd-service\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i libvirtd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-libvirtd-service\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i haproxy |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-haproxy-service\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i httpd |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-httpd-service\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i neutron-dhcp-agent |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-neutron-dhcp-agent\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i neutron-l3-agent |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-neutron-l3-agent\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i neutron-metadata-agent |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-neutron-metadata-agent\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i neutron-server |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-neutron-server\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl list-units |grep -i openstack-heat-api-cloudwatch |grep -ic running)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-openstack-heat-api-cloudwatch\" interval=$INTERVAL N:$val"

  val=$(ps aux | awk '{ print $8 " " $2 }' | grep -w Z | wc -l)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-zombieprocess-process\" interval=$INTERVAL N:$val"

  #val=$(/usr/local/sbin/netif_discovery.sh)
  #val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-net-phys-if-discovery\" interval=$INTERVAL N:$val"

  #val=$(if [ $(cat /sys/class/net/$1/operstate)= "up" ]; then cat /sys/class/net/$1/carrier; else echo "0"; fi;)
  #val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-net-if-carrier-status \" interval=$INTERVAL N:$val"

  #val=$(/usr/local/sbin/discover_disk.sh)
  #val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-disk-discovery\" interval=$INTERVAL N:$val"

  #val= $(/usr/local/sbin/smart-temp.sh /dev/$1 Temperature_Celsius)
  #val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-smart-temp\" interval=$INTERVAL N:$val"

  #val=$(/usr/local/sbin/smart-health.sh /dev/$1)
  #val=$(if [$val -z ]; then echo 0; else echo $val; fi)
  #echo "PUTVAL \"$HOSTNAME/nfvi-services/service-smart-health\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl is-active corosync >/dev/null 2>&1 && echo 1 || echo 0)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-corosync\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl is-active pcsd >/dev/null 2>&1 && echo 1 || echo 0)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-pcsd\" interval=$INTERVAL N:$val"

  val=$(sudo systemctl is-active pacemaker >/dev/null 2>&1 && echo 1 || echo 0)
  echo "PUTVAL \"$HOSTNAME/nfvi-services/service-pacemaker\" interval=$INTERVAL N:$val"
done
