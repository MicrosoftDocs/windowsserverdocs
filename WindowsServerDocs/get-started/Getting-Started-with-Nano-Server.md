---
title: Install Nano Server
description: "Clean installation, upgrade, migration, and evaluation of Nano Server"
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/29/2016
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 2c2fa45b-6f3b-4663-b421-2da6ecc463bf
author: jaimeo
ms.author: jaimeo
---
# Install Nano Server

>Applies To: Windows Server 2016

Windows Server 2016 offers a new installation option: Nano Server. Nano Server is a remotely administered server operating system optimized for private clouds and datacenters. It is similar to Windows Server in Server Core mode, but significantly smaller, has no local logon capability, and only supports 64-bit applications, tools, and agents. It takes up far less disk space, sets up significantly faster, and requires far fewer updates and restarts than Windows Server. When it does restart, it restarts much faster. The Nano Server installation option is available for Standard and Datacenter editions of Windows Server 2016.  
  
Nano Server is ideal for a number of scenarios:  
  
-   As a "compute" host for Hyper-V virtual machines, either in clusters or not  
  
-   As a storage host for Scale-Out File Server.  
  
-   As a DNS server  
  
-   As a web server running Internet Information Services (IIS)  
  
-   As a host for applications that are developed using cloud application patterns and run in a container or virtual machine guest operating system  
  
These topics describe how to configure a Nano Server image with the packages you'll need, add additional device drivers, and deploy it with an Unattend.xml file. It also explains the options for managing Nano Server remotely, managing the Hyper-V role running on Nano Server, and setup and management of a failover cluster of computers that are running Nano Server. 

## Installation scenarios

### Evaluation
You can obtain a 180-day-licensed evaluation copy of Windows Server from [Windows Server Evaluations](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016?i=1). To try out Nano Server, choose the **Nano Server | 64-bit EXE option**, and then come back to either [Nano Server Quick Start](Nano-Server-Quick-Start.md) or [Deploy Nano Server](Deploy-Nano-Server.md) to get started.

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
If you need a different installation option, you can head [back to the main Windows Server 2016 page](Windows-Server-2016-Technical-Preview-5.md) 
  

  


 
