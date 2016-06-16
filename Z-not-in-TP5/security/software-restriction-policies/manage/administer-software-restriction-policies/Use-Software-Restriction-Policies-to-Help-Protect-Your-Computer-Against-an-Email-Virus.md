---
title: Use Software Restriction Policies to Help Protect Your Computer Against an Email Virus
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 02f23979-f832-4e46-bdea-21fd77db35b2
---
# Use Software Restriction Policies to Help Protect Your Computer Against an Email Virus
This topic provides information how to set application control polices using Software Restriction Policies \(SRP\) to help protect your computer against e\-mail virus beginning with Windows Server 2008 and Windows Vista.

## Introduction
Software Restriction Policies \(SRP\) is Group Policy\-based feature that identifies software programs running on computers in a domain, and controls the ability of those programs to run. You use software restriction policies to create a highly restricted configuration for computers, in which you allow only specifically identified applications to run. These are integrated with Microsoft Active Directory Domain Services and Group Policy but can also be configured on stand\-alone computers. For a starting point for SRP, see the [Software Restriction Policies](Software-Restriction-Policies.md).

Beginning with  Windows Server® 2008 R2  and  Windows 7® , Windows AppLocker can be used instead of or in concert with SRP for a portion of your application control strategy. For information about AppLocker in  Windows Server 2012  and Windows 8, see the [AppLocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7).

#### Configure SRP to help protect against an e\-mail virus

1.  Review the best practices for software restriction policies to understand how SRP works.

    -   [Best practices](Software-Restriction-Policies-Technical-Overview.md#BKMK_Best_Practices)

    -   [How Software Restriction Policies Work](http://technet.microsoft.com/library/cc786941(v=WS.10).aspx)

2.  Open Software Restriction Policies.

    -   [For your local computer](Administer-Software-Restriction-Policies.md#BKMK_1)

    -   [For a domain, site, or organizational unit, and you are on a member server or on a workstation that is joined to a domain](Administer-Software-Restriction-Policies.md#BKMK_2)

3.  If you have not previously defined software restriction policies, create new software restriction policies.

    -   [To create new software restriction policies](Administer-Software-Restriction-Policies.md#BKMK_Create_SRP)

4.  Create a path rule for the folder that your e\-mail program uses to run e\-mail attachments, and then set the security level to **Disallowed**.

    -   [Working with path rules](Work-with-Software-Restriction-Policies-Rules.md#BKMK_Path_Rules)

5.  Specify the file types to which the rule applies.

    -   [To add or delete a designated file type](Administer-Software-Restriction-Policies.md#BKMK_Add_Del)

6.  Modify policy settings so that they apply to the users and groups that you want:

    -   Specify users or groups to which you do not want the Group Policy Object's \(GPO\) policy settings to apply.

    -   Exclude local administrators from the software restriction policies of a specific policy setting in Group Policy and still have the rest of Group Policy apply to the administrators.

        -   [To prevent software restriction policies from applying to local administrators](Administer-Software-Restriction-Policies.md#BKMK_Prevent_Admin)

7.  Test the policy.


