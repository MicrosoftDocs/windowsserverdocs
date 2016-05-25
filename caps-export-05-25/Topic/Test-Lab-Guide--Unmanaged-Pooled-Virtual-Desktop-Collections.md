---
title: Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8a78abd3-7ad0-44c2-a050-addcdb299390
author: lizap
---
# Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections
In Remote Desktop Services, there are two types of virtual desktop collections available: personal and pooled. You have the option to let Remote Desktop Services automatically manage virtual desktops in a virtual desktop collection, or you can manually manage them.  
  
An unmanaged pooled virtual desktop collection offers the following capability:  
  
-   User profile disk support. A user profile disk stores user profile information in a separate virtual hard disk so that user profile settings are persistent across pooled virtual desktops.  
  
This test lab walks you through the process of creating an unmanaged pooled virtual desktop collection, which completes the following tasks:  
  
-   Creates a network share used to store the user profile disks.  
  
-   Creates an unmanaged pooled virtual desktop collection by using Server Manager.  
  
### In this guide  
This guide contains instructions for setting up a test lab that is based on information in [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md). You will deploy an unmanaged pooled virtual desktop collection that uses four servers and one client computer. The resulting lab demonstrates how to successfully create an unmanaged pooled virtual desktop collection.  
  
> [!IMPORTANT]  
> The following instructions are for configuring an unmanaged pooled virtual desktop collection test lab that uses the minimum number of computers. Individual computers are needed to separate the services that are provided on the network and to clearly show the desired functionality. This configuration is not designed to reflect best practices or to reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed only to work on a separate test lab network.  
  
### Test lab overview  
In this test lab, Remote Desktop Services is deployed with:  
  
