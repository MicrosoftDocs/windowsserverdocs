---
title: About Always On VPN for Windows Server Remote Access
description: Learn about Always On VPN benefits over standard Windows VPN solutions. Key areas in integration, security, connectivity, networking control, and compatibility align Always On VPN with Microsoft's cloud-first, mobile-first vision.
ms.topic: article
ms.author: wscontent
author: anaharris-ms
ms.date: 04/28/2023
---

# About Always On VPN

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10+

Always On VPN allows you to:

- **Create advanced scenarios** by integrating Windows operating systems and third-party solutions. For a list of supported integrations, see [Supported integrations](#supported-integrations).

- **Maintain network security**, restricting connection by traffic types, applications, and authentication methods. For a list of Always On VPN security features, see [Security features](#security-features).

- **Configure auto-triggering** for user and device authenticated connections. For more information, see [Connectivity features](#connectivity-features).

- **Control your network** by creating routing policies at a granular level; even down to the individual application.  For more information, see [Networking features](#networking-features).

- **Configure your VPN settings** with a standard XML profile (ProfileXML) which is defined by an industry standard configuration template. You can deploy and manage your VPN settings with Windows PowerShell, Microsoft Endpoint Configuration Manager, Intune, Windows Configuration Designer, or any third-party mobile device management (MDM) tool.

## Supported integrations

Always On VPN supports domain-joined, nondomain-joined (workgroup), or Azure AD–joined devices to allow for both enterprise and BYOD scenarios. Always On VPN is available in all Windows editions, and the platform features are available to third parties by way of UWP VPN plug-in support.

Always On VPN supports integration with the following platforms:

- [**Windows Information Protection (WIP).**](/windows/threat-protection/windows-information-protection/protect-enterprise-data-using-wip) Integration with WIP allows network policy enforcement to determine whether traffic is permitted to go over the VPN. If the user profile is active and WIP policies are applied, Always On VPN is automatically triggered to connect. Also, when you use WIP, there's no need to specify `AppTriggerList` and `TrafficFilterList` rules separately in the VPN profile (unless you want more advanced configuration) because the WIP policies and application lists automatically take effect.

- [**Windows Hello for Business.**](/windows/access-protection/hello-for-business/hello-overview) Always On VPN natively supports Windows Hello for Business in certificate-based authentication mode. The native Windows Hello support provides a seamless single sign-on experience for both sign-in to the machine, as well as connection to the VPN. No secondary authentication (user credentials) is needed for the VPN connection.

- [**Microsoft Azure conditional access platform.**](/azure/active-directory/active-directory-conditional-access-controls) The Always On VPN client can integrate with the Azure conditional access platform to enforce multifactor authentication (MFA), device compliance, or a combination of the two. When compliant with conditional access policies, Azure Active Directory (Azure AD) issues a short-lived (by default, sixty minutes) IP Security (IPsec) authentication certificate. The IPSec certificate can then be used to authenticate to the VPN gateway. Device compliance uses Configuration Manager/Intune compliance policies, which can include the device health attestation state as part of the connection compliance check. For more details, see [VPN and conditional access](/windows/security/identity-protection/vpn/vpn-conditional-access)

- [**Azure AD Multi-Factor Authentication platform.**](/azure/active-directory/authentication/concept-mfa-howitworks) When combined with Remote Authentication Dial-In User Service (RADIUS) services and the Network Policy Server (NPS) extension for Azure AD Multi-Factor Authentication, VPN authentication can use strong MFA.

- **Third-party VPN plug-ins.**  With the Universal Windows Platform (UWP), third-party VPN providers can create a single application for the full range of Windows devices. The UWP provides a guaranteed core API layer across devices, eliminating the complexity of and problems often associated with writing kernel-level drivers. Currently, Windows UWP VPN plug-ins exist for [Pulse Secure](https://www.microsoft.com/p/pulse-secure/9nblggh3b0bp), [F5 Access](https://www.microsoft.com/p/f5-access/9wzdncrdsfn0), [Check Point Capsule VPN](https://www.microsoft.com/p/check-point-capsule-vpn/9wzdncrdjxtj), [FortiClient](https://www.microsoft.com/p/forticlient/9wzdncrdh6mc), [SonicWall Mobile Connect](https://www.microsoft.com/p/sonicwall-mobile-connect/9wzdncrdsfkz), and [GlobalProtect](https://www.microsoft.com/p/globalprotect/9nblggh6bzl3).

## Security features

Always On VPN provides connectivity to corporate resources by using tunnel policies that require authentication and encryption until they reach the VPN gateway. By default, the tunnel sessions terminate at the VPN gateway, which also functions as the IKEv2 gateway, providing end-to-edge security.

For details about standard VPN authentication options, see [VPN authentication options](/windows/security/identity-protection/vpn/vpn-authentication).

Always On VPN supports the following security features:

- **Industry-standard IKEv2 VPN protocol support.** The Always On VPN client supports IKEv2, one of today's most widely used industry-standard tunneling protocols. This compatibility maximizes interoperability with third-party VPN gateways.

- **Interoperability with third-party IKEv2 VPN gateways.** The Always On VPN client supports interoperability with third-party IKEv2 VPN gateways. You can also achieve interoperability with third-party VPN gateways by using a UWP VPN plug-in combined with a custom tunneling type without sacrificing Always On VPN platform features and benefits.

    >[!NOTE]
    >Consult with your gateway or third-party back-end appliance vendor on configurations and compatibility with Always On VPN and Device Tunnel using IKEv2.

- **Fall back to SSTP from IKEv2.** You can configure fall back for clients that are behind firewalls or proxy servers by using the automatic tunnel/protocol type within the VPN profile.

    >[!NOTE]
    >User Tunnel supports SSTP and IKEv2, and Device Tunnel supports IKEv2 only, with no support for SSTP fallback.

- **Support for machine certificate authentication.** The IKEv2 protocol type available as part of the Always On VPN platform specifically supports the use of machine or computer certificates for VPN authentication.

    >[!NOTE]
    >IKEv2 is the only supported protocol for Device Tunnel and there is no support option for SSTP fallback. For more information see,  [Configure an Always On VPN device tunnel](/windows-server/remote/remote-access/vpn/vpn-device-tunnel-config).

- **Traffic and app filters.** With traffic and app firewall rules, you can specify client-side policies that determine which traffic and apps are allowed to connect to the VPN interface. 

    Two types of filtering rules are available:
    - **App-based rules.** App-based firewall rules are based on a list of specified applications so that only traffic originating from these apps are permitted to go over the VPN interface.

    - **Traffic-based rules.** Traffic-based firewall rules are based on network requirements like ports, addresses, and protocols. Use these rules only for traffic that matches these specific conditions are permitted to go over the VPN interface.

    >[!NOTE]
    >These rules apply only to traffic outbound from the device. Use of traffic filters blocks inbound traffic from the corporate network to the client.

- **VPN conditional access.** Conditional access and device compliance can require managed devices to meet standards before they can connect to the VPN. VPN conditional access allows you to restrict the VPN connections to the devices whose client authentication certificate contains the Azure AD Conditional Access OID of `1.3.6.1.4.1.311.87`. To learn how to restrict the VPN connections directly on the NPS server, see [Configure VPN conditional access on the Network Policy Server](how-to-always-on-vpn-conditional-access-network-policy-server.md). To learn how to restrict the VPN connections with [Azure Active Directory (Azure AD) conditional access](/azure/active-directory/active-directory-conditional-access-azure-portal), see [Conditional access for VPN connectivity using Azure AD](how-to-aovpn-conditional-access.md).

- **Limit remote access to specific users and devices.** You can configure Always On VPN to support granular authorization when using RADIUS, which includes the use of security groups to control VPN access.

- **Define accessible management servers before user sign-in.** Use the Device Tunnel feature (available in version 1709 – for IKEv2 only) in the VPN profile combined with traffic filters to control which management systems on the corporate network are accessible through the Device Tunnel.

    >[!NOTE]
    >If you turn on traffic filters in the Device Tunnel profile, then the Device Tunnel denies inbound traffic (from the corporate network to the client).

- **Per-app VPN.** Per-app VPN is like having an app-based traffic filter, but it goes farther to combine application triggers with an app-based traffic filter so that VPN connectivity is constrained to a specific application as opposed to all applications on the VPN client. The feature automatically initiates when the app starts.

- **Customized IPsec cryptography algorithms.** Always On VPN supports the use of both RSA and elliptic curve cryptography–based custom cryptographic algorithms to meet stringent government or organizational security policies.

- **Native Extensible Authentication Protocol (EAP) support.** Always On VPN natively supports EAP, which allows you to use a diverse set of Microsoft and third-party EAP types as part of the authentication workflow. EAP provides secure authentication based on the following authentication types:

    - Username and password
    - Smart card (both physical and virtual)
    - User certificates
    - Windows Hello for Business
    - MFA support by way of EAP RADIUS integration
    
    The application vendor controls third-party UWP VPN plug-in authentication methods, although they have an array of available options, including custom credential types and OTP support.

- **Windows Hello for Business two-factor authentication on PCs and mobile devices.** In Windows 10, [Windows Hello for Business](/windows/access-protection/hello-for-business/hello-identity-verification) replaces passwords by providing strong two-factor authentication on PCs and mobile devices. For more information, see [Enabling Remote Access with Windows Hello for Business in Windows 10](/previous-versions/mt728163(v=technet.10))

- **Azure Multifactor Authentication (MFA).** Azure AD Multi-Factor Authentication has cloud and on-premises versions that you can integrate with the Windows VPN authentication mechanism. For more information, see [Integrate RADIUS authentication with Azure AD Multi-Factor Authentication Server](/azure/multi-factor-authentication/multi-factor-authentication-get-started-server-radius).

- **Trusted Platform Module (TPM) Key Attestation.** A user certificate that has a TPM-attested key provides higher security assurance, backed up by non-exportability, anti-hammering, and isolation of keys provided by the TPM.

For more information about TPM key attestation in Windows 10, see [TPM Key Attestation](../../identity/ad-ds/manage/component-updates/tpm-key-attestation.md).

## Connectivity features

Always On VPN supports the following connectivity features:

- **Application auto-triggering.** You can configure Always On VPN to support auto-triggering based on application launch or namespace resolution requests. For more information on how to configure auto-triggering, see [VPN auto-triggered profile options](/windows/security/identity-protection/vpn/vpn-auto-trigger-profile).

- **Name-based auto-triggering.** With Always On VPN, you can define rules so that specific domain name queries trigger the VPN connection. Windows devices support name-based triggering for domain-joined and nondomain-joined machines (previously, only nondomain-joined machines were supported).

- **Trusted network detection.** Always On VPN includes this feature to ensure that VPN connectivity isn't triggered if a user is connected to a trusted network within the corporate boundary. You can combine this feature with any of the triggering methods mentioned earlier to provide a seamless "only connect when needed" user experience.

- **[Device Tunnel](./vpn/vpn-device-tunnel-config.md).** Always On VPN gives you the ability to create a dedicated VPN profile for device or machine. Unlike *User Tunnel*, which only connects after a user logs on to the device or machine, *Device Tunnel* allows the VPN to establish connectivity before user sign-in. Both Device Tunnel and User Tunnel operate independently with their VPN profiles, can be connected at the same time, and can use different authentication methods and other VPN configuration settings as appropriate. For information on how to configure a device tunnel, including information on how to use manage-out to dynamically register client IP addresses in DNS, see [Configure an Always On VPN device tunnel](/windows-server/remote/remote-access/vpn/vpn-device-tunnel-config).

    >[!NOTE]
    >Device Tunnel can only be configured on domain-joined devices running Windows 10 Enterprise or Education version 1709 or later. There's no support for third-party control of the Device Tunnel.

- **Connectivity Assistant** Always On VPN is fully integrated with the native Network Connectivity Assistant and provides connectivity status from the View All Networks interface. With the advent of Windows 10 Creators Update (version 1703), VPN connection status and VPN connection control for User Tunnel are available through the Network flyout (for the Windows built-in VPN client).

## Networking features

Always On VPN supports the following networking features:

- **Dual-stack support for IPv4 and IPv6.** Always On VPN natively supports the use of both IPv4 and IPv6 in a dual-stack approach. It has no specific dependency on one protocol over the other, which allows for maximum IPv4/IPv6 application compatibility combined with support for future IPv6 networking needs.

- **Application-specific routing policies.** In addition to defining global VPN connection routing policies for internet and intranet traffic separation, it's possible to add routing policies to control the use of split tunnel or force tunnel configurations on a per-application basis. This option gives you more granular control over which apps are allowed to interact with which resources through the VPN tunnel.

- **Exclusion routes.** Always On VPN supports the ability to specify exclusion routes that specifically control routing behavior to define which traffic should traverse the VPN only and not go over the physical network interface.

    >[!NOTE]
    >Exclusion routes work for traffic within the same subnet as the client such as LinkLocal. Exclusion routes only work in a Split Tunnel setup.

- **Support for multiple domains and forests.** The Always On VPN platform has no dependency on Active Directory Domain Services (AD DS) forests or domain topology (or associated functional/schema levels) because it doesn't require the VPN client to be domain joined to function. Group Policy is therefore not a dependency to define VPN profile settings because you don't use it during client configuration. Where Active Directory authorization integration is required, you can achieve it through RADIUS as part of the EAP authentication and authorization process.

- **Name resolution of corporate resources** using short-name, fully qualified domain name (FQDN), and DNS suffix.Always On VPN can natively define one or more DNS suffixes as part of the VPN connection and IP address assignment process, including corporate resource name resolution for short names, FQDNs, or entire DNS namespaces. Always On VPN also supports the use of Name Resolution Policy Tables to provide namespace-specific resolution granularity.

    >[!NOTE]
    >Avoid the use of Global Suffixes as they interfere with shortname resolution when using Name Resolution Policy tables.

## High availability features

The following are more options for high availability.

**Server resilience and load balancing.** In environments that require high availability or support large numbers of requests, you can increase the performance and resiliency of Remote Access by configuring [load balancing between Network Policy Servers (NPS)](/windows-server/networking/technologies/nps/nps-manage-proxy-lb) and by [enabling Remote Access server clustering](ras/cluster/deploy-remote-access-in-cluster.md).

**Geographic site resilience.** For IP-based geolocation, you can use Global Traffic Manager with DNS in Windows Server. For more robust geographic load balancing, you can use Global Server Load Balancing solutions, such as [Microsoft Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview).

## Next steps

- [Install Remote Access as a VPN server](get-started-install-ras-as-vpn.md?tabs=powershell)

- [Tutorial: Deploy Always On VPN](tutorial-aovpn-deploy-setup.md)

- [VPN security features](/windows/access-protection/vpn/vpn-security-features): This topic provides an overview of VPN security guidelines for LockDown VPN, Windows Information Protection (WIP) integration with VPN, and traffic filters.

- [VPN auto-triggered profile options](/windows/access-protection/vpn/vpn-auto-trigger-profile): This topic provides an overview of VPN auto-triggered profile options, such as app trigger, name-based trigger, and Always On.

- [Troubleshoot Always On VPN](/troubleshoot/windows-server/networking/troubleshoot-always-on-vpn)
