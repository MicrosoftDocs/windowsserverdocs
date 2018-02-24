---
title: Remote Access Always On VPN Deployment Guide for Windows Server and Windows 10
description: You can use this guide to deploy Always On Virtual Private Network (VPN) connections for remote employees by using Remote Access in Windows Server 2016 or later and Always On VPN profiles for Windows 10 client computers.
ms.prod: windows-server-threshold
ms.technology: networking, remote access, vpn
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Always On VPN Deployment Guide for Windows Server and Windows 10

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in). Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess. Always On VPN addresses the previous gaps between Windows VPNs and DirectAccess.

Upon completion of this Lesson, you will be able to do the following:
*	Plan and stage your environment 
*	Configure the Always On VPN Server Infrastructure
*	Configure the Remote Access Server for Always On VPN
*	Install and configure the Network Policy Server (NPS)
*	Configure DNS and Firewall settings for Always On VPN
*	Configure Always On VPN connections on Windows 10


>[!IMPORTANT]
>This guide is designed for deploying Always On VPN with the Remote Access server role on an on\-premises organization network. Do not attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## Benefits of Always On VPN

Always On VPN has many benefits over the Windows VPN solutions of the past. Key improvements in integration, security, connectivity, networking control, and compatibility align Always On VPN with Microsoft's cloud-first, mobile-first vision.

Because many of the devices that require remote access are personal devices, Always On VPN does not require that a device be domain joined. When you migrate domain-joined devices that use DirectAccess, Always On VPN can provide a single, cohesive solution for remote access for all your connected devices going forward, even personally owned devices. Also, organizations can choose which management platform they prefer for deploying the Always On VPN configuration because the CSP is not vendor specific.

