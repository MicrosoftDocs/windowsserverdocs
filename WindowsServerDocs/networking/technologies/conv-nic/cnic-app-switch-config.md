---
title: Physical switch configuration for Converged NIC
description: In this topic, we provide you with guidelines for configuring your physical switches. 
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 6d53c797-fb67-4b9e-9066-1c9a8b76d2aa
manager: dougkim
ms.author: lizross
author: eross-msft
ms.date: 09/14/2018
---

# Physical switch configuration for Converged NIC

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this topic, we provide you with guidelines for configuring your physical switches. 


These are only commands and their uses; you must determine the ports to which the NICs are connected in your environment. 

>[!IMPORTANT]
>Ensure that the VLAN and no-drop policy is set for the priority over which SMB is configured.

## Arista switch \(dcs\-7050s\-64, EOS\-4.13.7M\)

1.	en \(go to admin mode, usually asks for a password\)
2.	config \(to enter into configuration mode\)
3.	show run \(shows current running configuration\)
4.	find out switch ports to which your NICs are connected to. In these example, they are 14/1,15/1,16/1,17/1.
5.	int eth 14/1,15/1,16/1,17/1 \(enter into config mode for these ports\)
6.	dcbx mode ieee
7.	priority-flow-control mode on
8.	switchport trunk native vlan 225
9.	switchport trunk allowed vlan 100-225
10.	switchport mode trunk
11.	priority-flow-control priority 3 no-drop
12.	qos trust cos
13.	show run \(verify that configuration is setup correctly on the ports\)
14.	wr \(to make the settings persists across switch reboot\)

### Tips:
1.	No #command# negates a command
2.	How to add a new VLAN: int vlan 100  \(If storage network is on VLAN 100\)
3.	How to check existing VLANs : show vlan
4.	For more information on configuring Arista Switch, search online for: Arista EOS Manual
5.	Use this command to verify PFC settings: show priority-flow-control counters detail

--- 

## Dell switch \(S4810, FTOS 9.9 \(0.0\)\)

    
    !
    dcb enable
    ! put pfc control on qos class 3
    configure
    dcb-map dcb-smb
    priority group 0 bandwidth 90 pfc on
    priority group 1 bandwidth 10 pfc off
    priority-pgid 1 1 1 0 1 1 1 1
    exit
    ! apply map to ports 0-31
    configure
    interface range ten 0/0-31
    dcb-map dcb-smb
    exit
    
--- 

## Cisco switch \(Nexus 3132, version 6.0\(2\)U6\(1\)\)

### Global
    
    class-map type qos match-all RDMA
    match cos 3
    class-map type queuing RDMA
    match qos-group 3
    policy-map type qos QOS_MARKING
    class RDMA
    set qos-group 3
    class class-default
    policy-map type queuing QOS_QUEUEING
    class type queuing RDMA
    bandwidth percent 50
    class type queuing class-default
    bandwidth percent 50
    class-map type network-qos RDMA
    match qos-group 3
    policy-map type network-qos QOS_NETWORK
    class type network-qos RDMA
    mtu 2240
    pause no-drop
    class type network-qos class-default
    mtu 9216
    system qos
    service-policy type qos input QOS_MARKING
    service-policy type queuing output QOS_QUEUEING
    service-policy type network-qos QOS_NETWORK
    

### Port specific

    
    switchport mode trunk
    switchport trunk native vlan 99
    switchport trunk allowed vlan 99,2000,2050   çuse VLANs that already exists
    spanning-tree port type edge
    flowcontrol receive on (not supported with PFC in Cisco NX-OS)
    flowcontrol send on (not supported with PFC in Cisco NX-OS)
    no shutdown
    priority-flow-control mode on
    
--- 

## Related topics

- [Converged NIC Configuration with a Single Network Adapter](cnic-single.md)
- [Converged NIC Teamed NIC Configuration](cnic-datacenter.md)
- [Troubleshooting Converged NIC Configurations](cnic-app-troubleshoot.md)

--- 