---
manager: amycolannino
ms.assetid: b7bf7579-ca53-49e3-a26a-6f9f8690762f
title: Best Practices for securing AD FS and Web Application Proxy
description: Best practices for the secure planning and deployment of Active Directory Federation Services (AD FS) and Web Application Proxy.
author: billmath
ms.author: billmath
ms.date: 08/15/2023
ms.topic: article
---

# Best practices for securing Active Directory Federation Services

This document provides best practices for the secure planning and deployment of Active Directory Federation Services (AD FS) and Web Application Proxy (WAP). It contains recommendations for additional security configurations, specific use cases, and security requirements.

This document applies to AD FS and WAP in Windows Server 2012 R2, 2016, and 2019. These recommendations can be used for either an on-premises network or in a cloud hosted environment such as Microsoft Azure.

## Standard deployment topology

For deployment in on-premises environments, we recommend a standard deployment topology consisting of:

- One or more AD FS servers on the internal corporate network.
- One or more Web Application Proxy (WAP) servers in a DMZ or extranet network.  

At each layer, AD FS and WAP, a hardware or software load balancer is placed in front of the server farm, and handles traffic routing.  Firewalls are placed, in front of the external IP address, of the load balancer as needed.

![A diagram depicting a standard A D F S topology.](media/Best-Practices-Securing-AD-FS/adfssec1.png)

> [!NOTE]
> AD FS requires a full writable Domain Controller to function as opposed to a Read-Only Domain Controller. If a planned topology includes a Read-Only Domain controller, the Read-Only domain controller can be used for authentication but LDAP claims processing will require a connection to the writable domain controller.

### Hardening your AD FS servers

The following is a list of best practices and recommendations for hardening and securing your AD FS deployment:

