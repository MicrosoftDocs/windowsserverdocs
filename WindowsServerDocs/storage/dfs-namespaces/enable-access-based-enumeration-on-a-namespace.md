---
title: Enable Access-based Enumeration on a Namespace
description: This article describes how to enable access-based enumeration on a namespace.
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Enable access-based enumeration on a namespace

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Access-based enumeration hides files and folders that users do not have permissions to access. By default, this feature is not enabled for DFS namespaces. You can enable access-based enumeration of DFS folders by using DFS Management. To control access-based enumeration of files and folders in folder targets, you must enable access-based enumeration on each shared folder by using Share and Storage Management.

To enable access-based enumeration on a namespace, all namespace servers must be running Windows Server 2008 or newer. Additionally, domain-based namespaces must use the Windows Server 2008 mode. For information about the requirements of the Windows Server 2008 mode, see [Choose a Namespace Type](choose-a-namespace-type.md).

In some environments, enabling access-based enumeration can cause high CPU utilization on the server and slow response times for users.

> [!NOTE]
> If you upgrade the domain functional level to Windows Server 2008 while there are existing domain-based namespaces, DFS Management will allow you to enable access-based enumeration on these namespaces. However, you will not be able to edit permissions to hide folders from any groups or users unless you migrate the namespaces to the Windows Server 2008 mode. For more information, see [Migrate a Domain-based Namespace to Windows Server 2008 Mode](migrate-a-domain-based-namespace-to-windows-server-2008-mode.md).


To use access-based enumeration with DFS Namespaces, you must follow these steps:

-   Enable access-based enumeration on a namespace
-   Control which users and groups can view individual DFS folders


> [!WARNING]
> Access-based enumeration does not prevent users from getting a referral to a folder target if they already know the DFS path. Only the share permissions or the NTFS file system permissions of the folder target (shared folder) itself can prevent users from accessing a folder target. DFS folder permissions are used only for displaying or hiding DFS folders, not for controlling access, making Read access the only relevant permission at the DFS folder level. For more information, see [Using Inherited Permissions with Access-Based Enumeration](https://technet.microsoft.com/library/dd834874(v=ws.11).aspx)

<br />
You can enable access-based enumeration on a namespace either by using the Windows interface or by using a command line.

## To enable access-based enumeration by using the Windows interface

1.  In the console tree, under the **Namespaces** node, right-click the appropriate namespace and then click **Properties** .

2.  Click the **Advanced** tab and then select the **Enable access-based enumeration for this namespace** check box.

## To enable access-based enumeration by using a command line

1.  Open a command prompt window on a server that has the **Distributed File System** role service or **Distributed File System Tools** feature installed.

2.  Type the following command, where *<namespace\_root>* is the root of the namespace:

    ```  
    dfsutil property abe enable \\ <namespace_root>
    ```

> [!TIP]
> To manage access-based enumeration on a namespace by using Windows PowerShell, use the [Set-DfsnRoot](https://technet.microsoft.com/library/jj884281.aspx), [Grant-DfsnAccess](https://technet.microsoft.com/library/jj884272.aspx), and [Revoke-DfsnAccess](https://technet.microsoft.com/library/jj884273.aspx) cmdlets. The DFSN Windows PowerShell module was introduced in Windows Server 2012.

You can control which users and groups can view individual DFS folders either by using the Windows interface or by using a command line.

## To control folder visibility by using the Windows interface

1.  In the console tree, under the **Namespaces** node, locate the folder with targets for which you want to control visibility, right-click it and then click **Properties**.

2.  Click the **Advanced** tab.

3.  Click **Set explicit view permissions on the DFS folder** and then **Configure view permissions**.

4.  Add or remove groups or users by clicking **Add** or **Remove**.

5.  To allow users to see the DFS folder, select the group or user, and then select the **Allow** check box.

    To hide the folder from a group or user, select the group or user, and then select the **Deny** check box.

## To control folder visibility by using a command line

1. Open a Command Prompt window on a server that has the **Distributed File System** role service or **Distributed File System Tools** feature installed.

2. Type the following command, where *&lt;DFSPath&gt;* is the path of the DFS folder (link), *<DOMAIN\\Account>* is the name of the group or user account, and *(...)* is replaced with additional Access Control Entries (ACEs):

   ```
   dfsutil property sd grant <DFSPath> DOMAIN\Account:R (...) Protect Replace
   ```

   For example, to replace existing permissions with permissions that allows the Domain Admins and CONTOSO\\Trainers groups Read (R) access to the \\contoso.office\public\training folder, type the following command:

   ```
   dfsutil property sd grant \\contoso.office\public\training "CONTOSO\Domain Admins":R CONTOSO\Trainers:R Protect Replace 
   ```

3. To perform additional tasks from the command prompt, use the following commands:


| Command | Description |
|---|---|
|[Dfsutil property sd deny](https://msdn.microsoft.com/library/dd759150(v=ws.11).aspx)|Denies a group or user the ability to view the folder.|
|[Dfsutil property sd reset](https://msdn.microsoft.com/library/dd759150(v=ws.11).aspx) |Removes all permissions from the folder.|
|[Dfsutil property sd revoke](https://msdn.microsoft.com/library/dd759150(v=ws.11).aspx)| Removes a group or user ACE from the folder. |

## See also

-   [Create a DFS Namespace](create-a-dfs-namespace.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)
-   [Installing DFS](https://technet.microsoft.com/library/cc731089(v=ws.11).aspx)
-   [Using Inherited Permissions with Access-Based Enumeration](using-inherited-permissions-with-access-based-enumeration.md)