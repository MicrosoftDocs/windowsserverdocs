---
title: DirectAccess Unsupported Configurations
description: This topic provides a list of unsupported DirectAccess configurations in Windows Server 2016.
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking-da
ms.topic: article
ms.assetid: 23d05e61-95c3-4e70-aa83-b9a8cae92304
ms.author: pashort
author: shortpatti
---
# DirectAccess Unsupported Configurations

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Review the following list of unsupported DirectAccess configurations before you start your deployment to avoid having to start your deployment again.  

## <a name="bkmk_frs"></a>File Replication Service (FRS) distribution of Group Policy objects (SYSVOL replications)  
Do not deploy DirectAccess in environments where your domain controllers are running the File Replication Service (FRS) for distribution of Group Policy objects (SYSVOL replications). Deployment of DirectAccess is not supported when you use FRS.  
  
You are using FRS if you have domain controllers that are running Windows Server 2003 or Windows Server 2003 R2. In addition, you might be using FRS if you previously used Windows 2000 Server or Windows Server 2003 domain controllers and you never migrated SYSVOL replication from FRS to Distributed File System Replication (DFS-R).  
  
If you deploy DirectAccess with FRS SYSVOL replication, you risk the unintentional deletion of DirectAccess Group Policy objects that contain the DirectAccess server and client configuration information. If these objects are deleted, your DirectAccess deployment will suffer an outage, and client computers that use DirectAccess will not be able to connect to your network.  
  
If you are planning to deploy DirectAccess, you must use domain controllers that are running operating systems later than Windows Server 2003 R2, and you must use DFS-R.  
  
For information on migrating from FRS to DFS-R, see the [SYSVOL Replication Migration Guide: FRS to DFS Replication](https://technet.microsoft.com/library/dd640019(v=ws.10).aspx).  
  
## <a name="bkmk_nap"></a>Network Access Protection for DirectAccess clients  
Network Access Protection (NAP) is used to determine whether remote client computers meet IT policies before they are granted access to the corporate network. NAP was deprecated in Windows Server 2012 R2 and is not included in Windows Server 2016. For this reason, starting a new deployment of DirectAccess with NAP is not recommended. A different method of end point control for the security of DirectAccess clients is recommended.  
  
## <a name="bkmk_multi"></a>Multisite support for Windows 7 clients  
When DirectAccess is configured in a multisite deployment, Windows 10&reg;, Windows&reg; 8.1, and Windows&reg; 8 clients have the capability of connecting to the nearest site.  Windows 7&reg;  client computers do not have the same capability. Site selection for  Windows 7  clients is set to a particular site at the time of policy configuration, and these clients will always connect to that designated site, regardless of their location.  
  
## <a name="bkmk_user"></a>User-based access control  
DirectAccess policies are computer based, not user based. Specifying DirectAccess user policies to control access to the corporate network is not supported.  
  
## <a name="bkmk_policy"></a>Customizing DirectAccess policy  
DirectAccess can be configured by using the DirectAccess Setup Wizard, the Remote Access Management console, or the Remote Access Windows PowerShell cmdlets. Using any means other than the DirectAccess Setup Wizard to configure DirectAccess, such as modifying DirectAccess Group Policy Objects directly or manually modifying the default policy settings on the server or client, is not supported. These modifications may result in an unusable configuration.  
  
## <a name="bkmk_kerb"></a>KerbProxy authentication  
When you configure a DirectAccess server with the Getting Started Wizard, the DirectAccess server is automatically configured to use KerbProxy authentication for computer and user authentication. Because of this, you should only use the Getting Started Wizard for single-site deployments where only Windows 10&reg;, Windows 8.1, or Windows 8 clients are deployed.  
  
In addition, the following features should not be used with KerbProxy authentication:  
  
-   Load balancing by using either an external load balancer or Windows Load   
    Balancer  
  
-   Two-factor authentication where smart cards or a one-time password (OTP) are required  
  
The following deployment plans are not supported if you enable KerbProxy authentication:  
  
-   Multisite.  
  
-   DirectAccess support for  Windows 7  clients.  
  
-   Force tunneling. To ensure that KerbProxy authentication is not enabled when you use force tunneling, configure the following items while running the wizard:  
  
    -   Enable force tunneling  
  
    -   Enable DirectAccess for  Windows 7  clients  
  
> [!NOTE]  
> For the previous deployments, you should use the Advanced Configuration Wizard, which uses a two-tunnel configuration with a certificate-based computer and user authentication. For more information, see [Deploy a Single DirectAccess Server with Advanced Settings](../../remote-access/directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md).  
  
## <a name="bkmk_isa"></a>Using ISATAP  
ISATAP is a transition technology that provides IPv6 connectivity in IPv4-only corporate networks. It is limited to small- and medium-sized organizations with a single DirectAccess server deployment, and it allows remote management of DirectAccess clients. If ISATAP is deployedin a multisite, load balancing, or multidomain environment, you must remove it or move it to a native IPv6 deployment before you configure DirectAccess.  
  
## <a name="bkmk_iphttps"></a>IPHTTPS and one-time password (OTP) endpoint configuration  
When you use IPHTTPS, the IPHTTPS connection must terminate on the DirectAccess server, not on any other device, such as a load balancer. Similarly, the out-of-band Secure Sockets Layer (SSL) connection that is created during one-time password (OTP) authentication must terminate on the DirectAccess server. All devices between the endpoints of these connections must be configured in pass-through mode.  
  
## <a name="bkmk_ft"></a>Force Tunnel with OTP authentication  
Do not deploy a DirectAccess server with two-factor authentication with OTP and Force Tunneling, or OTP authentication will fail. An out-of-band Secure Sockets Layer (SSL) connection is required between the DirectAccess server and the DirectAccess client. This connection requires an exemption to send the traffic outside of the DirectAccess tunnel. In a Force Tunnel configuration, all traffic must flow through a DirectAccess tunnel, and no exemption is allowed after the tunnel is established. Because of this, it is not supported to have OTP authentication in a Forced Tunnel configuration.  
  
## <a name="bkmk_rodc"></a>Deploying DirectAccess with a Read-Only Domain Controller  
DirectAccess servers must have access to a read-write domain controller, and do not function correctly with a Read-Only Domain Controller (RODC).  
  
A read-write domain controller is required for many reasons, including the following:  
  
-   On the DirectAccess server, a read-write domain controller is required to open the Remote Access Microsoft Management Console (MMC).  
  
-   The DirectAccess server must both read and write to the DirectAccess client and DirectAccess server Group Policy Objects (GPOs).  
  
-   The DirectAccess server reads and writes to the client GPO specifically from the Primary Domain Controller emulator (PDCe).  
  
Because of these requirements, do not deploy DirectAccess with an RODC.  
  


