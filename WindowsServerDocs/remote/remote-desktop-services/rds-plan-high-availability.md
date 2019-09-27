---
title: Remote Desktop Services - High availability
description: Planning information about setting up a highly available RDS deployment.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ec630ea0-ab80-4dfe-a25f-f4f601651f72
author: lizap
ms.author: elizapo
ms.date: 09/07/2016
manager: dongill
---
# Remote Desktop Services - High availability

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Failures and throttling are unavoidable in large-scale systems. It's simple to set up Remote Desktop infrastructure roles to support high availability and allow end users to connect seamlessly, every time.

In Remote Desktop Services, the following items represent the Remote Desktop infrastructure roles, with their respective guidance to establish high availability:
- [Remote Desktop Connection Broker](Deploy-a-Remote-Desktop-Connection-Broker-cluster.md)
- [Remote Desktop Gateway](Deploy-a-RD-Web-Access-and-Gateway-farm.md)
- Remote Desktop Licensing
- [Remote Desktop Web Access](Deploy-a-RD-Web-Access-and-Gateway-farm.md)

High availability is established by duplicating each of the roles services on a second machines. In Azure, you can receive a guaranteed uptime by placing the set of the two virtual machines (hosting the same role) in an availability sets.

Along with availability sets, you can now leverage the power of Azure SQL Database and its Azure-backed SLA to ensure that you always have connection information and can redirect users to their desktops and applications.

For best practices on creating your RDS environment, please see the [desktop hosting architecture](desktop-hosting-reference-architecture.md).