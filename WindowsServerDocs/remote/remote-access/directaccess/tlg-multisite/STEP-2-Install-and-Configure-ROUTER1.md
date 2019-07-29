---
title: STEP 2 Install and Configure ROUTER1
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc20b1a0-540d-4531-a176-50b87c071600
ms.author: pashort
author: shortpatti
---
# STEP 2 Install and Configure ROUTER1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

In this multisite test lab guide, the router computer provides an IPv4 and IPv6 bridge between the Corpnet and 2-Corpnet subnets, and acts as a router for IP-HTTPS and Teredo traffic.  
  
- Install the operating system on ROUTER1 
  
- Configure TCP/IP properties and rename the computer  
  
- Turn off the firewall
  
- Configure routing and forwarding
  
## Install the operating system on ROUTER1  
First, install  Windows Server 2016, Windows Server 2012 R2 or Windows Server 2012.  
  
### To install the operating system on ROUTER1  
  
1.  Start the installation of  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012  (full installation).  
  
2.  Follow the instructions to complete the installation, specifying a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect ROUTER1 to a network that has Internet access and run Windows Update to install the latest updates for  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012 , and then disconnect from the Internet.  
  
4.  Connect ROUTER1 to the Corpnet and 2-Corpnet subnets.  
  
## Configure TCP/IP properties and rename the computer  
Configure TCP/IP settings on the router and rename the computer to ROUTER1.  
  
### To configure TCP/IP properties and rename the computer  
  
1.  In the Server Manager console, click **Local Server**, and then in the **Properties** area, next to **Wired Ethernet Connection**, click the link.  
  
2.  In the **Network Connections** window, right-click the network adapter that is connected to Corpnet, click **Rename**, type **Corpnet**, and press ENTER.  
  
3.  Right-click **Corpnet**, and then click **Properties**.  
  
4.  Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
5.  Click **Use the following IP address**. In **IP address**, type **10.0.0.254**. In **Subnet mask**, type **255.255.255.0**, and then click **OK**.  
  
6.  Click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
7.  Click **Use the following IPv6 address**. In **IPv6 address**, type **2001:db8:1::fe**. In **Subnet prefix length**, type **64**, and then click **OK**.  
  
8.  On the **Corpnet Properties** dialog box click **Close**.  
  
9. In the **Network Connections** window, right-click the network adapter that is connected to 2-Corpnet, click **Rename**, type **2-Corpnet**, and press ENTER.  
  
10. Right-click **2-Corpnet**, and then click **Properties**.  
  
11. Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
12. Click **Use the following IP address**. In **IP address**, type **10.2.0.254**. In **Subnet mask**, type **255.255.255.0**, and then click **OK**.  
  
13. Click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
14. Click **Use the following IPv6 address**. In **IPv6 address**, type **2001:db8:2::fe**. In **Subnet prefix length**, type **64**, and then click **OK**.  
  
15. On the **2-Corpnet Properties** dialog box click **Close**.  
  
16. Close the **Network Connections** window.  
  
17. In the Server Manager console, in **Local Server**, in the **Properties** area, next to **Computer name**, click the link.  
  
18. On the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
19. On the **Computer Name/Domain Changes** dialog box, in **Computer name**, type **ROUTER1**, and then click **OK**.  
  
20. When you are prompted that you must restart the computer, click **OK**.  
  
21. On the **System Properties** dialog box, click **Close**.  
  
22. When you are prompted to restart the computer, click **Restart Now**.  
  
23. After the computer has restarted, log on with the local Administrator account.  
  
## Turn off the firewall  
This computer is configured only to provide routing between the Corpnet and 2-Corpnet subnets; therefore, the firewall must be turned off.  
  
### To turn off the firewall  
  
1.  On the **Start** screen, type**wf.msc**, and then press ENTER.  
  
2.  In Windows Firewall with Advanced Security, in the **Actions** pane, click **Properties**.  
  
3.  On the **Windows Firewall with Advanced Security** dialog box, on the **Domain Profile** tab, in **Firewall state**, click **Off**.  
  
4.  On the **Windows Firewall with Advanced Security** dialog box, on the **Private Profile** tab, in **Firewall state**, click **Off**.  
  
5.  On the **Windows Firewall with Advanced Security** dialog box, on the **Public Profile** tab, in **Firewall state**, click **Off**, and then click **OK**.  
  
6.  Close Windows Firewall with Advanced Security.  
  
## Configure routing and forwarding  
To provide routing and forwarding services between the Corpnet and 2-Corpnet subnets, you must enable forwarding on the network interfaces and configure static routes between the subnets.  
  
### To configure static routes  
  
1.  On the **Start** screen, type**cmd.exe**, and then press ENTER.  
  
2.  Enable forwarding on both the IPv4 and IPv6 interfaces of both network adapters using the following commands. After entering each command, press ENTER.  
  
    ```  
    netsh interface IPv4 set interface Corpnet forwarding=enabled  
    netsh interface IPv4 set interface 2-Corpnet forwarding=enabled  
    netsh interface IPv6 set interface Corpnet forwarding=enabled  
    netsh interface IPv6 set interface 2-Corpnet forwarding=enabled  
    ```  
  
3.  Enable IP-HTTPS routing between the Corpnet and 2-Corpnet subnets.  
  
    ```  
    netsh interface IPv6 add route 2001:db8:1:1000::/59 Corpnet 2001:db8:1::2  
    netsh interface IPv6 add route 2001:db8:2:2000::/59 2-Corpnet 2001:db8:2::20  
    ```  
  
4.  Enable Teredo routing between the Corpnet and 2-Corpnet subnets.  
  
    ```  
    netsh interface IPv6 add route 2001:0:836b:2::/64 Corpnet 2001:db8:1::2  
    netsh interface IPv6 add route 2001:0:836b:14::/64 2-Corpnet 2001:db8:2::20  
    ```  
  
5.  Close the Command Prompt window.
