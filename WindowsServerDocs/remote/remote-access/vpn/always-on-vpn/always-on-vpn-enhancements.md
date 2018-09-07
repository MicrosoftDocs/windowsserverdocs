---
title: Always On VPN enhancements
description: Always On VPN has many benefits over the Windows VPN solutions of the past. Key improvements in integration, security, connectivity, networking control, and compatibility align Always On VPN with Microsoft's cloud-first, mobile-first vision. 
manager: elizapo
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: 
ms.author: pashort
author: shortpatti
ms.date: 05/29/2018
---

# Always On VPN enhancements

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

&#171; [**Previous:** Learn about the feature comparison between Always On VPN and DirectAccess](../vpn-map-da.md)<br>
&#187; [**Next:** Learn about the Always On VPN technology](always-on-vpn-technology-overview.md)

Always On VPN has many benefits over the Windows VPN solutions of the past. The following key improvements align Always On VPN with Microsoft’s cloud-first, mobile-first vision:

- **Platform Integration:** Always On VPN has improved integration with the Windows operating system and third-party solutions to provide a robust platform for countless advanced connection scenarios.
- **Security:** Always On VPN has new, advanced security capabilities to restrict the type of traffic, which applications can use the VPN connection, and which authentication methods you can use to initiate the connection. When the connection is active most of the time, it is especially important to secure the connection.
- **VPN Connectivity:** Always On VPN, with or without Device Tunnel, creates a persistent connection by using either user or device authentication. Before Always On VPN, the ability to create a persistent connection through either user or device authentication was not possible. 
- **Networking control:** Always On VPN allows administrators to specify routing policies at a more granular level—even down to the individual application—which is perfect for line-of-business (LOB) apps that require special remote access.  Always On VPN is also fully compatible with both Internet Protocol version 4 (IPv4) and version 6 (IPv6). Unlike DirectAccess, there is no specific dependency on IPv6.
  >[!Note]
  >Before you get started, make sure to enable IPv6 on the VPN server. Otherwise, a connection cannot be established and an error message displays.
- **Configuration and compatibility:** Always On VPN can be deployed and managed several ways, which gives Always On VPN several advantages over the other VPN client software. 

## Platform integration

Microsoft has introduced or improved the following integration capabilities in Always On VPN:

