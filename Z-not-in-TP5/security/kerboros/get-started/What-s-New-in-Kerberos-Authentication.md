---
title: What&#39;s New in Kerberos Authentication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d7d7f393-6ca8-4ade-88a9-802d51717952
---
# What&#39;s New in Kerberos Authentication
This topic for the IT professional describes new capabilities and improvements to Windows implementation of the Kerberos authentication protocol in  Windows Server 2012  and Windows 8.

The Windows Server operating systems implement the Kerberos version 5 authentication protocol and extensions for public key and password-based authentication. The Kerberos authentication client is implemented as a security support provider (SSP), which can be accessed through the Security Support Provider Interface (SSPI). Initial user authentication is integrated with the Winlogon service single sign-on architecture. The Kerberos Key Distribution Center (KDC) is integrated in the domain controller with other security services in Windows Server. The KDC uses the domain’s Active Directory Domain Services (AD DS) as its security account database. AD DS is required for default Kerberos implementations within the domain or forest. In  Windows Server 2012  and Windows 8, Kerberos authentication can be leveraged to address lack of connectivity to the domain controller from outside the corporate firewall. To do so, it proxies Kerberos authentication and password change messages for users who are requesting domain access through DirectAccess or Remote Desktop Services.

## What's new in Kerberos Authentication in Windows Server 2012 and Windows 8

### <a name="BKMK_ImprovementsToReduceFailures"></a>Improvements to reduce authentication failures due to large service tickets
As sign-in scenarios become more complex, the amount of authorization information that is contained in the authentication messages increases, which in some cases leads to an authentication failure. In  Windows Server 2012  and Windows 8, improvements have been made to accommodate this increase.

#### KDC resource group compression
Within Kerberos authentication processes, authorization data is retrieved by the client from the domain controller and then sent to the resource. As the complexity of organizations increases, the number of groups that a user belongs to can increase significantly. When users are members of many groups in the resource domain, universal groups, and groups associated with security identifier history, the size of the authorization data in the service ticket can increase. The authentication message can exceed the default context token buffer size that Kerberos reports to applications, and this can cause authentication failures. In addition, when authorization data contains claims and device information, the size of that data increases.

**What value does this change add?**

This compression makes deployments easier when organizations have many users with high resource domain membership. In  Windows Server 2012  and Windows 8, the KDC automatically compresses the groups in the resource domain, which can reduce the size of the service ticket and reduce application authentication failures. After the  Windows Server 2012  KDC performs the compression, the supported operating systems  Windows Server 2012 ,  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003, Windows 8,  Windows 7 , Windows Vista and Windows XP can use the more compact Kerberos service ticket.

**What works differently?**

KDC resource group compression is a default feature of the implementation of the Kerberos protocol in the Windows operating systems.

#### Increase in the Kerberos SSPI context token buffer size
When applications query to determine the maximum size of the authentication context token buffer so they can preallocate memory, they can fail authentication when the Kerberos or negotiate message returned is larger than expected.

**What value does this change add?**

The increase in the default size of this buffer prevents a greater number of application authentication requests from failing due to a limit in space.

**What works differently?**

In  Windows Server 2012  and Windows 8, the default Kerberos SSPI context token buffer size has been increased to advised to set this value to more than 48,000 bytes.

#### Group Policy to set a maximum for the Kerberos SSPI context token buffer size
The new **Set maximum Kerberos SSPI context token buffer size** Kerberos administrative template policy setting enables you to set the value that is returned to applications that request the maximum size of the authentication context token buffer. This Group Policy setting replaces the need to manually set the MaxTokenSize registry value in HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters.

**What value does this change add?**

This Group Policy setting enables you to finely control the context token buffer size to meet the authentication requirements of the applications in your environment.

**What works differently?**

If you do not already configure the MaxTokenSize registry value, you should consider applying this policy with a setting of 48,000 bytes. The new warning for large Kerberos tickets can be used to determine if your organization has or is approaching a large authentication context token buffer issue.

