---
title: Deploy primary computers for Folder Redirection and Roaming User Profiles
description: How to enable primary computer support and designate primary computers for users with Folder Redirection and Roaming User Profiles.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 06/06/2019
ms.localizationpriority: medium
---
# Deploy primary computers for Folder Redirection and Roaming User Profiles

>Applies to: Windows 10, Windows 8, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012, Windows Server 2012 R2

This topic describes how to enable primary computer support and designate primary computers for users. Doing so enables you to control which computers use Folder Redirection and Roaming User Profiles.

> [!IMPORTANT]
> When enabling primary computer support for Roaming User Profiles, always enable primary computer support for Folder Redirection as well. This keeps documents and other user files out of the user profiles, which helps profiles remain small and sign on times stay fast.

## Prerequisites

## Software requirements

Primary computer support has the following requirements:

- The Active Directory Domain Services (AD DS) schema must be updated to include Windows Server 2012 schema additions (installing a Windows Server 2012 domain controller automatically updates the schema). For information about updating the AD DS schema, see [Adprep.exe integration](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh472161(v=ws.11)#adprepexe-integration>) and [Running Adprep.exe](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd464018(v=ws.10)>).
- Client computers must run Windows 10, Windows 8.1, Windows 8, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012.

> [!TIP]
> Although primary computer support requires Folder Redirection and/or Roaming User Profiles, if you are deploying these technologies for the first time, it is best to set up primary computer support before enabling the GPOs that configure Folder Redirection and Roaming User Profiles. This prevents user data from being copied to non-primary computers before primary computer support is enabled. For configuration information, see [Deploy Folder Redirection](deploy-folder-redirection.md) and [Deploy Roaming User Profiles](deploy-roaming-user-profiles.md).

## Step 1: Designate primary computers for users

The first step in deploying primary computers support is designating the primary computers for each user. To do so, use Active Directory Administration Center to obtain the distinguished name of the relevant computers and then set the **msDs-PrimaryComputer** attribute.

> [!TIP]
> To use Windows PowerShell to work with primary computers, see the blog post [Digging a little deeper into Windows 8 Primary Computer](<https://blogs.technet.microsoft.com/askds/2012/10/23/digging-a-little-deeper-into-windows-8-primary-computer/>).

Here's how to specify the primary computers for users:

1. Open Server Manager on a computer with Active Directory Administration Tools installed.
2. On the **Tools** menu, select **Active Directory Administration Center**. Active Directory Administration Center appears.
3. Navigate to the **Computers** container in the appropriate domain.
4. Right-click a computer that you want to designate as a primary computer and then select **Properties**.
5. In the Navigation pane, select **Extensions**.
6. Select the **Attribute Editor** tab, scroll to **distinguishedName**, select **View**, right-click the value listed, select **Copy**, select **OK**, and then select **Cancel**.
7. Navigate to the **Users** container in the appropriate domain, right-click the user to which you want to assign the computer, and then select **Properties**.
8. In the Navigation pane, select **Extensions**.
9. Select the **Attribute Editor** tab, select **msDs-PrimaryComputer** and then select **Edit**. The Multi-valued String Editor dialog box appears.
10. Right-click the text box, select **Paste**, select **Add**, select **OK**, and then select **OK** again.

## Step 2: Optionally enable primary computers for Folder Redirection in Group Policy

The next step is to optionally configure Group Policy to enable primary computer support for Folder Redirection. Doing so enables a user's folders to be redirected on computers designated as the user's primary computers, but not on any other computers. You can control primary computers for Folder Redirection on a per-computer basis, or a per-user basis.

Here's how to enable primary computers for Folder Redirection:

1. In Group Policy Management, right-click the GPO you created when doing the initial configuration of Folder Redirection and/or Roaming User Profiles (for example, **Folder Redirection Settings** or **Roaming User Profiles Settings**), and then select **Edit**.
2. To enable primary computers support using computer-based Group Policy, navigate to **Computer Configuration**. For user-based Group Policy, navigate to **User Configuration**.
    - Computer-based Group Policy applies primary computer processing to all computers to which the GPO applies, affecting all users of the computers.
    - User-based Group Policy to applies primary computer processing to all user accounts to which the GPO applies, affecting all computers to which the users sign on.
3. Under **Computer Configuration** or **User Configuration**, navigate to **Policies**, then **Administrative Templates**, then **System**, then **Folder Redirection**.
4. Right-click **Redirect folders on primary computers only**, and then select **Edit**.
5. Select **Enabled**, and then select **OK**.

## Step 3: Optionally enable primary computers for Roaming User Profiles in Group Policy

The next step is to optionally configure Group Policy to enable primary computer support for Roaming User Profiles. Doing so enables a user's profile to roam on computers designated as the user's primary computers, but not on any other computers.

Here's how to enable primary computers for Roaming User Profiles:

1. Enable primary computer support for Folder Redirection, if you haven't already.<br>This keeps documents and other user files out of the user profiles, which helps profiles remain small and sign on times stay fast.
2. In Group Policy Management, right-click the GPO you created (for example, **Folder Redirection and Roaming User Profiles Settings**), and then select **Edit**.
3. Navigate to **Computer Configuration**, then **Policies**, then **Administrative Templates**, then **System**, and then **User Profiles**.
4. Right-click **Download roaming profiles on primary computers only,** and then select **Edit**.
5. Select **Enabled**, and then select **OK**.

## Step 4: Enable the GPO

Once you have completed configuring Folder Redirection and Roaming User Profiles, enable the GPO if you have not already. Doing so permits it to be applied to affected users and computers.

Here's how to enable the Folder Redirection and/or Roaming User Profiles GPOs:

1. Open Group Policy Management
2. Right-click the GPOs that you created, and then select **Link Enabled**. A checkbox should appear next to the menu item.

## Step 5: Test primary computer function

To test primary computer support, sign in to a primary computer, confirm that the folders and profiles are redirected, then sign in to a non-primary computer and confirm that the folders and profiles are not redirected.

Here's how to test primary computer functionality:

1. Sign in to a designated primary computer with a user account for which you have enabled Folder Redirection and/or Roaming User Profiles.
2. If the user account has signed on to the computer previously, open a Windows PowerShell session or Command Prompt window as an administrator, type the following command and then sign off when prompted to ensure that the latest Group Policy settings are applied to the client computer:

    ```PowerShell
    Gpupdate /force
    ```

3. Open File Explorer.
1. Right-click a redirected folder (for example, the My Documents folder in the Documents library), and then select **Properties**.
1. Select the **Location** tab, and confirm that the path displays the file share you specified instead of a local path. To confirm that the user profile is roaming, open **Control Panel**, select **System and Security**, select **System**, select **Advanced System Settings**, select **Settings** in the User Profiles section and then look for **Roaming** in the **Type** column.
1. Sign in with the same user account to a computer that is not designated as the user's primary computer.
1. Repeat steps 2–5, instead looking for local paths and a **Local** profile type.

> [!NOTE]
> If folders were redirected on a computer before you enabled primary computer support, the folders will remain redirected unless the following setting is configured in each folder's folder redirection policy setting: **Redirect the folder back to the local userprofile location when the policy is removed**. Similarly, profiles that were previously roaming on a particular computer will show **Roaming** in the **Type** columns; however, the **Status** column will show **Local**.

## More information

- [Deploy Folder Redirection with Offline Files](deploy-folder-redirection.md)
- [Deploy Roaming User Profiles](deploy-roaming-user-profiles.md)
- [Folder Redirection, Offline Files, and Roaming User Profiles overview](folder-redirection-rup-overview.md)
- [Digging a little deeper into Windows 8 Primary Computer](https://blogs.technet.com/b/askds/archive/2012/10/23/digging-a-little-deeper-into-windows-8-primary-computer.aspx)