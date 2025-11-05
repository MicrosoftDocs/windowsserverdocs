---
title: RDS - Build and deploy
description: Steps to build a Remote Desktop deployment
ms.author: daknappe
ms.date: 7/3/2024
ms.topic: install-set-up-deploy
author: dknappettmsft
---
# Build and deploy your Remote Desktop Services deployment

A Remote Desktop Services deployment is the infrastructure used to share apps and resources with your users. Depending on the experience you want to provide, you can make it as small or complex as you need. Remote Desktop deployments are easily scaled. You can increase and decrease Remote Desktop Web Access, Gateway, Connection Broker and Session Host servers at will. You can use Remote Desktop Connection Broker to distribute workloads. Active Directory based authentication provides a highly secure environment.

[Remote Desktop clients](clients/remote-desktop-clients.md) enable access from any Windows, Apple, or Android computer, tablet, or phone.

See [Remote Desktop Services architecture](desktop-hosting-logical-architecture.md) for a detailed discussion of the different pieces that work together to make up your Remote Desktop Services deployment.

Have an existing Remote Desktop deployment built on a previous version of Windows Server? Check out your options for moving to the latest version of Windows Server, where you can take advantage of new and better functionality around performance and scale:

- [Migrate your RDS deployment](migrate-rds-role-services.md)
- [Upgrade your RDS deployment](./upgrade-to-rds.md)

Want to create a new Remote Desktop deployment? Use the following information to deploy Remote Desktop in Windows Server:

- [Deploy the Remote Desktop Services infrastructure](rds-deploy-infrastructure.md)
- [Create a session collection to hold the apps and resources you want to share](rds-create-collection.md)
- [License your RDS deployment](rds-client-access-license.md)
- Have your users install a [Remote Desktop client](clients/remote-desktop-clients.md) so they can access the apps and resources.
- Enable high availability by adding additional Connection Brokers and Session Hosts:
   - [Scale out an existing RDS collection with an RD Session Host farm](rds-scale-rdsh-farm.md)
   - [Add high availability to the RD Connection Broker infrastructure](rds-connection-broker-cluster.md)
   - [Add high availability to the RD Web and RD Gateway web front](rds-rdweb-gateway-ha.md)
   - [Deploy a two-node Storage Spaces Direct file system for UPD storage](rds-storage-spaces-direct-deployment.md)
