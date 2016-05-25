---
title: WDS: How to Perform Common Tasks
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e73be1e0-2dca-43b2-97e9-5691ea47fbf6
---
# WDS: How to Perform Common Tasks
This topic contains procedures for performing common tasks using Windows Deployment Services MMC snap\-in. and the WDSUTIL command line tool. The management tasks that you can perform with these tools fall into the following categories:  
  
|Category|Task groups|  
|------------|---------------|  
|[Server Management Tasks](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_wdssvrmgmt)|-   [General WDS server setup](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_genset)<br />-   DHCP configuration settings<br />-   Client request settings<br />-   Client boot settings<br />-   AD DS settings<br />-   Unattend file configuration|  
|[Computer Management Tasks](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_wdscmgmt)|-   Create and delete prestaged accounts in Active Directory Domain Services \(AD DS\)<br />-   View information about prestaged computers<br />-   Configure settings for prestaged computers<br />-   Reject\/approve pending computers|  
|[Image Management Tasks](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_wdsimgmt)|-   View information about images and image groups<br />-   Create images<br />-   Add, copy, export, remove, update images from the image store<br />-   Set attributes and associate unattend files for install images.<br />-   Convert RIPREP images<br />-   Add and remove image groups<br />-   Set attributes of an image group|  
|[How to use Bcdedit to Modify the BCD File](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_wdsbcdedit)|-   To view the contents of the BCD store<br />-   To configure the default selection time\-out value<br />-   To configure a localized boot manager experience<br />-   To configure the TFTP block size and window size<br />-   To configure Windows debugger options|  
  
### <a name="BKMK_wdssvrmgmt"></a>Server Management Tasks  
  
