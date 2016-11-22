---
title: Working with starter GPOs using GPMC
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 792b9e16-d8af-4ce9-8cac-500585a1de0a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Working with starter GPOs using GPMC

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic contains procedures for managing starter Group Policy Objects as a Group Policy administrator using the Group Policy Management Console in Windows Server  2012.

## About starter Group Policy Objects
starter Group Policy Objects are derived from a Group Policy Object, and provide the ability to store a collection of Administrative Template policy settings in a single object. You can import and export starter GPOs, which makes them easy to distribute to other environments. When you create a new GPO from a starter GPO, the new GPO has all of the Administrative Template policy settings and their values that were defined in the starter GPO.

System starter Group Policy Objects (GPOs) are read-only starter GPOs that provide a baseline of settings for a specific scenario. Like starter GPOs, they derive from a GPO, provide the ability to store a collection of Administrative Template policy settings in a single object, and can be imported. You can determine whether a starter GPO is a System starter GPO by viewing the **starter GPO type** on the **details** tab of the starter GPO.

A variety of System starter GPOs are included with Windows Server. For information about the recommended use of each System starter GPO, see the **Comment** on the **details** tab for that starter GPO.

## <a name="BKMK_create"></a>How to create a starter GPO

#### create a starter GPO

1.  Open the **Group Policy Management Console**.

2.  Right-click **starter GPOs** and then click **New**.

3.  In the **New starter GPO** dialog box, type the name of the starter GPO in the **Name** box. Optionally, you can type comments in the **Comments** box.

4.  Click **OK**.

## <a name="BKMK_edit"></a>How to edit a starter GPO

#### edit a starter GPO

1.  Open the **Group Policy Management Console**. expand the **starter GPOs** node.

2.  Right-click the starter GPO you want to edit and then click **edit**.

3.  In the console tree, click the folder under **Administrative Templates** that contains the policy settings you want to configure.

4.  In the **Setting** column, click the name for a policy setting to read a description of the policy setting.

5.  To change a policy setting, double-click the name of the policy setting.

6.  In the policy setting dialog box, click one of the following:

    -   **Not Configured**: The registry is not modified.

    -   **Enabled**: The registry reflects that the policy setting is selected.

    -   **Disabled**: The registry reflects that the policy setting is not selected.

7.  select any other available options, and then click **OK**.

## How to copy a starter GPO

#### copying a starter GPO

1.  Open the Group Policy Management Console. expand the **starter GPOs** node.

2.  Right-click the starter GPO you want to copy and then click **copy**.

3.  Right-click the **starter GPO** node and then click **Paste**.

4.  Click **OK**.

## How to delete a starter GPO

#### delete a starter GPO

1.  Open the Group Policy Management Console. expand the **starter GPOs** node.

2.  Right-click the starter GPO you want to delete and then click **delete**.

3.  Click **OK** to confirm the deletion.

## How to create a new GPO from a starter GPO
There are two ways to create a new Group Policy object from a starter GPO. You can create a new Group Policy object from a starter GPO at the starter GPOs node or at the Group Policy objects node.

### Using the starter GPOs node

##### create a new GPO from a starter GPO at the starter GPOs node

1.  Open the Group Policy Management Console. expand the **starter GPOs** node.

2.  Right-click the starter GPO you want to use to create a new Group Policy object and then click **New GPO from starter GPO**.

3.  In the **New GPO** dialog box, type the name of the new Group Policy object in the **Name** box.

4.  Click **OK**.

### Using the Group Policy Objects node

##### create a new GPO from a starter GPO at the Group Policy Objects node

1.  Open the Group Policy Management Console. Right-click the **Group Policy Objects** node.

2.  In the **New GPO** dialog box, type the name of the new Group Policy object in the **Name** box.

3.  select the starter GPO from the **Source starter GPO** list that you want to use to create a new Group Policy object.

4.  Click **OK**.

## How to back up a starter GPO

#### Backing up a starter GPO

1.  Open the Group Policy Management Console. expand the **starter GPOs** node.

2.  To back up a single starter GPO, right-click the starter GPO, and then click **Back Up**. To back up all starter GPOs in the domain, right-click **starter GPOs** and click **Back Up All**.

3.  In the **Backup starter GPO** dialog box, in the **Location** box, enter the path for the location where you want to store the starter GPO backups. Or click **Browse**, locate the folder in which you want to store the starter GPO backups, and then click **OK**.

4.  In the **Description** box, type a description for the starter GPOs that you want to back up, and then click **Back Up**. If you are backing up multiple starter GPOs, the description will apply to all starter GPOs you back up.

5.  After the operation completes, click **OK**.

    > [!IMPORTANT]
    > To secure backed-up starter GPOs, ensure that only authorized administrators have permission to access the folder to which you are backing up the starter GPOs.

## How to restore a starter GPO

#### Restoring a starter GPO

1.  Open the Group Policy Management Console. expand the **starter GPOs** node.

2.  Right-click **starter GPOs** and then click **Manage Backups**.

3.  In the **Manage Backups** dialog box, in the **Backup location** box, type the path for the backup folder. You can also use **Browse** to locate the backup folder.

4.  In the **Backed up starter GPOs** box, select the starter GPO that you want to restore from the list of starter GPO backups shown, and then click **Restore**.

5.  When prompted to confirm the restore operation, click **OK**.

6.  After the operation completes, click **OK** and then click **Close**.

## How to work with reports of starter GPO settings

#### To view, print, and save a report of starter GPO settings

1.  Open the Group Policy Management Console. expand the **starter GPOs** node.

2.  Click the starter GPO that has the settings you want to view.

3.  Click the **Settings** tab to view reports in GPMC.

4.  if you want to print or save the report, right-click the settings report in the results pane and do one of the following:

    -   select **print** to print the report.

    -   select **Save Report** to save the report.

        > [!NOTE]
        > To customize the information displayed in a report, click **Show** or **Hide** to display only the data you want to view or print.

## How to import a starter GPO

#### importing a starter GPO

1.  Open the Group Policy Management Console. Click the **starter GPOs** node.

2.  Click **Load Cabinet**. Then click **Browse for CAB**.

3.  Use the **Load starter GPO** dialog box to locate the starter GPO cabinet you want to load. Click the file name and then click **Open**.

4.  Click **OK** to complete the import.

## How to export a starter GPO

#### Exporting a starter GPO

1.  Open the Group Policy Management Console. Click the **starter GPOs** node.

2.  Click **Save as Cabinet**.

3.  In the **Save starter GPO as Cabinet** window, type the name of the file in the **File name** box. Optionally, you can click **Browse Folders** if you want to change the location where the cabinet file is saved.

4.  Click **Save**.

## How to add a comment to a starter GPO
You can include comments for each starter GPO. You can use this text box to further document the intended use of the starter GPO or the name of the user who last updated the starter GPO. Commenting starter GPOs allows you to later use keyword filter to help you quickly find a starter GPO with matching keywords.

#### adding a Comment to a starter Group Policy object

1.  Open the Group Policy Management Console. expand the **starter GPOs** node.

2.  Right-click the starter GPO you want to comment and then click **edit**.

3.  In the console tree, right-click the name of the starter GPO and then click **Properties**.

4.  Click the **Comment** tab.

5.  type your comments in the **Comment** box.

6.  Click **OK**.


