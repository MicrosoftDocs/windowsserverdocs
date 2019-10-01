---
title: Developing for Nano Server
description: "PowerShell remoting and CIM sessions"
ms.prod: windows-server
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/06/2017
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 57079470-a1c1-4fdc-af15-1950d3381860
author: jaimeo
ms.author: jaimeo
ms.localizationpriority: medium
---
# Developing for Nano Server

>Applies To: Windows Server 2016

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means. 

These topics explain important differences in PowerShell on Nano Server and also provide guidance for developing your own PowerShell cmdlets for use on Nano Server.

- [PowerShell on Nano Server](PowerShell-on-Nano-Server.md)
- [Developing PowerShell Cmdlets for Nano Server](Developing-PowerShell-Cmdlets-for-Nano-Server.md)

## Using Windows PowerShell remoting  
To manage Nano Server with Windows PowerShell remoting, you need to add the IP address of the Nano Server to your management computer's list of trusted hosts, add the account you are using to the Nano Server's administrators, and enable CredSSP if you plan to use that feature.  

> [!NOTE]
> If the target Nano Server and your management computer are in the same AD DS forest (or in forests with a trust relationship), you should not add the Nano Server to the trusted hosts list--you can connect to the Nano Server by using its fully qualified domain name, for example:
>     PS C:\> Enter-PSSession -ComputerName nanoserver.contoso.com -Credential (Get-Credential)
  
  
To add the Nano Server to the list of trusted hosts, run this command at an elevated Windows PowerShell prompt:  
  
`Set-Item WSMan:\localhost\Client\TrustedHosts "<IP address of Nano Server>"`  
  
To start the remote Windows PowerShell session, start an elevated local Windows PowerShell session, and then run these commands:  
  
  
```  
$ip = "\<IP address of Nano Server>"  
$user = "$ip\Administrator"  
Enter-PSSession -ComputerName $ip -Credential $user  
```  
  
  
You can now run Windows PowerShell commands on the Nano Server as normal.  
  
> [!NOTE]  
> Not all Windows PowerShell commands are available in this release of Nano Server. To see which are available, run `Get-Command -CommandType Cmdlet`  
  
Stop the remote session with the command `Exit-PSSession`  
  
## Using Windows PowerShell CIM sessions over WinRM  
You can use CIM sessions and instances in Windows PowerShell to run WMI commands over Windows Remote Management (WinRM).  
  
Start the CIM session by running these commands in a Windows PowerShell prompt:  
  
  
```  
$ip = "<IP address of the Nano Server\>"  
$ip\Administrator  
$cim = New-CimSession -Credential $user -ComputerName $ip  
```  
  
  
With the session established, you can run various WMI commands, for example:  
  
  
```  
Get-CimInstance -CimSession $cim -ClassName Win32_ComputerSystem | Format-List *  
Get-CimInstance -CimSession $Cim -Query "SELECT * from Win32_Process WHERE name LIKE 'p%'"  
```  
  
  