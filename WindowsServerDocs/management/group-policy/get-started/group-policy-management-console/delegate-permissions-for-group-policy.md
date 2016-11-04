---
title: delegate Permissions for Group Policy
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b16fc36e-a445-4ec7-9e18-5f7d707d7854
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# delegate Permissions for Group Policy

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes procedures for an administrator to delegate permissions to others using the GPMC so that they can perform some Group Policy administrative tasks.

## Introduction
With GPMC, the following tasks can be delegated:

-   create GPOs in a domain.

-   Set permissions on a GPO.

-   Set policy-related permissions on site, domain or organizational unit.

    -   Link GPOs to a given site, domain or organizational unit.

    -   Perform Group Policy modeling analyses on a given domain or organizational unit (but not on a site).

    -   Read Group Policy Results data for objects in a given domain or organizational unit (but not on a site).

-   create WMI filters in a domain.

-   Set permissions on a WMI filter.

GPMC simplifies delegation by managing the various ACEs required for a task as a single bundle of permissions for the task. if you want to see the ACL in detail, you can click the Advanced button on the delegation tab. The underlying mechanism for achieving delegation is the application of the appropriate DAcls to GPOs and other objects in active directory. This mechanism is identical to using security groups to filter the application of GPOs to various users.

You can also specify Group Policy to control the behavior of mmc and mmc snap-ins. for example, you can use Group Policy to manage the rights to create, configure, and use mmc consoles, and to control access to individual snap-ins.

## How to delegate permissions for a group or user on a Group Policy Object

#### To delegate permissions for a group or user on a Group Policy Object

1.  In the Group Policy Management Console (GPMC) console tree, expand the **Group Policy Objects** node in the forest and domain containing the Group Policy object (GPO) for which you want to add or remove permissions.

2.  Click the GPO.

3.  In the results pane, click the **delegation** tab.

4.  Click **add**.

5.  In the **select User, computer, or Group** dialog box, click **Object types**, select the types of objects for which you want to add GPO permissions, and then click **OK**.

6.  Click **Locations**, select either **Entire directory** or the domain or organizational unit containing the object for which you want to add GPO permissions, and then click **OK**.

7.  In the **Enter the object name to select** box, type the name of the object for which you want to add GPO permissions by performing one of the following actions:

    -   if you know the name, type it and then click **OK**.

    -   To search for the name, click **Advanced**, type the search criteria, click **find Now**, select the name in the list box, click **OK**, and then click **OK** again.

    -   In the **Permissions** box of the **add Group or User** dialog box, select the appropriate permissions from the drop-down list, and then click **OK**.

### additional considerations

-   To perform this procedure, you must have **edit settings, delete, and modify security** permissions on the GPO.

-   Groups and users that have **Custom** in the **Allowed Permissions** column in the **Groups and users** list box on the **delegation** tab have permissions that do not match one of the three standard levels of permissions. To view the permissions for groups with custom permissions or to set custom permissions, click **Advanced**.

-   You can also click the **delegation** tab to change or remove permissions for a group or user on a GPO.

## How to delegate permissions to link Group Policy Objects

#### To delegate permissions to link Group Policy Objects

1.  In the Group Policy Management Console (GPMC) console tree, do one of the following:

    -   To delegate permission to link Group Policy objects (GPOs) to either the domain or an organizational unit (OU), click the domain or the OU.

    -   To delegate permission to link GPOs to a site, click the site.

2.  In the results pane, click the **delegation** tab.

3.  In the **Permission** drop down-list box, select **Link GPOs**. Click **add**.

4.  In the **select User, computer, or Group** dialog box, click **Object types**, select the types of objects to which you want to delegate permissions for the domain, site, or OU, and then click **OK**.

5.  Click **Locations**, select either **Entire directory** or the domain or OU containing the object to which you want to delegate permissions, and then click **OK**.

6.  In the **Enter the object name to select** box, enter the name of the object to which you want to delegate permissions by doing one of the following:

    -   if you know the name, type it and then click **OK**.

    -   To search for the name, click **Advanced**, enter the search criteria, click **find Now**, select the name in the list box, click **OK**, and then click **OK** again.

7.  In the **add Group or User** dialog box, in the **Permissions** drop-down list, select the level to which you want permissions to apply for this group or user, and then click **OK**.

### additional considerations

-   To delegate permissions to link GPOs to a site, domain, or OU, you must have **Modify Permissions** on that site, domain, or OU. By default, only Domain Administrators and Enterprise Administrators have this permission.

-   Users and groups with permission to link GPOs to a specific site, domain, or OU can link GPOs, change link order, and set block inheritance on that site, domain, or OU.

-   You cannot remove groups and users that inherit permissions from a parent container.

-   Some entries in the **Groups and users** drop-down list, such as **System**, do not have an associated property dialog box, so **Properties** is unavailable for these entries.

## How to delegate permissions for generating Group Policy modeling data

#### To delegate permissions for generating Group Policy modeling data

1.  In the Group Policy Management Console (GPMC) console tree, click the domain or organizational unit (OU) for which you want to delegate Group Policy modeling permissions.

