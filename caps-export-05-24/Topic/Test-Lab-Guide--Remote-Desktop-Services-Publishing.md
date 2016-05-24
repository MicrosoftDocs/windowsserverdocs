---
title: Test Lab Guide: Remote Desktop Services Publishing
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 251e308e-4a1f-40b2-abb6-5300c50733bf
author: lizap
---
# Test Lab Guide: Remote Desktop Services Publishing
  
## Introduction  
In Windows Server 2008 R2, publishing and managing applications on both pooled and personal virtual desktops is a very time\-consuming and costly process. Because RemoteApp programs only partially integrate with the native Windows experience, they add to the management cost since there’s no way to organize published RemoteApp programs to users.  
  
Remote Desktop Services in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] enables you to publish and manage resources, such as RemoteApp programs, session\-based desktops, and virtual desktops, from a centralized console. Using this new publishing feature, you get an historic view of resources assigned to end users, you can change published resources for any given collection, and you can edit properties of published resources.  
  
Centralized resource publishing provides end users with an experience that can replace locally installed applications.  
  
### In this guide  
This paper contains instructions for setting up a test lab based on the [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md) and publishing and managing resources using four server computers and one client computer. The resulting centralized resource publishing test lab demonstrates how to successfully install and configure resource publishing.  
  
> [!IMPORTANT]  
> The following instructions are for configuring the Remote Desktop Services Publishing test lab using the minimum number of computers. Individual computers are needed to separate the services provided on the network and to clearly show the desired functionality. This configuration is neither designed to reflect best practices nor does it reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed only to work on a separate test lab network.  
  
### Test lab overview  
In this test lab, Remote Desktop Services Publishing is deployed with:  
  
