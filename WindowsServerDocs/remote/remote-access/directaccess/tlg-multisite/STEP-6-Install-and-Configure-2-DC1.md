---
title: STEP 6 Install and Configure 2-DC1
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3d66901a-c40b-474c-9948-f989f399cfea
ms.author: pashort
author: shortpatti
---
# STEP 6 Install and Configure 2-DC1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

2-DC1 provides the following services:  
  
-   A domain controller for the corp2.corp.contoso.com Active Directory Domain Services (AD DS) domain.  
  
-   A DNS server for the corp2.corp.contoso.com DNS domain.  
  
2-DC1 configuration consists of the following:  
  
- Install the operating system on 2-DC1
  
- Configure TCP/IP properties

- Configure 2-DC1 as a domain controller and DNS server

- Provide Group Policy permissions to CORP\User1
  
- Allow CORP2 computers to obtain computer certificates
  
- Force replication between DC1 and 2-DC1
  
## Install the operating system on 2-DC1  
First, install  Windows Server 2016, Windows Server 2012 R2 or Windows Server 2012.  
  
### To install the operating system on 2-DC1  
  
1.  Start the installation of  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012 .  
  
2.  Follow the instructions to complete the installation, specifying  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012  (full installation) and a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect 2-DC1 to a network that has Internet access and run Windows Update to install the latest updates for  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012 , and then disconnect from the Internet.  
  
4.  Connect 2-DC1 to the 2-Corpnet subnet.  
  
## Configure TCP/IP properties  
Configure the TCP/IP protocol with static IP addresses.  
  
### To configure TCP/IP on 2-DC1  
  
1.  In the Server Manager console, click **Local Server**, and then in the **Properties** area, next to **Wired Ethernet Connection**, click the link.  
  
2.  In **Network Connections**, right-click **Wired Ethernet Connection**, and then click **Properties**.  
  
3.  Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
4.  Click **Use the following IP address**. In **IP address**, type **10.2.0.1**. In **Subnet mask**, type **255.255.255.0**. In **Default gateway**, type **10.2.0.254**. Click **Use the following DNS server addresses**, in **Preferred DNS server**, type **10.2.0.1**, and in **Alternate DNS server**, type **10.0.0.1**.  
  
5.  Click **Advanced**, and then click the **DNS** tab.  
  
6.  In **DNS suffix for this connection**, type **corp2.corp.contoso.com**, and then click **OK** twice.  
  
7.  Click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
8.  Click **Use the following IPv6 address**. In **IPv6 address**, type **2001:db8:2::1**. In **Subnet prefix length**, type **64**. In **Default gateway**, type **2001:db8:2::fe**. Click **Use the following DNS server addresses**, in **Preferred DNS server**, type **2001:db8:2::1**, and in **Alternate DNS server**, type **2001:db8:1::1**.  
  
9. Click **Advanced**, and then click the **DNS** tab.  
  
10. In **DNS suffix for this connection**, type **corp2.corp.contoso.com**, and then click **OK** twice.  
  
11. On the **Wired Ethernet Connection Properties** dialog box, click **Close**.  
  
12. Close the **Network Connections** window.  
  
13. In the Server Manager console, in **Local Server**, in the **Properties** area, next to **Computer name**, click the link.  
  
14. On the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
15. On the **Computer Name/Domain Changes** dialog box, in **Computer name**, type **2-DC1**, and then click **OK**.  
  
16. When you are prompted that you must restart the computer, click **OK**.  
  
17. On the **System Properties** dialog box, click **Close**.  
  
18. When you are prompted to restart the computer, click **Restart Now**.  
  
19. After restarting, login using the local administrator account.  
  
## Configure 2-DC1 as a domain controller and DNS server  
Configure 2-DC1 as a domain controller for the corp2.corp.contoso.com domain and as a DNS server for the corp2.corp.contoso.com DNS domain.  
  
### To configure 2-DC1 as a domain controller and DNS server  
  
1.  In the Server Manager console, on the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen  
  
3.  On the **Select server roles** page, select **Active Directory Domain Services**. Click **Add Features** when prompted, and then click **Next** three times.  
  
4.  On the **Confirm installation selections** page, click **Install**.  
  
5.  When the installation completes successfully, click **Promote this server to a domain controller**.  
  
6.  In the Active Directory Domain Services Configuration Wizard, on the **Deployment Configuration** page, click **Add a new domain to an existing forest**.  
  
7.  In **Parent domain name**, type **corp.contoso.com**, in **New domain name**, type **corp2**.  
  
8.  Under **Supply the credentials to perform this operation**, click **Change**. On the **Windows Security** dialog box, in **User name**, type **corp.contoso.com\Administrator**, and in **Password**, enter the corp\Administrator password, click **OK**, and then click **Next**.  
  
9. On the **Domain Controller Options** page, make sure that the **Site name** is **Second-Site**. Under **Type the Directory Services Restore Mode (DSRM) password**, in **Password** and **Confirm password**, type a strong password twice, and then click **Next** five times.  
  
