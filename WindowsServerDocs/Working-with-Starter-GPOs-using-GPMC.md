---
title: Working with Starter GPOs using GPMC
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 792b9e16-d8af-4ce9-8cac-500585a1de0a
author: coreyp
---
# Working with Starter GPOs using GPMC
This topic contains procedures for managing Starter Group Policy Objects as a Group Policy administrator using the Group Policy Management Console in [!INCLUDE[win8_server_1](includes/win8_server_1_md.md)].  
  
## About Starter Group Policy Objects  
Starter Group Policy Objects are derived from a [!INCLUDE[gpo](includes/gpo_md.md)], and provide the ability to store a collection of Administrative Template policy settings in a single object. You can import and export Starter GPOs, which makes them easy to distribute to other environments. When you create a new GPO from a Starter GPO, the new GPO has all of the Administrative Template policy settings and their values that were defined in the Starter GPO.  
  
System Starter Group Policy Objects \(GPOs\) are read\-only Starter GPOs that provide a baseline of settings for a specific scenario. Like Starter GPOs, they derive from a GPO, provide the ability to store a collection of Administrative Template policy settings in a single object, and can be imported. You can determine whether a Starter GPO is a System Starter GPO by viewing the **Starter GPO type** on the **Details** tab of the Starter GPO.  
  
A variety of System Starter GPOs are included with Windows Server. For information about the recommended use of each System Starter GPO, see the **Comment** on the **Details** tab for that Starter GPO.  
  
## <a name="BKMK_Create"></a>How to create a Starter GPO  
  
#### Create a Starter GPO  
  
1.  Open the **Group Policy Management Console**.  
  
2.  Right\-click **Starter GPOs** and then click **New**.  
  
3.  In the **New Starter GPO** dialog box, type the name of the Starter GPO in the **Name** box. Optionally, you can type comments in the **Comments** box.  
  
4.  Click **OK**.  
  
## <a name="BKMK_Edit"></a>How to edit a Starter GPO  
  
#### Edit a Starter GPO  
  
1.  Open the **Group Policy Management Console**. Expand the **Starter GPOs** node.  
  
2.  Right\-click the Starter GPO you want to edit and then click **Edit**.  
  
3.  In the console tree, click the folder under **Administrative Templates** that contains the policy settings you want to configure.  
  
4.  In the **Setting** column, click the name for a policy setting to read a description of the policy setting.  
  
5.  To change a policy setting, double\-click the name of the policy setting.  
  
6.  In the policy setting dialog box, click one of the following:  
  
    -   **Not Configured**: The registry is not modified.  
  
    -   **Enabled**: The registry reflects that the policy setting is selected.  
  
    -   **Disabled**: The registry reflects that the policy setting is not selected.  
  
7.  Select any other available options, and then click **OK**.  
  
## How to copy a Starter GPO  
  
#### Copying a Starter GPO  
  
1.  Open the Group Policy Management Console. Expand the **Starter GPOs** node.  
  
2.  Right\-click the Starter GPO you want to copy and then click **Copy**.  
  
3.  Right\-click the **Starter GPO** node and then click **Paste**.  
  
4.  Click **OK**.  
  
## How to delete a Starter GPO  
  
#### Delete a Starter GPO  
  
1.  Open the Group Policy Management Console. Expand the **Starter GPOs** node.  
  
2.  Right\-click the Starter GPO you want to delete and then click **Delete**.  
  
3.  Click **OK** to confirm the deletion.  
  
## How to create a new GPO from a Starter GPO  
There are two ways to create a new Group Policy object from a Starter GPO. You can create a new Group Policy object from a Starter GPO at the Starter GPOs node or at the Group Policy objects node.  
  
### Using the Starter GPOs node  
  
##### Create a new GPO from a Starter GPO at the Starter GPOs node  
  
1.  Open the Group Policy Management Console. Expand the **Starter GPOs** node.  
  
2.  Right\-click the Starter GPO you want to use to create a new Group Policy object and then click **New GPO from Starter GPO**.  
  
3.  In the **New GPO** dialog box, type the name of the new Group Policy object in the **Name** box.  
  
4.  Click **OK**.  
  
### Using the Group Policy Objects node  
  
##### Create a new GPO from a Starter GPO at the Group Policy Objects node  
  