-   One computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, Dynamic Host Configuration Protocol \(DHCP\) server, and an enterprise root certification authority \(CA\).  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDVH1 that is configured as the Remote Desktop Virtualization Host \(RD Virtualization Host\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDWA1 that is configured as the Remote Desktop Web Access \(RD Web Access\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDCB1 that is configured as the Remote Desktop Connection Broker \(RD Connection Broker\) server.  
  
-   One client computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] named CLIENT1 that is used to connect to the virtual desktop collection.  
  
In addition, the unmanaged pooled virtual desktop collection test lab consists of one subnet \(10.0.0.0\/24\) that simulates an intranet named Corpnet.  
  
Computers are connected to each other by using a Hyper\-V virtual switch as shown in the following figure.  
  
![](../Image/RDS_TLG_POOL.jpg)  
  
### Hardware and software requirements  
The following are required components of the test lab:  
  
-   Two identical client virtual machines must exist. These virtual machines will become part of the unmanaged pooled virtual desktop collection.  
  
-   A network share must exist that is used to store the user profile disks. The RD Virtualization Host computer accounts must have Write access to this location.  
  
-   The product disc or files for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   A physical computer that meets the minimum hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## Steps for configuring the test lab  
There are four steps to follow when setting up an unmanaged pooled virtual desktop collection test lab based on the [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md).  
  
-   **Step 1: Complete the VDI standard deployment test lab** The unmanaged pooled virtual desktop collection test lab requires the VDI standard deployment test lab as its starting point.  
  
-   **Step 2: Configure RDCB1** RDCB1 stores the user profile disks that are created for the unmanaged pooled virtual desktop collection.  
  
-   **Step 3: Create the unmanaged pooled virtual desktop collection** The unmanaged pooled virtual desktop collection is created by running the Server Manager Create Collection Wizard on RDCB1.  
  
-   **Step 4: Test Remote Desktop Services connectivity** CLIENT1 is a [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] computer that is used to test that you can successfully connect to the virtual desktop collection.  
  
-   **Step 5: Take a snapshot of the configuration** At the completion of the lab, take a snapshot of the configuration so that you can later return to a working unmanaged pooled virtual desktop collection test lab.  
  
> [!NOTE]  
> You must be logged on as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks that are described in this guide. If you cannot complete a task while you are logged on with an account that is a member of the Administrators group, try performing the task while you are logged on with an account that is a member of the Domain Admins group.  
  
### Step 1: Complete the VDI standard deployment test lab  
This test lab guide uses the VDI standard deployment test lab as a starting place. Complete the steps in [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md) before you proceed with the remainder of the steps in this guide. If you have already completed the steps in the Test Lab Guide: Virtual Desktop Infrastructure standard Deployment, and you saved a disk image or a virtual machine snapshot of the VDI standard deployment, you can restore the VDI standard deployment in Hyper\-V Manager, and then proceed to the next step.  
  
### Step 2: Configure RDCB1  
You must create a network share on a computer in the CORP domain to store the user profile disks. In this test lab, we will create the network share on the RDCB1 computer.  
  
Use the following procedures to connect to the virtual desktop collection:  
  
-   Create the user profile disk network share  
  
-   Adjust permissions on the network share  
  
##### To create the user profile disk network share  
  
1.  Log on to the RDCB1 computer by using the CORP\\Administrator user account.  
  
2.  Open Windows Explorer.  
  
3.  Click **Computer**, and then double\-click **Local Disk \(C:\)**.  
  
4.  Click **New Folder**, type **UPD** and then press ENTER.  
  
5.  Right\-click the **UPD** folder, and then click **Properties**.  
  
6.  Click **Sharing**, and then click **Advanced Sharing**.  
  
7.  Select the **Share this folder** check box.  
  
8.  Click **Permissions**, and then grant Full Control permissions to the Everyone group.  
  
9. Click **OK** twice, and then click **Close**.  
  
##### To adjust permissions on the network share  
  
1.  Right\-click the **UPD** folder, and then click **Properties**.  
  
2.  Click **Security**, and then click **Edit**.  
  
3.  Click **Add**.  
  
4.  Click **Object Types**, select the **Computers** check box, and then click **OK**.  
  
5.  In the **Enter the object names to select** box, type **rdvh1.corp.contoso.com** and then click **OK**.  
  
    > [!IMPORTANT]  
    > Each RD Virtualization Host computer account in your deployment must have Modify permissions on the user profile disk network share.  
  
6.  Click **RDVH1**, and then select the **Allow** check box next to **Modify**.  
  
7.  Click **OK** twice.  
  
### Step 3: Create the unmanaged pooled virtual desktop collection  
Use the following procedure to create an unmanaged pooled virtual desktop collection:  
  
##### To create the unmanaged pooled virtual desktop collection  
  
1.  Log on to the RDCB1 server by using the CORP\\Administrator user account.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  In the left pane, click **Remote Desktop Services**.  
  
4.  Click **Collections**.  
  
5.  Click **Tasks**, and then click **Create Virtual Desktop Collection**.  
  
6.  On the **Before you begin** page, click **Next**.  
  
7.  On the **Name the collection** page, in the **Name** box, type **Contoso Unmanaged Pool**, and then click **Next**.  
  
8.  On the **Specify the collection Type** page, click the **Pooled virtual desktop collection** option, clear the **Automatically create and manage virtual desktops** check box, and then click **Next**.  
  
9. On the **Specify the existing virtual desktops** page, click the name of the virtual desktop, and then click **Add**.  
  
    > [!NOTE]  
    > If the virtual desktop does not show up, you should close this wizard, add the virtual machines by using Hyper\-V Manager, and then create the collection again.  
  
10. Click the name of another virtual desktop, click **Add**, and then click **Next**.  
  
11. On the **Specify user groups** page, accept the default selections, and then click **Next**.  
  
12. On the **Specify user profile disks** page, in the **Location of user profile disks** box, type **\\\\rdcb1\\upd**, and then click **Next**. Make sure that the RD Virtualization Host computer accounts have Read and Write access to this location.  
  
13. On the **Confirm selections** page, click **Create**.  
  
    > [!NOTE]  
    > This procedure will take a while to complete.  
  
### Step 4: Test Remote Desktop Services connectivity  
You can ensure that the unmanaged pooled virtual desktop collection was created successfully by connecting to the RD Web Access server on the CLIENT1 computer, and then connect to a pooled virtual desktop in the Contoso Unmanaged Pool virtual desktop collection.  
  
> [!NOTE]  
> If you plan to connect to an RD Web Access server website from a server, you must use Server Manager to turn off Internet Explorer Enhanced Security Configuration.  
  
Use the following procedure to connect to the virtual desktop collection.  
  
##### To connect to the virtual desktop collection  
  
1.  Open Internet Explorer. To open Internet Explorer, click **Start**, and then click **Internet Explorer.**  
  
2.  In the Internet Explorer address bar, type **https:\/\/rdwa1.corp.contoso.com\/RDWeb**, and then press Enter.  
  
3.  Click **Continue to this website \(not recommended\)**.  
  
4.  In the **Domain\\user name** box, type **CORP\\Administrator**.  
  
5.  In the **Password** box, type the password for the CORP\\Administrator user account, and then click **Sign in**.  
  
6.  Click **Contoso Unmanaged Pool**, and then click **Connect**.  
  
### Step 5: Take a snapshot of the configuration  
This completes the unmanaged pooled virtual desktop collection test lab guide. To save this configuration so that you can quickly return to a working unmanaged pooled virtual desktop collection configuration from which you can test other Remote Desktop Services modular test lab guides \(TLGs\), TLG extensions, or for your own experimentation and learning, do the following:  
  
1.  On all physical computers or virtual machines in the test lab, close all windows and then turn them off.  
  
2.  If your lab is based on virtual machines, save a snapshot of each virtual machine and name the snapshots. If your lab uses physical computers, create disk images to save the unmanaged pooled virtual desktop collection test lab configuration.  
  
## Additional Resources  
  
-   [What's New in Remote Desktop Services in Windows Server 2012 \[redirected\]](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server-2012.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Quick Start](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Quick-Start.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md)  
  
-   [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md)  
  
-   **You Are Here \->** Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md)  
  
-   [Test Lab Guide: Remote Desktop Services Publishing](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Publishing.md)  
  
-   [Test Lab Guide: Remote Desktop Licensing](../Topic/Test-Lab-Guide--Remote-Desktop-Licensing.md)  
  
