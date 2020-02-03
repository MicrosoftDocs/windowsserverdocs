---
title: Install Nano Server
description: "Clean installation, upgrade, migration, and evaluation of Nano Server"
ms.prod: windows-server
ms.service: na
manager: dougkim
ms.technology: server-nano
ms.date: 09/06/2017
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 2c2fa45b-6f3b-4663-b421-2da6ecc463bf
author: jaimeo
ms.author: jaimeo
ms.localizationpriority: medium
---
# Install Nano Server

>Applies To: Windows Server 2016

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means. 

Windows Server 2016 offers a new installation option: Nano Server. Nano Server is a remotely administered server operating system optimized for private clouds and datacenters. It is similar to Windows Server in Server Core mode, but significantly smaller, has no local logon capability, and only supports 64-bit applications, tools, and agents. It takes up far less disk space, sets up significantly faster, and requires far fewer updates and restarts than Windows Server. When it does restart, it restarts much faster. The Nano Server installation option is available for Standard and Datacenter editions of Windows Server 2016.  

Nano Server is ideal for a number of scenarios:  
  
-   As a "compute" host for Hyper-V virtual machines, either in clusters or not  
  
-   As a storage host for Scale-Out File Server.  
  
-   As a DNS server  
  
-   As a web server running Internet Information Services (IIS)  
  
-   As a host for applications that are developed using cloud application patterns and run in a container or virtual machine guest operating system  
  
## Important differences in Nano Server

Because Nano Server is optimized as a lightweight operating system for running “cloud-native” applications based on containers and micro-services or as an agile and cost-effective datacenter host with a dramatically smaller footprint, there are important differences in Nano Server versus Server Core or Server with Desktop Experience installations:

- Nano Server is "headless;" there is no local logon capability or graphical user interface.
- Only 64-bit applications, tools, and agents are supported.
- Nano Server cannot serve as an Active Directory domain controller.
- Group Policy is not supported. However, you can use [Desired State Configuration](https://msdn.microsoft.com/powershell/dsc/nanoDsc) to apply settings at scale.
- Nano Server cannot be configured to use a proxy server to access the internet.
- NIC Teaming (specifically, load balancing and failover, or LBFO) is not supported. Switch-embedded teaming (SET) is supported instead.
- Microsoft Endpoint Configuration Manager and System Center Data Protection Manager are not supported.
- Best Practices Analyzer (BPA) cmdlets and BPA integration with Server Manager are not supported.
- Nano Server does not support virtual host bus adapters (HBAs).
- Nano Server does not need to be activated with a product key. When functioning as a Hyper-V host, Nano Server does not support [Automatic Virtual Machine Activation](https://technet.microsoft.com/library/dn303421%28v=ws.11%29.aspx) (AVMA). Virtual machines running on a Nano Server host can be activated using [Key Management Service](https://technet.microsoft.com/library/jj612867(v=ws.11).aspx) (KMS) with a generic volume license key or using [Active Directory-based activation](https://technet.microsoft.com/library/dn502534(v=ws.11).aspx).
- The version of Windows PowerShell provided with Nano Server has important differences. For details, see [PowerShell on Nano Server](PowerShell-on-Nano-Server.md).
- Nano Server is supported only on the Current Branch for Business (CBB) model--there is no Long-Term Servicing Branch (LTSB) release for Nano Server at this time. See the following subsection for more information.

### Current Branch for Business
Nano Server is serviced with a more active model, called Current Branch for Business (CBB), in order to support customers who are moving at a “cloud cadence," using rapid development cycles. In this model, feature update releases of Nano Server are expected two to three times per year. This model requires [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default.aspx) for Nano Servers deployed and operated in production. To maintain support, administrators must stay no more than two CBB releases behind. However, these releases do not auto-update existing deployments; administrators perform manual installation of a new CBB release at their convenience. For some additional information, see [Windows Server 2016 new Current Branch for Business servicing option](https://blogs.technet.microsoft.com/windowsserver/2016/07/12/windows-server-2016-new-current-branch-for-business-servicing-option/).

The Server Core and Server with Desktop Experience installation options are still serviced on the [Long-Term Servicing Branch (LTSB) model](https://support.microsoft.com/lifecycle#gp%2Fgp_msl_policy), comprising 5 years of mainstream support and 5 years of extended support.

## Installation scenarios

### Evaluation
You can obtain a 180-day-licensed evaluation copy of Windows Server from [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016). To try out Nano Server, choose the **Nano Server | 64-bit EXE option**, and then come back to either [Nano Server Quick Start](Nano-Server-Quick-Start.md) or [Deploy Nano Server](Deploy-Nano-Server.md) to get started.

### Clean installation
Because you install Nano Server by configuring a VHD, a clean installation is the quickest and simplest deployment method.

- To get started quickly with a basic deployment of Nano Server using DHCP to obtain an IP address, see the [Nano Server Quick Start](Nano-Server-Quick-Start.md) 
- If you're already familiar with the basics of Nano Server, the more detailed topics starting with [Deploy Nano Server](Deploy-Nano-Server.md) offer a full set of instructions for customizing images, working with domains, installing packages for server roles and other features both online and offline, and much more.

> [!IMPORTANT]  
> Once Setup has completed and immediately after you have installed all of the server roles and features you need, check for and install updates available for Windows Server 2016. For Nano Server, see the "Managing updates in Nano Server" section of [Manage Nano Server](Manage-Nano-Server.md).

### Upgrade
Since Nano Server is new for Windows Server 2016, there isn't an upgrade path from older operating system versions to Nano Server.

### Migration
Since Nano Server is new for Windows Server 2016, there isn't migration path from older operating system versions to Nano Server.
  
-------------------------------------
If you need a different installation option, you can head [back to the main Windows Server 2016 page](windows-server-2016.md) 

  


 
