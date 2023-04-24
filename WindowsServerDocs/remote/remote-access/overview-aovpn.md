---
title: About Always On VPN
description: Learn about Always On VPN benefits over standard Windows VPN solutions. Key areas in integration, security, connectivity, networking control, and compatibility align Always On VPN with Microsoft's cloud-first, mobile-first vision.
ms.topic: article
ms.author: wscontent
author: anaharris-ms
ms.date: 04/24/2023
---

# About Always On VPN

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10+

<!-- Editor note: What are we comparing here: standard Windows VPN solutions, Other solutions, DirectAcess? Need to choose or provide separate comparisons for each -->

Always On VPN allows you to:

- **Create advanced scenarios** by integrating Windows operating systems and third-party solution platforms. For a list of supported platforms, see [Supported platforms](#supported-platforms).

<!-- Editor note: what  is the difference specifically between AOVPN and standard options -->
- **Maintain network security**, restricting connection by traffic types, applications, and authenticaion methods. For a list of Always On VPN security features, see [Security features](#security-features).

- **Configure auto-triggering** for user and device authenticated connections. For more information, see [Connectivity features](#connectivity-features).

- **Control your network** by creating routing policies at a granular level; even down to the individual application.  For more information, see [Networking features](#networking-features).

<!--Editor note: chech below items for accuracy -->

- **Configure your VPN settings** with a standard XML profile (ProfileXML) which is defined by an industry standard configuration template. You can deploy and manage your VPN settings with Windows PowerShell, Microsoft Endpoint Configuration Manager, Intune, Windows Configuration Designer, or any third-party mobile device management (MDM) tool.

## Supported platforms

<!-- Editor note: Where would this go? -->
Always On VPN supports domain-joined, nondomain-joined (workgroup), or Azure AD–joined devices to allow for both enterprise and BYOD scenarios. Always On VPN is available in all Windows editions, and the platform features are available to third parties by way of UWP VPN plug-in support.<p><p>***Note:***<br>Device Tunnel can only be configured on domain-joined devices running Windows 10 Enterprise or Education version 1709 or later. There is no support for third-party control of the Device Tunnel.  

Always On VPN supports integration with the following platforms:

| Support for... |  Description  |
|----------------|---|
|[**Windows Information Protection (WIP)**](/windows/threat-protection/windows-information-protection/protect-enterprise-data-using-wip) | Integration with WIP allows network policy enforcement to determine whether traffic is permitted to go over the VPN. If the user profile is active and WIP policies are applied, Always On VPN is automatically triggered to connect. Also, when you use WIP, there's no need to specify `AppTriggerList` and `TrafficFilterList` rules separately in the VPN profile (unless you want more advanced configuration) because the WIP policies and application lists automatically take effect. |
|[**Windows Hello for Business**](/windows/access-protection/hello-for-business/hello-overview) |Always On VPN natively supports Windows Hello for Business in certificate-based authentication mode. The native Windows Hello support provides a seamless single sign-on experience for both sign-in to the machine, as well as connection to the VPN. No secondary authentication (user credentials) is needed for the VPN connection. |
| [**Microsoft Azure conditional access platform**](/azure/active-directory/active-directory-conditional-access-controls) |The Always On VPN client can integrate with the Azure conditional access platform to enforce multifactor authentication (MFA), device compliance, or a combination of the two. When compliant with conditional access policies, Azure Active Directory (Azure AD) issues a short-lived (by default, sixty minutes) IP Security (IPsec) authentication certificate. The IPSec certificate can then be used to authenticate to the VPN gateway. Device compliance uses Configuration Manager/Intune compliance policies, which can include the device health attestation state as part of the connection compliance check. For more details, see [VPN and conditional access](/windows/security/identity-protection/vpn/vpn-conditional-access)|
|[**Azure AD Multi-Factor Authentication platform**](/azure/active-directory/authentication/concept-mfa-howitworks) |When combined with Remote Authentication Dial-In User Service (RADIUS) services and the Network Policy Server (NPS) extension for Azure AD Multi-Factor Authentication, VPN authentication can use strong MFA. |
|**Third-party VPN plug-ins**  | With the Universal Windows Platform (UWP), third-party VPN providers can create a single application for the full range of Windows devices. The UWP provides a guaranteed core API layer across devices, eliminating the complexity of and problems often associated with writing kernel-level drivers. Currently, Windows UWP VPN plug-ins exist for [Pulse Secure](https://www.microsoft.com/p/pulse-secure/9nblggh3b0bp), [F5 Access](https://www.microsoft.com/p/f5-access/9wzdncrdsfn0), [Check Point Capsule VPN](https://www.microsoft.com/p/check-point-capsule-vpn/9wzdncrdjxtj), [FortiClient](https://www.microsoft.com/p/forticlient/9wzdncrdh6mc), [SonicWall Mobile Connect](https://www.microsoft.com/p/sonicwall-mobile-connect/9wzdncrdsfkz), and [GlobalProtect](https://www.microsoft.com/p/globalprotect/9nblggh6bzl3). |

## Security features

<!-- Editor note: moved this paragraph here. Does it belong here? -->
Always On VPN provides connectivity to corporate resources by using tunnel policies that require authentication and encryption until they reach the VPN gateway. By default, the tunnel sessions terminate at the VPN gateway, which also functions as the IKEv2 gateway, providing end-to-edge security.

Always On VPN supports the following security features:

| Feature| Description  |
|---|---|
|**Support for machine certificate authentication** |The IKEv2 protocol type available as part of the Always On VPN platform specifically supports the use of machine or computer certificates for VPN authentication.<p><p>***Note:***<br>IKEv2 is the only supported protocol for Device Tunnel and there is no support option for SSTP fallback. For more information see,  [Configure an Always On VPN device tunnel](/azure/vpn-gateway/vpn-gateway-howto-always-on-device-tunnel).  |
| **Traffic and app filters** | With traffic and app firewall rules, you can specify client-side policies that determine which traffic and apps are allowed to connect to the VPN interface. Two types of filtering rules are available:<ul><li>**App-based rules.** App-based firewall rules are based on a list of specified applications so that only traffic originating from these apps are permitted to go over the VPN interface.</li><li>**Traffic-based rules.** Traffic-based firewall rules are based on network requirements like ports, addresses, and protocols. Use these rules only for traffic that matches these specific conditions are permitted to go over the VPN interface.<p><p>***Note:***<br>These rules apply only to traffic outbound from the device. Use of traffic filters blocks inbound traffic from the corporate network to the client. </li></ul> |
|**Limit remote access functionality to specific clients** |You can configure Always On VPN to support granular authorization when using RADIUS, which includes the use of security groups to control VPN access.|
|**Define which accessible management servers before user sign-in**|Use the Device Tunnel feature (available in version 1709 – for IKEv2 only) in the VPN profile combined with traffic filters to control which management systems on the corporate network are accessible through the Device Tunnel.<p><p>***Note:***<br>If you turn on traffic filters in the Device Tunnel profile, then the Device Tunnel denies inbound traffic (from the corporate network to the client)|
|**Per-App VPN**|Per-App VPN is like having an app-based traffic filter, but it goes farther to combine application triggers with an app-based traffic filter so that VPN connectivity is constrained to a specific application as opposed to all applications on the VPN client. The feature automatically initiates when the app starts.|
|  **Customized IPsec cryptography algorithms**   | Always On VPN supports the use of both RSA and elliptic curve cryptography–based custom cryptographic algorithms to meet stringent government or organizational security policies.|
| **Native Extensible Authentication Protocol (EAP) support** |Always On VPN natively supports EAP, which allows you to use a diverse set of Microsoft and third-party EAP types as part of the authentication workflow. EAP provides secure authentication based on the following authentication types:<ul><li>Username and password</li><li>Smart card (both physical and virtual)</li><li>User certificates</li><li>Windows Hello for Business</li><li>MFA support by way of EAP RADIUS integration</li></ul>The application vendor controls third-party UWP VPN plug-in authentication methods, although they have an array of available options, including custom credential types and OTP support.|

 For more details about standard VPN authentication options, see [VPN authentication options](/windows/security/identity-protection/vpn/vpn-authentication).

## Connectivity features

Always On VPN supports the following connectivity features:

|  Feature  | Description |
|----|-----|
|**Application auto-triggering** |You can configure Always On VPN to support auto-triggering based on application launch or namespace resolution requests. For more information on how to configure auto-triggering, see [VPN auto-triggered profile options](/windows/security/identity-protection/vpn/vpn-auto-trigger-profile).|
|**Name-based auto-triggering** | With Always On VPN, you can define rules so that specific domain name queries trigger the VPN connection. Windows devices support name-based triggering for domain-joined and nondomain-joined machines (previously, only nondomain-joined machines were supported). |
| **Trusted network detection**  | Always On VPN includes this feature to ensure that VPN connectivity is not triggered if a user is connected to a trusted network within the corporate boundary. You can combine this feature with any of the triggering methods mentioned earlier to provide a seamless "only connect when needed" user experience. |
| **[Device Tunnel](../vpn-device-tunnel-config.md)** | Always On VPN gives you the ability to create a dedicated VPN profile for device or machine. Unlike *User Tunnel*, which only connects after a user logs on to the device or machine, *Device Tunnel* allows the VPN to establish connectivity before user sign-in. Both Device Tunnel and User Tunnel operate independently with their VPN profiles, can be connected at the same time, and can use different authentication methods and other VPN configuration settings as appropriate. For information on how to configure a device tunnel, including information on how to use manage-out to dynamically register client IP addresses in DNS, see [Configure an Always On VPN device tunnel](/azure/vpn-gateway/vpn-gateway-howto-always-on-device-tunnel). |
|**Determine intranet connectivity**| Trusted network detection provides the capability to detect corporate network connections, and it is based on an assessment of the connection-specific DNS suffix assigned to network interfaces and network profile. For more information, see [Create custom Intune profiles to deploy VPN client profiles](/azure/vpn-gateway/vpn-profile-intune).|
|**Connectivity Assistant** | Always On VPN is fully integrated with the native Network Connectivity Assistant and provides connectivity status from the View All Networks interface. With the advent of Windows 10 Creators Update (version 1703), VPN connection status and VPN connection control for User Tunnel are now available through the Network flyout (for the Windows built-in VPN client), as well.                       |

## Networking features

Always On VPN supports the following networking features:

| Feature |  Description   |
|-------------------------------------------|--|
| **Dual-stack support for IPv4 and IPv6**  | Always On VPN natively supports the use of both IPv4 and IPv6 in a dual-stack approach. It has no specific dependency on one protocol over the other, which allows for maximum IPv4/IPv6 application compatibility combined with support for future IPv6 networking needs. |
| **Industry-standard IKEv2 VPN protocol support** |The Always On VPN client supports IKEv2, one of today's most widely used industry-standard tunneling protocols. This compatibility maximizes interoperability with third-party VPN gateways. |
| **Interoperability with third-party IKEv2 VPN gateways** | The Always On VPN client supports interoperability with third-party IKEv2 VPN gateways. You can also achieve interoperability with third-party VPN gateways by using a UWP VPN plug-in combined with a custom tunneling type without sacrificing Always On VPN platform features and benefits.<p><p>***Note:***<br>Consult with your gateway or third-party back-end appliance vendor on configurations and compatibility with Always On VPN and Device Tunnel using IKEv2. |
| **Application-specific routing policies** | In addition to defining global VPN connection routing policies for internet and intranet traffic separation, it's possible to add routing policies to control the use of split tunnel or force tunnel configurations on a per-application basis. This option gives you more granular control over which apps are allowed to interact with which resources through the VPN tunnel. |
|**Exclusion routes** | Always On VPN supports the ability to specify exclusion routes that specifically control routing behavior to define which traffic should traverse the VPN only and not go over the physical network interface.<p><p>***Notes:***<br>- Exclusion routes currently work for traffic within the same subnet as the client, for example, LinkLocal.<br>- Exclusion routes only work in a Split Tunnel setup.|
| **Fall back to SSTP from IKEv2** | You can configure fall back for clients that are behind firewalls or proxy servers by using the automatic tunnel/protocol type within the VPN profile.<p><p>***Note:***<br>User Tunnel supports SSTP and IKEv2, and Device Tunnel supports IKEv2 only, with no support for SSTP fallback.|
|**Support for multiple domains and forests**|The Always On VPN platform has no dependency on Active Directory Domain Services (AD DS) forests or domain topology (or associated functional/schema levels) because it doesn't require the VPN client to be domain joined to function. Group Policy is therefore not a dependency to define VPN profile settings because you do not use it during client configuration. Where Active Directory authorization integration is required, you can achieve it through RADIUS as part of the EAP authentication and authorization process.|
|**ame resolution of corporate resources using short-name, fully qualified domain name (FQDN), and DNS suffix**|Always On VPN can natively define one or more DNS suffixes as part of the VPN connection and IP address assignment process, including corporate resource name resolution for short names, FQDNs, or entire DNS namespaces. Always On VPN also supports the use of Name Resolution Policy Tables to provide namespace-specific resolution granularity.<p><p>***Note:***<br>Avoid the use of Global Suffixes as they interfere with shortname resolution when using Name Resolution Policy tables.|

<!-- Editor note:  Removed the following as it is more important during a how-to or are more detailed drill down.: <p>***Note:*** Before you get started, make sure to enable IPv6 on the VPN server. Otherwise, a connection cannot be established and an error message displays.-->

## Next steps

- [Install Remote Access as a VPN server](get-started-install-ras-as-vpn.md?tabs=powershell)
- [Tutorial: Deploy Always On VPN](tutorial-aovpn-deploy-setup.md)
