---
title: Troubleshooting Enabling Multisite
description: This topic is part of the guide Deploy Multiple Remote Access Servers in a Multisite Deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 570c81d6-c4f4-464c-bee9-0acbd4993584
ms.author: pashort
author: shortpatti
---
# Troubleshooting Enabling Multisite

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic contains troubleshooting information for issues related to the `Enable-DAMultisite` command. To confirm that the error you received is related to enabling multisite, check in the Windows Event log for the event ID 10051.  
  
## User connectivity issues  
Users may experience connectivity issues when you enable multisite if the configuration is not correct.  
  
**Cause**  
  
In a multisite deployment, Windows 10 and Windows 8 client computers are able to roam between different entry points.  Windows 7  client computers must be associated with a specific entry point in the multisite deployment. If client computers are not in the correct security group, they may receive the wrong group policy settings.  
  
**Solution**  
  
DirectAccess requires at least one security group for all Windows 10 and Windows 8 client computers; we recommend using one security group for all Windows 10 and Windows 8 computers per domain. DirectAccess also requires a security group for  Windows 7  client computers for each entry point. Each client computer should be included in only one security group. Therefore, you should make sure that the security groups for Windows 10 and Windows 8 clients contain only computers running Windows 10 or Windows 8, and that each  Windows 7  client computer belongs to a single dedicated security group for the relevant entry point and that no Windows 10 or Windows 8 clients belong to the  Windows 7  security groups.  
  
Configure the Windows 8 security groups on the **Select Groups** page of the **DirectAccess Client Setup** wizard. Configure  Windows 7  security groups on the **Client Support** page of the **Enable Multisite Deployment** wizard, or on the **Client Support** page of the **Add an Entry Point** wizard.  
  
## Kerberos proxy authentication  
**Error received**. Kerberos proxy authentication is not supported in a multisite deployment. You must enable the use of computer certificates for IPsec user authentication.  
  
**Cause**  
  
Computer certificate authentication must be enabled before enabling multisite.  
  
**Solution**  
  
To enable computer certificate authentication:  
  
1.  In the Remote Access Management console, in the details pane, under **Step 2 Remote Access Server**, click **Edit**.  
  
2.  In the **Remote Access Server Setup** wizard, on the **Authentication** page, select the **Use computer certificates** check box, and select the root or intermediate certification authority that issues certificates in your deployment.  
  
To enable computer certificate authentication using Windows PowerShell, use the `Set-DAServer` cmdlet and specify the *IPsecRootCertificate* parameter.  
  
## IP-HTTPS certificates  
**Error received**. The DirectAccess server uses a self-signed IP-HTTPS certificate. Configure IP-HTTPS to use a signed certificate from a known CA.  
  
**Cause**  
  
The IP-HTTPS certificate is self-signed. You cannot use self-signed certificates in a multisite deployment.  
  
**Solution**  
  
To select an IP-HTTPS certificate:  
  
1.  In the Remote Access Management console, in the details pane, under **Step 2 Remote Access Server**, click **Edit**.  
  
2.  In the **Remote Access Server Setup** wizard, on the **Network Adapters** page, under **Select the certificate used to authenticate IP-HTTPS connections**, make sure the **Use a self-signed certificate created automatically by DirectAccess** check box is cleared, and click **Browse** to select a certificate issued by a trusted CA.  
  
## Network location server  
  
-   **Issue 1**  
  
    **Error received**. DirectAccess is configured to use a self-signed certificate for the network location server. Configure the network location server to use a signed certificate from a CA.  
  
    **Cause**  
  
    The network location server is deployed on the Remote Access server and uses a self-signed certificate. You cannot use self-signed certificates in a multisite deployment.  
  
    **Solution**  
  
    To select a network location server certificate:  
  
    1.  In the Remote Access Management console, in the details pane, under **Step 3 Infrastructure Servers**, click **Edit**.  
  
    2.  In the **Infrastructure Server Setup** wizard, on the **Network Location Server** page, under **The network location server is deployed on the Remote Access server**, make sure the **Use a self-signed certificate** check box is cleared, and click **Browse** to select a certificate issued by an Enterprise CA.  
  
