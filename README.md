# ansible_deploy_telemetry
Deploy telemetry/monitoring server and client components and configure them with ansible
# Deploying performance, fault and availability monitoring and metrics gathering with Collectd and Prometheus
Ansible playbooks to deploy collectd and prometheus based monitoring solution


# Package versions

|Package                  |Version      |Ports                                       |
|-------------------------|-------------|--------------------------------------------|
|Prometheus               |2.0.0        |TCP 9090                                    |
|Collectd                 |5.8.0.1      |                                            |
|Collectd exporter        |0.3.1        |TCP 25826, 9103                             |
|Grafana                  |4.6.3.1      |TCP 3000                                    |
|Prometheus Alert Manager |0.12.0       |TCP 6783                                    |

## How to run
To run playbooks first update the group_vars/all with environment specific parameters. The all file looks like this:
```
[ansible@se-nfv-srv12 ansible_deploy_telemetry{master}]$ cat /home/ansible/ansible_deploy_telemetry/group_vars/all
collectd_exporter_download_url: https://github.com/prometheus/collectd_exporter/releases/download/0.3.1/collectd_exporter-0.3.1.linux-386.tar.gz
collectd_exporter_port: 25826
collectd_exporter_http_port: 9103
prometheus_download_url: https://github.com/prometheus/prometheus/releases/download/v2.0.0/prometheus-2.0.0.linux-amd64.tar.gz
prometheus_web_port: 9090
alert_manager_download_url: https://github.com/prometheus/alertmanager/releases/download/v0.12.0/alertmanager-0.12.0.linux-amd64.tar.gz
alert_manager_mesh_port: 6783
alert_manager_port: 9093
grafana_download_url: https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.6.3-1.x86_64.rpm
grafana_port: 3000
```
If you want to make changes to port numbers for individual components you would make it in the all file.

Next step is to update the /home/ansible/ansible_deploy_telemetry/telemetry_hosts entries. This files defines the target hosts where the telemetry components are installed.
* **osp-controllers:** OpenStack controller and compute nodes where collectd and collectd plugins will be installed
* **ceph-nodes:** Ceph Mon and OSD nodes where collectd and collectd plugins will be installed. This should ceph node pkgs
* **collectd_exporters:** Receives binary or JSON formatted collectd data from each of the osp and ceph nodes and provides to the prometheus server over http
* **prometheus:** Time-series database used to store all the collectd data. Rules can be written against data to create alerts
* **alert_managers:** Receives alerts from prometheus. Responsible for deduplication and filtering
* **grafana:** Used for visualization of data from prometheus <br />
They look like this:
```
[osp-controllers]
10.19.109.12
[osp-computes]
10.19.109.230
10.19.109.231
[ceph-nodes]
10.19.109.232
[collectd_exporters]
10.19.109.225
10.19.109.229
[prometheus]
10.19.109.225
10.19.109.229
[alert_managers]
10.19.109.225
10.19.109.229
[grafana]
10.19.109.225
10.19.109.229
```
Note: Two servers 10.19.109.225 and 10.19.109.229 are listed under server side components - collectd_exporters, prometheus, alert_managers, grafana. This assumes full HA deployment. If you are trying this with only one servers (in the lab) you should have only one entry under each server component.

Then run the playbooks in the playbooks folder to deploy individual components or all
at the same time. Each components can be deployed on their own. There are playbooks to
deploy as well as remove as this will help in testing. All ansible-playbook commands
should be run from the ansbile-install-telmetry directory.

Following shows deploying just grafana
```
ansible-playbook playbooks/install_grafana.yaml
ansible-playbook playbooks/install_collectd_exporter.yaml
ansible-playbook playbooks/install_prometheus.yaml
ansible-playbook playbooks/install_alert_manager.yaml
ansible-playbook playbooks/install_grafana.yaml
```
To install all server components and configure them (Grafana excluded)
```
ansible-playbook playbooks/install_server_all.yaml
```
To configure collectd client,
Download packages from Red Hat Repo:
https://access.redhat.com/downloads/content/package-browser
and place them into directory: 

```
[ansible@se-nfv-srv12 packages{master}]$ pwd
/home/ansible/ansible_deploy_telemetry/roles/client/packages
[ansible@se-nfv-srv12 packages{master}]$ ls
collectd-5.8.0-5.el7ost.x86_64.rpm  collectd-ceph-5.8.0-5.el7ost.x86_64.rpm  collectd-disk-5.8.0-5.el7ost.x86_64.rpm
```

The packages in this directory need to correspond to the entries in the main.yaml file of the var directory of osp-nodes and ceph-nodes directories:
```
[ansible@se-nfv-srv12 vars{master}]$ cat /home/ansible/ansible_deploy_telemetry/roles/client/osp-nodes/vars/main.yaml
collect_plugins:
  - collectd
  - disk

package_dirs:
 src: /home/ansible/ansible_deploy_collectd_prometheus/roles/client/packages
 dst: /tmp

collectd_packages_all:
  - collectd-5.8.0-5.el7ost.x86_64.rpm
  - collectd-disk-5.8.0-5.el7ost.x86_64.rpm




[ansible@se-nfv-srv12 vars{master}]$ cat /home/ansible/ansible_deploy_telemetry/roles/client/ceph-nodes/vars/main.yaml
collect_plugins:
  - collectd
  - disk

package_dirs:
 src: /home/ansible/ansible_deploy_collectd_prometheus/roles/client/packages
 dst: /tmp

collectd_packages_all:
  - collectd-5.8.0-5.el7ost.x86_64.rpm
  - collectd-disk-5.8.0-5.el7ost.x86_64.rpm

collectd_packages_ceph:
  - collectd-ceph-5.8.0-5.el7ost.x86_64.rpm
```
Once the packages are downloaded and entries in the main.yaml under vars is updated the following commands can be run to install collectd packages on osp nodes and ceph nodes respectively
```
ansible-playbook playbooks/install_osp_nodes.yaml
ansible-playbook playbook/install_ceph_nodes.yaml
```

## To Do
* Remove keepalived if it confirmed that it is not in use in the solution
* Include exec plugin and it's configuration
* Include updated collect.conf for performance optimization
* Include exec plugin description
* Add OSP exporter
* Add SNMP webhook

