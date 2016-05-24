---
title: Windows Server 2012 R2 Test Lab Guide: Demonstrate VPN Auto trigger
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2698818d-adc3-44fd-824a-de2eaa09bbe5
---
# Windows Server 2012 R2 Test Lab Guide: Demonstrate VPN Auto trigger
[!INCLUDE[winblue_client_1](../Token/winblue_client_1_md.md)] allows a Microsoft or third party VPN clients to automatically connect to the corporate network when specified applications are launched.  
  
If auto triggering is enabled for a VPN profile, a remote access connection is triggered whenever a specific application is accessed. If user credentials are cached within the VPN profile, the VPN connection will be automatically established without any user interaction.  
  
## In this Guide  
This guide provides step\-by\-step instructions for configuring new Windows VPN capability in a test lab to demonstrate functionality and operation. You will set up and deploy Remote Access based on the [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] Base Configuration using four server computers and one client computer. The resulting test lab simulates an intranet and the Internet.  
  
> [!IMPORTANT]  
> The following instructions are for configuring a Remote Access test lab using the minimum number of computers. Individual computers are needed to separate the services provided on the network and to clearly show the desired functionality. This configuration is neither designed to reflect best practices nor does it reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed only to work on a separate test lab network.  
>   
> Attempting to adapt this Remote Access test lab configuration to a pilot or production deployment can result in configuration or functionality issues.  
  
## Test Lab Overview  
In this test lab, Remote Access is deployed with:  
  
-   One computer running Windows [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, and Dynamic Host Configuration Protocol \(DHCP\) server  
  
-   One intranet member server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] named EDGE1 that is configured as a Remote Access server  
  
-   One intranet member server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] named APP1 that is configured as a general application server and web server  
  
-   One standalone server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] named INET1 that is configured as an Internet DHCP server, DNS server, and web server  
  
-   One non\-domain\-joined, Internet\-connected client computer running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] named CLIENT2 that is configured as a Remote Access VPN client  
  
The Remote Access test lab consists of two subnets that simulate the following:  
  
1.  The Internet \(131.107.0.0\/24\)  
  
2.  An intranet named Corpnet \(10.0.0.0\/24\) separated from the Internet by EDGE1  
  
Automatic triggering of VPN connections is not supported on domain joined machines. Configuration of auto triggering properties on domain joined machines is possible through Windows PowerShell so that the profile can be exported to another computer. However, auto triggering will not work in a VPN profile if the client is domain joined. This modular test lab demonstrates Remote Access VPN auto trigger functionality using a non\-domain\-joined [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] client. This test client computer is used to show connectivity to corporate resources via a simulated Internet \(the Internet subnet\).  
  
### Hardware and software requirements  
The following are required components of the test lab:  
  
-   The product disc or files for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
  
-   The product disc or files for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]  
  
-   Five computers or virtual machines that meet the minimum hardware requirements for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
  
## Steps for Configuring the Remote Access VPN Auto\-trigger Test Lab  
There are four steps to follow when setting up a Remote Access VPN Auto\-trigger test lab based on the Test Lab Guide: Base Configuration.  
  
1.  Set up the Base Configuration test lab.  
  
    The Remote Access simplified setup test lab requires the [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId%2029010) with both Corpnet and Internet subnets, as its starting point.  
  
2.  Configure EDGE1.  
  
    EDGE1 is already a member server computer. For the Remote Access VPN auto\-trigger test lab, EDGE1 must be configured as a Remote Access server with VPN access deployed  
  
3.  Configure INET1.  
  
    INET1 is already a Windows [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] that is configured as an Internet DNS server, web server, and DHCP server. For the Remote Access VPN auto\-trigger test lab, INET1 must be configured with a DNS record for the internetsite.corp.contoso.com Internet resource  
  
4.  Configure CLIENT2.  
  
    Add CLIENT2 as a standalone client computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For this test lab, CLIENT2 will be used to test and demonstrate remote access VPN auto\-trigger functionality and operation.  
  
> [!NOTE]  
> You must be logged on as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks described in this guide. If you cannot complete a task while you are logged on with an account that is a member of the Administrators group, try performing the task while you are logged on with an account that is a member of the Domain Admins group.  
  
