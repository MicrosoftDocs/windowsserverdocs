---
title: "Configure DirectAccess in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c959b6fc-c67e-46cd-a9cb-cee71a42fa4c
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Configure DirectAccess in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This topic provides step-by-step instructions for configuring DirectAccess in  Windows Server Essentials to enable your mobile workforce to seamlessly connect to your organization's network from any Internet-equipped remote location without establishing a virtual private network (VPN) connection. DirectAccess can offer mobile workers the same connectivity experience inside and outside the office from their  Windows 8.1,  Windows 8, and  Windows 7 computers.  
  
 In  Windows Server Essentials, if the domain contains more than one  Windows Server Essentials server, DirectAccess must be configured on the domain controller.  
  
> [!NOTE]
>  This topic provides instructions for configuring DirectAccess when your  Windows Server Essentials server is the domain controller. If the  Windows Server Essentials server is a domain member, follow the instructions to configure DirectAccess on a domain member in [Add DirectAccess to an Existing Remote Access (VPN) Deployment](https://technet.microsoft.com/library/jj574220.aspx) instead.  
  
## Process overview  
 To configure DirectAccess in  Windows Server Essentials, complete the following steps.  
  
> [!IMPORTANT]
>  Before you use the procedures in this guide to configure DirectAccess in  Windows Server Essentials, you must enable VPN on the server. For instructions, see [Manage VPN](Manage-VPN-in-Windows-Server-Essentials.md).  
  
-   [Step 1: Add Remote Access Management Tools to your server](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_AddRAM)  
  
-   [Step 2: Change the network adapter address of the server to a static IP address](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_AddStaticIP)  
  
-   [Step 3: Prepare a certificate and DNS record for the network location server](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_DNS)  
  
    -   [Step 3a: Grant full permissions to Authenticated Users for the Web server's certificate template](#BKMK_GrantFullPermissions)  
  
    -   [Step 3b: Enroll a certificate for the network location server with a common name that is unresolvable from the external network](#BKMK_EnrollaCertificate)  
  
    -   [Step 3c: Add a new host on the DNS server and map it to the Windows Server Essentials server address](#BKMK_MapNewHosttoServerAddress)  
  
-   [Step 4: Create a security group for DirectAccess client computers](#BKMK_AddSecurityGroup)  
  
-   [Step 5: Enable and configure DirectAccess](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_EnableConfigureDA)  
  
    -   [Step 5a: Enable DirectAccess by using the Remote Access Management Console](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_EnableDA)  
  
    -   [Step 5b: Remove the invalid IPv6Prefix in RRAS GPO (Windows Server Essentials only)](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_RemoveIPv6)  
  
    -   [Step 5c: Enable client computers running Windows 7 Enterprise to use DirectAccess](#BKMK_Step4cWindows7Setup)  
  
    -   [Step 5d: Configure the network location server](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_NLS)  
  
    -   [Step 5e: Add a registry key to bypass CA certification when you establish an IPsec channel](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_CA)  
  
-   [Step 6: Configure Name Resolution Policy Table settings for the DirectAccess server](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_NRPT)  
  
-   [Step 7: Configure TCP and UDP firewall rules for the DirectAccess server GPOs](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_TCPUDP)  
  
-   [Step 8: Change the DNS64 configuration to listen to the IP-HTTPS interface](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_DNS64)  
  
-   [Step 9: Reserve ports for the WinNat service](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_ExemptPort)  
  
-   [Step 10: Restart the WinNat service](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_WinNAT)  
  
> [!NOTE]
>  [Appendix: Set up DirectAccess by using Windows PowerShell](#BKMK_AppendixBPowerShellScript) provides a Windows PowerShell script that you can use to perform the DirectAccess setup.  
  
##  <a name="BKMK_AddRAM"></a> Step 1: Add Remote Access Management Tools to your server  
  
#### To add Remote Access Management Tools  
  
1.  On the server, in the bottom left corner of the Start page, click the **Server Manager** icon.  
  
     In  Windows Server Essentials, you will need to search for Server Manager to open it. On the Start page, type **Server Manager**, and then click **Server Manager** in the search results. To pin Server Manager to the Start page, right-click Server Manager in the search results, and click **Pin to Start**.  
  
2.  If a **User Account Control** warning message displays, click **Yes**.  
  
3.  On the Server Manager Dashboard, click **Manage**, and then click **Add Roles and Features**.  
  
4.  In the Add Roles and Features Wizard, do the following:  
  
    1.  On the **Installation Type** page, click **Role-based or feature-based installation**.  
  
    2.  On the **Server Selection page** (or the **Select destination server** page in  Windows Server Essentials), click **Select a server from the server pool**.  
  
    3.  On the **Features** page, expand **Remote Server Administration Tools (Installed)**, expand **Remote Access Management Tools (Installed)**, expand **Role Administration Tools (Installed)**, expand **Remote Access Management Tools**, and then select **Remote Access GUI and Command-Line Tools**.  
  
    4.  Follow the instructions to complete the wizard.  
  
##  <a name="BKMK_AddStaticIP"></a> Step 2: Change the network adapter address of the server to a static IP address  
 DirectAccess requires an adapter with a static IP address. You need to change the IP address for the local network adapter on your server.  
  
#### To add a static IP address  
  
1.  On the Start page, open **Control Panel**.  
  
2.  Click **Network and Internet**, and then click **View network status and tasks**.  
  
3.  In the task pane of the **Network and Sharing Center**, click **Change adapter settings**.  
  
4.  Right-click the local network adapter, and then click **Properties**.  
  
5.  On the **Networking** tab, click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
6.  On the **General** tab, click **Use the following IP address**, and then type the IP address that you want to use.  
  
     A default value for subnet mask appears automatically in the **Subnet mask** box. Accept the default value, or type the subnet mask value that you want to use.  
  
7.  In the **Default gateway** box, type the IP address of your default gateway.  
  
8.  In the **Preferred DNS server** box, type the IP address of your DNS server.  
  
    > [!NOTE]
    >  Use the IP address that is assigned to your network adapter by DHCP (for example, 192.168.X.X) instead of a loopback network (for example, 127.0.0.1). To find out the assigned IP address, run **ipconfig** at a command prompt.  
  
9. In the **Alternate DNS Server** box, type the IP address of your alternate DNS server, if any.  
  
10. Click **OK**, and then click **Close**.  
  
> [!IMPORTANT]
>  Ensure that you configure the router to forward ports 80 and 443 to the new static IP address of the server.  
  
##  <a name="BKMK_DNS"></a> Step 3: Prepare a certificate and DNS record for the network location server  
 To prepare a certificate and DNS record for the network location server, perform the following tasks:  
  
-   [Step 3a: Grant full permissions to Authenticated Users for the Web server's certificate template](#BKMK_GrantFullPermissions)  
  
-   [Step 3b: Enroll a certificate for the network location server with a common name that is unresolvable from the external network](#BKMK_EnrollaCertificate)  
  
-   [Step 3c: Add a new host on the DNS server and map it to the Windows Server Essentials server address.](#BKMK_MapNewHosttoServerAddress)  
  
###  <a name="BKMK_GrantFullPermissions"></a> Step 3a: Grant full permissions to Authenticated Users for the Web server's certificate template  
 Your first task is to grant full permissions to authenticate users for the Web server's certificate template in the certification authority.  
  
####  <a name="BKMK_ToGrantFullPermissions"></a> To grant full permissions to Authenticated Users for the Web server's certificate template  
  
1.  On the **Start** page, open **Certification Authority**.  
  
2.  In the console tree, under **Certification Authority (Local)**, expand **<servername\>-CA**, right-click **Certificate Templates**, and then click **Manage**.  
  
3.  In **Certification Authority (Local)**, right-click **Web Server**, and then click **Properties**.  
  
4.  In Web Server properties, on the **Security** tab, click **Authenticated Users**, select **Full Control**, and then click **OK**.  
  
5.  Restart **Active Directory Certificate Services**. In Control Panel, open **View local services**. In the list of services, right-click **Active Directory Certificate Services**, and then click **Restart**.  
  
###  <a name="BKMK_EnrollaCertificate"></a> Step 3b: Enroll a certificate for the network location server with a common name that is unresolvable from the external network  
 Next, enroll a certificate for the network location server with a common name that is unresolvable from the external network.  
  
####  <a name="BKMK_ToEnrollaCertificate"></a> To enroll a certificate for the network location server  
  
1.  On the **Start** page, open **mmc** (the Microsoft Management Console).  
  
2.  If a **User Account Control** warning message appears, click **Yes**.  
  
     The Microsoft Management Console (MMC) opens.  
  
3.  On the **File** menu, click **Add/Remove Snap-ins**.  
  
4.  In the **Add or Remote Snap-ins** box, click **Certificates**, and then click **Add**.  
  
5.  On the **Certificates snap-in** page, click **Computer account**, and then click **Next**.  
  
6.  On the **Select Computer** page, click **Local computer**, click **Finish**, and then click **OK**.  
  
7.  In the console tree, expand **Certificates (Local Computer)**, expand **Personal**, right-click **Certificates**, and then, in **All Tasks**, click **Request New Certificate**.  
  
8.  When the Certificate Enrollment Wizard appears, click **Next**.  
  
9. On the **Select Certificate Enrollment Policy** page, click **Next**.  
  
10. On the **Request Certificates** page, select the **Web Server** check box, and then click **More information is required to enroll this certificate**.  
  
11. In the **Certificate Properties** box, enter the following settings for **Subject Name**:  
  
    1.  For **Type**, select **Common name**.  
  
    2.  For **Value**, type the name of the network location server (for example, DirectAccess-NLS.contoso.local), and then click **Add**.  
  
    3.  Click **OK**, and then click **Enroll**.  
  
12. When certificate enrollment completes, click **Finish**.  
  
###  <a name="BKMK_MapNewHosttoServerAddress"></a> Step 3c: Add a new host on the DNS server and map it to the Windows Server Essentials server address  
 To complete the DNS configuration, add a new host on the DNS server and map it to the  Windows Server Essentials server address.  
  
####  <a name="BKMK_ToMapNewHosttoServerAddress"></a> To map a new host to the Windows Server Essentials server address  
  
1.  On the Start page, open DNS Manager. To open DNS Manager, search for **dnsmgmt.msc**, and then click **dnsmgmt.msc** in the results.  
  
2.  In the DNS Manager console tree, expand the local server, expand **Forward Lookup Zones**, right-click the zone with server's domain suffix, and then click **New Host (A or AAAA)**.  
  
3.  Type the name and IP address of the server (for example, DirectAccess-NLS.contoso.local) and its corresponding server address (for example, 192.168.x.x).  
  
4.  Click **Add Host**, click **OK**, and then click **Done**.  
  
##  <a name="BKMK_AddSecurityGroup"></a> Step 4: Create a security group for DirectAccess client computers  
 Next, create a security group to use for DirectAccess client computers, and then add the computer accounts to the group.  
  
#### To add a security group for client computers that use DirectAccess  
  
1. On the Server Manager Dashboard, click **Tools**, and then click **Active Directory Users and Computers**.  
  
   > [!NOTE]
   >  If you do not see **Active Directory Users and Computers** on the **Tools** menu, you need to install the feature. To install Active Directory Users and Groups, run the following Windows PowerShell cmdlet as an administrator: `Install-WindowsFeature RSAT-ADDS-Tools`. For more information, see [Installing or Removing the Remote Server Administration Tool Pack](https://technet.microsoft.com/library/cc730825.aspx).  
  
2. In the console tree, expand the server, right-click **Users**, click **New**, and then click **Group**.  
  
3. Enter a group name, group scope, and group type (create a security group), and then click **OK**.  
  
   The new security group is added to the **Users** folder.  
  
#### To add computer accounts to the security group  
  
1.  On the Server Manager Dashboard, click **Tools**, and then click **Active Directory Users and Computers**.  
  
2.  In the console tree, expand the server, and then click **Users**.  
  
3.  In the list of user accounts and security groups on the server, right-click the security group that you created for DirectAccess, and then click **Properties**.  
  
4.  On the **Members** tab, click **Add**.  
  
5.  In the dialog box, type the names of the computer accounts that you want to add to the group, separating the names with a semicolon (;). Then click **Check Names**.  
  
6.  After the computer accounts are validated, click **OK**. Then click **OK** again.  
  
> [!NOTE]
>  You can also use the **Member of** tab in the computer account properties to add the account to the security group.  
  
##  <a name="BKMK_EnableConfigureDA"></a> Step 5: Enable and configure DirectAccess  
 To enable and configure DirectAccess in  Windows Server Essentials, you must complete the following steps:  
  
-   [Step 5a: Enable DirectAccess by using the Remote Access Management Console](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_EnableDA)  
  
-   [Step 5b: Remove the invalid IPv6Prefix in RRAS GPO (Windows Server Essentials only)](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_RemoveIPv6)  
  
-   [Step 5c: Enable client computers running Windows 7 Enterprise to use DirectAccess](#BKMK_Step4cWindows7Setup)  
  
-   [Step 5d: Configure the network location server](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_NLS)  
  
-   [Step 5e: Add a registry key to bypass CA certification when you establish an IPsec channel](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_CA)  
  
###  <a name="BKMK_EnableDA"></a> Step 5a: Enable DirectAccess by using the Remote Access Management Console  
 This section provides step-by-step instructions to enable DirectAccess in  Windows Server Essentials. If you have not configured VPN on the server yet, you should do that before you start this procedure. For instructions, see [Manage VPN](Manage-VPN-in-Windows-Server-Essentials.md).  
  
##### To enable DirectAccess by using the Remote Access Management Console  
  
1.  On the Start page, open **Remote Access Management**.  
  
2.  In the Enable DirectAccess Wizard, do the following:  
  
    1.  Review **DirectAccess Prerequisites**, and click **Next**.  
  
    2.  On the **Select Groups** tab, add the security group that you created earlier for DirectAccess clients. (If you have not created the security group, see [Step 4: Create a security group for DirectAccess client computers](#BKMK_AddSecurityGroup) for instructions.)  
  
    3.  On the **Select Groups** tab, click **Enable DirectAccess for mobile computers only** if you want to enable mobile computers to use DirectAccess to remotely access the server, and then click **Next**.  
  
    4.  In **Network Topology**, select the topology of the server, and then click **Next**.  
  
    5.  In **DNS Suffix Search List**, add the additional DNS suffix for the client computers, if needed, and then click **Next**.  
  
        > [!NOTE]
        >  By default, the Enable DirectAccess Wizard already adds the DNS suffix for current domain. However, you can add more if needed.  
  
    6.  Review the Group Policy Objects (GPOs) that will be applied, and modify them if needed.  
  
    7.  Click **Next**, and then click **Finish**.  
  
    8.  Restart the Remote Access Management service by running the following Windows PowerShell command in elevated mode:  
  
        ```powershell  
        Restart-Service RaMgmtSvc   
        ```  
  
###  <a name="BKMK_RemoveIPv6"></a> Step 5b: Remove the invalid IPv6Prefix in RRAS GPO (Windows Server Essentials only)  
  This section applies to a server running Windows Server Essentials.  
  
 Open Windows PowerShell as an Administrator and run the following commands:  
  
```powershell  
gpupdate  
$key = Get-ChildItem -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\RemoteAccess\config\MachineSIDs | Where-Object{$_.GetValue("IPv6RrasPrefix") -ne $null}  
Remove-GPRegistryValue -Name "DirectAccess Server Settings" -Key $key.Name -ValueName IPv6RrasPrefix  
gpupdate  
```  
  
###  <a name="BKMK_Step4cWindows7Setup"></a> Step 5c: Enable client computers running Windows 7 Enterprise to use DirectAccess  
 If you have client computers running  Windows 7 Enterprise, complete the following procedure to enable DirectAccess from those computers.  
  
##### To enable  Windows 7 Enterprise computers to use DirectAccess  
  
1.  On the server's Start page, open **Remote Access Management**.  
  
2.  In the Remote Access Management Console, click **Configuration**. Then, in the **Setup Details** pane, under **Step 2**, click **Edit**.  
  
     The Remote Access Server Setup Wizard opens.  
  
3.  On the **Authentication** tab, choose the certification authority (CA) certificate that will be the trusted root certificate (you can choose the CA certificate of the  Windows Server Essentials server). Click **Enable Windows 7 client computers to connect via DirectAccess**, and then click **Next**.  
  
4.  Follow the instructions to complete the wizard.  
  
> [!IMPORTANT]
>  There is a known issue for  Windows 7 Enterprise computers connecting over DirectAccess if the  Windows Server Essentials server did not come with UR1 pre-installed. To enable DirectAccess connections in that environment, you must perform these additional steps:  
> 
> 1. Install the hotfix described in [Microsoft Knowledge Base (KB) article 2796394](https://support.microsoft.com/kb/2796394) on the Windows Server Essentials server. Then restart the server.  
>    2. Then install the hotfix described in [Microsoft Knowledge Base (KB) article 2615847](https://support.microsoft.com/kb/2615847) on each  Windows 7 computer.  
> 
>    This issue was resolved in  Windows Server Essentials.  
  
###  <a name="BKMK_NLS"></a> Step 5d: Configure the network location server  
 This section provides step-by-step instructions to configure the network location server settings.  
  
> [!NOTE]
>  Before you begin, copy the contents of the <SystemDrive\>\inetpub\wwwroot folder to the <SystemDrive\>\Program Files\Windows Server\Bin\WebApps\Site\insideoutside folder. Also copy the default.aspx file from the <SystemDrive\>\Program Files\Windows Server\Bin\WebApps\Site folder to the <SystemDrive\>\Program Files\Windows Server\Bin\WebApps\Site\insideoutside folder.  
  
##### To configure the network location server  
  
1.  On the Start page, open **Remote Access Management**.  
  
2.  In the Remote Access Management Console, click **Configuration**, and in the **Remote Access Setup** details pane, in **Step 3**, click **Edit**.  
  
3.  In the Remote Access Server Setup Wizard, on the **Network Location Server** tab, select **The network location server is deployed on the Remote Access server**, and then select the certificate that was previously issued (in [Step 3: Prepare a certificate and DNS record for the network location server](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_DNS)).  
  
4.  Follow the instructions to complete the wizard, and then click **Finish**.  
  
###  <a name="BKMK_CA"></a> Step 5e: Add a registry key to bypass CA certification when you establish an IPsec channel  
 Your next step is to configure the server to bypass CA certification when an IPsec channel is established.  
  
##### To add a registry key to bypass the CA certification  
  
1.  On the Start page, open **regedit** (the Registry Editor).  
  
2.  In the Registry Editor, expand **HKEY_LOCAL_MACHINE**, expand **System**, expand **CurrentControlSet**, expand **Services**, and expand **IKEEXT**.  
  
3.  Under **IKEEXT**, right-click **Parameters**, click **New**, and then click **DWORD (32 bit) Value**.  
  
4.  Rename the newly added value to **ikeflags**.  
  
5.  Double-click **ikeflags**, set the **Type** to **Hexadecimal**, set the value to **8000**, and then click **OK**.  
  
> [!NOTE]
>  You can use the following Windows PowerShell command in elevated mode to add this registry key:  
>   
>  `Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\IKEEXT\Parameters -Name ikeflags -Type DWORD -Value 0x8000`  
  
##  <a name="BKMK_NRPT"></a> Step 6: Configure Name Resolution Policy Table settings for the DirectAccess server  
 This section provides instructions for editing the Name Resolution Policy Table (NPRT) entries for internal addresses (for example, entries with a contoso.local suffix) for DirectAccess client GPOs, and then set the IPHTTPS interface address.  
  
#### To configure Name Resolution Policy Table entries  
  
1.  On the Start page, open **Group Policy Management**.  
  
2.  In the Group Policy Management console, click the default forest and domain, right-click **DirectAccess Client Settings**, and then click **Edit**.  
  
3.  Click **Computer Configurations**, click **Policies**, click **Windows Settings**, and then click **Name Resolution Policy**. Choose the entry that has the namespace that is identical to your DNS suffix, and then click **Edit Rule**.  
  
4.  Click the **DNS Settings for DirectAccess** tab; then select **Enable DNS settings for DirectAccess in this rule**. Add the IPv6 address for the IP-HTTPS interface in the DNS server list.  
  
    > [!NOTE]
    >  You can use the following Windows PowerShell command to get the IPv6 address:  
    >   
    >  `(Get-NetIPInterface -InterfaceAlias IPHTTPSInterface | Get-NetIPAddress -PrefixLength 128)[1].IPAddress`  
  
##  <a name="BKMK_TCPUDP"></a> Step 7: Configure TCP and UDP firewall rules for the DirectAccess server GPOs  
 This section includes step-by-step instructions to configure TCP and UDP firewall rules for the DirectAccess server GPOs.  
  
#### To configure firewall rules  
  
1.  On the Start page, open **Group Policy Management**.  
  
2.  In the Group Policy Management console, click the default forest and domain, right-click **DirectAccess Server Settings**, and then click **Edit**.  
  
3.  Click **Computer Configuration**, click **Policies**, click **Windows Settings**, click **Security Settings**, click **Windows Firewall with Advanced Security**, click next-level **Windows Firewall with Advanced Security**, and then click **Inbound Rules**. Right-click **Domain name Server (TCP-In)**, and then click **Properties**.  
  
4.  Click the **Scope** tab, and in the **Local IP address** list, add the IPv6 address of the IP-HTTPS interface.  
  
5.  Repeat the same procedure for **Domain Name Server (UDP-In)**.  
  
##  <a name="BKMK_DNS64"></a> Step 8: Change the DNS64 configuration to listen to the IP-HTTPS interface  
 You must change the DNS64 configuration to listen to the IP-HTTPS interface by using the following Windows PowerShell command.  
  
```powershell  
Set-NetDnsTransitionConfiguration -AcceptInterface IPHTTPSInterface  
```  
  
##  <a name="BKMK_ExemptPort"></a> Step 9: Reserve ports for the WinNat service  
 Use the following Windows PowerShell command to reserve ports for the WinNat service. Replace "192.168.1.100" with the actual IPv4 address of your  Windows Server Essentials server.  
  
```powershell  
Set-NetNatTransitionConfiguration -IPv4AddressPortPool @("192.168.1.100, 10000-47000")  
```  
  
> [!IMPORTANT]
>  To avoid port conflicts with applications, be sure that the port range that you reserve for the WinNat service does not include port 6602.  
  
##  <a name="BKMK_WinNAT"></a> Step 10: Restart the WinNat service  
 Restart the Windows NAT Driver (WinNat) service by running the following Windows PowerShell command.  
  
```powershell  
Restart-Service winnat  
```  
  
##  <a name="BKMK_AppendixBPowerShellScript"></a> Appendix: Set up DirectAccess by using Windows PowerShell  
 This section describes how to set up and configure DirectAccess by using Windows PowerShell.  
  
### Preparation  
 Before you begin configuring your server for DirectAccess, you must complete the following:  
  
1.  Follow the procedure in [Step 3: Prepare a certificate and DNS record for the network location server](Configure-DirectAccess-in-Windows-Server-Essentials.md#BKMK_DNS) to enroll a certificate named **DirectAccess-NLS.contoso.com** (where **contoso.com** is replaced by your actual internal domain name), and to add a DNS record for the network location server (NLS).  
  
2.  Add a security group named **DirectAccessClients** in Active Directory, and then add client computers for which you want to provide the DirectAccess functionality. For more information, see [Step 4: Create a security group for DirectAccess client computers](#BKMK_AddSecurityGroup).  
  
### Commands  
  
> [!IMPORTANT]
>  In  Windows Server Essentials, you do not need to remove the unnecessary IPv6 prefix GPO. Delete the code section with the following label: `# [WINDOWS SERVER 2012 ESSENTIALS ONLY] Remove the unnecessary IPv6 prefix GPO`.  
  
```powershell  
# Add Remote Access role if not installed yet  
$ra = Get-WindowsFeature RemoteAccess  
If ($ra.Installed -eq $FALSE) { Add-WindowsFeature RemoteAccess }  
  
# Server may need to restart if you installed RemoteAccess role in the above step  
  
# Set the internet domain name to access server, replace contoso.com below with your own domain name  
$InternetDomain = "www.contoso.com"  
#Set the SG name which you create for DA clients  
$DaSecurityGroup = "DirectAccessClients"  
#Set the internal domain name  
$InternalDomain = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().Name  
  
# Set static IP and DNS settings  
$NetConfig = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true"  
$CurrentIP = $NetConfig.IPAddress[0]  
$SubnetMask = $NetConfig.IPSubnet | Where-Object{$_ -like "*.*.*.*"}  
$NetConfig.EnableStatic($CurrentIP, $SubnetMask)  
$NetConfig.SetGateways($NetConfig.DefaultIPGateway)  
$NetConfig.SetDNSServerSearchOrder($CurrentIP)  
  
# Get physical adapter name and the certificate for NLS server  
$Adapter = (Get-WmiObject -Class Win32_NetworkAdapter -Filter "NetEnabled=$true").NetConnectionId  
$Certs = dir cert:\LocalMachine\My  
$nlscert = $certs | Where-Object{$_.Subject -like "*CN=DirectAccess-NLS*"}  
  
# Add regkey to bypass CA cert for IPsec authentication  
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\IKEEXT\Parameters -Name ikeflags -Type DWORD -Value 0x8000  
  
# Install DirectAccess.   
Install-RemoteAccess -NoPrerequisite -DAInstallType FullInstall -InternetInterface $Adapter -InternalInterface $Adapter -ConnectToAddress $InternetDomain -nlscertificate $nlscert -force  
  
#Restart Remote Access Management service  
Restart-Service RaMgmtSvc  
  
# [WINDOWS SERVER 2012 ESSENTIALS ONLY] Remove the unnecessary IPv6 prefix GPO   
  
gpupdate  
$key = Get-ChildItem -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\RemoteAccess\config\MachineSIDs | Where-Object{$_.GetValue("IPv6RrasPrefix") -ne $null}  
Remove-GPRegistryValue -Name "DirectAccess Server Settings" -Key $key.Name -ValueName IPv6RrasPrefix  
gpupdate  
  
# Enable client computers running Windows 7 to use DirectAccess  
$allcertsinroot = dir cert:\LocalMachine\root  
$rootcert = $allcertsinroot | Where-Object{$_.Subject -like "*-CAA*"}  
Set-DAServer -IPSecRootCertificate $rootcert[0]  
Set -DAClient -OnlyRemoteComputers Disabled -Downlevel Enabled  
  
#Set the appropriate security group used for DA client computers. Replace the group name below with the one you created for DA clients  
Add-DAClient -SecurityGroupNameList $DaSecurityGroup   
Remove-DAClient -SecurityGroupNameList "Domain Computers"  
  
# Gather DNS64 IP address information  
$Remoteaccess = get-remoteaccess  
$IPinterface = get-netipinterface -InterfaceAlias IPHTTPSInterface | get-netipaddress -PrefixLength 128  
$DNS64IP=$IPInterface[1].IPaddress  
$Natconfig = Get-NetNatTransitionConfiguration  
  
# Configure TCP and UDP firewall rules for the DirectAccess server GPO  
$GpoName = 'GPO:'+$InternalDomain+'\DirectAccess Server Settings'  
Get-NetFirewallRule -PolicyStore $GpoName -Displayname "Domain Name Server (TCP-IN)"|Get-NetFirewallAddressFilter | Set-NetFirewallAddressFilter -LocalAddress $DNS64IP  
Get-NetFirewallrule -PolicyStore $GpoName -Displayname "Domain Name Server (UDP-IN)"|Get-NetFirewallAddressFilter | Set-NetFirewallAddressFilter -LocalAddress $DNS64IP  
  
# Configure the name resolution policy settings for the DirectAccess server, replace the DNS suffix below with the one in your domain  
$Suffix = '.' + $InternalDomain  
set-daclientdnsconfiguration -DNSsuffix $Suffix -DNSIPAddress $DNS64IP  
  
# Change the DNS64 configuration to listen to IP-HTTPS interface  
Set-NetDnsTransitionConfiguration -AcceptInterface IPHTTPSInterface  
  
# Copy the necessary files to NLS site folder  
XCOPY 'C:\inetpub\wwwroot' 'C:\Program Files\Windows Server\Bin\WebApps\Site\insideoutside' /E /Y  
XCOPY 'C:\Program Files\Windows Server\Bin\WebApps\Site\Default.aspx' 'C:\Program Files\Windows Server\Bin\WebApps\Site\insideoutside' /Y  
  
# Reserve ports for the WinNat service  
Set-NetNatTransitionConfiguration -IPv4AddressPortPool @("192.168.1.100, 10000-47000")  
  
# Restart the WinNat service  
Restart-Service winnat  
```  
  
## See also  
  
-   [Manage Anywhere Access](Manage-Anywhere-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
