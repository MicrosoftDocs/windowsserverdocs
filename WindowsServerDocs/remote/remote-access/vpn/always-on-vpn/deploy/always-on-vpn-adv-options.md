---
title: Advanced Features of Always On VPN
description: 'Beyond the deployment scenario provided in this deployment, you can add other advanced VPN features to improve the security and availability of your VPN connection.'
ms.assetid: 51a1ee61-3ffe-4f65-b8de-ff21903e1e74
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.date: 07/24/2019
ms.author: lizross, v-tea
author: eross-msft
ms.localizationpriority: medium 
ms.reviewer: deverette
---
# Advanced features of Always On VPN

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Learn about the Always On VPN technology](../always-on-vpn-technology-overview.md)
- [**Next:** Start planning the Always On VPN deployment](always-on-vpn-deploy-planning.md)

Beyond the deployment scenarios that are provided, you can add other advanced VPN features to improve the security and availability of your VPN connection. For example, the VPN server can use these features to help make sure that the connecting client is healthy before it allows a connection.

## High Availability

The following are additional options for high availability.

|Option  |Description  |
|---------|---------|
|Server resilience and load balancing     |In environments that require high availability or that support large numbers of requests, you can increase the performance and resiliency of Remote Access by using load balancing between multiple servers that are running Network Policy Server (NPS) and enabling Remote Access server clustering.<p>Related documents:<ul><li>[NPS Proxy Server Load Balancing](../../../../../networking/technologies/nps/nps-manage-proxy-lb.md)</li><li>[Deploy Remote Access in a Cluster](https://docs.microsoft.com/windows-server/remote/remote-access/ras/cluster/deploy-remote-access-in-cluster)</li></ul>        |
|Geographic site resilience     |For IP-based geolocation, you can use Global Traffic Manager with DNS in Windows Server 2016. For more robust geographic load balancing, you can use Global Server Load Balancing solutions, such as Microsoft Azure Traffic Manager.<p>Related documents:<ul><li>[Overview of Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview)</li><li>[Microsoft Azure Traffic Manager](https://azure.microsoft.com/services/traffic-manager)</li></ul>         |

## Advanced Authentication

The following are additional options for authentication.

|Option  |Description  |
|---------|---------|
|Windows Hello for Business     |In Windows 10, Windows Hello for Business replaces passwords by providing strong two-factor authentication on PCs and mobile devices. This authentication consists of a new type of user credential that is tied to a device and uses a biometric or Personal Identification Number (PIN).<p>The Windows 10 VPN client is compatible with Windows Hello for Business. After the user logs in by using a gesture, the VPN connection uses the Windows Hello for Business certificate for certificate-based authentication.<p>Related documents:<ul><li>[Windows Hello for Business](https://docs.microsoft.com/windows/access-protection/hello-for-business/hello-identity-verification)</li><li>Technical Case Study: [Enabling Remote Access with Windows Hello for Business in Windows 10](https://msdn.microsoft.com/library/mt728163.aspx)</li></ul>         |
|Azure Multifactor Authentication (MFA)     |Azure MFA has cloud and on-premises versions that you can integrate with the Windows VPN authentication mechanism.<p>For more information about how this mechanism works, see [Integrate RADIUS authentication with Azure Multi-Factor Authentication Server](https://docs.microsoft.com/azure/multi-factor-authentication/multi-factor-authentication-get-started-server-radius).         |

## Advanced VPN Features

The following are additional options for advanced features.

|Option  |Description  |
|---------|---------|
|Traffic filtering     |If you have to enforce the choice of which applications VPN clients can access, you can enable VPN Traffic Filters.<p>For more information, see [VPN security features](https://docs.microsoft.com/windows/access-protection/vpn/vpn-security-features).         |
|App-triggered VPN     |You can configure VPN profiles to connect automatically when certain applications or types of applications start.<p>For more information about this and other triggering options, see [VPN auto-triggered profile options](https://docs.microsoft.com/windows/access-protection/vpn/vpn-auto-trigger-profile).         |
|VPN conditional access   |Conditional access and device compliance can require managed devices to meet standards before they can connect to the VPN. One of the advanced features for VPN conditional access allows you to restrict the VPN connections to only those on which the client authentication certificate contains the "AAD Conditional Access" OID of **1.3.6.1.4.1.311.87**.<p>To restrict the VPN connections, you have to do the following:<ol><li>On the NPS server, open the **Network Policy Server** snap-in.</li><li>Expand **Policies** > **Network Policies**.</li><li>Right-click the **Virtual Private Network (VPN) Connections** Network Policy and select **Properties**.</li><li>Select the **Settings** tab.</li><li>Select **Vendor Specific**, and then select **Add**.</li><li>Select the **Allowed-Certificate-OID** option, and then select **Add**.</li><li>Paste the AAD Conditional Access OID of **1.3.6.1.4.1.311.87** as the attribute value, and then select **OK** two times.</li><li>Select **Close**, and then select **Apply**.<p>After you follow these steps, when VPN clients try to connect by using any certificate other than the short-lived cloud certificate, the connection fails.</li></ol>For more information about conditional access, see [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access).   |


---
## Blocking VPN Clients that Use Revoked Certificates
  
After you install updates, the RRAS server can enforce certificate revocation for VPNs that use IKEv2 and machine certificates for authentication, such as device tunnel Always-on VPNs. This means that for such VPNs, the RRAS server can deny VPN connections to clients that try to use a revoked certificate.

**Availability**

The following table lists the releases that contain the fixes for each version of Windows.

|Operating system version |Release  |
|---------|---------|
|Windows Server, version 1903  |[KB4501375](https://support.microsoft.com/help/4501375/windows-10-update-kb4501375) |
|Windows Server 2019<br />Windows Server, version 1809  |[KB4505658](https://support.microsoft.com/help/4505658/windows-10-update-kb4505658)  |
|Windows Server, version 1803  |[KB4507466](https://support.microsoft.com/help/4507466/windows-10-update-kb4507466)  |
|Windows Server, version 1709  |[KB4507465](https://support.microsoft.com/help/4507465/windows-10-update-kb4507465)  |
|Windows Server 2016, version 1607  |[KB4503294](https://support.microsoft.com/help/4503294/windows-10-update-kb4503294) |

**How to configure prerequisites** 

1. Install the Windows updates as they become available.
1. Make sure that all the VPN client and RRAS server certificates that you use have CDP entries, and that the RRAS server can reach the respective CRLs.
1. On the RRAS server, use the **Set-VpnAuthProtocol** PowerShell cmdlet to configure the **RootCertificateNameToAccept** parameter.<br /><br />
   The following example lists the commands to do this. In the example, **CN=Contoso Root Certification Authority** represents the distinguished name of the Root Certification Authority. 
   ``` powershell
   $cert1 = ( Get-ChildItem -Path cert:LocalMachine\root | Where-Object -FilterScript { $_.Subject -Like "*CN=Contoso Root Certification Authority*" } )
   Set-VpnAuthProtocol -RootCertificateNameToAccept $cert1 -PassThru
   ```
**How to configure the RRAS server to enforce certificate revocation for VPN connections that are based on IKEv2 machine certificates**

1. In a Command Prompt window, run the following command: 
   ```
   reg add HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess\Parameters\Ikev2 /f /v CertAuthFlags /t REG_DWORD /d "4"
   ```

1. Restart the **Routing and Remote Access** service.
  
To disable certificate revocation for these VPN connections, set **CertAuthFlags = 2** or remove the **CertAuthFlags** value, and then restart the **Routing and Remote Access** service. 

**How to revoke a VPN client certificate for a VPN connection that is based on an IKEv2 machine certificate**
1. Revoke the VPN client certificate from the Certification Authority.
1. Publish a new CRL from the Certification Authority.
1. On the RRAS server, open an administrative Command Prompt window, and then run the following commands:
   ```
   certutil -urlcache * delete
   certutil -setreg chain\ChainCacheResyncFiletime @now
   ```

**How to verify that certificate revocation for IKEv2 machine certificate-based VPN connections is working**  
>[!Note]  
> Before you use this procedure, make sure that you enable the CAPI2 operational event log.
1. Follow the previous steps to revoke a VPN client certificate.
1. Try to connect to the VPN by using a client that has the revoked certificate. The RRAS server should refuse the connection and display a message such as “IKE authentication credentials are unacceptable.”
1. On the RRAS server, open Event Viewer, and navigate to **Applications and Services Logs/Microsoft/Windows/CAPI2**. 
1. Search for an event that has the following information:
   * Log Name: **Microsoft-Windows-CAPI2/Operational Microsoft-Windows-CAPI2/Operational**
   * Event ID: **41** 
   * The event contains the following text: **subject="*Client FQDN*"** (*Client FQDN* represents the fully qualified domain name of the client that has the revoked certificate.) 

   The **<Result>** field of the event data should include **The certificate is revoked**. For example, see the following excerpts from an event:
   ```xml
   Log Name:      Microsoft-Windows-CAPI2/Operational Microsoft-Windows-CAPI2/Operational  
   Source:        Microsoft-Windows-CAPI2  
   Date:          5/20/2019 1:33:24 PM  
   Event ID:      41  
   ...  
   Event Xml:
   <Event xmlns="https://schemas.microsoft.com/win/2004/08/events/event">
    <UserData>  
     <CertVerifyRevocation>  
	  <Certificate fileRef="C97AE73E9823E8179903E81107E089497C77A720.cer" subjectName="client01.corp.contoso.com" />  
      <IssuerCertificate fileRef="34B1AE2BD868FE4F8BFDCA96E47C87C12BC01E3A.cer" subjectName="Contoso Root Certification Authority" />
      ...
      <Result value="80092010">The certificate is revoked.</Result>
     </CertVerifyRevocation>
    </UserData>
   </Event>
   ```

---
## Additional Protection

### Trusted Platform Module (TPM) Key Attestation

A user certificate that has a TPM-attested key provides higher security assurance, backed up by non-exportability, anti-hammering, and isolation of keys provided by the TPM.

For more information about TPM key attestation in Windows 10, see [TPM Key Attestation](https://docs.microsoft.com/windows-server/identity/ad-ds/manage/component-updates/tpm-key-attestation).

## Next step

[Start planning the Always On VPN deployment](always-on-vpn-deploy-planning.md): Before you install the Remote Access server role on the computer that you plan to use as a VPN server, do the following tasks. After appropriate planning, you can deploy Always On VPN, and optionally configure conditional access for VPN connectivity using Azure AD.  

## Related topics
- [NPS Proxy Server Load Balancing](../../../../../networking/technologies/nps/nps-manage-proxy-lb.md): Remote Authentication Dial-In User Service (RADIUS) clients, which are network access servers such as virtual private network (VPN) servers and wireless access points, create connection requests and send them to RADIUS servers such as NPS. In some cases, an NPS server might receive too many connection requests at one time, resulting in degraded performance or an overload.

- [Overview of Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview): This topic provides an overview of Azure Traffic Manager, which allows you to control the distribution of user traffic for service endpoints. Traffic Manager uses the Domain Name System (DNS) to direct client requests to the most appropriate endpoint based on a traffic-routing method and the health of the endpoints. 

- [Windows Hello for Business](https://docs.microsoft.com/windows/access-protection/hello-for-business/hello-identity-verification): This topic provides the prerequisites, such as cloud only deployments and hybrid deployments.  This topic also lists frequently asked questions about Windows Hello for Business.

- [Technical case study: Enabling Remote Access with Windows Hello for Business in Windows 10](https://msdn.microsoft.com/library/mt728163.aspx): In this technical case study you learn how Microsoft implements remote access with Windows Hello for Business.  Windows Hello for Business is a private/public key or certificate-based authentication approach for organizations and consumers that goes beyond passwords. This form of authentication relies on key pair credentials that can replace passwords and are resistant to breaches, thefts, and phishing. 

- [Integrate RADIUS authentication with Azure Multi-Factor Authentication Server](https://docs.microsoft.com/azure/multi-factor-authentication/multi-factor-authentication-get-started-server-radius): This topic walks you through adding and configuring a RADIUS client authentication with Azure Multi-Factor Authentication Server. RADIUS is a standard protocol to accept authentication requests and to process those requests. The Azure Multi-Factor Authentication Server can act as a RADIUS server. 

- [VPN security features](https://docs.microsoft.com/windows/access-protection/vpn/vpn-security-features): This topic provides you VPN security guidelines for LockDown VPN, Windows Information Protection (WIP) integration with VPN, and traffic filters. 

- [VPN auto-triggered profile options](https://docs.microsoft.com/windows/access-protection/vpn/vpn-auto-trigger-profile): This topic provides you VPN auto-triggered profile options, such as app trigger, name-based trigger, and Always On.

- [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access): This topic provides you an overview of cloud-based Conditional Access Platform to provide a device compliance option for remote clients. Conditional Access is a policy-based evaluation engine that lets you create access rules for any Azure Active Directory (Azure AD) connected application. 

- [TPM Key Attestation](https://docs.microsoft.com/windows-server/identity/ad-ds/manage/component-updates/tpm-key-attestation): This topic provides you an overview of Trusted Platform Module (TPM) and steps to deploy TPM key attestation. You can also find troubleshooting information and steps to resolve issues.
