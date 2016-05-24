---
title: GPO_DOMISO_Firewall
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd978d05-a17e-4bb8-bae9-6b6871863d50
author: vhorne
---
# GPO_DOMISO_Firewall
This GPO is authored by using the [!INCLUDE[wfas](../Token/wfas_md.md)] interface in the Group Policy editing tools. The User Configuration section of the GPO is disabled. It is intended to only apply to computers that are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
## Firewall settings  
This GPO provides the following settings:  
  
-   Unless otherwise stated, the firewall rules and settings described here are applied to all profiles.  
  
-   The firewall is enabled, with inbound, unsolicited connections blocked and outbound connections allowed.  
  
-   Under the domain profile, the settings **Display notifications to the user**, **Apply local firewall rules**, and **Apply local connection security rules** are all set to **No**. These settings are applied only to the domain profile because the computers can only receive an exception rule for a required program from a GPO if they are connected to the domain. Under the public and private profiles, those settings are all set to **Yes**.  
  
    > [!NOTE]  
    > Enforcing these settings requires that you define any firewall exceptions for programs, because the user cannot manually permit a new program. You must deploy the exception rules by adding them to this GPO. We recommend that you do not enable these settings until you have tested all your applications and have tested the resulting rules in a test lab and then on pilot computers.  
  
## Firewall rules  
This GPO provides the following rules:  
  
-   Built\-in firewall rule groups are configured to support typically required network operation. The following rule groups are set to **Allow the connection**:  
  
    -   Core Networking  
  
    -   File and Printer Sharing  
  
    -   Network Discovery  
  
    -   Remote Administration  
  
    -   Remote Desktop  
  
    -   Remote Event Log Management  
  
    -   Remote Scheduled Tasks Management  
  
    -   Remote Service Management  
  
    -   Remote Volume Management  
  
    -   Windows Firewall Remote Management  
  
    -   Windows Management Instrumentation \(WMI\)  
  
    -   Windows Remote Management  
  
-   A firewall exception rule to allow required network traffic for the WGBank dashboard program. This inbound rule allows network traffic for the program Dashboard.exe in the %ProgramFiles%\\WGBank folder. The rule is also filtered to only allow traffic on port 1551. This rule is applied only to the domain profile.  
  
**Next:**[Isolated Domain GPOs](../Topic/Isolated-Domain-GPOs.md)  
  
