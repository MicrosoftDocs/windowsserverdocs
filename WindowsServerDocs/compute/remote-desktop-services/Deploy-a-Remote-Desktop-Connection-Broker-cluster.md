---
title: Deploy a Remote Desktop Connection Broker cluster
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2bc58e11-cc5a-4845-b441-eaf7a5ab86c5
author: lizap
manager: msswadhwa
---
# Deploy a Remote Desktop Connection Broker cluster

>Applies To: Windows Server Technical Preview

You can deploy a Remote Desktop Connection Broker (RD Connection Broker) cluster to improve the availability and scale of a desktop hosting solution based on the Microsoft Azure Desktop Hosting Reference Architecture Guide.   
  
This article will show you how to add a second RD Connection Broker server to your existing Remote Desktop Services deployment. This article assumes that you have already created a basic deployment of Remote Desktop Services that leverages Azure Infrastructure Services.  
  
There are multiple ways to deploy a desktop hosting solution. Throughout the article, specific examples are given that can be used as a starting point for a basic deployment. These examples are identified with the ( ) notation.  
  
Use the following steps to set up your RD Connection Broker cluster:  
  
1. [Create a basic Remote Desktop hosting deployment.](Deploy-a-basic-desktop-hosting-environment-using-Azure-IaaS.md)  
2. Create a second RD Connection Broker [virtual machine](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-hero-tutorial/), and [prepare it for Remote Desktop](Prepare-the-RD-Connection-Broker-VM-for-Remote-Desktop.md).  
3. [Install a SQL native client on each RD Connection Broker server](Install-SQL-native-client-on-each-RD-Connection-Broker-server.md).  
4. [Create an Azure SQL database](Create-an-Azure-SQL-database-for-the-RD-Connection-Broker.md).  
5. [Create an Azure internal load balancer](Create-an-Azure-internal-load-balancer-for-Remote-Desktop-deployment.md) (or implement DNS round-robin for the cluster).  
6. [Add the RD Connection Broker server to the deployment](Add-the-RD-Connection-Broker-server-to-the-deployment-and-configure-high-availability.md), and then configure high availability.  
7. [Configure trusted certificates on RD Connection Broker servers and clients](Configure-trusted-certificates-on-RD-Connection-Broker-servers-and-clients.md).  
8. [Validate and secure the Remote Desktop deployment](Validate-and-secure-your-Remote-Desktop-deployment.md).   


