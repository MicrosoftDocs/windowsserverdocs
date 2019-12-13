---
title: Create a Remote Desktop Services collection
description: Learn how to add and RDSH and RemoteApp programs to your RDS deployment.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 10/22/2019
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ae9767e3-864a-4eb2-96c0-626759ce6d60
author: lizap
manager: dongill
---
# Create a Remote Desktop Services collection for desktops and apps to run

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Use the following steps to create a Remote Desktop Services session collection. A session collection holds the apps and desktops you want to make available to users. After you create the collection, publish it so users can access it.

Before you create a collection, you need to decide what kind of collection you need: pooled desktop sessions or personal desktop sessions. 

- **Use pooled desktop sessions for session-based virtualization**: Leverage the compute power of Windows Server to provide a cost-effective multi-session environment to drive your users' everyday workloads
- **Use personal desktop sessions for to create a virtual desktop infrastructure (VDI)**: Leverage Windows client to provide the high performance, app compatibility, and familiarity that your users have come to expect of their Windows desktop experience.
 
With a pooled session, multiple users access a shared pool of resources, while with a personal desktop session, users are assigned their own desktop from within the pool. The pooled session provides lower overall cost, while personal sessions enable users to customize their desktop experience.

If you need to share graphics-intensive hosted applications, you can combine personal session desktops with the new Discrete Device Assignment (DDA) capability to also provide support for hosted applications that require accelerated graphics. Check out [Which graphics virtualization technology is right for you](rds-graphics-virtualization.md) for more information.


Regardless of the type of collection you choose, you'll populate those collections with RemoteApps - programs and resources that users can access from any supported device and work with as though the program was running locally.

## Create a pooled desktop session collection

1.  In Server Manager, click **Remote Desktop Services > Collections > Tasks > Create Session Collections**.  
2.  Enter a name for the collection, for example **ContosoAps**.  
3.  Select the RD Session Host server you created (for example, Contoso-Shr1).  
4.  Accept the default **User Groups**.  
5.  Enter the location of the file share you created for the user profile disks for this collection (for example, **\Contoso-Cb1\UserDisksr**).   
6.  Click **Create**. When the collection is created, click **Close**.  


## Create a personal desktop session collection

Use the New-RDSessionCollection cmdlet to create a personal session desktop collection. The following three parameters provide the configuration information required for personal session desktops:

- **-PersonalUnmanaged** - Specifies the type of session collection that lets you assign users to a personal session host server. If you don't specify this parameter, then the collection is created as a traditional RD Session Host collection, where users are assigned to the next available session host when they sign in.
- **-GrantAdministrativePrivilege** - If you use **-PersonalUnmanaged**, specifies that the user assigned to the session host be given administrative privileges. If you don't use this parameter, users are granted only standard user privileges.
- **-AutoAssignUser** - If you use **-PersonalUnmanaged**, specifies that new users connecting through the RD Connection Broker are automatically assigned to an unassigned session host. If there are no unassigned session hosts in the collection, the user will see an error message. If you don't use this parameter, you have to [manually assign users to a session host](rds-manage-personal-collection.md#manually-assign-a-user-to-a-personal-session-host) before they sign in.

You can use PowerShell cmdlets to manage your personal desktop session collections. See [Manage your personal desktop session collections](rds-manage-personal-collection.md) for more information.

## Publish RemoteApp programs
Use the following steps to publish the apps and resources in your collection:

1.  In Server Manager, select the new collection (**ContosoApps**).  
2.  Under RemoteApp Programs, click **Publish RemoteApp programs**.  
3. Select the programs you want to publish, and then click **Publish**.  
