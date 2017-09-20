---
title: Virtual Private Networking (VPN)
description: You can use this topic to learn about Windows Server 2016 and Windows 10 VPN features and functionality.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: cd4908f0-0d6f-4c02-8f98-4dc88c3dcb65
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Virtual Private Networking \(VPN\)

>Applies To: Windows Server 2016, Windows 10

You can use this topic to learn about Windows Server 2016 and Windows 10 VPN features and functionality.

>[!NOTE]
>In addition to this topic, the following VPN documentation is available.
>
>- [Always On VPN and DirectAccess Features Comparison](vpn-map-da.md)
>- [Remote Access Always On VPN Deployment Guide for Windows Server 2016 and Windows 10](always-on-vpn/deploy/always-on-vpn-deploy.md)
>- Windows 10 [VPN technical guide](https://docs.microsoft.com/windows/access-protection/vpn/vpn-guide)

## RAS Gateway as a Single Tenant VPN Server

In Windows Server 2016, the Remote Access server role is a logical grouping of the following related network access technologies.

- Remote Access Service (RAS)
- Routing
- Web Application Proxy

These technologies are the role services of the Remote Access server role. 

When you install the Remote Access server role with the Add Roles and Features Wizard or Windows PowerShell, you can install one or more of these three role services.

When you install the **DirectAccess and VPN \(RAS\)** role service, you are deploying the Remote Access Service Gateway \(**RAS Gateway**\). You can deploy RAS Gateway as a single tenant RAS Gateway virtual private network \(VPN\) server that provides many advanced features and enhanced functionality.

>[!NOTE]
>You can also deploy RAS Gateway as a Multitenant VPN server for use with Software Defined Networking \(SDN\), or as a DirectAccess server. For more information, see [RAS Gateway](https://docs.microsoft.com/windows-server/remote/remote-access/ras-gateway/ras-gateway), [Software Defined Networking (SDN)](https://docs.microsoft.com/windows-server/networking/sdn/software-defined-networking), and [DirectAccess](https://docs.microsoft.com/windows-server/remote/remote-access/directaccess/directaccess).

VPN advanced features and enhanced functionality are described in the following sections.

## Advanced Platform Integration

Following are the Advanced Platform Integration features for Windows 10 VPN.

### Windows Information Protection \(WIP\) Integration

Integration with Windows Information Protection \(formerly known as Enterprise Data Protection\) allows network policy enforcement to determine if the traffic is allowed to go over the VPN. If the profile is active, it also automatically triggers the VPN to connect. Additionally, when using WIP there is no need to specify AppTriggerList and TrafficFilterList rules separately in the VPN profile \(unless more advanced config is needed\) because the WIP policies and Application lists automatically take effect.

### Windows Hello for Business Integration

The Windows 10 VPN natively supports the use of Windows Hello for Business \(in certificate-based authentication mode\) to provide a seamless single sign-on experience for both logon to the machine and simultaneous connection to the VPN.

### Azure Conditional Access Integration

The Windows 10 VPN client is able to integrate with the Azure Conditional Access Platform to enforce multi-factor authentication, enforce device compliance, or a combination of both. When compliant with conditional access policies, Azure AD will issue a short-lived \(60 mins by default\) IPsec authentication certificate that can then be used to authenticate to the VPN gateway. Device compliance leverages Microsoft Configuration Manager/Intune Compliance Policies which includes the ability to includes the device health attestation state as part of the connection compliance check.

### Azure Multi-Factor Authentication \(MFA\) Integration

When combined with RADIUS services and the Network Policy Server \(NPS\) extension for Azure MFA, VPN authentication can utilize strong multi-factor authentication.

### Third-Party VPN Plug-in Integration

Using the UWP platform, third-party VPN providers can create app-containerized plug-ins using WinRT APIs, eliminating the complexity and problems often associated with writing kernel-level drivers. At the time of writing, the following Windows 10 UWP VPN plug-ins are available: Pulse Secure, F5 Access, Check Point Capsule VPN , FortiClient and SonicWall Mobile Connect.


## Advanced Security

Following are the Advanced Security features for Windows 10 VPN.

### Traffic Filters

Traffic Filters provide the ability to decide what traffic is allowed into the corporate network based on policy; effectively providing the capability to add interface specific firewall rules on the VPN Interface. With app-based firewall rules, a list of applications can be marked such that only traffic originating from these apps is allowed to go over the VPN interface. Traffic-based firewall rules are 5-tuple policies \(ports, addresses, protocol\) that can be specified such that only traffic matching these rules is allowed to go over the VPN interface.

### Lockdown VPN

A VPN profile configured with LockDown VPN secures the device to only allow network traffic over the VPN interface and provides a configuration option suitable for highly security-conscious organizations.

### Per Application VPN

Per Application VPN is essentially a special traffic filter that combines application triggers with an application-specific traffic filter so that VPN connectivity is constrained to a specific application, as opposed to all applications on the VPN client. 

### Support for Customized IPsec Cryptography Algorithms

The Windows 10 VPN platform supports the use of both RSA and ECC-based custom cryptographic algorithms in order to meet stringent Government, or similar, organizational security policies.

### Native Extensible Authentication Protocol \(EAP\) Support

The Windows 10 VPN platform natively supports the Extensible Authentication Protocol \(EAP\) which allows for a diverse set of both Microsoft and third-party EAP types to be used as part of the authentication workflow. EAP provides secure authentication using both user name and password, and certificate-based methods, amongst other types.

### Support for Flexible, Strong Authentication and Authorization

The Windows 10 VPN platform natively supports the following authentication/authorization options.

- User name and password
- Smart Card \(both physical and virtual)
- User or Machines Certificate
- Windows Hello for Business Certificate
- One-time password or multi-factor authentication support by way of EAP RADIUS integration.

Third-party UWP VPN plug-in authentication methods are controlled by the application vendor, although these include a diverse array of available options including custom credential types and One-Time password \(OTP\) support.

## Advanced VPN Connectivity

Following are the Advanced VPN Connectivity features for Windows 10 VPN.

### Always On

Always On enables the active VPN profile to connect automatically and remain permanently connected based on the following triggers: User sign-in, Network state change or Device screen active. 

Always On is also integrated with the Connected Standby experience to maximize battery life.

It is recommended that you use Always On VPN instead of DirectAccess. 

For information on deploying Always On VPN, see [Remote Access Always On VPN Deployment Guide for Windows Server 2016 and Windows 10](always-on-vpn/deploy/always-on-vpn-deploy.md).

### Application Triggering

VPN profiles in Windows 10 can be configured to connect automatically on the launch of a specified set of applications. Both desktop and Universal Windows Platform \(UWP\) applications can be configured to trigger a VPN connection.

### Name-based Triggering

Windows 10 VPN allows rules to be defined so that specific domain name queries will trigger the VPN connection. Windows 10 now supports name-based triggering for domain joined machines \(previously only non-domain joined machines were supported).

### Trusted Network Detection

Windows 10 VPN includes this feature to ensure that VPN connectivity is not triggered if a user is connected to a trusted network within the corporate boundary. This feature can be combined with any of the above triggering methods to provide a seamless ‘only connect when needed’ user experience.

## Advanced Networking

Following are the Advanced Networking features for Windows 10 VPN.

### Dual Stack Support for Both IPv4 and IPv6 Protocols

The Windows 10 VPN natively supports the use of both IPv4 and IPv6 protocols in a ‘dual stack’ approach and has no specific dependency on one protocol over the other. This allows for maximum IPv4/IPv6 application compatibility combined with support for future IPv6 networking needs. Unlike DirectAccess, there is no specific dependency on IPv6.

### Application-specific Routing Policies

In addition to defining global VPN connection routing policies for Internet and intranet traffic separation, it is also possible to add routing policies to control the use of split tunnel or force tunnel use on a per-application basis.

### Exclusion Routes

Windows 10 VPN platform supports the ability to specify exclusion routes that specifically control routing behavior to define which traffic should only ever traverse the VPN and not go over the physical network interface.

## Advanced Interoperability

Following are the Advanced Interoperability features for Windows 10 VPN.

### Third-Party VPN Gateway Interoperability

The Windows 10 VPN client does not require the use of a Microsoft-based VPN gateway to operate, and through support of the IKEv2 protocol, allows for interoperability with third-party VPN gateways that support this industry-standard tunneling type. 

Backward combability is also provided for SSTP, L2TP/IPsec and PPTP protocols.

Interoperability with third-party VPN gateways can also be achieved by way of using a UWP VPN plug-in combined with a custom tunneling type, without sacrificing Windows 10 VPN platform features and benefits.

### Industry-Standard IKEv2 VPN Protocol Support

The Windows 10 VPN client supports the use of IKEv2 which is probably the most industry-standard tunneling protocol used by many VPN providers. This ensures maximum interoperability with third-party VPN gateways whilst still maintaining all of the Windows 10 VPN platform features.

### Platform Support 

Windows 10 VPN supports both domain-joined and non-domain joined \(workgroup or Azure AD joined\) VPN clients to allow for Enterprise and BYOD scenarios alike.

Windows 10 VPN is also available in all SKUs of Windows and the platform features are also available to third-parties by way of UWP VPN plug-in support.

## Advanced Manageability

Following are the Advanced Manageability features for Windows 10 VPN.

### Diverse Management and Deployment Mechanisms

Management of VPN settings \(called a VPN profile\) can be achieved using a diverse list of management and deployment mechanisms. These include PowerShell, System Centre Configuration Manager, Microsoft Intune \(or third-party MDM provider\) and the Windows Configuration Designer tool.

### Standardized VPN Profile Definition

Windows 10 VPN supports the collation of all VPN settings into a single standardized XML format which can be used by the different management and deployment toolsets to define the VPN profile as single, homogenous XML blob.

