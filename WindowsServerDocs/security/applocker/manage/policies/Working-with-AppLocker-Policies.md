---
title: Working with AppLocker Policies
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d5d2dede-00f6-43d0-b320-ca2139d6fd41
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Working with AppLocker Policies

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic provides links to procedural topics about creating, maintaining, and testing AppLocker policies.

-   [Configure the Application Identity Service](Configure-the-Application-Identity-Service.md)

-   [Configure an AppLocker Policy for Audit Only](Configure-an-AppLocker-Policy-for-Audit-Only.md)

-   [Configure an AppLocker Policy for Enforce Rules](Configure-an-AppLocker-Policy-for-Enforce-Rules.md)

-   [Display a Custom URL Message When Users Try to Run a Blocked Application](Display-a-Custom-URL-Message-When-Users-Try-to-Run-a-Blocked-Application.md)

-   [Export an AppLocker Policy from a GPO](Export-an-AppLocker-Policy-from-a-GPO.md)

-   [Export an AppLocker Policy to an XML File](Export-an-AppLocker-Policy-to-an-XML-File.md)

-   [Import an AppLocker Policy from Another Computer](Import-an-AppLocker-Policy-from-Another-Computer.md)

-   [Import an AppLocker Policy into a GPO](Import-an-AppLocker-Policy-into-a-GPO.md)

-   [Add Rules for Packaged Apps to Existing AppLocker Rule-set](Add-Rules-for-Packaged-Apps-to-Existing-AppLocker-Rule-set.md)

-   [Merge AppLocker Policies by Using Set-ApplockerPolicy](Merge-AppLocker-Policies-by-Using-Set-ApplockerPolicy.md)

-   [Merge AppLocker Policies Manually](Merge-AppLocker-Policies-Manually.md)

-   [Refresh an AppLocker Policy](Refresh-an-AppLocker-Policy.md)

-   [Test an AppLocker Policy by Using Test-AppLockerPolicy](Test-an-AppLocker-Policy-by-Using-Test-AppLockerPolicy.md)

## What does AppLocker do?
AppLocker helps reduce administrative overhead and helps reduce the organization's cost of managing computing resources by decreasing the number of help desk calls that result from users running unapproved applications. AppLocker addresses the following application security scenarios:

-   Application inventory

    AppLocker has the ability to enforce its policy in an audit-only mode where all application access activity is registered in event logs. These events can be collected for further analysis. Windows PowerShell cmdlets also help you analyze this data programmatically.

-   Protection against unwanted software

    AppLocker has the ability to deny applications from running when you exclude them from the list of allowed applications.  Once AppLocker rules are enforced in the production environment any application that is not covered by the allow rules is blocked from executing.

-   Licensing conformance

    AppLocker can help you create rules that preclude unlicensed software from running and restricting licensed software to authorized users.

-   Software standardization

    AppLocker policies can be configured to allow only supported or approved applications to run on computers within a business group. This permits a more uniform application deployment.

-   Manageability improvement

    AppLocker includes a number of improvements in manageability as compared to its predecessor Software Restriction Policies (SRP). Importing and exporting policies, automatic generation of rules from multiple files, audit-only mode deployment and PowerShell cmdlets are a few of the improvements over SRP.


For information about Software Restriction Policies and AppLocker policies, see [Use AppLocker and Software Restriction Policies in the Same Domain](../Use-AppLocker-and-Software-Restriction-Policies-in-the-Same-Domain.md).


