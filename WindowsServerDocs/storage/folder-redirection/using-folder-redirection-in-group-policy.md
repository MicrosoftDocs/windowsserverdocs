---
title: Using Folder Redirection in Group Policy
description: Learn how to use folder redirection in Group Policy
ms.topic: article
ms.author: robinharwood
author: wscontent
ms.date: 04/30/2023
---

# Using Folder Redirection in Group Policy

This article presents conceptual information about folder redirection and procedures using the GPMC.

Folder redirection enables you to redirect the location of specific folders within user profiles to a new location, such as a shared network location. Folder redirection is used in the process of administering user profiles and roaming user profiles. You can configure Folder redirection using the Group Policy Management Console to redirect specific user profile folders, and edit Folder redirection policy settings.

## Overview

User settings and user files are typically stored in the local user profile, under the **Users** folder. The files in local user profiles can be accessed only from the current computer; this makes it difficult for users who use more than one computer to work with their data and synchronize settings between multiple computers. Two technologies exist to address this problem: Roaming Profiles and Folder Redirection. Both technologies have their advantages, and they can be used separately or together to create a seamless user experience from one computer to another. They also provide more options for administrators managing user data.

Folder Redirection lets administrators redirect the path of a folder to a new location. The location can be a folder on the local computer or a directory on a network file share. Users can work with documents on a server as if the documents were based on a local drive. The documents in the folder are available to the user from any computer on the network. Folder Redirection is located under **Windows Settings** in the console tree when you edit domain-based Group Policy by using the Group Policy Management Console (GPMC). The path is `<Group Policy Object Name>\User Configuration\Policies\Windows Settings\Folder Redirection`.

## Folders that can be redirected

You can use the GPMC to redirect the following folders:

- **AppData/Roaming**

- **Contacts**

- **Desktop**

- **Documents**

- **Downloads**

- **Favorites**

- **Links**

- **Music**

- **Pictures**

- **Saved Games**

- **Searches**

- **Start Menu**

- **Videos**

## Advantages of Folder Redirection

There are several distinct advantages to using folder redirection. For example, even if users sign in to different computers on the network, their data is always available.

Additionally, Offline File technology (on by default) gives users access to the folder even when they aren't connected to the network. Using Offline Files is especially useful for people who use portable computers.

Folder redirection enables data that is stored in a network folder to be backed up as part of routine system administration. This is safer because it requires no action by the user.

If you use Roaming User Profiles, you can use Folder Redirection to reduce the total size of your Roaming Profile and make the sign in and sign out process more efficient for the end-user. When you deploy Folder Redirection with Roaming User Profiles, the data synchronized with Folder Redirection isn't part of the roaming profile and is synchronized in the background by using Offline Files after the user has logged on. Therefore, the user doesn't have to wait for this data to be synchronized when they sign in or sign out as is the case with Roaming User Profiles.

Folder redirection enables data that's specific to a user to be redirected to a different hard disk on the user's local computer from the hard disk that holds the operating system files. Folder redirection makes the user's data safer in case the operating system has to be reinstalled.

Finally, as an administrator, you can use Group Policy to set disk quotas, limiting how much space user profile folders will use.

## Selecting a Folder Redirection target

The **Target** tab of the folder's **Properties** box enables you to select the location of the redirected folder on a network or in the local user profile. You can choose between the following settings:

- **Basic—Redirect everyone's folder to the same location**. This setting enables you to redirect everyone's folder to the same location and is applied to all users included in the Group Policy Object. For this setting, you have the following options in specifying a target folder location:

  - **Create a folder for each user under the root path**. This option creates a folder in the form `\\server\share\User Account Name\Folder Name`. Each user has a unique path for their redirected folder.

- **Redirect to the following location**. This option uses an explicit path for the redirection location. This can cause multiple users to share the same path for the redirected folder.

- **Redirect to the local user profile location**. This option moves the location of the folder to the local user profile under the **Users** folder.

- **Advanced—Specify locations for various user groups**. This setting enables you to specify redirection behavior for the folder based on the security group memberships for the GPO.

- **Not configured**. This is the default setting. This setting specifies that policy-based folder redirection was removed for that GPO. All folders are redirected to the local user profile location or remain where they're based on the redirection options selected. No changes are made to the current folder location.

## Configuring other settings for the redirected folder

In the **Settings** tab in the **Properties** box for a folder, you can enable the following settings.

