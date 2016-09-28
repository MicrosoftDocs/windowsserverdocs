---
title: Getting Started with Nano Server
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/27/2016
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: c2be4bbf-5022-4bd7-aabb-dbe58fb1f7bb
author: jaimeo
ms.author: jaimeo
---
# Getting Started with Nano Server

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

### Clean installation
Because you install Nano Server by configuring a VHD, a clean installation is the quickest and simplest deployment method.

- To get started quickly with a basic deployment of Nano Server using DHCP to obtain an IP address, see the [Nano Server Quick Start](Nano-Server-Quick-Start.md) 
- If you're already familiar with the basics of Nano Server, the more detailed topics starting with [Deploy Nano Server](Deploy-Nano-Server.md) offer a full set of instructions for customizing images, working with domains, installing packages for server roles and other features both online and offline, and much more.

### Upgrade
Since Nano Server is new for Windows Server 2016, there isn't an upgrade path from older operating system versions to Nano Server.

### Migration
Since Nano Server is new for Windows Server 2016, there isn't migration path from older operating system versions to Nano Server.
  
 
   
  

  


 