#### KDC with warning events for large Kerberos tickets
The new **Warning events for large Kerberos tickets** KDC administrative template policy setting enables you to control the system warning events that are logged by a KDC when tickets issued during Kerberos authentication are close to or greater than a configured threshold value size. The ticket size warnings are Event ID 31 in the System log.

**What works differently?**

But there are some considerations for setting this warning threshold. If it is set too high, warnings are not produced before authentication failures due to larger than expected authentication context token buffer size. If it is set too low, log entries increase, which makes analysis more difficult. The size should be set to one of the following:

-   Your custom MaxTokenSize registry value

-   The size deployed by the **Set maximum Kerberos SSPI context token buffer size** Group Policy setting

If the **Warning events for large Kerberos tickets** setting is not enabled, the threshold value defaults to 12,000 bytes, which is the default setting for MaxTokenSize for Kerberos tickets in Windows 7, Windows Server 2008 R2, and prior versions.

### <a name="versions"></a>New and changed functionality for developers
The following features are introduced for Kerberos authentication in  Windows Server 2012  and Windows 8 to enable you to build more robust applications.

#### Extended protection for untrusted targets
Extended Protection for Authentication is designed to protect against authentication relay attacks. It uses a combination of channel binding and service binding techniques. Extended Protection was introduced in Windows 7 and made available on a number of previously released operating systems.

Extended Protection relies on a collaboration of client-side and server-side technologies and a specific set of rules. For example, one rule is that the target of authentication, the Service Principal Name (SPN), must be intentional—even when a user is lured into authentication. The target SPN must be derived from user intent, and not from an untrusted source.

**What works differently?**

In  Windows Server 2012 , InitializeSecurityContext () adds support for the ISC_REQ_UNVERIFIED_TARGET_NAME flag for applications to use when they provide target names from an untrusted source. This allows services that are configured for Extended Protection to handle authentication to an untrusted source securely. Because NTLM and Kerberos clients that are attempting to authenticate using an untrusted SPN state that explicitly in their authentication messages, the services then will allow or fail the authentication request based on its Extended Protection configuration:

-   Disabled: allow

-   Enabled: fail

#### Kernel support for EncryptMessage and DecryptMessage
The Kerberos SSP now supports EncryptMessage/DecryptMessage from kernel applications.

#### Device sign-in with certificates
The Kerberos SSP now supports device sign-in by using a certificate.

### New and changed functionality for IT professionals

#### <a name="BKMK_BranchOfficeSupport"></a>Branch office support for authentication to resources outside the branch office
In  Windows 7 , when the user signed in by using a smart card with a mapped group, the group was lost when the user connected to resources outside the branch office. A device running Windows 8 in a branch office uses a hub domain controller running  Windows Server 2012  to get a ticket-granting ticket (TGT). It uses the TGT to request service tickets for resources outside the branch office. There is no configuration required to use this feature.

#### <a name="BKMK_Sup4ClaimsCAarmoring"></a>Support for claims, compound authentication, and Kerberos armoring
If you want to create access control based on claims and compound authentication, you need to deploy Dynamic Access Control. This requires that you upgrade to Kerberos clients and use the KDC, which support these new authorization types. With  Windows Server 2012 , you do not have to wait until all the domain controllers and the domain functional level are upgraded to take advantage of new access control options.

For information about Dynamic Access Control in  Windows Server 2012 , see [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md) and the related topics.

**What value does this change add?**

You can create access control based on claims and compound authentication.

**What works differently?**

The new **KDC support for claims, compound authentication, and Kerberos armoring** KDC administrative template policy setting allows you to configure a domain controller to support claims and compound authentication for Dynamic Access Control and Kerberos armoring by using Kerberos authentication. This policy setting is configured on the domain controller OU.

