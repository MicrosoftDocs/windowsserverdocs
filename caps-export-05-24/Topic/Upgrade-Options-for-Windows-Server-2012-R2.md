---
title: Upgrade Options for Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 54660ce8-d743-43c6-9806-9066a42aaa7b
author: jaimeo
---
# Upgrade Options for Windows Server 2012 R2
This topic includes information about upgrading to [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] from a variety of previous operating systems using a variety of methods.  
  
The process of moving to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] might vary greatly depending on which operating system you are starting with and the pathway you take. We use the following terms to distinguish among different actions, any of which could be involved in a new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] deployment.  
  
-   **Installation** is the basic concept of getting the new operating system on your hardware. Specifically, a **clean installation** requires deleting the previous operating system. For information about installing [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [System Requirements and Installation Information for Windows Server 2012 R2](../Topic/System-Requirements-and-Installation-Information-for-Windows-Server-2012-R2.md). For information about installing other versions of Windows Server, see [Windows Server Installation and Upgrade](http://technet.microsoft.com/windowsserver/dn527667).  
  
-   **Upgrade** means moving from your existing operating system release to a more recent release, while staying on the same hardware. For example, if your server is running Windows Server 2012, you can upgrade it to Windows Server 2012 R2. You can upgrade from an evaluation version of the operating system to a retail version, from an older retail version to a newer version, or, in some cases, from a volume\-licensed edition of the operating system to an ordinary retail edition.  
  
-   **License conversion** in some operating system releases, you can convert a particular edition of the release to another edition of the same release in a single step with a simple command and the appropriate license key. We call this “license conversion.” For example, if you are running Windows Server 2012 R2 Standard, you can convert it to Windows Server 2012 R2 Datacenter.  
  
-   **Migration** means moving from your existing operating system to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] by transferring to a different set of hardware. Migration, which might vary considerably depending on the server roles you have installed, is discussed in detail at [http:\/\/technet.microsoft.com\/windowsserver\/dn458795](http://technet.microsoft.com/windowsserver/dn458795).  
  
Depending on your scenario, you might encounter a variety of different upgrade pathways.  
  
## Upgrading previous retail versions of Windows Server to Windows Server 2012 R2  
The table below briefly summarizes which already licensed \(that is, not evaluation\) Windows operating systems can be upgraded to which editions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Note the following general guidelines for supported paths:  
  
-   In\-place upgrades from 32\-bit to 64\-bit architectures are not supported. All editions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] are 64\-bit only.  
  
-   In\-place upgrades from one language to another are not supported.  
  
-   In\-place upgrades from one build type \(fre to chk, for example\) are not supported.  
  
-   If the server is a domain controller, see [http:\/\/technet.microsoft.com\/library\/hh994618.aspx](http://technet.microsoft.com/library/hh994618.aspx) for important information.  
  
-   Upgrades from pre\-release versions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] are not supported. Perform a clean installation to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   Upgrades that switch from a Server Core installation to the Server with a GUI mode of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] in one step \(and vice versa\) are not supported. However, after upgrade is complete, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] allows you to switch freely between Server Core and Server with a GUI modes. For more information about these installation options, how to convert between them, and how to use the new Minimal Server Interface and Features on Demand, see [http:\/\/technet.microsoft.com\/library\/hh831786](http://technet.microsoft.com/library/hh831786).  
  
If you do not see your current version in the left column, upgrading to this release of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is not supported.  
  
If you see more than one edition in the right column, upgrade to either edition from the same starting version is supported.  
  
|||  
|-|-|  
|If you are running:|You can upgrade to these editions:|  
|[!INCLUDE[nextref_server_7dat](../Token/nextref_server_7dat_md.md)] with SP1|[!INCLUDE[winblue_server_datacenter_2](../Token/winblue_server_datacenter_2_md.md)]|  
|[!INCLUDE[nextref_server_7ent](../Token/nextref_server_7ent_md.md)] with SP1|[!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] or [!INCLUDE[winblue_server_datacenter_2](../Token/winblue_server_datacenter_2_md.md)]|  
|[!INCLUDE[nextref_server_7std](../Token/nextref_server_7std_md.md)] with SP1|[!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] or [!INCLUDE[winblue_server_datacenter_2](../Token/winblue_server_datacenter_2_md.md)]|  
|[!INCLUDE[nextref_server_7web](../Token/nextref_server_7web_md.md)] with SP1|[!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)]|  
|[!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|[!INCLUDE[winblue_server_datacenter_2](../Token/winblue_server_datacenter_2_md.md)]|  
|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]|[!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] or [!INCLUDE[winblue_server_datacenter_2](../Token/winblue_server_datacenter_2_md.md)]|  
|Hyper\-V Server 2012|[!INCLUDE[hv_blue_2](../Token/hv_blue_2_md.md)]|  
|[!INCLUDE[wss_standard_2](../Token/wss_standard_2_md.md)]|[!INCLUDE[wssblue_standard_2](../Token/wssblue_standard_2_md.md)]|  
|[!INCLUDE[wss_workgroup_2](../Token/wss_workgroup_2_md.md)]|[!INCLUDE[wssblue_workgroup_2](../Token/wssblue_workgroup_2_md.md)]|  
  
