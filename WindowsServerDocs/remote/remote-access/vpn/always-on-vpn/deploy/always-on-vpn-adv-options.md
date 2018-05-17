---
title: Remote Access Always On VPN Advanced Features
description: 'With Azure AD conditional access for virtual private network (VPN) connectivity, you can help protect your VPN connections.'
services: active-directory
documentationcenter: ''
ms.assetid: 51a1ee61-3ffe-4f65-b8de-ff21903e1e74
ms.service: active-directory
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/15/2018
ms.author: pashort
author: shortpatti
manager: elizapo
ms.reviewer: jairoc
---

# Remote Access Always On VPN Advanced Features

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

[&#171; Previous: Feature Comparison of Always On VPN and DirectAccess](../../vpn-map-da.md)<br>
[&#187; Next: Remote Access Always On VPN Deployment Overview](always-on-vpn-deploy-overview.md)

Beyond the deployment scenario provided in this guide, you can add other advanced VPN features to improve the security and availability of your VPN connection. For example, such components can help ensure that the connecting client is healthy before allowing a connection.

The following list includes some of these additional options.

## High Availability

Following are additional options for high availability.

### Server resilience and load balancing

In environments that require high availability or support large numbers of requests, you can increase the performance and resiliency of Remote Access by using load balancing between multiple servers that are running Network Policy Server (NPS) and enabling Remote Access server clustering.

For more information, see [NPS Proxy Server Load Balancing](../../../../../networking/technologies/nps/nps-manage-proxy-lb.md).

For more information about deploying Remote Access with load-balanced clusters, see [Deploy Remote Access in a Cluster](https://docs.microsoft.com/windows-server/remote/remote-access/ras/cluster/deploy-remote-access-in-cluster).

### Geographic site resilience

For IP-based geolocation, you can use Global Traffic Manager with DNS in Windows Server 2016. For more robust geographic load balancing, you can use Global Server Load Balancing solutions, such as Microsoft Azure Traffic Manager.

For more information, see [Overview of Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview)
and [Microsoft Azure Traffic Manager](https://azure.microsoft.com/en-us/services/traffic-manager).

## Advanced Authentication


Following are additional options for authentication.

### Windows Hello for Business.

In Windows 10, Windows Hello for Business replaces passwords with strong two-factor authentication on PCs and mobile devices. This authentication consists of a new type of user credential that is tied to a device and uses a biometric or Personal Identification Number (PIN).

The Windows 10 VPN client is compatible with Windows Hello for Business. After the user logs in with a gesture, the VPN connection uses the Windows Hello for Business certificate for certificate-based authentication.

For more information about Windows Hello for Business with the Windows 10 VPN client, see the following topics.

-   [Windows Hello for Business](https://docs.microsoft.com/windows/access-protection/hello-for-business/hello-identity-verification)

-   Technical Case Study: [Enabling Remote Access with Windows Hello for Business in Windows 10](https://msdn.microsoft.com/library/mt728163.aspx).

### Azure Multifactor Authentication (MFA).

Azure MFA has cloud and on-premises versions that you can integrate with the Windows VPN authentication mechanism.

For more information about how this mechanism works, see [Integrate RADIUS authentication with Azure Multi-Factor Authentication Server](https://docs.microsoft.com/azure/multi-factor-authentication/multi-factor-authentication-get-started-server-radius).

## Advanced VPN Features


Following are additional options for advanced features.

### Traffic filtering

If you need to enforce which applications VPN clients can access, you can enable VPN Traffic Filters.

For more information, see [VPN security features](https://docs.microsoft.com/windows/access-protection/vpn/vpn-security-features).

### App-triggered VPN

You can configure VPN profiles to connect automatically when certain applications or types of applications start.

For more information about this and other triggering options, see [VPN auto-triggered profile options](https://docs.microsoft.com/windows/access-protection/vpn/vpn-auto-trigger-profile).

### VPN conditional access

Conditional access and device compliance can require managed devices to meet standards before they can connect to the VPN. 

One of the advanced features for VPN conditional access allows you to restrict the VPN connections to only those where the client authentication certificate contains the ‘AAD Conditional Access’ OID of '1.3.6.1.4.1.311.87'. 

To restrict the VPN connections, you need to:

1.	On the NPS server, open the Network Policy Server snap-in. 
2.	Expand Policies > Network Policies
3.	Right-click the ‘Virtual Private Network (VPN) Connections' Network Policy and select Properties. 
4.	Select the Settings tab.
5.	Select the 'Vendor Specific' and click Add.
6.	Select the 'Allowed-Certificate-OID' option and then click Add.
7.	Paste the AAD Conditional Access OID of 1.3.6.1.4.1.311.87 as the attribute value, and then click OK, OK, Close, and Apply.<p>Now when VPN clients attempt to connect using any certificate other than the short-lived cloud certificate, the connection will fail.


For more information about conditional access, see [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access).

## Additional Protection


Following are additional options for protection.

### Trusted Platform Module (TPM) Key Attestation

A user certificate with a TPM-attested key provides higher security assurance, backed up by non-exportability, anti-hammering, and isolation of keys provided
by the TPM.

For more information about TPM key attestation in Windows 10, see [TPM Key Attestation](https://docs.microsoft.com/windows-server/identity/ad-ds/manage/component-updates/tpm-key-attestation).

## Next step
[Remote Access Always On VPN Deployment Overview](always-on-vpn-deploy-overview.md): You deploy Always On Virtual Private Network \(VPN\) connections for remote computers that are running Windows 10. In this topic, you learn about the VPN connection process, servers to configure, ProfileXML VPNv2 CSP node, and other tecnologies to deploy Alwasy On VPN.

## Related topics
- [NPS Proxy Server Load Balancing](../../../../../networking/technologies/nps/nps-manage-proxy-lb.md): Remote Authentication Dial-In User Service (RADIUS) clients, which are network access servers such as virtual private network (VPN) servers and wireless access points, create connection requests and send them to RADIUS servers such as NPS. In some cases, an NPS server might receive too many connection requests at one time, resulting in degraded performance or an overload.

- [Overview of Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview): This topic provides an overview of Azure Traffic Manager, which allows you to control the distribution of user traffic for service endpoints. Traffic Manager uses the Domain Name System (DNS) to direct client requests to the most appropriate endpoint based on a traffic-routing method and the health of the endpoints. 

- [Windows Hello for Business](https://docs.microsoft.com/windows/access-protection/hello-for-business/hello-identity-verification): This topic provides the prerequisites, such as cloud only deployments and hybrid deployments.  This topic also lists frequently asked questions about Windows Hellow for Business.

- [Technical case study: Enabling Remote Access with Windows Hello for Business in Windows 10](https://msdn.microsoft.com/library/mt728163.aspx): In this technical case study you learn how Microsoft implements remote access with Windows Hello for Business.  Windows Hello for Business is a private/public key or certificate-based authentication approach for organizations and consumers that goes beyond passwords. This form of authentication relies on key pair credentials that can replace passwords and are resistant to breaches, thefts, and phishing. With Windows Hello, biometric authentication and recognition is easy with a face or fingerprint. PCs with fingerprint readers are ready to use Windows Hello.

- [Integrate RADIUS authentication with Azure Multi-Factor Authentication Server](https://docs.microsoft.com/azure/multi-factor-authentication/multi-factor-authentication-get-started-server-radius): This topic walks you through adding and configuring a RADIUS client authentication with Azure Multi-Factor Authentication Server. RADIUS is a standard protocol to accept authentication requests and to process those requests. The Azure Multi-Factor Authentication Server can act as a RADIUS server. Insert it between your RADIUS client (VPN appliance) and your authentication target to add two-step verification. Your authentication target could be Active Directory, an LDAP directory, or another RADIUS server. For Azure Multi-Factor Authentication (MFA) to function, you must configure the Azure MFA Server so that it can communicate with both the client servers and the authentication target. The Azure MFA Server accepts requests from a RADIUS client, validates credentials against the authentication target, adds Azure Multi-Factor Authentication, and sends a response back to the RADIUS client. The authentication request only succeeds if both the primary authentication and the Azure Multi-Factor Authentication succeed.

- [VPN security features](https://docs.microsoft.com/windows/access-protection/vpn/vpn-security-features): This topic provides you VPN security guidelines for LockDown VPN, Windows Information Protection (WIP) integration with VPN, and traffic filters. 

- [VPN auto-triggered profile options](https://docs.microsoft.com/windows/access-protection/vpn/vpn-auto-trigger-profile): This topic provides you VPN auto-triggered profile options, such as app trigger, name-based trigger, and Always On.

- [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access): This topic provides you an overview of cloud-based Conditional Access Platform to provide a device compliance option for remote clients. Conditional Access is a policy-based evaluation engine that lets you create access rules for any Azure Active Directory (Azure AD) connected application. 

- [TPM Key Attestation](https://docs.microsoft.com/windows-server/identity/ad-ds/manage/component-updates/tpm-key-attestation): This topic provides you an overview of Trusted Platform Module (TPM) and steps to deploy TPM key attestation. You can also find troubleshooting information and steps to resolve issues. 