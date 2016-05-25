---
title: Automatic Virtual Machine Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9353ff39-8d90-402e-b6a9-898b738db61c
author: jaimeo
---
# Automatic Virtual Machine Activation
Automatic Virtual Machine Activation \(AVMA\) acts as a proof\-of\-purchase mechanism, helping to ensure that Windows products are used in accordance with the Product Use Rights and Microsoft Software License Terms.  
  
AVMA lets you install virtual machines on a properly activated Windows server without having to manage product keys for each individual virtual machine, even in disconnected environments. AVMA binds the virtual machine activation to the licensed virtualization server and activates the virtual machine when it starts up. AVMA also provides real\-time reporting on usage and historical data on the license state of the virtual machine. Reporting and tracking data is available on the virtualization server.  
  
## Practical Applications  
On virtualization servers that are activated using Volume Licensing or OEM licensing, AVMA offers several benefits.  
  
Server datacenter managers can use AVMA to do the following:  
  
-   Activate virtual machines in remote locations  
  
-   Activate virtual machines with or without an internet connection  
  
-   Track virtual machine usage and licenses from the virtualization server, without requiring any access rights on the virtualized systems  
  
There are no product keys to manage and no stickers on the servers to read. The virtual machine is activated and continues to work even when it is migrated across an array of virtualization servers.  
  
Service Provider License Agreement \(SPLA\) partners and other hosting providers do not have to share product keys with tenants or access a tenant’s virtual machine to activate it. Virtual machine activation is transparent to the tenant when AVMA is used. Hosting providers can use the server logs to verify license compliance and to track client usage history.  
  
## System Requirements  
AVMA only requires a virtualization server running Windows Server 2012 R2 Datacenter. The guest virtual machine operating system must be Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, or Windows Server 2012 R2 Essentials.  
  
## How to implement AVMA  
  
1.  On a Windows Server 2012 R2 Datacenter virtualization server, install and configure the Microsoft Hyper\-V Server role. For more information, see Install Hyper\-V Server 2012.  
  
2.  Create a virtual machine and install a supported server operating system on it.  
  
3.  Install the AVMA key in the virtual machine. From an elevated command prompt, run the following command:  
  
    ```  
    slmgr /ipk <AVMA_key>  
    ```  
  
The virtual machine will automatically activate the license against the virtualization server.  
  
> [!TIP]  
> You can also employ the AVMA keys in any Unattend.exe setup file.  
  
## AVMA keys  
The following AVMA keys can be used for Windows Server 2012 R2.  
  
|Edition|AVMA key|  
|-----------|------------|  
|Datacenter|Y4TGP\-NPTV9\-HTC2H\-7MGQ3\-DV4TW|  
|Standard|DBGBW\-NPF86\-BJVTX\-K3WKJ\-MTB6V|  
|Essentials|K2XGM\-NMBT3\-2R6Q8\-WF2FK\-P36R2|  
  
## Reporting and Tracking  
The registry \(KVP\) on the virtualization server provides real\-time tracking data for the guest operating systems. Because the registry key moves with the virtual machine, you can get license information as well. By default the KVP returns information about the virtual machine, including the following:  
  
-   Fully qualified domain name  
  
-   Operating system and service packs installed  
  
-   Processor architecture  
  
-   IPv4 and IPv6 network addresses  
  
-   RDP addresses  
  
For more information about how to get this information, see [Hyper\-V Script: Looking at KVP GuestIntrinsicExchangeItems](http://blogs.msdn.com/b/virtual_pc_guy/archive/2008/11/18/hyper-v-script-looking-at-kvp-guestintrinsicexchangeitems.aspx).  
  
> [!NOTE]  
> KVP data is not secured. It can be modified and is not monitored for changes.  
  
> [!IMPORTANT]  
> KVP data should be removed if the AVMA key is replaced with another product key \(retail, OEM, or volume licensing key\).  
  
Historical data about AVMA requests is available in a log file on the virtualization server \(EventID 12310\).  
  
Since the AVMA activation process is transparent, error messages are not displayed. However, the following events are captured in a log file on the virtual machines \(EventID 12309\).  
  
|Notification|Description|  
|----------------|---------------|  
|AVMA Success|The virtual machine was activated.|  
|Invalid Host|The virtualization server is unresponsive. This can happen when the server is not running a supported version of Windows.|  
|Invalid Data|This usually results from a failure in communication between the virtualization server and the virtual machine, often caused by corruption, encryption, or data mismatch.|  
|Activation Denied|The virtualization server could not activate the guest operating system because the AVMA ID did not match.|  
  
2.0  
  
