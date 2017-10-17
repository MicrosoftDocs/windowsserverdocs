---
title: Windows Server
description: Get started with Windows Server
ms.prod: windows-server-threshold
ms.date: 10/17/2017
ms.technology: server-general
ms.topic: article
author: jaimeo
ms.author: jaimeo
manager: dongill
ms.localizationpriority: high
---
# Windows Server technical content library

This library provides info for IT pros to evaluate, plan, deploy, secure, and manage Windows Server.

**What's new in Windows Server? Check out our latest mechanics video:**
<br>
<iframe src="https://www.youtube.com/embed/yea9OXRZ8xg" width="640" height="360" allowfullscreen></iframe>


<br>
<table border="0" width="100%" align='center'>
  <tr style="text-align:center;">
    <td valign="bottom" style="width:20%; border:0;">
      <a href="/windows-server/get-started/whats-new-in-windows-server-1709">
        ![](media/landing-icons/new.png)</br>What's New?</a>    
    </td>
    <td valign="bottom" style="width:20%; border:0;">
      <a href="/windows-server/get-started/server-basics">
        ![](media/landing-icons/getstarted.png)</br>Get Started</a>
    </td>
    <td valign="bottom" style="width:20%; border:0;">
      <a href="/windows-server/administration/manage-windows-server">
        ![](media/landing-icons/manage.png)</br>Manage</a>
    </td>
    <td valign="bottom" style="width:20%; border:0;">
      <a href="/windows-server/failover-clustering/failover-clustering-overview">
        ![](media/landing-icons/cluster.png)</br>Failover Clustering</a>
    </td>
    <td valign="bottom" style="width:20%; border:0;"><br/>
      <a href="/windows-server/identity/identity-and-access">
        ![Identity icon](media/landing-icons/identity.png)<br/>Identity and Access</a>
    </td>
  </tr>
  <tr style="text-align:center;">
    <td valign="bottom" style="width:20%; border:0;"><br/>
      <a href="/windows-server/networking/networking">
        ![Network icon](media/landing-icons/network.png)
        <br/>Networking</a>
    </td>
    <td valign="bottom" style="width:20%; border:0;"><br/>
      <a href="/windows-server/remote/index">
        ![Remote icon](media/landing-icons/remote.png)
        <br/>Remote Access</a>
    </td>
    <td valign="bottom" style="width:20%; border:0;"><br/>
      <a href="/windows-server/security/security-and-assurance">
        ![Security icon](media/landing-icons/security.png)
      <br/>Security and Assurance</a>
    </td>
    <td valign="bottom" style="width:20%; border:0;"><br>
      <a href="/windows-server/storage/storage">
        ![Storage icon](media/landing-icons/storage.png)
      <br/>Storage</a>
    </td>
   <td valign="bottom" style="width:20%; border:0;"><br/>
      <a href="/windows-server/virtualization/virtualization">
        ![Virtualization icon](media/landing-icons/virtualization.png)<br/>Virtualization</a>
    </td>
      </tr>
</table>

<br/>

> [!Note] 
> To experience first-hand new features and functionality available in Windows Server 2016, you can download an evaluation version by visiting [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016). 


## Windows Server, version 1709

Windows Server, version 1709 is the first release in the new Semi-Annual Channel. Semi-Annual Channel releases such as this one are ideal for customers who are moving at a “cloud cadence," such as those on rapid development cycles or hosters keeping up with the latest Hyper-V investments. 

Windows Server, version 1709 runs in Server Core mode. That means there is no local console or graphical user interface, so you manage it remotely. However, it offers great advantages such as smaller hardware requirements, much smaller attack surface, and a reduction in the need for updates. If you're new to working with Server Core, [Manage a Server Core server](administration/server-core/server-core-manage.md) will help you get used to this environment. [Manage Windows Server](administration/manage-windows-server.md) shows you the various options for managing servers remotely.

