---
title: Test Lab Guide: Managed Pooled Virtual Desktop Collections
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a901c4ed-ae0f-41d6-a917-caf28e799377
author: lizap
---
# Test Lab Guide: Managed Pooled Virtual Desktop Collections
In Remote Desktop Services, there are two types of virtual desktop collections available: personal and pooled. You have the option to let Remote Desktop Services automatically manage pooled virtual desktops in a collection, or you can manually manage them. This topic addresses automatically managed pooled virtual desktop collections.  
  
A managed pooled virtual desktop collection offers the following capabilities:  
  
-   Automatically create pooled virtual desktops based on a virtual desktop template.  
  
-   Automatically install security updates and applications based on a virtual desktop template.  
  
-   Live migration with local caching.  
  
-   User profile disk support. A user profile disk stores user profile information in a separate virtual hard disk so that user profile settings are persistent across pooled virtual desktops.  
  
This test lab walks you through the process of creating a managed pooled virtual desktop collection, which completes the following tasks:  
  
-   Creates a network share that is used to store the user profile disks.  
  
-   Adds the virtual desktop template as a Hyper\-V virtual machine on the RDVH1.  
  
-   Creates a managed pooled virtual desktop collection by using Server Manager.  
  
### In this guide  
This topic contains instructions for setting up a test lab that is based on information in [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md). You will deploy a managed pooled virtual desktop collection that uses four servers and one client computer. The resulting test lab represents a successfully created managed pooled virtual desktop collection.  
  
> [!IMPORTANT]  
> The following instructions are for configuring a managed pooled virtual desktop collection test lab that uses the minimum number of computers. Individual computers are needed to separate the services that are provided on the network and to clearly show the desired functionality. This configuration is not designed to reflect best practices or to reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed to work only on a separate test lab network.  
  
### Test lab overview  
In this test lab, Remote Desktop Services is deployed with:  
  
-   One computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, Dynamic Host Configuration Protocol \(DHCP\) server, and an enterprise root certification authority \(CA\).  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDVH1 that is configured as the Remote Desktop Virtualization Host \(RD Virtualization Host\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDWA1 that is configured as the Remote Desktop Web Access \(RD Web Access\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDCB1 that is configured as the Remote Desktop Connection Broker \(RD Connection Broker\) server.  
  
-   One client computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] named CLIENT1 that is used to connect to the virtual desktop collection.  
  
In addition, the managed pooled virtual desktop collection test lab includes:  
  
One subnet \(10.0.0.0\/24\) that simulates an intranet named Corpnet.  
  
Computers connected to each other by using a Hyper\-V virtual switch as shown in the following figure.  
  
![](../Image/RDS_TLG_POOL.jpg)  
  
### Hardware and software requirements  
The following are required components of the test lab:  
  
-   A network share must exist that is used to store the user profile disks. The RD Virtualization Host computer accounts must have write access to this location.  
  
-   When creating the virtual desktop collection, you must be logged on to the computer with a user account with access to join computers to the domain. This is required so the pooled virtual desktops in the collection are added to the domain.  
  
-   The virtual desktop template must be added as a Hyper\-V virtual machine. The virtual machine must be generalized by using Sysprep and shut down.  
  
    The product disc or files for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   The product disc or files for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   A physical computer that meets the minimum hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## Steps for configuring the test lab  
There are six steps to follow when you set up a managed pooled virtual desktop collection test lab based on the [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md).  
  
**Step 1: Complete the VDI standard deployment test lab** The managed pooled virtual desktop collection test lab requires the VDI standard deployment test lab as its starting point.  
  
**Step 2: Configure RDCB1** RDCB1 stores the user profile disks that are created for the managed pooled virtual desktop collection.  
  
**Step 3: Configure RDVH1** The virtual desktop template is added as a Hyper\-V virtual machine on RDVH1.  
  
**Step 4: Create the managed pooled virtual desktop collection** The managed pooled virtual desktop collection is created by running the Create Collection Wizard in Server Manager on RDCB1.  
  
**Step 5: Test Remote Desktop Services connectivity** CLIENT1 is a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], which is used to test that you can successfully connect to the virtual desktop collection.  
  
