---
title: Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d93e108f-f4b7-408b-ba19-09c617e9c5d4
author: lizap
---
# Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start
  
## Introduction  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] the [!INCLUDE[rds_sv_st_1](../Token/rds_sv_st_1_md.md)] is a scenario\-based installation within Server Manager that allows you to install, configure, and manage RD Session Host servers from a central location. With the [!INCLUDE[rds_sv_st_2](../Token/rds_sv_st_2_md.md)] scenario, you’re presented with two deployment types:  
  
-   **Standard Deployment:** Allows you to flexibly deploy the various Remote Desktop Services role services to different servers.  
  
-   **Quick Start:** Installs all the necessary Remote Desktop Services’ role services on one computer to let you install and configure in a test environment. . To use the standard deployment instead of the Quick Start, see: [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md).  
  
Session Virtualization is a scenario\-based installation within Server Manager that allows you to install, configure, and manage RD Session Host servers from a central location.  
  
This test lab walks you through the process of creating a **Session Virtualization Quick Start** by doing the following:  
  
-   Installs the RD Session Host, RD Connection Broker, and RD Web Access role services on a single computer.  
  
-   Creates a session collection.  
  
-   Publishes a session\-based desktop for each RD Session Host server in the collection.  
  
-   Publishes applications as RemoteApp programs.  
  
### In this guide  
This topic contains instructions for setting up a test lab based on the [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId=236358) and deploying [!INCLUDE[rds_sv_qs_1](../Token/rds_sv_qs_1_md.md)] using two server computers and one client computers. The resulting [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] test lab demonstrates how to successfully deploy a [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)].  
  
> [!IMPORTANT]  
> The following instructions are for configuring a [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] test lab using the minimum number of computers. Individual computers are needed to separate the services provided on the network and to clearly show the desired functionality. This configuration is neither designed to reflect best practices nor does it reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed only to work on a separate test lab network.  
  
### Test lab overview  
In this test lab, Remote Desktop Services Session Virtualization is deployed with:  
  
-   One computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, Dynamic Host Configuration Protocol \(DHCP\) server, and an enterprise root certification authority \(CA\).  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named APP1 that will be configured as the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] server.  
  
-   One roaming member client computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] named CLIENT1 that is configured to the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)].  
  
The Remote Desktop Services Session Virtualization test lab consists of one subnet that simulates an intranet named Corpnet \(10.0.0.0\/24\).  
  
Computers on each subnet connect using a Hyper\-V virtual switch. See the following figure.  
  
![](../Image/RDS_SVQS_TLG.jpg)  
  
### Hardware and software requirements  
The following are required components of the test lab:  
  
-   The product disc or files for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   The product disc or files for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   A physical computer that meet the minimum hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## Steps for configuring the test lab  
There are 4 steps to follow when setting up [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] test lab based on the Base Configuration Test Lab Guide.  
  
> [!NOTE]  
> You must be logged on as a member of the Domain Admins group or as a member of the Administrators group on each computer to complete the tasks described in this guide. If you cannot complete a task while you are logged on with an account that is a member of the Administrators group, try performing the task while you are logged on with an account that is a member of the Domain Admins group.  
  
-   **Step 1: Complete the Base Configuration Test Lab** \- The [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] test lab requires the Base Configuration test lab as its starting point.  
  
-   **Step 2: Configure APP1.** APP1 is a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer that will host the Session Virtualization Quick Start.  
  
-   **Step 3: Test Remote Desktop Services Connectivity.** CLIENT1 is a [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] computer that is used to test that you can successfully connect to the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] session collection.  
  
-   **Step 4: Snapshot the configuration.** At the completion of the lab, snapshot the configuration so that you can later return to a working [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] Test Lab.  
  
### Step 1: Complete the Base Configuration Test Lab  
This Test Lab Guide uses the Base Configuration network as a starting place. Please complete the steps in [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId=236358) before proceeding with the remainder of the steps in this guide. If you have already completed the steps in the Base Configuration Test Lab Guide and saved a disk image or a virtual machine snapshot of the Base Configuration, then you can restore the Base Configuration and proceed to the next step.  
  
