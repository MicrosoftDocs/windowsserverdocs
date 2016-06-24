---
title: Use Resultant Set of Policy to Manage Group Policy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16fe9efd-ccef-4c46-a688-e10e3248eab0
---
# Use Resultant Set of Policy to Manage Group Policy
This topic describes how Resultant Set of Policy (RSoP) is used by Group Policy Management Console (GPMC) and describes the procedures to use.

## Introduction
Resultant Set of Policy (RSoP) is an addition to Group Policy to assist in policy implementation and troubleshooting. RSoP is a query engine that polls existing policies and planned policies, and then reports the results of those queries. It polls existing policies based on site, domain, domain controller, and organizational unit. RSoP gathers this information from the Common Information Management Object Model (CIMOM) database (otherwise known as CIM-compliant object repository) through Windows Management Instrumentation (WMI).

RSoP provides details about all policy settings that are configured by an Administrator, including Administrative Templates, Folder Redirection, Internet Explorer Maintenance, Security Settings, Scripts, and Group Policy Software Installation.

When policies are applied on multiple levels (for example, site, domain, domain controller, and organizational unit), the results can conflict. RSoP can help you determine a set of applied policies and their precedence (the order in which policies are applied).

## How to determine the resultant set of policy
Group Policy Resultant Set of Policy (RSoP) reports Group Policy settings that are applied to a user or computer. Group Policy Results in Group Policy Management Console (GPMC) requests RSoP data from a target computer and presents this in a report in HTML format. Group Policy Modeling requests the same type of information, but the data reported is from a service that simulates RSoP for a combination of computer and user. Finally, the RSoP Microsoft Management Console (MMC) provides an alternative way to display this information, although Group Policy Results is generally the preferred method.

#### To determine Resultant Set of Policy for a forest

1.  In the Group Policy Management Console (GPMC) console tree, double-click the forest in which you want to create a Group Policy Results query, right-click **Group Policy Results**, and then click **Group Policy Results Wizard**.

2.  In the **Group Policy Results Wizard**, click **Next** and enter the appropriate information.

3.  After you complete the wizard, click **Finish**.

4.  If you want to print or save the report, right-click the settings report in the details pane and do one of the following:

    -   Select **Print** to print the report.

    -   Select **Save Report** to save the report.

### Additional considerations

-   To access Group Policy Results data for a user or computer, you must have **Read** Group Policy Results Data permission on the domain or organizational unit that contains the user or computer, or you must be a member of a local administrator's group on the targeted computer.

-   If you run Group Policy Results on a computer that does not support Group Policy Preferences and you select a destination computer that does support Group Policy Preferences, the Group Policy Preferences settings of the destination computer will not appear in the report results.

-   To customize the information displayed in a report, click **Show** or **Hide** to display only the data you want to view or print.

-   Within the GPMC, you cannot use the keyboard to navigate inside an HTML report. To browse inside the HTML report, save the report to a file and then use Internet Explorer to view the report.

-   If you open a previously saved console and want to save a Group Policy Modeling or Group Policy Results report in XML, rerun the report by using the **Rerun Query** option.

##### To determine computer policy information

1.  Open the RSoP snap-in (rsop.msc).

2.  Click **Generate RSOP data** on the **Action** menu.

3.  Click **Next**, click **Logging Mode**, and then click **Next**.

4.  Click either **This Computer** or **Another Computer**, and then type the computer name.

5.  Click **Select a specific user**, and then click the blank space that is below the listed users. This has the same effect as clicking **Do not display user policy settings in the results**.

6.  Click **Next**, and then click **Next**. Note that only computer-specific settings are displayed.

## How to simulate RSoP using Group Policy Modeling
You can use a Group Policy management feature that allows you to simulate a policy deployment that would be applied to users and computers before actually applying the policies. This feature, known as Resultant Set of Policy (RSoP) – Planning Mode, is integrated into GPMC as Group Policy Modeling.

#### To simulate Resultant Set of Policy using Group Policy Modeling

1.  Open the Group Policy Management Console (GPMC). In the console tree, double-click the forest in which you want to create a Group Policy Modeling query, right-click **Group Policy Modeling**, and then click **Group Policy Modeling Wizard**.

2.  In the **Group Policy Modeling Wizard**, click **Next**, and then type the appropriate information.

3.  When you are finished, click **Finish**.

4.  If you want to print or save the report, right-click the settings report in the details pane and do one of the following:

    -   Select **Print** to print the report.

    -   Select **Save Report** to save the report.

### Additional considerations

-   To create a Group Policy Modeling query, you must have the Perform Group Policy Modeling Analyses permission on the domain or organizational unit that contains the objects on which you want to run the query.

-   If you run Group Policy Modeling in an environment that supports Group Policy Preferences, the following requirements must be met for the Group Policy Preferences settings to appear in the report results:

-   To customize the information displayed in a report, click **Show** or **Hide** to display only the data that you want to view or print.

-   Within the GPMC, you cannot use the keyboard to navigate inside an HTML report. To browse inside the HTML report, save the report to a file and then use Internet Explorer to view the report.

-   If you open a previously saved console and want to save a Group Policy Modeling or Group Policy Results report in XML, rerun the report by using the **Rerun Query** option.

-   To view a saved report in a Web browser, you must use Internet Explorer® 6 or later.


