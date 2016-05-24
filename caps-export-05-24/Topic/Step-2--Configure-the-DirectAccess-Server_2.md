---
title: Step 2: Configure the DirectAccess Server_2
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 84c8e8ff-c3e3-466e-943c-02f11c9d6a0f
---
# Step 2: Configure the DirectAccess Server_2
This topic describes how to configure the client and server settings required for a basic DirectAccess deployment. Before beginning the deployment steps, ensure that you have completed the planning steps described in [Step 2: Plan the DirectAccess Deployment_1](../Topic/Step-2--Plan-the-DirectAccess-Deployment_1.md).  
  
|Task|Description|  
|--------|---------------|  
|Install the Remote Access role|Install the Remote Access role.|  
|Configure DirectAccess Using the Getting Started Wizard|The new Getting Started Wizard presents a greatly simplified configuration experience. The wizard masks the complexity of DirectAccess, and allows for an automated setup in a few simple steps. The wizard provides a seamless experience for the administrator by configuring Kerberos proxy automatically to eliminate the need for an internal PKI deployment.|  
|Update clients with the DirectAccess configuration|To receive the DirectAccess settings, clients must update group policy while connected to the intranet.|  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_Role"></a>Install the Remote Access role  
To deploy Remote Access, you must install the Remote Access role on a server in your organization that will act as the Remote Access server.  
  
#### To install the Remote Access role  
  
1.  On the Remote Access server, in the [!INCLUDE[sm](../Token/sm_md.md)] console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select server roles** dialog, select **Remote Access**, click **Add Features**, and then click **Next**.  
  
4.  Click **Next** five times.  
  
5.  On the **Confirm installation selections** dialog, click **Install**.  
  
6.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Install-WindowsFeature RemoteAccess -IncludeManagementTools  
```  
  
## Configure DirectAccess with the Getting Started Wizard  
  
#### To configure DirectAccess using the Getting Started Wizard  
  
1.  In Server Manager click **Tools**, and then click **Remote Access Management**.  
  
2.  In the Remote Access Management console, click **Run the Getting Started Wizard**.  
  
3.  Click **Deploy DirectAccess only**.  
  
4.  Select the topology of your network configuration and type the public name to which remote access clients will connect. Click **Next**.  
  
    > [!NOTE]  
    > By default, the Getting Started Wizard deploys DirectAccess to all laptops and notebook computers in the domain by applying a WMI filter to the client settings GPO.  
  
5.  Click **Finish**.  
  
6.  Since there is no PKI used in this deployment, if certificates are not found, the wizard will automatically provision self\-signed certificates for IP\-HTTPS and the Network Location Server, and will automatically enable Kerberos proxy. The wizard will also enable NAT64 and DNS64 for protocol translation in the IPv4\-only environment. After the wizard successfully completes applying the configuration, click **Close**.  
  
7.  In the console tree of the Remote Access Management console, select **Operations Status**. Wait until the status of all monitors display as "Working". In the Tasks pane under Monitoring, click **Refresh** periodically to update the display.  
  
## Update clients with the DirectAccess configuration  
  
#### To update DirectAccess clients  
  
1.  Click the **Search** charm, and then click **Apps**. Right\-click **Windows PowerShell**, click **Advanced**, and then click **Run as administrator**.  
  
2.  In the PowerShell window, type **gpupdate** and then press **ENTER**.  
  
3.  Wait for the computer policy update to complete successfully.  
  
4.  Type **Get\-DnsClientNrptPolicy** and then press **ENTER**  
  
    The Name Resolution Policy Table \(NRPT\) entries for DirectAccess are displayed. Note that the NLS server exemption is displayed. The Getting Started wizard automatically created this DNS entry for the DirectAccess server, and provisioned an associated self\-signed certificate so that the DirectAccess server can function as the Network Location Server.  
  
5.  Type **Get\-NCSIPolicyConfiguration** and then press **ENTER**. The network connectivity status indicator settings deployed by the wizard are displayed. Note the value of DomainLocationDeterminationURL. Whenever this network location server URL is accessible, the client will determine that it is inside the corporate network, and NRPT settings will not be applied.  
  
6.  Type **Get\-DAConnectionStatus** and then press **ENTER**. Since the client can reach the network location server URL, the status will display as **ConnectedLocally**.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Verify the Deployment_4](../Topic/Step-3--Verify-the-Deployment_4.md)  
  