When the supported (or higher) setting is configured, domain controllers running  Windows Server 2012 , Windows Server 2008 R2, or Windows Server 2008 will advertise domain support for claims and compound authentication for Dynamic Access Control and Kerberos armoring. No domain controllers running Windows Server 2003 can be in a domain that support claims and compound authentication for Dynamic Access Control and Kerberos armoring.

Additionally, the **Kerberos client support for claims, compound authentication and Kerberos armoring** administrative template policy setting enables you to configure devices running Windows 8 to support claims and compound authentication for Dynamic Access Control and Kerberos armoring by using Kerberos authentication. Devices running Windows 8 will fail authentication if they cannot find a domain controller running  Windows Server 2012  . It is important to ensure that there are sufficient domain controllers running  Windows Server 2012  for any account, referral, and resource domains that are supported.

The following table lists the four configurations that are available in **KDC support for claims, compound authentication, and Kerberos armoring**.

|Configuration|Results|Domain controller behavior in  Windows Server 2012 |
|-----------------|-----------|-----------------------------------------------------------------------------------------|
|Not supported (default)|No minimum requirement for domain controllers running  Windows Server 2012 |Claims not provided<br /><br />Compound authentication not supported<br /><br />Kerberos armoring not supported|
|Supported|All domain controllers advertise support for claims and compound authentication for Dynamic Access Control and Kerberos armoring<br /><br />Requires sufficient domain controllers running  Windows Server 2012  to handle the  authentication requests for devices running  Windows 8 in the domain|Claims provided on request<br /><br />Compound authentication provided on request when resource supports it<br /><br />Kerberos armoring supported|
|Always provide claims|All domain controllers advertise support for claims and compound authentication for Dynamic Access Control and Kerberos armoring<br /><br />Requires  Windows Server 2012  domain functional level|Claims always provided<br /><br />Compound authentication provided on request when resource supports it<br /><br />Kerberos armoring supported and Flexible Authentication via Secure Tunneling (RFC FAST) behavior supported|
|Fail unarmored authentication requests|All domain controllers advertise support for claims and compound authentication for Dynamic Access Control and Kerberos armoring<br /><br />Requires  Windows Server 2012  domain functional level<br /><br />Requires that all FAST-aware devices request authentication|Claims always provided<br /><br />Compound authentication provided on request when resource supports it<br /><br />Rejects unarmored Kerberos messages and supports the Flexible Authentication via Secure Tunneling (RFC FAST) behavior|

**Always provide claims** and **Fail unarmored authentication requests** options cause intermittent authentication or access control failures if there are any domain controllers not running - Windows Server 2012  in the domain. So neither of these options will take effect until the domain is set at the  Windows Server 2012  functional level. Until then, domain controllers running  Windows Server 2012  will behave as if the **Supported** option is configured.

Supporting claims and compound authentication for Dynamic Access Control and Kerberos armoring will impact the domain controller because:

1.  Secure Kerberos domain capability discovery is required, which results in additional message exchanges. Resource servers running  Windows Server 2012  send protocol transition requests for non-Windows 8 devices, which results in additional messages exchanges to account domains and referral domains. These requests will go outside the site when no domain controller is available in the site.

2.  Claims and compound authentication for Dynamic Access Control increases the size and complexity of the data in the message, which results in more processing time and greater Kerberos service ticket size.

3.  Kerberos armoring fully encrypts Kerberos messages and signs Kerberos errors. This results in increased processing time, but it does not change the Kerberos service ticket size.

Supporting claims and compound authentication for Dynamic Access Control and Kerberos armoring (when the Supported option or higher is selected), could impact connectivity and file access because:

1.  The setting configures a domain for the new access control model, which new services can choose to support.

2.  Any device that supports claims, compound authentication, and Kerberos armoring cannot authenticate unless it can find a domain controller that supports claims, compound authentication and Kerberos armoring. This ensures that the client device receives complete domain authorization information during authentication for all access control checks (local and remote).

