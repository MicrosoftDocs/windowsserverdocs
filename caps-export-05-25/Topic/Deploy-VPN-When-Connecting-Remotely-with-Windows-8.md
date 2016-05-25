---
title: Deploy VPN When Connecting Remotely with Windows 8
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bc392186-c15f-4a2d-98b3-90c7ee139238
author: vhorne
---
# Deploy VPN When Connecting Remotely with Windows 8
It is becoming very common for computer users to connect to networks by using personal devices such as laptops, slates, and tablets. For organizations that support it, remote users can connect to the corporate network from their personal devices. The users can connect directly through the corporate WiFi by using their domain credentials, or by using virtual private network \(VPN\) connectivity. This topic describes the detailed steps and recommendations for deploying a VPN so that users running Windows 8 can connect remotely. It is meant to help organizations enable users to use their personal devices for common Windows 8 deployment scenarios.  
  
## Deploy Windows 8 VPN client  
This section describes several methods for deploying a VPN , and it explains the IT pro and remote user experiences in detail. Some of the common profile management tasks such as editing, deleting, and profile renaming are also discussed briefly.  
  
A VPN profile deployment includes setting up the profile on the client device and preparing the relevant settings that are required to access the corporate network.  
  
> [!NOTE]  
> Windows RT does not support the installation of third\-party applications. However, the Windows VPN client is available on Windows RT, and it is capable of connecting to third\-party solutions. The third\-party VPN solutions may need to be configured to allow the connection, and third\-party VPN vendors own this support. The Windows VPN client can be provisioned by the methods  that are described in this section \(excluding the Connection Manager Administration Kit\).  
  
The following VPN connection profile deployment methods are available for unmanaged client devices \(including devices running Windows RT\):  
  
