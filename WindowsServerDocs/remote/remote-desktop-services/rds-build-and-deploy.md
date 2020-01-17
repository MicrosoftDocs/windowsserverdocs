---
title: RDS - Build and deploy
description: Steps to build a Remote Desktop deployment
ms.custom: na
ms.prod: windows-server
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

[Remote Desktop clients](clients/remote-desktop-clients.md) enable access from any Windows, Apple, or Android computer, tablet, or phone.

See [Remote Desktop Services architecture](desktop-hosting-logical-architecture.md) for a detailed discussion of the different pieces that work together to make up your Remote Desktop Services deployment.

Have an existing Remote Desktop deployment built on a previous version of Windows Server? Check out your options for moving to WIndows Server 2016, where you can take advantage of new and better functionality around performance and scale:

- [Migrate your RDS deployment to Windows Server 2016](migrate-rds-role-services.md)
- [Upgrade your RDS deployment to Windows Server 2016](upgrade-to-rds-2016.md)

Want to create a new Remote Desktop deployment? Use the following information to deploy Remote Desktop in Windows Server 2016:

- [Deploy the Remote Desktop Services infrastructure](rds-deploy-infrastructure.md)
- [Create a session collection to hold the apps and resources you want to share](rds-create-collection.md)
- [License your RDS deployment](rds-client-access-license.md)
- Have your users install a [Remote Desktop client](clients/remote-desktop-clients.md) so they can access the apps and resources. 
- Enable high availability by adding additional Connection Brokers and Session Hosts:
   - [Scale out an existing RDS collection with an RD Session Host farm](rds-scale-rdsh-farm.md)
   - [Add high availability to the RD Connection Broker infrastructure](rds-connection-broker-cluster.md)
   - [Add high availability to the RD Web and RD Gateway web front](rds-rdweb-gateway-ha.md)
   - [Deploy a two-node Storage Spaces Direct file system for UPD storage](rds-storage-spaces-direct-deployment.md)


If you're a hosting partner interested in using Remote Desktop to provide apps and resources to customers or a customer looking for someone to host your apps, check out [Remote Desktop Services hosting partners](rds-hosting-partners.md) for information about an assessment you can take about using RDS in Azure as a hosting environment, as well as a list of partners who've passed it.
