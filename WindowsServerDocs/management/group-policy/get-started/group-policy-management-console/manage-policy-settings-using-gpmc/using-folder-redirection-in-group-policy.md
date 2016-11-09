---
title: Using Folder Redirection in Group Policy
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd8ecd23-db37-4db7-a5bc-ba7bdac086e4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using Folder Redirection in Group Policy

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic presents conceptual information about folder redirection and procedures using the GPMC.

Folder Redirection enables you to redirect the location of specific folders within user profiles to a new location, such as a shared network location. Folder redirection is used in the process of administering user profiles and roaming user profiles. You can configure Folder Redirection using the Group Policy Management Console to redirect specific user profile folders, as well as edit Folder Redirection policy settings.

## Overview
User settings and user files are typically stored in the local user profile, under the **Users** folder. The files in local user profiles can be accessed only from the current computer, which makes it difficult for users who use more than one computer to work with their data and synchronize settings between multiple computers. Two technologies exist to address this problem: Roaming Profiles and Folder Redirection. Both technologies have their advantages, and they can be used separately or together to create a seamless user experience from one computer to another. They also provide additional options for administrators managing user data.

Folder Redirection lets administrators redirect the path of a folder to a new location. The location can be a folder on the local computer or a directory on a network file share. Users can work with documents on a server as if the documents were based on a local drive. The documents in the folder are available to the user from any computer on the network. Folder Redirection is located under **Windows Settings** in the console tree when you edit domain-based Group Policy by using the Group Policy Management Console (GPMC). The path is **[Group Policy Object Name]\User Configuration\Policies\Windows Settings\Folder Redirection**.

### Folders that can be redirected
You can use the GPMC to redirect the following folders:

-   **AppData/Roaming**

-   **Contacts**

-   **Desktop**

-   **Documents**

-   **Downloads**

-   **Favorites**

-   **Links**

-   **Music**

-   **Pictures**

-   **Saved Games**

-   **Searches**

-   **start Menu**

-   **Videos**

### Advantages of Folder Redirection

-   Even if users log on to different computers on the network, their data is always available.

-   offline File technology (which is turned on by default) gives users access to the folder even when they are not connected to the network. This is especially useful for people who use portable computers.

-   Data that is stored in a network folder can be backed up as part of routine system administration. This is safer because it requires no action by the user.

-   if you use Roaming User Profiles, you can use Folder Redirection to reduce the total size of your Roaming Profile and make the user logon and logoff process more efficient for the end-user. When you deploy Folder Redirection with Roaming User Profiles, the data synchronized with Folder Redirection is not part of the roaming profile and is synchronized in the background by using offline Files after the user has logged on. Therefore, the user does not have to wait for this data to be synchronized when they log on or log off as is the case with Roaming User Profiles.

-   Data that is specific to a user can be redirected to a different hard disk on the user's local computer from the hard disk that holds the operating system files. This makes the user's data safer in case the operating system has to be reinstalled.

-   As an administrator, you can use Group Policy to set disk quotas, limiting how much space is taken up by user profile folders.

## selecting a Folder Redirection target
The **Target** tab of the folder's **Properties** box enables you to select the location of the redirected folder on a network or in the local user profile. You can choose between the following settings:

-   **Basic Redirect everyone's folder to the same location**. This setting enables you to redirect everyone's folder to the same location and is applied to all users included in the Group Policy Object. For this setting, you have the following options in specifying a target folder location:

    -   **create a folder for each user under the root path**. This option creates a folder in the form **\\\server\share\User Account Name\Folder Name**. Each user has a unique path for their redirected folder.

-   **Redirect to the following location**. This option uses an explicit path for the redirection location. This can cause multiple users to share the same path for the redirected folder.

-   **Redirect to the local user profile location**. This option moves the location of the folder to the local user profile under the **Users** folder.

-   **Advanced Specify locations for various user groups**. This setting enables you to specify redirection behavior for the folder based on the security group memberships for the GPO.

-   **Not configured**. This is the default setting. This setting specifies that policy-based folder redirection was removed for that GPO and the folders are redirected to the local user profile location or stay where they are based on the redirection options selected if any existing redirection policies were set. No changes are being made to the current location of this folder.

## Configuring additional settings for the redirected folder
In the **Settings** tab in the **Properties** box for a folder, you can enable these settings:

