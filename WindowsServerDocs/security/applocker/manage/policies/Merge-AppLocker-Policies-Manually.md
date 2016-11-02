---
title: Merge applocker Policies Manually
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b8774c2e-5040-4362-8254-b9ed86f75e0a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Merge applocker Policies Manually

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This procedural topic describes the steps to manually merge applocker policies to update the Group Policy Object (GPO) in  Windows Server 2012  and Windows 8.

If you have created multiple applocker policies and need to merge them to create one applocker policy, you can either manually merge the policies or use the Windows PowerShell cmdlets for applocker. You cannot automatically merge policies by using the applocker snap-in. You must create one rule collection from two or more policies. For information about merging policies by using the cmdlet, see [Merge applocker Policies by Using Set-applockerPolicy](merge-applocker-policies-by-using-set-applockerpolicy.md).

The applocker policy is saved in XML format, and the exported policy can be edited with any text or XML editor. Rule collections are specified within the **RuleCollection Type** element. The XML schema includes five attributes for the different rule collections, as shown in the following table.

|Rule collection|RuleCollection Type element|
|----------|----------------|
|Executable rules|Exe|
|Windows Installer rules|.msi file|
|Script rules|Script|
|DLL rules|Dll|
|Packaged apps and packaged app installers|Appx|

Rule enforcement is specified with the **EnforcementMode** element. The three enforcement modes in the XML correspond to the three enforcement modes in the applocker snap-in, as shown in the following table.

|XML enforcement mode|Enforcement mode in Group Policy|
|------------|------------------|
|NotConfigured|Not configured (rules are enforced)|
|AuditOnly|Audit only|
|Enabled|Enforce rules|

Each of the three condition types use specific elements. For XML examples of the different rule types, see [Merge applocker Policies Manually](http://technet.microsoft.com/library/ee791754(v=ws.10).aspx) in the Windows Server 2008 R2 Technical Library.

Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.

#### To merge two or more applocker policies

1.  Open an XML policy file in a text editor or XML editor, such as Notepad.

2.  Select the rule collection where you want to copy rules from.

3.  Select the rules that you want to add to another policy file, and then copy the text.

4.  Open the policy where you want to add the copied rules.

5.  Select and expand the rule collection where you want to add the rules.

6.  At the bottom of the rule list for the collection, after the closing element, paste the rules that you copied from the first policy file. Verify that the opening and closing elements are intact, and then save the policy.

7.  Upload the policy to a reference computer to ensure that it is functioning properly within the GPO.


