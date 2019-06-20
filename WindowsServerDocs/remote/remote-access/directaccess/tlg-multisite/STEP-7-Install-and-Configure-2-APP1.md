---
title: STEP 7 Install and Configure 2-APP1
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1cc0abc6-be4d-4cbe-bd0c-cc448bf294f6
ms.author: pashort
author: shortpatti
---
# STEP 7 Install and Configure 2-APP1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

2-APP1 provides web and file sharing services. 2-APP1 configuration consists of the following:  
  
- Install the operating system on 2-APP1  
  
- Configure TCP/IP properties  
  
- Join 2-APP1 to the CORP2 domain  
  
- Install the Web Server (IIS) role on 2-APP1  
  
- Create a shared folder on 2-APP1 
  
## <a name="bkmk_InstallOS"></a>Install the operating system on 2-APP1  
First, install  Windows Server 2016, Windows Server 2012 R2 or Windows Server 2012.  
  
#### To install the operating system on 2-APP1  
  
1.  Start the installation of  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012  (full installation).  
  
2.  Follow the instructions to complete the installation, specifying a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect 2-APP1 to a network that has Internet access and run Windows Update to install the latest updates for  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012 , and then disconnect from the Internet.  
  
4.  Connect 2-APP1 to the 2-Corpnet subnet.  
  
## <a name="bkmk_TCP"></a>Configure TCP/IP properties  
Configure TCP/IP properties on 2-APP1.  
  
#### To configure TCP/IP properties  
  
1.  In the Server Manager console, click **Local Server**, and then in the **Properties** area, next to **Wired Ethernet Connection**, click the link.  
  
2.  In the **Network Connections** window, right-click **Wired Ethernet Connection**, and then click **Properties**.  
  
3.  Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
4.  Click **Use the following IP address**. In **IP address**, type **10.2.0.3**. In **Subnet mask**, type **255.255.255.0**. In **Default gateway**, type **10.2.0.254**.  
  
5.  Click **Use the following DNS server addresses**. In **Preferred DNS server**, type **10.2.0.1**.  
  
6.  Click **Advanced**, and then click the **DNS** tab. In **DNS suffix for this connection**, type **corp2.corp.contoso.com**, and click **OK** twice.  
  
7.  Click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
8.  Click **Use the following IPv6 address**. In **IPv6 address**, type **2001:db8:2::3**. In **Subnet prefix length**, type **64**. In **Default gateway**, type **2001:db8:2::fe**. Click **Use the following DNS server addresses**, and in **Preferred DNS server**, type **2001:db8:2::1**.  
  
9. Click **Advanced**, and then click the **DNS** tab.  
  
10. In **DNS suffix for this connection**, type **corp2.corp.contoso.com**, and then click **OK** twice.  
  
11. On the **Wired Ethernet Connection Properties** dialog box click **Close**.  
  
12. Close the **Network Connections** window.  
  
## <a name="bkmk_JoinDomain"></a>Join 2-APP1 to the CORP2 domain  
Join 2-APP1 to the corp2.corp.contoso.com domain.  
  
#### To join 2-APP1 to the CORP2 domain  
  
1.  In the Server Manager console, in **Local Server**, in the **Properties** area, next to **Computer name**, click the link.  
  
2.  On the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
3.  In **Computer name**, type **2-APP1**. In **Member of**, click **Domain**, type **corp2.corp.contoso.com**, and then click **OK**.  
  
4.  When you are prompted for a user name and password, type **Administrator** and its password, and then click **OK**.  
  
5.  When you see a dialog box welcoming you to the corp2.corp.contoso.com domain, click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  On the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
9. After the computer restarts, click **Switch User**, and then click **Other User** and log on to the CORP2 domain with the Administrator account.  
  
## <a name="bkmk_IIS"></a>Install the Web Server (IIS) role on 2-APP1  
Install the Web Server (IIS) role to make 2-APP1 a web server.  
  
#### To install the Web Server (IIS) role  
  
1.  In the Server Manager console, on the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen  
  
3.  On the **Select server roles** page, select **Web Server (IIS)**, and then click **Next** four times.  
  
4.  On the **Confirm installation selections** page, click **Install**.  
  
5.  Verify that the installation was successful, and then click **Close**.  
  
## <a name="bkmk_Share"></a>Create a shared folder on 2-APP1  
Create a shared folder and a text file within the folder on 2-APP1.  
  
#### To create a shared folder  
  
1.  On the **Start** screen, type**explorer.exe**, and then press ENTER.  
  
2.  Click **Computer**, then double-click **Local Disk (C:)**.  
  
3.  Click **New Folder**, type **Files**, and then press ENTER. Leave the **Local Disk** window open.  
  
4.  On the **Start** screen, type**notepad.exe**, right-click **Notepad**, click **Advanced**, and then click **Run as administrator**.  
  
5.  In the **Untitled - Notepad** window, type **This is a shared file on 2-APP1**.  
  
6.  Click **File**, click **Save**, click **Computer**, double-click **Local Disk (C:)**, and then double-click the **Files** folder.  
  
7.  In **File name**, type **example.txt**, and then click **Save**. Close Notepad.  
  
8.  In the **Local Disk** window, right-click the **Files** folder, point to **Share with**, and then click **Specific people**.  
  
9. On the **File Sharing** dialog box, in the drop-down list, click **Everyone**, and then click **Add**. In **Permission Level** for **Everyone**, click **Read/Write**.  
  
10. Click **Share**, and then click **Done**.  
  
11. Close the **Local Disk** window.  
  


