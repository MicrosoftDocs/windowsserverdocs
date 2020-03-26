---
title: STEP 10 Install and Configure 2-EDGE1
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d98d6f7a-a2e6-45b1-9c63-08e2986a5c03
ms.author: lizross
author: eross-msft
---
# STEP 10 Install and Configure 2-EDGE1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

2-EDGE1 configuration consists of the following:  
  
- Install the operating system on 2-EDGE1. Install  Windows Server 2016, Windows Server 2012 R2 or Windows Server 2012 on 2-EDGE1.  
  
- Configure TCP/IP properties. Configure 2-EDGE1 with static addresses on both network interfaces.  
  
- Configure routing between subnets. To enable communication between the Corpnet and 2-Corpnet subnets, you must configure routing.  
  
- Join 2-EDGE1 to the CORP2 domain. Join 2-EDGE1 to the corp2.corp.contoso.com domain.  
  
- Obtain certificates on 2-EDGE1. Certificates are required for the IPsec connection between DirectAccess clients and the Remote Access server, and to authenticate the IP-HTTPS listener when clients connect over HTTPS.  
  
- Provide access to CORP\User1. The user CORP\User1 is the Remote Access administrator. To enable this user to make changes to 2-EDGE1 from EDGE1, you must grant access to the user.  
  
- Install the Remote Access role on 2-EDGE1. To enable a multisite deployment, you must install the Remote Access role on 2-EDGE1.  
  
2-EDGE1 must have two network adapters installed.  
  
## <a name="installOS"></a>Install the operating system on 2-EDGE1  
  
1.  Start the installation of  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012 .  
  
2.  Follow the instructions to complete the installation, specifying  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012  (full installation) and a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect 2-EDGE1 to a network that has Internet access and run Windows Update to install the latest updates for  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012 , and then disconnect from the Internet.  
  
4.  Connect one network adapter to the 2-Corpnet subnet and the other to the simulated Internet.  
  
## <a name="tcpip"></a>Configure TCP/IP properties  
  
1.  In the Server Manager console, click **Local Server**, and then in the **Properties** area, next to **Wired Ethernet Connection**, click the link.  
  
2.  In **Network Connections**, right-click the network connection that is connected to the 2-Corpnet subnet, click **Rename**, type **2-Corpnet**, and then press ENTER.  
  
3.  Right-click **2-Corpnet**, and then click **Properties**.  
  
4.  Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
5.  Click **Use the following IP address**. In **IP address**, type **10.2.0.20**, in **Subnet mask**, type **255.255.255.0**.  
  
6.  Click **Use the following DNS server addresses**. In **Preferred DNS server**, type **10.2.0.1**, and in **Alternate DNS server**, type **10.0.0.1**.  
  
7.  Click **Advanced**, and then click the **DNS** tab.  
  
8.  In **DNS suffix for this connection**, type **corp2.corp.contoso.com**, and then click **OK** twice.  
  
9. Click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
10. Click **Use the following IPv6 address**. In **IPv6 address**, type **2001:db8:2::20**, in **Subnet prefix length**, type **64**. Click **Use the following DNS server addresses**, and in **Preferred DNS server**, type **2001:db8:2::1**, in **Alternate DNS server**, type **2001:db8:1::1**.  
  
11. Click **Advanced**, and then click the **DNS** tab.  
  
12. In **DNS suffix for this connection**, type **corp2.corp.contoso.com**, and then click **OK** twice.  
  
13. On the **2-Corpnet Properties** dialog box, click **Close**.  
  
14. In the **Network Connections** window, right-click the network connection that is connected to the Internet subnet, click **Rename**, type **Internet**, and then press ENTER.  
  
15. Right-click **Internet**, and then click **Properties**.  
  
16. Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
17. Click **Use the following IP address**. In **IP address**, type **131.107.0.20**. In **Subnet mask**, type **255.255.255.0**.  
  
18. Click **Advanced**. On the **IP Settings** tab, in the **IP addresses** area, click **Add**. On the **TCP/IP Address** dialog box, in **IP address** type **131.107.0.21**, in **Subnet mask** type **255.255.255.0**, and then click **Add**.  
  
19. Click the **DNS** tab.  
  
