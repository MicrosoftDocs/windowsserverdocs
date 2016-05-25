---
title: Evaluation Versions and Upgrade Options for Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc2b4176-bacb-483f-b953-79f9331df74d
author: jaimeo
---
# Evaluation Versions and Upgrade Options for Windows Server 2012
This document summarizes key information about evaluation versions of [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], including where to obtain them, the limits on their use, and how to convert them to full retail versions. It also summarizes the supported upgrade paths from previously licensed retail versions of Windows Server to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## Evaluation versions of Windows Server 2012  
Fully functional time\-limited evaluation versions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are available for the following editions:  
  
-   [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]  
  
-   [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]  
  
-   [!INCLUDE[sbs_sbs8web_1](../Token/sbs_sbs8web_1_md.md)]  
  
These evaluation versions are 64\-bit only and can be installed with the Server Core option or the Server with a GUI option. For more information about these installation options, how to convert between them, and how to use the new Minimal Server Interface and Features on Demand, see [http:\/\/technet.microsoft.com\/\/library\/hh831786](http://technet.microsoft.com/library/hh831786).  
  
For all editions, you have 10 days to complete online activation, at which point the evaluation period begins and runs for 180 days. During the evaluation period, a notification on the Desktop displays the days remaining the evaluation period \(except in [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)]\). You can also run **slmgr.vbs \/dlv** from an elevated command prompt to see the time remaining.  
  
### Where to find evaluation versions  
You can get evaluation versions by the following methods:  
  
-   [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]; [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]: from the TechNet Evaluation Center \([http:\/\/technet.microsoft.com\/evalcenter\/hh670538.aspx](http://technet.microsoft.com/evalcenter/hh670538.aspx)\). These editions are also available as pre\-created VHDs for use in virtualized environments.  
  
-   [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)]: from [http:\/\/go.microsoft.com\/fwlink\/p\/?LinkId\=266340](http://go.microsoft.com/fwlink/p/?LinkId=266340)  
  
### Limits of evaluation versions  
All evaluation versions are fully functional during the evaluation period, although booting to Safe mode is not available. The [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)] and [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)] editions come with the activation key pre\-installed. After the 180\-day evaluation period elapses, the server warns you in various ways depending on the edition:  
  
[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]; [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]:  
  
-   The following warning appears on the Desktop: **Windows License is expired**  
  
-   When you log on to Windows, you are prompted with the following options:  
  
    -   Activate now  
  
    -   Ask me later  
  
-   The system shuts down every hour.  
  
-   The only updates that can be installed are security updates.  
  
-   Event ID 100 from source WLMS “The license period for this installation of Windows has expired. The operating system will shut down every hour.” appears in the Application log.  
  
[!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)]: you receive warnings on the Desktop and on the dashboard, but the server does not shut down.  
  
### Converting evaluation versions of Windows Server 2012 to full retail versions  
Most evaluation versions can be converted to full retail versions, but the method varies slightly depending on the edition. Before you attempt to convert the version, verify that your server is actually running an evaluation version. To do this, do either of the following:  
  
1.  From an elevated command prompt, run **slmgr.vbs \/dlv**; evaluation versions will include “EVAL” in the output.  
  
2.  From the **Start** screen, open **Control Panel**. Open **System and Security**, and then **System**. View Windows activation status in the Windows activation area of the System page. Click **View details in Windows activation** for more information about your Windows activation status.  
  
If you have already activated Windows, the Desktop shows the time remaining in the evaluation period.  
  
If the server is running a retail version instead of an evaluation version, see the “Upgrading previous licensed versions” section of this document for instructions to upgrade to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
For [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)]: You can convert to the full retail version by entering a retail, volume license, or OEM key in the command slmgr.vbs.  
  
If the server is running an evaluation version of [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)] or [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)], you can convert it to a retail version as follows:  
  
1.  If the server is a domain controller, you cannot convert it to a retail version. In this case, install an additional domain controller on a server that runs a retail version and remove AD DS from the domain controller that runs on the evaluation version. For more information, see [http:\/\/technet.microsoft.com\/library\/hh994618.aspx](http://technet.microsoft.com/library/hh994618.aspx).  
  
2.  Read the license terms.  
  
3.  From an elevated command prompt, determine the current edition name with the command **DISM \/online \/Get\-CurrentEdition**. Make note of the edition ID, an abbreviated form of the edition name. Then run **DISM \/online \/Set\-Edition:<edition ID> \/ProductKey:XXXXX\-XXXXX\-XXXXX\-XXXXX\-XXXXX \/AcceptEula**, providing the edition ID and a retail product key. The server will restart twice.  
  
For the evaluation version of [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)], you can also convert to the retail version of [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)] in one step using this same command and the appropriate product key.  
  
