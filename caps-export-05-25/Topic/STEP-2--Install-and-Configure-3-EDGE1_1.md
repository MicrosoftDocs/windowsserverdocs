---
title: STEP 2: Install and Configure 3-EDGE1_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cf5ea3d9-69f2-4e27-be5c-dc6f31417267
author: vhorne
---
# STEP 2: Install and Configure 3-EDGE1_1
  
## STEP 2: Install and Configure 3\-EDGE1  
  
-   Install the operating system on 3\-EDGE1  
  
-   Configure TCP\/IP properties  
  
-   Install the Remote Access server role  
  
3\-EDGE1 must have two network adapters installed.  
  
First, install [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] as a standalone server.  
  
#### To install the operating system on 3\-EDGE1  
  
1.  Start the installation of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
2.  Follow the instructions to complete the installation, specifying [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Enterprise Edition \(full installation\) and a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect 3\-EDGE1 to a network that has Internet access and run Windows Update to install the latest updates for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
4.  Connect one network adapter to the cloudnet subnet and the other to the Internet subnet.  
  
Next, configure the TCP\/IP protocol with static IPv4 addresses on both network interfaces.  
  
#### To configure TCP\/IP properties  
  
1.  In **Server Manager**, click **Local Server**.  
  
2.  In the **Properties** pane, click **IPv4 address assigned by DHCP, IPv6 enabled**.  
  
3.  In **Network Connections**, right\-click the network connection that is connected to the Corpnet subnet, click **Rename**, type **Corpnet**, and then press ENTER.  
  
4.  Right\-click **Corpnet**, and then click **Properties**.  
  
5.  Click **Internet Protocol Version 4 \(TCP\/IPv4\)**, and then click **Properties**.  
  
6.  Click **Use the following IP address**. In **IP address**, type **10.6.0.2**. In **Subnet mask**, type **255.255.255.0**.  
  
7.  In the **Network Connections** window, right\-click the network connection that is connected to the Internet subnet, click **Rename**, type **Internet**, and then press ENTER.  
  
8.  Right\-click **Internet**, and then click **Properties**.  
  
9. Click **Internet Protocol Version 4 \(TCP\/IPv4\)**, and then click **Properties**.  
  
10. Click **Use the following IP address**. In **IP address**, type **131.107.0.4**. In **Subnet mask**, type **255.255.255.0**.  
  
11. Click the **DNS** tab.  
  
12. In **DNS suffix for this connection**, type **isp.example.com**, click **OK** twice, and then click **Close**.  
  
13. Close the **Network Connections** window.  
  
14. From the Start screen, type command, and then click Command Prompt.  
  
15. To check network communication between 3\-EDGE1 and EDGE1, type ping EDGE1.contoso.com in the command prompt window and hit ENTER.  
  
16. Verify that there are four responses from 131.107.0.2.  
  
17. Close the Command Prompt window.  
  
The Remote Access server role in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] combines the DirectAccess feature and the RRAS role service into a new unified server role. This new Remote Access server role allows for centralized administration, configuration, and monitoring of both DirectAccess and VPN\-based remote access services. Use the following procedure to install the Remote Access role on 3\-EDGE1.  
  
### <a name="InstallDA"></a>To install the Remote Access role on 3\-EDGE1  
  
1.  In the [!INCLUDE[sm](../Token/sm_md.md)] console, in the **Dashboard**, click **add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select server roles** dialog, select **Remote Access**, click **Add Features**, and then click **Next**.  
  
4.  Click **Next** five times.  
  
5.  On the **Role Services** screen select **Routing**, and then click **Next**  
  
6.  On the **Confirm installation selections** dialog, click **Install**.  
  
7.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
ipmo servermanager  
Install-WindowsFeature RemoteAccess -IncludeManagementTools  
add-windowsFeature -name  routing -IncludeManagementTools  
  
```  
  
