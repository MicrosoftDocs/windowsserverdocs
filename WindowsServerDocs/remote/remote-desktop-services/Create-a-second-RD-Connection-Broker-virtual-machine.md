---
title: Create a second RD Connection Broker virtual machine
description: Learn how to create an additional RDCB VM.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: afcbc712-3c8d-4b4e-a78f-38ec57e50c31
author: lizap
manager: dongill
---
# Create a second RD Connection Broker virtual machine

>Applies To: Windows Server 2016

Use the following steps to create a virtual machine to host the RD Connection Broker role service:  
  
1. In the Azure portal, click **Browse > Virtual machines > Add > Windows Server**.   
2. Click **Windows Server 2016**.  
3. Choose **Resource Manager** for the deployment model, and then click **Create**.  
4. Enter a name for the virtual machine (for example, Contoso-CB2).  
5. Enter a user name and password to add to the local administrators group.  
6. Select the appropriate Azure subscription and location.  
7. For **Resource group**, click **Select existing**, and then select the resource group created in the basic deployment (for example, Contoso-RG). Then click **OK**.  
8. Set the size (A1 Standard), and then click **Select**.   
9. Select the storage account you created in the prerequisites, and then click **OK**.  
10. Select **Network security group** and **None**.  
11. For **Availability set**, select the availability set created in the basic deployment, (for example, CBAvSet).  
12. Accept the other default options, and then click **OK**.  
13. Click **OK** 


