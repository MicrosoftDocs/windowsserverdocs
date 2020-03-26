---
title: STEP 3 Install and Configure EDGE2
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess in a Cluster with Windows NLB for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f04eb11e-ed5f-42a1-a77b-57a248ba2d10
ms.author: lizross
author: eross-msft
---
# STEP 3 Install and Configure EDGE2

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

EDGE2 is the second member of a Remote Access cluster. EDGE2 is installed and configured before enabling the cluster configuration.

Perform the following steps to configure EDGE2:

## <a name="installOS"></a>Install the operating system on EDGE2  
  
1.  On EDGE2, start the installation of  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012 .  
  
2.  Follow the instructions to complete the installation, specifying  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012  (full installation) and a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect EDGE2 to a network that has Internet access and run Windows Update to install the latest updates for  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012 , and then disconnect from the Internet.  
  
4.  Connect one network adapter to the Corpnet subnet or the virtual switch representing the corpnet subnet and the other to the Internet subnet or virtual switch representing the Internet subnet.  
  
## <a name="TCP"></a>Configure TCP/IP properties  
  
1.  In the Server Manager console, click **Local Server**, and then in the **Properties** area, next to **Wired Ethernet Connection**, click the link.  
  
2.  In the **Network Connections** window, right-click the network connection that is connected to the Corpnet subnet or virtual switch, and then click **Rename**.  
  
3.  Type **Corpnet**, and then press ENTER.  
  
4.  Right-click **Corpnet**, and then click **Properties**.  
  
5.  Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
6.  Click **Use the following IP address**. In **IP address**, type **10.0.0.8**. In **Subnet mask**, type **255.255.255.0**.  
  
7.  Click **Use the following DNS server addresses**. In **Preferred DNS server**, type **10.0.0.1**.  
  
8.  Click **Advanced**, and then click the **DNS** tab.  
  
9. In **DNS suffix for this connection**, type **corp.contoso.com**, click **OK** twice.  
  
10. Click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
11. Click **Use the following IPv6 address**. In **IPv6 address**, type **2001:db8:1::8**. In **Subnet prefix length**, type **64**.  
  
12. Click **Use the following DNS server addresses**. In **Preferred DNS server**, type **2001:db8:1::1**.  
  
13. Click **Advanced**, and then click the **DNS** tab.  
  
14. In **DNS suffix for this connection**, type **corp.contoso.com**, click **OK** twice, and then click **Close**.  
  
15. In the **Network Connections** window, right-click the network connection that is connected to the Internet subnet, and then click **Rename**.  
  
16. Type **Internet**, and then press ENTER.  
  
17. Right-click **Internet**, and then click **Properties**.  
  
18. Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
19. Click **Use the following IP address**. In **IP address**, enter **131.107.0.8**. In **Subnet mask**, enter **255.255.255.0**.  
  
20. Click the **DNS** tab  
  
21. In **DNS suffix for this connection**, type **isp.example.com**, and then click **OK** twice, and then click **Close**.  
  
22. Close the **Network Connections** window.  
  
23. To check network communication between EDGE2 and DC1, click **Start**, type **cmd**, and then press ENTER.  
  
24. In the Command Prompt window, type **ping dc1.corp.contoso.com** and press ENTER. Verify that there are four responses from 10.0.0.1 or the IPv6 address 2001:db8:1::1  
  
25. Close the Command Prompt window.  
  
## <a name="rename"></a>Rename EDGE2 and join it to the domain  
  
1.  In the Server Manager console, in **Local Server**, in the **Properties** area, next to **Computer name**, click the link.  
  
2.  On the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
3.  On the **Computer Name/Domain Changes** dialog box, in the **Computer name** box, type **EDGE2**. In the **Member of** area, click **Domain**, and in the text box, enter **corp.contoso.com**, and then click **OK**.  
  
4.  When you are prompted for a user name and password, type **User1** and its password, and then click **OK**.  
  
5.  When you see a dialog box welcoming you to the corp.contoso.com domain, click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  On the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
9. After restarting, login as CORP\User1.  
  
## <a name="IPHTTPSCert"></a>Install the IP-HTTPS certificate  
  
1.  On the **Start** screen, type**mmc.exe**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  On the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Finish**, and then click **OK**.  
  
4.  In the left pane of the console, navigate to **Certificates (Local Computer)\Personal\Certificates**. Right click the **Certificates** node, point to **All Tasks**, and then click **Request New Certificate**.  
  
5.  On the Certificate Enrollment wizard, click **Next** twice.  
  
6.  On the **Request Certificates** page, select the **Web Server** check box, and then click **More information is required to enroll for this certificate**.  
  
7.  On the **Certificate Properties** dialog box, on the **Subject** tab, in the **Subject name** area, in the **Type** list, click **Common Name**.  
  
8.  In **Value**, type **edge1.contoso.com**, and then click **Add**.  
  
9. In the **Alternative name** area, in the **Type** list, click **DNS**.  
  
10. In **Value**, type **edge1.contoso.com**, and then click **Add**.  
  
11. On the **General** tab, in **Friendly name**, type **IP-HTTPS Certificate**.  
  
12. Click **OK**, click **Enroll**, and then click **Finish**.  
  
13. In the details pane of the Certificates snap-in, verify that a new certificate with the name edge1.contoso.com was enrolled with Intended Purposes of Server Authentication.  
  
14. Close the console window. If you are prompted to save settings, click **No**.  
  
## <a name="InstallDA"></a>Install the Remote Access role on EDGE2  
  
1.  In the Server Manager console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select server roles** dialog, select **Remote Access**, click **Add Features**, and then click **Next**.  
  
4.  Click **Next** five times.  
  
5.  On the **Confirm installation selections** dialog, click **Install**.  
  
6.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  