### Per\-server\-role considerations for upgrading  
Even in supported upgrade paths from previous retail versions to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], certain server roles that are already installed might require additional preparation or actions for the role to continue functioning after the upgrade. Consult the specific TechNet Library topics for each server role you intend to install for details of additional steps that might be required.  
  
### Converting a current evaluation version to a current retail version  
You can convert the evaluation version of Windows Server 2012 R2 Standard to either Windows Server 2012 R2 Standard \(retail\) or Datacenter \(retail\). Similarly, you can convert the evaluation version of Windows Server 2012 R2 Datacenter to the retail version.  
  
Before you attempt to convert from evaluation to retail, verify that your server is actually running an evaluation version. To do this, do either of the following:  
  
-   From an elevated command prompt, run **slmgr.vbs \/dlv**; evaluation versions will include “EVAL” in the output.  
  
-   From the **Start** screen, open **Control Panel**. Open **System and Security**, and then **System**. View Windows activation status in the Windows activation area of the System page. Click **View details in Windows activation** for more information about your Windows activation status.  
  
If you have already activated Windows, the Desktop shows the time remaining in the evaluation period.  
  
If the server is running a retail version instead of an evaluation version, see the “Upgrading previous retail versions of Windows Server to Windows Server 2012 R2” section of this topic for instructions to upgrade to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
For [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)]: You can convert to the full retail version by entering a retail, volume license, or OEM key in the command slmgr.vbs.  
  
If the server is running an evaluation version of [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)] or [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)], you can convert it to a retail version as follows:  
  
1.  If the server is a domain controller, you cannot convert it to a retail version. In this case, install an additional domain controller on a server that runs a retail version and remove AD DS from the domain controller that runs on the evaluation version. For more information, see [http:\/\/technet.microsoft.com\/library\/hh994618.aspx](http://technet.microsoft.com/library/hh994618.aspx).  
  
2.  Read the license terms.  
  
3.  From an elevated command prompt, determine the current edition name with the command **DISM \/online \/Get\-CurrentEdition**. Make note of the edition ID, an abbreviated form of the edition name. Then run **DISM \/online \/Set\-Edition:<edition ID> \/ProductKey:XXXXX\-XXXXX\-XXXXX\-XXXXX\-XXXXX \/AcceptEula**, providing the edition ID and a retail product key. The server will restart twice.  
  
For the evaluation version of [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)], you can also convert to the retail version of [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)] in one step using this same command and the appropriate product key.  
  
> [!TIP]  
> For more information about Dism.exe, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192466](http://go.microsoft.com/fwlink/?LinkId=192466).  
  
### Converting a current retail version to a different current retail version  
At any time after installing [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can run Setup to repair the installation \(sometimes called “repair in place”\) or, in certain cases, to convert to a different edition.  
  
You can run Setup to perform a “repair in place” on any edition of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]; the result will be the same edition you started with.  
  
For [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)], you can convert the system to [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)] as follows: From an elevated command prompt, determine the current edition name with the command **DISM \/online \/Get\-CurrentEdition**. Make note of the edition ID, an abbreviated form of the edition name. Then run **DISM \/online \/Set\-Edition:<edition ID> \/ProductKey:XXXXX\-XXXXX\-XXXXX\-XXXXX\-XXXXX \/AcceptEula**, providing the edition ID and a retail product key. The server will restart twice.  
  
### Converting a current volume\-licensed version to a current retail version  
At any time after installing [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can freely convert it between a volume\-licensed version, a retail version, or an OEM version. The edition remains the same during this conversion.  
  
To do this, from an elevated command prompt, run:  
  
**slmgr \/ipk <key>**  
  
Where <key> is the appropriate volume\-license, retail, or OEM product key.  
  
