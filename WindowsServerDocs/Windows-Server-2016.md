---
redirect_url: /windows-server/windows-server
---

# Windows Server 2016

This library provides info for IT pros to evaluate, plan, deploy, secure, and manage Windows Server 2016.

> [!Note] 
> The next version of Windows Server is changing! You can find details about what's on the horizon by visiting [Windows Server Semi-annual Channel Overview](./get-started/semi-annual-channel-overview.md). 

[![Windows Server 2016 Overview Video](media/front-page-video.png)](https://www.youtube-nocookie.com/embed/V8oF0JpDzaM)

<table border="0" width="100%" align='center'>
  <tr style="text-align:center;">
    <td align='center' style="width:25%; border:0;">
      <a href="/windows-server/get-started/what-s-new-in-windows-server-2016">
        &lt;img height=145 src=&quot;media/whats-new-highlight.png&quot; alt=&quot;What&#39;s new icon&quot; title=&quot;Whats new in Windows Server 16?&quot;/&gt;</a>
        <br/>What&#39;s New?
    </td>
    <td align='center' style="width:25%; border:0;">
      <a href="/windows-server/get-started/server-basics">
        &lt;img height=145 src=&quot;media/1-getstarted.png&quot; alt=&quot;get started icon&quot; title=&quot;Get Started with Windows Server 16&quot; /&gt;</a>
      <br/>Get Started
    </td>
    <td align='center' style="width:25%; border:0;">
      <a href="/windows-server/administration/index">
        &lt;img height=145 src=&quot;media/8-management.png&quot; alt=&quot;administer icon&quot; title=&quot;Administer Windows Server&quot; /&gt;</a>
      <br/>Administer
    </td>
    <td align='center' style="width:25%; border:0;">
      <a href="/windows-server/failover-clustering/failover-clustering-overview">
        &lt;img height=145 src=&quot;media/3-failover.png&quot; alt=&quot;Failover clustering icon&quot; title=&quot;Windows Server Failover clustering&quot; /&gt;</a>
      <br/>Failover Clustering
    </td>
  </tr>
  <tr style="text-align:center;">
    <td align='center' style="width:25%; border:0;"><br/>
      <a href="/windows-server/identity/identity-and-access">
        &lt;img height=145 src=&quot;media/4-identity.png&quot; alt=&quot;Identity and access icon&quot; title=&quot;Windows Server Identity and Access&quot; /&gt;</a>
      <br>Identity and Access
    </td>
    <td align='center' style="width:25%; border:0;"><br/>
      <a href="/windows-server/networking/networking">
        &lt;img height=145 src=&quot;media/6-networking.png&quot; alt=&quot;Networking icon&quot; title=&quot;Windows Server Networking&quot; /&gt;
        </a>
      <br/>Networking
    </td>
    <td align='center' style="width:25%; border:0;"><br/>
      <a href="/windows-server/remote/index">
        &lt;img height=145 src=&quot;media/remote.png&quot; alt=&quot;remote icon&quot; title=&quot;Remote access and server management&quot; /&gt;
        </a>
      <br/>Remote Access
    </td>
    <td align='center' style="width:25%; border:0;"><br/>
      <a href="/windows-server/security/security-and-assurance">
        &lt;img height=145 src=&quot;media/5-security.png&quot; alt=&quot;Security icon&quot; title=&quot;Windows Server Security and Assurance&quot; /&gt;
      </a>
      <br/>Security and Assurance
    </td>
  </tr>
  <tr style="text-align:center;">
    <td align='center' style="width:25%; border:0;">&nbsp;</td>
    <td align='center' style="width:25%; border:0;"><br>
      <a href="/windows-server/storage/storage">
        &lt;img height=145 src=&quot;media/7-storage.png&quot; alt=&quot;Storage icon&quot; title=&quot;Windows Server Storage&quot; /&gt;
      </a>
      <br/>Storage
    </td>
   <td align='center' style="width:25%; border:0;"><br/>
      <a href="/windows-server/virtualization/virtualization">
        &lt;img height=145 src=&quot;media/virtualization.png&quot; alt=&quot;virtualization icon&quot; title=&quot;Windows Server Virtualization&quot; /&gt;</a>
      <br/>Virtualization
    </td>
    <td align='center' style="width:25%; border:0;">&nbsp; </td>
  </tr>
</table>

<br/>

> [!Note] 
> To experience first-hand new features and functionality available in Windows Server 2016, you can download an evaluation version by visiting [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016). 


## Windows Server 2016 editions

Windows Server 2016 is available in Standard, Datacenter, and Essentials editions. Windows Server 2016 Datacenter includes unlimited virtualization rights plus new features to build a software-defined datacenter. Windows Server 2016 Standard offers enterprise-class features with limited virtualization rights. Windows Server Essentials is an ideal cloud-connected first server. It has its own [extensive documentation](https://go.microsoft.com/fwlink/?LinkID=827171)—the content here focuses on Standard and Datacenter editions. The following table briefly summarizes the key differences between Standard and Datacenter editions:

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

For more information, see [Pricing and licensing for Windows Server 2016](https://www.microsoft.com/cloud-platform/windows-server-pricing) and [Compare features in Windows Server versions](https://www.microsoft.com/cloud-platform/windows-server-comparison).

## Installation options

Both Standard and Datacenter editions offer three installation options:

- **Server Core:** reduces the space required on disk, the potential attack surface, and especially the servicing requirements. This is the **recommended** option unless you have a particular need for additional user interface elements and graphical management tools.
- **Server with Desktop Experience:** installs the standard user interface and all tools, including client experience features that required a separate installation in Windows Server 2012 R2. Server roles and features are installed with Server Manager or by other methods.
- **Nano Server:** is a remotely administered server operating system optimized for private clouds and datacenters. It is similar to Windows Server in Server Core mode, but significantly smaller, has no local logon capability, and only supports 64-bit applications, tools, and agents. It takes up far less disk space, sets up significantly faster, and requires far fewer updates and restarts than the other options.

>[!Note]
> Unlike some previous releases of Windows Server, you cannot convert between Server Core and Server with Desktop Experience after installation. For example, if you install Server Core and later decide to user Server with Desktop Experience, you should do a fresh installation (and vice versa).


Now that you know which edition and installation option is right for you, click below to get started with Windows Server 2016.
<br/>
<br/>

<table border="0" width="100%" align='center'>
  <tr style="text-align:center;">
    <td align='center' style="width:33%; border:0;">
      <a  href="/windows-server/get-started/getting-started-with-nano-server"> <img width="175" src="media/nano.png" alt="Icon representing Nano server" title="Nano Server - Lightest Weight" /><br/>Nano Server - <br/>Lightest weight</a>
    </td>
    <td align='center' style="width:33%; border:0;"><a href="/windows-server/get-started/getting-started-with-server-core"> <img width="175" src="media/servercore.png" alt="Icon representing the Server Core installation" title="Server Core - Recommended" /><br/>Server Core - <br/>Recommended</a></td>
   <td align='center' style="width:33%; border:0;"><a href="/windows-server/get-started/getting-started-with-server-with-desktop-experience"><img width="175" src="media/desktop.png" alt="Icon representing the full desktop experience installation option for Windows Server" title="Desktop Experience - Full Experience" /><br/>Desktop Experience - <br/>Full interface</a></td>
  </tr>
</table>

## Windows Server Software-Defined Datacenter (SDDC)

Virtualized Storage, Networking, Security and Management technologies are the building blocks of the Windows Server Software-Defined Datacenter (SDDC).
<br/>
<br/>

<table border="0" width="100%" align='center'>
  <tr style="text-align:center;">
    <td align='center' style="width:10%; border:0;"></td>
    <td align='center' style="width:50%; border:0;"><a href="/windows-server/sddc"><img width="400" src="media/sddc/WS16-heading.png" alt="Icon representing SDDC" title="Windows Server Software-Defined Datacenter (SDDC)" /><br/>Windows Server Software-Defined Datacenter (SDDC)</a></td>
    <td align='center' style="width:10%; border:0;"></td>
  </tr>
</table>