- **Grant the user exclusive rights**. This setting is enabled by default and is a recommended setting. This setting specifies that the administrator and other users don't have permissions to access this folder.

- **Move the contents of `<FolderName>` to the new location**. This setting moves all the data the user has in the local folder to the shared folder on the network.

- **Policy Removal**. The following table summarizes the behavior of redirected folders and their contents when the GPO no longer applies, based on your selections for policy removal. The following policy removal options are available in the **Settings** tab, under **Policy Removal**.

| Policy removal option | Selected setting | Result |
| ----- | ----- | ----- |
| Redirect the folder back to the user profile location when policy is removed | Enabled | <li>The folder returns to its user profile location.
<li>The contents are copied, not moved, back to the user profile location.
<li>The contents aren't deleted from the redirected location.
<li>The user continues to have access to the contents, but only on the local computer. |
| Redirect the folder back to the user profile location when policy is removed | Disabled |
<li>The folder returns to its user profile location.
<li>The contents aren't copied or moved to the user profile location.
<li>Note: If the contents of a folder aren't copied to the user profile location, the user can't see them. |
| Leave the folder in the new location when policy is removed | Either Enabled or *Disabled |
<li>The folder remains at its redirected location.
<li>The contents remain at the redirected location.
<li>The user continues to have access to the contents at the redirected folder. |

## How to specify the location of folders in a user profile

You can use Group Policy to specify another location (in other words, "redirect" the location) for folders within user profiles. You can redirect folders either to one location for everyone or to different locations based on the security group membership of users. You can also configure other settings for the redirected folder. The settings that you can configure include: 

- Granting exclusive user rights to the folder 
- Moving the contents of the folder to the new location
- Applying redirection policy to earlier Windows operating systems
- Specifying system behavior if the policy is removed

### To specify the location of folders in a user profile

1. In the GPMC console tree, right-select the Group Policy Object that is linked to the site, domain, or organizational unit that contains the users whose user profile folders you want to redirect, and then select **Edit**.

1. In the Group Policy Management Editor window, right-select the user profile folder that you want to redirect. The path of the user profile folder is **User Configuration\\Policies\\Windows Settings\\Folder Redirection\\UserProfileFolderName**

1. In the **Target** tab, under **Set.tings**, choose one of the following settings, follow the steps for that setting, and then select **OK**:

    **Basic—Redirect everyone's folder to the same location** 

    1. Under **Target folder location**, select a location.

    1. If you want to redirect the folder to a specific location, select **Create a folder for each user under the root path** or **Redirect to the following location**, and then select **Browse** to specify a location.

    1. If you want to specify more redirection settings for the folder, select the **Settings** tab to configure any of the following settings, and then select **OK**:

      - Grant the user exclusive rights to the folder (selected by default).

      - Move the contents of the folder to the new location (selected by default).

      - Specify policy removal settings (**Leave the folder in the new location when policy is removed** is selected by default).

### Advanced—Specify locations for various user groups

Use the following procedure to specify location for any user group. 

1. Under **Security Group Membership**, select **Add**.

1. Under **Security Group Membership**, select **Browse** to find the security group.

1. Under **Target folder location**, select a location.

1. If you want to redirect the folder to a specific location, select **Create a folder for each user under the root path** or **Redirect to the following location**, and then select **Browse** to specify a location.

1. If you want to specify more redirection settings for the folder, select the **Settings** tab to configure any of the following settings, and then select **OK**:

- **Grant the user exclusive rights to \[FolderName\]** (selected by default).

- **Move the contents of \[FolderName\] to the new location** (selected by default).

- Specify **Policy Removal** settings (**Leave the folder in the new location when policy is removed** is selected by default).

    **Follow the documents folder**

    **Not configured**

    This is the default setting. No changes are made to the current location of this folder.

    **Additional considerations**

      - You can also use the GPMC to configure the following Folder Redirection policy settings:

          - **Use localized subfolder names when redirecting Start and My Documents**—This policy is located in the following paths: **Computer Configuration\\Policies\\Administrative Templates\\System\\Folder Redirection**, or **User Configuration\\Policies\\Administrative Templates\\System\\Folder Redirection**.

          - **Do not automatically make redirected folders available offline**—This policy is located in the following path: **User Configuration\\Policies\\Administrative Templates\\System\\Folder Redirection**.

      - For more information about User Profiles and Folder Redirection, see [https://go.microsoft.com/fwlink/?LinkId=66003](https://go.microsoft.com/fwlink/?linkid=66003).