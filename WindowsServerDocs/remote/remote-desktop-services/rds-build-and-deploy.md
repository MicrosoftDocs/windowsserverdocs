---
title: RDS - Build and deploy
description: Steps to build a Remote Desktop deployment
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 04/18/2017  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 176ae424-96e9-4c78-88f5-da418e76c3d7
author: lizap
manager: dongill
---
# Build and deploy your Remote Desktop Services deployment

A Remote Desktop Services deployment is the infrastructure used to share apps and resources with your users. Depending on the experience you want to provide, you can make it as small or complex as you need. Remote Desktop deployments are easily scaled. You can increase and decrease Remote Desktop Web Access, Gateway, Connection Broker and Session Host servers at will. You can use Remote Desktop Connection Broker to distribute workloads. Active Directory based authentication provides a highly secure environment. 

[Remote Desktop clients](clients\remote-desktop-clients.md) enable access from any Windows, Apple, or Android computer, tablet, or phone.

Use the following information to build and deploy your Remote Desktop Services deployment:

- [Migrate your RDS deployment to Windows Server 2016](migrate-rds-role-services.md)
- [Upgrade your RDS deployment to Windows Server 2016](upgrade-to-rds-2016.md)
- [Deploy the Remote Desktop Services infrastructure](rds-deploy-infrastructure.md)
- [Create a session collection to hold the apps and resources you want to share](rds-create-collection.md)
- [License your RDS deployment](rds-client-access-license.md)
- Have your users install a [Remote Desktop client](clients/remote-desktop-clients.md) so they can access the apps and resources. 
- Enable high availability by adding additional Connection Brokers and Session Hosts:
   - [Scale out an existing RDS collection with an RD Session Host farm](rds-scale-rdsh-farm.md)
   - [Add high availability to the RD Connection Broker infrastructure](rds-connection-broker-cluster.md)
   - [Add high availability to the RD Web and RD Gateway web front](rds-rdweb-gateway-ha.md)
   - [Deploy a two-node Storage Spaces Direct file system for UPD storage](rds-storage-spaces-direct-deployment.md)


If you want to create a cloud-based hosting environment based on the [Desktop Hosting Reference Architecture](desktop-hosting-reference-architecture.md), use the following information. 

- [Deploy a desktop hosting environment.](deploy-a-basic-desktop-hosting-environment-using-azure-iaas.md)
- [Configure your desktop hosting environment.](configure-your-desktop-hosting-environment.md)
- [Deploy a Remote Desktop Session Host farm to improve availability.](deploy-a-remote-desktop-session-host-farm-to-improve-availability.md)
- [Deploy a Remote Desktop Connection Broker cluster.](deploy-a-remote-desktop-connection-broker-cluster.md)
- [Deploy a RD Web Access and Gateway farm.](deploy-a-rd-web-access-and-gateway-farm.md)
- [Deploy RemoteApp programs.](deploy-remoteapp-programs.md)

