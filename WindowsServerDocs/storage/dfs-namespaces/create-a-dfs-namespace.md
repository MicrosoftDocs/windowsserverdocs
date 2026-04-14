---
title: Create a DFS Namespace in Windows Server
description: Use 
ms.date: 04/03/2025
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ai-usage: ai-assisted
---

# Create a DFS namespace

This article describes how to create a Distributed File System (DFS) namespace in Windows Server. A DFS namespace is a virtual view of shared folders in an organization. It allows users to access shared folders using a single path, regardless of the physical location of the shared folders.

To create a new namespace, you can use Server Manager to create the namespace when you install the Distributed File System (DFS) Namespaces role service or  the [New-DfsnRoot](/powershell/module/dfsn/new-dfsnroot) PowerShell cmdlet.

## Prerequisites

Before you create a DFS Namespace, ensure that you have the following prerequisites:

- You must be a member of the **Administrators** group, or equivalent, on the computer where you're creating the namespace. To learn more, about the delegation of permissions required to create a namespace, see [Delegate management permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md).

- You must have the **DFS Namespaces** role service installed on the computer where you're creating the namespace.

- For both stand-alone and domain-based namespaces, ensure the namespace location is secure. This location can be the default path (_C:\DFSRoots_) or a custom path specified by the administrator during namespace creation. Restrict access to authorized users only. Doing so helps protect the configuration and reduces the risk of misuse or exploitation.

## Create the namespace

To create a DFS namespace, you can use the **DFS Management** console or the **New-DfsnRoot** PowerShell cmdlet. Select the method that best suits your needs.

### [DFS Management console](#tab/dfs-management-console)

The following procedure describes how to create a namespace using the DFS Management console.

1. Select **Start**, point to **Administrative Tools**, and then select **DFS Management**.

1. In the console tree, right-click the **Namespaces** node, and then select **New Namespace**.

1. On the **Namespace Server** screen, select the server on which you want to create the namespace, then select **Next**.

1. Enter the new namespace name in the **Name** box on the **Namespace Name and Settings** screen, then select **Next**.

1. Select the type of namespace you want to create on the **Namespace Type** screen. You can choose between a domain-based namespace or a stand-alone namespace. Make your selection, and then select **Next**.

   > [!IMPORTANT]
   > Don't attempt to create a domain-based namespace using the Windows Server 2008 mode unless the forest functional level is Windows Server 2003 or higher. Doing so can result in a namespace for which you can't delete DFS folders, yielding the following error message: "The folder can't be deleted. Can't complete this function."

1. On the **Review Settings and Create Namespace** screen, review the settings for the namespace. If everything looks correct, select **Create** to create the namespace.

1. Wait for the namespace to be created. This process might take a few minutes, depending on your environment. Once the namespace is created, you see a message indicating that the namespace was created successfully. Select **Close** to close the wizard.

### [PowerShell](#tab/powershell)

The following procedure describes how to create a namespace using the **New-DfsnRoot** PowerShell cmdlet.

1. Open an elevated **Windows PowerShell** as an administrator.

1. Create a folder to serve as the root of the namespace. For example, you can create a folder named **C:\DFSRoots\<namespace>**. Use the following command replacing `<NamespaceName>` with the name of your namespace:

   ```powershell
   New-Item -Path "C:\DFSRoots\<NamespaceName>" -ItemType Directory
   ```

1. Share the newly created folder. Use the following command replacing `<NamespaceName>` with the name of your namespace:

   ```powershell
   New-SmbShare -Name "<NamespaceName>" -Path "C:\DFSRoots\<NamespaceName>" -ReadAccess "<domainFQDN>\<groupName>"
   ```

   > [!NOTE]
   > The `-ReadAccess` parameter specifies read access to the DFS Namespace root share only for users in the group.

1. To create a DFS Namespace, use one of the following steps. Replace `<ServerName>`, `<DomainName>`, `<NamespaceName>`, `<TargetHost>`, and `<TargetPath>` with the appropriate values for your environment.

   1. To create a stand-alone namespace, use the following command:

   ```powershell
   New-DfsnRoot -Path "\\<ServerName>\<NamespaceName>" -TargetPath "<TargetPath>" -Type Standalone
   ```

   OR

   1. To create a domain-based namespace, use the following command:

   ```powershell
   New-DfsnRoot -Path "\\<DomainName>\<NamespaceName>" -TargetPath "\\<TargetHost>\<TargetPath>" -Type DomainV2
   ```

1. To verify that the namespace was created successfully, use the following command:

   ```powershell
   Get-DfsnRoot
   ```

   This command displays a list of all DFS namespaces on the server, including the one you created.

---

## Secure the namespace

After creating the namespace, you should secure it by restricting access to the namespace folder. You should secure both the stand-alone and domain-based namespaces. Securing the namespace is important to maintain configuration integrity and mitigate the risk of exploitation.

To secure the namespace, you can use the following procedure:

1. In **Windows Explorer**, navigate to the namespace folder (for example, _C:\DFSRoots\My Namespace_).

1. Right-click the folder, and then select **Properties**.

1. On the **Security** tab, select **Advanced**.

1. In the **Advanced Security Settings** dialog box, select **Change Permissions**, then select **Disable Inheritance**.

1. Select **Convert inherited permissions into explicit permissions on this object** to convert the inherited permissions into explicit permissions.

1. Remove any groups or users that shouldn't have access to the namespace folder. For example, remove the **CREATOR OWNER** principle with **Full control** access. Also remove **Users** groups with the **Special** access privilege. This entry is added by default and allows all users to create files and folders in the namespace folder.

   > [!NOTE]
   > Permissions are inherited from the parent folder. Permissions for the namespace root folder are independent of the permissions for the target folders. You must set permissions for the namespace root folder and the target folders separately.

## Related content

- [Deploying DFS Namespaces](deploying-dfs-namespaces.md)

- [Choose a Namespace Type](choose-a-namespace-type.md)

- [Add Namespace Servers to a Domain-based DFS Namespace](add-namespace-servers-to-a-domain-based-dfs-namespace.md)

- [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md).