This guide provides steps for configuring the computers of the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]: Base Configuration test lab, configuring Remote Access in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], and demonstrating remote client connectivity. The following sections provide details about how to perform these tasks.  
  
### Step 1: Set up the Base Configuration Test Lab  
Set up the Base Configuration test lab for both the Corpnet and Internet subnets using the procedures in the “Steps for Configuring the Corpnet Subnet” and “Steps for Configuring the Internet Subnet” sections of the [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/p/?LinkId%2029010).  
  
### Step 2: Configure EDGE1  
EDGE1 configuration for the Remote Access VPN Auto\-trigger test lab consists of the following procedures:  
  
1.  Install the Remote Access server role on EDGE1  
  
2.  Deploy VPN access using the Remote Access Configuration wizard  
  
The following sections explain these procedures in detail.  
  
##### To install the Remote Access server role on EDGE1  
  
1.  In the **Dashboard** console of **Server Manager**, under **Configure this local server**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  In the **Select Server Roles** dialog, select **Remote Access**, and then click **Next**.  
  
4.  Click **Next** on the **Select Features** screen.  
  
5.  Click **Next** on the **Remote Access** screen.  
  
6.  On the **Role Services** screen, select **DirectAccess and VPN \(RAS\)**. Click **Add Features** when prompted, and then click **Next**.  
  
7.  Click **Next** on the **Web Server Role \(IIS\)** screen, and then click **Next** to accept default role services for IIS.  
  
8.  On the **Confirmation** screen, click **Install**.  
  
9. Wait for the feature installations to complete, and then click **Close**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
Install-WindowsFeature RemoteAccess -IncludeManagementTools  
Add-WindowsFeature -Name DirectAccess-VPN -IncludeManagementTools  
  
```  
  
### Deploy VPN access using the Remote Access Configuration wizard  
Use the following procedure to deploy VPN Remote Access on EDGE1.  
  
##### To configure VPN Remote Access on EDGE1  
  
1.  From the **Tools** menu in **Server Manager**, click **Routing and Remote Access**.  
  
2.  In the **Routing and Remote Access** console, right\-click **EDGE1 \(local\)**, and then click **Configure and Enable Routing and Remote Access**.  
  
3.  When the **Routing and Remote Access Server Setup Wizard** launches. Click **Next**.  
  
4.  Select **Remote access \(dial\-up or VPN\)**, and then click **Next**.  
  
5.  Select the checkbox for **VPN**, and then click **Next**.  
  
6.  Under Network interfaces, select **Internet**, and then click **Next**.  
  
7.  On the IP Address Assignment screen, select **Automatically**, and then click **Next**.  
  
8.  On the Managing Multiple Remote Access Servers screen, select **No, use Routing and Remote Access to authenticate connection requests**, and then click **Next**.  
  
9. On the **Summary** screen, click **Finish**. When you are prompted to enable DHCP Relay Agent, click **OK**.  
  
10. When the Routing and Remote Access Server Setup Wizard completes, expand **EDGE1 \(local\)** in the Routing and Remote Access console tree, and select **Remote Access Logging & Policies**.  
  
11. When the Routing and Remote Access Server Setup Wizard completes, expand **EDGE1 \(local\)** in the Routing and Remote Access console tree, and select **Remote Access Logging & Policies**.  
  
12. Right\-click **Remote Access Logging and Policies**, and select **Launch NPS**.  
  
13. Double\-click the first default policy named **Connections to Microsoft Routing and Remote Access server**.  
  
14. On the **Overview** tab, under **Access Permission**, select **Grant Access**. **Grant Access if the connection request matches this policy radio button**.  
  
15. Click to select **Ignore user account dial\-in properties**.  
  
16. Click **OK** to close the Connections to Microsoft Routing and Remote Access server properties window.  
  
17. Close the **Network Policy Server** window.  
  
### Step 3: Configure INET1  
INET1 is already a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] server that is configured as an Internet DNS server, web server, and DHCP server. For the Remote Access VPN auto\-trigger test lab, INET1 must be configured with a DNS record for the internetsite.corp.contoso.com Internet resource.  
  
INET1 configuration for the Remote Access VPN Auto\-trigger test lab consists of the following procedure:  
  
-   Create a new DNS host record for internetsite.corp.contoso.com on INET1  
  
The following section explains this procedure in detail.  
  
#### Create a new DNS host record on INET1  
Use the following procedure to create the internetsite record on INET1.  
  
###### To create a new DNS entry on INET1  
  
1.  From the Tools menu in Server Manager, click **DNS**.  
  
2.  In the console tree of DNS Manager, expand **INET1**, and click **Forward Lookup Zones**.  
  
3.  Right\-click **Forward Lookup Zones**, click **New Zone**, and then click **Next**.  
  
4.  On the **Zone Type** page, click **Next**.  
  
5.  On the **Zone Name** page, type **corp.contoso.com**, and then click **Next**.  
  
6.  Click **Next** twice to accept defaults for zone file and dynamic update, and then click **Finish**.  
  
7.  In the console tree, expand **Forward Lookup Zones**, right click **corp.contoso.com**, and then click **New Host \(A or AAAA\)**.  
  
8.  In **Name**, type **internetsite**. In **IP address**, type **131.107.0.1**. Click **Add Host**.  
  
9. Click **OK**, and then click **Done**.  
  
10. Close the DNS Manager console.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
Add-DnsServerPrimaryZone -Name corp.contoso.com -ZoneFile corp.contoso.com.dns  
Add-DnsServerResourceRecordA -ZoneName corp.contoso.com -Name internetsite -IPv4Address 131.107.0.1  
  
```  
  
