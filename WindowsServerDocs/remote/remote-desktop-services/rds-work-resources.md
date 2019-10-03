---
title: Customize the RDS title “Work Resources” using PowerShell on Windows Server
description: Provides description of how to change workspace name from default in Windows Server.
ms.prod: windows-server
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 10/26/2017  
ms.topic: article
author: Heidilohr
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

For more information about the Set-RDWorkspace cmdlet, see the [Set-RDSWorkspace](https://docs.microsoft.com/powershell/module/remotedesktop/set-rdworkspace?view=win10-ps) reference.