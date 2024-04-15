---
title: Group Policy Modeling and Results in Windows
description: Use this article to understand how to model group policy results and evaluate group policy settings.
author: Orin-Thomas
ms.topic: conceptual
ms.author: orthomas
contributor: orthomas
ms.date: 02/18/2024
---

# Group Policy Modeling and Group Policy Results

In Active Directory Domain Services environments, use Group Policy Modeling in the Group Policy Management Console (GPMC) to simulate the deployment of Group Policy Objects (GPOs) to any destination computer. The primary tool for viewing the actual application of GPOs is by using Group Policy Results in the GPMC.

## Group Policy Modeling

The Group Policy Modeling Wizard in the GPMC calculates the simulated net effect of GPOs. Group Policy Modeling can also simulate such factors as security group membership, Windows Management Instrumentation (WMI) filter evaluation, and the effects of moving user or computer objects to a different Active Directory container. A service that runs on domain controllers performs the simulation. These calculated policy settings are reported in HTML and displayed in the GPMC on the Settings tab in the details pane for the selected query. To expand and hide the policy settings under each item, select **Hide** or **Show all** so that you can view all the policy settings, or only a few. To perform Group Policy Modeling, you must have the _Perform Group Policy Modeling analyses_ permission on the domain or OU that contains the objects on which you want to run the query.

To run the wizard, in the GPMC console tree, right-click Group Policy Modeling (or an Active Directory container), and then select **Group Policy Modeling Wizard**. If you run the wizard from an Active Directory container, the wizard completes the Container fields for the user and computer with the Lightweight Directory Access Protocol (LDAP) distinguished name of that container.

After you complete the wizard, the results are displayed as if they were from a single GPO. They're also saved as a query that is represented as a new item in the GPMC, in Group Policy Modeling. Under the heading Winning GPO, the display also shows which GPO is responsible for each policy setting. You can also view more detailed precedence information (for example, which GPOs attempted to set the policy settings, but didn't succeed) by right-clicking the query item and then selecting **Advanced View**. The Advance View opens Resultant Set of Policy snap-in opens. Each policy setting has a Precedence tab when viewing the properties for policy settings in Resultant Set of Policy.

Keep in mind that Group Policy Modeling doesn't include evaluating any local GPOs. Therefore, in some cases you might see a difference between the simulation and the actual results. You can save modeling results by right-clicking the query, and then select **Save Report**.

## Group Policy Results

Use the Group Policy Results Wizard to determine which Group Policy settings are in effect for a user or computer by obtaining RSoP data from the destination computer. In contrast to Group Policy Modeling, Group Policy Results reveals the actual Group Policy settings that were applied to the destination computer.

The policy settings are reported in HTML. The report is displayed in the GPMC browser window on the Summary and Settings tabs in the details pane for the selected query. You can expand and contract the policy settings under each item by clicking Hide or Show all so that you can see all the policy settings, or only a few. To remotely access Group Policy Results data for a user or computer, you must have the _Remotely access Group Policy Results data_ permission on the domain or OU that contains the user or computer. Alternatively, you must be a member of a local Administrators group on the appropriate computer and must have network connectivity to the destination computer.

You can run the wizard by right-clicking the Group Policy Results item, and then selecting **Group Policy Results Wizard**.

GPMC creates a report that displays the RSoP data for the user and computer that you specified in the wizard. Under the heading Winning GPO, the display shows which GPO is responsible for each policy setting on the Settings tab.

You can save the results by right-clicking the query and then selecting **Save Report**.

## Using gpresult to evaluate policy settings

You can run `gpresult.exe` on the local computer to obtain the same data that you can obtain by using Group Policy Results Wizard in the GPMC. By default, `gpresult.exe` returns policy settings in effect on the computer on which it runs. `gpresult.exe` outputs its results in an HTML file that you can open with Microsoft Edge or another web browser.