|Type|Procedure|  
|--------|-------------|  
|[General WDS server setup](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_genset)|-   [To manage a server remotely](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_remote)<br />-   [To configure Windows Deployment Services](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_configure)<br />-   [To start or stop the server](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_startstop)<br />-   [To enable the server](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_enable)<br />-   [To enable logging for the Windows Deployment Services client](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_logging)<br />-   [To choose the port number for RPCs](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_rpcport)<br />-   [To specify the network interfaces for Windows Deployment Services to listen on](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_nic)<br />-   [To configure how often the server refreshes its settings](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_refresh)<br />-   [To force the server to update files in the RemoteInstall folder](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_risfolder)<br />-   [To configure the network profile for the server](../Topic/WDS--How-to-Perform-Common-Tasks.md#BKMK_netpro)|  
|DHCP configuration settings|-   To configure Windows Deployment Services to run on the same computer as Microsoft DHCP<br />-   To configure Windows Deployment Services to run on the same computer as non\-Microsoft DHCP<br />-   To turn on the DHCP authorization requirement<br />-   To authorize the server in DHCP|  
|Client request settings|-   To configure the server to answer clients<br />-   To set a delay in the server’s answers to network requests<br />-   To configure unknown clients to perform network boots without requiring F12<br />-   To configure clients who have booted without F12 to require a key press on subsequent boots<br />-   To configure the server to determine the architecture of booting clients|  
|Client boot settings|-   To choose which boot images are displayed on x64\-based computers<br />-   To choose the default network boot program for each architecture<br />-   To choose the default network boot program that does not require F12 for each architecture<br />-   To choose the default boot image for each architecture|  
|AD DS settings|-   To specify a domain controller for Windows Deployment Services<br />-   To specify a global catalog server for Windows Deployment Services<br />-   To choose whether to search for computer accounts in the domain controller before searching the global catalog<br />-   To configure the server to prestage clients by using their MAC address instead of their GUID<br />-   To maintain a list of GUIDs that belong to multiple computers<br />-   To specify how to generate client computer names<br />-   To specify the domain and OU in which to create client computer accounts<br />-   To specify that client computers should not be joined to a domain|  
|Unattend file configuration|-   To choose a default unattend file for the Windows Deployment Services client<br />-   To specify whether an unattend file on the client computer overrides the default unattend file|  
  
#### <a name="BKMK_genset"></a>General WDS server setup  
  
##### <a name="BKMK_remote"></a>To manage a server remotely  
  
|Method|Explanation|  
|----------|---------------|  
|Managing from another Windows Deployment Services server|To do this, you must specify which server you want to manage. You can do this in either of the following ways:<br /><br />-   **Using the Windows Deployment Services MMC snap\-in**. First you must add the server to the console. To do this, right\-click the **Servers** node and then click **Add Server**. Next, type the name of the server you want to add, or select it in the list. The server will be added to the left pane in the console, and you can perform any task by selecting it just as you would select the local server.<br />-   **Using WDSUTIL**. To specify a remote server to run a WDSUTIL command, append **\/Server:<name>** to the command. For example:<br />    **WDSUTIL \/Add\-Image \/ImageFile:C:\\images\\capture.wim \/Server:MY\-WDS\-02 \/ImageType:Boot**|  
|Managing from a remote server that is running Windows Server 2008 \(but not Windows Deployment Services\)|To do this, you can install Remote Server Administration Tools, which will install WDSUTIL and the Windows Deployment Services MMC snap\-in on the server. To install Remote Server Administration Tools, open **Server Manager**, right\-click the **Features** node, click **Add Features**, and then click **Remote Server Administration Tools**. Next click  **Role Administration Tools**, and then click **Windows Deployment Services Tools**.|  
|Using PsExec|You can also manage the server by using PsExec. For example: **psexec \\\\<servername> \\wdsutil \/get\-device \/id:<GUID>**<br /><br />For information about using PsExec, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=110605](http://go.microsoft.com/fwlink/?LinkId=110605).|  
  
##### <a name="BKMK_configure"></a>To configure Windows Deployment Services  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Install Windows Deployment Services. For more information, see the [Windows Deployment Services Getting Started Guide](http://go.microsoft.com/fwlink/?LinkID=84628).<br />2.  Click **Start**, click **Administrative  Tools**, and then click **Windows Deployment Services**.<br />3.  In the left pane of the Windows Deployment Services snap\-in, right\-click the server and then click **Configure Server**.<br />4.  Follow the instructions in the wizard.|1.  Install Windows Deployment Services. For more information, see the [Windows Deployment Services Getting Started Guide](http://go.microsoft.com/fwlink/?LinkID=84628).<br />2.  Click **Start**, right\-click **Command Prompt**, click **Run as administrator**, and then run `WDSUTIL /Verbose /Progress /Initialize-Server /RemInst:<path>`, where <path> is the path where you would like the RemoteInstall folder to be located.|  
  
##### <a name="BKMK_startstop"></a>To start or stop the server  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Right\-click the server, and then click **All Tasks**.<br />2.  Click **Stop Server** or **Start Server**.|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Start-Server` or `WDSUTIL /Stop-Server`.|  
  
##### <a name="BKMK_enable"></a>To enable the server  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Enable-Server`.|  
  
##### <a name="BKMK_logging"></a>To enable logging for the Windows Deployment Services client  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  To turn on client logging, run `WDSUTIL /Set-Server /WDSClientLogging /Enabled:Yes`.<br />3.  To change which events are logged, run `WDSUTIL /Set-Server /WDSClientLogging /LoggingLevel:{None&#124;Errors&#124;Warnings&#124;Info}` \(each category includes all events from the previous categories\).|  
  
##### <a name="BKMK_rpcport"></a>To choose the port number for RPCs  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /RPCPort:X`, where X is the RPC port number you want to use.<br />3.  You must restart the service before the changes will take effect. To do this, run `wdsutil /stop-server` and then run `wdsutil /start-server`.|  
  
> [!NOTE]  
> If this remote procedure call \(RPC\) port is changed from the default value, you must add a firewall exception for the new RPC port.  
  
##### <a name="BKMK_nic"></a>To specify the network interfaces for Windows Deployment Services to listen on  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|<ol><li>Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.</li><li>Do one of the following:<br /><br /><ul><li>To add an interface to the list, run `WDSUTIL /Set-Server /BindPolicy /Add /Address:<IP or MAC address> /AddressType:{IP&#124;MAC}`.</li><li>To bind to only the interfaces on the list, run `WDSUTIL /Set-Server /BindPolicy /Policy:Include`.</li><li>To bind to all interfaces other than those on the list, run `WDSUTIL /Set-Server /BindPolicy /Policy:Exclude`.</li></ul></li></ol>|  
  
##### <a name="BKMK_refresh"></a>To configure how often the server refreshes its settings  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /RefreshPeriod:<time in seconds>`.|  
  
##### <a name="BKMK_risfolder"></a>To force the server to update files in the RemoteInstall folder  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Update-ServerFiles`.|  
  
##### <a name="BKMK_netpro"></a>To configure the network profile for the server  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Right\-click the server, and then click **Properties**.<br />2.  On the **Network Settings** tab under **Network Profile**, select the option that specifies the network speed of your organization.|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server [/Server:<name>] /Transport /Profile:{10Mbps&#124;100Mbps&#124;1Gbps&#124;Custom}`.|  
  
> [!IMPORTANT]  
> You should not modify the other profiles that are provided. Instead, you should create a custom profile even if you want to change only one setting.  
  
#### <a name="BKMK_dhcp"></a>DHCP  
  
##### To configure Windows Deployment Services to run on the same computer as Microsoft DHCP  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Right\-click the server, and then click **Properties**.<br />2.  On the **DHCP** tab, select **Do not listen on port 67** and **Configure DHCP Option 60 to PXEClient** \(for Windows Server 2008 R2, this option is labeled “Configure DHCP option 60 to indicate that this server is also a PXE server”\).|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /UseDHCPPorts:No /DHCPOption60:Yes`.|  
  
##### To configure Windows Deployment Services to run on the same computer as non\-Microsoft DHCP  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Right\-click the server, and then click **Properties**.<br />2.  On the **DHCP** tab, select **Do not listen on port 67**.<br />3.  Use your DHCP server tools to set the option 60 tag to PXEClient.|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /UseDHCPPorts:No`.<br />3.  Use your DHCP server tools to set the option 60 tag to PXEClient.|  
  
##### To turn on the DHCP authorization requirement  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /RogueDetection:Yes`.|  
  
##### To authorize the server in DHCP  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Ensure that you are a domain administrator in the root domain of the forest or an enterprise administrator.<br />2.  Right\-click the server, and then click **Properties**.<br />3.  On the **Advanced** tab, select **Authorize the Windows Deployment Server in DHCP**.|1.  Ensure that you are a domain administrator in the root domain of the forest or an enterprise administrator.<br />2.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />3.  Run `WDSUTIL /Set-Server /Authorize:Yes`.|  
  
#### <a name="BKMK_clientreq"></a>Client requests  
  
#### <a name="BKMK_clientboot"></a>Client boot settings  
  
#### <a name="BKMK_adds"></a>AD DS settings  
  
#### <a name="BKMK_unattend"></a>Unattend file configuration  
  
### <a name="BKMK_wdscmgmt"></a>Computer Management Tasks  
  
### <a name="BKMK_wdsimgmt"></a>Image Management Tasks  
  
### <a name="BKMK_wdsbcdedit"></a>How to use Bcdedit to Modify the BCD File  
