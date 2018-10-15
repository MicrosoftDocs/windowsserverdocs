---
title: Delegate Management Permissions for DFS Namespaces
description: This article describes how to delegate management permissions for DFS namespaces, and which groups can execute namespace tasks by default
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Delegate management permissions for DFS Namespaces

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

The following table describes the groups that can perform basic namespace tasks by default, and the method for delegating the ability to perform these tasks:

|Task | Groups that Can Perform this Task by Default | Delegation Method |
|---|---|---|
|Create a domain-based namespace|Domain Admins group in the domain where the namespace is configured|Right-click the **Namespaces** node in the console tree, and then click **Delegate Management Permissions**. Or use the [Set-DfsnRoot GrantAdminAccounts](https://technet.microsoft.com/itpro/powershell/windows/dfsn/set-dfsnroot) and [Set-DfsnRoot RevokeAdminAccounts](https://technet.microsoft.com/itpro/powershell/windows/dfsn/set-dfsnroot). Windows PowerShell cmdlets (introduced in Windows Server 2012). You must also add the user to the local Administrators group on the namespace server.|
|Add a namespace server to a domain-based namespace|Domain Admins group in the domain where the namespace is configured| Right-click the domain-based namespace in the console tree, and then click **Delegate Management Permissions**. Or use the [Set-DfsnRoot GrantAdminAccounts](https://technet.microsoft.com/itpro/powershell/windows/dfsn/set-dfsnroot) and [Set-DfsnRoot RevokeAdminAccounts](https://technet.microsoft.com/itpro/powershell/windows/dfsn/set-dfsnroot). Windows PowerShell cmdlets (introduced in Windows Server 2012). You must also add the user to the local Administrators group on the namespace server to be added.|
|Manage a domain-based namespace|Local Administrators group on each namespace server| Right-click the domain-based namespace in the console tree, and then click **Delegate Management Permissions**. |
|Create a stand-alone namespace|Local Administrators group on the namespace server| Add the user to the local Administrators group on the namespace server. |
|Manage a stand-alone namespace*|Local Administrators group on the namespace server| Right-click the stand-alone namespace in the console tree, and then click **Delegate Management Permissions**. Or use the [Set-DfsnRoot GrantAdminAccounts](https://technet.microsoft.com/itpro/powershell/windows/dfsn/set-dfsnroot) and [Set-DfsnRoot RevokeAdminAccounts](https://technet.microsoft.com/itpro/powershell/windows/dfsn/set-dfsnroot). Windows PowerShell cmdlets (introduced in Windows Server 2012).|
|Create a replication group or enable DFS Replication on a folder|Domain Admins group in the domain where the namespace is configured| Right-click the Replication node in the console tree, and then click **Delegate Management Permissions**. |

<br />

\*Delegating management permissions to manage a stand-alone namespace does not grant the user the ability to view and manage security by using the **Delegation** tab unless the user is a member of the local Administrators group on the namespace server. This issue occurs because the DFS Management snap-in cannot retrieve the discretionary access control lists (DACLs) for the stand-alone namespace from the registry. To enable the snap-in to display delegation information, you must follow the steps in the Microsoft<sup>®</sup> Knowledge Base article: [KB314837: How to Manage Remote Access to the Registry](https://go.microsoft.com/fwlink?linkid=46803)