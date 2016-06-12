---
title: Working with Group Policy Objects using GPMC
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9933e6fd-ea3c-493f-9ce7-853b46f08896
---
# Working with Group Policy Objects using GPMC
This topic describes procedures for configuring, filtering, backing up, restoring and importing Group Policy Objects using the Group Policy management Console \(GPMC\).

## Introduction
The Local Group Policy object \(Local GPO\) is stored on each individual computer, in the hidden **Windows\\System32\\GroupPolicy** directory. Generally, each computer running Windows has exactly one Local GPO, regardless of whether the computers are part of an active directory environment. Local GPOs are always processed, but are the least influential GPOs in an active directory environment, because active directory\-based GPOs have precedence.

at the domain level, a GPO is a collection of Group Policy settings stored as a virtual object consisting of a Group Policy container and a Group Policy template. The Group Policy container, which contains information about the properties of a GPO, is stored in active directory on each domain controller in the domain. The Group Policy template contains the data in a GPO and is stored in the SYSvol in the \/Policies subdirectory. GPOs affect users and computers that are contained in sites, domains, and OUs.

Because GPOs contain policy settings, the GPOs can be configured, backed up, restored, copied, and scoped using the GPMC.

## How to add a comment to a Group Policy Object
You can include comments for each Group Policy object. You can use this space to document the Group Policy object and why its implementation is important to your environment. Commenting GPOs allows you to later use keyword filter to help you quickly find GPOs with matching keywords.

#### adding a comment to a Group Policy Object

1.  Open the Group Policy management Console. expand the **Group Policy Objects** node.

2.  Right\-click the Group Policy object you want to comment and then click **edit**.

3.  In the console tree, right\-click the name of the Group Policy object and then click **Properties**.

4.  Click the **Comment** tab.

5.  type your comments in the **Comment** box.

6.  Click **OK**

## How to back up a Group Policy Object

#### To back up a Group Policy object

1.  In the Group Policy management Console \(GPMC\) console tree, open **Group Policy Objects** in the forest and domain containing the Group Policy object \(GPO\) to back up.

2.  To back up a single GPO, right\-click the GPO, and then click **Back Up**. To back up all GPOs in the domain, right\-click **Group Policy objects** and click **Back Up All**.

3.  In the **Backup Group Policy object** dialog box, in the **Location** box, enter the path for the location in which you want to store the GPO backups, or click **Browse**, locate the folder in which you want to store the GPO backups, and then click **OK**.

4.  In the **Description** box, type a description for the GPOs that you want to back up, and then click **Back Up**. if you are backing up multiple GPOs, the description will apply to all GPOs you back up.

5.  After the operation completes, click **OK**.

    > [!importANT]
    > To secure backed\-up GPOs, ensure that only authorized administrators have permission to access the folder to which you are exporting the GPOs.

### additional considerations

-   You must have Read permissions on the GPO and Write permissions on the folder containing the GPO backup to perform this procedure.

-   The backup function also serves as the export capability for GPOs.

## How to block Group Policy Object inheritance
You can block inheritance for a domain or organizational unit. Blocking inheritance prevents Group Policy objects \(GPOs\) that are linked to higher sites, domains, or organizational units from being automatically inherited by the child\-level.

#### To block inheritance

1.  In the Group Policy management Console \(GPMC\) console tree, double\-click the forest containing the domain or organizational unit \(OU\) for which you want to block inheritance for GPO links, and then do one of the following:

    -   To block inheritance of the GPO links of an entire domain, double\-click **Domains**, and then right\-click the domain.

    -   To block inheritance for an OU, double\-click **Domains**, double\-click the domain containing the OU, and then right\-click the OU.

2.  Click **Block Inheritance**.

### additional considerations

-   To complete this procedure, you must have Link GPOs permission for the domain or OU.

-   if a domain or OU is set to block inheritance, it will appear with a blue exclamation mark in the console tree.

-   GPO links that are enforced cannot be blocked from the parent container.

## How to copy a Group Policy Object
You can copy a Group Policy object \(GPO\) either by using the drag\-and\-drop method or right\-click method. Both methods are described in this topic.

#### To copy a Group Policy object \(drag\-and\-drop method\)

