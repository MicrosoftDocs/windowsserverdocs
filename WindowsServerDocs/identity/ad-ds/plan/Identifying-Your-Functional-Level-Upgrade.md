---
ms.assetid: 231158d8-5e81-4630-b8d5-93fee16e0cd3
title: Identifying Your Functional Level Upgrade
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Identifying Your Functional Level Upgrade

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Before you can raise domain and forest functional levels, you have to evaluate your current environment and identify the functional level requirement that best meets the needs of your organization. Assess your current environment by identifying the domains in your forest, the domain controllers that are located in each domain, the operating system and service packs that each domain controller is running, and the date that you plan to upgrade the domain controllers. If you plan to retire a domain controller, make sure that you understand the full impact that doing so will have on your environment.  
  
The following circumstances might prevent you from upgrading an earlier version of the Windows Server operating system to the  Windows Server 2008  or  Windows Server 2008 R2  functional level:  
  
-   Insufficient hardware  
  
-   A domain controller running an antivirus program that is incompatible with  Windows Server 2008  or  Windows Server 2008 R2   
  
-   Use of a version-specific program that does not run on  Windows Server 2008  or  Windows Server 2008 R2   
  
-   The need to upgrade a program with the latest service pack  
  
Documenting this information can help you identify the steps to take to ensure that you have a fully functional  Windows Server 2008  or  Windows Server 2008 R2  environment.  
  
After you assess your current environment, you have to identify the functional level upgrade that applies to your organization. These options are available:  
  
-   Windows 2000 native-mode environment to  Windows Server 2008  or  Windows Server 2008 R2   
  
-   Windows Server 2003 forest to  Windows Server 2008  or  Windows Server 2008 R2   
  
-   New  Windows Server 2008  forest  
  
-   New  Windows Server 2008 R2  forest  
  
## Upgrading functional levels in a native Windows 2000 Active Directory forest  
In a Windows 2000 native environment that consists only of Windows 2000-based domain controllers, the functional levels are set by default to the following levels, and they remain at these levels until you raise them manually:  
  
-   Windows 2000 native domain functional level  
  
-   Windows 2000 forest functional level  
  
To use all the forest-level and domain-level features in  Windows Server 2008  or  Windows Server 2008 R2 , you have to upgrade this Windows 2000 environment to  Windows Server 2008  or  Windows Server 2008 R2 . You can perform this upgrade in either of the following ways:  
  
-   Introduce newly installed  Windows Server 2008 -based or  Windows Server 2008 R2 -based domain controllers into the forest, and then retire all domain controllers running Windows 2000.  
  
