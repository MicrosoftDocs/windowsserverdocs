---
title: Shutdown: Clear virtual memory pagefile
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c629dde8-7bae-4736-9836-1dbdef4e5ccd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Shutdown: Clear virtual memory pagefile

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines whether the virtual memory paging file is cleared when the computer is shut down. Virtual memory support uses a system paging file to swap pages of memory to disk when they are not used. On a running computer, this paging file is opened exclusively by the operating system, and it is well protected. However, computers that are configured to allow other operating systems to start should verify that the system paging file is cleared as the computer shuts down. This confirmation ensures that sensitive information from process memory that might be placed in the paging file is not available to an unauthorized user who manages to directly access the paging file after shutdown.  
  
Important information that is kept in real memory might be written periodically to the paging file. This helps computers running at least the Windows Server 2003 operating system handle multitasking functions. A malicious user who has physical access to a server that has been shut down can view the contents of the paging file. The attacker can move the system volume into a different computer and then analyze the contents of the paging file. This is a time-consuming process, but it can expose data that is cached from RAM to the paging file. A malicious user who has physical access to the server can bypass this countermeasure by simply unplugging the server from its power source.  
  
### Possible values  
  
-   Enabled  
  
    The system paging file is cleared when the system shuts down normally. Also, this policy setting forces the computer to clear the hibernation file (hiberfil.sys) when hibernation is disabled on a portable computer.  
  
-   Disabled  
  
-   Not defined  
  
### Best practices  
  
1.  Set this policy to **Enabled**. This causes the Windows Server operating system to clear the paging file when the system is shut down. Depending on the size of the paging file, this process might take several minutes before the system completely shuts down. This delay in shutting down the server is especially noticeable on servers with large paging files. For a server with 2 gigabytes (GB) of RAM and a 2-GB paging file, this setting can add more than 30 minutes to the shutdown process. For some organizations, this downtime violates their internal service level agreements. Use caution when implementing this countermeasure in your environment.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Disabled|  
|DC Effective Default Settings|Disabled|  
|Member Server Effective Default Settings|Disabled|  
|Client Computer Effective Default Settings|Disabled|  
  
### Operating system version differences  
There are no differences in this policy between operating systems beginning with Windows Server 2003.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Important information that is kept in real memory may be written periodically to the paging file to help the operating system handle multitasking functions. An attacker who has physical access to a server that has been shut down could view the contents of the paging file. The attacker could move the system volume into a different computer and then analyze the contents of the paging file. Although this process is time consuming, it could expose data that is cached from random access memory (RAM) to the paging file.  
  
> [!CAUTION]  
> An attacker who has physical access to the computer could bypass this countermeasure by unplugging the computer from its power source.  
  
### Countermeasure  
Enable the **Shutdown: Clear virtual memory page file when system shuts down** setting. This configuration causes the operating system to clear the paging file when the computer is shut down. The amount of time that is required to complete this process depends on the size of the page file. Because the process overwrites the storage area that is used by the page file several times, it could be several minutes before the computer completely shuts down.  
  
### Potential impact  
It takes longer to shut down and restart the computer, especially on computers with large paging files. For a computer with 2 gigabytes (GB) of RAM and a 2-GB paging file, this policy setting could increase the shutdown process by more than 30 minutes. For some organizations this downtime violates their internal service level agreements. Therefore, use caution before you implement this countermeasure in your environment.  
  

