---
title: Working with applocker Policies
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d5d2dede-00f6-43d0-b320-ca2139d6fd41
---
# Working with applocker Policies
This topic provides links to procedural topics about creating, maintaining, and testing applocker policies in Windows Server® 2012 and Windows® 8.

-   [Configure the Application Identity Service]()

-   [Configure an applocker Policy for Audit Only]()

-   [Configure an applocker Policy for Enforce Rules]()

-   [Display a Custom URL Message When Users Try to Run a Blocked Application]()

-   [Export an applocker Policy from a GPO]()

-   [Export an applocker Policy to an XML File]()

-   [Import an applocker Policy from Another Computer]()

-   [Import an applocker Policy into a GPO]()

-   [Add Rules for Packaged Apps to Existing applocker Rule-set]()

-   [Merge applocker Policies by Using Set-applockerPolicy]()

-   [Merge applocker Policies Manually]()

-   [Refresh an applocker Policy]()

-   [Test an applocker Policy by Using Test-applockerPolicy]()

## What does applocker do?
applocker helps reduce administrative overhead and helps reduce the organization's cost of managing computing resources by decreasing the number of help desk calls that result from users running unapproved applications. applocker addresses the following application security scenarios:

-   Application inventory

    applocker has the ability to enforce its policy in an audit\-only mode where all application access activity is registered in event logs. These events can be collected for further analysis. Windows PowerShell cmdlets also help you analyze this data programmatically.

-   Protection against unwanted software

    applocker has the ability to deny applications from running when you exclude them from the list of allowed applications.  Once applocker rules are enforced in the production environment any application that is not covered by the allow rules is blocked from executing.

-   Licensing conformance

    applocker can help you create rules that preclude unlicensed software from running and restricting licensed software to authorized users.

-   Software standardization

    applocker policies can be configured to allow only supported or approved applications to run on computers within a business group. This permits a more uniform application deployment.

-   Manageability improvement

    applocker includes a number of improvements in manageability as compared to its predecessor Software Restriction Policies \(SRP\). Importing and exporting policies, automatic generation of rules from multiple files, audit\-only mode deployment and PowerShell cmdlets are a few of the improvements over SRP.

For more information about how applocker policies work, see the [applocker Technical Overview](assetId:///358610e4-88b2-40d0-b34d-dfd7ddee0ed9).

For information about Software Restriction Policies and applocker policies, see [Use applocker and Software Restriction Policies in the Same Domain](use-applocker-software-restriction-policies-same-domain.md).

## See Also
[applocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)