1.  In the Group Policy management Console \(GPMC\) console tree, click the Group Policy object \(GPO\) that you want to copy.

2.  Do one of the following:

    -   To create a copy of the GPO on the same domain as the source GPO, drag and drop the GPO you want to copy to **Group Policy Objects**, select a permissions option under **Specify the permissions for the new GPO**, and then click **OK**.

    -   To create a copy of the GPO in a different domain, double\-click the destination domain, then drag and drop the GPO you want to copy to **Group Policy objects**. Answer all the questions in the cross\-domain copying wizard that appears, and then click **Finish**.

#### To copy a Group Policy object \(right\-click method\)

1.  In the GPMC console tree, right\-click the GPO that you want to copy, and then click **copy**.

2.  Do one of the following:

    -   To create a copy of the GPO in the same domain as the source GPO, right\-click **Group Policy objects**, click **Paste**, specify permissions for the new GPO in the **copy GPO** box, and then click **OK**.

    -   To create a copy of the GPO in a different domain, double\-click the destination domain, right\-click **Group Policy objects**, and then click **Paste**. Answer all the questions in the cross\-domain copying wizard that appears, and then click **Finish**.

### additional considerations

-   You must have privileges to create GPOs in the destination domain to complete this procedure.

-   for copy operations to another domain, you may need to specify a migration table.

## How to create and edit a Group Policy Object

