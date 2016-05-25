---
title: Deploy and Configure a VPN for Devices Running Windows RT
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8636faae-be69-40c7-a9fa-6a7d13f9b3c8
author: vhorne
---
# Deploy and Configure a VPN for Devices Running Windows RT
Employees who want to use personal devices \(such as laptops, slates, and tablets\) to connect to corporate networks when they are not joined to the domain is a topic of high interest for businesses. Virtual private network \(VPN\) connectivity is available in all Windows 8 devices to enable remote access to the corporate network. This capability is documented in detail in a set of recently published Microsoft TechNet articles. These articles explain using a VPN with x86\-based devices and devices running Windows RT.  
  
This topic specifically focuses on how to deploy and configure a VPN when employees are using devices running Windows RT.  Additionally, this topic identifies limitations in VPN support in Windows RT, describes the VPN configurations that are possible with major third\-party VPN servers, and outlines the client\-side experiences.  
  
## Work with third\-party VPN servers  
Devices running Windows RT come with a VPN client implementation that is fully compatible with Microsoft Routing and Remote Access Server \(RRAS\). Third\-party VPN solutions from major networking vendors are in widespread use by enterprises. Windows RT \(unlike x86\-based Windows 8\) does not support the installation of native VPN client applications from these vendors. Thus, the only way to connect to third\-party VPN servers is by using the VPN client implementation that is provided in Windows RT.  
  
The VPN client in Windows RT can connect by using standard PPTP, L2TP\/IPsec, and IKEv2 protocols, which are widely supported. However, SSL\-based VPN connectivity to third\-party servers  is not possible because SSL VPN implementations are proprietary and distinct to each vendor. Network administrators must configure their third\-party VPN servers to allow connections by using one of the supported standard protocols.  
  
### Verify third\-party VPN interoperability  
Although connections to any third\-party server by using one of the previously mentioned protocols should work, we have specifically verified interoperability of the VPN client in Windows RT with popular versions of Cisco and Juniper server software. Following table depicts the interoperability details.  
  
||||||  
|-|-|-|-|-|  
|Third\-party VPN server solution|Tested operating system version|Tunnels supported|Authentication methods supported|Crypto Suits supported|  
|CISCO<br /><br />\(2951 VPN Server\)|IOS 15.1.4|-   PPTP<br /><br />-   L2TP\/IPSec with certificate<br /><br />-   IPSec \(IKEv2\) with certificate|-   CHAP<br /><br />-   PSK \(over v4 and v6\)<br /><br />-   Computer certificate|**IPsec**:<br /><br />AH auth: HMAC\_SHA\_1\_96, HMAC\_MD5\_96<br /><br />**ESP encryption**: AES\_128, CBC\_3DES, CBC\_DES, None<br /><br />IKEv2:<br /><br />Encryption: 3DES, AES\_128, AES\_192, AES\_256<br /><br />Integrity:SHA1, SHA\_256, SHA\_384<br /><br />DH Group: DH2|  
|Juniper<br /><br />\(SSG series\)|6.2.0r5.0|-   L2TP\/IPSec with certificate|-   CHAP<br /><br />-   PSK \(over v4 and v6\)<br /><br />-   Computer certificate||  
  
We recommend using the L2TP\/IPSec or IKEv2 protocols to connect to third\-party servers.  
  
> [!NOTE]  
> The Extensible Authentication Protocol \(EAP\) method is supported by the native VPN client in Windows RT, but it is not tested for interoperability with third\-party solutions.  
  