-   [Self\-service portal](../Topic/Deploy-VPN-When-Connecting-Remotely-with-Windows-8.md#BKMK_Portal)  
  
-   [Windows PowerShell scripts](../Topic/Deploy-VPN-When-Connecting-Remotely-with-Windows-8.md#BKMK_PowerShell)  
  
-   [Connection Manager Administration Kit](../Topic/Deploy-VPN-When-Connecting-Remotely-with-Windows-8.md#BKMK_CMAK)  
  
### <a name="BKMK_Portal"></a>Use self\-service portal  
On devices running Windows RT, an integrated management client is available that can communicate with a management infrastructure in the cloud to deliver line\-of\-business applications to the users. There are two parts to this management client:  
  
-   **Agent**: The built\-in system component.  
  
-   **Self\-service portal \(SSP\)**: The application that is used to browse for and install the line\-of\-business applications made available to them. IT pros can also use this SSP to deploy VPN connections on Windows client computers.  
  
The following subsections explain the IT pro and remote user experiences for a profile that is set up by using the SSP.  
  
**IT pro experience**  
  
-   To set up the profile, simply open the server management interface and provide settings for the VPN profile, then click **Finish**.  
  
-   The IT pro can also update the profile \(if needed\) through the server management interface, and no action is required from the users.  
  
**Remote user experience**  
  
Authorized users self\-deploy the VPN setup on a device running Windows RT by navigating to the Control Panel application called **Company apps**, and then providing their company email address and password.  
  
The agent then automatically configures the VPN and other features on the client device, based on the instructions provided by the organization’s management infrastructure.  
  
### <a name="BKMK_PowerShell"></a>Use Windows PowerShell scripts  
Simple Windows PowerShell scripts can be used by IT pros to help remote users install and configure VPN connections on unmanaged client computers. These scripts serve a dual purpose:  
  
1.  To set up VPN profiles on devices  
  
2.  To configure network\-specific settings \(such as prepared routes and network access point \(NAP\) settings\) on the client device  
  
The following subsections explain the IT pro and remote user experiences for installing the VPN profile by using these scripts.  
  
**IT pro experience**  
  
1.  The IT pro creates an external web portal that is accessible to remote users when they connect with domain credentials. This web portal is published to all the corporate network users who intend to connect to the corporate network by using the VPN.  
  
2.  The IT pro creates a Windows PowerShell script and adds it to the web portal with setup instructions and guidelines.  
  
The following Windows PowerShell script to create the VPN profiles is very simple. Other Windows PowerShell sample scripts and documentation are available on Microsoft TechNet to help IT pros create corresponding scripts for their network deployment.  
  
**Syntax**  
  
```  
## VPN profile creation cmdlet syntax  
Add-VpnConnection -Name "<name of the VPN connection>" -ServerAddress "<FQDN or IP Address of VPN server>" -TunnelType <tunnel type enum value> -EncryptionLevel <encryption level enum value> -AuthenticationMethod <authentication method enum value> -SplitTunneling -EapConfigXmlStream <EAP configuration XML>  
```  
  
**Syntax for password\-based deployment**  
  
```  
## Generate the required EAP method configuration (if applicable)  
  
# Generate configuration XML for (default) EAP-MSCHAPv2 authentication method  
$a = New-EapConfiguration  
# Generate configuration XML for PEAP authentication method with EAP-MSCHAPv2 as its inner method  
$b = New-EapConfiguration -Peap -FastReconnect $true -TunnledEapAuthMethod $a.EapConfigXmlStream  
  
## VPN cmdlet usage sample with VPN Connection name ‘MyVPN’ and VPN Server – contoso.com  
Add-VpnConnection -Name "My VPN" -ServerAddress "contoso.com" -TunnelType Automatic -EncryptionLevel Required -AuthenticationMethod Eap -SplitTunneling -EapConfigXmlStream $b.EapConfigXmlStream  
```  
  
**Remote user experience**  
  
1.  Remote users receive the external web portal information from the IT pro. To configure the VPN on the unmanaged device, users navigate to the portal and sign in with their domain credentials.  
  
2.  On the VPN configuration page, the user simply clicks \(or touches\) the link, and the setup script is downloaded to the client device.  
  
3.  The user clicks **Run**, and the profile is installed.  
  
4.  The IT pro informs the users to run the script again each time the script is updated.  
  
#### Advanced scenarios  
IT pros can include many advanced configuration settings in this single\-click VPN deployment script to provide a complete client deployment experience for remote users. These advanced settings might include the following for the VPN connection:  
  
-   Policies for IPsec, publishing routes, or NAP settings  
  
-   Web\-proxy configuration  
  
-   Intranet settings  
  
-   Connection\-specific DNS suffix configuration  
  
**Connection\-specific DNS suffix**  
  
For a given interface, the connection specific DNS suffix can be configured by using the following Windows PowerShell script:  
  
```  
## Configure connection specific DNS suffix  
Set-DnsClient -InterfaceAlias "My VPN" -ConnectionSpecificSuffix "contoso.com"  
  
```  
  
However, for VPN connections, there might be situations in which Kerberos authentication occurs before the VPN connection configuration is complete. When this happens, the Kerberos protocol will not allow authentication for 15 minutes. To work around this potential situation, IT pros can use the following command to clear the Kerberos negative cache and avoid delay:  
  
```  
## Clear negative caching for Kerberos  
klist purge_bind  
  
```  
  
**Get Connected Wizard**  
  
The Get Connected Wizard is the VPN connection setup wizard that is available on Windows Server and Windows client operating systems. It is a simple method for creating VPN connections if the VPN deployment is password\-based, and it has no complexities like deployment NAP settings or publishing routes. The remote access server name is the only piece of information that is needed to create the connection.  
  
If the profile is more complex, the IT pro should provide detailed instructions and configuration scripts.  
  
For more information, see [Set Up and Edit VPN Connections in Windows 8](../Topic/Set-Up-and-Edit-VPN-Connections-in-Windows-8.md).  
  
### <a name="BKMK_CMAK"></a>Use Connection Manager Administration Kit  
The Connection Manager Administration Kit \(CMAK\) Wizard creates customized VPN profiles according to organizational requirements, and distributes the generated package to clients for a single\-click installation. This tool is commonly used for VPN client package generation.  
  
> [!NOTE]  
> CMAK can be used to deploy VPN profiles on all devices running Windows, except those running Windows RT.  
  
For more information, see [Connection Manager Administration Kit Overview](http://technet.microsoft.com/library/hh831675.aspx).  
  
### Manage profiles  
For the VPN profiles that are created by using Windows PowerShell scripts, the IT pro can share another single\-click script through the web portal to remove the profile and its corresponding settings from a client device.  
  
**Windows PowerShell script example to remove a VPN profile**  
  
```  
## Remove a VPN profile named “My VPN” created for local user only  
Remove-VpnConnection -Name "My VPN" -Force  
  
```  
  
For more information, see [Set Up and Edit VPN Connections in Windows 8](../Topic/Set-Up-and-Edit-VPN-Connections-in-Windows-8.md).  
  
**Advanced profile editing configurations**  
  
1.  If IT pros want to make any changes to a VPN profile that was deployed on client systems by using System Center Configuration Manager, they simply open the server user interface and make the required changes. A new VPN profile will be generated and used for all future deployments  
  
2.  For script\-based profiles, IT pros can write a new script and distribute it through a shared resource or a web portal. As an example, the following scripts show some methods for changing the tunnel type, encryption level, and authentication method for the VPN profile “My VPN”, which was created in the [Use Windows PowerShell scripts](../Topic/Deploy-VPN-When-Connecting-Remotely-with-Windows-8.md#BKMK_PowerShell) section earlier.  
  
    The following script shows how an IT pro can delete an existing VPN connection, and then deploy a new one:  
  
    ```  
    ## 1. Delete older VPN connection, and provision a new one (with the same name) with updated ##    settings  
    $vpnConnection = Get-VpnConnection -AllUserConnection  
  
    if($vpnConnection.Name -eq "My VPN")  
    {  
        # Remove the connection  
        Remove-VpnConnection –Name "My VPN" –AllUserConnection -Force  
    }  
    ## Provision a new VPN connection “My VPN” with updated settings  
    Add-VpnConnection -Name "My VPN" -ServerAddress "contoso.com" -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MsChapv2 -SplitTunneling  
  
    ```  
  
    The following script provides an example for how you can edit an existing connection, and add a new connection if it is not already provisioned:  
  
    ```  
    ## 2. (a) If already provisioned, update this older VPN connection;   
    ##    (b) If not provisioned, provision a new VPN connection with updated settings  
  
    $vpnConnection = Get-VpnConnection -AllUserConnection  
  
    if($vpnConnection.Name -eq "My VPN")  
    {  
        # Update the connection  
        Set-VpnConnection –Name "My VPN" –AllUserConnection -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2  
    }  
    else  
    {  
        # Provision a new VPN connection “My VPN” with updated settings  
        Add-VpnConnection -Name "My VPN" -ServerAddress "contoso.com" -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MsChapv2 -SplitTunneling   
    }  
  
    ```  
  
    The following script shows how you can distribute separate Install and Uninstall scripts. In this case, the IT pro simply updates the installation script and asks users run this script to uninstall the older VPN connection.  
  
    ```  
    ## 3. If already provisioned, remove the older VPN connection  
    $vpnConnection = Get-VpnConnection -AllUserConnection  
  
    if($vpnConnection.Name -eq "My VPN")  
    {  
        # Remove the connection  
        Remove-VpnConnection –Name "My VPN" –AllUserConnection -Force  
  
    ```  
  
    For more information, see [Set Up and Edit VPN Connections in Windows 8](../Topic/Set-Up-and-Edit-VPN-Connections-in-Windows-8.md).  
  
## Connect VPN by using Windows 8 user interface  
The Windows 8 user interface includes the following features:  
  
-   Multiple connection profiles are supported  
  
-   Credential collection for all authentication methods in Windows 8  
  
-   Connection progress status and failure messages  
  
-   Seamless connection by using authentication protocol negotiation during connection for default profiles  
  
-   Users are not prompted for stored credentials, and stored credentials for a profile can be cleared from the right\-click menu  
  
-   Silent disconnect when the server initiates a disconnection  
  
### Launch Windows 8 user interface for VPN connections  
**Touch\-enabled devices**: Slide the user interface from the right corner of the screen.  
  
**All other devices**: Use the following procedure to launch the Windows 8 user interface:  
  
1.  Open Charms \(**Windows Key \+ C**\).  
  
2.  Click **Settings**.  
  
3.  Click the network icon in the right corner of the screen.  
  
4.  The Windows 8 user interface appears.  
  
**Desktop**: Click the **Network** icon in the **Notification** area to launch the Windows 8 user interface.  
  
The following screenshot shows the Windows 8 user interface. Multiple VPN and wireless connections are shown, and one of the VPN connections is selected.  
  
![](../Image/NetworkConnectionsUI.gif)  
  
### Connect to VPN  
Use the following procedure to connect to a password\-based VPN:  
  
##### To connect to a VPN  
  
1.  On the **Networks** menu, click the name of a VPN connection, and then click **Connect**.  
  
2.  In the **Network Authentication** text boxes, the remote user types a user name and password.  
  
3.  If the IT pro enabled the **Verify server identity** option, the user is prompted to confirm, and then clicks **Connect**.  
  
The following images represent the password\-based VPN connection process.  
  
![](../Image/VPNconnectionprocedure.png)  
  
### Deploy the VPN  
This section describes the options that are available for the VPN deployment.  
  
#### Password\-based deployment  
Windows 8 can establish a remote access connection through a variety of password\-based point\-to\-point authentication protocols, which include:  
  
1.  Non\-EAP methods \(PAP, CHAP, or MS\-CHAPv2\)  
  
2.  EAP methods \(PEAP or EAP\-TTLS\)  
  
Non\-EAP password\-based methods are not considered secure, and they should be deployed with secure TLS methods such as PEAP or EAP\-TTLS.  
  
We recommend using PEAP\- or EAP\-TTLS\-based authentication methods for corporate deployments. Both options are available in Windows 8.  
  
#### Certificate\-based deployments  
When an organization needs to support enrolling and importing user certificates, there are many ways to deploy the public key infrastructure \(PKI\). The best deployment method depends on the organization’s policy and deployment infrastructure.  
  
For more information, see [Certificate Enrollment Web Services in Windows Server 2008 R2](http://www.microsoft.com/download/details.aspx?displaylang=en&id=1746).  
  
#### Enable split tunneling  
Windows PowerShell cmdletsand System Center Configuration Manager support enabling and disabling split\-tunneling for VPN connections. But disabling split\-tunneling \(or enabling force tunneling\) requires some additional configuration, such as deploying a web proxy for Internet access over the VPN connection.  
  
IT pros can enable split tunneling by using the Windows PowerShell switch parameter **–SplitTunneling** in the **Add\-VpnConnection** cmdlet, or by setting the **–SplitTunneling** Boolean parameter to the value **$true** in the **Set\-VpnConnection** cmdlet. This is shown in the following commands:  
  
```  
## 1. Enabling* Split-Tunneling in a VPN connection while creating VPN connection  
Add-VpnConnection -Name "My VPN" -ServerAddress "contoso.com" –SplitTunneling  
  
## 2. Enabling Split-Tunneling in an existing VPN connection  
Set-VpnConnection -Name "My VPN" –SplitTunneling $true  
  
## 2. Disabling Split-Tunneling in an existing VPN connection  
Set-VpnConnection -Name "My VPN" –SplitTunneling $false  
  
```  
  
> [!NOTE]  
> By default, **Add\-VpnConnection** keeps split tunneling disabled for a VPN connection.  
  
For more information, see [Set Up and Edit VPN Connections in Windows 8](../Topic/Set-Up-and-Edit-VPN-Connections-in-Windows-8.md).  
  
#### Understand route implications  
For split\-tunneled VPN connections, the corporate network routes have to be configured on the client device after the VPN connection is established. The following two methods can accomplish this:  
  
-   **DHCP\-based route publishing**: When a client device is connected to the corporate network by using a VPN connection, it gets its IP address from the DHCP server that is designated for that purpose. This DHCP server can also supply the required routes for intranet access with the configuration packet to the client.  
  
-   **One\-click script route publishing**: The IT pro can provide a one\-click Windows PowerShell script to remote users for scheduled tasks. IT pros use a web portal or external shared resource to provide script for configuration of the corporate network routes on unmanaged client devices. The script adds a scheduled task on the device, which is triggered every time the device establishes a connection with the remote VPN server. The script includes the required routes, which enable the client to access corporate resources. If the IT pro already uses a single\-click script to deploy other settings \(such as IPsec policies and the DNS suffix\), this route information can be included with that script.  
  
#### Deploy web proxy and intranet settings  
In the case of force\-tunneling, the web proxy needs to be configured on the unmanaged devices for them to access Internet sites. Also, the intranet settings have to be enabled for a VPN connection to suppress repeated credential prompts while accessing intranet sites. The following sections discuss these configurations for unmanaged devices.  
  
**Web proxy**  
  
Force\-tunneling requires the VPN client to use corporate network web proxy for all the Internet traffic. The IT pro can configure a web\-proxy that is specific for the VPN connection by using Windows PowerShell cmdlets for web proxy deployment. These cmdlets can be included in the one\-click script used to deploy the VPN connection on the client computer.  
  
Following is the syntax and a sample usage command for a VPN\-specific web proxy:  
  
```  
## Syntax of PowerShell cmdlet for VPN specific web-proxy configuration  
Set-VpnConnectionProxy –Name “<name of the VPN connection>” [-AutoDetect] [–AutoConfigurationScript “<URL of the proxy configuration WPAD script>”] –[ProxyServer “<URL or IP Address/port number of the proxy server>”] [-BypassProxyForLocal] [–ExceptionPrefix “<comma separated list of the proxy exception Protocols and/or URLs and/or IP Addresses>”]  
  
```  
  
**Intranet settings**  
  
Enabling intranet settings is required for the user to access corporate sites without repeated credential prompts while connected through the VPN. Intranet settings determine whether websites are a part of the local intranet zone and if they require domain credentials. If intranet settings are enabled for a VPN connection, the VPN credentials are automatically used to authenticate users when they access local intranet sites.  
  
For domain\-joined computers, the VPN interface is automatically recognized, and these settings are turned on every time the client is connected to the corporate network through the VPN. But for unmanaged devices, VPN connections are not automatically recognized, which results in a credentials prompt every time the user navigates to a local intranet site. The IT pro should configure the following registry settings on clients running Windows 8 to enable the intranet settings when the client is connected to the corporate network through a VPN connection:  
  
```  
# registry settings to enable the Intranet settings while connected to a VPN Server  
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /v AutoDetect /t REG_DWORD /d 0 /f  
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /v UNCAsIntranet /t REG_DWORD /d 1 /f  
  
```  
  
## Deploy multisite VPN  
Organizations with more than one business location can choose to have multisite VPN server deployments. In this case, Global Server Load Balancing \(GSLB\) is used to resolve the address and to redirect the client to the nearest VPN server site. If this is not an option, the IT pro can provide VPN connection profiles per site, which provides a choice for remote users to connect to the desired server.  
  
## Interoperate with third\-party VPN servers  
The native VPN client running Windows 8 can interoperate with commonly deployed VPN server devices by using the PPTP, L2TP\/IPsec, SSTP, and IKEv2 protocols.  
  
For more information about tunneling, authentication, and encryption protocols that are supported, see the **Third\-party VPN interoperability** section in [VPN Compatibility and Interoperability in Windows 8 and Windows Server 2012](../Topic/VPN-Compatibility-and-Interoperability-in-Windows-8-and-Windows-Server-2012.md).  
  
> [!TIP]  
> We recommend using L2TP\/IPsec and IKEv2 protocols for connection.  
  
## Use Connected Standby state  
The Connected Standby state is a feature in Windows 8, which enables the computer to enter a standby state and consume very low battery power, but remain connected and fresh.  
  
When a device is connected to the remote VPN server, and it enters the Connected Standby state, the connection remains live, even if the interface is closed due to a low power state. When the device resumes from the Connected Standby state, VPN clients search for the same underlying interface. If the interface is available after resuming, and the VPN credentials are cached, the client seamlessly connects with the remote VPN server. However, if the credentials were not cached, and remote user input \(such as a physical smart card or one\-time password\) is required, the VPN connection is not resumed automatically.  
  
## Appendix A: Glossary  
The following table explains terms that are used in this topic.  
  
|||  
|-|-|  
|Name|Details|  
|Windows RT management by Configuration Manager|New server role that deploys and manages certain settings on Windows RT devices. It does support managing the complete VPN profile.|  
|Network access point \(NAP\) infrastructure settings|Settings to enable the NAP agent on the client side. Settings require information such as NAP server and SHAs for deploying the NAP service.|  
|VPN profile|Contains all the VPN settings, such as VPN server information, VPN authentication settings \(such as 2\-factor, EAP settings, and password\), tunnel settings \(such as IKEv2, SSTP, L2TP, and PPTP\), health check settings, and so on.|  
|OTP|RSA is the most popular OTP deployment. It provides a client EAP method in Windows to integrate with RSA OTP server.|  
|Split\-tunneling|Accessing the Internet without going through the corporate network firewall.|  
|NAP|NAP configuration for unmanaged devices is not considered a primary requirement, but if required in a corporate network, it can be deployed by a single\-click script provided by the IT pro \(similar to the methods discussed above for single\-click scripts\).|  
|FQDN|Fully qualified domain name|  
|GSLB|Global Server Load Balancing|  
|WinRT|Modern Windows 8 environment|  
|WindowsRT|New Windows 8 version for ARM architecture|  
  
### Experience terminology  
  
|||  
|-|-|  
|Name|Details|  
|VPN: **One click script**|VPN profile is deployed using the PowerShell script<br /><br />**Enabled only in W8 clients:** New VPN client PowerShell|  
|VPN: **System Center Configuration Manager**|VPN profile is deployed using the System Center Configuration Manager Windows RT management feature<br /><br />**Enabled only in Windows RT clients:** New instance based VPN client PowerShell \(consumes profile setting from XML\)|  
|VPN: **Get Connected Wizard**|Remote user creates the profile using built\-in client UI<br /><br />**Available in W8 & down\-level Windows client:** However, Windows 8 has a connect experience and method discovery option where the remote user is not asked any information except the server name for majority profiles.|  
|NAP: **Single click script**|IT pro provides the script to plumb the NAP policies on unmanaged client devices – details available on TechNet<br /><br />**Available in W8 & down\-level Windows client:** No changes made in Windows 8|  
|Routes deployment: **Single click script**|The IT pro provides the script to plumb the intranet routes on unmanaged devices.<br /><br />**Available in W8 & down\-level Windows client:** No changes made in Windows 8|  
|Certificate enrollment web\-servicve|Organization needs to support enrolling\/importing user certificates.  Web\-enrollment is an intuitive way to do so.<br /><br />More details are available on TechNet.|  
  