> [!NOTE]
> You can also create a GPO from a starter GPO. for more information, see [create a New GPO from a starter GPO](https://technet.microsoft.com/library/cc753835.aspx).

### <a name="BKMK_create"></a>
##### To create a Group Policy object

1.  In the GPMC console tree, right\-click **Group Policy Objects** in the forest and domain in which you want to create a GPO.

2.  Click **New**.

3.  In the **New GPO** dialog box, specify a name for the new GPO, and then click **OK**.

### <a name="BKMK_edit"></a>
##### To edit a Group Policy Object

1.  In the GPMC console tree, double\-click **Group Policy Objects** in the forest and domain containing the GPO that you want to edit.

2.  Right\-click the GPO, and then click **edit**.

3.  In the console tree, edit the settings as appropriate.

    > [!importANT]
    > The Default Domain Policy GPO and Default Domain Controllers Policy GPO are vital to the health of any domain. As a best practice, you should not edit the Default Domain Controllers Policy GPO or the Default Domain Policy GPO, except in the following cases:

    -   Account policy settings are required to be configured in the Default Domain GPO.

    -   if you install applications on domain controllers requiring modifications to User Rights or Audit policy settings, you must modify the policy settings in the Default Domain Controllers Policy GPO.

### additional considerations

-   When you create a GPO, it will not have an effect until it is linked to a site, domain, or organizational unit \(OU\).

-   By default only domain administrators, enterprise administrators, and members of the Group Policy creator owners group can create and edit GPOs.

-   To edit IPSec policy settings from within a GPO, you must be a member of the domain administrators group.

-   You can also edit a GPO by right\-clicking the name of the GPO in any container in which it is linked, and then clicking **edit**.

## How to create and populate a Migration Table
A migration table is used when you copy or import a Group Policy Object \(GPO\) from one domain or forest to another. The key challenge when migrating Group Policy objects \(GPOs\) from one domain or forest to another is that some information in the GPO is actually specific to the domain or forest where the GPO is defined. When transferring the GPO to a new domain or forest, it may not always be desirable, or even possible, to use the same settings. You can use a migration table to reference users, groups, computers, and UNC paths in the source GPO to new values in the destination GPO.

You can create migration tables using the Migration Table editor.

You can use the migration table editor to scan one or more Group Policy objects \(GPOs\) or backup GPOs, extract all references to security principals and UNC paths, and automatically enter these items in the migration table as source name entries.

#### To create a migration table

1.  In the Group Policy management Console \(GPMC\) console tree, double\-click the forest from which you want to create a migration table.

2.  Do either of the following:

    -   Right\-click **Domains** and then click **Open Migration Table editor**.

    -   Right\-click **Group Policy objects**, and then click **Open Migration Table editor**.

3.  Specify a source you want to include in the migration table by doing the following:

    1.  Under **Source Name**, type the source name or right\-click the cell and click **Browse** to find and then specify the object type, location, and name.

        if you enter the source name manually, you must type the exact name of the User, computer, Group, or UNC path referenced in the source GPO \(for example, TestDomain\\PolicyAdmins or \\\\server1\\publicshare\). The type of the source name must match the source type specified in the migration table.

        Security principals can be specified using any of the following formats:

        **UPN**: for example, *someone@contoso.com*.

        **SAM**: for example, *contoso\\someone*.

        **DNS**: for example, *contoso.com\\someone*.

        **Free text**: for example, *someone*. You must specify the type as Free Text or SID.

        **SID**: for example, S\-1\-11\-111111111\-111111111\-1111111111\-1112. You must specify the type as Free Text or SID.

    2.  Under **Source type**, specify the type of source in the cell adjacent to the source name cell by using the drop\-down list and selecting the appropriate type. if you have used **Browse** to find the source name, the source type is entered by default.

    3.  Under **Destination Name**, type the destination name or right\-click the cell adjacent to the source name and source type cells, and then do one of the following:

        Click **Browse** to find a user, computer, or group.

        Point to **Set Destination**, and then click the appropriate selection. You cannot use the **No Destination** option for UNC paths.

4.  Repeat Step 3 for each source you want to include in the migration table.

5.  Click **File**, and then click **Save**.

6.  Specify the location where you want to save the migration table, and then click **Save**.

You can use the migration table editor to check that destination entries can be resolved. if destination entries do not resolve in the migration table, then the copy or import operation might fail. To validate your migration table, from the **Tools** menu, click **Validate**.

#### To automatically populate a migration table from a GPO

1.  Open the migration table editor.

2.  From the **Tools** menu, click **Populate from GPO**.

3.  In the **Look in this domain** drop\-down list, select the domain that contains the GPO.

4.  In the **Group Policy objects** list, click the GPO or GPOs from which you want to populate the migration table, select **Include security principals from the DACL on the GPO** during scan if appropriate, and then click **OK**.

#### To automatically populate a migration table from a backup GPO

1.  Open the migration table editor.

2.  From the **Tools** menu, click **Populate from Backup**.

3.  In the **Backup location** drop\-down box, type the path of the folder that contains the backup GPO, or click **Browse** to locate the folder.

4.  In the **Backed up GPOs** list, select one or more backed\-up GPOs, select **Show only the latest version of each GPO** or **Include security principals from the DACL on the GPO** if appropriate, and then click **OK**.

### additional considerations

-   To complete the migration table for either of these procedures, you need to adjust only the destination values. By default, the destination name for each entry will be set to **Same as source** when you use either of the **Populate** options.

## How to delete a Group Policy Object
Insert section body here.

#### To delete a GPO

1.  In the Group Policy management Console \(GPMC\) console tree, double\-click **Group Policy Objects** in the forest and domain containing the Group Policy object \(GPO\) that you want to delete.

2.  Right\-click the GPO, and then click **delete**.

3.  When prompted to confirm the deletion, click **OK**.

### additional considerations

-   To delete a GPO, you must have edit Settings, delete, and Modify Security permissions for the GPO.

-   When you delete a GPO, GPMC attempts to delete all links to that GPO in the domain of the GPO. if you do not have rights to delete a link, the GPO will be deleted, but the link will remain. Links from other domains and sites are not deleted. The link to a deleted GPO appears in GPMC as **Not Found**. To delete **Not Found** links, you must have permission on the site, domain, or organizational unit containing the link.

-   You cannot delete the Default Domain Controllers Policy GPO or the Default Domain Policy GPO.

## How to disable a Group Policy Object link

#### To disable a Group Policy object link

-   In the Group Policy management Console \(GPMC\) console tree, double\-click to expand the forest containing the domain, site, or organizational unit \(OU\) containing the link you want to disable, and then do one of the following:

    Right\-click the GPO link. A check mark next to **Link Enabled** indicates that the link is enabled.

    Click **Link Enabled** to disable the link. No check mark will be displayed when the link is disabled.

### additional considerations

-   You must have Link GPOs permission for the domain, site, or OU to complete this procedure.

-   You can also click the GPO link and look at the information in the **Links** section of the **Scope** tab to determine if a GPO link is enabled.

## How to disable user or computer settings in a Group Policy Object

#### To disable user or computer settings in a Group Policy object

1.  In the Group Policy management Console \(GPMC\) console tree, double\-click the forest containing the domain or organizational unit \(OU\) that contains the Group Policy object \(GPO\).

2.  Double\-click the domain or OU.

3.  Right\-click the GPO that contains the user or computer settings you want to disable, point to **GPO Status**, and then do one of the following:

    -   Click **User settings disabled** to disable user settings for the GPO.

    -   Click **computer settings disabled** to disable computer settings for the GPO.

4.  A check mark next to **User settings disabled** or **computer settings disabled** indicates that user or computer settings are disabled.

### additional considerations

-   You must have **edit** permission on the GPO to complete this procedure.

-   You can also modify **GPO Status** from the **details** tab of a GPO.

## How to enforce a Group Policy Object link

#### To enforce a Group Policy object link

1.  In the Group Policy management Console \(GPMC\) console tree, double\-click the forest containing the domain, site, or organizational unit \(OU\) containing the link you want to enforce, and then do one of the following:

    -   To enforce a GPO link at the domain level, double\-click **Domains**, and then double\-click the domain containing the GPO link.

    -   To enforce a GPO link at the OU level, double\-click **Domains**, double\-click the domain containing the OU, and then double\-click the OU containing the GPO link.

    -   To enforce a GPO link at the site level, double\-click **Sites**, and double\-click the site containing the GPO link.

2.  Right\-click the GPO link, and then click **Enforced** to enable or disable enforcing the link. A check mark next to **Enforced** indicates that the link is enforced.

### additional considerations

-   You must have Link GPOs permission for the domain, site, or organizational unit containing the GPO link to complete this procedure.

-   To determine whether a GPO link is enforced, you can also click the GPO link and look at the information in the **Links** section of the **Scope** tab.

## How to filter Group Policy Objects using WMI filters
Windows management Instrumentation \(WMI\) filters allow you to dynamically determine the scope of Group Policy objects \(GPOs\), based on attributes of the target computer.

When a GPO that is linked to a WMI filter is applied on the target computer, the filter is evaluated on the target computer. if the WMI filter evaluates to false, the GPO is not applied \(unless the client computer is running Windows 2000, in which case the filter is ignored and the GPO is always applied\). if the WMI filter evaluates to true, the GPO is applied.

#### To create a WMI filter

1.  In the Group Policy management Console \(GPMC\) console tree, right\-click **WMI Filters** in the forest and domain in which you want to create a WMI filter.

2.  Click **New**.

3.  In the **New WMI Filter** dialog box, type a name for the new WMI Filter in the **Name** box, and type a description of the filter in the **Description** box.

4.  Click **add**.

5.  In the **WMI query** dialog box, either leave the default namespace \(root\\CIMv2\) or enter another namespace by doing one of the following:

    -   In the **Namespace** box, type the name of the namespace that you want to use for the WMI query.

    -   Click **Browse**, select a namespace from the list, and then click **OK**.

6.  type a WMI query in the **query** box, and then click **OK**.

7.  To add more queries, repeat Steps 4 through 6 to add each query.

8.  After adding all queries, click **Save**.

    **additional considerations**

    -   You must have privileges to create WMI filters in the domain in which you want to create the filter. By default, the Domain Administrators, Enterprise Administrators, and Group Policy Creator Owners groups have this permission.

    -   **WMI Filters** is only available if at least one domain controller in the domain is running Microsoft Windows Server™ 2003. The same is true for **WMI Filtering** on the **Scope** tab for **Group Policy Objects**.

    -   To delete a WMI filter, in the console tree, right\-click the WMI filter and then click **delete**. When asked to confirm whether you want to delete the WMI filter, click **Yes**.

    -   WMI Filters are not evaluated on Microsoft Windows® 2000. A GPO targeted to a Windows 2000 machine will always apply the GPO regardless of the query associated with the WMI Filter \(the filter is ignored\)

#### import a WMI Filter

1.  In the Group Policy management Console \(GPMC\) console tree, right\-click **WMI Filters** in the forest and domain into which you want to import a WMI filter.

2.  Click **import**.

3.  In the **import WMI Filter** dialog box, enter the .mof file that contains the WMI filter you want to import, and then click **Open**.

4.  In the **import WMI Filter** dialog box, specify the appropriate information in the **Name** and **Description** boxes, and then do one of the following:

    -   To import the WMI filter without changing it, click **import**.

    -   To change the WMI filter and then import it, click **edit**, make the appropriate changes to the namespace or query, click **OK**, and then click **import**.

    **additional considerations**

    -   You must have privileges to create WMI filters in the domain in which you want to create the filter to complete this procedure. By default the Domain Administrators, Enterprise Administrators, and Group Policy Creator Owners groups have this permission.

    -   **WMI Filters** is only available if at least one domain controller in the domain is running Microsoft Windows Server 2003. The same is true for WMI Filtering on the **Scope** tab for **Group Policy objects**.

    -   importing a WMI filter creates a new filter instead of modifying an existing filter.

#### Export a WMI filter

1.  In the Group Policy management Console \(GPMC\) console tree, right\-click the WMI filter that you want to export, and then click **Export**.

2.  In the **Export WMI filter** dialog box, select a secure file system location from the **Save in** drop\-down list box, type a name for the filter that you want to export, and then click **Save**.

    **additional considerations**

    -   You can also export a WMI filter by clicking **WMI Filters** and, in the results pane, clicking the **Contents** tab, right\-clicking the filter name, and then clicking **Export**.

    -   GPMC can import only .mof files that contain a single WMI filter.

#### To copy a WMI Filter

1.  In the Group Policy management Console \(GPMC\) console tree, click the WMI filter in the forest and domain containing the WMI filter that you want to copy.

2.  Right\-click the WMI filter you want to copy, and then click **copy**.

3.  In the destination domain, right\-click **WMI Filters**, and then click **Paste**.

    **additional considerations**

    -   To complete this procedure, you must have privileges to create WMI filters in the domain in which you want to create the filter. By default, the Domain Administrators, Enterprise Administrators, and Group Policy Creator Owners groups have this permission.

#### To link a WMI filter to a Group Policy object

1.  In the Group Policy management Console \(GPMC\) console tree, double\-click **Group Policy Objects** in the forest and domain containing the Group Policy object \(GPO\) to which you want to link a WMI filter.

2.  Click the GPO.

3.  In the results pane, on the **Scope** tab, under **WMI Filtering**, select a WMI filter from the drop\-down list.

4.  When prompted to confirm the selection, click **Yes**.

    **additional considerations**

    -   To link a WMI filter to a GPO, you must have edit permissions on the GPO.

    -   Only one WMI filter can be linked to a GPO, and you can only link a WMI filter to a GPO in the same domain.

    -   **WMI Filters** and **WMI Filtering** on the **Scope** tab for GPOs are available only if at least one domain controller in the domain is running Microsoft Windows Server 2003.

## How to filter for Group Policy Objects using security groups

#### To filter using security groups

1.  In the Group Policy management Console \(GPMC\) console tree, expand **Group Policy Objects** and click the Group Policy object \(GPO\) to which you want to apply security filtering.

2.  In the results pane, on the **Scope** tab, click **add**.

3.  In the **Enter the object name to select** box, type the name of the group, user, or computer that you want to add to the security filter. Click **OK**.

### additional considerations

-   In order to ensure that only members of the group or groups you added in Step 3 can receive the settings in this GPO, you will need to remove **Authenticated Users** if this group appears in the **Scope** tab. Click the **Scope** tab, select this group, and then click **remove**.

-   You must have edit settings, delete, and modify security permissions on the GPO to perform these procedures.

-   The settings in a GPO will apply only to users and computers that are contained in the domain, organizational unit, or organizational units to which the GPO is linked, and that are specified in or are members of a group that are specified in Security Filtering.

## How to import settings from a Group Policy Object

#### To import settings from a Group Policy object

1.  In the Group Policy management Console \(GPMC\) console tree, expand the **Group Policy Objects** node in the forest and domain containing the Group Policy object \(GPO\) to import settings.

2.  Right\-click the GPO and click **import Settings**.

3.  Follow the instructions in the **import Settings Wizard**.

### additional considerations

-   To complete this procedure, you must have edit permissions on the GPO into which you want to import settings.

-   for import operations to another domain or forest, you may need to specify a migration table.

## How to link Group Policy Objects

#### To link a GPO

1.  In the Group Policy management Console \(GPMC\) console tree, locate the site, domain, or organizational unit \(OU\) to which you want to link a Group Policy object \(GPO\)

2.  Do one of the following:

    -   To link an existing GPO, right\-click the domain or OU within the domain, and then click **Link an Existing GPO**. In the **select GPO** dialog box, click the GPO that you want to link, and then click **OK**.

    -   To link a new GPO, right\-click the domain or OU within a domain, and then click **create a GPO in this domain, and link it here**. In the **Name** box, type a name for the new GPO, and then click **OK**.

### additional considerations

-   To link an existing GPO to a site, domain, or OU, you must have Link GPOs permission on that site, domain, or OU. By default, only domain administrators and enterprise administrators have this privilege for domains and OUs. Enterprise administrators and domain administrators of the forest root domain have this privilege for sites.

-   To create and link a GPO, you must have Link GPOs permissions on the desired domain or organizational unit, and you must have permission to create GPOs in that domain. By default, only domain administrators, enterprise administrators, and Group Policy Creator owners have permission to create GPOs.

-   The **create a GPO in this domain, and link it here** option is not available for sites. The administrator can create a GPO in any domain in the forest, and then use the **Link an Existing GPO** option to link it to the site.

## How to restore a deleted or previous version of an existing Group Policy Object

#### To restore a deleted or previous version of an existing Group Policy object

1.  In the Group Policy management Console \(GPMC\) console tree, in the forest and domain containing the Group Policy object \(GPO\) that you want to restore, locate **Group Policy Objects**.

2.  Right\-click **Group Policy Objects** and then click **manage Backups**.

3.  In the **manage Backups** dialog box, in the **Backup location** box, type the path for the backup folder. You can also use **Browse** to locate the backup folder.

4.  In the **Backed up GPOs** box, select the GPO that you want to restore from the list of GPO backups shown, and then click **Restore**.

5.  When prompted to confirm the restore operation, click **OK**.

6.  After the operation completes, click **OK** and then click **Close**.

### additional considerations

-   You must have privileges to create GPOs in the domain and Read permissions on the file system location of the backed\-up GPO to restore a GPO that has been deleted.

-   You can also restore an existing or deleted GPO using the **manage Backups** function by right\-clicking **Domains**.

## How to search for a Group Policy Object

#### To search for a Group Policy object

1.  In the Group Policy management Console \(GPMC\) console tree, double\-click the forest containing the domain where you want to search for a Group Policy object \(GPO\). Double\-click **Domains**, right\-click the domain, and then click **Search**.

2.  In the **Search for Group Policy objects** dialog box, in the **Search for GPOs in this domain** box, select a domain or select **All domains shown in this forest**.

3.  In the **Search item** box, select the type of object on which you want to base your search.

    if you select **Security Group**, the **select User, computer, or Group** dialog box appears. Specify the appropriate object type, location of the object, and object name, and then click **OK**.

    You can choose **GPO\-links** on the **Search item** dropdown menu to find unlinked GPOs and GPOs linked across domains.

4.  In the **Condition** box, select the condition that you want to use in the search.

5.  In the **Value** box, select or specify the value that you want to use to filter the search, and then click **add**.

6.  Repeat Steps 4 and 5 until you complete the definition of all search criteria, and then click **Search**.

7.  When search results are returned, do one of the following:

    -   To save the search results, click **Save results** and then, in the **Save GPO Search Results** dialog box, specify the file name for the saved results, and then click **Save**.

    -   To navigate to a GPO found in the search, double\-click the GPO in the search results list.

    -   To clear the search results, click **Clear**.

### additional considerations

-   You can also open the search dialog box by right\-clicking a forest and then clicking **Search**. In this case, the search for GPOs in this domain box defaults to **All domains shown in this forest**.

-   if a policy setting is enabled and then all the policy settings in that extension are removed, there can be false\-positive search results for certain types of settings. This happens because the GPO has the extension listed as active. The extensions with this behavior are Security Settings, Software Installation, Folder Redirection, Internet Explorer Maintenance, and Encrypting File System \(EFS\).


