---
title: Configure your desktop hosting environment
description: Get your environment ready for RDS.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fa15d0c3-2aa1-48b0-9c39-6bfc0ca4299e
author: lizap
manager: dongill
---
# Configure your desktop hosting environment

>Applies To: Windows Server 2016

Before you start deploying any of the desktop hosting solutions for Remote Desktop Services, there are some steps you need to take to prepare your environment:  
  
- Create a [Microsoft Azure subscription](https://azure.microsoft.com/free/).  
- Sign into the [Azure portal](http://ms.portal.azure.com).  
- Create an [Azure storage account](https://azure.microsoft.com/documentation/articles/storage-create-storage-account/#create-a-storage-account).
    - Create the storage account in the Azure Resource Manager and create it in a new resource group. 
- Set up an [Active Directory forest](https://azure.microsoft.com/documentation/articles/active-directory-new-forest-virtual-machine/) on a virtual network.
    - Create the virtual network in the same resource group as the storage account.
    - Ensure to follow the steps to **install AD DS**.
    - Ignore further steps to create VMs for domain members.
    - After these steps, you will have a virtual network and a domain to deploy virtual machines running Remote Desktop Services roles.
- Create [virtual machines](Create-virtual-machines-for-Remote-Desktop.md) and [prepare them for Remote Desktop](Prepare-your-virtual-machines-for-Remote-Desktop.md).  
    - After these steps, you will have three machines that are domain-joined and ready to have Remote Desktop Services roles installed on them.

Then, after you follow the steps in the hosting guides, you'll want to [validate the connection and secure the deployment](Validate-and-secure-your-Remote-Desktop-deployment.md).


