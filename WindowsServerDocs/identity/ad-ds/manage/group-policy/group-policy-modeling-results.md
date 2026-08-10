---
title: Group Policy Modeling and Results in Windows
description: Learn how to model group policy results and evaluate group policy settings using the Group Policy Management Console in Windows Server.
author: Orin-Thomas
ms.topic: how-to
ms.author: orthomas
contributor: orthomas
ms.date: 04/16/2024
---

# Group Policy Modeling and Group Policy Results

In Active Directory Domain Services environments, use Group Policy Modeling in the Group Policy Management Console (GPMC) to simulate the deployment of Group Policy Objects (GPOs) to any destination computer. The primary tool for viewing the actual application of GPOs is by using Group Policy Results in the GPMC.

## Prerequisites

To use the GPMC and perform Group Policy modeling, you must complete the following prerequisites.

- Have the Group Policy Management feature installed on a computer running Windows Server or a Windows client operating system.
- Have the _read_ security permissions on the directory and GPOs.
- To link GPOs, you need the _modify_ permission on that site, domain, or OU. By default, only Domain Administrators and Enterprise Administrators have this permission.
  - Users and groups with permission to link GPOs to a specific site, domain, or OU can link GPOs, change link order, and set block inheritance on that site, domain, or OU.

## Group Policy Modeling

The Group Policy Modeling Wizard in the GPMC calculates the simulated net effect of GPOs. Group Policy Modeling can also simulate such factors as security group membership, Windows Management Instrumentation (WMI) filter evaluation, and the effects of moving user or computer objects to a different Active Directory container. A service that runs on the domain controller performs the simulation. These calculated policy settings are reported in HTML and displayed in the GPMC on the Settings tab in the details pane for the selected query. To expand and hide the policy settings under each item, select **Hide** or **Show all** so that you can view all the policy settings, or only a few. To perform Group Policy Modeling, you must have the _Perform Group Policy Modeling analyses_ permission on the domain or OU that contains the objects on which you want to run the query.

To simulate a policy deployment for planning and testing, follow the steps.

1. To open the GPMC, select **Start**, enter **Group Policy Management** in the search box, and then select **Group Policy Management**.

1. In the GPMC console tree, right-click **Group Policy Modeling**, select **Group Policy Modeling Wizard**.

1. Select **Next** to get started.

1. Select the domain you want to model, then select one of the following:

   | Option | Description |
   |-|-|
   | Any available domain controller running Windows 2003 or later | The nearest domain controller processes the simulation. |
   | This domain controller | Specifies the domain controller to process the simulation. |

   Once you've selected one of the radio buttons, select **Next**.

1. Select either the container users are located in or specify a specific user using the distinguished name (DN) of the user. You can select **Browse** to search for a container or user instead of entering the DN. Repeat this step for the computer container or specific computer, then select **Next**.

1. Select **Next** or optionally, complete the following information to simulate policy settings for:

   | Option | Description |
   |-|-|
   | Slow network connection (for example, a dial-up connection) | The response to a slow policy connection varies among policies. The policy can specify the response to a slow link. For example, you can specify if script processing is allowed across a slow network connection. |
   | Loopback processing | Select **Replace** or **Merge**. To learn about the loopback processing mode, see [Group Policy Processing](group-policy-processing.md). |
   | Site | Select the Active Directory site to simulate the policy settings for. |

   Once you've selected one of the radio buttons, select **Next**.

1. Select **Next** or optionally, select **Add** or **Remove** to simulate the effect of changes to a user's group membership. Once you've confirmed the groups to simulate, select **Next**.

1. Select **Next** or optionally, select **Add** or **Remove** to simulate the effect of changes to a computers's group membership. Once you've confirmed the groups to simulate, select **Next**.

1. Select **Next** or optionally, to simulate the effect of changes to the WMI filters applied to users, complete the following information:

   | Option | Description |
   |-|-|
   | All linked filters | Uses the filters currently applied to any of the linked policies. |
   | Only these filters | Select **List Filters** to show the currently applied to any of the lined policies. To remove specific filters, selecting the filter, then select **Remove**. |

   Once you've confirmed the groups to simulate, select **Next**.

1. Review the **Summary of Selections** screen, then select **Next** to run the simulation.

1. Select **Finish** to complete the wizard.

After you complete the wizard, the results are displayed as if they were from a single GPO. They're also saved as a query that is represented as a new item in the GPMC, in Group Policy Modeling. Under the heading Winning GPO, the display also shows which GPO is responsible for each policy setting. You can also view more detailed precedence information (for example, which GPOs attempted to set the policy settings, but didn't succeed) by right-clicking the query item and then selecting **Advanced View**. The Advance View opens Resultant Set of Policy snap-in opens. Each policy setting has a Precedence tab when viewing the properties for policy settings in Resultant Set of Policy.

Keep in mind that Group Policy Modeling doesn't include evaluating any local GPOs. Therefore, in some cases you might see a difference between the simulation and the actual results. You can save modeling results by right-clicking the query, and then select **Save Report**.

## Group Policy Results

Use the Group Policy Results Wizard to determine which Group Policy settings are in effect for a user or computer by obtaining RSoP data from the destination computer. In contrast to Group Policy Modeling, Group Policy Results reveals the actual Group Policy settings that were applied to the destination computer.

The policy settings are reported in HTML. The report is displayed in the GPMC browser window on the Summary and Settings tabs in the details pane for the selected query. You can expand and contract the policy settings under each item by clicking Hide or Show all so that you can see all the policy settings, or only a few. To remotely access Group Policy Results data for a user or computer, you must have the _Remotely access Group Policy Results data_ security permission on the domain or OU that contains the user or computer. To configure the permissions, first select the domain, container, OU, then select the **Delegation** tab. From the **Delegation** tab, select **Remotely access Group Policy Results data** from the dropdown menu. Alternatively, you must be a member of a local Administrators group on the appropriate computer and must have network connectivity to the destination computer.

To run the Group Policy Results Wizard, follow these steps.

1. Right-clicking the Group Policy Results item, then selecting **Group Policy Results Wizard**.

1. Select **Next** to get started.
1. Select **This computer** then select **Next**. Optionally, you can select **Another computer** and enter the computer name, then select **Next**.
1. Select **Current user** then select **Next**. Optionally, you can select **Select a specific user** and select the user name from the list of users that have logged on to the computer. Select **Next** to continue.
1. Review the **Summary of Selections** screen, then select **Next** to run the Group Policy results.
1. Select **Finish** to complete the wizard.

GPMC creates a report that displays the RSoP data for the user and computer that you specified in the wizard. Under the heading Winning GPO, the display shows which GPO is responsible for each policy setting on the Settings tab.

You can save the results by right-clicking the query and then selecting **Save Report**.

## Evaluate policy settings from the command line

You can run `gpresult.exe` on the local computer to obtain the same data that you can obtain by using Group Policy Results Wizard in the GPMC. By default, `gpresult.exe` returns policy settings in effect on the computer on which it runs. `gpresult.exe` outputs its results in an HTML file that you can open with Microsoft Edge or another web browser.
