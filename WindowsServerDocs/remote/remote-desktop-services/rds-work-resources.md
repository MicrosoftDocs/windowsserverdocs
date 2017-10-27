---
title: Customize the RDS title “Work Resources” using PowerShell on Windows Server
description: Provides description of how to change workspace name from default in Windows Server.
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 10/26/2017  
ms.topic: article
author: Heidilohr
---
# Customize the RDS title “Work Resources” using PowerShell on Windows Server

When using Windows Server to access RemoteApps or desktops through RD WebAccess or the new Remote Desktop App, you may have noticed that the workspace is titled  “Work Resources" by default.  Although the config file called RDWAStrings.xml (inside C:\Windows\Web\RDWeb\Pages\en-US) allows changes in certain strings, the title “Work Resources” is set on a deployment (workspace) level and can't be changed using the .xml file. We can only change it with PowerShell.

To change the title, open up a new PowerShell window and import the RemoteDesktop module with the following command.

    Import-Module RemoteDesktop

Next, use the set-RDWorkspace command to change the workspace name.

    Set-RDWorkspace [-Name] <string> [-ConnectionBroker <string>]  [<CommonParameters>]

For example, you can use the following command to change the workpsace name to "XYZ Applications":

    set-RDWorkspace -Name "XYZ Applications" -ConnectionBroker broker01.company.local

If you are running multiple Connection Brokers in High Availability mode, you must run this against the active broker. You can use this command:

    Set-RDWorkspace -Name "XYZ Applications" -ConnectionBroker (Get-RDConnectionBrokerHighAvailability).ActiveManagementServer