For more information, see[Virtual Private Networking with Windows Server 2012 and Windows 8: Compatibility and Interoperability](http://go.microsoft.com/fwlink/?LinkID=263426).  
  
### VPN deployment options  
The following apply to both Microsoft RRAS as well as 3rd party VPN servers.**Password\-based deployment**  
  
Windows RT can establish a remote access connection through a variety of password\-based PPP authentication protocols, which includes  
  
-   Non\-EAP methods like PAP, CHAP, MS\-CHAPv2, etc., or  
  
-   EAP methods \(PEAP, EAP\-TTLS etc.\)  
  
The password\-based methods which are not considered secure \(Non\-EAP password based methods\) should be deployed with secure TLS methods such as PEAP, EAP\-TTLS.  
  
> [!IMPORTANT]  
> Microsoft recommends using PEAP or TTLS based authentication methods \(both available in\-the\-box in Windows RT\) for corporate deployments.  
  
**Certificate\-based deployments**  
  
To support this, an organization needs to support enrolling\/importing user certificates. There are many options to deploy a Public Key Infrastructure \(PKI\) for this purpose and it depends upon the organization’s policy and deployment capabilities. More details on the Certificate enrollment web service can be found on TechNet.  
  
### Multi\-site VPN deployment  
Organizations with more than one business location may choose to have multi\-site VPN server deployments. In this case, organizations should use Global Server Load Balancing \(GSLB\) for resolution of the address and redirecting the client to the nearest VPN server site. If for some reason, that is not an option, then the IT administrator can provide VPN connection profiles per site, thus providing the user with a choice to connect the desired remote server.  
  
## Windows RT VPN client provisioning  
VPN profile provisioning includes setting up the profile on the client device and plumbing the relevant settings required for corpnet access. The following describes the VPN connection profile provisioning methods that are available for Windows RT devices.  
  
### Get Connected Wizard \(GCW\)  
GCW is the legacy VPN connection setup wizard, and is available on Windows RT. It provides a simple method for creating VPN connections from the client device itself. If the VPN deployment is simple \(password based\) and has no complexities like provisioning NAP, Routes, etc., then users can easily create the profile themselves. In this case, a user just configures the remote access server name or IP address as instructed by his network administrator.  
  
If the profile is a more complex then the administrator needs to provide the detailed instructions and\/or the configuration scripts.  
  
The TechNet article, [Set Up and Edit VPN Connections in Windows 8](../Topic/Set-Up-and-Edit-VPN-Connections-in-Windows-8.md), provides more details.  
  
### Single\-Click \(PowerShell\) scripts  
Network administrators can create simple PowerShell scripts to help users install and configure the VPN connections on unmanaged devices. These scripts serve dual purposes:  
  
-   Create a VPN profile, and  
  
-   Configure network specific settings \(e.g. plumbing routes, NAP settings, etc.\)  
  
The admin and user experiences for installing the VPN profile using PowerShell scripts are discussed below.  
  
**Admin experience**  
  
-   Admin creates a PowerShell script and setup instructions. The PowerShell cmdlets to create the VPN profiles are very simple and comprise a few lines of code.  
  
    1.  PS examples, sample scripts & documentation are available on TechNet to help admins create scripts as per their network deployment.  
  
-   Admin delivers the script and instructions to users via email or a web portal. The admin needs to inform users to run the script again each time the script gets updated  
  
**User Experience**  
  
-   The user navigates to the web portal as instructed and logs\-in with his domain credentials.  
  
-   He simply clicks on the VPN configuration link and the setup script gets downloaded to the client device  
  
-   User clicks on the “Run” option from browser download UI and profile gets installed  
  
**Advanced Scenarios**  
  
Administrators can club many advanced configurations with this single\-click VPN provisioning script to provide a complete client provisioning story for users. These advanced settings could involve  
  
-   Deploying additional policies like IPsec, routes publishing or NAP for VPN connections  
  
-   Web\-proxy configuration for VPN connection  
  
-   Intranet settings for VPN connection  
  
-   Connection specific DNS Suffix plumbing for VPN connectionv  
  
### Provisioning via System Center  
On Windows RT devices, an integrated management client called **Company Apps** is available that can communicate with the management infrastructure and receive LOB apps and VPN connection configuration delivered by the System center.  
  
The IT Administrators can generate the VPN connection configuration XML and configure it with System Center manager to push down to the client devices enrolling for the service.  
  
The clients can browse to **Company Apps** \(in Control Panel\) and enroll for the device management infrastructure by using their domain credentials. On successful enrollment, System center management infrastructure pushes the VPN connection configuration information to the client device and the **Self\-Service Portal** agent \(on WindowsRT devices\) configures the VPN connection on the client device without any user intervention.  
  
The admin and user experiences for profile setup via SSP are discussed below.  
  
**Admin experience**  
  
1.  Open System Center management UI and configure VPN profile configuration XML for clients.  
  
2.  Admin can update the profile \(if needed\) again through System Center server management UI and no further action is required from user.  
  
**User experience**  
  
User needs self\-provisioning for WoA machine to get enrolled for the VPN setup.  
  
-   Authorized users navigates to the new Control Panel applet called Company apps on their WOA devices and provide their company email address and password.  
  
-   The SSP agent then automatically configures VPN and other features on the client device based on the instructions received from organization’s management infrastructure.  
  
> [!NOTE]  
> The above device management solution is not yet released. The release along with documentation is slated for Jan 2013.  
  
### Profile management  
After a VPN profile is created, it may need to be modified occasionally. This section describes common profile settings and how these settings can be modified by the administrator or the user.  
  
-   Edit and delete experiences for GCW profiles are described in the Windows 8 VPN – Get Connected TechNet article.  
  
-   For VPN profiles created using powershell scripts \(managed by the administrator\),  
  
    -   The administrator can create and share another single\-click script to remove the profile and corresponding settings from client device.  
  
    -   The new script may also be used to  
  
    -   Delete an existing VPN connection, and then provision a new one, or  
  
    -   Edit an existing connection, or add a new connection  
  
-   If the IT administrator wants to make any changes to the VPN profile deployed on client systems, he can simply create a new VPN profile configuration XML and update that in management infrastructure. The new VPN profile will be used for provisioning from then on.  
  
The Windows 8 VPN – Get Connected TechNet article provides more details on the client experience for VPN profile management.  
  
### Enabling split\-tunneling  
Split\-tunneling, which allows Internet\-bound traffic to bypass the VPN connection, can be set up as follows on Windows RT devices:  
  
##### To enable split\-tunneling  
  
1.  Navigate to **View Available Networks** by clicking on the network icon in taskbar and select the VPN connection  
  
2.  Right\-click the VPN connection and select **Properties** from the contex menu  
  
3.  Navigate to **Networking** tab; select **Internet Protocol Version 6 \(TCP\/IPv6\) or Internet Protocol Version 4 \(TCP\/IPv4\)** and click **Properties**.  
  
4.  In  **Properties** click **Advanced**.  
  
5.  Under **General** in **Advanced TCP\/IP settings**, unselect the option **Use default gateway on remote network to enable split\-tunneling**.  
  
Rather than the user executing the above steps, the administrator can also enable split\-tunneling using the configuration PowerShell cmdlet as described in this TechNet article.  
  
### Implications on routes  
For split\-tunneled VPN connections, the corporate network routes have to be configured on the client device after the VPN connection is established. The administrator can do this using one of the following two methods:  
  
**DHCP based routes publishing** – When a client is connected to the corporate network via a VPN connection, it gets its IP address from the DHCP server designated for the same purpose. This DHCP server can also supply the required routes along with other configuration.  
  
One\-click script \(scheduled tasks\) – The administrator can enable the configuration of routes through a script. The script adds a scheduled task in the client device, which is triggered every time the device establishes a connection with the remote VPN server, and plumbs the required routes on the client, enabling it to access corporate resources. If the administrator is already using a single\-click script to provision other settings \(IPSec policies, DNS suffix etc.\), then route\-provisioning can also be clubbed with the same script.  
  
### Provisioning web proxy and Intranet settings for VPN connection  
In the case of force\-tunneling, a web proxy needs to be configured on the Windows RT devices for them to be able to access Internet sites. Also, the intranet settings have to be enabled for a VPN connection to suppress repeated credential prompts while accessing intranet sites. The following sections discuss these configurations for Windows RT devices.  
  
**Web\-proxy**  
  
Force\-tunneling requires the VPN client to use corpnet web proxy for all the internet traffic. The administrator can either provide the required web proxy information to the users via e\-mail and have them configure the web\-proxy themselves, or he can configure a VPN\-specific web proxy by using a PowerShell cmdlet. This cmdlet can be included in the one\-click script used for VPN connection provisioning or can be distributed separately.  
  
**Intranet Settings**  
  
Enabling intranet settings is another requirement for accessing corporate sites without repeated credential prompts for the user while connected via a VPN connection. Intranet settings determine whether accessed web sites are a part of the local intranet zone and require domain credentails. If intranet settings are enabled for a VPN connection, the VPN credentials are automatically used for authenticating the user while accessing the local intranet sites.  
  
For unmanaged Windows RT devices, VPN connection is not automatically recognized and intranet settings are not turned ON by default. This results in a credentials prompt every time the user navigates to a local intranet site. To resolve this, users need to turn on the intranet settings by following the procedure below:  
  
##### To turn on intranet settings  
  
1.  Open **Internet Explorer**, and click **Tools**.  
  
2.  On the **Tools** menu, click **Internet options**, and then click the **Security** tab.  
  
3.  Click **Local Intranet**, and then click **Sites**.  
  
4.  In **Local Intranet**, clear the **Automatically detect intranet network** check box, and select the other three options. Click **OK** and then **Apply**.  
  
5.  Click **OK**, and then **Apply**.  
  
Alternatively, the administrator can configure certain registry settings on devices running Windows RT by using Windows PowerShell scripts when the client is connected to corporate network through the VPN.  
  
## Connect to the VPN  
The Get Connected Wizard is located in the **View Available Networks** UI \(with a few exceptions\). It provides a seamless connection experience for the user. Users do not need to specify the authentication or encryption protocols because they are negotiated with the server during the connection.  
  
For more information, see [Set Up and Edit VPN Connections in Windows 8](../Topic/Set-Up-and-Edit-VPN-Connections-in-Windows-8.md).  
  
### Use one\-time password for authentication  
An organization can use  one\-time password \(OTP\) authentication by completing the following configuration steps on clients and the server.  
  
**On clients**  
  
Configure the VPN client profile in Windows RT to use TTLS\-PAP authentication protocol. TTLS\-PAP is a password\-based, secure EAP method in Windows 8 that is used to transport the user’s user name and password, and the OTP token.  
  
**On servers**  
  
-   Install RSA Authentication Manager, and configure it to accept and process TTL\-PAP authentication requests.  
  
-   Configure the VPN server \(Microsoft RRAS or a third\-party server\) to redirect all authentication requests to RSA Authentication Manager.  
  
To authenticate with an OTP, the user enters the OTP user name and passcode for the VPN profile. The passcode is the user’s password followed by the OTP token code. TTLS\-PAP protocol accesses the RSA Authentication Manager, which authenticates the user name, password, and token code.  
  
> [!NOTE]  
> -   This method for OTP authentication is currently being validated by Microsoft on third\-party VPN servers.  
  
This  authentication method does not provide the following capabilities, which are offered by the regular RSA OTP authentication method.  
  
|Feature|Description|Workaround  or Solution|  
|-----------|---------------|---------------------------|  
|PIN changes|During first time authentication or PIN expiry, the user is required to set a new PIN. After the PIN is changed, the authentication is completed and the user is connected.|Use the RSA Security Center, which is a tool provided by RSA with the EAP client. The tool enables users to communicate with the RSA Authentication Manager directly and reset the PIN. The procedure is required to be completed inside the corporate network.|  
|Next token code|If user authentication succeeds after several failed attempts, the authentication manager challenges the user to enter the next token code that flashes on the device and validates it.|This feature can be disabled in the RSA Authentication Manager,  and then users do not have to enter the next token code.|  
  
