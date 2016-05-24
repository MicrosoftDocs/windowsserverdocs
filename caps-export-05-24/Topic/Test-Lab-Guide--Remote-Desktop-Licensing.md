---
title: Test Lab Guide: Remote Desktop Licensing
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 13f2b485-2138-4c41-b4ad-5ebddd0acbcf
author: lizap
---
# Test Lab Guide: Remote Desktop Licensing
  
## Introduction  
Remote Desktop Licensing \(RD Licensing\) is a Remote Desktop Services role service that is included with [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. RD Licensing manages the licenses that are required to connect to a session\-based desktop or a virtual desktop. You can use RD Licensing to install, issue, and track the availability and usage of licenses.  
  
### In this guide  
This paper contains instructions for setting up a test lab based on the [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md) or [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md) and installing and configuring licensing for Remote Desktop Services using four server computers. The resulting test lab demonstrates how to successfully install and configure licensing for Remote Desktop Services.  
  
> [!IMPORTANT]  
> The following instructions are for configuring the Remote Desktop Services Licensing test lab using the minimum number of computers. Individual computers are needed to separate the services provided on the network and to clearly show the desired functionality. This configuration is neither designed to reflect best practices nor does it reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed only to work on a separate test lab network.  
  
### Test lab overview  
In this test lab, Remote Desktop Services Publishing is deployed with:  
  
-   One computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, Dynamic Host Configuration Protocol \(DHCP\) server, and an enterprise root certification authority \(CA\).  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDVH1 that is configured as the Remote Desktop Virtualization Host \(RD Virtualization Host\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDWA1 that is configured as the Remote Desktop Web Access \(RD Web Access\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named RDCB1 that is configured as the Remote Desktop Connection Broker \(RD Connection Broker\) and the Remote Desktop Services Licensing server.  
  
The Remote Desktop Services Licensing test lab consists of 1 subnet \(10.0.0.0\/24\) that simulates an intranet named Corpnet.  
  
Computers are connected to each other by using a Hyper\-V virtual switch. See the following figure.  
  
![](../Image/RDS_TLG_POOL.jpg)  
  
### Hardware and software requirements  
The following are required components of the test lab:  
  
-   You must have a network shared folder that is configured to store user profile disks. All RD Virtualization Host computer accounts must have the ability to read and write to this location.  
  
-   The product disc or files for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   The product disc or files for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   A physical computer that meet the minimum hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## Steps for configuring the test lab  
There are 7 steps to follow when you set up Remote Desktop Services Licensing test lab based on the [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md) or [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md).  
  
-   **Step 1: Complete the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment Test Lab** \-\- The Publishing test lab requires the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment test lab as its starting point.  
  
-   **Step 2: Install the RD Licensing role service** – Install the RD Licensing role service on RDCB1.  
  
-   **Step 3: Activate the Remote Desktop license server** – Activate the Remote Desktop license server to certify the license server.  
  
-   **Step 4: Request RDS Beta CALs** – Request Beta licenses for the Remote Desktop license server.  
  
-   **Step 5: Install RDS CALs on the Remote Desktop license server** \-\- Install RDS CALs to allow the license server to issue Remote Desktop Services licenses to clients.  
  
-   **Step 6: Verify licensing for the Remote Desktop Services** \-\-  
  
-   **Step 7: Snapshot the configuration** \-\- At the completion of the lab, snapshot the configuration so that you can later return to a working [!INCLUDE[rds_sv_2](../Token/rds_sv_2_md.md)] Test Lab.  
  
> [!NOTE]  
> You must be logged on as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks described in this guide. If you cannot complete a task while you are logged on with an account that is a member of the Administrators group, try performing the task while you are logged on with an account that is a member of the Domain Admins group.  
  
### Step 1: Complete the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment Test Lab  
This Test Lab Guide uses the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment test lab as a starting place. Please complete the steps in [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md) or [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md) before proceeding with the remainder of the steps in this guide. If you have already completed the steps in the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment Test Lab Guide and saved a disk image or a virtual machine snapshot of the Demonstrate Remote Desktop Services Session Virtualization Standard Deployment, then you can restore the Configuration and proceed to the next step.  
  
### Step 2: Install the RD Licensing role service  
Install the RD Licensing role service on the RDCB1 server.  
  
-   Install the RD Licensing role service  
  
The following sections explain these procedures in detail.  
  
#### Install the RD Licensing role service  
  
###### To install the RD Licensing role service  
  
1.  Log on to the RDCB1 server as the CORP\\Administrator user account.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  On the left side of the window, click **Remote Desktop Services**, and then click **Overview**.  
  
4.  Under **Deployment Overview**, click the **\+** icon above RD Licensing.  
  
5.  On the **Select a server** page, click **RDCB1.corp.contoso.com**, click the right arrow, and then click **Next**.  
  
6.  On the **Confirm selections** page, verify the RD Licensing role service will be installed, and then click **Add**.  
  
7.  On the **View progress** page, confirm the installation of the RD Licensing role service was successful, and then click **Close**.  
  
### Step 3: Activate the Remote Desktop License Server  
Activate the Remote Desktop license server. A license server must be activated to certify the license server and prepare the license server to issue Remote Desktop Services client access licenses \(RDS CALs\), or VDI Suite licenses.  
  
-   Activate the Remote Desktop License Server  
  
The following sections explain these procedures in detail.  
  
#### Activate the Remote Desktop license server  
  
###### To activate a Remote Desktop license server automatically  
  
1.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
2.  On the left side of the window, click **Remote Desktop Services**.  
  
3.  Click **Servers**.  
  
4.  Right\-click **RDCB1**, and then click **RD Licensing Manager**.  
  
5.  Right\-click **RDCB1**, and then click **Activate Server**. The Activate Server Wizard starts.  
  
6.  In the **Activate Server Wizard**, on the **Welcome to the Activate Server Wizard** page, click **Next**.  
  
7.  On the **Connection Method** page, in the **Connection method:** drop\-down list, select **Automatic connection \(recommended\)**, and then click **Next**.  
  
8.  On the **Company Information** page, enter your **First Name:**, **Last Name:**, and **Company:**, select your **Country or Region:** from the drop\-down list, and then click **Next**.  
  
9. On the **Company Information** optional information page, specify any other information that you want to provide, such as **Email:**, and **Company address:**, and then click **Next**.  
  
10. On the **Completing the Activate Server Wizard** page, ensure that the **Start Install Licenses Wizard** now check box is cleared, and then click **Next**.  
  
### Step 4: Request RDS Beta CALs  
Request RDS CALs over the Internet.  
  
-   Request RDS Beta CALs  
  
The following sections explain these procedures in detail.  
  
#### Request RDS Beta CALs  
  
###### To request RDS Beta CALs  
  
1.  Open Internet Explorer. To open Internet Explorer, click **Start**, and then click **Internet Explorer**.  
  
2.  In the **Internet Explorer address bar**, type **https:\/\/licensecode.one.microsoft.com\/** and then press Enter.  
  
3.  On the **Remote Desktop Services License Code Request page**, select the following information and then click **Next**:  
  
    -   **Country:**  
  
    -   **Source:** Select your beta\/evaluation source.  
  
    -   **License Type:** You have the choice to select Per User CALs or Per Device CALs.  
  
    -   **eMail Address:** Select an email address to receive the RDS CALs.  
  
4.  On the **Confirm License Code Request** page, re\-enter the **email address** and ensure that the information you provided in the confirm section is correct. Enter the capcha code and then click **Submit**.  
  
5.  You will receive an email from RDSLMIC \(it may end up in your junk folder\) with a **5x5 Beta evaluation license key**.  
  
### Step 5: Install RDS CALs on the Remote Desktop License Server  
Install RDS CALs on the Remote Desktop license server, to allow the license server to issue Remote Desktop Services client access licenses \(RDS CALs\).  
  
-   Install RDS CALs on the Remote Desktop license server  
  
The following sections explain these procedures in detail.  
  
#### Install RDS CALs on the Remote Desktop license server  
  
###### To install Remote Desktop Services client access licenses \(RDS CALs\) automatically  
  
1.  On the left side of the window, click **Remote Desktop Services**, and then click **Servers**, select the server **RDCB1**, and then click **RD Licensing Manager**.  
  
2.  Right\-click the license server **RDCB1**, and then click **Install Licenses**.  
  
3.  In the **Install Licenses Wizard**, on the **Welcome to the Install Licenses Wizard** page, click **Next**.  
  
4.  On the **License Program** page, select **License Pack \(Retail Purchase\)**, and then click **Next**.  
  
5.  Enter the 5x5 Beta evaluation license key that you received by email, click **Add**, and then click **Next**.  
  
6.  Click **Finish**, to complete installation of the licenses. The license server can now issue RDS CALs to clients that connect to a Remote Desktop Services deployment.  
  
### Step 6: Verify Licensing for the Remote Desktop Services  
To verify the functionality of the deployment, use Remote Desktop Connection \(RDC\) to connect to the remote host. The use of the license will be verified on the Remote Desktop license server.  
  
-   Verify client connectivity:  
  
    -   To verify client connectivity in a session\-based desktop deployment: Establish a client connection in a session\-based desktop deployment using a valid license  
  
    -   To verify client connectivity in a virtual machine\-based desktop deployment: Establish a client connection in a virtual machine\-based desktop deployment using a valid license  
  
-   Verify the RDS CAL by using Remote Desktop Licensing Manager  
  
The following sections explain these procedures in detail.  
  
#### Establish a client connection in a session\-based desktop deployment using a valid license  
  
###### To establish a client connection in a session\-based desktop deployment using a valid license  
  
1.  Use the appropriate deployment guide to verify client connectivity. After client connectivity has been established, verify the RDS CAL by using Remote Desktop Licensing Manager.  
  
    -   [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)  
  
    -   [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md)  
  
#### Establish a client connection in a virtual machine\-based desktop deployment using a valid license  
  
###### To establish a client connection in a virtual machine\-based desktop deployment using a valid license  
  
1.  Use the appropriate deployment guide to verify client connectivity. After client connectivity has been established, verify the RDS CAL by using Remote Desktop Licensing Manager.  
  
    -   [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md)  
  
#### Verify the RDS CAL by using Remote Desktop Licensing Manager  
  
###### To verify the RDS CAL by using Remote Desktop Licensing Manager  
  
1.  On the left side of the window, click **Remote Desktop Services**, and then click **Servers**, select the server **RDCB1**, and then click **RD Licensing Manager**.  
  
2.  In the console tree, expand **All servers**, and then click **RDCB1**.  
  
3.  In the results pane, verify that a license is used in the **Issued** column.  
  
### Step 7: Snapshot the Configuration  
This completes the Remote Desktop Services Licensing test lab. To save this configuration so that you can quickly return to a working Remote Desktop Services Licensing configuration from which you can test other Remote Desktop Services modular test lab guides \(TLGs\), TLG extensions, or for your own experimentation and learning, do the following:  
  
1.  On all physical computers or virtual machines in the test lab, close all windows and then perform a graceful shutdown.  
  
2.  If your lab is based on virtual machines, save a snapshot of each virtual machine and name the snapshots Remote Desktop Services Licensing. If your lab uses physical computers, create disk images to save the Remote Desktop Services Licensing test lab configuration.  
  
## Additional Resources  
  
-   [What's New in Remote Desktop Services in Windows Server 2012 \[redirected\]](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server-2012.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Quick Start](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Quick-Start.md)  
  
-   [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md)  
  
-   [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Unmanaged-Pooled-Virtual-Desktop-Collections.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)  
  
-   [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md)  
  
-   [Test Lab Guide: Remote Desktop Services Publishing](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Publishing.md)  
  
-   **You Are Here \->** Test Lab Guide: Remote Desktop Services Licensing  
  