> [!TIP]  
> For more information about Dism.exe, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192466](http://go.microsoft.com/fwlink/?LinkId=192466).  
  
## Upgrading previous retail versions of Windows Server to Windows Server 2012  
The table below briefly summarizes which already licensed \(that is, not evaluation\) Windows operating systems can be upgraded to which editions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
Note the following general guidelines for supported paths:  
  
-   In\-place upgrades from 32\-bit to 64\-bit architectures are not supported. All editions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are 64\-bit only.  
  
-   In\-place upgrades from one language to another are not supported.  
  
-   In\-place upgrades from one build type \(fre to chk, for example\) are not supported.  
  
-   If the server is a domain controller, see [http:\/\/technet.microsoft.com\/library\/hh994618.aspx](http://technet.microsoft.com/library/hh994618.aspx) for important information.  
  
-   Upgrades from pre\-release versions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] \(such as the Release Candidate\) are not supported. Perform a clean installation to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   Upgrades that switch from a Server Core installation to the Server with a GUI mode of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in one step \(and vice versa\) are not supported. However, after upgrade is complete, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] allows you to switch freely between Server Core and Server with a GUI modes. For more information about these installation options, how to convert between them, and how to use the new Minimal Server Interface and Features on Demand, see [http:\/\/technet.microsoft.com\/library\/hh831786](http://technet.microsoft.com/library/hh831786).  
  
-   If you do not see your current version in the left column, upgrading to this release of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is not supported.  
  
    If you see more than one edition in the right column, upgrade to either edition from the same starting version is supported.  
  
|||  
|-|-|  
|If you are running:|You can upgrade to these editions:|  
|Windows Server 2008 Standard with SP2 or Windows Server 2008 Enterprise with SP2|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)], [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|  
|Windows Server 2008 Datacenter with SP2|[!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|  
|Windows Web Server 2008|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]|  
|[!INCLUDE[nextref_server_7std](../Token/nextref_server_7std_md.md)] with SP1 or [!INCLUDE[nextref_server_7ent](../Token/nextref_server_7ent_md.md)] with SP1|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)], [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|  
|[!INCLUDE[nextref_server_7dat](../Token/nextref_server_7dat_md.md)] with SP1|[!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|  
|[!INCLUDE[nextref_server_7web](../Token/nextref_server_7web_md.md)]|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]|  
  
### Per\-server\-role considerations for upgrading  
Even in supported upgrade paths from previous retail versions to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], certain server roles that are already installed might require additional preparation or actions for the role to continue functioning after the upgrade. The following table summarizes these considerations.  
  
