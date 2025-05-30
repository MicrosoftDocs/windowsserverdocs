---
title: Customize the RDS title “Work Resources” using PowerShell on Windows Server
description: Provides description of how to change workspace name from default in Windows Server.
author: xelu86
ms.date: 7/3/2024
ms.topic: how-to
ms.author: alalve
---
# Customize the RDS title “Work Resources” using PowerShell on Windows Server

When using Windows Server to access RemoteApps or desktops through RD WebAccess or the new Remote Desktop app, you may have noticed that the workspace is titled  “Work Resources" by default.  You can easily change the title by using PowerShell cmdlets.

To change the title, open up a new PowerShell window on the connection broker server and import the RemoteDesktop module with the following command.

```powershell
    Import-Module RemoteDesktop
```

Next, use the Set-RDWorkspace command to change the workspace name.

```powershell
    Set-RDWorkspace [-Name] <string> [-ConnectionBroker <string>]  [<CommonParameters>]
```

For example, you can use the following command to change the workpsace name to "Contoso RemoteApps":

```powershell
    Set-RDWorkspace -Name "Contoso RemoteApps" -ConnectionBroker broker01.contoso.com
```

If you are running multiple Connection Brokers in High Availability mode, you must run this against the active broker. You can use this command:

```powershell
    Set-RDWorkspace -Name "Contoso RemoteApps" -ConnectionBroker (Get-RDConnectionBrokerHighAvailability).ActiveManagementServer
```

For more information about the Set-RDWorkspace cmdlet, see the [Set-RDSWorkspace](/powershell/module/remotedesktop/set-rdworkspace) reference.
