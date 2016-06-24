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

-   For Group Policy deployment, at least one computer with the Group Policy Management Console (GPMC) or Remote Server Administration Tools (RSAT) installed to host the AppLocker rules.

-   Computers running a supported operating system to enforce the AppLocker rules that you create.

> [!NOTE]
> You can use Software Restriction Policies with AppLocker, but with some limitations. For more information, see [Use AppLocker and Software Restriction Policies in the Same Domain](Use-AppLocker-and-Software-Restriction-Policies-in-the-Same-Domain.md).

## Operating system requirements
The following table show the on which operating systems AppLocker features are supported.

|Version|Can be configured|Can be enforced|Available rules|Notes|
|-----------|---------------------|-------------------|-------------------|---------|
| Windows Server 2012 R2 |Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL||
|Windows 8.1|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL|Only the Enterprise edition supports AppLocker|
|Windows RT 8.1|No|No|NA||
|Windows Server 2012 Standard|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL||
|Windows Server 2012 Datacenter|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL||
|Windows 8 Pro|No|No|NA||
|Windows 8 Enterprise|Yes|Yes|Packaged apps<br />Executable<br />Windows Installer<br />Script<br />DLL||
|Windows RT|No|No|NA||
| Windows Server 2008 R2 Standard |Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|
| Windows Server 2008 R2 Enterprise |Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|
| Windows Server 2008 R2 Datacenter |Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|
| Windows Server 2008 R2 for Itanium-Based Systems |Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|
|Windows 7 Ultimate|Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|
|Windows 7 Enterprise|Yes|Yes|Executable<br />Windows Installer<br />Script<br />DLL|Packaged app rules will not be enforced.|
|Windows 7 Professional|Yes|No|Executable<br />Windows Installer<br />Script<br />DLL|No AppLocker rules are enforced.|

AppLocker is not supported on versions of the Windows operating system not listed above. Software Restriction Policies can be used with those versions. However, the SRP Basic User feature is not supported on the above operating systems.

## See also
[Administer AppLocker](Administer-AppLocker.md)

[Monitor Application Usage with AppLocker](Monitor-Application-Usage-with-AppLocker.md)

[Optimize AppLocker Performance](Optimize-AppLocker-Performance.md)

[Use AppLocker and Software Restriction Policies in the Same Domain](Use-AppLocker-and-Software-Restriction-Policies-in-the-Same-Domain.md)

[Manage Packaged Apps with AppLocker](Manage-Packaged-Apps-with-AppLocker.md)

[AppLocker Policies Design Guide](AppLocker-Policies-Design-Guide.md)


