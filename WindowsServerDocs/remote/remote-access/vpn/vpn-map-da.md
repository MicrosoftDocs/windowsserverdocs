---
title: Always On VPN and DirectAccess Features Comparison
description: This section provides information of how Windows Server 2016 and Always On VPN features map to DirectAccess features, including details about the increased flexibility provided by new VPN features.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.date: 
ms.assetid: 8fe1c810-4599-4493-b4b8-73fa9aa18535
manager: brianlic
ms.author: pashort
author: shortpatti
---

# Always On VPN and DirectAccess Features Comparison

>Applies To: Windows Server \(Semi-Annual Channel\), Windows Server 2016, Windows 10

In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in). Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess. Always On VPN addresses the previous gaps between Windows VPNs and DirectAccess; therefore, Always On VPN is the DirectAccess replacement solution.

This section provides information of how Windows Server 2016 and Always On VPN features map to DirectAccess features, including details about the increased flexibility provided by new VPN features.

## <a name="feature-mapping"></a>Features Comparison between DirectAccess and Always On VPN

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






















You can use this section to gain an understanding of how Windows Server and Windows 10, version 1709, VPN features map to and improve upon old DirectAccess features.

### Pre\-Logon Device Tunnels 

Following are the differences between the ways VPN and DirectAccess handle Pre\-Logon Infrastructure Tunnels.

#### Windows 10 VPN

By default, Windows 10 VPN does not automatically create Device Tunnels when users are not logged on to their computer or device. 

You can configure Windows 10 VPN to automatically create Pre\-Logon Device Tunnels by using the Device Tunnel \(prelogon\) feature in the VPN profile.

This is defined using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/DeviceTunnel**

#### DirectAccess

When users are not logged on, DirectAccess automatically creates a dedicated Infrastructure Tunnel to provide connectivity to the organization network.

### Management of Remote Computers and Devices

Following are the differences between the ways VPN and DirectAccess provide management of remote computers and devices.

#### Windows 10 VPN

You can manage Windows 10 VPN clients by configuring the Device Tunnel \(prelogon\) feature in the VPN profile. In addition, you must configure the VPN connection to dynamically register the IP addresses that are assigned to the VPN interface with internal DNS services.

You can define a Device Tunnel by using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/DeviceTunnel**
- **VPNv2/ProfileName/RegisterDNS**

#### DirectAccess

DirectAccess manage\-out has a mandatory dependency on native IPv6 connectivity between the management client and the DirectAccess gateway - which is often difficult to achieve, especially when you have load balanced or multi\-site deployments.

### Specify Pre\-Logon Device Tunnel Allowed Destinations

Following are the differences between how VPN and DirectAccess provide the ability to define pre\-logon Allowed Destinations.

#### Windows 10 VPN

This can be achieved with the Device Tunnel \(prelogon\) feature in the VPN profile, combined with traffic filters to control which management systems on the corporate network are accessible via the device tunnel.

This is defined using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/DeviceTunnel**
- **VPNv2/ProfileName/TrafficFilterList**
- **VPNv2/ProfileName/RouteList**

#### DirectAccess

DirectAccess supports defining pre\-logon management servers.

## Comparison of Features included in both 1709 and earlier versions of Windows Server and Windows 10 

The following VPN features are included in Windows Server 2016, Windows 10, and  Windows Server and Windows 10 versions 1709

### Network Connectivity Options

Following are the differences between Windows 10 VPN and DirectAccess network connectivity options.

#### Windows 10 VPN

You have three network connectivity options with Windows 10 VPN:

- The remote computer or device is always connected to your organization network when the device is turned on and Internet connected. You can make this configuration with the following VPNv2 CSP parameter: **VPNv2/ProfileName/AlwaysOn**
- The launch of applications that you specify triggers automatic connection of the VPN client to your organization network. You can make this configuration with the following VPNv2 CSP parameter: **VPNv2/ProfileName/AppTriggerList**
- DNS name resolution requests for specific domains trigger automatic connection of the VPN client to your organization network. You can make this configuration with the following VPNv2 CSP parameter: **VPNv2/ProfileName/DomainNameInformationList/AutoTrigger**

