---
title: Test Lab Guide: Virtual Desktop Infrastructure Quick Start
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 70afa6c5-f424-4c49-ba2c-bd22c220c13d
author: lizap
---
# Test Lab Guide: Virtual Desktop Infrastructure Quick Start
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the [!INCLUDE[rds_vdi_1](../Token/rds_vdi_1_md.md)] is a scenario\-based installation that allows you to install, configure, and manage your virtual desktops from a central location. With the [!INCLUDE[rds_vdi_2](../Token/rds_vdi_2_md.md)] scenario, you are presented with two deployment types:  
  
**Microsoft Virtual Desktop Infrastructure \(VDI\) Quick Start** Installs all the necessary Remote Desktop Services role services on one computer to let you install and configure them in a test environment.  
  
**Microsoft Virtual Desktop Infrastructure \(VDI\) standard deployment** Allows you to flexibly deploy the Remote Desktop Services role services to servers. To use the standard deployment instead of the Quick Start, see: [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md).  
  
This test lab walks you through a **[!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)]**. The deployment process completes the following tasks:  
  
-   Installs the Remote Desktop Connection Broker \(RD Connection Broker\), Remote Desktop Virtualization Host \(RD Virtualization Host\), and Remote Desktop Web Access \(RD Web Access\) role services on a single computer.  
  
-   Creates a pooled virtual desktop collection that is based on a virtual hard disk of the virtual desktop template.  
  
-   Creates a Hyper\-V network switch named RDS Virtual and assign the pooled virtual desktop to that switch.  
  
### In this guide  
This topic contains instructions for setting up a test lab based on the [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId=236358) test lab and deploying a [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] that uses two servers and one client computer. The resulting test lab demonstrates how to successfully deploy a [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)].  
  
> [!IMPORTANT]  
> The following instructions are for configuring a [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] test lab that uses the minimum number of computers. Individual computers are needed to separate the services that are provided on the network and to clearly show the desired functionality. This configuration is not designed to reflect best practices or to reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed to work only on a separate test lab network.  
  
### Test lab overview  
In this test lab, Remote Desktop Services is deployed with:  
  
-   One computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, Dynamic Host Configuration Protocol \(DHCP\) server, and an enterprise root certification authority \(CA\).  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named APP1 that is configured as the [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] server.  
  
-   One client computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] named CLIENT1 that is used to connect to the [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)].  
  
In addition, the VDI Quick Start test lab includes:  
  
-   One subnet \(10.0.0.0\/24\) that simulates an intranet named Corpnet.  
  
-   Computers connected to each other by using a Hyper\-V virtual switch as shown in the following figure.  
  
![](../Image/VDIQuickStartTLG.jpg)  
  
### Hardware and software requirements  
The following are required components for the test lab:  
  
-   The computer on which are you installing the Quick Start must have access to join computers to the domain. For the purposes of this guide, APP1 computer object must have permissions to join computers to the CORP domain.  
  
-   The virtual desktop template \(a virtual hard disk\) must be generalized by using Sysprep and then shut down.  
  
-   The product disc or files for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   The product disc or files for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   A physical computer that meets the minimum hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!NOTE]  
> If you choose the VDI scenario\-based installation, a virtual switch named RDS Virtual is automatically created.  
  
## Steps for configuring the test lab  
There are four steps to follow when you set up a [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] test lab that is based on Test Lab Guide: Base Configuration.  
  
**Step 1: Complete the base configuration test lab** The [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] test lab requires using the base configuration test lab as its starting point.  
  
**Step 2: Configure APP1** APP1 is a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that is configured in the base configuration, and it will host the VDI Quick Start.  
  
> [!IMPORTANT]  
> You must have hardware\-assisted virtualization on APP1 to successfully complete this test lab. Since all the role services will be installed on APP1 in this Quick Start, APP1 cannot run in Hyper\-V. You can run all Remote Desktop Services roles on Hyper\-V virtual machines except for the RD Virtualization Host role service.  
  
**Step 3: Test Remote Desktop Services connectivity** CLIENT1 is a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] that is used to test that you can successfully connect to the [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] virtual desktop collection.  
  
**Step 4: Take a snapshot of the configuration** At the completion of the lab, a snapshot of the configuration will enable you to later return to a working [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] test lab.  
  