### Step 2: Configure APP1  
APP1 configuration for the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] test lab consists of the following procedures:  
  
-   Deploy Session Virtualization Quick Start  
  
The following sections explain these procedures in detail.  
  
#### Deploy the Session Virtualization Quick Start  
The Session Virtualization Quick Start is deployed by using Server Manager.  
  
###### To deploy the Session Virtualization Quick Start  
  
1.  Log on to the APP1 server as the CORP\\User1 user account.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  In the **QUICK START** section, click **Add roles and features**.  
  
4.  On the **Before You Begin** page of the Add Roles and Features Wizard, click **Next**.  
  
5.  On the **Select Installation Type** page, click **Remote Desktop Services installation**, and then click **Next**.  
  
6.  On the **Select deployment type** page, click **Quick Start**, and then click **Next**.  
  
7.  On the **Select deployment scenario** page, click **Session\-based desktop deployment**, and then click **Next**.  
  
8.  On the **Server Selection** page, accept the default selections, and then click **Next**.  
  
9. On the **Confirm selections** page, select the **Restart the destination server automatically if required** check box, and then click **Deploy**.  
  
10. Click **Close**.  
  
    > [!NOTE]  
    > The computer will restart after the RD Session Host role service is installed. After the restart is complete and you log on as CORP\\User1, the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] will finish the installation.  
  
### Step 3: Test Remote Desktop Service Connectivity  
Verify that the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] deployed successfully by connecting to the session collection that was created during installation.  
  
> [!NOTE]  
> If you plan on connecting to an RD Web Access server website from a server, you must turn off Internet Explorer Enhanced Security Configuration by using Server Manager.  
  
Use the following procedures to connect to the Session Collection:  
  
-   Connect to the virtual desktop collection.  
  
The following sections explain these procedures in detail.  
  
#### Connect to the Session Collection  
To test that the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] deployed successfully, you log on to the RD Web Access server on the APP1 computer and connect to the session collection.  
  
###### To connect to the session collection  
  
1.  Log on to the CLIENT1 computer as the CORP\\User1 user account.  
  
2.  Open Internet Explorer. Click **Start**, point to **All Programs**, and then click **Internet Explorer**.  
  
3.  In the Internet Explorer address bar, type **https:\/\/app1.corp.contoso.com\/RDWeb** and then press **Enter**.  
  
4.  Click **Continue to this website \(not recommended\).**  
  
5.  In the **Domain\/user name** box, type **CORP\\Administrator**.  
  
6.  In the **Password** box, type the password for the CORP\\Administrator user account, and then click **Sign in**.  
  
7.  Click **No**, and then click **Allow**.  
  
### Step 4: Snapshot the Configuration  
This completes the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] test lab. To save this configuration so that you can quickly return to a working [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] configuration from which you can test other modular test lab guides \(TLGs\), TLG extensions, or for your own experimentation and learning, do the following:  
  
1.  On all physical computers or virtual machines in the test lab, close all windows and then perform a graceful shutdown.  
  
2.  If your lab is based on virtual machines, save a snapshot of each virtual machine and name the snapshots [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)]. If your lab uses physical computers, create disk images to save the [!INCLUDE[rds_sv_qs_2](../Token/rds_sv_qs_2_md.md)] test lab configuration.  
  
## Additional Resources  
  
-   [What's New in Remote Desktop Services in Windows Server 2012 \[redirected\]](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server-2012.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Quick Start](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Quick-Start.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md)  
  
-   [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Unmanaged-Pooled-Virtual-Desktop-Collections.md)  
  
-   **You Are Here \->** Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md)  
  
-   [Test Lab Guide: Remote Desktop Services Publishing](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Publishing.md)  
  
-   [Test Lab Guide: Remote Desktop Licensing](../Topic/Test-Lab-Guide--Remote-Desktop-Licensing.md)  
  