3.  Devices running Windows 8 that do not support claims, compound authentication, and Kerberos armoring should not be configured with claims-based access controls for startup or sign-on services or with claims-based access controls for local files. Access will be denied, and claims will not be available until the domain is configured to the  Windows Server 2012  domain functional level and configured to always provide claims.

The **KDC support for claims, compound authentication, and Kerberos armoring** administrative template policy setting also impacts network load and traffic patterns as follows:

1.  Secure Kerberos domain capability discovery is required, which results in additional message exchanges.

2.  Requests will go outside of the site when no domain controllers running  Windows Server 2012  are available on the site for devices running Windows 8 that send authentication requests, and resource servers running  Windows Server 2012  that send protocol transition requests.

##### Claims
Claims are new authorization data that are provided by Active Directory. When claims are provisioned,  Windows Server 2012  KDCs can create service tickets with a principal’s claims. Access tokens that are created from these service tickets include claims that can be used for access control.

**What value does this change add?**

This enables  Windows Server 2012  to control access to resources with expressions in terms of:

-   User claims

-   Device claims, if the resource’s domain supports claims and compound authentication for Dynamic Access Control and Kerberos armoring

**What works differently?**

To support resources that use claims-based access control, the principal’s domains will need to be running one of the following:

-   All  Windows Server 2012  domain controllers

-   Sufficient  Windows Server 2012  domain controllers to handle all the Windows 8 device authentication requests

-   Sufficient  Windows Server 2012  domain controllers to handle all the  Windows Server 2012  resource protocol transition requests to support non-Windows 8 devices

Additionally, you will need to configure on the domain controller OU, the new **KDC support for claims, compound authentication and Kerberos armoring** policy with “Supported” or higher setting, and if the client is retrieving claims, configure the new **Kerberos client support for claims, compound authentication and Kerberos armoring** policy on each client.

To support access control across forests, the forest root domains need the following:

-   All  Windows Server 2012  domain controllers. This helps ensure that claims are not lost from trusted forests.

