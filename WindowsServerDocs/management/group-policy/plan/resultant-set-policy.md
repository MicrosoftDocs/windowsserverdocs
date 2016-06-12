---
title: Resultant Set of Policy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 836cc651-9e3d-4e6c-a5ff-f2b6809951d1
---
# Resultant Set of Policy
You can use Resultant Set of Policy \(RSoP\) to simulate and test policy settings that are applied to computers or users using Group Policy.

#### Open RSoP as an mmc snap\-in

1.  Open Microsoft management Console.

2.  On the **File** menu, click **add\/remove Snap\-in**.

3.  In the **Available snap\-ins** box, click **Resultant Set of Policy**, and then click **add**.

4.  Click **OK**.

> [!NOTE]
> You must add a Resultant Set of Policy snap\-in to Microsoft management Console \(mmc\) for each new RSoP query.

## RSoP overview
Resultant Set of Policy \(RSoP\) is an addition to Group Policy to assist in policy implementation and troubleshooting. RSoP is a query engine that polls existing policies and planned policies, and then reports the results of those queries. It polls existing policies based on site, domain, domain controller, and organizational unit. RSoP gathers this information from the Common Information management Object model \(CIMOM\) database \(otherwise known as CIM\-compliant object repository\) through Windows management Instrumentation \(WMI\).

RSoP provides details about all policy settings that are configured by an Administrator, including Administrative Templates, Folder Redirection, Internet Explorer Maintenance, Security Settings, Scripts, and Group Policy Software Installation.

When policies are applied on multiple levels \(for example, site, domain, domain controller, and organizational unit\), the results can conflict. RSoP can help you determine a set of applied policies and their precedence \(the order in which policies are applied\).

RSoP consists of two modes: planning mode and logging mode. With planning mode, you can simulate the effect of policy settings that you want to apply to a computer and user. Logging mode reports the existing policy settings for a computer and user that is currently logged on.

The Resultant Set of Policy Wizard helps you create an RSoP query. You can open the wizard from Microsoft management Console \(mmc\), active directory Users and computers, or active directory Sites and Services. You must run the wizard at least once to create an RSoP query. When complete, the wizard displays the query results in the RSoP snap\-in in mmc. From here, you can save, change, and refresh your queries. You can create many RSoP queries by adding multiple Resultant Set of Policy snap\-ins to mmc, one RSoP snap\-in per query.