-   Perform an in-place upgrade of all existing domain controllers running Windows 2000 in the forest to domain controllers running Windows Server 2003. Then, perform an in-place upgrade of those domain controllers to  Windows Server 2008  or  Windows Server 2008 R2 . For more information, see [Upgrading Active Directory Domains to Windows Server 2008 AD DS Domains \[LH\]](assetId:///9c91be5f-df14-40b2-b176-2b1852a51e61).  
  
    > [!IMPORTANT]  
    >  Windows Server 2008 R2  is an x64-based operating system. If your server is running an x64-based version of Windows Server 2003, you can successfully perform an in-place upgrade of this computer's operating system to  Windows Server 2008 R2 . If your server is running an x86-based version of Windows Server 2003, you cannot upgrade this computer to  Windows Server 2008 R2 .  
  
To use the  Windows Server 2008  or  Windows Server 2008 R2  domain-level features without upgrading your entire Windows 2000 forest to  Windows Server 2008  or  Windows Server 2008 R2 , raise only the domain functional level to  Windows Server 2008  or  Windows Server 2008 R2 .  
  
> [!NOTE]  
> Before you raise the domain functional level, you must upgrade all Windows 2000-based domain controllers in that domain to  Windows Server 2008  or  Windows Server 2008 R2 .  
  
After you replace all the Windows 2000-based domain controllers in the forest with domain controllers that run  Windows Server 2008  or  Windows Server 2008 R2 , you can raise the forest functional level to  Windows Server 2008  or  Windows Server 2008 R2 . Doing so automatically raises the functional level of all domains in the forest that are set to Windows 2000 native or higher to  Windows Server 2008  or  Windows Server 2008 R2 .  
  
For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain \[LH\]](assetId:///92406e8d-dc1c-4740-a00a-2c4032896dd1).  
  
## Upgrading functional levels in a Windows Server 2003 Active Directory forest  
In a Windows Server 2003 environment that consists of only Windows Server 2003-based domain controllers, the functional levels are set by default to the following levels, and they remain at these levels until you raise them manually:  
  
-   Windows 2000 native domain functional level  
  
-   Windows 2000 forest functional level  
  
To use all the forest-level and domain-level features in  Windows Server 2008  or  Windows Server 2008 R2 , you have to upgrade this Windows Server 2003 environment to  Windows Server 2008  or  Windows Server 2008 R2 . You can perform this upgrade in either of the following ways:  
  
-   Introduce a newly installed  Windows Server 2008 -based or  Windows Server 2008 R2 -based domain controller into the forest, and then retire all domain controllers running Windows Server 2003 or upgrade them to  Windows Server 2008  or  Windows Server 2008 R2 .  
  
-   Perform an in-place upgrade of all existing domain controllers running Windows Server 2003 to domain controllers running  Windows Server 2008  or  Windows Server 2008 R2 . For more information, see [Upgrading Active Directory Domains to Windows Server 2008 AD DS Domains \[LH\]](assetId:///9c91be5f-df14-40b2-b176-2b1852a51e61).  
  
> [!IMPORTANT]  
>  Windows Server 2008 R2  is an x64-based operating system. If your server is running an x64-based version of Windows Server 2003, you can successfully perform an in-place upgrade of this computer's operating system to  Windows Server 2008 R2 . If your server is running an x86-based version of Windows Server 2003, you cannot upgrade this computer to run  Windows Server 2008 R2 .  
  
To use all the  Windows Server 2008  or  Windows Server 2008 R2  domain-level features without upgrading your entire Windows Server 2003 forest to  Windows Server 2008  or  Windows Server 2008 R2 , raise only the domain functional level to  Windows Server 2008  or  Windows Server 2008 R2 .  
  
> [!NOTE]  
> Before you raise the domain functional level, you must upgrade all Windows Server 2003-based domain controllers in that domain to  Windows Server 2008  or  Windows Server 2008 R2 .  
  
After you upgrade all the Windows Server 2003-based domain controllers in the forest to  Windows Server 2008  or  Windows Server 2008 R2 , you can raise the forest functional level to  Windows Server 2008  or  Windows Server 2008 R2 . Doing so automatically raises the functional level of all domains in the forest that are set to Windows Server 2003 to  Windows Server 2008  or  Windows Server 2008 R2 .  
  
For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain \[LH\]](assetId:///92406e8d-dc1c-4740-a00a-2c4032896dd1).  
  
## Upgrading functional levels in a new Windows Server 2008 forest  
When you install the first domain controller in a new  Windows Server 2008  forest, functional levels are set by default to the following levels, and they remain at these levels until you raise them manually:  
  
-   Windows 2000 native domain functional level  
  
-   Windows 2000 forest functional level  
  
Functional levels are set at these default levels to give you the option of adding Windows 2000 or Windows Server 2003-based domain controllers to your new  Windows Server 2008  forest. After you create a forest root domain, the domain functional level for each domain that you add to the  Windows Server 2008  forest is set to Windows 2000 native. However, if you want all domain controllers in your new  Windows Server 2008  environment to run  Windows Server 2008 , set the forest functional level, and then the domain functional level, to  Windows Server 2008  when you install the first domain controller in your forest. Doing this saves time and enables all the forest-level and domain-level features in  Windows Server 2008 .  
  
> [!IMPORTANT]  
> If the forest operates at the  Windows Server 2008  functional level and you attempt to install Active Directory on a Windows Server 2003-based member server or a Windows 2000-based member server, the installation fails.  
  
For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain \[LH\]](assetId:///92406e8d-dc1c-4740-a00a-2c4032896dd1).  
  
## Upgrading functional levels in a new Windows Server 2008 R2 forest  
When you install the first domain controller in a new  Windows Server 2008 R2  forest, functional levels are set by default to the following levels, and they remain at these levels until you raise them manually:  
  
-   Windows Server 2003 domain functional level  
  
-   Windows Server 2003 forest functional level  
  
Functional levels are set at these default levels to give you the option of adding Windows Server 2003-based domain controllers to your new  Windows Server 2008 R2  forest. After you create a forest root domain, the domain functional level for each domain that you add to the  Windows Server 2008 R2  forest is set to Windows Server 2003. However, if you want all domain controllers in your new  Windows Server 2008 R2  environment to run  Windows Server 2008 R2 , set the forest functional level, and then the domain functional level, to  Windows Server 2008 R2  when you install the first domain controller in your forest. Doing this saves time and enables all forest-level and domain-level features in  Windows Server 2008 R2 .  
  
> [!IMPORTANT]  
> If the forest operates at the  Windows Server 2008 R2  functional level and you attempt to install Active Directory on a  Windows Server 2008 -based or Windows Server 2003-based member server, or on a Windows 2000-based member server, the installation fails.  
  
For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain \[LH\]](assetId:///92406e8d-dc1c-4740-a00a-2c4032896dd1).  
  
> [!NOTE]  
> Although ADMT v3.1 must be installed on Windows Server 2008, you can use ADMT v3.1 to migrate objects to a domain that is hosted by one or more  Windows Server 2008 R2  domain controllers. For more information, see [article 976659](https://go.microsoft.com/fwlink/?LinkId=180398) in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkId=180398).  
  