-   If users across forests sign in to devices in child domains, you must apply the QFE [NetBIOS domain name\username format cannot be used with the Kerberos referral mechanism to log on to a computer in an across forest environment](http://support.microsoft.com/kb/2675498) to down-level global catalogs.

To support access control for branch offices, you need the following:

-   If groups or claims are generated from certificate-based sign-ins, sufficient hub domain controllers running  Windows Server 2012  for the corresponding branch office read-only domain controllers (RODC) to handle all the Windows 8 device authentication requests for resources outside the branch office.

-   For resources that do not sign in to an RODC, sufficient hub domain controllers running  Windows Server 2012  for the corresponding branch office user’s RODC. These domain controllers handle all the  Windows Server 2012  resource protocol transition requests to support devices that are not running Windows 8.

##### Compound authentication
Compound authentication is an extension to Flexible Authentication Secure Tunneling (FAST), which allows Kerberos clients to provide the device’s TGT. This allows  Windows Server 2012  KDCs to create service tickets with device authorization data for services that are hosted on Windows 8 and configured to support device authorization data. Access tokens that are created from these service tickets include the device’s groups and claims, which can be used for access control.

**What value does this change add?**

This enables  Windows Server 2012  to control access to resources with expressions in terms of:

-   Devices

-   Device groups

-   Device claims, if the device’s domain supports claims and compound authentication for Dynamic Access Control and Kerberos armoring

**What works differently?**

To support resources by using compound authentication for access control, the resource domains need one of the following:

-   All  Windows Server 2012  domain controllers

-   Sufficient  Windows Server 2012  domain controllers to handle all the Windows 8 device authentication requests

Additionally, you will need to configure on the domain controller OU, the new **KDC support for claims, compound authentication and Kerberos armoring** policy with “Supported” or higher setting, and if the client is retrieving claims, configure the new **Kerberos client support for claims, compound authentication and Kerberos armoring** policy on each client.

Access control based on device claims also require the device’s domain to be provisioned for claims. Access control based on device or device groups, does not.

To support across forest access control, the forest root domains need:

-   All  Windows Server 2012  domain controllers. This helps ensure that claims are not lost from trusted forests. If domain controllers that are running a Windows Server version earlier than  Windows Server 2012  exist in the forest root domains, those domain controllers will discard the claims. This results in intermittent access control failures, and the claims data is not disclosed to the trusting forest.

To support access control for resources outside the branch office, sufficient hub domain controllers running  Windows Server 2012  for the corresponding branch office domain controllers (RODC).

The new **Support compound authentication** Kerberos administrative template policy setting enables you to explicitly configure support for KDCs to provide compound authentication to services by using the device’s identity. Generally, this is not needed because applications will configure support for compound authentication. There are three options:

-   **Never**: KDC will not provide compound authentication.

-   **Automatic**: When a Dynamic Access Control-aware application is installed, the KDC always provides compound authentication. After the last Dynamic Access Control-aware application is removed, the KDC will not provide compound authentication.

-   **Always**: KDC always provides compound authentication.

For services that are using a managed service account identity, Windows PowerShell must be used so that the KDC can start providing compound authentication. Use **Set-ADServiceAccount** with the **CompoundIdentitySupported** parameter.

##### Kerberos Armoring (Flexible Authentication Secure Tunneling (FAST))
Flexible Authentication Secure Tunneling (FAST) provides a protected channel between the Kerberos client and the KDC. FAST is implemented as Kerberos armoring in  Windows Server 2012 , and it is only available for authentication service (AS) and ticket-granting service (TGS) exchanges.

**What value does this change add?**

This enables the following for domain-joined systems running  Windows Server 2012  and Windows 8:

-   Protection against offline dictionary attacks. Kerberos armoring protects the user’s preauthentication data, which is vulnerable to offline dictionary attacks when it is generated from a password.

-   Authenticated Kerberos errors. Kerberos armoring protects user Kerberos authentications from KDC Kerberos error spoofing, which can downgrade to NTLM or weaker cryptography.

-   Compounded authentication

**What works differently?**

Kerberos armoring uses a ticket-granting ticket (TGT) for the device to protect authentication service exchanges with the KDC, so the computer’s authentication service exchange is not armored. The user’s TGT is used to protect its TGS exchanges with the KDC.

The new **Fail authentication requests when Kerberos armoring is not available** Kerberos administrative template policy setting controls whether a device requires that Kerberos message exchanges be armored when communicating with a domain controller. When this policy setting is enabled, a device running Windows 8 only allows the authentication service exchange to be unarmored and fail authentication when a domain does not support Kerberos armoring, or when a domain controller running  Windows Server 2012  cannot be found for a domain that supports Kerberos armoring.

> [!IMPORTANT]
> This policy setting is affected by another setting. When a domain does not support Kerberos armoring by enabling **KDC support claims, compound authentication, and Kerberos armoring**, all authentication attempts for all its users will fail from computers that have this policy enabled.

#### <a name="BKMK_CD"></a>Resource-based constrained delegation across domains and forest
In  Windows Server 2012 , the new resource-based Kerberos constrained delegation can be used to provide constrained delegation when the front-end services and the resource services are not in the same domain.

Kerberos constrained delegation provides a safer form of delegation to be used by services. It restricts the services to which a given server can act on the behalf of a user. However, this model limited constrained delegation to a single domain and required a domain administrator because it is configured on the front-end service’s account. In today’s enterprise, front-end services are not designed to limit themselves to integration with only services in their domain. In addition, because provisioning is required by domain administrators, deploying new services cannot be done by service administrators.

Currently, a service administrator has no useful way of knowing which front-end services delegate to the resource services they own. This introduces security risks because any front-end service that can delegate to a resource service represents a potential attack point. If a server that hosts a front-end service that delegates to a resource service is compromised, the resource service may be compromised.

**What value does this change add?**

In  Windows Server 2012 , service administrators are able to specify which service identities can impersonate users to their services. Configuring constrained delegation on the resource permits services such as ISA Server, OWA, and SharePoint to be configured to use constrained delegation to authenticate to servers in other domains or in other forests. This provides support for multihop service solutions by using an existing Kerberos infrastructure.

**What works differently?**

To configure a resource service to allow a front-end service access on the behalf of users, Windows PowerShell cmdlets are used to provide a list of principals that are allowed. Use the **New** and **Set** cmdlets for **ADComputer**, **ADServiceAccount**, and **ADUser** with the **PrincipalsAllowedToDelegateToAccount** parameter.

> [!NOTE]
> -   You must apply the QFE [Resource-based constrained delegation KDC_ERR_POLICY failure in environments that have Windows Server 2008 R2-based domain controllers](http://support.microsoft.com/kb/2665790) to all down-level domain controllers in user account domains between the front-end and back-end domains.

To retrieve the list of principals, use the **Get** cmdlet for **ADComputer**, **ADServiceAccount**, and **ADUser** with the **PrincipalsAllowedToDelegateToAccount** parameter.

#### <a name="BKMK_EnforcementForForestBoundary"></a>Enforcement for forest boundary for Kerberos full delegation
When full delegation is enabled for Kerberos on a server, the server can use the delegated ticket-granting ticket (TGT) to connect as the user to any server, including those across a one way trust. In  Windows Server 2012 , a trust across forests can be configured to enforce the security boundary by disallowing forwarding TGTs to enter other forests.

**What works differently?**

To disable Kerberos full delegation on an outbound forest trust, all domain controllers in the forest root must support this feature, and you must set netdom trust for **EnableTGTDelegation on the across forest trust** to **No**.

#### <a name="BKMK_KDCproxyService"></a>KDC proxy service
The KDC proxy service is installed with select DirectAccess or Remote Desktop solutions to provide a way for Kerberos authentication to be used by Internet clients. DirectAccess and Remote Desktop clients create a TLS/SSL secure channel to the KDC proxy service running on the DirectAccess server or Remote Desktop Gateway (RD Gateway). To obtain the service ticket for the DirectAccess server or the Remote Desktop server, Kerberos messages are sent to the corresponding KDC proxy service. The service sends the request to a domain controller in the corporate network, and then returns the response.

**What value does this change add?**

This benefits the administrator in that the same protocol used in support of Active Directory domains, Kerberos, is also used for authentication traffic and credential management, such as password change for DirectAccess or Remote Desktop users who are requesting domain access.

**What works differently?**

For currently deployed systems that use Kerberos authentication, there are no differences. For some deployments of DirectAccess and Remote Desktop Services solutions with  Windows Server 2012 , the KDC proxy service is available by default.

The **Disable revocation checking for the SSL certificate of KDC proxy servers** Kerberos administrative template policy setting allows you to create a test environment for DirectAccess or RD Gateway with a KDC proxy server without needing to configure a CRL/OCSP environment. When enabled, the Kerberos client will not enforce the revocation check for the KDC proxy service’s TLS/SSL certificate.

> [!WARNING]
> Because this setting allows the client to connect to services with an invalid certificate, it should never be set on production servers.

#### Strict KDC Validation default changes
In Windows 8, the default behavior for domain-joined smart card sign on for KDC validation was changed so that validation using NTAuth store policy, or the root CA on the smart card, is required.

> [!NOTE]
> This behavior is not the same as enabling **Require strict KDC validation**. Strict KDC validation is a more restrictive set of criteria which ensures all of the following are met:
> 
> -   The domain controller has the private key for the certificate provided.
> -   For domain-joined systems, the certification authority (CA) that issued the KDC’s certificate is in the NTAuth store.
> -   For non-domain-joined systems, the root CA of the KDC’s certificate is in the Third-Party Root CA or Smart Card Trusted Roots store.
> -   KDC’s certificate has the KDC EKU.
> -   KDC certificate’s DNSName field of the subjectAltName (SAN) extension matches the DNS name of the domain.

For non-domain-joined smart card sign on, strict KDC validation is required.

To disable this default behavior, disable the Group Policy setting **Require strict KDC validation**.

### Configuration and maintenance improvements

#### KDC service servicing without a reboot
The  Windows Server 2012  Kerberos Key Distribution Center (KDC) service (kdcsvc) can be patched without requiring a system reboot.

#### New KDC system events
The following table describes new KDC events, which are written to the System log on a domain controller.

|Event|Text|Resolution|
|---------|--------|--------------|
|31|Warning service ticket issued that approaches the configured ticket threshold|This is controlled by the new “Warning events for large Kerberos tickets” KDC administrative template policy setting. The Explain text of this policy setting has a detailed description.|
|32|KDC certificate is missing a KDC EKU|This event is triggered by a certificate sign-in request. The KDC has a certificate that is using an old template that does not have the KDC EKU, and it should be replaced.|
|33| Windows Server 2012  domain controller failed to configure the domain to advertise support for claims and compound authentication for Dynamic Access Control and Kerberos armoring.|To resolve this issue, try running **gpupdate /force** on a domain controller running  Windows Server 2012 .|
|34| Windows Server 2012  domain controllers are configured for supporting claims and compound authentication for Dynamic Access Control and Kerberos armoring option which requires  Windows Server 2012  domain functional level and the domain is not at this level.|To resolve this condition, update the domain functional level to  Windows Server 2012  or set the domain support for claims and compound authentication for Dynamic Access Control and Kerberos armoring to the **Supported** option.|

#### KDC operational log
The new KDC operational log is located in **Application and Services/Microsoft/Windows/Kerberos-Key-Distribution-Center/Operational**. It provides information that can help you determine the cause of a certificate logon failure or when the KDC service was stopped or started. In  Windows Server 2012 , the following events are logged when the operational log is enabled:

-   120: Error: KDC certificate validation failure

-   200: Warning: KDC certificate not found

-   300: Informational: KDC service was started

-   301: Informational: KDC service was stopped

-   302: Informational: KDC certificate is current

#### Kerberos operational log
The new Kerberos operational log is located in **Application and Services/Microsoft/Windows/Security-Kerberos/Operational**. It provides information that can help you determine the cause of a failure without collecting a trace and contacting Microsoft Product Support. In  Windows Server 2012 , the following events are logged when the operational log is enabled:

-   100: Error: Authentication failure due to unregistered SPN

-   101: Error: Authentication failure due to duplicate SPN

-   102: Error: Certificate based authentication failure due to KDC certificate validation failure

-   103: Error: Certificate based authentication failure due to client certificate validation failure

-   104: Error: Certificate based authentication failure due to KDC either not supported certificate based authentication or not provisioned with a KDC certificate

-   105: Error: Attempt to retrieve group managed service account password failed

-   106: Error: Certificate based authentication failure due to KDC certificate validation failure due to KDC EKU missing

-   107: Error: Certificate based authentication failure due to KDC certificate validation failure due to wrong domain name

-   108: Error: Authentication failure due to no domain controller available and inability to use Kerberos proxy messages

-   109: Error: Authentication failure due to no domain controller available and attempt to use Kerberos proxy failed because the authentication request did not have authentication credentials for HTTP proxy

-   200: Warning: Domain controller could not be located

-   300: Informational: Domain controller which was located

-   301: Informational: Authentication using a stored credential

-   302: Informational: Domain controller not responding

-   303: Informational: Group managed service account password retrieved

#### Performance monitor counters
In Windows Server 2008 R2, Kerberos had four performance monitor counters:

-   Forwarded Kerberos Requests for read-only domain controllers

-   KDC AS Requests for domain controllers

-   KDC TGS Requests for domain controllers

-   Kerberos Authentications for servers

In  Windows Server 2012 , the following Kerberos performance counters have been added:

-   KDC claims-aware AS Requests

    Measures the number of claims-aware Authentication Service requests (AS-REQ) that are being received by a domain controller. The load of existing claims-aware devices can be determined without requiring that the domain support claims, compound authentication, or provide Kerberos armoring. However, because devices running Windows 8 are not claims-aware by default, this counter cannot be used to determine initial authentication requests unless the devices are configured to support claims, compound authentication, and provide Kerberos armoring.

    > [!NOTE]
    >  Windows Server 2012  domain controllers control the provisioning of claims authorization data, and only those domain controllers that support claims and compound authentication for Dynamic Access Control and Kerberos armoring will actually return AS-REP messages that contain claims.

-   KDC AS Requests with FAST for domain controllers

    Measures the number of armored Authentication Service request messages (AS-REQ) that are being processed by a domain controller.

    > [!NOTE]
    > Domain controllers that do not support claims and compound authentication for Dynamic Access Control and Kerberos armoring cannot process armored Kerberos messages.

-   KDC armored TGS Requests

    Measures the number of armored ticket-granting service request messages (TGS-REQ) that are being processed by a domain controller.

    > [!NOTE]
    > Domain controllers that do not support claims and compound authentication for Dynamic Access Control and Kerberos armoring cannot process armored Kerberos messages.

-   KDC claims-aware TGS Requests

    Measures the number of claims-aware ticket-granting service request messages (TGS-REQ) that are being received by a domain controller. The load of existing claims-aware devices can be determined without requiring the domain to support claims, compound authentication, and provide Kerberos armoring. However, because devices running Windows 8 are not claims-aware by default, this counter cannot be used to determine service ticket requests unless the devices are configured to support claims, compound authentication, and provide Kerberos armoring.

-   KDC claims-aware service asserted identity TGS Requests

    Measures the number of service asserted identity (S4U2Self) ticket-granting service request messages (TGS-REQ) that are explicitly asking for claims.

    > [!NOTE]
    > Domain controllers running  Windows Server 2012  control the provisioning of claims authorization data, and only those domain controllers that support claims and compound authentication for Dynamic Access Control and Kerberos armoring will actually return TGS-REP messages that contain claims.

-   KDC classic type constrained delegation TGS Requests

    Measures the number of constrained delegation (S4U2Proxy) ticket-granting service request messages (TGS-REQ) that are being processed by a domain controller by using the SPNs that are configured on the middle-tier service account object.

-   KDC resource type constrained delegation TGS Requests

    Measures the number of constrained delegation (S4U2Proxy) ticket-granting service request messages (TGS-REQ) that are being processed by a domain controller by using the resource’s account object configuration.

#### Changes to SetSPN
In  Windows Server 2012 , SetSPN will no longer be able to register duplicate SPNs in a domain. When SetSPN –a is used, SetSPN will treat it as SetSPN –s.

For eveloping information about SetSPN, see [Service Principal Names (SPNs) SetSPN Syntax (Setspn.exe)](http://social.technet.microsoft.com/wiki/contents/articles/717.service-principal-names-spns-setspn-syntax-setspn-exe.aspx) on the TechNet Wiki. For the command reference, see [Setspn \[2008\]](assetId:///9341c753-11ff-4acc-993c-b05d50f32330) in the TechNet Library.

## See also

-   [Kerberos Authentication Overview](Kerberos-Authentication-Overview.md)

-   [Kerberos Constrained Delegation Overview](Kerberos-Constrained-Delegation-Overview.md)

-   [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)

-   [Active Directory Domain Services Overview](Active-Directory-Domain-Services-Overview.md)