**Step 6: Take a snapshot of the configuration** At the completion of the lab, take a snapshot of the configuration so that you can later return to a working managed pooled virtual desktop collection test lab.  
  
> [!NOTE]  
> You must be logged on as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks that are described in this guide. If you cannot complete a task when you are logged on with an account that is a member of the Administrators group, try performing the task when you are logged on with an account that is a member of the Domain Admins group.  
  
### Step 1: Complete the VDI standard deployment test lab  
This test lab guide uses the VDI standard deployment test lab as a starting place. Complete the steps in [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md) before you proceed with the remainder of the steps in this guide. If you have already completed the steps in the Test Lab Guide: Virtual Desktop Infrastructure standard deployment, and you saved a disk image or a virtual machine snapshot of the VDI standard deployment, you can restore the VDI standard deployment in Hyper\-V Manager, and then proceed to the next step.  
  
### Step 2: Configure RDCB1  
You must create a network share on a computer in the CORP domain to store the user profile disks. In this test lab, we will create the network share on the RDCB1 computer.  
  
Use the following procedures to connect to the virtual desktop collection:  
  
-   Create the user profile disk network share  
  
-   Adjust permissions on the network share  
  
##### To create the user profile disk network share  
  
1.  Log on to the RDCB1 computer by using the CORP\\Administrator user account.  
  
2.  Open Windows Explorer.  
  
3.  Click **Computer**, and then double\-click **Local Disk \(C:\)**.  
  
4.  Click **Home**, click **New Folder**, type **UPD** and then press ENTER.  
  
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
  
5.  In the **Enter the object names to select** box, type **rdvh1.corp.contoso.com**, and then click **OK**.  
  
    > [!IMPORTANT]  
    > Each RD Virtualization Host computer account in your deployment must have Modify permissions on the user profile disk network share.  
  
6.  Click **RDVH1**, and then select the **Allow** check box next to **Modify**.  
  
7.  Click **OK** two times.  
  
### Step 3: Configure RDVH1  
You must add the virtual desktop template to Hyper\-V so you can assign it to the pooled virtual desktop collection.  
  
##### To add the virtual desktop template  
  
1.  Log on to the RDVH1 computer as a CORP\\Administrator user account.  
  
2.  Click **Start**, and then click **Hyper\-V Manager**.  
  
3.  Right\-click **RDVH1**, point to **New**, and then click **Virtual Machine**.  
  
4.  On the **Before You Begin** page, click **Next**.  
  
5.  On the **Specify Name and Location** page, in the **Name** box, type **Virtual Desktop Template**, and then click **Next**.  
  
6.  On the **Assign Memory** page, in the **Startup memory** box, type **1024**, and then click **Next**.  
  
7.  On the **Configure Networking** page, in the **Connection** box, click **RDS Virtual**, and then click **Next**.  
  
8.  On the **Connect Virtual Hard Disk** page, click the **Use an existing virtual hard disk** option.  
  
9. Click **Browse**, navigate to the virtual hard disk that should be used as the virtual desktop template, and then click **Open**. Click **Next**.  
  
10. On the **Summary** page, click **Finish**.  
  
### Step 4: Create the managed pooled virtual desktop collection  
Create the managed pooled virtual desktop collection so that users can connect to desktops in the collection.  
  
##### To create the managed pooled virtual desktop collection  
  
1.  Log on to the RDCB1 server as a CORP\\Administrator user account.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  In the left pane, click **Remote Desktop Services**,   and then click **Collections**.  
  
4.  Click **Tasks**, and then click **Create Virtual Desktop Collection**.  
  
5.  On the **Before you begin** page, click **Next**.  
  