For additional details about the advantages of Always On VPN, see [Always On VPN and DirectAccess Features Comparison](https://docs.microsoft.com/windows-server/remote/remote-access/vpn/vpn-map-da).

### Platform integration

Always On VPN has improved integration with the Windows operating system and third-party solutions to provide a robust platform for countless advanced connection scenarios. Microsoft has introduced or improved the following integration capabilities in Always On VPN:

| Key improvement | Description |
| ---- | ---- |
| **[Windows Information Protection (WIP)](https://docs.microsoft.com/en-us/windows/threat-protection/windows-information-protection/protect-enterprise-data-using-wip)** | Integration with WIP allows network policy enforcement to determine whether traffic is permitted to go over the VPN. If the user profile is active and WIP policies are applied, Always On VPN is automatically triggered to connect. Also, when you use WIP, there's no need to specify AppTriggerList and TrafficFilterList rules separately in the VPN profile (unless you want more advanced configuration) because the WIP policies and application lists automatically take effect. |
| **[Windows Hello for Business](https://docs.microsoft.com/en-us/windows/access-protection/hello-for-business/hello-overview)** | Always On VPN natively supports Windows Hello for Business (in certificate-based authentication mode) to provide a seamless single sign-on experience for both sign-in to the machine and connection to the VPN. Therefore, no secondary authentication (user credentials) is needed for the VPN connection, making it possible to use an Always On connection with Windows Hello for Business authentication. |
| **[Microsoft Azure conditional access](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-controls)** | The Always On VPN client can integrate with the Azure conditional access platform to enforce multifactor authentication (MFA), device compliance, or a combination of the two. When compliant with conditional access policies, Azure Active Directory (Azure AD) issues a short-lived (by default, 60 minutes) IP Security (IPsec) authentication certificate that can then be used to authenticate to the VPN gateway. Device compliance uses System Center Configuration Manager/Intune compliance policies, which can include the device health attestation state as part of the connection compliance check. |
| **Azure MFA** | When combined with Remote Authentication Dial-In User Service (RADIUS) services and the Network Policy Server (NPS) extension for Azure MFA, VPN authentication can use strong MFA. |
| **Third-party VPN plug-in** | With the Universal Windows Platform (UWP), third-party VPN providers can create a single application for the full range of Windows 10 devices. The UWP provides a guaranteed core API layer across devices, eliminating the complexity of and problems often associated with writing kernel-level drivers. Currently, Windows 10 UWP VPN plug-ins exist for Pulse Secure, F5 Access, Check Point Capsule VPN, FortiClient, and SonicWall Mobile Connect; no doubt, others will appear in the future. |

### Security

VPNs create a pinhole connection in your network firewall. Securing that connection is important, especially when that connection is active most of the time. Always On VPN has new, advanced security capabilities to restrict the type of traffic, which applications can use the VPN connection, and which authentication methods you can use to initiate the connection. The primary improvements in security are in the following areas:

| Key improvement | Description |
| ---- | ---- |
| **Traffic filters** | Through traffic filters, you can specify client-side policies that determine which traffic is allowed into the corporate network. In this way, administrators can apply app or traffic restrictions on the VPN interface, limiting its use to certain sources, destination ports, and IP addresses. Two types of filtering rules are available:<ul><li>**App-based rules.** App-based firewall rules are based on a list of specified applications so that only traffic originating from these apps are permitted to go over the VPN interface.</li><li>**Traffic-based rules.** Traffic-based firewall rules are based on network requirements like ports, addresses, and protocols. Use these rules to require that only traffic that matches these specific conditions are permitted to go over the VPN interface.</li></ul> |
| **LockDown VPN** | LockDown VPN secures the device to allow only network traffic over the VPN interface and provides a configuration option suitable for highly security-conscious organizations. |
| **Per-App VPN** | Per-App VPN is like having an app-based traffic filter, but it goes farther to combine application triggers with an app-based traffic filter so that VPN connectivity is constrained to a specific application as opposed to all applications on the VPN client. The feature is automatically initiated when the app starts. |
| **Support for customized IPsec cryptography algorithms** | Always On VPN supports the use of both RSA and elliptic curve cryptography–based custom cryptographic algorithms to meet stringent government or organizational security policies. |
| **Native Extensible Authentication Protocol (EAP) support** | Always On VPN natively supports EAP, which allows you to use a diverse set of Microsoft and third-party EAP types as part of the authentication workflow. EAP provides secure authentication based on the following authentication types:<ul><li>User name and password</li><li>Smart card (both physical and virtual)</li><li>User or machines certificates</li><li>Windows Hello for Business</li><li>One-time password (OTP) or MFA support by way of EAP RADIUS integration</li></ul>The application vendor controls third-party UWP VPN plug-in authentication methods, although they have an array of available options, including custom credential types and OTP support. |

###<a name="vpn-connectivity"></a> VPN connectivity

Windows 10 has improved connectivity options over previous versions of the Windows operating system. When comparing DirectAccess to Always On VPN in the past, this is where DirectAccess often stood out. Until Always On VPN in Windows 10, the ability to create a persistent connection through either user or device authentication was not possible. Now, using the Always On feature with or without Device Tunnel, you can easily configure a persistent connection by using user or device authentication.

With Always On VPN, the connection type does not have to be exclusively user or device but can be a combination of both. For example, you could enable device authentication for remote device management, and then enable user authentication for connectivity to internal company sites and services. The following are the primary improvements in Always On VPN connectivity:

| Key improvement | Description |
| ---- | ---- |
| **Always On** | Always On is a Windows 10 feature that enables the active VPN profile to connect automatically and remain connected based on triggers—namely, user sign-in, network state change, or device screen active. Always On is also integrated into the connected standby experience to maximize battery life. |
| **Application triggering** | You can configure VPN profiles in Windows 10 to connect automatically on the launch of a specified set of applications. You can configure both desktop and UWP applications to trigger a VPN connection. |
| **Name-based triggering** | With Always On VPN, you can define rules so that specific domain name queries trigger the VPN connection. Windows 10 now supports name-based triggering for domain-joined and nondomain-joined machines (previously, only nondomain-joined machines were supported). |
| **Trusted network detection** | Always On VPN includes this feature to ensure that VPN connectivity is not triggered if a user is connected to a trusted network within the corporate boundary. You can combine this feature with any of the triggering methods mentioned earlier to provide a seamless "only connect when needed" user experience. |
| **[Device Tunnel](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/vpn/vpn-device-tunnel-config)** | Always On VPN gives you the ability to create a dedicated VPN profile for device or machine. Unlike _User Tunnel_, which only connects after a user logs on to the device or machine, _Device Tunnel_ allows the VPN to establish connectivity before user sign-in. Additionally, Device Tunnel provides feature parity with the _Infrastructure Tunnel_ concept of DirectAccess. You can use traffic filters to control which corporate resources as available through the Device Tunnel and when machine certificate authentication is employed. Both Device Tunnel and User Tunnel operate independently with their VPN profiles, can be connected at the same time, and can use different authentication methods and other VPN configuration settings as appropriate. |

### Networking

Microsoft added advanced networking capabilities to Always On VPN to allow administrators to specify routing policies at a more granular level—even down to the individual application—which is perfect for line-of-business (LOB) apps that require special remote access. Always On VPN is also fully compatible with both Internet Protocol version 4 (IPv4) and version 6 (IPv6). Unlike DirectAccess, there is no specific dependency on IPv6. The following are some of the networking improvements in Always On VPN:

| Key improvement | Description |
| ---- | ---- |
| **Dual-stack support for IPv4 and IPv6** | Always On VPN natively supports the use of both IPv4 and IPv6 in a dual-stack approach. It has no specific dependency on one protocol over the other, which allows for maximum IPv4/IPv6 application compatibility combined with support for future IPv6 networking needs. |
| **Application-specific routing policies** | In addition to defining global VPN connection routing policies for internet and intranet traffic separation, it is possible to add routing policies to control the use of split tunnel or force tunnel configurations on a per-application basis. This option gives you more granular control over which apps are allowed to interact with which resources through the VPN tunnel. |
| **Exclusion routes** | Always On VPN supports the ability to specify exclusion routes that specifically control routing behavior to define which traffic should traverse the VPN only and not go over the physical network interface.<br><br>**Important.** Exclusion routes only work in a Split Tunnel setup. |

### Configuration and compatibility

You can deploy and manage Always On VPN in several ways, which gives Always On VPN several advantages over other VPN client software that may require advanced software packaging and deployment, end-user involvement in the configuration, or simply lack features like Always On or Device Tunnel. As long as the standard protocols and authentication mechanisms work with the additional gateways, you can use the features of Always On VPN without having to set up a Always On VPN server infrastructure. The following are some of the configuration and
compatibility improvements in Always On VPN:

| Key improvement | Description |
| ---- | ---- |
| **Third-party VPN gateway compatibility** | The Always On VPN client does not require the use of a Microsoft-based VPN gateway to operate. Through the support of the IKEv2 protocol, the client facilitates interoperability with third-party VPN gateways that support this industry-standard tunneling type. Always On VPN also has backward-compatibility with Secure Socket Tunneling Protocol (SSTP), Layer 2 Tunneling Protocol/IPsec, and Point-to-Point Tunneling Protocol. You can also achieve interoperability with third-party VPN gateways by using a UWP VPN plug-in combined with a custom tunneling type without sacrificing Always On VPN platform features and benefits. |
| **Industry-standard IKEv2 VPN protocol support** | The Always On VPN client supports IKEv2, one of today's most widely used industry-standard tunneling protocols. This compatibility maximizes interoperability with third-party VPN gateways. |
| **Platform support** | Always On VPN supports domain-joined, nondomain-joined (workgroup), or Azure AD–joined devices to allow for both enterprise and bring your own device (BYOD) scenarios. Also, Always On VPN is available in all Windows editions. |
| **Diverse management and deployment mechanisms** | You can use many management and deployment mechanisms to manage VPN settings (called a *VPN profile*), including Windows PowerShell, System Center Configuration Manager, Intune (or third-party mobile device management [MDM] tool), and Windows Configuration Designer. These options simplify the configuration of Always On VPN regardless of the client management tools you use. |
| **Standardized VPN profile definition** | Always On VPN supports configuration using a standard XML profile (ProfileXML), providing a standard configuration template format that most management and deployment toolsets use. |

## <a name="feature-mapping"></a>Feature mapping between DirectAccess and Always On VPN

This section covers feature similarities and differences between DirectAccess and Always On VPN. This list is not exhaustive, but it does include some of the most common features and functions of DirectAccess. The features and scenarios discussed fall into three categories:

-   **Equivalent functionality.** These are scenarios and features used in DirectAccess that have a directly related capability in Always On VPN. Where possible, this guide provides the configuration service provider (CSP) parameter for configuring each option so that you're aware of the XML setting name.

-   **Improved functionality.** These are situations or scenarios in which Always On VPN provides improved functionality over DirectAccess or fills a gap in functionality. Where possible, this guide provides the CSP parameter for configuring each option so that you're aware of the XML setting name.

-   **Limited comparable functionality.** In a few situations, Always On VPN requires an alternate way to incorporate existing functionality. This section discusses those changes and how you can gain the functionality with Always On VPN.

For additional details about the feature comparison between DirectAccess and Always On VPN, see [Always On VPN and DirectAccess Features Comparison](https://docs.microsoft.com/windows-server/remote/remote-access/vpn/vpn-map-da).

### Equivalent functionality

Each item in this section is a use case scenario or commonly used DirectAccess feature for which Always On VPN has an equivalent.

| DirectAccess functionality | Always On VPN equivalent |
| ---- | ---- |
| Seamless, transparent connectivity to the corporate network. | You can configure Always On VPN to support auto-triggering based on application launch or namespace resolution requests; you can also set it for permanent connection through Always On VPN.<br><br>Define this functionality by using the following VPNv2 CSP parameters:<br><br>`VPNv2/ProfileName/AlwaysOn`<br>`VPNv2/ProfileName/AppTriggerList`<br>`VPNv2/ProfileName/DomainNameInformationList/AutoTrigger` |
| Use of a dedicated Infrastructure Tunnel to provide connectivity to the corporate network when the user is not signed in. | You can achieve this functionality by using the Device Tunnel feature in the VPN profile.<br><br>Define this functionality by using the following VPNv2 CSP parameter:<br><br>`VPNv2/ProfileName/DeviceTunnel` |
| Use of manage-out to allow remote connectivity to DirectAccess-connected clients from management clients located on the corporate network. | You can achieve this functionality by using the Device Tunnel feature in the VPN profile combined with configuring the VPN connection to dynamically register the IP addresses assigned to the VPN interface with internal DNS services.<br><br>Define this functionality by using the following VPNv2 CSP parameter:<br><br>`VPNv2/ProfileName/DeviceTunnel VPNv2/ProfileName/RegisterDNS` |
| Fall back to IP-HTTPS when DirectAccess clients are behind firewalls or proxy servers. | You can configure to fall back to SSTP (from IKEv2) by using the automatic tunnel/protocol type within the VPN profile.<br><br>Define this functionality by using the following VPNv2 CSP parameter:<br><br>`VPNv2/ProfileName/NativeProfile/NativeProtocolType` |
| Support for DirectAccess end-to-edge access mode. | Always On VPN provides connectivity to corporate resources by using tunnel policies that require authentication and encryption until they reach the VPN gateway. By default, the tunnel sessions terminate at the VPN gateway, which also functions as the IKEv2 gateway, providing end-to-edge security. |
| Support for limited access to specific application servers using DirectAccess end-to-end access mode. | DirectAccess provides the ability to extend end-to-edge IPsec policies all the way to specified application servers. You can configure similar capability in Always On VPN by using an IPsec transport policy tunneled inside the end-to-edge VPN tunnel. The VPN gateway then forwards the authenticated and traffic-protected IPsec sessions to the application servers. Also, you can employ traffic filters to limit connectivity to specific destinations across the Always On VPN connection, providing end-to-end security to specific servers. |
| Support for load balancing using Windows Network Load Balancing (NLB) or external load balancers. | Always On VPN supports the use of integrated Windows NLB or third-party hardware load-balancing solutions to provide VPN load-balancing capabilities. Both IKEv2 and SSTP tunnel types/protocols can be successfully load balanced. |
| Support for machine certificate authentication. | The IKEv2 protocol type available as part of the Always On VPN platform specifically supports the use of authentication by machine or computer certificates for VPN authentication.<br><br>Define this functionality by using the following VPNv2 CSP parameter:<br><br> `VPNv2/ProfileName/NativeProfile/Authentication/MachineMethod` |
| Use DirectAccess security groups to limit remote access functionality to specific clients. | You can configure Always On VPN to support granular authorization when using RADIUS, which includes the use of security groups to control VPN access. |
| Support for DirectAccess servers behind an edge firewall or NAT device. | Always On VPN gives you the ability to use protocols like IKEv2 and SSTP that fully support the use of a VPN gateway that is behind a NAT device or edge firewall. |
| Use of NLS to determine intranet connectivity when connected to the corporate network. | Trusted network detection provides a similar capability to DirectAccess NLS for detecting corporate network connections, but it is based on an assessment of the connection-specific DNS suffix assigned to network interfaces and network profile rather than depending on a web service probe mechanism and associated internal web server infrastructure to function.<br><br>Define this functionality by using the following VPNv2 CSP parameter:<br><br>`VPNv2/ProfileName/TrustedNetworkDetection` |
| DirectAccess compliance using Network Access Protection (NAP). | The Always On VPN client can integrate with Azure conditional access to enforce MFA, device compliance, or a combination of both. When compliant with conditional access policies, Azure AD issues a short-lived (by default, 60 minutes) IPsec authentication certificate that the client can then use to authenticate to the VPN gateway. Device compliance takes advantage of System Center Configuration Manager/Intune compliance policies, which can include the device health attestation state. At this time, Azure VPN conditional access provides the closest replacement to the existing NAP solution, although there is no form of remediation service or quarantine network capabilities.<br><br>Define this functionality by using the following VPNv2 CSP parameter:<br><br>`VPNv2/ProfileName/DeviceCompliance` |
| Ability to define which management servers are accessible before user sign-in. | You can achieve this functionality in Always On VPN by using the Device Tunnel feature (available in version 1709) in the VPN profile combined with traffic filters to control which management systems on the corporate network are accessible through the Device Tunnel.<br><br>Define this functionality by using the following VPNv2 CSP parameters:<br><br>`VPNv2/ProfileName/DeviceTunnel`<br>`VPNv2/ProfileName/TrafficFilterList` |
| Monitoring of DirectAccess operational status. | Although not strictly specific to Always On VPN, the Windows Server 2016 Remote Access Management console natively provides the operational status of VPN services. |
| Monitoring of DirectAccess remote access client status. | Although not strictly specific to the Always On VPN, the Windows Server 2016 Remote Access Management console natively provides the connection status of Always On VPN clients.  |
| Use of Inbox or RADIUS accounting for reporting of DirectAccess connections. | Although not strictly specific to Always On VPN, the Windows Server 2016 Remote Access Management console natively provides reporting for Always On VPN clients. |

### Improved functionality

Each item in this section is a use case scenario or commonly used DirectAccess function for which Always On VPN has improved functionality—either through an expansion of functionality or elimination of a previous limitation.

| DirectAccess functionality | Always On VPN equivalent |
| ---- | ---- |
| Domain-joined devices with Enterprise SKUs requirement. | Always On VPN supports domain-joined, nondomain-joined (workgroup), or Azure AD–joined devices to allow for both enterprise and BYOD scenarios. Always On VPN is available in all Windows editions, and the platform features are available to third parties by way of UWP VPN plug-in support. |
| DirectAccess clients depend on IPv6 and associated IPv6 translation services to function. | With Always On VPN, users can access both IPv4 and IPv6 resources on the corporate network. The Always On VPN client uses a dual-stack approach that doesn't specifically depend on IPv6 or the need for the VPN gateway to provide NAT64 or DNS64 translation services. |
| Support for two-factor or OTP authentication. | The Always On VPN platform natively supports EAP, which allows for the use of diverse Microsoft and third-party EAP types as part of the authentication workflow. Always On VPN specifically supports smart card (both physical and virtual) and Windows Hello for Business certificates to satisfy two-factor authentication requirements. Also, Always On VPN supports OTP and MFA by way of EAP RADIUS integration.<br><br>Define this functionality by using the following VPNv2 CSP parameter:<br><br>`VPNv2/ProfileName/NativeProfile/Authentication` |
| Support for multiple domains and forests. | The Always On VPN platform has no dependency on Active Directory Domain Services (AD DS) forests or domain topology (or associated functional/schema levels) because it doesn't require the VPN client to be domain joined to function. Group Policy is therefore not a dependency to define VPN profile settings because you do not use it during client configuration. Where Active Directory authorization integration is required, you can achieve it through RADIUS as part of the EAP authentication and authorization process. |
| Support for both split and force tunnel for internet/intranet traffic separation. | You can configure Always On VPN to support both force tunnel (the default operating mode) and split tunnel natively. Always On VPN provides additional granularity for application-specific routing policies.<br><br>Define this functionality by using the following VPNv2 CSP parameters:<br><br> `VPNv2/ProfileName/NativeProfile/RoutingPolicyType`<br>`VPNv2/ProfileName/TrafficFilterList/App/RoutingPolicyType` |
| Support for IP-HTTPS transition technology. | Always On VPN does not require the use of an IPv6 encapsulation protocol like IP-HTTPS. You can configure it to support SSTP natively if Secure Sockets Layer fallback from IKEv2 is required. |
| Support for the DirectAccess Connectivity Assistant to provide corporate connectivity status. | Always On VPN is fully integrated with the native Network Connectivity Assistant and provides connectivity status from the View All Networks interface. With the advent of Windows 10 Creators Update (version 1703), VPN connection status and VPN connection control are now available through the Network flyout, as well. |
| Name resolution of corporate resources using short-name, fully qualified domain name (FQDN), and DNS suffix. | Always On VPN can natively define one or more DNS suffixes as part of the VPN connection and IP address assignment process, including corporate resource name resolution for short names, FQDNs, or entire DNS namespaces. Always On VPN also supports use of Name Resolution Policy Tables to provide namespace-specific resolution granularity.<br><br>Define this functionality by using the following VPNv2 CSP parameters:<br><br>`VPNv2/ProfileName/DnsSuffix`<br>`VPNv2/ProfileName/DomainNameInformationList` |

### Limited comparable functionality

Each item in this section is a use case scenario or commonly used DirectAccess function for which Always On VPN does not have an equivalent natively. Although these are limited functionalities for Always On VPN, you can implement these functionalities in other ways as mentioned in the table below.

| DirectAccess functionality | Always On VPN equivalent |
| ---- | ---- |
| Use of multisite to provide multiple remote access entry points and geo-redundancy. | <!-- pashort 2/15/2018: eventually re-write this column for the two; let's make some sense out of these to prevent user confusion --> No native multisite-equivalent feature exists in Always On VPN without the use of third-party networking equipment or services such as Azure Traffic Manager or a third-party global server load balancer. However, users can manually select an appropriate VPN endpoint if you define multiple entries in the VPN profile. Third-Party UWP VPN plug-ins may support similar features for connecting to the nearest or most appropriate server VPN endpoint, but this varies by provider. |
| Deployment of client and server configuration settings through Group Policy. | Always On VPN does not require devices to be domain joined, so there are no dedicated Group Policy settings to configure it. Instead, you can configure clients by using Windows PowerShell, System Center Configuration Manager, Intune (or a third-party MDM provider), or Windows Configuration Designer. Also, because there's no dependency on a Microsoft VPN gateway, you must configure and manage server settings independent of the Always On VPN. |





This guide is designed for network and system administrators who want to manage remote computers that connect automatically to the organization network with VPN whenever the user logs on to the device, changes networks, or simply turns on the display. This type of automatically connecting VPN is called an *Always On VPN* - because the VPN connection appears to be a persistent connection.

>[!NOTE]
>This guide is available for download in Word format at [TechNet Gallery](https://gallery.technet.microsoft.com/Always-On-VPN-Deployment-e681bc7d).

This guide provides instructions on deploying Remote Access as a single tenant VPN RAS Gateway for point\-to\-site VPN connections that allow your remote employees to connect to your organization network with Always On VPN connections.

It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment scenario. These guides can help you determine whether this deployment scenario provides the services and configuration that you need for your organization's network. For more information, see [Technology overviews](#bkmk_technology).

## <a name="bkmk_prerequisites"></a>Prerequisites for using this guide

This guide provides instructions on how to deploy Remote Access Always On VPN connections for remote client computers that are running Windows 10. Following are the prerequisites for performing the procedures in this guide.

>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.

- You must have an Active Directory domain infrastructure, including one or more Domain Name System \(DNS\) servers.
- You must have a Public Key Infrastructure \(PKI\) and Active Directory Certificate Services \(AD CS\).
- You must have a perimeter network that includes two firewalls. For more information, see [Remote Access Always On VPN Deployment Overview](always-on-vpn-deploy-overview.md)
- Remote client computers must be joined to the Active Directory domain.
- Remote client computers must be running the Windows 10 Anniversary Update \(version 1607\) or later operating system.
- You must be prepared to deploy one new physical server or virtual machine \(VM\) on your perimeter network, upon which you will install Remote Access. This server must have two physical Ethernet network adapters.
- You must be prepared to install NPS as a RADIUS server on a server or VM. You can install NPS on a new physical server or on a new VM. If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than adding a new server.
- You must read the planning section of this guide to ensure that you are prepared for this deployment before you perform the deployment.
- You must perform the steps in this guide in the order in which they are presented.

## <a name="bkmk_not"></a>What this guide does not provide

This guide does not provide instructions for deploying the following items.

- Active Directory Domain Services \(AD DS\)
- Active Directory Certificate Services \(AD CS\) and a Public Key Infrastructure \(PKI\).
- Dynamic Host Configuration Protocol \(DHCP\) automatic IP address assignment to computers and other devices that are configured as DHCP clients. 
- Network hardware, such as Ethernet cabling, firewalls, switches, and hubs.
- Additional network resources, such as application and file servers, that remote users can access over an Always On VPN connection.
- Internet connectivity

## <a name="bkmk_technology"></a>Technology Overviews

When performing the steps in this guide, you must install and configure the following technologies in Windows Server 2016.

If you already have some of these technologies deployed on your network, you can use the instructions in this guide to perform additional configuration of the technologies for this deployment purpose.

Following are brief overviews of these technologies and links to additional documentation.

### Remote Access

In Windows Server 2016, the Remote Access server role is a multifaceted gateway and router that provides centralized administration, configuration, and monitoring of Virtual Private Network \(VPN\) remote access services. 

You can manage Remote Access Service \(RAS\) Gateways by using Windows PowerShell commands and the Remote Access Microsoft Management Console \(MMC\). 

For more information, see [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access).

#### Windows 10 VPN Clients

Remote client computers must be running the Windows 10 Anniversary Update \(version 1607\) or later operating system, and must be joined to your Active Directory domain.

For detailed feature descriptions and a full list of the VPN capabilities in Windows 10, see the [Windows 10 VPN Technical Guide](https://docs.microsoft.com/windows/access-protection/vpn/vpn-guide).

### Active Directory Domain Services \(AD DS\)

AD DS provides a distributed database that stores and manages information about network resources and application-specific data from directory-enabled applications. Administrators can use AD DS to organize elements of a network, such as users, computers, and other devices, into a hierarchical containment structure. The hierarchical containment structure includes the Active Directory forest, domains in the forest, and organizational units \(OUs\) in each domain. A server that is running AD DS is called a domain controller. 

AD DS contains the user accounts, computer accounts, and account properties that are required by Protected Extensible Authentication Protocol \(PEAP\) to authenticate user credentials and to evaluate authorization for VPN connection requests.

For information about deploying AD DS, see the Windows Server 2016 [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide).

#### Active Directory Users and Computers

Active Directory Users and Computers is a component of AD DS that contains accounts that represent physical entities, such as a computer, a person, or a security group. A security group is a collection of user or computer accounts that administrators can manage as a single unit. User and computer accounts that belong to a particular group are referred to as group members. 

#### Group Policy Management

Group Policy Management enables directory-based change and configuration management of user and computer settings, including security and user information. You use Group Policy to define configurations for groups of users and computers. 

With Group Policy, you can specify settings for registry entries, security, software installation, scripts, folder redirection, remote installation services, and Internet Explorer maintenance. The Group Policy settings that you create are contained in a Group Policy object \(GPO\). By associating a GPO with selected Active Directory system containers — sites, domains, and OUs — you can apply the GPO's settings to the users and computers in those Active Directory containers. To manage Group Policy objects across an enterprise, you can use the Group Policy Management Editor Microsoft Management Console \(MMC\). 

### Domain Name System \(DNS\)

DNS is a name resolution protocol for TCP/IP networks, such as the Internet or an organization network. A DNS server hosts the information that enables client computers and services to resolve easily recognized, alphanumeric DNS names to the IP addresses that computers use to communicate with each other.

For more overview information about DNS, see [Domain Name System (DNS)](https://docs.microsoft.com/windows-server/networking/dns/dns-top).

For information about deploying AD DS with DNS, see the Windows Server 2016 [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide).

### Active Directory Certificate Services

AD CS in Windows Server 2016 provides customizable services for creating and managing the X.509 certificates that are used in software security systems that employ public key technologies. Organizations can use AD CS to enhance security by binding the identity of a person, device, or service to a corresponding public key. AD CS also includes features that allow you to manage certificate enrollment and revocation in a variety of scalable environments.

For more information, see [Active Directory Certificate Services Overview](https://technet.microsoft.com/library/hh831740.aspx) and [Public Key Infrastructure Design Guidance](https://social.technet.microsoft.com/wiki/contents/articles/2901.public-key-infrastructure-design-guidance.aspx). 

#### Certificate Templates

Certificate templates can greatly simplify the task of administering a certification authority \(CA\) by allowing you to issue certificates that are preconfigured for selected tasks. The Certificate Templates MMC snap-in allows you to perform the following tasks.

- View properties for each certificate template.
- Copy and modify certificate templates.
- Control which users and computers can read templates and enroll for certificates.
- Perform other administrative tasks relating to certificate templates.

Certificate templates are an integral part of an enterprise certification authority (CA). They are an important element of the certificate policy for an environment, which is the set of rules and formats for certificate enrollment, use, and management.

For more information, see [Certificate Templates](https://technet.microsoft.com/library/cc730705.aspx).

#### Digital Server Certificates

This guide provides instructions for using Active Directory Certificate Services (AD CS) to both enroll and automatically enroll certificates to Remote Access and NPS infrastructure servers. AD CS allows you to build a public key infrastructure \(PKI\) and provide public key cryptography, digital certificates, and digital signature capabilities for your organization.  

When you use digital server certificates for authentication between computers on your network, the certificates provide:

1. Confidentiality through encryption. 
2. Integrity through digital signatures. 
3. Authentication by associating certificate keys with computer, user, or device accounts on a computer network. 

For more information, see [AD CS Step by Step Guide: Two Tier PKI Hierarchy Deployment](https://social.technet.microsoft.com/wiki/contents/articles/15037.ad-cs-step-by-step-guide-two-tier-pki-hierarchy-deployment.aspx).

### Network Policy Server (NPS)

NPS allows you to create and enforce organization-wide network access policies for connection request authentication and authorization. When you use NPS as a Remote Authentication Dial-In User Service \(RADIUS\) server, you configure network access servers, such as VPN servers, as RADIUS clients in NPS. 

You also configure network policies that NPS uses to authorize connection requests, and you can configure RADIUS accounting so that NPS logs accounting information to log files on the local hard disk or in a Microsoft SQL Server database. 

For more information, see [Network Policy Server (NPS)](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-top).

For the next section in this guide, see [Remote Access Always On VPN Deployment Overview](always-on-vpn-deploy-overview.md).


