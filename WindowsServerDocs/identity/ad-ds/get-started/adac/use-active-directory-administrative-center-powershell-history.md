---
description: Learn how to use the Windows PowerShell History Viewer in Active Directory Administrative Center to construct Windows PowerShell scripts.
title: Use the Active Directory Administrative Center Windows PowerShell History Viewer in Windows Server
ms.author: roharwoo
author: robinharwood
ms.date: 09/05/2024
ms.topic: how-to
#customer intent: As an Active Directory administrator, I want to use the Windows PowerShell History Viewer in Active Directory Administrative Center so that I can construct Windows PowerShell scripts based on the commands I run in Active Directory Administrative Center.
---

# Use the Active Directory Administrative Center Windows PowerShell History Viewer

> 

Active Directory Administrative Center now provides a complete history of all the Windows PowerShell cmdlets it runs and their arguments and values. You can copy the cmdlet history elsewhere for learning, modification, and re-use. You can create task notes to assist with understanding what your Active Directory Administrative Center commands resulted in Windows PowerShell. You can also filter the history to find points of interest.

In this article, you'll learn how to use the Windows PowerShell History Viewer in Active Directory Administrative Center (ADAC) to construct a Windows PowerShell script.

## Prerequisites

Before you can use the Windows PowerShell History Viewer in Active Directory Administrative Center (ADAC), you need to complete the following prerequisites.

- You must be using a supported version of Windows Server. To learn more about supported versions of Windows Server, see [Release information](../../../../get-started/windows-server-release-info.md).

- You must have the following Remote Server Administration Tools (RSAT) installed:

  - Active Directory Administrative Center (ADAC)

  - Active Directory module for Windows PowerShell.

- Have a basic understanding of Windows PowerShell. For example, you need to know how piping in Windows PowerShell works. For more information about piping in Windows PowerShell, see [about_Pipelines](/powershell/module/microsoft.powershell.core/about/about_pipelines).

## Construct a script

The Active Directory Administrative Center Windows PowerShell History Viewer's purpose is for you to learn through practical experience. As actions are executed in the user interface, the equivalent Windows PowerShell command is shown to the user in Windows PowerShell History Viewer.

Using the Active Directory Administrative Center (ADAC), create a user and then use the Windows PowerShell History Viewer to construct a Windows PowerShell script.

1. Sign in to a computer that has the Active Directory module for Windows PowerShell installed.

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. Select the appropriate target domain in the navigation pane.

1. Navigate to the organizational unit where you want to create the user.

1. In the **Tasks** pane, under **Users**, select **New**, then **User**.

1. Fill in the required fields and click **OK**.

1. Expand the **Windows PowerShell History** pane at the bottom of the ADAC screen.

1. Review the command that was just generated, copy it, and paste it into your desired editor to construct your script. For example, you can now modify the command to create a different user, or create a user in a different organizational unit.

You can repeat this process for other tasks in Active Directory Administrative Center.

## Related content

- [Advanced AD DS Management Using Active Directory Administrative Center (Level 200)](Advanced-AD-DS-Management-Using-Active-Directory-Administrative-Center--Level-200-.md)

