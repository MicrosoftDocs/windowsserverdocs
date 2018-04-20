---
title: Remote Access Always On VPN Advanced Features
description: You can use this topic to learn about advanced deployment options for Always On VPN with Windows Server 2016 and Windows 10.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 
manager: elizapo
ms.author: pashort
author: shortpatti
ms.date: 4/20/2018
---
# Remote Access Always On VPN Advanced Features

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Beyond the deployment scenario provided in this guide, you can add other advanced VPN features to improve the security and availability of your VPN connection. For example, such components can help ensure that the connecting client is healthy before allowing a connection. 

The following list includes some of these additional options.

## High Availability

Following are additional options for high availability.

### Server resilience and load balancing

In environments that require high availability or support large numbers of requests, you can increase the performance and resiliency of Remote Access by using load balancing between multiple servers that are running Network Policy Server \(NPS\) and enabling Remote Access server clustering.

For more information, see [NPS Proxy Server Load Balancing](../../../../../networking/technologies/nps/nps-manage-proxy-lb.md). 

For more information about deploying Remote Access with load-balanced clusters, see [Deploy Remote Access in a Cluster](https://docs.microsoft.com/windows-server/remote/remote-access/ras/cluster/deploy-remote-access-in-cluster).

### Geographic site resilience

For IP-based geolocation, you can use Global Traffic Manager with DNS in Windows Server 2016. For more robust geographic load balancing, you can use Global Server Load Balancing solutions, such as Microsoft Azure Traffic Manager.

For more information, see [Overview of Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview) and [Microsoft Azure Traffic Manager](https://azure.microsoft.com/en-us/services/traffic-manager).

## Advanced Authentication

Following are additional options for authentication.

### Windows Hello for Business.

In Windows 10, Windows Hello for Business replaces passwords with strong two-factor authentication on PCs and mobile devices. This authentication consists of a new type of user credential that is tied to a device and uses a biometric or Personal Identification Number \(PIN\).

The Windows 10 VPN client is compatible with Windows Hello for Business. After the user logs in with a gesture, the VPN connection uses the Windows Hello for Business certificate for certificate-based authentication. 

For more information about Windows Hello for Business with the Windows 10 VPN client, see the following topics.

- [Windows Hello for Business](https://docs.microsoft.com/windows/access-protection/hello-for-business/hello-identity-verification)
- Technical Case Study: [Enabling Remote Access with Windows Hello for Business in Windows 10](https://msdn.microsoft.com/library/mt728163.aspx).

### Azure Multifactor Authentication (MFA).

Azure MFA has cloud and on\-premises versions that you can integrate with the Windows VPN authentication mechanism. 

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

For more information about conditional access, see [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access).

## Additional Protection

Following are additional options for protection.

### Trusted Platform Module \(TPM\) Key Attestation

A user certificate with a TPM\-attested key provides higher security assurance, backed up by non\-exportability, anti\-hammering, and isolation of keys provided by the TPM. 

For more information about TPM key attestation in Windows 10, see [TPM Key Attestation](https://docs.microsoft.com/windows-server/identity/ad-ds/manage/component-updates/tpm-key-attestation).

For detailed information about these and other Windows 10 VPN configuration options, see the Windows 10 [VPN technical guide](https://docs.microsoft.com/windows/access-protection/vpn/vpn-guide).

For the next section in this guide, see [Remote Access Always On VPN Troubleshooting](always-on-vpn-deploy-troubleshooting.md).
