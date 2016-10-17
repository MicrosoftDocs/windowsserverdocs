---
title: Deploy RemoteApp programs
description: Share apps through RemoteApps in Remote Desktop Services (RDS) 
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd6152b3-5aaa-4f83-98cb-3de9ee5b63c0
author: lizap
manager: dongill
---
# Deploy RemoteApp programs

>Applies To: Windows Server 2016

RemoteApp programs let you share apps, programs, and resources with your users as part of your Remote Desktop Services deployment. To do this, you need to deploy a Remote Desktop Session Host (RDSH) server and collection  

There are multiple ways to deploy a desktop hosting solution. Throughout the document, specific examples are given that can be used as a starting point for a basic deployment. These examples are identified with the ( ) notation.  

Before you get started, make sure you have:  

1.  Create a [basic desktop hosting service deployment](Deploy-a-basic-desktop-hosting-environment-using-Azure-IaaS.md).   
2.  Create a [virtual machine image](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-hero-tutorial/) that contains the apps and programs you want to share.
    - For consistency, we named the new RemoteApp virtual machine "Contoso-Shr1"
    - Create a new availability set for the RemoteApp virtual machines (like, ShrAvSet)   
    - You can also create a [customized RDSH virtual machine image](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-upload-image/).  
3. [Prepare that virtual machine for Remote Desktop.](Prepare-the-RDSH-virtual-machine.md)  
4. [Add the RDSH server to the deployment, create a collection, and publish your apps and programs to users](Add-the-RDSH-Server-create-a-collection-and-publish-the-RemoteApp-programs.md).  
5. [Validate and secure the deployment](Validate-and-secure-your-remote-desktop-deployment.md).  
