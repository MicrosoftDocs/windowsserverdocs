---
title: Remote Access Always On VPN migration overview
description: Always On VPN addresses the previous gaps between Windows VPNs and DirectAccess, and how to migrate from DirectAccess to Always On VPN.
manager: dougkim
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: eeca4cf7-90f0-485d-843c-76c5885c54b0
ms.author: lizross
author: eross-msft
ms.date: 05/29/2018
---

# Overview of the DirectAccess to Always On VPN migration 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

&#187; [**Next:** Plan the DirectAccess to Always On VPN migration](da-always-on-migration-planning.md)

In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess, such as automatic connections initiated before users sign in. Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess. Always On VPN addresses the previous gaps between Windows VPNs and DirectAccess.

The DirectAccess–to–Always On VPN migration process consists of four primary components and high-level processes:


1.  **Plan the Always On VPN migration.** Planning helps identify target clients for user phase separation as well as infrastructure and functionality.

    1.  [!INCLUDE [build-migration-rings-shortdesc-include](../includes/build-migration-rings-shortdesc-include.md)]

    2.  [!INCLUDE [review-feature-mapping-shortdesc-include](../includes/review-feature-mapping-shortdesc-include.md)] 

    3.  [!INCLUDE [review-the-enhancements-shortdesc-include](../includes/review-the-enhancements-shortdesc-include.md)] 

    4.  [!INCLUDE [review-the-technology-overview-shortdesc-include](../includes/review-the-technology-overview-shortdesc-include.md)]

2.  **Deploy a side-by-side VPN infrastructure.** After you have determined your migration phases and the features you want to include in your deployment, you deploy the Always On VPN infrastructure side by side with the existing DirectAccess infrastructure.  

3.  **Deploy certificates and configuration to the clients.**  Once the VPN infrastructure is ready, you create and publish the required certificates to the client. When the clients have received the certificates, you deploy the VPN_Profile.ps1 configuration script. Alternatively, you can use Intune to configure the VPN client. Use Microsoft Endpoint Configuration Manager or Microsoft Intune to monitor for successful VPN configuration deployments.

4.  **Remove and decommission.** Properly decommission the environment after you have migrated everyone off DirectAccess.

    1.  [!INCLUDE [remove-da-from-client-shortdesc-include](../includes/remove-da-from-client-shortdesc-include.md)]

    2.  [!INCLUDE [decommission-da-shortdesc-include](../includes/decommission-da-shortdesc-include.md)]


## DirectAccess deployment scenario

In this deployment scenario, you use a simple DirectAccess deployment scenario as a starting point for the migration this guide presents. You do not need to match this deployment scenario before migrating to Always On VPN, but for many organizations, this simple setup is an accurate representation of their current DirectAccess deployment. The table below provides a list of basic features for this setup.

Many DirectAccess deployment scenarios and options exist, so your implementation is likely to be different from the one described here. If so, refer to [Feature mapping between DirectAccess and Always On VPN](../vpn/vpn-map-da.md) to determine the Always On VPN feature set mapping for your current additions, and then add those features to your configuration. Also, you can refer to the [Always On VPN enhancements](../vpn/always-on-vpn/always-on-vpn-enhancements.md) to add options to your Always On VPN deployment.

>[!NOTE] 
>For nondomain-joined devices, there are additional considerations, such as certificate enrollment. For details, see [Always On VPN Deployment for Windows Server and Windows 10](../vpn/always-on-vpn/deploy/always-on-vpn-deploy.md).

### Deployment scenario feature list

| DirectAccess feature | Typical scenario |
|-----|----|
| Deployment scenario                   | Deploy full DirectAccess for client access and remote management                                               |
| Network adapters                      | 2                                                                                                              |
| User authentication                   | Active Directory credentials                                                                                   |
| Use computer certificates             | Yes                                                                                                            |
| Security groups                       | Yes                                                                                                            |
| Single DirectAccess server            | Yes                                                                                                            |
| Network topology                      | Network address translation (NAT) behind an edge firewall with two network adapters                            |
| Access mode                           | End to edge                                                                                                    |
| Tunneling                             | Split tunnel                                                                                                   |
| Authentication                        | Standard public key infrastructure (PKI) authentication with machine certificate plus Kerberos (not KerbProxy) |
| Protocols                             | IP over HTTPS (IP-HTTPS)                                                                                       |
| Network location server (NLS) off-box | Yes                                                                                                            |

## Always On VPN deployment scenario

In this deployment scenario, you focus on migrating a simple DirectAccess environment to a simple Always On VPN environment, which is the DirectAccess replacement solution. The following table provides the features used in this simple solution. For more detailed information about additional enhancements to the Always On VPN client, see [Always On VPN enhancements](../vpn/always-on-vpn/always-on-vpn-enhancements.md).

### Always On VPN features used in the simple environment

| VPN feature | Deployment scenario configuration |
|-----|-----|
| Connection type | Native Internet Key Exchange version 2 (IKEv2) |
| Network adapters   | 2        |
| User authentication  | Active Directory credentials            |
| Use computer certificates        | Yes                          |
| Routing | Split Tunneling |
| Name resolution | Domain name information list and Domain Name System (DNS) suffix |
| Triggering | Always on and trusted network detection |
| Authentication  | Protected Extensible Authentication Protocol-Transport Layer Security (PEAP-TLS) with Trusted Platform Module–protected user certificates |

## Next step

[Plan the DirectAccess to Always On VPN migration](da-always-on-migration-planning.md). The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process.

---