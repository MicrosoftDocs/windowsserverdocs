---
title: Deploy a Remote Desktop Session Host farm to improve availability
description: Add a second RD Session Host to yur RDS environment.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 078db266-58fe-4df9-9ccd-777bedf78d9d
author: lizap
manager: dongill
---
# Deploy a Remote Desktop Session Host farm to improve availability

>Applies To: Windows Server 2016

If you want to improve the availability and scale of your desktop hosting solution, you can deploy a Remote Desktop Session Host (RDSH) farm based on the [Microsoft Azure Desktop Hosting Reference Architecture Guide](Desktop-Hosting-Reference-Architecture.md).   
  
The scope of this scenario is limited to adding a second RDSH virtual machine to a collection in a desktop hosting deployment. For higher scale, you can add additional RDSH virtual machines by repeating the steps in this document for the same collection and other collections.   
  
There are multiple ways to deploy a desktop hosting solution. Throughout the document, specific examples are given that can be used as a starting point for a basic deployment. These examples are identified with the ( ) notation.   
  
Use the following steps to set up your deployment:  
  
1. [Create a basic desktop hosting deployment.](Deploy-a-basic-desktop-hosting-environment-using-Azure-IaaS.md)  
2. Create an additional Remote Desktop Session Host (RDSH) [virtual machine](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-hero-tutorial/).
    - For consistency, we named the second RDSH server "Contoso-Sh2"
    - Make sure to include it the same availability set as the existing RDSH server to ensure high availability  
    - You can also create a [customized RDSH virtual machine image](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-upload-image/).  
3. [Prepare that virtual machine for Remote Desktop.](Prepare-the-RDSH-virtual-machine.md)  
4. [Add the RDSH server to the collection farm](Add-the-RDSH-server-to-the-collection-farm.md).  
5. [Validate and secure the deployment](Validate-and-secure-your-remote-desktop-deployment.md).  


