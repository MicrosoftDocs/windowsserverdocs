---
title: Always On VPN and DirectAccess Features Comparison
description: You can use this topic to gain an understanding of how Windows 2016 and Windows 10 VPN features map to and improve upon old DirectAccess features.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.date: 
ms.assetid: 8fe1c810-4599-4493-b4b8-73fa9aa18535
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Always On VPN and DirectAccess Features Comparison

>Applies To: Windows Server \(Semi-Annual Channel\), Windows Server 2016, Windows 10

With Windows 10 Virtual Private Networking \(VPN\), you can create Always On VPN connections so that remote computers and devices are always connected to your organization network when they are turned on and Internet connected.

You can use this topic to gain an understanding of how Windows 2016 and Windows 10 Virtual Private Networking \(VPN\) features map to DirectAccess features, including details about the increased flexibility provided by new VPN features.

You can also use this topic for an overview of how Windows 10 VPN provides advantages over DirectAccess deployments.

## Windows 10 VPN Advantages

You can use this section for an overview of new VPN functionality and how it provides advantages over using DirectAccess for an Always On remote access connectivity solution.

Changes are made to VPN primarily due to some problems presented by DirectAccess.

Remote Access DirectAccess deployments include the following disadvantages.

- DirectAccess requires a complex server side infrastructure
- DirectAccess supports IPv6 only
- DirectAccess clients must be domain joined
- DirectAccess offers no support for Mobile device management or Azure Active Directory Joined
- DirectAccess is not compatible with Windows Phones
- DirectAccess is a Windows\-only solution

Remote Access VPN deployments include the following advantages.

- Simplified and time tested deployment
- IPv4 and IPv6 compatible
- Supported on all Windows operating systems
- Similar solutions available to third party platforms, allowing enterprise administrators to deploy one solution across the device ecosystem
- Three automatic connectivity choices:
	- Always connected
	- Name match\-based triggering
	- Application\-launch based triggering
- Modern security features
	- Per app VPN
	- Traffic pattern\-based filters
	- Lockdown VPN
- Routing flexibility
	- Split or force tunnel
- New authentication technology integration, such as with Windows Hello for Business
- Integration with the Azure Conditional Access platform
- Mobile Device Management \(MDM\) and System Center Configuration Manager \(SCCM\) based deployment
- With Windows Server and Windows 10 version 1709 VPN, Pre\-Logon Infrastructure Tunnels, Management of Remote Computers and Devices, and the ability to specify Pre\-Logon Gateways

The following sections provide specific functionality comparisons between Windows 10 VPN and DirectAccess.

## Windows Server and Windows 10 version 1709 VPN Features Comparison

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

#### Windows 10 VPN

You can deploy many Remote Access servers configured as Always On VPN organization entry points for your employees. With this multi\-site deployment, you must define multiple VPN server entries in VPN profiles so that users can select the VPN server to which they want to connect.

Alternately, you can use third-party networking equipment or services, like Azure Traffic Manager \(ATM\) or a third-party Global Server Load Balancer \(GSLB\) to provide automatic multi\-site services.

Some third\-party Universal Windows Platform \(UWP\) VPN plug-ins might support similar multi\-site features for connecting to the nearest, or most appropriate, server VPN endpoint.

#### DirectAccess

DirectAccess uses multi\-site to provide multiple remote access entry points and geo-redundancy.

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

By default, the tunnel sessions terminate at the VPN gateway, which also functions as the IKEv2 Gateway. This provides end\-to\-edge security.

For end\-to\-end access, where traffic is protected between the remote VPN client and application servers on your organization network, you can use an IPsec transport policy that is tunneled inside the end-to-edge VPN tunnel.

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

- No content available

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
>NAP was deprecated in Windows Server 2012 R2 and is not available in Windows Server 2016.

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

DirectAccess supports name resolution for NetBIOS names, FQDN, and DNS Suffix.

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