20. In **DNS suffix for this connection**, type **isp.example.com**, click **OK** twice, and then click **Close**.  
  
21. Close the **Network Connections** window.  
  
## <a name="routing"></a>Configure routing between subnets  
  
1.  On the **Start** screen, type**cmd.exe**, and then press ENTER.  
  
2.  In the Command Prompt window, enter the following commands. After entering each command, press ENTER.  
  
    ```  
    netsh interface IPv4 add route 10.0.0.0/24 2-Corpnet 10.2.0.254  
    netsh interface IPv6 add route 2001:db8:1::/64 2-Corpnet 2001:db8:2::fe  
    ```  
  
3.  To check network communication between 2-EDGE1 and DC1, type **ping dc1.corp.contoso.com**.  
  
4.  Verify that there are four responses from either the IPv4 address, 10.0.0.1, or from the IPv6 address, 2001:db8:1::1.  
  
5.  Close the Command Prompt window.  
  
## <a name="Join"></a>Join 2-EDGE1 to the CORP2 domain  
  
1.  In the Server Manager console, in **Local Server**, in the **Properties** area, next to **Computer name**, click the link.  
  
2.  On the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
3.  On the **Computer Name/Domain Changes** dialog box, in **Computer name**, type **2-EDGE1**. In **Member of**, click **Domain**, type **corp2.corp.contoso.com**, and then click **OK**.  
  
4.  If you are prompted for a user name and password, type **Administrator** and its password, and then click **OK**.  
  
5.  When you see a dialog box welcoming you to the corp2.corp.contoso.com domain, click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  On the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
9. After the computer has restarted, click **Switch User**, and then click **Other User** and log on to the CORP2 domain with the Administrator account.  
  
## <a name="certs"></a>Obtain certificates on 2-EDGE1  
  
1.  On the **Start** screen, type**mmc.exe**, and then press ENTER.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  On the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal**.  
  
5.  Right-click **Personal**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice.  
  
7.  On the **Request Certificates** page, select the **Client-Server Authentication** and the **Web Server** check boxes, and then click **More information is required to enroll for this certificate**.  
  
8.  On the **Certificate Properties** dialog box, on the **Subject** tab, in the **Subject name** area, in **Type**, select **Common name**.  
  
9. In **Value**, type **2-edge1.contoso.com**, and then click **Add**.  
  
10. In the **Alternative name** area, in **Type**, select **DNS**.  
  
11. In **Value**, enter **2-edge1.contoso.com**, and then click **Add**.  
  
12. On the **General** tab, in **Friendly name**, type **IP-HTTPS Certificate**.  
  
13. Click **OK**, click **Enroll**, and then click **Finish**.  
  
14. In the details pane of the Certificates snap-in, verify that a new certificate with the name 2-edge1.contoso.com was enrolled with Intended Purposes of Server Authentication, and a new certificate with the name 2-edge1.corp2.corp.contoso.com was enrolled with Intended Purposes of Client Authentication and Server Authentication.  
  
15. Close the console window. If you are prompted to save settings, click **No**.  
  
## <a name="Access"></a>Provide access to CORP\User1  
  
1.  On the **Start** screen, type**compmgmt.msc**, and then press ENTER.  
  
2.  In the left pane, click **Local Users and Groups**.  
  
3.  Double-click **Groups**, and then double-click **Administrators**.  
  
4.  On the **Administrators Properties** dialog box, click **Add**, and on the **Select Users, Computers, Service Accounts, or Groups** dialog box, click **Locations**.  
  
5.  On the **Locations** dialog box, in the **Location** tree, click **corp.contoso.com**, and then click **OK**.  
  
6.  In the **Enter the object names to select** type **User1**, and then click **OK**.  
  
7.  On the **Administrators Properties** dialog box, click **OK**.  
  
8.  Close the Computer Management window.  
  
## <a name="InstallDA"></a>Install the Remote Access role on 2-EDGE1  
  
1.  In the Server Manager console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select server roles** dialog, select **Remote Access**, click **Add Features**, and then click **Next**.  
  
4.  Click **Next** five times.  
  
5.  On the **Confirm installation selections** dialog, click **Install**.  
  
6.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  