-   **Grant the user exclusive rights**. This setting is enabled by default and is a recommended setting. This setting specifies that the administrator and other users do not have permissions to access this folder.

-   **move the contents of [FolderName] to the new location**. This setting moves all the data the user has in the local folder to the shared folder on the network.

-   **Policy removal**. The following table summarizes the behavior of redirected folders and their contents when the GPO no longer applies, based on your selections for policy removal. The following policy removal options are available in the **Settings** tab, under **Policy removal**.

|Policy removal option|selected setting|Result|
|-------------|----------|-----|
|**Redirect the folder back to the user profile location when policy is removed**|**Enabled**|-   The folder returns to its user profile location.<br />-   The contents are copied, not moved, back to the user profile location.<br />-   The contents are not deleted from the redirected location.<br />-   The user continues to have access to the contents, but only on the local computer.|
|**Redirect the folder back to the user profile location when policy is removed**|**Disabled**|-   The folder returns to its user profile location.<br />-   The contents are not copied or moved to the user profile location. **Note:** if the contents of a folder are not copied to the user profile location, the user cannot see them.|
|**Leave the folder in the new location when policy is removed**|Either **Enabled** or **Disabled**|-   The folder remains at its redirected location.<br />-   The contents remain at the redirected location.<br />-   The user continues to have access to the contents at the redirected folder.|

## How to specify the location of folders in a user profile
You can use Group Policy to specify another location (in other words, "redirect" the location) for folders within user profiles. You can redirect folders either to one location for everyone or to different locations based on the security group membership of users. You can also configure additional settings for the redirected folder. The settings that you can configure include whether to grant exclusive user rights to the folder, move the contents of the folder to the new location, apply redirection policy to earlier Windows operating systems, or specify system behavior if the policy is removed.

#### To specify the location of folders in a user profile

1.  In the GPMC console tree, right-click the Group Policy Object that is linked to the site, domain, or organizational unit that contains the users whose user profile folders you want to redirect, and then click **edit**.

2.  In the Group Policy Management editor window, right-click the user profile folder that you want to redirect. The path of the user profile folder is **User Configuration\Policies\Windows Settings\Folder Redirection\UserProfileFolderName**

3.  In the **Target** tab, under **Settings**, choose one of the following settings, follow the steps for that setting, and then click **OK**:

    **Basic Redirect everyone's folder to the same location**

    1.  Under **Target folder location**, select a location.

    2.  if you want to redirect the folder to a specific location, select **create a folder for each user under the root path** or **Redirect to the following location**, and then click **Browse** to specify a location.

    3.  if you want to specify additional redirection settings for the folder, click the **Settings** tab to configure any of the following settings, and then click **OK**:

    -   Grant the user exclusive rights to the folder (selected by default).

    -   move the contents of the folder to the new location (selected by default).

    -   Specify policy removal settings (**Leave the folder in the new location when policy is removed** is selected by default).

    **Advanced Specify locations for various user groups**

    1.  Under **Security Group Membership**, click **add**.

    2.  Under **Security Group Membership**, click **Browse** to find the security group.

    3.  Under **Target folder location**, select a location.

    4.  if you want to redirect the folder to a specific location, select **create a folder for each user under the root path** or **Redirect to the following location**, and then click **Browse** to specify a location.

    5.  if you want to specify additional redirection settings for the folder, click the **Settings** tab to configure any of the following settings, and then click **OK**:

    -   **Grant the user exclusive rights to [FolderName]** (selected by default).

    -   **move the contents of [FolderName] to the new location** (selected by default).

    -   Specify **Policy removal** settings (**Leave the folder in the new location when policy is removed** is selected by default).

    **Follow the documents folder**

    **Not configured**

    This is the default setting. No changes are made to the current location of this folder.

    **additional considerations**

    -   You can also use the GPMC to configure the following Folder Redirection policy settings:

        -   **Use localized subfolder names when redirecting start and My Documents** This policy is located in the following paths: **computer Configuration\Policies\Administrative Templates\System\Folder Redirection**, or **User Configuration\Policies\Administrative Templates\System\Folder Redirection**.

        -   **Do not automatically make redirected folders available offline** This policy is located in the following path: **User Configuration\Policies\Administrative Templates\System\Folder Redirection**.

    -   for more information about User Profiles and Folder Redirection, see [http://go.microsoft.com/fwlink/?LinkId=66003](http://go.microsoft.com/fwlink/?LinkId=66003).


