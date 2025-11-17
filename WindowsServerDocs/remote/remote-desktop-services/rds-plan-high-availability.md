---
title: Remote Desktop Services - High availability
description: Planning information about setting up a highly available RDS deployment.
ms.topic: best-practice
author: dknappettmsft
ms.author: daknappe
ms.date: 7/3/2024
---
# Remote Desktop Services - High availability

Failures and throttling are unavoidable in large-scale systems. It's simple to set up Remote Desktop infrastructure roles to support high availability and allow end users to connect seamlessly, every time.

In Remote Desktop Services, the following items represent the Remote Desktop infrastructure roles, with their respective guidance to establish high availability:
- [Remote Desktop Connection Broker](./rds-connection-broker-cluster.md)
- [Remote Desktop Gateway](./rds-rdweb-gateway-ha.md)
- [Remote Desktop Licensing](./rds-client-access-license.md)
- [Remote Desktop Web Access](./rds-rdweb-gateway-ha.md)

High availability is established by duplicating each of the roles services on a second machines. In Azure, you can receive a guaranteed uptime by placing the set of the two virtual machines (hosting the same role) in an availability sets.

Along with availability sets, you can now leverage the power of Azure SQL Database and its Azure-backed SLA to ensure that you always have connection information and can redirect users to their desktops and applications.

For best practices on creating your RDS environment, please see the [desktop hosting architecture](desktop-hosting-reference-architecture.md).