| Key improvement | Description |
| ---- | ---- |
| **[Windows Information Protection (WIP)](https://docs.microsoft.com/en-us/windows/threat-protection/windows-information-protection/protect-enterprise-data-using-wip)** | Integration with WIP allows network policy enforcement to determine whether traffic is permitted to go over the VPN. If the user profile is active and WIP policies are applied, Always On VPN is automatically triggered to connect. Also, when you use WIP, there's no need to specify AppTriggerList and TrafficFilterList rules separately in the VPN profile (unless you want more advanced configuration) because the WIP policies and application lists automatically take effect. |
| **[Windows Hello for Business](https://docs.microsoft.com/en-us/windows/access-protection/hello-for-business/hello-overview)** | Always On VPN natively supports Windows Hello for Business (in certificate-based authentication mode) to provide a seamless single sign-on experience for both sign-in to the machine and connection to the VPN. Therefore, no secondary authentication (user credentials) is needed for the VPN connection, making it possible to use an Always On connection with Windows Hello for Business authentication. |
| **[Microsoft Azure conditional access](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-controls)** | The Always On VPN client can integrate with the Azure conditional access platform to enforce multifactor authentication (MFA), device compliance, or a combination of the two. When compliant with conditional access policies, Azure Active Directory (Azure AD) issues a short-lived (by default, 60 minutes) IP Security (IPsec) authentication certificate that can then be used to authenticate to the VPN gateway. Device compliance uses System Center Configuration Manager/Intune compliance policies, which can include the device health attestation state as part of the connection compliance check. |
| **Azure MFA** | When combined with Remote Authentication Dial-In User Service (RADIUS) services and the Network Policy Server (NPS) extension for Azure MFA, VPN authentication can use strong MFA. |
| **Third-party VPN plug-in** | With the Universal Windows Platform (UWP), third-party VPN providers can create a single application for the full range of Windows 10 devices. The UWP provides a guaranteed core API layer across devices, eliminating the complexity of and problems often associated with writing kernel-level drivers. Currently, Windows 10 UWP VPN plug-ins exist for [Pulse Secure](https://www.microsoft.com/en-us/p/pulse-secure/9nblggh3b0bp), [F5 Access](https://www.microsoft.com/en-us/p/f5-access/9wzdncrdsfn0), [Check Point Capsule VPN](https://www.microsoft.com/en-us/p/check-point-capsule-vpn/9wzdncrdjxtj), [FortiClient](https://www.microsoft.com/en-us/p/forticlient/9wzdncrdh6mc), [SonicWall Mobile Connect](https://www.microsoft.com/en-us/p/sonicwall-mobile-connect/9wzdncrdsfkz), and [GlobalProtect](https://www.microsoft.com/en-us/p/globalprotect/9nblggh6bzl3); no doubt, others will appear in the future. |

---

## Security

The primary improvements in security are in the following areas:

| Key improvement | Description |
| ---- | ---- |
| **Traffic filters** | Through traffic filters, you can specify client-side policies that determine which traffic is allowed into the corporate network. In this way, administrators can apply app or traffic restrictions on the VPN interface, limiting its use to certain sources, destination ports, and IP addresses. Two types of filtering rules are available:<ul><li>**App-based rules.** App-based firewall rules are based on a list of specified applications so that only traffic originating from these apps are permitted to go over the VPN interface.</li><li>**Traffic-based rules.** Traffic-based firewall rules are based on network requirements like ports, addresses, and protocols. Use these rules to require that only traffic that matches these specific conditions are permitted to go over the VPN interface.</li></ul> |
| **LockDown VPN** | LockDown VPN secures the device to allow only network traffic over the VPN interface and provides a configuration option suitable for highly security-conscious organizations. |
| **Per-App VPN** | Per-App VPN is like having an app-based traffic filter, but it goes farther to combine application triggers with an app-based traffic filter so that VPN connectivity is constrained to a specific application as opposed to all applications on the VPN client. The feature is automatically initiated when the app starts. |
| **Support for customized IPsec cryptography algorithms** | Always On VPN supports the use of both RSA and elliptic curve cryptography–based custom cryptographic algorithms to meet stringent government or organizational security policies. |
| **Native Extensible Authentication Protocol (EAP) support** | Always On VPN natively supports EAP, which allows you to use a diverse set of Microsoft and third-party EAP types as part of the authentication workflow. EAP provides secure authentication based on the following authentication types:<ul><li>User name and password</li><li>Smart card (both physical and virtual)</li><li>User or machines certificates</li><li>Windows Hello for Business</li><li>One-time password (OTP) or MFA support by way of EAP RADIUS integration</li></ul>The application vendor controls third-party UWP VPN plug-in authentication methods, although they have an array of available options, including custom credential types and OTP support. |

---

##<a name="vpn-connectivity"></a> VPN connectivity

The following are the primary improvements in Always On VPN connectivity:

| Key improvement | Description |
| ---- | ---- |
| **Always On** | Always On is a Windows 10 feature that enables the active VPN profile to connect automatically and remain connected based on triggers—namely, user sign-in, network state change, or device screen active. Always On is also integrated into the connected standby experience to maximize battery life. |
| **Application triggering** | You can configure VPN profiles in Windows 10 to connect automatically on the launch of a specified set of applications. You can configure both desktop and UWP applications to trigger a VPN connection. |
| **Name-based triggering** | With Always On VPN, you can define rules so that specific domain name queries trigger the VPN connection. Windows 10 now supports name-based triggering for domain-joined and nondomain-joined machines (previously, only nondomain-joined machines were supported). |
| **Trusted network detection** | Always On VPN includes this feature to ensure that VPN connectivity is not triggered if a user is connected to a trusted network within the corporate boundary. You can combine this feature with any of the triggering methods mentioned earlier to provide a seamless "only connect when needed" user experience. |
| **[Device Tunnel](../vpn-device-tunnel-config.md)** | Always On VPN gives you the ability to create a dedicated VPN profile for device or machine. Unlike _User Tunnel_, which only connects after a user logs on to the device or machine, _Device Tunnel_ allows the VPN to establish connectivity before user sign-in. Additionally, Device Tunnel provides feature parity with the _Infrastructure Tunnel_ concept of DirectAccess. You can use traffic filters to control which corporate resources as available through the Device Tunnel and when machine certificate authentication is employed. Both Device Tunnel and User Tunnel operate independently with their VPN profiles, can be connected at the same time, and can use different authentication methods and other VPN configuration settings as appropriate. |

---

## Networking

The following are some of the networking improvements in Always On VPN:

| Key improvement | Description |
| ---- | ---- |
| **Dual-stack support for IPv4 and IPv6** | Always On VPN natively supports the use of both IPv4 and IPv6 in a dual-stack approach. It has no specific dependency on one protocol over the other, which allows for maximum IPv4/IPv6 application compatibility combined with support for future IPv6 networking needs.<p>**_Note._** Before you get started, make sure to enable IPv6 on the VPN server. Otherwise, a connection cannot be established and an error message displays.|
| **Application-specific routing policies** | In addition to defining global VPN connection routing policies for internet and intranet traffic separation, it is possible to add routing policies to control the use of split tunnel or force tunnel configurations on a per-application basis. This option gives you more granular control over which apps are allowed to interact with which resources through the VPN tunnel. |
| **Exclusion routes** | Always On VPN supports the ability to specify exclusion routes that specifically control routing behavior to define which traffic should traverse the VPN only and not go over the physical network interface.<br><br>**Important.** Exclusion routes only work in a Split Tunnel setup. |

---

## Configuration and compatibility
The following are some of the configuration and compatibility improvements in Always On VPN:

| Key improvement | Description |
| ---- | ---- |
| **Third-party VPN gateway compatibility** | The Always On VPN client does not require the use of a Microsoft-based VPN gateway to operate. Through the support of the IKEv2 protocol, the client facilitates interoperability with third-party VPN gateways that support this industry-standard tunneling type. Always On VPN also has backward-compatibility with Secure Socket Tunneling Protocol (SSTP), Layer 2 Tunneling Protocol/IPsec, and Point-to-Point Tunneling Protocol. You can also achieve interoperability with third-party VPN gateways by using a UWP VPN plug-in combined with a custom tunneling type without sacrificing Always On VPN platform features and benefits. |
| **Industry-standard IKEv2 VPN protocol support** | The Always On VPN client supports IKEv2, one of today's most widely used industry-standard tunneling protocols. This compatibility maximizes interoperability with third-party VPN gateways. |
| **Platform support** | Always On VPN supports domain-joined, nondomain-joined (workgroup), or Azure AD–joined devices to allow for both enterprise and bring your own device (BYOD) scenarios. Also, Always On VPN is available in all Windows editions. |
| **Diverse management and deployment mechanisms** | You can use many management and deployment mechanisms to manage VPN settings (called a *VPN profile*), including Windows PowerShell, System Center Configuration Manager, Intune (or third-party mobile device management [MDM] tool), and Windows Configuration Designer. These options simplify the configuration of Always On VPN regardless of the client management tools you use. |
| **Standardized VPN profile definition** | Always On VPN supports configuration using a standard XML profile (ProfileXML), providing a standard configuration template format that most management and deployment toolsets use. |



## Next step
|If you want to...  |Then see...  |
|---------|---------|
|Learn more about the Always On VPN technology     |[Always On VPN Technology Overview](always-on-vpn-technology-overview.md): This page provides a brief overview of the Always On VPN technologies with links to detailed documents.         |
|Learn more about the Always On VPN advanced features  |[Advanced Features of Always On VPN](deploy/always-on-vpn-adv-options.md): This page provides guidance on how to enable VPN Traffic Filters, how to configure Automatic VPN connections using App-Triggers, and how to configure NPS to only allow VPN Connections from clients using certificates issued by Azure AD.         |
|Migrate from DirectAccess to Always On VPN  |[DirectAccess to Always On VPN migration overview](../../da-always-on-vpn-migration/da-always-on-migration-overview.md): If you are migrating from DirectAccess to Always On VPN, you must properly plan your migration phases before deploying Always On VPN.  Planning your migration phases helps identify any issues before they affect the entire organization. The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process. If you perform tasks out of order, a race condition may occur, leaving remote users with no way to access company resources.         |
|Start planning your Always On VPN deployment |[Step 1. Plan the Always On VPN Deployment](deploy/always-on-vpn-deploy-planning.md): Before you install the Remote Access server role on the computer you're planning on using as a VPN server, perform the following tasks. After proper planning, you can deploy Always On VPN, and optionally configure conditional access for VPN connectivity using Azure AD.  |



---