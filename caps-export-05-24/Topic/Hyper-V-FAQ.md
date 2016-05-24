---
title: Hyper-V FAQ
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3ff169bf-c223-4484-a44b-6a96bee43718
author: cwatsonmsft
---
# Hyper-V FAQ
The following are some of the most frequently asked questions about Hyper\-V. These questions are based on actual calls and e\-mails to Microsoft and might save you time and effort.  
  
## Frequently Asked Questions  
[Hyper\-V deployment](#BKMK_1)  
  
-   [How can I determine the version of Hyper\-V?](#BKMK_2)  
  
-   [Does my BIOS support virtualization?](#BKMK_3)  
  
-   [Is my workload supported on Hyper\-V?](#BKMK_4)  
  
-   [Can I run Windows PowerShell on a Server Core installation?](#BKMK_5)  
  
-   [How do I manage platform power efficiency?](#BKMK_6)  
  
-   [Where can I find Hyper\-V updates and hotfixes?](#BKMK_7)  
  
[Virtual machines](#BKMK_8)  
  
-   [Are 1000\-Mbps network adapters supported on virtual machines?](#BKMK_9)  
  
-   [Are USB devices supported on virtual machines?](#BKMK_10)  
  
-   [Some virtual devices are unavailable due to lack of drivers for them.](#BKMK_11)  
  
-   [Are dynamic disks\/differential disks\/snapshots supported?](#BKMK_12)  
  
-   [What interface is supported for the shared disk of the cluster configuration between guest operating systems using Failover Clustering in Windows Server 2008?](#BKMK_13)  
  
### <a name="BKMK_1"></a>Hyper\-V deployment  
  
##### <a name="BKMK_2"></a>How can I determine the version of Hyper\-V?  
As of this writing, there are two versions of Hyper\-V, with the following version numbers:  
  
-   Beta version \= 6.0.6001.17101  
  
-   Release To Market \(RTM\) \= 6.0.6001.18016  
  
###### To check the Hyper\-V version number  
  
1.  On the server running Hyper\-V, open Hyper\-V Manager and click **Help.**  
  
2.  Click **About Hyper\-V Manager…**  
  
Alternatively, open a command prompt on the server running Hyper\-V and type the following command:  
  
```c#  
wmic datafile where name=”c:\\windows\\system32\\vmms.exe” get version  
```  
  
###### To check the integration services version number  
  
1.  On the virtual machine, open the Device Manager Microsoft Management Console \(MMC\) snap\-in and click a “vmBus” device, for example **VmBus Network Adapter**.  
  
2.  Click **Properties**.  
  
3.  Click the **Driver** tab. The number should end in 18016 \(the RTM version\).  
  
**See also:** [Hyper\-V Planning and Deployment Guide](http://go.microsoft.com/fwlink/?LinkID=108560) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=108560\)  
  
##### <a name="BKMK_3"></a>Does my BIOS support virtualization?  
Hyper\-V requires hardware\-assisted virtualization, which is available in processors that include a virtualization option—specifically processors with Intel Virtualization Technology \(Intel VT\) or AMD Virtualization \(AMD\-V\) technology. Hyper\-V also requires that hardware\-enforced Data Execution Prevention \(DEP\) is available and enabled. Specifically, you must enable the Intel XD bit \(execute disable bit\) or AMD NX bit \(no execute bit\). The [Windows Server catalog](http://go.microsoft.com/fwlink/?LinkId=111228) shows an up\-to\-date list of all successfully Hyper\-V tested systems \(search for Hyper\-V as an additional qualification\) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111228\). To scan your entire IT environment, and get a report of machines supporting virtualization, use the Microsoft Assessment and Planning Toolkit solution accelerator at: http:\/\/technet.microsoft.com\/en\-us\/library\/bb977556.aspx \(FWLINK NEEDED\)  
  
For older server systems, newer ones not yet in the catalog, or for non\-server systems, you can use the following tools to check if your processor supports Hyper\-V:  
  
-   [AMD Hyper\-V Compatibility Check Utility](http://go.microsoft.com/fwlink/?LinkId=150561) \(.zip file\) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=150561\)  
  
-   [Intel Processor Identification Utility](http://go.microsoft.com/fwlink/?LinkId=150562) \(Windows Version\) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=150562\)  
  
##### <a name="BKMK_4"></a>Is my workload supported on Hyper\-V?  
See [article 957006](http://go.microsoft.com/fwlink/?LinkID=129503) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=129503\) for information about the support policy for running Microsoft server software in the following supported virtualization environments:  
  
-   Windows Server 2008 with Hyper\-V  
  
-   Microsoft Hyper\-V Server 2008  
  
-   Server Virtualization Validation Program \(SVVP\)  
  
    Microsoft supports the Microsoft server software that is running in the supported virtualization environments that are listed in the "More Information" section.  
  
    **See also:** [Microsoft Support Life\-Cycle policy](http://go.microsoft.com/fwlink/?LinkId=150563) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=150563\)  
  
##### <a name="BKMK_5"></a>Can I run Windows PowerShell on a Server Core installation?  
Windows PowerShell is not supported on a Server Core installation of Windows Server 2008.  
  
##### <a name="BKMK_6"></a>How do I manage platform power efficiency?  
System sleep states, such as Standby and Hibernate, are not supported when the Hyper\-V role is enabled.  However, processor power management features are supported with Hyper\-V, and will allow the system to automatically scale processor power consumption with system utilization.  The management operating system owns and directs power policy for the virtual machine, and works in conjunction with the hypervisor to direct the system’s processors into low power idle and performance states based on system activity.  System power policy can be configured in the management operating system. There is no power management configuration exposed from Hyper\-V.  
  
##### <a name="BKMK_7"></a>What PowerShell scripts are available for Hyper\-V?  
See the PowerShell scripts available for Hyper\-V at the [PowerShell management Library for Hyper\-V](http://go.microsoft.com/fwlink/?LinkID=135684) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135684\).  
  
##### Where can I find Hyper\-V updates and hotfixes?  
The [Hyper\-V Update List](http://go.microsoft.com/fwlink/?LinkID=140282) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=140282\) shows the list of software updates and hotfixes for Hyper\-V. Updates that are available on Windows Update are indicated, as well as the download location for those that are available at the Microsoft Download Center. In the “Community Content” section of the page, community members also list updates for the following:  
  
-   Windows Server 2008  
  
-   Virtual Machine Manager  
  
-   Virtual Server and Virtual PC  
  
-   Data Protection Manager  
  
### <a name="BKMK_8"></a>Virtual machines  
  
##### <a name="BKMK_9"></a>Are 1000\-Mbps network adapters supported on virtual machines?  
The device sharing model in Hyper\-V does not expose the physical network adapter of the server running Hyper\-V to the virtual machine. The virtual machine can use a network adapter optimized for use in virtual machines, or a legacy Intel\/DEC 21140 adapter \(depending on the virtual machine configuration setting\). If the version of Windows on the server running Hyper\-V supports a physical network adapter, you can create a virtual network switch for the virtual machines to use.  
  
**See also:** [Configuring Virtual Networks](http://go.microsoft.com/fwlink/?LinkID=131362) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=131362\)  
  
##### <a name="BKMK_10"></a>Are USB devices supported on virtual machines?  
USB devices are not supported on a virtual machine. Production servers, including servers running Hyper\-V, are usually limited in support for USB devices. However, depending on the operating system of the virtual machine, some USB devices such as a mouse, keyboard, and CD\/DVD drive that are attached to the server running Hyper\-V may be accessible.  
  
##### <a name="BKMK_11"></a>Some virtual devices are unavailable due to lack of drivers for them.  
As of this writing, the list of virtual devices that are unavailable for virtual machine use because they lack drivers includes the following:  
  
-   Legacy network adapter in Windows Server 2003 with Service Pack 2 \(x64\) and as Windows XP Professional with Service Pack 2 or Service Pack 3 \(x64\)  
  
-   SCSI controller in Windows Server 2000 with Service Pack 4 and Windows XP Professional with Service Pack 2 or Service Pack 3 \(x86\)  
  
##### <a name="BKMK_12"></a>Are dynamic disks\/differencing disks\/snapshots supported?  
We recommend using fixed disks for virtual machines for better performance. Dynamic virtual hard disks are supported, but are not recommended on virtual machines in production, because of the performance issues they can cause. Snapshots are stored using a special kind of virtual hard disk and are supported, but are not recommended in production. For more information about snapshots, see [Virtual Machine Snapshots: Frequently Asked Questions](http://go.microsoft.com/fwlink/?LinkID=147648) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=147648\).  
  
##### <a name="BKMK_13"></a>What interface is supported for the shared disk of the cluster configuration between guest operating systems using Failover Clustering in Windows Server 2008?  
Only Internet SCSI \(iSCSI\) is supported.  
  
