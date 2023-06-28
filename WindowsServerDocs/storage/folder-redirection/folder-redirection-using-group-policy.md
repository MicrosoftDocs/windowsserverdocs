---
title: Folder Redirection using Group Policy on Windows Server
description: Learn about using Group Policy to configure Folder Redirection on Windows Server 
ms.topic: conceptual
ms.author: wscontent
author: robinharwood
ms.date: 05/19/2023
---

# Folder Redirection using Group Policy

Folder Redirection lets administrators redirect the path of a folder to a new location. You can use Group Policy to configure these locations. The location can be a folder on the local computer or a directory on a network file share. Folder Redirection is located under **Windows Settings** in the console tree when you edit domain-based Group Policy by using the Group Policy Management Console (GPMC). The path is `<Group Policy Object Name>\User Configuration\Policies\Windows Settings\Folder Redirection`.

To learn more about Folder Redirection, see [Folder Redirection, Offline Files, and Roaming User Profiles overview](folder-redirection-rup-overview.md).

## Folders that can be redirected

You can use the GPMC to redirect the following folders:

- AppData/Roaming

- Contacts

- Desktop

- Documents

- Downloads

- Favorites

- Links

- Music

- Pictures

- Saved Games

- Searches

- Start Menu

- Videos

## Selecting a Folder Redirection target

The **Target** tab of the folder's **Properties** box enables you to select the location of the redirected folder on a network or in the local user profile. You can choose between the following settings:

- **Basic—Redirect everyone's folder to the same location**. This setting enables you to redirect everyone's folder to the same location and is applied to all users included in the Group Policy Object. For this setting, you have the following options in specifying a target folder location:

  - **Create a folder for each user under the root path**. This option creates a folder in the form `\\server\share\User Account Name\Folder Name`. Each user has a unique path for their redirected folder.

- **Redirect to the following location**. This option uses an explicit path for the redirection location. This can cause multiple users to share the same path for the redirected folder.

- **Redirect to the local user profile location**. This option moves the location of the folder to the local user profile under the **Users** folder.

- **Advanced—Specify locations for various user groups**. This setting enables you to specify redirection behavior for the folder based on the security group memberships for the GPO.

- **Not configured**. This option is the default setting. This setting specifies that policy-based folder redirection was removed for that GPO. All folders are redirected to the local user profile location or remain where they're based on the redirection options selected. No changes are made to the current folder location.

## Configuring other settings for the redirected folder

In the **Settings** tab in the **Properties** box for a folder, you can enable the following settings.

- **Grant the user exclusive rights**. This setting is enabled by default and is a recommended setting. This setting specifies that the administrator and other users don't have permissions to access this folder.

- **Move the contents of `<FolderName>` to the new location**. This setting moves all the data the user has in the local folder to the shared folder on the network.

  > [!CAUTION]
  > Moving all data can take a large amount of time, depending on the speed of the connection and
  > volume of data. The time to move all data could be significant if both locations are remote. You
  > might also notice a delay when pinning and unpinning files in remote locations, as the file
  > needs to sync between the cache and the file share.

- **Policy Removal**. The following table summarizes the behavior of redirected folders and their contents when the GPO no longer applies, based on your selections for policy removal. The following policy removal options are available in the **Settings** tab, under **Policy Removal**.

| Policy removal option | Selected setting | Result |
| ----- | ----- | ----- |
| Redirect the folder back to the user profile location when policy is removed<sup>1</sup> | Enabled | - The folder returns to its user profile location.<br>- The contents are copied, not moved, back to the user profile location. <br>- The contents aren't deleted from the redirected location.<br>- The user continues to have access to the contents, but only on the local computer. |
| Leave the folder in the new location when policy is removed | Enabled | - The folder remains at its redirected location.<br>- The contents remain at the redirected location. <br>- The user continues to have access to the contents at the redirected folder. |

<sup>1</sup> Moving all data back to the user profile can take a large amount of time, depending on
the speed of the connection and volume of data. The time to move all data could be significant if
both locations are remote. You might also notice a delay when pinning and unpinning files in remote
locations, as the file needs to sync between the cache and the file share.

You can also use the GPMC to configure the following Folder Redirection policy settings:

- **Use localized subfolder names when redirecting Start and My Documents**. This policy is located in the following paths: `Computer Configuration\Policies\Administrative Templates\System\Folder Redirection`, or `User Configuration\Policies\Administrative Templates\System\Folder Redirection`.

- **Do not automatically make redirected folders available offline**. This policy is located in the following path: `User Configuration\Policies\Administrative Templates\System\Folder Redirection`.

## Specify the location of folders in a user profile

You can use Group Policy to specify another location (in other words, "redirect" the location) for folders within user profiles. You can redirect folders either to one location for everyone or to different locations based on the security group membership of users. You can also configure other settings for the redirected folder. The settings that you can configure include:

- Granting exclusive user rights to the folder.
- Moving the contents of the folder to the new location.
- Applying redirection policy to earlier Windows operating systems.
- Specifying system behavior if the policy is removed.

## Next steps

- [Deploy Folder Redirection with Offline Files](deploy-folder-redirection.md)