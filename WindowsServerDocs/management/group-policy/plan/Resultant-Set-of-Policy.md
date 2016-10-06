---
title: Resultant Set of Policy
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 836cc651-9e3d-4e6c-a5ff-f2b6809951d1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Resultant Set of Policy

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

You can use Resultant Set of Policy (RSoP) to simulate and test policy settings that are applied to computers or users using Group Policy.

#### Open RSoP as an MMC snap-in

1.  Open Microsoft Management Console.

2.  On the **File** menu, click **Add/Remove Snap-in**.

3.  In the **Available snap-ins** box, click **Resultant Set of Policy**, and then click **Add**.

4.  Click **OK**.

> [!NOTE]
> You must add a Resultant Set of Policy snap-in to Microsoft Management Console (MMC) for each new RSoP query.

## RSoP overview
Resultant Set of Policy (RSoP) is an addition to Group Policy to assist in policy implementation and troubleshooting. RSoP is a query engine that polls existing policies and planned policies, and then reports the results of those queries. It polls existing policies based on site, domain, domain controller, and organizational unit. RSoP gathers this information from the Common Information Management Object Model (CIMOM) database (otherwise known as CIM-compliant object repository) through Windows Management Instrumentation (WMI).

RSoP provides details about all policy settings that are configured by an Administrator, including Administrative Templates, Folder Redirection, Internet Explorer Maintenance, Security Settings, Scripts, and Group Policy Software Installation.

When policies are applied on multiple levels (for example, site, domain, domain controller, and organizational unit), the results can conflict. RSoP can help you determine a set of applied policies and their precedence (the order in which policies are applied).

RSoP consists of two modes: planning mode and logging mode. With planning mode, you can simulate the effect of policy settings that you want to apply to a computer and user. Logging mode reports the existing policy settings for a computer and user that is currently logged on.

The Resultant Set of Policy Wizard helps you create an RSoP query. You can open the wizard from Microsoft Management Console (MMC), Active Directory Users and Computers, or Active Directory Sites and Services. You must run the wizard at least once to create an RSoP query. When complete, the wizard displays the query results in the RSoP snap-in in MMC. From here, you can save, change, and refresh your queries. You can create many RSoP queries by adding multiple Resultant Set of Policy snap-ins to MMC, one RSoP snap-in per query.