-   One computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, Dynamic Host Configuration Protocol \(DHCP\) server, and an enterprise root certification authority \(CA\).  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDSH1 that is configured as the Remote Desktop Session Host \(RD Session Host\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDWA1 that is configured as the Remote Desktop Web Access \(RD Web Access\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDCB1 that is configured as the Remote Desktop Connection Broker \(RD Connection Broker\) server.  
  
-   One roaming member client computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] named CLIENT1 that is used to connect to the Session Virtualization deployment.  
  
The Remote Desktop Services Publishing test lab consists of 1 subnet \(10.0.0.0\/24\) that simulates an intranet named Corpnet.  
  
Computers are connected to each other by using a Hyper\-V virtual switch. See the following figure.  
  
![](../Image/RDS_SVSD_TLG.jpg)  
  
### Hardware and software requirements  
The following are required components of the test lab:  
  
-   The product disc or files for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   The product disc or files for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   A physical computer that meet the minimum hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## Steps for configuring the test lab  
There are 6 steps to follow when setting up the Remote Desktop Services Publishing test lab based on the Test Lab Guide: Demonstrate Remote Desktop Services Session Virtualization Standard Deployment.  
  
-   **Step 1: Complete the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment Test Lab** \-\- The Publishing test lab requires the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment test lab as its starting point.  
  
-   **Step 2: Publish a RemoteApp Program** – RemoteApp programs are published to either a session collection using Server Manager.  
  
-   **Step 3: Enable File Type Association on a RemoteApp Program** – Enable file type association to assign the file association on the client device to the associated RemoteApp program.  
  
-   **Step 4: Configure DNS Feed Lookup for RemoteApp and Desktop Connections** – Configure the Remote Desktop Services DNS feed lookup to automatically discover the RemoteApp and Desktop connection URL when users type in their email addresses.  
  
-   **Step 5: Test Published RemoteApp Program using RD Web Access** \-\- CLIENT1 is a [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] computer that is used to test that you can successfully connect to the published RemoteApp program.  
  
-   **Step 6: Snapshot the configuration** \-\- At the completion of the lab, snapshot the configuration so that you can later return to a working [!INCLUDE[rds_sv_2](../Token/rds_sv_2_md.md)] Test Lab.  
  
> [!NOTE]  
> You must be logged on as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks described in this guide. If you cannot complete a task while you are logged on with an account that is a member of the Administrators group, try performing the task while you are logged on with an account that is a member of the Domain Admins group.  
  
### Step 1: Complete the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment Test Lab  
This Test Lab Guide uses the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment test lab as a starting place. Please complete the steps in Test Lab Guide: Demonstrate Remote Desktop Services Session Virtualization Standard Deployment before proceeding with the remainder of the steps in this guide. If you have already completed the steps in the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment Test Lab Guide and saved a disk image or a virtual machine snapshot of the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment, then you can restore the Configuration and proceed to the next step.  
  
### Step 2: Publish a RemoteApp Program  
RemoteApp programs are published to either a session collection or virtual desktop collection using Server Manager. Publishing a RemoteApp program in the [!INCLUDE[rds_sv_2](../Token/rds_sv_2_md.md)] test lab consists of the following procedures:  
  
-   Publish a RemoteApp program  
  
The following sections explain these procedures in detail.  
  
#### Publish a RemoteApp program  
  
###### To publish a RemoteApp program  
  
1.  Log on to the RDSH1 server as the CORP\\Administrator user account.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  On the left side of the window, click **Remote Desktop Services**.  
  
4.  Under **Collections**, click **SessionCollection**.  
  
5.  In the **REMOTEAPP PROGRAMS** tile, click **Tasks**, and then click **Publish RemoteApp Programs**.  
  
6.  On the **Select RemoteApp Programs** page, select **Calculator** and **Wordpad**, and then click **Next**.  
  
7.  On the **Confirmation** page, click **Publish**.  
  
8.  When the RemoteApp program is published, click **Close**.  
  
### Step 3: Enable File Type Association on a RemoteApp Program  
Installing and configuring the server that will be used for RD Web Access in the [!INCLUDE[rds_sv_2](../Token/rds_sv_2_md.md)] test lab consists of the following procedures:  
  
-   Enable the default connection URL using Group Policy  
  
-   Configure the file type association  
  
The following sections explain these procedures in detail.  
  
#### Enable the default connection URL using Group Policy  
  
###### To enable the default connection URL using Group Policy  
  
1.  Log on to the domain controller as the CORP\\Administrator user account.  
  
2.  On the domain controller, open Group Policy Management. Click **Start**, type **Group Policy Management**, and then click **Group Policy Management**..  
  
3.  Expand **Forest: corp.contoso.com**, and expand **Domains**, and then expand **corp.contoso.com**.  
  
4.  Right\-click **Default Domain Policy**, and then click **Edit**.  
  
5.  Navigate to **User Configuration** \-> **Policies** \->**Administrative Templates** \-> **Windows Components** \-> **Remote Desktop Services** \-> **RemoteApp and Desktop Connections**.  
  
6.  Double\-click **Specify Default Connection URL**, and then click **Enabled**.  
  
7.  In the **Default Connection URL** box, type **https:\/\/RDWA1.corp.contoso.com\/RDWeb**.  
  
8.  Click **OK**.  
  
#### Configure the File Type Association  
  
###### To configure the file type association  
  
1.  Log on to the RDSH1 server as the CORP\\Administrator user account.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  On the left side of the window, click **Remote Desktop Services**.  
  
4.  Under **Collections**, click **SessionCollection**.  
  
5.  Under the **REMOTEAPP PROGAMS** heading, right\-click **WordPad**, and then click **Edit Properties**.  
  
6.  Click **File Type Association**.  
  
7.  Select the **.docx**, **.odt**, and **.rtf**  
  
8.  Click **OK**.  
  
### Step 4: Configure DNS Feed Lookup for RemoteApp and Desktop Connections  
The Remote Desktop Services DNS feed lookup is used to automatically discover the RemoteApp and Desktop connection URL when users type in their email addresses. This is done by creating a DNS TXT record on the DNS server that contains the connection URL. Configure DNS Feed Lookup for RemoteApp and Desktop Connections to enable automatic discovery of the RemoteApp and Desktop connection URL consists of the following procedures:  
  
-   Configure DNS Feed Lookup for RemoteApp and Desktop Connections.  
  
The following sections explain these procedures in detail.  
  
#### Configure DNS Feed Lookup for RemoteApp and Desktop Connections.  
  
###### To configure DNS feed lookup for RemoteApp and Desktop Connection  
  
1.  Log on to the domain controller as the CORP\\Administrator user account.  
  
2.  On the domain controller, open DNS Manager. Click **Start**, type **DNS**, and then click **DNS**.  
  
3.  Right\-click the forward lookup zone where you want to create the TXT record, and then click **Other New Records**.  
  
4.  Click **Text \(TXT\)**, and then click **Create Record**.  
  
5.  In the **Record name \(use parent domain if left blank\)** box, type **\_msradc**.  
  
6.  In the **Text** box, type **https:\/\/RDWA1.corp.contoso.com\/RDWeb\/Feed**.  
  
7.  Click **OK**.  
  
### Step 5: Test Published RemoteApp Program using RD Web Access  
You can ensure the RemoteApp program published successfully by connecting to the WordPad application that was published.  
  
-   Test Published RemoteApp Program using RD Web Access  
  
The following sections explain these procedures in detail.  
  
#### Test Published RemoteApp Program using RD Web Access  
  
###### To test published RemoteApp program using RD Web Access  
  
1.  Log on to the CLIENT1 computer as the CORP\\Administrator user account.  
  
2.  Open Internet Explorer. To open Internet Explorer, click **Start**, and then click **Internet Explorer.**  
  
3.  In the Internet Explorer address bar, type **https:\/\/RDWA1.corp.contoso.com\/RDWeb** and then press Enter.  
  
4.  Click **Continue to this website \(not recommended\)**.  
  
5.  In the **Domain\/user name** box, type **CORP\\Administrator**.  
  
6.  In the **Password** box, type the password for the CORP\\Administrator user account, and then click **Sign in**.  
  
7.  Click **WordPad**, and then click **Connect**.  
  
8.  Verify that the WordPad application appears correctly.  
  
### Step 6: Snapshot the Configuration  
This completes the Remote Desktop Services Virtual Desktop Infrastructure Quick Start test lab. To save this configuration so that you can quickly return to a working VDI Quick Start configuration from which you can test other Remote Desktop Services modular test lab guides \(TLGs\), TLG extensions, or for your own experimentation and learning, do the following:  
  
1.  On all physical computers or virtual machines in the test lab, close all windows and then perform a graceful shutdown.  
  
2.  If your lab is based on virtual machines, save a snapshot of each virtual machine and name the snapshots Publish RemoteApp program. If your lab uses physical computers, create disk images to save the Remote Desktop Services Publishing test lab configuration.  
  
## Additional Resources  
  
-   [What's New in Remote Desktop Services in Windows Server 2012 \[redirected\]](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server-2012.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Quick Start](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Quick-Start.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md)  
  
-   [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Unmanaged-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md)  
  
-   **You Are Here \->** Test Lab Guide: Remote Desktop Services Publishing  
  
-   [Test Lab Guide: Remote Desktop Licensing](../Topic/Test-Lab-Guide--Remote-Desktop-Licensing.md)  
  