Check out [What's New in Windows Server version 1709](get-started/whats-new-in-windows-server-1709.md) for more information about the new features and functionality added in Windows Server, version 1709.

## Windows Server editions

Windows Server, version 1709, is available in Standard and Datacenter editions, while Windows Server 2016 is available in Standard, Datacenter, and Essentials editions. Windows Server Datacenter includes unlimited virtualization rights plus new features to build a software-defined datacenter. Windows Server Standard offers enterprise-class features with limited virtualization rights. Windows Server 2016 Essentials is an ideal cloud-connected first server. It has its own [extensive documentation](http://go.microsoft.com/fwlink/?LinkID=827171)—the content here focuses on Standard and Datacenter editions. The following table briefly summarizes the key differences between Standard and Datacenter editions:

|Feature|Datacenter|Standard|  
|-------------------|----------|-----------------------|  
|Core functionality of Windows Server| yes| yes|
|OSEs / Hyper-V containers|unlimited|	2|
|Windows Server containers|unlimited|	unlimited|
|Host Guardian Service| yes| yes|
|Storage features including Storage Replica| yes| no|
|Shielded Virtual Machines| yes| no|
|Software Defined Networking Infrastructure (Network Controller, Software Load Balancer, and Multi-tenant Gateway)| yes| no|

For more information, see [Pricing and licensing for Windows Server 2016](https://www.microsoft.com/en-us/cloud-platform/windows-server-pricing) and [Compare features in Windows Server versions](https://www.microsoft.com/en-us/cloud-platform/windows-server-comparison).

## Installation options

Both Standard and Datacenter editions offer two installation options:

- **Server Core:** reduces the space required on disk, the potential attack surface, and especially the servicing requirements. This is the **recommended** option unless you have a particular need for additional user interface elements and graphical management tools.
- **Server with Desktop Experience:** installs the standard user interface and all tools, including client experience features that required a separate installation in Windows Server 2012 R2. Server roles and features are installed with Server Manager or by other methods.

If you are installing Windows Server, version 1709, Server Core is your only installation option, while Windows Server 2016 offers both the Server Core and Server with Desktop Experience installation options.

>[!Note]
> Unlike some previous releases of Windows Server, you cannot convert between Server Core and Server with Desktop Experience after installation. For example, if you install Server Core and later decide to user Server with Desktop Experience, you should do a fresh installation (and vice versa).


Now that you know which edition and installation option is right for you, click below to get started with Windows Server.
<br/>
<br/>

<table border="0" width="100%" align='center'>
    <td align='center' style="width:50%; border:0;"><a href="/windows-server/get-started/getting-started-with-server-core"> <img width="175" src="media/servercore.png" alt="" title="Server Core - Recommended" /><br/>Server Core - <br/>Recommended</a></td>
   <td align='center' style="width:50%; border:0;"><a href="/windows-server/get-started/getting-started-with-server-with-desktop-experience"><img width="175" src="media/desktop.png" alt="" title="Desktop Experience - Full Experience" /><br/>Desktop Experience - <br/>Full interface</a></td>
  </tr>
</table>

## Windows Server Software-Defined Datacenter (SDDC)

Virtualized Storage, Networking, Security and Management technologies are the building blocks of the Windows Server Software-Defined Datacenter (SDDC).
<br/>
<br/>

<table border="0" width="100%" align='center'>
  <tr style="text-align:center;">
    <td align='center' style="width:10%; border:0;"></td>
    <td align='center' style="width:50%; border:0;"><a href="/windows-server/sddc"><img width="400" src="media/sddc/WS16-heading.png" alt="" title="Windows Server Software-Defined Datacenter (SDDC)" /><br/>Windows Server Software-Defined Datacenter (SDDC)</a></td>
    <td align='center' style="width:10%; border:0;"></td>
  </tr>
</table>

Not finding content you need? Windows 10 users, tell us what you want on [Feedback Hub](feedback-hub:?tabid=2&contextid=898). 