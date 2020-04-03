---
title: Automatic virtual machine activation
TOCTitle: Automatic VM Activation
description: How to activate VMs in Windows Server 2019, Windows Server 2016, and Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
ms.author: elizapo
ms.localizationpriority: medium
---

# Automatic virtual machine activation

> Applies to: Windows Server 2019, Windows Server Semi-Annual Channel, Windows Server 2016, Windows Server 2012 R2

Automatic Virtual Machine Activation (AVMA) acts as a proof-of-purchase mechanism, helping to ensure that Windows products are used in accordance with the Product Use Rights and Microsoft Software License Terms.

AVMA lets you install virtual machines on a properly activated Windows server without having to manage product keys for each individual virtual machine, even in disconnected environments. AVMA binds the virtual machine activation to the licensed virtualization server and activates the virtual machine when it starts up. AVMA also provides real-time reporting on usage and historical data on the license state of the virtual machine. Reporting and tracking data is available on the virtualization server.

## Practical applications

On virtualization servers that are activated using Volume Licensing or OEM licensing, AVMA offers several benefits.

Server datacenter managers can use AVMA to do the following:

  - Activate virtual machines in remote locations

  - Activate virtual machines with or without an internet connection

  - Track virtual machine usage and licenses from the virtualization server, without requiring any access rights on the virtualized systems

There are no product keys to manage and no stickers on the servers to read. The virtual machine is activated and continues to work even when it is migrated across an array of virtualization servers.

Service Provider License Agreement (SPLA) partners and other hosting providers do not have to share product keys with tenants or access a tenant's virtual machine to activate it. Virtual machine activation is transparent to the tenant when AVMA is used. Hosting providers can use the server logs to verify license compliance and to track client usage history.

## System requirements

AVMA requires a Microsoft Virtualization Server running Windows Server 2019 Datacenter, Windows Server 2016 Datacenter, or Windows Server 2012 R2. 

Here are the guests that the different version hosts can activate:

|Server host version|Windows Server 2019|Windows Server 2016|Windows Server 2012 R2|
|-|-|-|-|
|Windows Server 2019|X|X|X|
|Windows Server 2016| |X|X|
|Windows Server 2012 R2| ||X|

Note that these activate all editions (Datacenter, Standard, or Essentials).

This tool does not work with other Virtualization Server technologies.

## How to implement AVMA

1.  On a Windows Server Datacenter virtualization server, install and configure the Microsoft Hyper-V Server role. For more information, see [Install Hyper-V Server](../virtualization/hyper-v/get-started/install-the-hyper-v-role-on-windows-server.md).

2.  [Create a virtual machine](../virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v.md) and install a supported server operating system on it.

3.  Install the AVMA key in the virtual machine. From an elevated command prompt, run the following command:
    
    ``` 
    slmgr /ipk <AVMA_key>  
    ```

The virtual machine will automatically activate the license against the virtualization server.


> [!TIP]
> You can also employ the AVMA keys in any Unattend.exe setup file.


## AVMA keys

The following AVMA keys can be used for Windows Server 2019.

|Edition|	AVMA key|
|-|-|
|Datacenter|	H3RNG-8C32Q-Q8FRX-6TDXV-WMBMW|
|Standard|	TNK62-RXVTB-4P47B-2D623-4GF74|
|Essentials|	2CTP7-NHT64-BP62M-FV6GG-HFV28|
 
The following AVMA keys can be used for Windows Server, versions 1909, 1903, and 1809.

|Edition|	AVMA key|
|-|-|
|Datacenter|	H3RNG-8C32Q-Q8FRX-6TDXV-WMBMW|
|Standard|	TNK62-RXVTB-4P47B-2D623-4GF74|

The following AVMA keys can be used for Windows Server, version 1803 and 1709.

|Edition|AVMA key|
|-|-|
|Datacenter|TMJ3Y-NTRTM-FJYXT-T22BY-CWG3J|
|Standard|C3RCX-M6NRP-6CXC9-TW2F2-4RHYD|


The following AVMA keys can be used for Windows Server 2016.

|Edition|AVMA key|
|-|-|
|Datacenter|TMJ3Y-NTRTM-FJYXT-T22BY-CWG3J|
|Standard|C3RCX-M6NRP-6CXC9-TW2F2-4RHYD|
|Essentials|B4YNW-62DX9-W8V6M-82649-MHBKQ|


The following AVMA keys can be used for Windows Server 2012 R2.

|Edition|AVMA key|
|-|-|
|Datacenter|Y4TGP-NPTV9-HTC2H-7MGQ3-DV4TW|
|Standard|DBGBW-NPF86-BJVTX-K3WKJ-MTB6V|
|Essentials|K2XGM-NMBT3-2R6Q8-WF2FK-P36R2|

## Reporting and tracking

The registry (KVP) on the virtualization server provides real-time tracking data for the guest operating systems. Because the registry key moves with the virtual machine, you can get license information as well. By default the KVP returns information about the virtual machine, including the following:

  - Fully qualified domain name

  - Operating system and service packs installed

  - Processor architecture

  - IPv4 and IPv6 network addresses

  - RDP addresses

For more information about how to get this information, see [Hyper-V Script: Looking at KVP GuestIntrinsicExchangeItems](https://blogs.msdn.com/b/virtual_pc_guy/archive/2008/11/18/hyper-v-script-looking-at-kvp-guestintrinsicexchangeitems.aspx).


> [!NOTE]
> KVP data is not secured. It can be modified and is not monitored for changes.



> [!IMPORTANT]
> KVP data should be removed if the AVMA key is replaced with another product key (retail, OEM, or volume licensing key).


Historical data about AVMA requests is available in a log file on the virtualization server (EventID 12310).

Since the AVMA activation process is transparent, error messages are not displayed. However, the following events are captured in a log file on the virtual machines (EventID 12309).

|Notification|Description|
|-|-|
|AVMA Success|The virtual machine was activated.|
|Invalid Host|The virtualization server is unresponsive. This can happen when the server is not running a supported version of Windows.|
|Invalid Data|This usually results from a failure in communication between the virtualization server and the virtual machine, often caused by corruption, encryption, or data mismatch.|
|Activation Denied|The virtualization server could not activate the guest operating system because the AVMA ID did not match.|