2.  In the results pane, click the **delegation** tab.

3.  In the **Permission** box, select **Perform Group Policy modeling analyses** to add a new group or user to the permissions list**.**

4.  On the **delegation** tab, click **add**.

5.  In the **select User, computer, or Group** dialog box, click **Object types**, select the types of objects to which you want to delegate permissions for the domain, site, or OU, and then click **OK**.

6.  Click **Locations**, select either **Entire directory** or the domain or OU containing the object to which you want to delegate permissions, and then click **OK**.

7.  In the **Enter the object name to select** box, find the name of the object to which you want to delegate permissions by doing one of the following:

    -   if you know the name, type it, and then click **OK** again.

    -   To search for the name, click **Advanced**, enter the search criteria, click **find Now**, select the name in the drop-down list, click **OK**, and then click **OK**.

8.  In the **add Group or User** dialog box, in the **Permissions** drop-down list, select the level to which you want permissions to apply for this group or user, and then click **OK**.

### additional considerations

-   To delegate permissions to perform Group Policy modeling analyses for objects in a domain or organizational unit, you must have **Modify Permissions** on that domain or organizational unit. By default, only domain administrators and enterprise administrators have this permission.

-   You cannot delegate permission to perform Group Policy modeling analyses for sites.

-   You can also use the **delegation** tab to change or remove permissions for a group or user for Group Policy modeling data.

## How to delegate permissions to generate Group Policy Results

#### To delegate permissions to generate Group Policy Results

1.  In the Group Policy Management Console (GPMC) console tree, click the domain or organizational unit (OU) for which you want to delegate permission to generate Group Policy Results.

2.  In the results pane, click the **delegation** tab.

3.  In the **Permissions** drop-down list, select **Read Group Policy Results data to add a new group or user to the permissions list.**

4.  On the **delegation** tab, click **add**.

5.  In the **select User, computer, or Group** dialog box, click **Object types**, select the types of objects to which you want to delegate permissions for the domain, site, or OU, and then click **OK**.

6.  select the user or group to which permission should be delegated.

7.  In the **add Group or User** dialog box, in the **Permissions** drop-down list, select the level to which you want permissions to apply for this group or user, and then click **OK**.

### additional considerations

-   To delegate permissions to generate Group Policy Results for objects in a domain or OU, you must have **Modify Permissions** on that domain or OU. By default, only domain administrators and enterprise administrators have this permission.

-   You cannot delegate permission to generate Group Policy Results for sites.

-   You can also use the **delegation** tab to change or remove permissions for a group or user for Group Policy Results data.

## How to delegate permissions for a group or user on a WMI filter

#### To delegate permissions for a group or user on a WMI filter

1.  In the Group Policy Management Console (GPMC) console tree, click the WMI filter for which you want to delegate permissions.

2.  In the results pane, click the **delegation** tab.

3.  Click **add**.

4.  In the **select User, computer, or Group** dialog box, click **Object types**, select the types of objects to which you want to delegate permissions on the WMI filter, and then click **OK**.

5.  Click **Locations**, select either **Entire directory** or the domain or organizational unit containing the object to which you want to delegate permissions, and then click **OK**.

6.  In the **Enter the object name to select** box, type the name of the object to which you want to delegate permissions by doing one of the following:

    -   if you know the name, type it and then click **OK**.

    -   To search for the name, click **Advanced**, type the search criteria, click **find Now**, select the name in the list box, click **OK**, and then click **OK** again.

7.  In the **add Group or User** dialog box, in the **Permissions** box, select the permissions level you want to assign to the group or user, and then click **OK**.

### additional considerations

-   You must have Full Control permissions on a WMI filter to change its permissions.

-   You cannot remove or change inherited permissions for WMI filters.

-   All users must have Read access to all WMI filters. Otherwise, Group Policy stops processing when it encounters a WMI filter that cannot be read.

-   You cannot use the GPMC to remove Read permissions from WMI filters.

-   WMI Filters are available if at least one domain controller in the domain is running Microsoft Windows Server 2003 or later.

-   You can also use the delegation tab to change or remove permissions for a group or user for WMI filters.

## How to delegate permissions for a Group or User on a starter GPO

#### delegating permissions for a Group or User on a starter GPO

1.  Open the Group Policy Management Console. expand the **starter GPOs** node.

2.  Click the starter GPO you want to delegate.

3.  In the results pane, click the **delegation** tab.

4.  Click **add**.

5.  In the **select User, computer, or Group** dialog box, click **Object types**, select the types of objects for which you want to add starter GPO permissions, and then click **OK**.

6.  Click **Locations**, select either **Entire directory** or the domain or organizational unit containing the object for which you want to add starter GPO permissions, and then click **OK**.

7.  In the **Enter the object name to select** box, type the name of the object for which you want to add starter GPO permissions by performing one of the following actions:

    -   if you know the name, type it and then click **OK**.

    -   To search for the name, click **Advanced**, type the search criteria, click **find Now**, select the name in the list box, click **OK**, and then click **OK** again.

8.  In the **Permissions** box of the **add Group or User** dialog box, select the appropriate permissions from the drop-down list, and then click **OK**.


