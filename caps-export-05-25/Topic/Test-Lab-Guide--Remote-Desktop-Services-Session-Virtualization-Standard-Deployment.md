---
title: Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 87983ebb-acbd-4af3-b36b-f33bc522c64d
author: lizap
---
# Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] the [!INCLUDE[rds_sv_st_1](../Token/rds_sv_st_1_md.md)] is a scenario\-based installation within Server Manager that allows you to install, configure, and manage RD Session Host servers from a central location. With the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] scenario, you’re presented with two deployment types:  
  
-   **Standard Deployment:** Allows you to flexibly deploy the various Remote Desktop Services role services to different servers.  
  
-   **Quick Start:** Installs all the necessary Remote Desktop Services’ role services on one computer to let you install and configure in a test environment. To use the Quick Start instead of the standard deployment, see: [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)  
  
This test lab walks you through the process of creating a Session Virtualization **standard deployment** by doing the following:  
  
-   Installs the RD Connection Broker, RD Session Host, and RD Web Access role services on separate computers.  
  
-   Creates a session collection.  
  
-   Publishes a session\-based desktop for each RD Session Host server in the collection.  
  
-   Publishes applications as RemoteApp programs.  
  
A [!INCLUDE[rds_sv_st_1](../Token/rds_sv_st_1_md.md)] allows you to install the appropriate role services on separate computers. Unlike the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)], a standard deployment provides more precise control of session\-based desktops and session virtualization collections by not creating them automatically.  
  
### In this guide  
This topic contains instructions for setting up a test lab based on the [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId=236358) and deploying Session Virtualization using three server computers and one client computer. The resulting [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab demonstrates how to successfully install and configure a [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)].  
  
> [!IMPORTANT]  
> The following instructions describe how to configure a [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab using the minimum number of computers. Individual computers are needed to separate the services provided on the network and to clearly show the desired functionality. This configuration is neither designed to reflect best practices, nor does it reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed only to work on a separate test lab network.  
  
### Test lab overview  
In this test lab, the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] is deployed with:  
  
