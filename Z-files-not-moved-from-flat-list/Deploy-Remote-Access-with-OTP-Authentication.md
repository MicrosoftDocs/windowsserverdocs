---
title: Deploy Remote Access with OTP Authentication
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 808af247-bd15-4e24-acb7-7287916d12f2
author: coreyp
---
# Deploy Remote Access with OTP Authentication
[!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)] and [!INCLUDE[win8_server_1](includes/win8_server_1_md.md)] combine DirectAccess and Routing and Remote Access Service (RRAS) VPN into a single Remote Access role.   
  
  
## <a name="BKMK_OVER"></a>Scenario description  
In this scenario a Remote Access server with DirectAccess enabled is configured to authenticate DirectAccess client users with two-factor OTP authentication, in addition to standard Active Directory credentials.  
  
## Prerequisites  
Before you begin deploying this scenario, review this list for important requirements:  
  
-   [Deploy a single Remote Access server with advanced settings](assetId:///3475e527-541f-4a34-b940-18d481ac59f6) must be deployed before deploying OTP.  
  
-   Windows 7 Clients need to use DCA 2.0 to support OTP.  
  
-   OTP does not support PIN change.  
  
-   A Public Key Infrastructure must be deployed.  
  
    For more information see: [Test Lab Guide Mini-Module: Basic PKI for Windows Server 2012.](http://social.technet.microsoft.com/wiki/contents/articles/7862.test-lab-guide-mini-module-basic-pki-for-windows-server-2012.aspx)  
  
-   Changing policies outside of the DirectAccess management console or PowerShell cmdlets is not supported.  
  
## In this scenario  
The OTP authentication scenario includes a number of steps:  
  
1.  **[Plan and deploy a single server](assetId:///3475e527-541f-4a34-b940-18d481ac59f6)**—A single Remote Access server must be deployed before configuring OTP. Planning and deploying a single server includes designing and configuring a network topology, planning and deploying certificates, setting up DNS and Active Directory, configuring Remote Access server settings, deploying DirectAccess clients, and preparing intranet servers.  
  
2.  **[Plan an OTP deployment](assetId:///b38c88ae-e863-44e2-8338-f1c4daaea9ae)**—In addition to the planning required for a single server, OTP requires planning for a Microsoft certification authority (CA) and certificate templates for OTP; and a RADIUS-enabled OTP server. Planning might also include a requirement for security groups to exempt specific users from strong (OTP or smart card) authentication. For information regarding the configuration of OTP in a multi-forest environment, see [Configure a multi-forest deployment](assetId:///79404dbc-1e3d-4524-aad0-3422c56ed31b).  
  
3.  **[Deploy OTP](assetId:///bde70218-fcef-4ff5-ac78-31319cc2ea16)**—OTP deployment consists of a number of configuration steps, including preparing the infrastructure for OTP authentication, configuring the OTP server, configuring OTP settings on the Remote Access server, and updating DirectAccess client settings.  
  
4.  **[Troubleshoot an OTP Deployment](assetId:///6c02b193-15c1-484f-8f1c-75cd9aa0a377)**—This troubleshooting section describes a number of the most common errors that can occur when deploying Remote Access with OTP authentication.  
  
## <a name="BKMK_APP"></a>Practical applications  
Increase security—Using OTP increases the security of your DirectAccess deployment. A user requires OTP credentials in order to gain access to the internal network. A user supplies OTP credentials via the Workplace Connections available in the network connections on the [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] client computer, or using DirectAccess Connectivity Assistant (DCA) on client computers running Windows 7. The OTP authentication process works as follows:  
  
1.  The DirectAccess client enters domain credentials to access DirectAccess infrastructure servers (over the infrastructure tunnel).  If no connection to the internal network is available, due to a specific IKE failure, Workplace Connection on the client computer notifies the user that credentials are required. On client computers running Windows 7, a pop-up requesting smart card credentials appears.  
  
2.  After the OTP credentials have been entered, they are sent over SSL to the Remote Access server, together with a request for a short-term smart card logon certificate.  
  
3.  The Remote Access server initiates validation of the OTP credentials with the RADIUS-based OTP server.  
  
4.  If successful, the Remote Access server signs the certificate request using its registration authority certificate, and sends it back to the DirectAccess client computer  
  
5.  The DirectAccess client computer forwards the signed certificate request to the CA and stores the enrolled certificate for use by the Kerberos SSP/AP.  
  
6.  Using this certificate the client computer transparently performs standard smart card Kerberos authentication.  
  
## <a name="BKMK_NEW"></a>Roles and features included in this scenario  
The following table lists the roles and features required for the scenario:  
  
|Role/feature|How it supports this scenario|  
|-----------------|---------------------------------|  
|*Remote Access Management role*|The role is installed and uninstalled using the Server Manager console. This role encompasses both DirectAccess, which was previously a feature in Windows Server 2008 R2, and Routing and Remote Access Services which was previously a role service under the Network Policy and Access Services (NPAS) server role. The Remote Access role consists of two components:<br /><br />1.  DirectAccess and Routing and Remote Access Services (RRAS) VPN—DirectAccess and VPN are managed together in the Remote Access Management console.<br />2.  RRAS Routing—RRAS routing features are managed in the legacy Routing and Remote Access console.<br /><br />The Remote Access role is dependent on the following server features:<br /><br />-   Internet Information Services (IIS) Web Server – This feature is required to configure the network location server, utilize OTP authentication, and configure the default web probe.<br />-   Windows Internal Database—Used for local accounting on the Remote Access server.|  
|Remote Access Management Tools feature|This feature is installed as follows:<br /><br />-   It is installed by default on a Remote Access server when the Remote Access role is installed, and supports the Remote Management console user interface.<br />-   It can be optionally installed on a server not running the Remote Access server role. In this case it is used for remote management of a Remote Access computer running DirectAccess and VPN.<br /><br />The Remote Access Management Tools feature consists of the following:<br /><br />-   Remote Access GUI and Command Line Tools<br />-   Remote Access module for Windows PowerShell<br /><br />Dependencies include:<br /><br />-   Group Policy Management Console<br />-   RAS Connection Manager Administration Kit (CMAK)<br />-   Windows PowerShell 3.0<br />-   Graphical Management Tools and Infrastructure|  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements for this scenario include the following:  
  
-   A computer that meets the hardware requirements for [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)].  
  
-   In order to test the scenario, at least one computer running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or Windows 7 configured as a DirectAccess client is required.  
  
-   An OTP server that supports PAP over RADIUS.  
  
-   An OTP hardware or software token.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
There are a number of requirements for this scenario:  
  
1.  Software requirements for single server deployment. For more information, see [Deploy a single Remote Access server with advanced settings](assetId:///3475e527-541f-4a34-b940-18d481ac59f6).  
  
2.  In addition to software requirements for a single server there are a number of OTP-specific requirements:  
  
    1.  CA for IPsec authentication—In an OTP deployment DirectAccess must be deployed using IPsec machines certificates issued by a CA. IPsec authentication using the Remote Access server as a Kerberos proxy is not supported in an OTP deployment. An internal CA is required.  
  
    2.  CA for OTP authentication—A Microsoft Enterprise CA (running on Windows 2003 Server or later) is required to issue the OTP client certificate. The same CA used for issuing certificates for IPsec authentication can be used. The CA server must be available over the first infrastructure tunnel.  
  
    3.  Security group—To exempt users from strong authentication, an Active Directory security group containing these users is required.  
  
    4.  Client-side requirements—For [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] client computers, the Network Connectivity Assistant (NCA) service is used to detect whether OTP credentials are required. If they are the DirectAccess Media Manager prompts for credentials.  NCA is included in the [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] operating system, and no installation or deployment is required. For Windows 7 client computers DirectAccess Connectivity Assistant (DCA) 2.0 is required. This is available as a download on the [Microsoft Download Center](http://www.microsoft.com/download/details.aspx?id=29039).  
  
    5.  Note the following:  
  
        1.  OTP authentication can be used in parallel with smart card and Trusted Platform Module (TPM)-based authentication. Enabling OTP authentication in the Remote Access Management console also enables use of smartcard authentication.  
  
        2.  During Remote Access configuration users in a specified security group can be exempt from two-factor authentication, and thus authenticate with username/password only.  
  
        3.  OTP new PIN and next tokencode modes are not supported  
  
        4.  In a Remote Access multisite deployment, OTP settings are global and identify for all entry points. If multiple RADIUS or CA servers are configured for OTP, they are sorted by each Remote Access server according to availability and proximity.  
  
        5.  When configuring OTP in a Remote Access multi-forest environment, OTP CAs should be from the resource forest only, and certificate enrollment should be configured across forest trusts. For more information, see [AD CS: Cross-forest Certificate Enrollment with Windows Server 2008 R2](http://technet.microsoft.com/library/ff955842(WS.10).aspx).  
  
        6.  Users who are using a KEY FOB OTP token should insert the PIN followed by the tokencode (without any separators) in the DirectAccess OTP dialog. Users who are using PIN PAD OTP token should insert only the tokencode in the dialog.  
  
        7.  When the WEBDAV is enabled then OTP should not be enabled.  
  
## <a name="KnownIssues"></a>Known Issues  
The following are known issues when configuring an OTP scenario:  
  
-   Remote Access uses a probe mechanism to verify connectivity to RADIUS-based OTP servers. In some cases this might cause an error to be issued on the OTP server. To avoid this issue, do the following on the OTP server:  
  
    -   Create a user account that matches the username and password configured on the Remote Access server for the probe mechanism. The username should not define an Active Directory user.  
  
        By default the username on the Remote Access server is DAProbeUser and the password is DAProbePass. These default settings can be modified using the following values in the registry on the Remote Access server:  
  
        -   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectAccess\OTP\RadiusProbeUser  
  
        -   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectAccess\OTP\ RadiusProbePass  
  
-   If you change the IPsec root certificate in a configured and running DirectAccess deployment, OTP stops working. To resolve this issue, on each DirectAccess server, in a [!INCLUDE[wps_2](includes/wps_2_md.md)] window, run the command: `iisreset`  
  