10. On the **Prerequisites Check** page, after the prerequisites are validated, click **Install**.  
  
11. Wait until the wizard completes the configuration of Active Directory and DNS services, and then click **Close**.  
  
12. After the computer restarts, log in to the CORP2 domain using the Administrator account.  
  
## Provide Group Policy permissions to CORP\User1  
Use this procedure to provide the CORP\User1 user with full permissions to create and change corp2 Group Policy Objects.  
  
### To provide Group Policy permissions  
  
1.  On the **Start** screen, type**gpmc.msc**, and then press ENTER.  
  
2.  In the Group Policy Management console, open **Forest: corp.contoso.com/Domains/corp2.corp.contoso.com**.  
  
3.  In the details pane, click the **Delegation** tab. In the **Permission** drop-down list, click **Link GPOs**.  
  
4.  Click **Add**, and on the new **Select User, Computer, or Group** dialog box, click **Locations**.  
  
5.  On the **Locations** dialog box, in the **Location** tree, click **corp.contoso.com**, and click **OK**.  
  
6.  In **Enter the object name to select** type **User1**, click **OK**, and on the **Add Group or User** dialog box, click **OK**.  
  
7.  In the Group Policy Management console, in the tree, click **Group Policy Objects**, and in the details pane click the **Delegation** tab.  
  
8.  Click **Add**, and on the new **Select User, Computer, or Group** dialog box, click **Locations**.  
  
9. On the **Locations** dialog box, in the **Location** tree, click **corp.contoso.com**, and click **OK**.  
  
10. In **Enter the object name to select** type **User1**, click **OK**.  
  
11. In the Group Policy Management console, in the tree, click **WMI Filters**, and in the details pane click the **Delegation** tab.  
  
12. Click **Add**, and on the new **Select User, Computer, or Group** dialog box, click **Locations**.  
  
13. On the **Locations** dialog box, in the **Location** tree, click **corp.contoso.com**, and click **OK**.  
  
14. In **Enter the object name to select** type **User1**, click **OK**. On the **Add Group or User** dialog box, make sure that **Permissions** are set to **Full control**, and then click **OK**.  
  
15. Close the Group Policy Management console.  
  
## Allow CORP2 computers to obtain computer certificates 

Computers in the CORP2 domain must obtain computer certificates from the certification authority on APP1. Perform this procedure on APP1.  
  
### To allow CORP2 computers to automatically obtain computer certificates  
  
1.  On APP1, click **Start**, type **certtmpl.msc**, and then press ENTER.  
  
2.  In the **Certificates Template Console**, in the middle pane, double-click **Client-Server Authentication**.  
  
3.  On the **Client-Server Authentication Properties** dialog box, click the **Security** tab.  
  
4.  Click **Add**, and on the **Select Users, Computers, Service Accounts, or Groups** dialog box, click **Locations**.  
  
5.  On the **Locations** dialog box, in **Location**, expand **corp.contoso.com**, click **corp2.corp.contoso.com**, and then click **OK**.  
  
6.  In **Enter the object names to select**, type **Domain Admins; Domain Computers** and then click **OK**.  
  
7.  On the **Client-Server Authentication Properties** dialog box, in **Group or user names**, click **Domain Admins (CORP2\Domain Admins)**, and in **Permissions for Domain Admins**, in the **Allow** column, select **Write** and **Enroll**.  
  
8.  In **Group or user names**, click **Domain Computers (CORP2\Domain Computers)**, and in **Permissions for Domain Computers**, in the **Allow** column, select **Enroll** and **Autoenroll**, and then click **OK**.  
  
9. Close the Certificate Templates Console.  
  
## <a name="replication"></a>Force replication between DC1 and 2-DC1  
Before you can enroll for certificates on 2-EDGE1, you must force the replication of settings from DC1 to 2-DC1. This operation should be done on DC1.  
  
### To force replication  
  
1.  On DC1, click **Start**, and then click **Active Directory Sites and Services**.  
  
2.  In the Active Directory Sites and Services console, in the tree, expand **Inter-Site Transports**, and then click **IP**.  
  
3.  In the details pane, double-click **DEFAULTIPSITELINK**.  
  
4.  On the **DEFAULTIPSITELINK Properties** dialog box, in **Cost**, type **1**, in **Replicate every**, type **15**, and then click **OK**. Wait for 15 minutes for replication to complete.  
  
5.  To force replication now in the console tree, expand **Sites\Default-First-Site-name\Servers\DC1\NTDS Settings**, in the details pane, right-click **<automatically generated>**, click **Replicate Now**, and then on the **Replicate Now** dialog box, click **OK**.  
  
6.  To ensure replication has completed successfully do the following:  
  
    1.  On the **Start** screen, type**cmd.exe**, and then press ENTER.  
  
    2.  Type the following command, and then press ENTER.  
  
        ```  
        repadmin /syncall /e /A /P /d /q  
        ```  
  
    3.  Make sure that all partitions are synchronized with no errors. If not, then rerun the command until no errors are reported before proceeding.  
  
7.  Close the Command Prompt window.  
  