-   One computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, and Dynamic Host Configuration Protocol \(DHCP\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDSH1 that is configured as the Remote Desktop Session Host \(RD Session Host\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDWA1 that is configured as the Remote Desktop Web Access \(RD Web Access\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDCB1 that is configured as the Remote Desktop Connection Broker \(RD Connection Broker\) server.  
  
-   One roaming member client computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] named CLIENT1 that is used to connect to the Session Virtualization deployment.  
  
The [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab consists of one subnet that simulate the following:  
  
-   An intranet, referred to as the Corpnet subnet \(10.0.0.0\/24\).  
  
Computers on the subnet connect using a physical hub, switch, or virtual switch. See the following figure for the configuration of the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab.  
  
![](../Image/RDS_SVSD_TLG.jpg)  
  
### Hardware and software requirements  
The following are required components of the test lab:  
  
-   The product disc or files for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   The product disc or files for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   Three physical computers that meet the minimum hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## Steps for configuring the test lab  
There are 8 steps to follow when setting up the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab based on the [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId=236358).  
  
-   **Step 1: Complete the Base Configuration Test Lab** \-\- The [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab requires the Base Configuration test lab as its starting point.  
  
-   **Step 2: Install and Configure RDSH1** – RDSH1 is a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer that is used as the RD Session Host computer.  
  
-   **Step 3: Install and Configure RDWA1** – RDWA1 is a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer that is used as the RD Web Access computer.  
  
-   **Step 4: Install and Configure RDCB1** – RDCB1 is a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer that is used as the RD Connection Broker computer.  
  
-   **Step 5: Deploy Session Virtualization Standard Deployment** – The [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] is deployed by using Server Manager.  
  
-   **Step 6: Create Session Collection** – A Session Collection is created by using Server Manager.  
  
-   **Step 7: Test Remote Desktop Services Connectivity** \-\- CLIENT1 is a [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] computer that is used to test that you can successfully connect to the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)].  
  
-   **Step 8: Snapshot the configuration** \-\- At the completion of the lab, snapshot the configuration so that you can later return to a working [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] Test Lab.  
  
> [!NOTE]  
> You must be logged on as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks described in this guide. If you cannot complete a task while you are logged on with an account that is a member of the Administrators group, try performing the task while you are logged on with an account that is a member of the Domain Admins group.  
  
### Step 1: Complete the base configuration test lab  
This test lab guide uses the base configuration test lab as a starting place. Before you proceed with the remainder of the steps in this guide, complete the steps in the [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId=236358). If you have already completed the steps in the Test Lab Guide: Base Configuration and saved a disk image or a virtual machine snapshot of the base configuration, you can restore the base configuration and proceed to the next step.  
  
### Step 2: Install and Configure RDSH1  
Installing and configuring the server used for the RD Session Host consists of the following procedures:  
  
-   Install the operating system.  
  
-   Configure TCP\/IP properties.  
  
-   Join RDSH1 to the CORP domain.  
  
The following sections explain these procedures in detail.  
  
#### <a name="bkmk_InstallOS"></a>Install the operating system on RDSH1  
First, install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
###### To install the operating system on RDSH1  
  
1.  Start the installation of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
2.  Follow the instructions to complete the installation, specifying a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect RDSH1 to a network that has Internet access and run Windows Update to install the latest updates for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
#### Configure TCP\/IP properties  
Next, configure TCP\/IP.  
  
###### To configure TCP\/IP properties  
  
1.  In Server Manager, click **Local Server** in the console tree. Click the link next to **Wired Ethernet Connection** in the Properties tile.  
  
2.  In **Network Connections**, right\-click **Wired Ethernet Connection**, and then click **Properties**. Note that the "Wired Ethernet Connection" interface name may be different on your computer.  
  
3.  Click **Internet Protocol Version 4 \(TCP\/IPv4\)**, and then click **Properties**.  
  
4.  Select **Use the following IP address**. In **IP address**, type **10.0.0.6**. In **Subnet mask**, type **255.255.255.0**.  
  
5.  Select **Use the following DNS server addresses**. In **Preferred DNS server**, type **10.0.0.1**.  
  
6.  Click **OK**, and then click **Close**. Close the **Network Connections** window.  
  
7.  From the Start screen, type **command**, and then click **Command Prompt**.  
  
8.  To check name resolution and network communication between RDSH1 and DC1, type **ping dc1.corp.contoso.com** in the command prompt window and hit **ENTER**.  
  
9. Verify that there are four replies from 10.0.0.1.  
  
10. Close the Command Prompt window.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
New-NetIPAddress -InterfaceAlias "Wired Ethernet Connection" -IPv4Address 10.0.0.6 -PrefixLength 24  
Set-DnsClientServerAddress -InterfaceAlias "Wired Ethernet Connection" -ServerAddresses 10.0.0.1  
  
```  
  
#### Join RDSH1 to the CORP domain  
  
###### To join RDSH1 to the CORP domain  
  
1.  Log on to the computer with the local Administrator user account.  
  
2.  Server Manager will start automatically. If it does not start automatically, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  Click **Local Server**.  
  
4.  Click the name of the computer next to **Computer name**, and then click **Change**.  
  
5.  In the **Computer name** box, type **RDSH1**. In the **Member of** box, click the **Domain** option, type **corp.contoso.com** and then click **OK**.  
  
6.  When you are prompted for a user name and password, provide the CORP\\Administrator credentials, and then click **OK**.  
  
7.  When you see a dialog box welcoming you to the corp.contoso.com domain, click **OK**.  
  
8.  When you are prompted that you must restart the computer, click **OK**.  
  
9. On the **System Properties** dialog box, click **Close**, and then click **Restart Now**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Note that you must supply domain credentials after entering the Add\-Computer command below.  
  
```  
Rename-Computer -NewName RDSH1  
Restart-Computer  
Add-Computer -DomainName corp.contoso.com  
Restart-Computer  
  
```  
  
### Step 3: Install and Configure RDWA1  
Installing and configuring the server  used for RD Web Access in the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab consists of the following procedures:  
  
-   Install the operating system.  
  
-   Configure TCP\/IP properties.  
  
-   Join RDWA1 to the CORP domain.  
  
The following sections explain these procedures in detail.  
  
#### Install the operating system on RDWA1  
First, install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
###### To install the operating system on RDWA1  
  
1.  Start the installation of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
2.  Follow the instructions to complete the installation, specifying a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect RDWA1 to a network that has Internet access and run Windows Update to install the latest updates for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
#### Configure TCP\/IP properties  
Next, configure TCP\/IP.  
  
###### To configure TCP\/IP properties  
  
1.  In Server Manager, click **Local Server** in the console tree. Click the link next to **Wired Ethernet Connection** in the Properties tile.  
  
2.  In **Network Connections**, right\-click **Wired Ethernet Connection**, and then click **Properties**. Note that the "Wired Ethernet Connection" interface name may be different on your computer.  
  
3.  Click **Internet Protocol Version 4 \(TCP\/IPv4\)**, and then click **Properties**.  
  
4.  Select **Use the following IP address**. In **IP address**, type **10.0.0.4**. In **Subnet mask**, type **255.255.255.0**.  
  
5.  Select **Use the following DNS server addresses**. In **Preferred DNS server**, type **10.0.0.1**.  
  
6.  Click **OK**, and then click **Close**. Close the **Network Connections** window.  
  
7.  From the Start screen, type **command**, and then click **Command Prompt**.  
  
8.  To check name resolution and network communication between RDWA1 and DC1, type **ping dc1.corp.contoso.com** in the command prompt window and hit **ENTER**.  
  
9. Verify that there are four replies from 10.0.0.1.  
  
10. Close the Command Prompt window.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
New-NetIPAddress -InterfaceAlias "Wired Ethernet Connection" -IPv4Address 10.0.0.4 -PrefixLength 24  
Set-DnsClientServerAddress -InterfaceAlias "Wired Ethernet Connection" -ServerAddresses 10.0.0.1  
  
```  
  
#### Join RDWA1 to the CORP domain  
  
###### To join RDWA1 to the CORP domain  
  
1.  Log on to the computer with the local Administrator user account.  
  
2.  Server Manager will start automatically. If it does not start automatically, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  Click **Local Server**.  
  
4.  Click the name of the computer next to **Computer name**, and then click **Change**.  
  
5.  In the **Computer name** box, type **RDWA1**. In the **Member of** box, click the **Domain** option, type **corp.contoso.com** and then click **OK**.  
  
6.  When you are prompted for a user name and password, provide the CORP\\Administrator credentials, and then click **OK**.  
  
7.  When you see a dialog box welcoming you to the corp.contoso.com domain, click **OK**.  
  
8.  When you are prompted that you must restart the computer, click **OK**.  
  
9. On the **System Properties** dialog box, click **Close**, and then click **Restart Now**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Note that you must supply domain credentials after entering the Add\-Computer command below.  
  
```  
Rename-Computer -NewName RDWA1  
Restart-Computer  
Add-Computer -DomainName corp.contoso.com  
Restart-Computer  
  
```  
  
### Step 4: Install and Configure RDCB1  
Installing and configuring the server used for the RD Connection Broker consists of the following procedures:  
  
-   Install the operating system.  
  
-   Configure TCP\/IP properties.  
  
-   Join RDCB1 to the CORP domain.  
  
The following sections explain these procedures in detail.  
  
#### Install the operating system on RDCB1  
First, install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
###### To install the operating system on RDCB1  
  
1.  Start the installation of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
2.  Follow the instructions to complete the installation, specifying a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect RDCB1 to a network that has Internet access and run Windows Update to install the latest updates for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
#### Configure TCP\/IP properties  
Next, configure TCP\/IP.  
  
###### To configure TCP\/IP properties  
  
1.  In Server Manager, click **Local Server** in the console tree. Click the link next to **Wired Ethernet Connection** in the Properties tile.  
  
2.  In **Network Connections**, right\-click **Wired Ethernet Connection**, and then click **Properties**. Note that the "Wired Ethernet Connection" interface name may be different on your computer.  
  
3.  Click **Internet Protocol Version 4 \(TCP\/IPv4\)**, and then click **Properties**.  
  
4.  Select **Use the following IP address**. In **IP address**, type **10.0.0.5**. In **Subnet mask**, type **255.255.255.0**.  
  
5.  Select **Use the following DNS server addresses**. In **Preferred DNS server**, type **10.0.0.1**.  
  
6.  Click **OK**, and then click **Close**. Close the **Network Connections** window.  
  
7.  From the Start screen, type **command**, and then click **Command Prompt**.  
  
8.  To check name resolution and network communication between RDCB1 and DC1, type **ping dc1.corp.contoso.com** in the command prompt window and hit **ENTER**.  
  
9. Verify that there are four replies from 10.0.0.1.  
  
10. Close the Command Prompt window.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
New-NetIPAddress -InterfaceAlias "Wired Ethernet Connection" -IPv4Address 10.0.0.5 -PrefixLength 24  
Set-DnsClientServerAddress -InterfaceAlias "Wired Ethernet Connection" -ServerAddresses 10.0.0.1  
  
```  
  
#### Join RDCB1 to the CORP domain  
  
###### To join RDCB1 to the CORP domain  
  
1.  Log on to the computer with the local Administrator user account.  
  
2.  Server Manager will start automatically. If it does not start automatically, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  Click **Local Server**.  
  
4.  Click the name of the computer next to **Computer name**, and then click **Change**.  
  
5.  In the **Computer name** box, type **RDCB1**. In the **Member of** box, click the **Domain** option, type **corp.contoso.com** and then click **OK**.  
  
6.  When you are prompted for a user name and password, provide the CORP\\Administrator credentials, and then click **OK**.  
  
7.  When you see a dialog box welcoming you to the corp.contoso.com domain, click **OK**.  
  
8.  When you are prompted that you must restart the computer, click **OK**.  
  
9. On the **System Properties** dialog box, click **Close**, and then click **Restart Now**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Note that you must supply domain credentials after entering the Add\-Computer command below.  
  
```  
Rename-Computer -NewName RDCB1  
Restart-Computer  
Add-Computer -DomainName corp.contoso.com  
Restart-Computer  
  
```  
  
### Step 5: Deploy Session Virtualization Standard  
Deploying the required role services for the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] consists of the following procedures:  
  
-   Add RDSH1, RDWA1, and RDCB1 to the server pool.  
  
-   Deploy [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)].  
  
The following sections explain these procedures in detail.  
  
#### Add RDSH1, RDWA1, and RDCB1 to the server pool  
  
###### To add RDSH1, RDWA1, and RDCB1 to the server pool  
  
1.  Log on to the RDCB1 server as the CORP\\User1 user account.  
  
2.  Server Manager will start automatically. If it does not start automatically, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  In the **QUICK START** section, click **Add other servers to manage**.  
  
4.  In the **Name \(CN\):** box, type **RDWA1** and then click **Find Now**.  
  
5.  Click **RDWA1** and then click the right arrow.  
  
6.  Repeat steps 4 – 5 for the RDSH1 server.  
  
7.  Click **OK**.  
  
#### Deploy the Session Virtualization Standard deployment  
The [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] is deployed by using Server Manager.  
  
###### To deploy Session Virtualization Standard  
  
1.  Log on to the RDCB1 server as the CORP\\User1 user account.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  In the **QUICK START** section, click **Add roles and features**.  
  
4.  On the **Before You Begin** page of the **Add Roles and Features Wizard**, click **Next**.  
  
5.  On the **Select Installation Type** page, click **Remote Desktop Services installation**, and then click **Next**.  
  
6.  On the **Select deployment type** page, click **Standard deployment**, and then click **Next**.  
  
7.  On the **Select deployment scenario** page, click **Session based desktop deployment**, and then click **Next**.  
  
8.  On the **Review role services** page, click **Next**.  
  
9. On the **Specify RD Connection Broker server** page, click **RDCB1.corp.contoso.com**, click the right arrow, and then click **Next**.  
  
10. On the **Specify RD Web Access server** page, click **RDWA1.corp.contoso.com**, click the right arrow, and then click **Next**.  
  
11. On the **Specify RD Session Host servers** page, click **RDSH1.corp.contoso.com**, click the right arrow, and then click **Next**.  
  
12. On the **Confirm selections** page, select the **Restart the destination server automatically if required** check box, and then click **Deploy**.  
  
13. After the installation is complete, click **Close**.  
  
### Step 6: Create Session Collection  
A Session Collection is created by using Server Manager.  
  
Use the following procedures to create a Session Collection:  
  
-   Create a Session Collection  
  
The following sections explain these procedures in detail.  
  
#### Create a session collection  
  
###### To create a session collection  
  
1.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
2.  On the left side of the window, click **Remote Desktop Services**.  
  
3.  Click **Collections**.  
  
4.  Click **Tasks**, and then click **Create Session Collection**.  
  
5.  On the **Before You Begin** page of the Create Collection wizard, click **Next**.  
  
6.  On the **Name the collection** page, type **SessionCollection** in the **Name** box, and then click **Next**.  
  
7.  On the **Specify RD Session Host servers** page, select **RDSH1**, click the right arrow, and then click **Next**.  
  
8.  On the **Specify user groups** page, accept the default selections, and then click **Next**.  
  
9. On the **Specify user profile disks** page, clear the **Enable user profile disks** check box, and then click **Next**.  
  
10. On the **Confirm selections** page, click **Create**.  
  
11. After the session collection is created, click **Close**.  
  
### Step 7: Test Remote Desktop Services Connectivity  
You can ensure [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] deployed successfully by connecting to the session collection that was created.  
  
> [!NOTE]  
> If you plan on connecting to an RD Web Access server website from a server, you must turn off Internet Explorer Enhanced Security Configuration by using Server Manager.  
  
Use the following procedures to connect to the [!INCLUDE[rds_sv_2](../Token/rds_sv_2_md.md)]:  
  
-   Connect to the session collection.  
  
The following sections explain these procedures in detail.  
  
#### Connect to the session collection  
To test that the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] deployed and the session collection was created successfully, you log on to the RD Web Access server on the RDWA1 computer and connect to a session in the SessionCollection session collection.  
  
###### To connect to the session collection  
  
1.  Log on to the CLIENT1 computer as the CORP\\User1 user account.  
  
2.  Open Internet Explorer. To open Internet Explorer, click **Start**, and then click **Internet Explorer**.  
  
3.  In the Internet Explorer address bar, type **https:\/\/rdwa1.corp.contoso.com\/RDWeb** and then press Enter.  
  
4.  Click **Continue to this website \(not recommended\)**.  
  
5.  In the **Domain\/user name** box, type **CORP\\Administrator**.  
  
6.  In the **Password** box, type the password for the CORP\\Administrator user account, and then click **Sign in**.  
  
7.  Click **SessionCollection**, and then click **Connect**.  
  
8.  Verify that the session\-based desktop appears correctly.  
  
### Step 8: Snapshot the Configuration  
This completes the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab. To save this configuration so that you can quickly return to a working VDI Quick Start configuration from which you can test other Remote Desktop Services modular test lab guides \(TLGs\), TLG extensions, or for your own experimentation and learning, do the following:  
  
1.  On all physical computers or virtual machines in the test lab, close all windows and then perform a graceful shutdown.  
  
2.  If your lab is based on virtual machines, save a snapshot of each virtual machine and name the snapshots [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)]. If your lab uses physical computers, create disk images to save the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] test lab configuration.  
  
## Additional Resources  
  
-   [What's New in Remote Desktop Services in Windows Server 2012 \[redirected\]](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server-2012.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Quick Start](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Quick-Start.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md)  
  
-   [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Unmanaged-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)  
  
-   **You Are Here \->** Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment  
  
-   [Test Lab Guide: Remote Desktop Services Publishing](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Publishing.md)  
  
-   [Test Lab Guide: Remote Desktop Licensing](../Topic/Test-Lab-Guide--Remote-Desktop-Licensing.md)  
  
