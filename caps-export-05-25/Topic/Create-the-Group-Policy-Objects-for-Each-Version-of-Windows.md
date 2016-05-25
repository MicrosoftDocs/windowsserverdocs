---
title: Create the Group Policy Objects for Each Version of Windows
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 37d645b8-38c7-4115-9de8-d571c711127e
author: coreyp
---
# Create the Group Policy Objects for Each Version of Windows
Use this procedure to create the GPOs. Create one GPO for each version of Windows that requires different settings to achieve the desired configuration.  
  
Membership in **Domain Admins** is the minimum required to complete this procedure.  
  
### To create the GPOs  
  
1.  On AD\-DNS\-01, in Server Manager, click **Tools**, and then click **Group Policy Management**. The Group Policy Management Console \(GPMC\) opens.  
  
2.  In the GPMC navigation pane, expand **Forest:** *your forest name*, expand **Domains**, expand your domain, and then click **Group Policy Objects**.  
  
3.  Click **Action**, and then click **New**.  
  
4.  In the **New GPO** dialog box, in **Name**, type the name of the GPO. Use a name that indicates both the function and the target group \(for example, **GPO\_FunctionA\_W2K12**\). Click **OK** to save your GPO.  
  
5.  Repeat step 5 for each of the other versions of Windows supported by the membership group \(**GPO\_FunctionA\_W2K8 R2**, **GPO\_FunctionA\_W2K8**, **GPO\_FunctionA\_W2K3**, **GPO\_FunctionA\_Windows\_8**, **GPO\_FunctionA\_Windows\_7**, **GPO\_FunctionA\_Vista**, and **GPO\_FunctionA\_XP**\).  
  
