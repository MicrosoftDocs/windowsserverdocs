---
title: Determine Allow-Deny List and Application Inventory for Software Restriction Policies
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-software-restriction-policies
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0abb73b6-b5d8-4505-8ab1-2f29e4bf0411
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Determine Allow-Deny List and Application Inventory for Software Restriction Policies

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic for the IT professional gives guidance how to create an allow and deny list for applications to be managed by Software Restriction Policies (SRP) beginning with Windows Server 2008 and Windows Vista.

## Introduction
Software Restriction Policies (SRP) is Group Policy-based feature that identifies software programs running on computers in a domain, and controls the ability of those programs to run. You use software restriction policies to create a highly restricted configuration for computers, in which you allow only specifically identified applications to run. These are integrated with Microsoft Active Directory Domain Services and Group Policy but can also be configured on stand-alone computers. For a starting point for SRP, see the [Software Restriction Policies](software-restriction-policies.md).

Beginning with  Windows Server 2008 R2  and  Windows 7 , Windows AppLocker can be used instead of or in concert with SRP for a portion of your application control strategy.

For information about how to accomplish specific tasks using SRP, see the following:

-   [Work with Software Restriction Policies Rules](work-with-software-restriction-policies-rules.md)

-   [Use Software Restriction Policies to Help Protect Your Computer Against an Email Virus](use-software-restriction-policies-to-help-protect-your-computer-against-an-email-virus.md)

### What default rule to choose: Allow or Deny
Software restriction policies can be deployed in one of two modes that are the basis of your default rule: Allow List or Deny List. You can create a policy that identifies every application that is allowed to run in your environment; the default rule within your policy is Restricted and will block all applications that you do not explicitly allow to run. Or you can create a policy that identifies every application that cannot run; the default rule is Unrestricted and restricts only the applications that you have explicitly listed.

> [!IMPORTANT]
> The Deny List mode might be a high-maintenance strategy for your organization regarding application control. Creating and maintaining an evolving list that prohibits all malware and other problematic applications would be time consuming and susceptible to mistakes.

### Create an inventory of your applications for the Allow list
To effectively use the Allow default rule, you need to determine exactly which applications are required in your organization. There are tools designed to produce an application inventory, such as the Inventory Collector in the Microsoft Application Compatibility Toolkit. But SRP has an advanced logging feature to help you understand exactly what applications are running in your environment.

##### To discover which applications to allow

1.  In a test environment, deploy Software Restriction Policy with the default rule set to Unrestricted and remove any additional rules. If you enable SRP without forcing it to restrict any applications, SPR will be able to monitor what applications are being run.

2.  Create the following registry value in order to enable the advanced logging feature and set the path to where the log file should be written.

    **"HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\ CodeIdentifiers"**

    String Value: *NameLogFile path to NameLogFile*

    Because SRP is evaluating all applications when they run, an entry is written to the log file *NameLogFile* each time that application is run.

3.  Evaluate the log file

    Each log entry states:

    -   the caller of the software restriction policy and the process ID (PID) of the calling process

    -   the target being evaluated

    -   the SRP rule that was encountered when that application ran

    -   an identifier for the SRP rule.

    An example of the output written to a log file:

**explorer.exe (PID = 4728) identifiedC:\Windows\system32\onenote.exe as Unrestricted usingpath rule, Guid ={320bd852-aa7c-4674-82c5-9a80321670a3}**    All applications and associated code that SRP checks and set to block will be noted in the log file, which you then can use to determine which executables should be considered for your Allowed list.


