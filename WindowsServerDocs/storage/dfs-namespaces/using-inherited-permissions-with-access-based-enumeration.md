---
title: Using Inherited Permissions with Access-based Enumeration
description: This article describes how to use inherited permissions with access-based enumeration
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Using inherited permissions with Access-based Enumeration

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

By default, the permissions used for a DFS folder are inherited from the local file system of the namespace server. The permissions are inherited from the root directory of the system drive and grant the DOMAIN\\Users group Read permissions. As a result, even after enabling access-based enumeration, all folders in the namespace remain visible to all domain users.

## Advantages and limitations of inherited permissions

There are two primary benefits to using inherited permissions to control which users can view folders in a DFS namespace:

-   You can quickly apply inherited permissions to many folders without having to use scripts.
-   You can apply inherited permissions to namespace roots and folders without targets.

Despite the benefits, inherited permissions in DFS Namespaces have many limitations that make them inappropriate for most environments:

-   Modifications to inherited permissions are not replicated to other namespace servers. Therefore, use inherited permissions only on stand-alone namespaces or in environments where you can implement a third-party replication system to keep the Access Control Lists (ACLs) on all namespace servers synchronized.
-   DFS Management and **Dfsutil** cannot view or modify inherited permissions. Therefore, you must use Windows Explorer or the **Icacls** command in addition to DFS Management or **Dfsutil** to manage the namespace.
-   When using inherited permissions, you cannot modify the permissions of a folder with targets except by using the **Dfsutil** command. DFS Namespaces automatically removes permissions from folders with targets set using other tools or methods.
-   If you set permissions on a folder with targets while you are using inherited permissions, the ACL that you set on the folder with targets combines with inherited permissions from the folder's parent in the file system. You must examine both sets of permissions to determine what the net permissions are.

> [!NOTE]
> When using inherited permissions, it is simplest to set permissions on namespace roots and folders without targets. Then use inherited permissions on folders with targets so that they inherit all permissions from their parents.

## Using inherited permissions

To limit which users can view a DFS folder, you must perform one of the following tasks:

-   **Set explicit permissions for the folder, disabling inheritance.** To set explicit permissions on a folder with targets (a link) using DFS Management or the **Dfsutil** command, see [Enable Access-Based Enumeration on a Namespace](enable-access-based-enumeration-on-a-namespace.md).
-   **Modify inherited permissions on the parent in the local file system**. To modify the permissions inherited by a folder with targets, if you have already set explicit permissions on the folder, switch to inherited permissions from explicit permissions, as discussed in the following procedure. Then use Windows Explorer or the **Icacls** command to modify the permissions of the folder from which the folder with targets inherits its permissions.

> [!NOTE]
> Access-based enumeration does not prevent users from obtaining a referral to a folder target if they already know the DFS path of the folder with targets. Permissions set using Windows Explorer or the **Icacls** command on namespace roots or folders without targets control whether users can access the DFS folder or namespace root. However, they do not prevent users from directly accessing a folder with targets. Only the share permissions or the NTFS file system permissions of the shared folder itself can prevent users from accessing folder targets.

## To switch from explicit permissions to inherited permissions

1.  In the console tree, under the **Namespaces** node, locate the folder with targets whose visibility you want to control, right-click the folder and then click **Properties**.

2.  Click the **Advanced** tab.

3.  Click **Use inherited permissions from the local file system** and then click **OK** in the **Confirm Use of Inherited Permissions** dialog box. Doing this removes all explicitly set permissions on this folder, restoring inherited NTFS permissions from the local file system of the namespace server.

4.  To change the inherited permissions for folders or namespace roots in a DFS namespace, use Windows Explorer or the **ICacls** command.

## See also

-   [Create a DFS Namespace](create-a-dfs-namespace.md)