- Ensure only Active Directory Admins and AD FS Admins have admin rights to the AD FS system.
- Reduce local Administrators group membership on all AD FS servers.
- Require all cloud admins use multifactor authentication (MFA).
- Minimal administration capability via agents.
- Limit access on-network via host firewall.
- Ensure AD FS Admins use Admin Workstations to protect their credentials.
- Place AD FS server computer objects in a top-level OU that doesn’t also host other servers.
- All GPOs that apply to AD FS servers should only apply to them and not other servers as well. This limits potential privilege escalation through GPO modification.
- Ensure the installed certificates are protected against theft (don’t store these on a share on the network) and set a calendar reminder to ensure they get renewed before expiring (expired certificate breaks federation auth).  Additionally, we recommend protecting signing keys/certificates in a [hardware security module (HSM)](#hardware-security-module-hsm) attached to AD FS.
- Set logging to the highest level and send the AD FS (& security) logs to a SIEM to correlate with AD authentication as well as AzureAD (or similar).
- Remove unnecessary protocols & Windows features.
- Use a long (>25 characters), complex password for the AD FS service account. We recommend using a [Group Managed Service Account (gMSA)](../../../security/group-managed-service-accounts/group-managed-service-accounts-overview.md) as the service account, as it removes the need for managing the service account password over time by managing it automatically.
- Update to the latest AD FS version for security and logging improvements (as always, test first).

## Ports required

The below diagram depicts the firewall ports that must be enabled between and amongst the components of the AD FS and WAP deployment. If the deployment does not include Microsoft Entra ID / Office 365, the sync requirements can be disregarded.

> [!NOTE]
> Port 49443 is only required if user certificate authentication is used, which is optional for Microsoft Entra ID and Office 365.

![A diagram showing the required ports and protocols for an A D F S deployment.](media/Best-Practices-Securing-AD-FS/adfssec2.png)

> [!NOTE]
> Port 808 (Windows Server 2012R2) or port 1501 (Windows Server 2016+) is the Net. TCP port AD FS uses for the local WCF endpoint to transfer configuration data to the service process and PowerShell. This port can be seen by running Get-AdfsProperties | select NetTcpPort. This is a local port that will not need to be opened in the firewall but will be displayed in a port scan.

### Communication between Federation Servers

Federation servers on an AD FS farm communicate with other servers in the farm and the Web Application Proxy (WAP) servers via HTTP port 80 for configuration synchronization. Make sure that only these servers can communicate with each other and no other is a measure of defense in depth.

Organizations can do achieve this state, by setting up firewall rules on each server.  The rules should only allow inbound communication from the IP addresses of the servers in the farm and WAP servers. Some Network Load Balancers (NLB) use HTTP port 80 for probing the health on individual federation servers. Make sure that you include the IP addresses of the NLB in the configured firewall rules.

<a name='azure-ad-connect-and-federation-serverswap'></a>

### Microsoft Entra Connect and Federation Servers/WAP

This table describes the ports and protocols that are required for communication between the Microsoft Entra Connect server and Federation/WAP servers.

Protocol |Ports |Description
-----|-----|--|
HTTP|80 (TCP/UDP)|Used to download CRLs (Certificate Revocation Lists) to verify SSL certificates.|
HTTPS|443(TCP/UDP)|Used to synchronize with Microsoft Entra ID.|
WinRM|5985| WinRM Listener.|

### WAP and Federation Servers

This table describes the ports and protocols that are required for communication between the Federation servers and WAP servers.

Protocol |Ports |Description
-----|-----|--|
HTTPS|443(TCP/UDP)|Used for authentication.|

### WAP and Users

This table describes the ports and protocols that are required for communication between users and the WAP servers.

Protocol |Ports |Description
-----|-----|--|
HTTPS|443(TCP/UDP)|Used for device authentication.|
TCP|49443 (TCP)|Used for certificate authentication.|

For information on required ports and protocols required for hybrid deployments, see [Hybrid reference connect ports](/azure/active-directory/hybrid/reference-connect-ports).

For information about ports and protocols required for a Microsoft Entra ID and Office 365 deployment, see the document [Office 365 URL and IP address ranges](https://support.office.com/article/Office-365-URLs-and-IP-address-ranges-8548a211-3fe7-47cb-abb1-355ea5aa88a2?ui=en-US&rs=en-US&ad=US).

### Endpoints enabled

When AD FS and WAP are installed, a default set of AD FS endpoints are enabled on the federation service and on the proxy. These defaults were chosen based on the most commonly required and used scenarios and it is not necessary to change them.

<a name='min-set-of-endpoints-proxy-enabled-for-azure-ad--office-365-optional'></a>

### Min set of endpoints proxy enabled for Microsoft Entra ID / Office 365 (optional)

Organizations deploying AD FS and WAP only for Microsoft Entra ID and Office 365 scenarios can limit even further the number of AD FS endpoints enabled on the proxy to achieve a more minimal attack surface. Below is the list of endpoints that must be enabled on the proxy in these scenarios:

|Endpoint|Purpose |
|-----|----- |
|/adfs/ls/|Browser based authentication flows and current versions of Microsoft Office use this endpoint for Microsoft Entra ID and Office 365 authentication |
|/adfs/services/trust/2005/usernamemixed|Used for Exchange Online with Office clients older than Office 2013 May 2015 update.  Later clients use the passive \adfs\ls endpoint. |
|/adfs/services/trust/13/usernamemixed|Used for Exchange Online with Office clients older than Office 2013 May 2015 update.  Later clients use the passive \adfs\ls endpoint. |
|/adfs/oauth2/|Used for any modern apps (on-premises or in cloud) you have configured to authenticate directly to AD FS (i.e. not through Microsoft Entra ID) |
|/adfs/services/trust/mex|Used for Exchange Online with Office clients older than Office 2013 May 2015 update.  Later clients use the passive \adfs\ls endpoint.|
|/federationmetadata/2007-06/federationmetadata.xml    |Requirement for any passive flows; and used by Office 365 / Microsoft Entra ID to check AD FS certificates. |

AD FS endpoints can be disabled on the proxy using the following PowerShell cmdlet:

```powershell
Set-AdfsEndpoint -TargetAddressPath <address path> -Proxy $false
```

```powershell
Set-AdfsEndpoint -TargetAddressPath /adfs/services/trust/13/certificatemixed -Proxy $false
```

### Extended protection for authentication

Extended protection for authentication is a feature that mitigates against man in the middle (MITM) attacks and is enabled by default with AD FS. The setting can be verified using the below PowerShell cmdlet:

```powershell
Get-ADFSProperties
```

The property is `ExtendedProtectionTokenCheck`. The default setting is Allow, so that the security benefits can be achieved without the compatibility concerns with browsers that do not support the capability.

### Congestion control to protect the federation service

The federation service proxy (part of the WAP) provides congestion control to protect the AD FS service from a flood of requests. The Web Application Proxy will reject external client authentication requests if the federation server is overloaded as detected by the latency between the Web Application Proxy and the federation server. This feature is configured by default with a recommended latency threshold level. To verify the settings, you can do the following:

1. On your Web Application Proxy computer, start an elevated command window.
2. Navigate to the AD FS directory, at %WINDIR%\adfs\config.
3. Change the congestion control settings from its default values to `<congestionControl latencyThresholdInMSec="8000" minCongestionWindowSize="64" enabled="true" />`.
4. Save and close the file.
5. Restart the AD FS service by running `net stop adfssrv` and then `net start adfssrv`.

For guidance on this capability, see [Configure extranet access for AD FS on Windows Server 2012 R2](/previous-versions/azure/azure-services/dn528859(v=azure.100)).

### Standard HTTP request checks at the proxy

The proxy also performs the following standard checks against all traffic:

- The FS-P itself authenticates to AD FS via a short lived certificate.  In a scenario of suspected compromise of dmz servers, AD FS can "revoke proxy trust" so that it no longer trusts any incoming requests from potentially compromised proxies. Revoking the proxy trust revokes each proxy`s own certificate so that it cannot successfully authenticate for any purpose to the AD FS server.
- The FS-P terminates all connections and creates a new HTTP connection to the AD FS service on the internal network. This provides a session-level buffer between external devices and the AD FS service. The external device never connects directly to the AD FS service.
- The FS-P performs HTTP request validation that specifically filters out HTTP headers that are not required by AD FS service.

## Recommended security configurations

Ensure all AD FS and WAP servers receive the most current updates. The most important security recommendation for your AD FS infrastructure is to ensure you have a means in place to keep your AD FS and WAP servers current with all security updates, as well as those optional updates specified as important for AD FS on this page.

The recommended way for Microsoft Entra customers to monitor and keep current their infrastructure is via Microsoft Entra Connect Health for AD FS, a feature of Microsoft Entra ID P1 or P2. Microsoft Entra Connect Health includes monitors and alerts that trigger if an AD FS or WAP machine is missing one of the important updates specifically for AD FS and WAP.

To learn more about health monitoring for AD FS, see [Microsoft Entra Connect Health agent installation](/azure/active-directory/hybrid/how-to-connect-health-agent-install).

<a name='best-practice-for-securing-and-monitoring-the-ad-fs-trust-with-azure-ad'></a>

## Best practice for securing and monitoring the AD FS trust with Microsoft Entra ID

When you federate your AD FS with Microsoft Entra ID, it is critical that the federation configuration (trust relationship configured between AD FS and Microsoft Entra ID) is monitored closely, and any unusual or suspicious activity is captured. To do so, we recommend setting up alerts and getting notified whenever any changes are made to the federation configuration. To learn how to set up alerts, see [Monitor changes to federation configuration](/azure/active-directory/hybrid/how-to-connect-monitor-federation-changes).

## Additional security configurations

The following additional capabilities can be configured to provide more protection.

### Extranet "soft" lockout protection for accounts

With the extranet lockout feature in Windows Server 2012 R2, an AD FS administrator can set a maximum allowed number of failed authentication requests (ExtranetLockoutThreshold) and an `observation window` time period (ExtranetObservationWindow). When this maximum number (ExtranetLockoutThreshold) of authentication requests is reached, AD FS stops trying to authenticate the supplied account credentials against AD FS for the set time period (ExtranetObservationWindow). This action protects this account from an AD account lockout, in other words, it protects this account from losing access to corporate resources that rely on AD FS for authentication of the user. These settings apply to all domains that the AD FS service can authenticate.

You can use the following Windows PowerShell command to set the AD FS extranet lockout (example):

```powershell
Set-AdfsProperties -EnableExtranetLockout $true -ExtranetLockoutThreshold 15 -ExtranetObservationWindow ( new-timespan -Minutes 30 )
```

For reference, see [Configuring AD FS Extranet Lockout](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486806(v=ws.11)) to learn more about this feature.

### Disable WS-Trust Windows endpoints on the proxy from extranet

WS-Trust Windows endpoints (*/adfs/services/trust/2005/windowstransport* and */adfs/services/trust/13/windowstransport*) are meant only to be intranet facing endpoints that use WIA binding on HTTPS. Exposing them to extranet could allow requests against these endpoints to bypass lockout protections. These endpoints should be disabled on the proxy (i.e. disabled from extranet) to protect AD account lockout by using following PowerShell commands. There is no known end user impact by disabling these endpoints on the proxy.

```powershell
Set-AdfsEndpoint -TargetAddressPath /adfs/services/trust/2005/windowstransport -Proxy $false
```

```powershell
Set-AdfsEndpoint -TargetAddressPath /adfs/services/trust/13/windowstransport -Proxy $false
```

> [!NOTE]
> If your AD FS farm runs on Windows Internal Databases (WID) and has a secondary AD FS server, after disabling the endpoints on primary server, wait for the SYNC to occur on secondary nodes before restarting the AD FS service on them. Use the PowerShell command **Get-AdfsSyncProperties** on the secondary node to track last SYNC process.

### Differentiate access policies for intranet and extranet access

AD FS has the ability to differentiate access policies for requests that originate in the local, corporate network vs requests that come in from the internet via the proxy.  This differentiation can be done per application or globally.  For high business value applications or applications with sensitive information, consider requiring multifactor authentication. Multifactor authentication can be set up via the AD FS management snap-in.

<a name='require-multi-factor-authentication-mfa'></a>

### Require multifactor authentication (MFA)

AD FS can be configured to require strong authentication (such as multifactor authentication) specifically for requests coming in via the proxy, for individual applications, and for conditional access to both Microsoft Entra ID / Office 365 and on premises resources.  Supported methods of MFA include both Microsoft Azure MF and third party providers.  The user is prompted to provide the additional information (such as an SMS text containing a one time code), and AD FS works with the provider specific plug-in to allow access.

Supported external MFA providers include those listed in the [Configure additional authentication methods for AD FS](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn758113(v=ws.11)) page.

<a name='enable-protection-to-prevent-by-passing-of-cloud-azure-ad-multi-factor-authentication-when-federated-with-azure-ad'></a>

### Enable protection to prevent by-passing of cloud Microsoft Entra multifactor authentication when federated with Microsoft Entra ID

Enable protection to prevent bypassing of cloud Microsoft Entra multifactor authentication when federated with Microsoft Entra ID and using Microsoft Entra multifactor authentication as your multifactor authentication for your federated users.  

Enabling the protection for a federated domain in your Microsoft Entra tenant will ensure that Microsoft Entra multifactor authentication is always performed when a federated user accesses an application that is governed by a conditional access policy requiring MFA. This includes performing Microsoft Entra multifactor authentication even when federated identity provider has indicated (via federated token claims) that on-premises MFA has been performed. Enforcing Microsoft Entra multifactor authentication every time assures that a compromised on-premises account cannot bypass Microsoft Entra multifactor authentication by imitating that a multifactor authentication has already been performed by the identity provider, and is highly recommended unless you perform MFA for your federated users using a third party MFA provider.  

The protection can be enabled using a new security setting, [`federatedIdpMfaBehavior`](/graph/api/resources/internaldomainfederation?view=graph-rest-beta&preserve-view=true), which is exposed as a part of the [Internal Federation MS Graph API](/graph/api/resources/internaldomainfederation) or [MS Graph PowerShell cmdlets](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgdomainfederationconfiguration). The `federatedIdpMfaBehavior` setting determines whether Microsoft Entra ID accepts the MFA performed by the federated identity provider when a federated user accesses an application that is governed by a conditional access policy that requires MFA.

Administrators can choose one of the following values:

|Property|Description|
|-----|-----|  
|acceptIfMfaDoneByFederatedIdp|Microsoft Entra ID accepts MFA if performed by identity provider. If not, performs Microsoft Entra multifactor authentication.|  
|enforceMfaByFederatedIdp|Microsoft Entra ID accepts MFA if performed by identity provider. If not, it redirects request to identity provider to perform MFA.|
|rejectMfaByFederatedIdp|Microsoft Entra ID always performs Microsoft Entra multifactor authentication and rejects MFA if performed by identity provider.|  

You can enable protection by setting `federatedIdpMfaBehavior` to `rejectMfaByFederatedIdp` using the following command.  

MS GRAPH API

```
 PATCH /domains/{domainsId}/federationConfiguration/{internalDomainFederationId} 

{ 

"federatedIdpMfaBehavior": "rejectMfaByFederatedIdp" 

} 
```

Example:

```
PATCH /domains/contoso.com/federationConfiguration/2a8ce608-bb34-473f-9e0f-f373ee4cbc5a 

{ 

"federatedIdpMfaBehavior": "rejectMfaByFederatedIdp" 
```

Example:

```powershell
Update-MgDomainFederationConfiguration -DomainId <domainsId> -InternalDomainFederationId <internalDomainFederationId> federatedIdpMfaBehavior "rejectMfaByFederatedIdp" 
```

Example:

```powershell
Update-MgDomainFederationConfiguration -DomainId “contoso.com” -InternalDomainFederationId “2a8ce608-bb34-473f-9e0f-f373ee4cbc5a” federatedIdpMfaBehavior "rejectMfaByFederatedIdp" 
```

### Hardware Security Module (HSM)

In its default configuration, the keys AD FS uses to sign tokens never leave the federation servers on the intranet. They are never present in the DMZ or on the proxy machines. Optionally to provide more protection, we recommend protecting these keys in a hardware security module (HSM) attached to AD FS. Microsoft does not produce an HSM product, however there are several on the market that support AD FS.  In order to implement this recommendation, follow the vendor guidance to create the X509 certs for signing and encryption, then use the AD FS installation PowerShell commandlets, specifying your custom certificates as follows:

```powershell
Install-AdfsFarm -CertificateThumbprint <String> -DecryptionCertificateThumbprint <String> -FederationServiceName <String> -ServiceAccountCredential <PSCredential> -SigningCertificateThumbprint <String>
```

where:

- `CertificateThumbprint` is your SSL certificate
- `SigningCertificateThumbprint` is your signing certificate (with HSM protected key)
- `DecryptionCertificateThumbprint` is your encryption certificate (with HSM protected key)
