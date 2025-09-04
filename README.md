# OSC2022 Online/Fall Seminar demo

## Seminar ##
 * Slides
   * https://linux-ha-japan.github.io/wp/archives/5044

## Install demo environment

### Host requirements

* Hardware
  * Memory: 16GB or more
* Software
  * Windows 11 24H2
  * VirtualBox-7.1.12-169651-Win.exe
  * vagrant_2.4.7_windows_amd64.msi
  * WSL2:
    * Ubuntu-24.04 LTS
      * ansible-core 2.18.8
    * AlmaLinux-9
      * ansible-core 2.14.18
  * Vagrant Box: rockylinux/9 v6.0.0


### Host installation

 * Install VirtualBox package
   * https://www.virtualbox.org/wiki/Downloads
 * Install Vagrant package
   * https://www.vagrantup.com/downloads.html
 * Install WSL2
   * https://learn.microsoft.com/ja-jp/windows/wsl/install
```
> wsl --install -d Ubuntu
```
 * For Symantec Endpoint Protection(SEP) users
   * see Appendix.

### Configurations for WSL2
 * /etc/wsl.conf
```
[automount]
options = "metadata"
```
### Proxy configuration (if necessary)
 * /etc/environment
```
http_proxy=http://PROXY:8080/
https_proxy=http://PROXY:8080/
```
 * $HOME/.bashrc
```
export http_proxy=http://PROXY:8080/
export https_proxy=http://PROXY:8080/
#export VAGRANT_CWD=/mnt/c/Users/<playbook_dir>/vagrant
export WSLENV=VAGRANT_CWD/p:http_proxy:https_proxy
```
 * /etc/apt/apt.conf.d/99proxy (Ubuntu only)
```
Acquire::http::proxy "http://PROXY:8080/";
Acquire::https::proxy "http://PROXY:8080/";
Acquire::http::Timeout "300";
```
### restart WSL2 to take effects
```
$ exit
> wsl --shutdown
> wsl
$
```
### Install ansible in WSL2 (Ubuntu)
```
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```
 * https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu

### Install ansible in WSL2 (AlmaLinux)
```
$ sudo dnf install git
$ sudo dnf install ansible-core
```

## Quick Start

 * checkout demo repo.
```
$ git clone --recursive https://github.com/kskmori/osc2022fall-demo
$ cd osc2022fall-demo
$ cp ansible.cfg.sample ansible.cfg
```

 * Build demo environment
```
$ ansible-playbook 10-vagrant.yml
$ ansible-playbook 20-virtualbmc.yml -K
$ ansible-playbook 30-postgresql-shared.yml
$ ansible-playbook 40-pacemaker.yml
```

## misc. tasks

 * restart the demo environment after the host was rebooted
```
$ ansible-playbook 80-demo-restart.yml -K
```

 * stop the demo environment
```
$ ansible-playbook 89-demo-stop.yml -K
```

## Related Repositories

 * Playbooks for Pacemaker installation
   * https://github.com/linux-ha-japan/ansible-pacemaker
 * Playbooks for PostgreSQL and iSCSI storage installation
   * https://github.com/linux-ha-japan/ansible-postgresql-shared
 * Playbooks for VirtualBMC installation
   * https://github.com/linux-ha-japan/ansible-virtualbmc
 * VirtualBMC (vbox support) - IPMI fencing for VirtualBox VMs
   * https://github.com/linux-ha-japan/virtualbmc-vbox/tree/devel-vbox-2.0

## Appendix
 * For Symantec Endpoint Protection(SEP) users
   * an additional setting is required to allow network connections to outside
   * see below
     * https://kemasoft.net/?vm/wsl2%A4%C8SEP%A4%C8stone#w98afb3e
     * https://computational-sediment-hyd.hatenablog.jp/entry/2022/05/02/231428

## Update history
 * 2022/11/03
   * Initial release for OSC2022 Online/Fall Seminor
 * 2025/09/04
   * Move all repositories to the Linux-HA Japan project
   * Update to Windows 11 / Rocky Linux 9.6