### Step 4: Add and Configure CLIENT2  
Use the following procedures to demonstrate remote access connectivity with CLIENT2:  
  
1.  Install the operating system on CLIENT2  
  
2.  Connect CLIENT2 to the Internet subnet and configure remote access with VPN  
  
3.  Configure and test VPN application\-based auto\-trigger functionality on CLIENT2  
  
4.  Connect CLIENT2 to the Corpnet subnet and verify that application\-based auto\-trigger functionality is disabled  
  
The following sections explain these procedures in detail.  
  
### Install the operating system on CLIENT2  
  
##### To install the operating system on CLIENT2  
  
1.  Start the installation of Windows 8.1.  
  
2.  When you are prompted for a PC name, type **CLIENT2**.  
  
3.  When you are prompted by the **Settings** dialog, click **Use express settings**.  
  
4.  At the Log on prompt, click **Sign in without a Microsoft account**. Click **Local account**. If CLIENT2 does not have Internet access during setup, you will be prompted to **Create a local account**.  
  
5.  When you are prompted for a user name, type **User1**. Type a strong password twice, and type a password hint. Click **Finish**.  
  
6.  Connect CLIENT2 to the Internet subnet. When prompted to automatically connect to devices on this network, click **Yes**.  
  
### Connect CLIENT2 to the Internet subnet and configure remote access with VPN  
  
##### To configure VPN access to Corpnet from the Internet  
  
1.  Connect CLIENT2 to the Internet subnet. Once the network determination process completes, the network icon should indicate Internet access.  
  
2.  Open **PC Settings** \(click the **Settings** charm, and then click **Change PC Settings**\)  
  
3.  In the PC Settings console tree, click **Network**.  
  
4.  Click **Add a VPN Connection**.  
  
5.  In the **Add a VPN connection** dialog, select **Microsoft** as the VPN provider.  
  
6.  Under **Connection name**, type **Contoso VPN Connection**.  
  
7.  Under **Server name or address**, type **edge1.contoso.com**.  
  
8.  Under **Type of sign\-in info**, select **User name and password**.  
  
9. Type **CORP\\User1** and the password for User1 in the User name and Password fields. Verify that the checkbox is selected for **Remember my sign\-in info**.  
  
10. Click **Save** to close the **Add a VPN connection** dialog.  
  
### Configure and test VPN application\-based auto\-trigger functionality on CLIENT2  
  
##### To configure and test VPN application\-based auto\-trigger functionality  
  
1.  From the desktop on CLIENT2, right\-click the **Start** icon. Click **Windows PowerShell \(Admin\)**.  
  
2.  Enable Split\-tunneling for the VPN connection by entering the following command, followed by **ENTER**.  
  
    **Set\-VpnConnection –Name “Contoso VPN connection” –SplitTunneling $true**  
  