1.  Open the Group Policy Management Console. Right\-click the **Group Policy Objects** node.  
  
2.  In the **New GPO** dialog box, type the name of the new Group Policy object in the **Name** box.  
  
3.  Select the Starter GPO from the **Source Starter GPO** list that you want to use to create a new Group Policy object.  
  
4.  Click **OK**.  
  
## How to back up a Starter GPO  
  
#### Backing up a Starter GPO  
  
1.  Open the Group Policy Management Console. Expand the **Starter GPOs** node.  
  
2.  To back up a single Starter GPO, right\-click the Starter GPO, and then click **Back Up**. To back up all Starter GPOs in the domain, right\-click **Starter GPOs** and click **Back Up All**.  
  
3.  In the **Backup Starter GPO** dialog box, in the **Location** box, enter the path for the location where you want to store the Starter GPO backups. Or click **Browse**, locate the folder in which you want to store the Starter GPO backups, and then click **OK**.  
  
4.  In the **Description** box, type a description for the Starter GPOs that you want to back up, and then click **Back Up**. If you are backing up multiple Starter GPOs, the description will apply to all Starter GPOs you back up.  
  
5.  After the operation completes, click **OK**.  
  
    > [!IMPORTANT]  
    > To secure backed\-up Starter GPOs, ensure that only authorized administrators have permission to access the folder to which you are backing up the Starter GPOs.  
  
## How to restore a Starter GPO  
  
#### Restoring a Starter GPO  
  
1.  Open the Group Policy Management Console. Expand the **Starter GPOs** node.  
  
2.  Right\-click **Starter GPOs** and then click **Manage Backups**.  
  
3.  In the **Manage Backups** dialog box, in the **Backup location** box, type the path for the backup folder. You can also use **Browse** to locate the backup folder.  
  
4.  In the **Backed up Starter GPOs** box, select the Starter GPO that you want to restore from the list of Starter GPO backups shown, and then click **Restore**.  
  
5.  When prompted to confirm the restore operation, click **OK**.  
  
6.  After the operation completes, click **OK** and then click **Close**.  
  
## How to work with reports of Starter GPO settings  
  
#### To view, print, and save a report of Starter GPO settings  
  
1.  Open the Group Policy Management Console. Expand the **Starter GPOs** node.  
  
2.  Click the Starter GPO that has the settings you want to view.  
  
3.  Click the **Settings** tab to view reports in GPMC.  
  
4.  If you want to print or save the report, right\-click the settings report in the results pane and do one of the following:  
  
    -   Select **Print** to print the report.  
  
    -   Select **Save Report** to save the report.  
  
        > [!NOTE]  
        > To customize the information displayed in a report, click **Show** or **Hide** to display only the data you want to view or print.  
  
## How to import a Starter GPO  
  
#### Importing a Starter GPO  
  
1.  Open the Group Policy Management Console. Click the **Starter GPOs** node.  
  
2.  Click **Load Cabinet**. Then click **Browse for CAB**.  
  
3.  Use the **Load Starter GPO** dialog box to locate the Starter GPO cabinet you want to load. Click the file name and then click **Open**.  
  
4.  Click **OK** to complete the import.  
  
## How to export a Starter GPO  
  
#### Exporting a Starter GPO  
  
1.  Open the Group Policy Management Console. Click the **Starter GPOs** node.  
  
2.  Click **Save as Cabinet**.  
  
3.  In the **Save Starter GPO as Cabinet** window, type the name of the file in the **File name** box. Optionally, you can click **Browse Folders** if you want to change the location where the cabinet file is saved.  
  
4.  Click **Save**.  
  
## How to add a comment to a Starter GPO  
You can include comments for each Starter GPO. You can use this text box to further document the intended use of the Starter GPO or the name of the user who last updated the Starter GPO. Commenting Starter GPOs allows you to later use keyword filter to help you quickly find a Starter GPO with matching keywords.  
  
#### Adding a Comment to a Starter Group Policy object  
  
1.  Open the Group Policy Management Console. Expand the **Starter GPOs** node.  
  
2.  Right\-click the Starter GPO you want to comment and then click **Edit**.  
  
3.  In the console tree, right\-click the name of the Starter GPO and then click **Properties**.  
  
4.  Click the **Comment** tab.  
  
5.  Type your comments in the **Comment** box.  
  
6.  Click **OK**.  
  

