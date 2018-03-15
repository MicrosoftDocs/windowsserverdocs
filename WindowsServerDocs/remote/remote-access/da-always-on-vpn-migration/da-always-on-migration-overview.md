---
title: Remote Access Always On VPN migration overview
description: Always On VPN addresses the previous gaps between Windows VPNs and DirectAccess, and how to migrate from DirectAccess to Always On VPN.
manager: brianlic
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: eeca4cf7-90f0-485d-843c-76c5885c54b0
ms.author: pashort
author: shortpatti
ms.date: 3/15/2018
---
DirectAccess to Always On VPN migration overview
================================================

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in). Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess. Always On VPN addresses the previous gaps between Windows VPNs and DirectAccess.

The DirectAccess–to–Always On VPN migration process consists of four primary components and high-level processes:

1.  **[Deploy Always On VPN](../vpn/vpn-top.md)**. Configure the infrastructure required to support Remote Access Always On VPNs in the Windows Server 2016 and later operating systems. Here, you use multiple client-management technologies to deploy Always-On VPN profiles to client computers running the Windows 10 Anniversary Update (version 1607) or later operating system.  

2.  **Plan.** Planning for Always On VPN includes identifying target clients for user phase separation as well as infrastructure and functionality planning.

    1.  **Build migration rings.** As in most other system migrations, target client migrations in phases to help identify any issues before they affect the entire organization. The first part of Always On VPN migration is no different.

    2.  **Review the feature mapping between DirectAccess and Always On VPN.**
        Similar to DirectAccess, Always On VPN has many security, connectivity, authentication, and other options.

    3.  **Review new features of Always On VPN.** Discover new or improved features that Always On VPN offers to improve your configuration.

3.  **Migrate.** Following a specific process to migrate clients helps minimize race conditions that arise from performing migration steps out of order.

    1.  **Deploy a side-by-side VPN infrastructure.** After you have determined your migration phases and the features you want to include in your deployment, you deploy the VPN infrastructure side by side with the existing DirectAccess infrastructure.

    2.  **Deploy certificates and the VPN configuration script.** After the VPN infrastructure is ready, you create and publish the required certificates. When the clients have received the certificates, deploy the VPN_Profile.ps1 configuration script. Alternatively, you can use Intune to configure the VPN client.

4.  **Remove and decommission.** Properly decommission the environment after you have migrated everyone off DirectAccess.

    1.  **Remove the DirectAccess configuration from the client.** Monitor Microsoft System Center Configuration Manager or Microsoft Intune for successful VPN configuration deployments. Then, use reporting
        to determine device-assignment information and discover which device belongs to each user. As users migrate successfully, you remove their devices from the DirectAccess security group so that you can remove DirectAccess from your environment.

    2.  **Decommission DirectAccess.** After you have successfully migrated all clients to Always On VPN, you remove DirectAccess from your environment. For further details about each step in the process, see the [Always On VPN migration deployment](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/da-always-on-vpn-migration/da-always-on-migration-deploy) section.

<!-- pashort 2/17/2018: maybe move these scenarios to the top of the planning page under a section for "Deployment scenarios"; the opening of the planning doc will need to be reworked to include a statement about the scenarios (stem sentence) -->

DirectAccess deployment scenario
--------------------------------

In this deployment scenario, you use a simple DirectAccess deployment scenario as a starting point for the migration this guide presents. You do not need to match this deployment scenario before migrating to Always On VPN, but for many organizations, this simple setup is an accurate representation of their current DirectAccess deployment. The table below provides a list of basic features for this setup.

Many DirectAccess deployment scenarios and options exist, so your implementation is likely to be different from the one described here. If so, refer to [Feature mapping between DirectAccess and Always On VPN](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/da-always-on-vpn-migration/da-always-on-migration-planning#feature-mapping) to determine the Always On VPN feature set mapping for your current additions, and then add those features to your configuration. Also, you can refer to the [Always On VPN enhancements](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/da-always-on-vpn-migration/da-always-on-migration-planning#always-on-vpn-enhancements) to add options to your Always On VPN deployment.

>[!NOTE] 
>For nondomain-joined devices, there are additional considerations, such as certificate enrollment. For details, see [Remote Access Always On VPN Deployment Guide for Windows Server and Windows 10](https://docs.microsoft.com/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy).

##### Deployment scenario feature list

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

Always On VPN deployment scenario
---------------------------------

In this deployment scenario, you focus on migrating a simple DirectAccess environment to a simple Always On VPN environment, which is the DirectAccess replacement solution. The following table provides the features used in this simple solution. For more detailed information about additional enhancements to the Always On VPN client, see the [Always On VPN enhancements](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/da-always-on-vpn-migration/da-always-on-migration-planning#always-on-vpn-enhancements) section.

##### Always On VPN features used in the simple environment

| VPN feature | Deployment scenario configuration |
|-----|-----|
| Connection type | Native Internet Key Exchange version 2 (IKEv2) |
| Routing | Split Tunneling |
| Name resolution | Domain name information list and Domain Name System (DNS) suffix |
| Triggering | Always on and trusted network detection |
| Authentication  | Protected Extensible Authentication Protocol-Transport Layer Security (PEAP-TLS) with Trusted Platform Module–protected user certificates |

<!-- Next steps -->
## Next steps
**[Plan your migration](da-always-on-migration-planning.md).** The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process.

<!-- pashort 2/17/2018: put a related documents section here with the external docs that are referenced -->