3.  Configure CLIENT2 to always connect to the Contoso intranet whenever the legacy application Notepad is used. In the Windows PowerShell window, type the following command to configure application\-based VPN triggering for the Notepad application, and then press **ENTER**.  
  
    **Add\-VpnConnectionTriggerApplication \-Name "Contoso VPN Connection" –ApplicationID “C:\\Windows\\System32\\notepad.exe”**  
  
4.  Configure CLIENT2 to always connect to the Contoso intranet whenever the modern application Calculator is used. First, in the Windows PowerShell window, type the following command to determine the application package family name associated with the Windows Calculator app, and then press **ENTER**.  
  
    **Get\-AppXPackage \-Name Microsoft.WindowsCalculator**  
  
    Note the string listed for PackageFamilyName.  
  
    Next, type the following command to configure application\-based VPN triggering for the Windows Calculator app, and then press **ENTER**.  
  
    **Add\-VpnConnectionTriggerApplication \-Name "Contoso VPN Connection" –ApplicationID Microsoft.WindowsCalculator\_8wekyb3d8bbwe**  
  
5.  View the newly added VPN triggers associated with the connection by typing the following command followed by **ENTER**.  
  
    **Get\-VpnConnectionTrigger "Contoso VPN Connection"**  
  
    Examine the output of Get\-VpnApplicationTrigger. The Contoso VPN Connection will be triggered for automatic connection whenever the applications notepad.exe or Windows Calculator are launched.  
  
6.  Launch the Notepad application to automatically trigger the VPN connection. From the Windows PowerShell prompt, type **notepad.exe** and then press **ENTER**.  
  
7.  Click the network icon in the System Notification Area. Note that **Contoso VPN Connection** is now listed as **Connected**.  
  
8.  In the Notepad window, click **File**, and then click **Open**. Next to **File name**, type **\\\\app1.corp.contoso.com\\Files\\example.txt**, and then click **Open**.  
  
9. You should see the contents of the Example.txt file shared on the APP1 server.  
  
10. Click the network icon in the System Notification Area. Click **Contoso VPN Connection**, and then click **Disconnect**.  
  
11. Click **Contoso VPN Connection** again. Note that manually disconnecting the VPN disables the auto\-connect setting. Select the checkbox for **Let apps automatically use this VPN connection** to re\-enable automatic triggering.  
  
### Connect CLIENT2 to the Corpnet subnet and verify that auto\-trigger functionality is disabled  
  
##### To verify that VPN is not triggered when connected to the Trusted Network  
  
1.  Connect CLIENT2 to the Corpnet subnet. CLIENT2 will receive a DHCP address with the corp.contoso.com connection\-specific DNS suffix.  
  
2.  From the Windows PowerShell prompt, type **ipconfig** and then press ENTER. Note that the value of **Connection\-specific DNS suffix** is listed as **corp.contoso.com**.  
  
3.  Review the VPN triggers configuration associated with the connection by typing the following command followed by **ENTER**.  
  
    **Get\-VpnConnectionTrigger "Contoso VPN Connection"**  
  
    Examine the output of Get\-VpnApplicationTrigger. While CLIENT2 is connected to the Corpnet subnet, access to the Trusted Network corp.contoso.com will prevent automatic triggering of the VPN connection.  
  
4.  From the Windows PowerShell prompt, type **notepad.exe** and then press **ENTER**.  
  
5.  Click the network icon in the System Notification Area. Note that **Contoso VPN Connection** is no longer automatically connected when the Notepad application is launched.  
  
## Snapshot the Configuration  
This completes the Remote Access Auto\-trigger VPN test lab. To save this configuration so that you can quickly return to a working Remote Access configuration from which you can test other Remote Access modular test lab guides \(TLGs\), TLG extensions, or for your own experimentation and learning, do the following:  
  
1.  On all physical computers or virtual machines in the test lab, close all windows and then perform a graceful shutdown.  
  
2.  If your lab is based on virtual machines, save a snapshot of each virtual machine and name the snapshots **Remote Access Auto\-trigger VPN**. If your lab uses physical computers, create disk images to save the DirectAccess simplified IPv4\-only test lab configuration.  
  