|Server role|Upgrade information|  
|---------------|-----------------------|  
|Active Directory|-   **Active Directory Domain Services \(AD DS\):** Active Directory domains can be upgraded by upgrading the operating system of existing domain controllers or by replacing existing domain controllers with domain controllers that run Windows Server 2012. For more information, see Deploy Active Directory Domain Services \(AD DS\) in Your Enterprise \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=262195](http://go.microsoft.com/fwlink/?LinkId=262195)\).<br />-   **Active Directory Lightweight Directory Services \(AD LDS\):** For more information, see Upgrading from ADAM to AD LDS \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=186351](http://go.microsoft.com/fwlink/?LinkId=186351)\).|  
|Active Directory Federation Services \(AD FS\)|For more information about upgrading AD FS from Windows Server 2008 R2 to Windows Server 2012, see [http:\/\/technet.microsoft.com\/library\/jj647765.aspx](http://technet.microsoft.com/library/jj647765.aspx)|  
|Active Directory Rights Management Services \(AD RMS\)|You can perform an in\-place upgrade from either Windows Server 2008 or Windows Server 2008 R2 to Windows Server 2012. After completing upgrade of your operating system for any servers running the AD RMS server role, you will need to run the AD RMS Upgrade wizard to upgrade your AD RMS cluster and ensure consistency. Otherwise, your AD RMS cluster might not be in a consistent state. The only other consideration when upgrading that you should be aware of when upgrading from these versions of the Windows Server operating system is that if the Windows Internal Database \(WID\) was previously selected for use to support your AD RMS database needs, that configuration will block your upgrade to Windows Server 2012 and require you to take additional steps. To unblock your upgrade to Windows Server 2012 you must first uninstall the AD RMS server role and migrate the existing WID instance to a SQL Server instance. For more information, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=229299](http://go.microsoft.com/fwlink/?LinkId=229299).|  
|Fax Server|See [http:\/\/technet.microsoft.com\/library\/jj134193.aspx](http://technet.microsoft.com/library/jj134193.aspx).|  
|File and Storage Services|After you upgrade a Windows Server 2008 R2\-based server that has DFS Management installed, you must reinstall the DFS Management Tools on the server. To install the DFS Management Tools, run the following Windows PowerShell cmdlet as an administrator: `Install-WindowsFeature RSAT-DFS-Mgmt-Con`<br /><br />You can also use the Add Roles and Features Wizard in Server Manager. On the **Features** page of the wizard, expand **Remote Server Administration Tools**, expand **Role Administration Tools**, expand **File Services Tools**, and then select the **DFS Management Tools** check box.|  
|Hyper\-V|Shut down and save all virtual machines prior to starting upgrade. For additional information, see [http:\/\/technet.microsoft.com \/library\/hh831531](http://technet.microsoft.com/library/hh831531)|  
|Print and Document Services|See [http:\/\/technet.microsoft.com\/library\/jj134150](http://technet.microsoft.com/library/jj134150).|  
|Remote Access|Routing and Remote Access Service \(RRAS\) was a role service in Windows Server operating systems prior to Windows Server 2012 that enabled you to use a computer as an IPv4 or IPv6 router, as an IPv4 network address translation \(NAT\) router, or as a remote access server that hosted dial\-up or virtual private network \(VPN\) connections from remote clients. Now, that feature has been combined with DirectAccess to make up the Remote Access server role in Windows Server 2012. For information about migration from Windows Server 2008 R2 and other versions prior to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [http:\/\/technet.microsoft.com\/library\/hh831423.aspx](http://technet.microsoft.com/library/hh831423.aspx)|  
|Remote Desktop Services|Windows Server® 2008 R2 Remote Desktop Services role services cannot be migrated to Windows Server 2012, however an existing Windows Server 2008 R2 RD Session Host server deployment can be integrated into a Windows Server 2012 RDS deployment. The Windows Server 2012 RD Web Access can be configured to point to an existing Windows Server 2008 R2 RD Session Host server farm. Desktops and RemoteApp programs published on the Windows Server® 2008 R2 RD Session Host server farm can be accessed from a Windows Server 2012 RD Web Access server.The Following steps need to be completed in order to add an existing Windows Server® 2008 R2 RD Session Host server farm to a Windows Server 2012 Remote Desktop Services deployment:<br /><br />-   Populate the TS Web Access Computers Security Group.<br />-   Configure Windows Server 2008 R2 Session Host servers with the right certificate to sign RDP files.<br />-   Pointing a Windows Server 2012 RD Web Access server to a Windows Server® 2008 R2 RD Session Host server farm.|  
|Volume Activation Services|With Active Directory\-based Activation, you do not need an additional host server; your existing domain controllers can support activation clients, with the following limitations:<br /><br />-   Active Directory\-based Activation cannot be configured on read\-only domain controllers.<br />-   Active Directory\-based Activation cannot be used with non\-Microsoft directory services.<br />-   AD DS must be at the Windows Server 2012 schema level to store activation objects. Domain controllers running earlier versions of Windows Server can activate clients after their schemas have been updated using the Windows Server 2012 version of Adprep.exe. For more information, see [What's New in Active Directory Domain Services Installation and Removal](../Topic/What-s-New-in-Active-Directory-Domain-Services-Installation-and-Removal.md).|  
|Web Server \(IIS\)|No functionality has been removed or changed. Web applications that work in IIS 7.0 run normally in IIS 8.0.|  
  
### Converting existing Windows Server 2012 versions  
At any time after installing [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can run Setup to repair the installation \(sometimes called “repair in place”\) or, in certain cases, to convert to a different edition.  
  
You can run Setup to perform a “repair in place” on any edition of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]; the result will be the same edition you started with.  
  
For [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)], you can convert the system to [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)] as follows: From an elevated command prompt, determine the current edition name with the command **DISM \/online \/Get\-CurrentEdition**. Make note of the edition ID, an abbreviated form of the edition name. Then run **DISM \/online \/Set\-Edition:<edition ID> \/ProductKey:XXXXX\-XXXXX\-XXXXX\-XXXXX\-XXXXX \/AcceptEula**, providing the edition ID and a retail product key. The server will restart twice.  
  
For [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)], you can run Setup and convert it to [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)] by providing the appropriate retail license key.  
  
