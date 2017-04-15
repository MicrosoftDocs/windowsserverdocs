---
title: Windows Server 2016
description: "Get started with Windows Server 2016. "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 03/15/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d8972680-d5ee-430e-a97a-991ac872b0d6
author: jaimeo
ms.author: jaimeo
manager: dongill
---

# Windows Server 2016

This library provides the core content that IT pros need to evaluate, plan, deploy, secure and manage Windows Server 16 in the enterprise.

[![Storage Spaces Direct Overview Video](media/front-page-video.png)](https://www.youtube.com/embed/V8oF0JpDzaM)

<table border="0" width="100%">
  <tr style="text-align:center">
    <td style="width:25%; border:0;">
      <a href="What-s-New-in-Windows-Server-2016.md">
        <img height=145 src="media/whats-new-highlight.png" alt="What's new icon" title="Whats new in Windows Server 16?"/>
        <br/>What's New?</a>
    </td>
    <td style="width:25%; border:0;">
      <a href="server-basics">
        <img height=145 src="media/1-getstarted.png" alt="get started icon" title="Get Started with Windows Server 16" />
      <br/>Get Started</a>
    </td>
    <td style="width:25%; border:0;">
      <a href="../administration/index">
        <img height=145 src="media/8-management.png" alt="administer icon" title="Administer Windows Server" />
      <br/>Administer</a>
    </td>
    <td style="width:25%; border:0;">
      <a href="/windows-server/failover-clustering/failover-clustering-overview">
        <img height=145 src="media/3-failover.png" alt="Failover clustering icon" title="Windows Server Failover clustering" />
      <br/>Failover Clustering</a>
    </td>
  </tr>
  <tr style="text-align:center;">
    <td style="width:25%; border:0;">
      <a href="../identity/identity-and-access">
        <img height=145 src="media/4-identity.png" alt="Identity and access icon" title="Windows Server Identity and Access" />
      <br>Identity and Access</a><br/>
    </td>
    <td style="width:25%; border:0;"><br/>
      <a href="../networking/networking">
        <img height=145 src="media/6-networking.png" alt="Networking icon" title="Windows Server Networking" />
      <br/>Networking</a>
    </td>
    <td style="width:25%; border:0;"><br/>
      <a href="../remote/index">
        <img height=145 src="media/remote.png" alt="remote icon" title="Windows Server Storage" />
      <br/>Remote</a><br/>
    </td>
    <td style="width:25%; border:0;"><br/>
      <a href="../networking/networking">
        <img height=145 src="media/5-security.png" alt="Security icon" title="Windows Server Security and Assurance" />
      <br/>Security and Assurance</a><br/>
    </td>
  </tr>
  <tr style="text-align:center;">
    <td style="width:25%; border:0;">&nbsp; </td>
     <td style="width:25%; border:0;"><br>
      <a href="../storage/storage">
        <img height=145 src="media/7-storage.png" alt="Storage icon" title="Windows Server Storage" />
      <br/>Storage</a><br/>
    </td>
   <td style="width:25%; border:0;"><br/>
      <a href="../virtualization/index">
        <img height=145 src="media/virtualization.png" alt="virtualization icon" title="Windows Server Virtualization" />
      <br/>Virtualization</a>
    </td>
    <td style="width:25%; border:0;"></td>
    <td style="width:25%; border:0;">&nbsp; </td>
  </tr>
</table>

> [!Note]  
> To experience first-hand new features and functionality available in Windows Server 2016, you can download an evaluation version by visiting [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016).  
>   

## Windows Server 2016 editions

Windows Server 2016 is available in Standard, Datacenter, and Essentials editions. Windows Server 2016 Datacenter includes unlimited virtualization rights plus new features to build a software-defined datacenter. Windows Server 2016 Standard offers enterprise-class features with limited virtualization rights. Windows Server Essentials is an ideal cloud-connected first server. It has its own [extensive documentation](http://go.microsoft.com/fwlink/?LinkID=827171)—the content here focuses on Standard and Datacenter editions. The following table briefly summarizes the key differences between Standard and Datacenter editions:

|Feature|Datacenter|Standard|  
|-------------------|----------|-----------------------|  
|Core functionality of Windows Server| yes| yes|
|OSEs / Hyper-V containers|unlimited|	2|
|Windows Server containers|unlimited|	unlimited|
|Host Guardian Service| yes| yes|
|Nano Server installation option| yes| yes|
|Storage features including Storage Spaces Direct and Storage Replica| yes| no|
|Shielded Virtual Machines| yes| no|
|Software Defined Networking Infrastructure (Network Controller, Software Load Balancer, and Multi-tenant Gateway)| yes| no|

For more information, see [Pricing and licensing for Windows Server 2016](https://www.microsoft.com/en-us/cloud-platform/windows-server-pricing) and [Compare features in Windows Server versions](https://www.microsoft.com/en-us/cloud-platform/windows-server-comparison).

## Installation options

Both Standard and Datacenter editions offer three installation options:

- **Server Core:** reduces the space required on disk, the potential attack surface, and especially the servicing requirements. This is the **recommended** option unless you have a particular need for additional user interface elements and graphical management tools.
- **Server with Desktop Experience:** installs the standard user interface and all tools, including client experience features that required a separate installation in Windows Server 2012 R2. Server roles and features are installed with Server Manager or by other methods.
- **Nano Server:** is a remotely administered server operating system optimized for private clouds and datacenters. It is similar to Windows Server in Server Core mode, but significantly smaller, has no local logon capability, and only supports 64-bit applications, tools, and agents. It takes up far less disk space, sets up significantly faster, and requires far fewer updates and restarts than the other options.

>[!NOTE]
>
>Unlike some previous releases of Windows Server, you cannot convert between Server Core and Server with Desktop Experience after installation. For example, if you install Server Core and later decide to user Server with Desktop Experience, you should do a fresh installation (and vice versa).


Now that you know which edition and installation option is right for you, click below to get started with Windows Server 2016.


<table border=0 width="100%">
  <tr style='text-align:center;'>
    <td style='width:34%'><a href="/windows-server/get-started/getting-started-with-nano-server"> <img height=145 src="media/nano.png" alt="Icon representing Nano server" title="Nano Server - Lightest Weight" /><br/>Nano Server - <br/>Lightest weight</a></td>
    <td style='width:33%'><a href="/windows-server/get-started/getting-started-with-server-core"> <img height=145 src="media/servercore.png" alt="Icon representing the Server Core installation" title="Server Core - Recommended" /><br/>Server Core - <br/>Recommended</a></td>
    <td style='width:33%'><a href="/windows-server/get-started/getting-started-with-server-with-desktop-experience"><img height=145 src="media/desktop.png" alt="Icon representing the full desktop experience installation option for Windows Server" title="Desktop Experience - Full Experience" /><br/>Desktop Experience - <br/>Full interface</a></td>
  </tr>
</table>