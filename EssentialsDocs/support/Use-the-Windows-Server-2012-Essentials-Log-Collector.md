---
title: "Use the Windows Server 2012 Essentials Log Collector"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: c6985518-b42d-4cfb-9761-eaa75306b6d7
caps.latest.revision: 12
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-at
  - de-de
  - es-es
  - fr-be
  - fr-fr
  - it-ch
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-tw
---
# Use the Windows Server 2012 Essentials Log Collector
When you are troubleshooting computer issues, a representative from Microsoft Customer Service and Support may ask you to gather logs from servers, computers on the network, or both by using the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials Log Collector.  
  
 The Log Collector copies program logs, event reviewer logs, and related environment information into a single zip file at a specified location. You can run the Log Collector directly from the server or any computer on the network, or by using a remote connection to the computers.  
  
> [!NOTE]
>  -   The Log Collector does not analyze network issues or make changes to any server or computer on the network. For information about how to troubleshoot network issues, see the Help documentation for your server product.  
> -   In this guide, the computers on your network, other than your server, are called “network computers.�?  
> -   [Download the Windows Server 2012 Essentials Log Collector installation package](http://go.microsoft.com/fwlink/?LinkID=266341).  
  
 To install and run the Log Collector, perform the steps in the following topics:  
  
1.  [Install the Log Collector](../support/Install-the-Windows-Server-2012-Essentials-Log-Collector.md)  
  
2.  [Run the Log Collector](../support/Run-the-Windows-Server-2012-Essentials-Log-Collector.md)  
  
## Environment information collected  
 For each network computer or server that you specify, the Log Collector gathers the following environment information and places it into the log collection file.  
  
-   Operating system version  
  
-   CPU manufacturer and description  
  
-   Memory amount and allocation  
  
-   Network adapters that are bound to TCP/IP  
  
-   Locale  
  
-   Processes  
  
-   Storage configuration  
  
-   Host file information  
  
-   Event Logs including Application, System, Windows Server and Media Center  
  
-   Service Control Manager messages  
  
-   Reboot events and Windows Update events  
  
-   System Errors and Application Errors  
  
## Services information collected  
  
### Server services  
  
-   Windows Server Client Computer Backup Service  
  
-   Windows Server Client Computer Backup Provider Service  
  
-   Windows Server Devices Provider  
  
-   Windows Server Domain Name Management  
  
-   Windows Server Service Provider Registry  
  
-   Windows Server Settings Provider  
  
-   Windows Server UPnP Device Service  
  
-   Windows Server Remote Web Access Administration Provider  
  
-   Windows Server Health Service  
  
-   Windows Server Storage Service  
  
-   Windows Server SQM Service  
  
### Network computer services  
  
-   Windows Server Client Computer Backup Provider Service  
  
-   Windows Server Health Service  
  
-   Windows Server Service Provider Registry  
  
-   Windows Server SQM Service  
  
## Logs and registry information collected  
 For each network computer or server specified, the Log Collector gathers log and registry information from the server and network computer as follows.  
  
### Server logs and registry information  
  
-   Server product logs, from <ProgramData\>\Microsoft\Windows Server\Logs  
  
-   Scheduled tasks  
  
-   Setup API logs  
  
-   Windows Update logs  
  
-   Health Alerts file  
  
-   Devices Info file  
  
-   Server Backup Log file  
  
-   Panther Log file  
  
-   Services  
  
-   Registry keys, from  
  
    -   \\\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\  
  
    -   \\\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DevicesProviderSvc  
  
    -   \\\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DomainManagerProviderSvc  
  
### Network computer logs and registry information  
  
-   Network computer product logs at <ProgramData\>\Microsoft\Windows Server\Logs  
  
-   Health Alerts file at <ProgramData\>\Microsoft\Windows Server\Data  
  
-   Windows Update logs  
  
-   Setup API logs  
  
-   Scheduled tasks info  
  
-   Registry keys from \\\HKEY_LOCAL_MACHINE \SOFTWARE\Microsoft\Windows Server\  
  
## Logs for computers that do not run a version of the Windows operating system  
 The Log Collector does not gather log files from computers that do not run a version of the Windows operating system. For non-Windows computers, manually copy the following log files to the same location where you are storing the Log Collector files.  
  
-   System.log  
  
-   Library/Logs/Windows Server.log  
  
-   Library/Logs/CrashReporter/LaunchPad-<nnn\> (copy all of the LaunchPad-<nnn\>.crash files)  
  
-   Library/Logs/DiagnosticReports/LaunchPad-<nnn\> (copy all of the LaunchPad-<nnn\>.crash files)  
  
## See also  
  
-   [Troubleshoot Log Collector Errors](../support/Troubleshoot-Windows-Server-2012-Essentials-Log-Collector-Errors.md)
