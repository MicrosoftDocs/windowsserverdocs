---
title: Change the Priority for DNS Service (SRV) Resource Records in the Registry
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 66951bd5-8b07-42aa-9a0e-07379b16b31e
author: Femila
---
# Change the Priority for DNS Service (SRV) Resource Records in the Registry
  You can use this procedure to reduce the workload on the primary domain controller \(PDC\) emulator operations master by changing the priority for Domain Name System \(DNS\) service \(SRV\) resource records in the registry.  
  
> [!CAUTION]  
>  Registry Editor bypasses standard safeguards, which allows settings that can damage your system or even require you to reinstall Windows. If you must edit the registry, back up critical volumes first. For information about backing up critical volumes, see [Administering Active Directory Backup and Recovery](../Topic/Administering-Active-Directory-Backup-and-Recovery.md).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the priority for DNS SRV records in the registry  
  
1.  Open Registry Editor as an administrator: Click **Start** and then, in **Start Search**, type **regedit**. At the top of the **Start** menu, right\-click **regedit**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  In Registry Editor, navigate to **HKLM\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**.  
  
3.  Click **Edit**, click **New**, and then click **DWORD \(32\-BIT\) Value**.  
  
4.  For the new value name, type **LdapSrvPriority**, and then press ENTER.  
  
5.  Double\-click the value name that you just typed to open the **Edit DWORD \(32\-BIT\) Value** dialog box.  
  
6.  Enter a value from 0 through 65535. The default value is 0.  
  
7.  Choose **Decimal** as the **Base** option, and then click **OK**.  
  
8.  Click **File**, and then click **Exit** to close Registry Editor.  
  
  