6.  On the **Name the collection** page, in the **Name** box, type **Contoso Managed Pool**, and then click **Next**.  
  
7.  On the **Specify the collection type** page, click the **Pooled virtual desktop collection** option, ensure that the **Automatically create and manage virtual desktops** check box is selected, and then click **Next**.  
  
8.  On the **Specify the virtual desktop template** page, click **Virtual Desktop Template**, and then click **Next**.  
  
9. On the **Specify the virtual desktop settings** page, click **Provide unattended settings**, and then click **Next**. In this step of the wizard, you can also choose to provide an answer file. For more information, see [Walkthrough: Build a Simple Answer File](http://technet.microsoft.com/library/cc749317(WS.10).aspx) on the Microsoft TechNet website.  
  
10. On the **Specify the unattended settings** page, enter the following information and retain the default settings for the options that are not specified, and then click **Next**.  
  
    -   In the **Local Administrator account password** and **Confirm password** boxes, type the same strong password.  
  
    -   In the **Time zone** box, click the time zone that is appropriate for your location.  
  
11. On the **Specify users and collection size** page, accept the default selections, and then click **Next**.  
  
12. On the **Specify virtual desktop allocation** page, accept the default selections, and then click **Next**.  
  
13. On the **Specify virtual desktop storage** page, accept the default selections, and then click **Next**.  
  
14. On the **Specify user profile disks** page, in the **Location user profile disks** box, type **\\\\rdcb1\\upd**, and then click **Next**. Make sure that the RD Virtualization Host computer accounts have read and write access to this location.  
  
15. On the **Confirm selections** page, click **Create**.  
  
    > [!NOTE]  
    > This process will take some time to complete.  
  
### Step 5: Test Remote Desktop Services connectivity  
You can ensure the managed pooled virtual desktop collection was created successfully by connecting to the RD Web Access server and then connecting to the virtual desktop in the Contoso Managed Pool collection.  
  
> [!NOTE]  
> If you plan to connect to an RD Web Access server website from a server, you must turn off Internet Explorer Enhanced Security Configuration by using Server Manager.  
  
##### To connect to the virtual desktop collection  
  
1.  Open Internet Explorer. \(To open Internet Explorer, click **Start**, and then click **Internet Explorer.**\)  
  
2.  In the Internet Explorer address bar, type **https:\/\/rdwa1.corp.contoso.com\/RDWeb**, and then press ENTER.  
  
3.  Click **Continue to this website \(not recommended\)**.  
  
4.  In the **Domain\\user name** box, type **CORP\\Administrator**.  
  
5.  In the **Password** box, type the password for the CORP\\Administrator user account, and then click **Sign in**.  
  
6.  Click **Contoso Managed Pool**, and then click **Connect**.  
  
### Step 6: Take a snapshot of the configuration  
This completes the managed pooled virtual desktop collection test lab guide. To save this configuration so that you can quickly return to a working managed pooled virtual desktop collection configuration from which you can test other Remote Desktop Services modular test lab guides \(TLGs\), TLG extensions, or for your own experimentation and learning, do the following:  
  
1.  On all physical computers or virtual machines in the test lab, close all windows and then turn them off.  
  
2.  If your lab is based on virtual machines, save a snapshot of each virtual machine and name the snapshots. If your lab uses physical computers, create disk images to save the managed pooled virtual desktop collection test lab configuration.  
  
## Additional Resources  
  
-   [What's New in Remote Desktop Services in Windows Server 2012 \[redirected\]](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server-2012.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Quick Start](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Quick-Start.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md)  
  
-   **You Are Here \->** Test Lab Guide: Managed Pooled Virtual Desktop Collections  
  
-   [Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Unmanaged-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md)  
  
-   [Test Lab Guide: Remote Desktop Services Publishing](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Publishing.md)  
  
-   [Test Lab Guide: Remote Desktop Licensing](../Topic/Test-Lab-Guide--Remote-Desktop-Licensing.md)  
  
