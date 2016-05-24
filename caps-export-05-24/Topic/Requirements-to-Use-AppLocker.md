---
title: Requirements to Use AppLocker
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c366bf00-8554-4d74-8af6-a4d61f49d268
---
# Requirements to Use AppLocker
This topic for the IT professional lists software requirements to use AppLocker on the supported Windows operating systems.  
  
## General requirements  
To use AppLocker, you need:  
  
-   A computer running a supported operating system to create the rules. The computer can be a domain controller.  
  
-   For Group Policy deployment, at least one computer with the Group Policy Management Console \(GPMC\) or Remote Server Administration Tools \(RSAT\) installed to host the AppLocker rules.  
  
-   Computers running a supported operating system to enforce the AppLocker rules that you create.  
  
> [!NOTE]  
> You can use Software Restriction Policies with AppLocker, but with some limitations. For more information, see [Use AppLocker and Software Restriction Policies in the Same Domain](../Topic/Use-AppLocker-and-Software-Restriction-Policies-in-the-Same-Domain.md).  
  
## Operating system requirements  
The following table show the on which operating systems AppLocker features are supported.  
  
|Version|Can be configured|Can be enforced|Available rules|Notes|  
|-----------|---------------------|-------------------|-------------------|---------|  
|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL||  
|[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL|Only the Enterprise edition supports AppLocker|  
|[!INCLUDE[winblue_winrt_2](../Token/winblue_winrt_2_md.md)]|No|No|NA||  
|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL||  
|[!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL||  
|[!INCLUDE[win8_client_pro_2](../Token/win8_client_pro_2_md.md)]|No|No|NA||  
|[!INCLUDE[win8_client_ent_2](../Token/win8_client_ent_2_md.md)]|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL||  
|[!INCLUDE[winrt_2](../Token/winrt_2_md.md)]|No|No|NA||  
|[!INCLUDE[nextref_server_7std](../Token/nextref_server_7std_md.md)]|Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|  
|[!INCLUDE[nextref_server_7ent](../Token/nextref_server_7ent_md.md)]|Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|  
|[!INCLUDE[nextref_server_7dat](../Token/nextref_server_7dat_md.md)]|Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|  
|[!INCLUDE[nextref_server_7itan](../Token/nextref_server_7itan_md.md)]|Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|  
|[!INCLUDE[nextref_client_7ult](../Token/nextref_client_7ult_md.md)]|Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|  
|[!INCLUDE[nextref_client_7ent](../Token/nextref_client_7ent_md.md)]|Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|  
|[!INCLUDE[nextref_client_7pro](../Token/nextref_client_7pro_md.md)]|Yes|No|Executable<br />Windows Installer<br />Script<br />DLL|No AppLocker rules are enforced.|  
  
AppLocker is not supported on versions of the Windows operating system not listed above. Software Restriction Policies can be used with those versions. However, the SRP Basic User feature is not supported on the above operating systems.  
  
## See also  
[Administer AppLocker](../Topic/Administer-AppLocker.md)  
  
[Monitor Application Usage with AppLocker](../Topic/Monitor-Application-Usage-with-AppLocker.md)  
  
[Optimize AppLocker Performance](../Topic/Optimize-AppLocker-Performance.md)  
  
[Use AppLocker and Software Restriction Policies in the Same Domain](../Topic/Use-AppLocker-and-Software-Restriction-Policies-in-the-Same-Domain.md)  
  
[Manage Packaged Apps with AppLocker](../Topic/Manage-Packaged-Apps-with-AppLocker.md)  
  
[AppLocker Policies Design Guide](../Topic/AppLocker-Policies-Design-Guide.md)  
  