-   **Issue 2**  
  
    **Error received**. To deploy a network load balanced cluster or multisite deployment, obtain a certificate for the network location server with a subject name that is different from the internal name of the Remote Access server.  
  
    **Cause**  
  
    The subject name of the certificate used for the network location server website is the same as the internal name of the Remote Access server. This will cause name resolution issues.  
  
    **Solution**  
  
    Obtain a certificate with a subject name that is not the same as the internal name of the Remote Access server.  
  
    To configure the network location server:  
  
    1.  In the Remote Access Management console, in the details pane, under **Step 3 Infrastructure Servers**, click **Edit**.  
  
    2.  In the **Infrastructure Server Setup** wizard, on the **Network Location Server** page, under **The network location server is deployed on the Remote Access server**, click **Browse** to select the certificate you previously obtained. The certificate must have a subject name that is different from the internal name of the Remote Access server.  
  
## Windows 7 client computers  
**Warning received**. When enabling multisite, the security groups configured for DirectAccess clients must not contain Windows 7 computers. To support Windows 7 client computers in a multisite deployment, select a security group containing the clients for each entry point.  
  
**Cause**  
  
In the existing DirectAccess deployment,  Windows 7  client support was enabled.  
  
**Solution**  
  
DirectAccess requires at least one security group for all Windows 8 client computers and a security group for  Windows 7  client computers for each entry point. Each client computer should be included in only one security group. Therefore, you should make sure that the security group for Windows 8 clients contains only computers running Windows 8, and that each  Windows 7  client computer belongs to a single dedicated security group for the relevant entry point and that no Windows 8 clients belong to the  Windows 7  security groups.  
  
## Active Directory site  
**Error received**. The server <server_name> is not associated with an Active Directory Site.  
  
**Cause**  
  
DirectAccess could not determine the Active Directory site. In the Active Directory Sites and Services console you can configure the different subnets for your network and associate each subnet with the relevant Active Directory site. This error may occur if the IP address of the Remote Access server does not belong to any of the subnets, or that the subnet to which the IP address belongs is not defined with an Active Directory site.  
  
**Solution**  
  
Confirm that this is the issue by running the command `nltest /dsgetsite` on your Remote Access server. If this is the issue, the command will return ERROR_NO_SITENAME. To solve this issue, on your domain controller, make sure that a subnet which contains the internal server IP address exists and that it is defined with an Active Directory site.  
  
## <a name="SaveGPOSettings"></a>Saving server GPO settings  
**Error received**. An error occurred while saving Remote Access settings to GPO <GPO_name>.  
  
**Cause**  
  
Changes to the server GPO couldn't be saved either due to connectivity issues or if there is a sharing violation on the registry.pol file, for example, another user has locked the file.  
  
**Solution**  
  
Make sure that there is connectivity between the Remote Access server and the domain controller. If there is connectivity, check on the domain controller if the registry.pol file is locked to another user, and if necessary, end that user session to unlock the file.  
  
## <a name="InternalServerError"></a>Internal error occurred  
**Error received**. An internal error occurred.  
  
**Cause**  
  
This may be caused by an unexpected entry point table configuration in the client GPO. This can occur if the administrator uses DirectAccess client cmdlets to edit the entry point table in the client GPO.  
  
**Solution**  
  
Review the entry point table configuration in all client GPOs and fix any inconsistencies in the multisite configuration between the different instances of the client GPOs and the DirectAccess configuration. Use the `Get-DaEntryPointTableItem` cmdlet with the name of the client GPO to get the entry point table on the client. Use the `Get-NetIPHttpsConfiguration` cmdlet to get all the IP-HTTPS profiles for all the entry points.  
  
For further information, see [DirectAccess Client Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/hh848426).  
  


