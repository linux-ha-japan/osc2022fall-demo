# OSC2022 Online/Fall Seminar demo

## Seminar ##
 * Slides
   * (TBD)
 * Introduction
   * https://event.ospn.jp/osc2022-online-fall/session/681272

## Install demo environment

### Host requirements

* Hardware
  * Memory: 16GB or more
* Software
  * Windows 10 21H2
  * VirtualBox-6.1.14-140239-Win
  * vagrant_2.3.2_windows_amd64.msi
  * WSL2: Ubuntu-20.04 LTS
  * Python-3.8.2 (Ubuntu bundled)
  * ansible-2.12.9


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
   * see below
      * https://kemasoft.net/?vm/wsl2%A4%C8SEP%A4%C8stone#w98afb3e
      * https://computational-sediment-hyd.hatenablog.jp/entry/2022/05/02/231428

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
 * /etc/apt/apt.conf.d/99proxy
```
Acquire::http::proxy "http://PROXY:8080/";
Acquire::https::proxy "http://PROXY:8080/";
Acquire::http::Timeout "300";
```
### restart WSL2 to take effects
```
$ exit
> wsl –-shutdown
> wsl
$
```
### Install ansible in WSL2
```
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```
 * https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu

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

## Related Repositories

 * Playbooks for Pacemaker installation
   * https://github.com/kskmori/ansible-pacemaker-rocky8
 * Playbooks for PostgreSQL and iSCSI storage installation
   * https://github.com/kskmori/ansible-postgresql-shared
 * Playbooks for VirtualBMC installation
   * https://github.com/kskmori/ansible-virtualbmc
 * VirtualBMC (vbox support) - IPMI fencing for VirtualBox VMs
   * https://github.com/kskmori/virtualbmc-vbox/tree/devel-vbox-2.0

## Known issues
 * TBD