#### DirectAccess

DirectAccess only allows computers and devices to always be connected to your organization network when they are turned on and Internet connected, and provides no other connectivity options. 

>[!NOTE]
>In some DirectAccess configurations, users are allowed to disconnect and reconnect DirectAccess.

### VPN Client Options

Following are the differences between the VPN clients that are allowed by Windows 10 VPN and DirectAccess.

#### Windows 10 VPN

Windows 10 VPN supports both domain\-joined and non\-domain joined \(workgroup or Azure AD joined\) VPN clients to allow you to deploy both Enterprise and bring your own device \(BYOD\) scenarios.

Windows 10 VPN is available in all editions of Windows 10, and the platform features are available to third\-party vendors. Vendors can take advantage of Universal Windows Platform \(UWP\) VPN plug\-in support.

>[!NOTE]
>For more information about UWP, see [What's a Universal Windows Platform (UWP) app?](https://docs.microsoft.com/windows/uwp/get-started/whats-a-uwp).

#### DirectAccess

DirectAccess clients must be domain-joined devices that are running supported Windows Enterprise edition operating systems.

### Use of Multiple Remote Access Servers for Geo\-Redundancy

Following are the differences between the ways VPN and DirectAccess use multiple remote access servers to provide users with more connectivity options.

#### Always On VPN

You can deploy many Remote Access servers configured as Always On VPN organization entry points for your employees. With this multi\-site deployment, you must define multiple VPN server entries in VPN profiles so that users can select the VPN server to which they want to connect.

Alternately, you can use third-party networking equipment or services, like Azure Traffic Manager \(ATM\) or a third-party Global Server Load Balancer \(GSLB\) to provide automatic multi\-site services. For more information, see [Overview of Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview).

Some third\-party Universal Windows Platform \(UWP\) VPN plug-ins might support similar multi\-site features for connecting to the nearest, or most appropriate, server VPN endpoint.

#### DirectAccess

DirectAccess uses multi\-site to provide multiple remote access entry points and geo\-redundancy with optional GSLB support.

### Use of Alternate Protocols

Following are the differences between how VPN and DirectAccess use alternate protocols when clients are behind firewalls or proxy servers.

#### Windows 10 VPN

You can configure VPN profiles so that Windows 10 VPN clients fall back to Secure Socket Tunneling Protocol \(SSTP\) \(from IKEv2\) when the clients are behind firewalls or proxy servers.

You can define an automatic tunnel and protocol type by using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/NativeProfile/NativeProtocolType**

#### DirectAccess

By default, DirectAccess falls back to the Internet Protocol \(IP\) over Hypertext Transfer Protocol Secure \(HTTPS\) Tunneling Protocol, called IP\-HTTPS, when DirectAccess clients are behind firewalls or proxy servers.

### Provide Access to Both IPv4 and IPv6 Resources

Following are the differences between how VPN and DirectAccess allow remote clients access to both IPv4 and IPv6 resources on your organization network.

#### Windows 10 VPN

Windows 10 VPN clients can access both IPv4 and IPv6 resources on your organization network. 

The Windows 10 VPN client uses a "dual stack" architecture that is not specifically dependent upon IPv6. In addition, Windows 10 VPN clients do not require that VPN gateways provide NAT64 or DNS64 translation services.

#### DirectAccess

DirectAccess clients can access both IPv4 and IPv6 resources on your organization network, however DirectAccess clients are dependent upon IPv6 and associated IPv6 translation services to function correctly. 

### Remote Client to VPN Server Security

Following are the differences between how VPN and DirectAccess provide end\-to\-edge security for the connection between remote clients and the gateway.

#### Windows 10 VPN

Windows 10 VPN provides connectivity to your organization's resources using tunnel policies that require authentication and encryption until they reach the VPN gateway.

By default, the tunnel sessions terminate at the VPN gateway, which also functions as the IKEv2, SSTP, or L2TP Gateway. This provides end-to-edge security.

For end-to-end access, where traffic is protected between the remote VPN client and application servers on your organization network, you can use an IPsec transport policy that is tunneled inside the end-to-edge VPN tunnel.

The VPN gateway then forwards the IPsec protected, authenticated traffic sessions to the application servers.

Additionally, you can employ traffic filters to limit connectivity to specific destinations across the Windows 10 VPN connection. This provides end\-to\-end security to specific servers.

#### DirectAccess 

DirectAccess supports limited access to specific application servers using DirectAccess end\-to\-end access mode.

This provides the ability to extend end\–to\-edge IPsec policies all the way to  the application servers that you specify.

### Load Balancing Support

Following are the differences between how VPN and DirectAccess provide load balancing support.

#### Windows 10 VPN

Windows 10 VPN supports the use of integrated Windows Network Load Balancing \(NLB\) or third-party hardware load balancing \(HLB\) solutions to provide VPN load balancing capabilities. You can use these technologies to load balance both IKEv2 and SSTP tunnel types and protocols.

For more information, see the following topics.

- [Deploy Remote Access in a Cluster](https://docs.microsoft.com/windows-server/remote/remote-access/ras/cluster/deploy-remote-access-in-cluster)
- [Network Load Balancing](https://docs.microsoft.com/windows-server/networking/technologies/network-load-balancing).

#### DirectAccess

DirectAccess also supports use of NLB and HLB solutions. For more information, see [Test Lab Guide: Demonstrate DirectAccess in a Cluster with Windows NLB](https://docs.microsoft.com/windows-server/remote/remote-access/directaccess/tlg-cluster-nlb/test-lab-guide-demonstrate-directaccess-in-a-cluster-with-windows-nlb).

### Computer Certificate Authentication Support	

Following are the differences between how VPN and DirectAccess provide support for computer certificate authentication.

#### Windows 10 VPN

The IKEv2 protocol type that is available as part of the Windows 10 VPN platform specifically supports the use of authentication using computer certificates for VPN authentication.

This is defined using the following VPNv2 CSP parameters:

**VPNv2/ProfileName/NativeProfile/Authentication/MachineMethod**


#### DirectAccess

DirectAccess supports using computer certificates for authentication. For Windows 7 DirectAccess clients, computer certificates are required. For DirectAccess clients running operating systems later than Windows 7, computer certificates are optional but recommended.

### Support for Two Factor or OTP Authentication

Following are the differences between how VPN and DirectAccess provide support for two factor and One Time Password \(OTP\) authentication.

#### Windows 10 VPN

Windows 10 VPN supports Extensible Authentication Protocol \(EAP\), which enables both Microsoft and third-party EAP types to be used with VPN connections. 

Windows 10 VPN specifically supports Smart Card \(both physical and virtual\) or Windows Hello for Business Certificates to satisfy two\-factor authentication requirements.

OTP or multi-factor authentication is also supported with EAP RADIUS integration.

This is defined using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/NativeProfile/Authentication**

#### DirectAccess

DirectAccess also supports two factor and OTP authentication.

For more information, see [Test Lab Guide: Demonstrate DirectAccess with OTP Authentication and RSA SecurID](https://docs.microsoft.com/windows-server/remote/remote-access/directaccess/tlg-otp-securid/test-lab-guide-demonstrate-directaccess-with-otp-authentication-and-rsa-securid).

### Apply Client and Server Configuration Using Group Policy

Following are the differences between how VPN and DirectAccess clients and servers can be configured by using Group Policy.

#### Windows 10 VPN

Windows 10 VPN cannot be configured via Group Policy and requires the use of Windows PowerShell, Configuration Manager, Intune \(or a third-party MDM provider\) or Windows Configuration Designer. 
 
There is no dependency on a Microsoft-based VPN gateway, so server configuration settings must be managed and configured separate from the Windows 10 VPN platform.

#### DirectAccess

DirectAccess supports configuration of clients and servers by using Group Policy.

### Use of Security Groups to Manage Access Levels

Following are the differences between how VPN and DirectAccess use security groups to manage access levels.

#### Windows 10 VPN

You can configure Windows 10 VPN to support granular authorization, which includes the use of security groups to control VPN access.

#### DirectAccess

DirectAccess supports using security groups to limit remote access functionality for specific clients.


### NAT64/DNS64 Functionality

Following are the differences between how VPN and DirectAccess use IPv4 and IPv6.

#### Windows 10 VPN

Windows 10 VPN does not require IPv6\-to\-IPv4 translation components. VPN functions natively with both IPv4 and IPv6 protocols in a **dual stack** model.

#### DirectAccess

DirectAccess requires both NAT64 and DNS64 IPv6\-to\-IPv4 translation components.


### Gateway Deployment Behind Edge Firewalls or NAT Devices

Following are the differences between how VPN and DirectAccess handle deployment of the gateway behind the edge firewall or Network Address Translation \(NAT\) device.
	
#### Windows 10 VPN

Windows 10 VPN provides the ability to use protocols like IKEv2 and SSTP that fully support the use of a VPN gateway that is behind a NAT device or edge firewall.

#### DirectAccess

DirectAccess supports deployment of DirectAccess servers behind an edge firewall or NAT device.

>[!NOTE]
>When DirectAccess servers are deployed behind a NAT device, only IPHTTPS is supported. Use of Teredo or 6to4 are not supported in this scenario.

### Support for Multiple Domains and Forests	

Following are the differences between how VPN and DirectAccess support multiple forests and domains.

#### Windows 10 VPN

The Windows 10 VPN platform has no dependency on Active Directory forests or domain topology \(or associated functional/schema levels\) and does not require the VPN client to be domain-joined in order to function. 

Group Policy is not a dependency to define VPN profile settings, because you can use various other Active Directory\-independent deployment mechanisms.
 
Where Active Directory authorization integration is required, this can be achieved by using RADIUS as part of the EAP authentication and authorization process.

#### DirectAccess

DirectAccess supports using multiple Active Directory domains and forests.


### Support for Split and Force Tunnel

Following are the differences between how VPN and DirectAccess use Split and Force Tunnel  for Internet and Intranet traffic separation.

#### Windows 10 VPN

You can configure Windows 10 VPN to support both Force Tunnel \(the default operating mode\) and also Split Tunnel.
 
Windows 10 VPN provides additional granularity in the form of application-specific routing policies.

This is defined using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/NativeProfile/RoutingPolicyType**
- **VPNv2/ProfileName/TrafficFilterList/App/RoutingPolicyType**


#### DirectAccess

DirectAccess supports using Split and Force Tunnel for Internet and Intranet traffic separation.


### Support for IP-HTTPS

Following are the differences between how VPN and DirectAccess provide support for the IP-HTTPS transition technology.

#### Windows 10 VPN

Windows 10 VPN does not require the use of an IPv6 encapsulation protocol like IP-HTTPS and can be configured to natively support SSTP if SSL-fallback from IKEv2 is required. 

#### DirectAccess

DirectAccess requires use of the IP-HTTPS transition technology.


### Support for Network Connectivity Assistant

Following are the differences between how VPN and DirectAccess support for Network Connectivity Assistant.

#### Windows 10 VPN

Windows 10 VPN is fully integrated with the native Network Connectivity Assistant and provides connectivity status from the View All Networks \(VAN\) interface. 

With the advent of Windows 10 Creators Update \(Version 1703\), VPN connection status and VPN connection control is also now available via the Network Flyout.

#### DirectAccess

DirectAccess supports the DirectAccess or Network Connectivity Assistant to provide corporate connectivity status.


### Use of Network Location Services

Following are the differences between how VPN and DirectAccess use Network Location Services.

#### Windows 10 VPN

Trusted Network Detection provides a similar capability to DirectAccess NLS in order to detect corporate network connections. 

However, it is based upon assessment of the connection-specific DNS suffix assigned to network interfaces, rather than having a dependency on a web service probe mechanism and associated internal web server infrastructure required for it to function.

This is defined using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/TrustedNetworkDetection**

#### DirectAccess

DirectAccess supports the use of Network Location Services to determine intranet connectivity when connected to the corporate network.


### Use of Network Access Protection \(NAP)

Following are the differences between how VPN and DirectAccess handle the issue of network configuration compliance.

#### Windows 10 VPN

The Windows 10 VPN client is able to integrate with the Azure Conditional Access Platform to enforce multi-factor authentication, enforce device compliance, or a combination of both. 

When compliant with conditional access policies, Azure AD will issue a short-lived \(60 mins by default\) IPsec authentication certificate that can then be used to authenticate to the VPN gateway. Device compliance leverages Microsoft Configuration Manager/Intune Compliance Policies which includes the ability to include the device health attestation state.
 
At this time, Azure VPN conditional access provides the closest replacement to the existing Network Access Protection \(NAP\) solution, although there is no form of remediation service or quarantine network capabilities.

This is defined using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/DeviceCompliance**


#### DirectAccess

DirectAccess supports the use of NAP.

>[!NOTE]
>NAP was deprecated in Windows 8.1 and Windows Server 2012 R2, and is not available in later versions of the operating systems.

### Name Resolution of Organization Resources

Following are the differences between how VPN and DirectAccess handle name resolution  with NetBIOS names, FQDN, and DNS Suffix.

#### Windows 10 VPN

Windows 10 VPN has the capability to define one or more DNS suffixes as part of the VPN connection and IP address assignment process.

This allows organization resource name resolution for NetBIOS names, FQDNs or entire DNS namespaces.

Windows 10 VPN also supports the use of the Name Resolution Policy Tables \(NRPT\) to provide namespace-specific resolution granularity.

This is defined using the following VPNv2 CSP parameters:

- **VPNv2/ProfileName/DnsSuffix**
- **VPNv2/ProfileName/DomainNameInformationList**

#### DirectAccess

DirectAccess supports name resolution for NetBIOS names, FQDN, and DNS Suffix based on the NRPT configuration.

### Monitoring of DirectAccess operational status

Following are the differences between how VPN and DirectAccess 

#### Windows 10 VPN

Although not strictly Windows 10 VPN\-specific, the Windows Server 2016 Remote Access Management console provides the operational status of VPN services.

#### DirectAccess

The Windows Server 2016 Remote Access Management console also provides the operational status of DirectAccess services.

### Remote Access Client Monitoring

Following are the differences between how VPN and DirectAccess monitor the status of remote access clients.

#### Windows 10 VPN

Although not strictly Windows 10 VPN\-specific, the Windows Server 2016 Remote Access Management console is able to provide the connection status of Windows 10 VPN clients. 

#### DirectAccess

The Windows Server 2016 Remote Access Management console also provides the connection status of DirectAccess clients.

### Use of Inbox or RADIUS Accounting

Following are the differences between how VPN and DirectAccess handle Inbox and RADIUS accounting.

#### Windows 10 VPN

Although not strictly Windows 10 VPN\-specific, the Windows Server 2016 Remote Access Management console is able to provide reporting for Windows 10 VPN clients.

#### DirectAccess

DirectAccess supports the Windows Server 2016 Remote Access Management console and also provides reporting for DirectAccess clients.