> [!NOTE]  
> You must be logged on as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks that are described in this guide. If you cannot complete a task when you are logged on with an account that is a member of the Administrators group, try performing the task when you are logged on with an account that is a member of the Domain Admins group.  
  
### Step 1: Complete the base configuration test lab  
This test lab guide uses the base configuration test lab as a starting place. Before you proceed with the remainder of the steps in this guide, complete the steps in the [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId=236358). If you have already completed the steps in Test Lab Guide: Base Configuration, and you saved a disk image or a virtual machine snapshot of the base configuration, you can restore the base configuration in Hyper\-V Manager, and then proceed to the next step.  
  
### Step 2: Configure APP1  
The APP1 configuration for the [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] test lab consists of deploying VDI Quick Start.  
  
##### To deploy the VDI Quick Start  
  
1.  Log on to the APP1 server with the CORP\\User1 user account.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  In the **QUICK START** section, click **Add roles and features**.  
  
4.  On the **Before you begin** page of the **Add Roles and Features Wizard**, click **Next**.  
  
5.  On the **Select installation type** page, click **Remote Desktop Services installation**, and then click **Next**.  
  
6.  On the **Select deployment type** page, click **Quick Start**, and then click **Next**.  
  
7.  On the **Select deployment scenario** page, click **Virtual machine\-based desktop deployment**, and then click **Next**.  
  
8.  On the **Select a server** page, accept the default selections, and then click **Next**.  
  
9. On the **Select a virtual desktop template** page, in the **Virtual hard disk location** box, click **Browse**.  
  
    Navigate to the location of the virtual desktop template, click **Open**, and then click **Next**.  
  
10. On the **Confirm selections** page, select the **Restart the destination server automatically if required** check box, and then click **Deploy**.  
  
    > [!NOTE]  
    > The computer will restart after the RD Virtualization Host role service is installed. After the restart is complete and you log on as CORP\\Administrator, VDI Quick Start will finish the installation.  
  
### Step 3: Test Remote Desktop Services connectivity  
You can ensure that VDI Quick Start deployed successfully by connecting to the virtual desktop collection that was created during installation. You log on to the RD Web Access server on the APP1 computer and connect to the QuickVMCollection virtual desktop collection.  
  
> [!NOTE]  
> If you plan to connect to an RD Web Access server website from a server, you must turn off Internet Explorer Enhanced Security Configuration by using Server Manager.  
  
##### To connect to the virtual desktop collection  
  
1.  Log on to the CLIENT1 computer with the CORP\\User1 user account.  
  
2.  Open Internet Explorer. \(To open Internet Explorer, click **Start**, and then click **Internet Explorer.**\)  
  
3.  In the Internet Explorer address bar, type **https:\/\/app1.corp.contoso.com\/RDWeb**, and then press ENTER.  
  
4.  Click **Continue to this website \(not recommended\)**.  
  
5.  In the **Domain\\user name** box, type **CORP\\Administrator**.  
  
6.  In the **Password** box, type the password for the CORP\\Administrator user account, and then click **Sign in**.  
  
7.  Click **QuickVMCollection**, and then click **Connect**.  
  
### Step 4: Take a snapshot of the configuration  
This completes the [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)]. To save this configuration so that you can quickly return to a working [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] configuration from which you can test other Remote Desktop Services modular test lab guides \(TLGs\), TLG extensions, or for your own experimentation and learning, do the following:  
  
1.  On all physical computers or virtual machines in the test lab, close all windows and then turn them off.  
  
2.  If your lab is based on virtual machines, save a snapshot of each virtual machine and name the snapshots. If your lab uses physical computers, create disk images to save the [!INCLUDE[rds_vdi_qs_2](../Token/rds_vdi_qs_2_md.md)] test lab configuration.  
  
## Additional Resources  
  
-   [What's New in Remote Desktop Services in Windows Server 2012 \[redirected\]](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server-2012.md)  
  
-   **You Are Here \->** Test Lab Guide: Virtual Desktop Infrastructure Quick Start  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md)  
  
-   [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Unmanaged-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md)  
  
-   [Test Lab Guide: Remote Desktop Services Publishing](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Publishing.md)  
  
-   [Test Lab Guide: Remote Desktop Licensing](../Topic/Test-Lab-Guide--Remote-Desktop-Licensing.md)  
  
