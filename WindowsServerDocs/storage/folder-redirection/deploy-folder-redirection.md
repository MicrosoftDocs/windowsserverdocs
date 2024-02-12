---
title: Deploy Folder Redirection with Offline Files
description: Learn how to deploy Folder Redirection and Offline Files together, including the steps needed to control access to the redirected files.
ms.topic: article
author: JasonGerend
ms.author: jgerend
ms.date: 03/20/2023
---

# Deploy Folder Redirection with Offline Files

> **Applies To:** Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, Windows Server 2016

This article describes the requirements for deploying Folder Redirection and Offline Files together, including the steps that you need to follow to control access to the redirected files.

<!-- >> [!IMPORTANT]
> Because of the security changes made in [MS16-072](https://support.microsoft.com/help/3163622/ms16-072-security-update-for-group-policy-june-14-2016), we updated [Step 4: Create a GPO for Folder Redirection](#step-4-create-a-gpo-for-folder-redirection) of this article so Windows can properly apply the Folder Redirection policy (and not revert redirected folders on affected client computers).

For a list of recent changes to this article, see [Change history](#change-history). -->

## Prerequisites

Before you begin, make sure your environment meets the following requirements.

### Administration requirements

- To administer Folder Redirection, you must be signed in as a member of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group.
- A computer must be available that has Group Policy Management and Active Directory Administration Center installed.

### File server requirements

The file server is the computer that hosts the redirected folders. Make sure your file server meets the following requirements.

#### Interoperability with Remote Desktop Services

Your remote access configuration affects how you configure the file server, file shares, and policies. If your file server also hosts Remote Desktop Services, there are a few deployment steps that differ.

- You don't have to create a security group for folder redirection users.
- You have to configure different permissions on the file share that hosts the redirected folders.
- You have to precreate folders for new users, and set specific permissions on those folders.

> [!IMPORTANT]  
> Most of the procedures in the rest of this section apply to both remote access configurations. The procedures or steps that are specific to one configuration or the other are labeled as such.

#### Restricting access

Apply the following changes to the file server, as appropriate for your configuration:

- **All configurations**: Make sure only required IT administrators have administrative access to the file server. The procedure in the next step configures access for the individual file shares.
- **Servers that don't also host Remote Desktop Services**: Disable the Remote Desktop Services service (`termserv`) on your file server if it's not also hosting Remote Desktop Services.

#### Interoperability with other storage features

To make sure Folder Redirection and Offline Files interact correctly with other storage features, check the following configurations.

- If the file share uses DFS Namespaces, the DFS folders (links) must have a single target to prevent users from making conflicting edits on different servers.
- If the file share uses DFS Replication to replicate the contents with another server, users must be able to access only the source server to prevent users from making conflicting edits on different servers.
- When using a clustered file share, disable continuous availability on the file share to avoid performance issues with Folder Redirection and Offline Files. When continuous availability is enabled, Offline Files might not transition to offline mode for 3-6 minutes after a user loses access to the file share. The delay could frustrate users who aren’t yet using the Always Offline mode of Offline Files.

### Client requirements

- Client computers must run Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, or Windows Server 2016.
- Client computers must be joined to the Active Directory Domain Services (AD DS) domain that you're managing.
- Client computers must run x64-based or x86-based processors. Folder Redirection isn't supported on PCs powered by ARM processors.

> [!IMPORTANT]  
> Some newer features in Folder Redirection have additional client computer and Active Directory schema requirements. For more information, see [Deploy primary computers for Folder Redirection and Roaming User Profiles](deploy-primary-computers.md), [Disable Offline Files on individual redirected folders](disable-offline-files-on-folders.md), [Enable Always Offline mode for faster access to files](enable-always-offline.md), and [Enable optimized moves of redirected folders](enable-optimized-moving.md).

## Step 1: Create a folder redirection security group

If you're running Remote Desktop Services on the file server, skip this step. Instead, assign permissions to the users when you precreate folders for new users.

This procedure creates a security group that contains all users to which you want to apply Folder Redirection policy settings.

1. On a computer that has Active Directory Administration Center installed, open Server Manager.
1. Select **Tools** > **Active Directory Administration Center**. Active Directory Administration Center appears.
1. Right-click the appropriate domain or OU, and then select **New** > **Group**.
1. In the **Create Group** window, in the **Group** section, specify the following settings:

   - In **Group name**, enter the name of the security group, for example: **Folder Redirection Users**.
   - In **Group scope**, select **Security** > **Global**.

1. In the **Members** section, select **Add**. The **Select Users, Contacts, Computers, Service Accounts or Groups** dialog box appears.
1. Enter the names of the users or groups to which you want to deploy Folder Redirection, select **OK**, and then select **OK** again.

## Step 2: Create a file share for redirected folders

If you don't already have a file share for redirected folders, use the following procedure to create a file share on a server that runs Windows Server 2016 or a later version.

> [!NOTE]  
> Some functionality might differ or be unavailable if you create the file share on a server that runs a different version of Windows Server.

1. In the Server Manager navigation pane, select **File and Storage Services** > **Shares** to display the **Shares** page.
1. In the **Shares** page, select **Tasks** > **New Share**. The New Share Wizard appears.
1. On the **Select Profile** page, choose the option that corresponds to your File Server Resource Manager configuration:

   - If you have File Server Resource Manager installed and are using folder management properties, select **SMB Share - Advanced**.
   - If you don't have File Server Resource Manager installed or you aren't using folder management properties, select **SMB Share – Quick**.

1. On the **Share Location** page, select the server and volume on which you want to create the share.
1. On the **Share Name** page, enter a name for the share (for example, `Users$`) in the **Share name** box.

   > [!TIP]  
   > When you create the share, hide the share by putting a `$` (dollar sign) after the share name. This change hides the share from casual browsers.

1. On the **Other Settings** page, clear the **Enable continuous availability** checkbox, if present. Optionally, select the **Enable access-based enumeration** and **Encrypt data access** checkboxes.
1. On the **Permissions** page, select **Customize permissions** to open the **Advanced Security Settings** dialog box.
1. Select **Disable inheritance**, and then select **Convert inherited permissions into explicit permission on this object**.
1. Set the permissions as described in the following tables and figures.

   > [!IMPORTANT]  
   > The permissions that you use depend on your remote access configuration, so make sure you use the correct table.

   - **Permissions for file servers without Remote Desktop Services**  
  
      |User Account |Permission |Applies to |
      | --- | --- | --- |
      |System |Full Control |This folder, subfolders, and files |
      |Administrators |Full Control |This folder only |
      |Creator/Owner |Full Control |Subfolders and files only |
      |Security group of users who need to put data on the share (Folder Redirection Users) |List folder/read data<sup>1</sup><br />Create&nbsp;folders/append data<sup>1</sup><br />Read attributes<sup>1</sup><br />Read extended attributes<sup>1</sup><br />Read permissions<sup>1</sup><br />Traverse folder/execute file<sup>1</sup> |This&nbsp;folder&nbsp;only |
      |Other groups and accounts |None (Remove any accounts that this table doesn't list) | |

      *<sup>1</sup> Advanced permissions*

      :::image type="content" source=".\media\deploy-folder-redirection\setting-the-permissions-for-the-redirected-folders-share.png" alt-text="Screenshot of the advanced permissions page showing the permissions configuration for the separate server configuration.":::

   - **Permissions for file servers with Remote Desktop Services**  
  
      |User Account or Role |Permission |Applies to |
      | --- | --- | --- |
      |System |Full Control |This folder, subfolders, and files |
      |Administrators |Full Control |This folder, subfolders, and files |
      |Creator/Owner |Full Control |Subfolders and files only |
      |Other groups and accounts |None (remove any other accounts from the access control list) | |

      :::image type="content" source=".\media\deploy-folder-redirection\co-located-config-folder-redirect-perms.png" alt-text="Screenshot of the advanced permissions page showing the permissions configuration for the colocated server configuration.":::

1. If you chose the **SMB Share - Advanced** profile earlier in this procedure, follow these extra steps:

    - On the **Management Properties** page, select the **User Files** Folder Usage value.
    - Optionally, select a quota to apply to users of the share.

1. On the **Confirmation** page, select **Create.**

## Step 3: Precreate folders for new users on servers that also host Remote Desktop Services

If the file server also hosts Remote Desktop Services, use the following procedure to precreate folders for new users and assign the appropriate permissions to the folders.

1. In the file share that you created in the previous procedure, navigate to the file share's root folder.
1. Use one of the following methods to create a new folder.

   - Right-click the root folder, and then select **New** > **Folder**. For the name of the folder, enter the user name of the new user.
   - Alternatively, to use Windows PowerShell to create the new folder, open a PowerShell Command Prompt window and run the following cmdlet:

     ```powershell
      New-Item -Path 'c:\shares\frdeploy\<newuser>' -ItemType Directory
     ```

     In this command, \<*newuser*> represents the user name of the new user.

1. Right-click the new folder, and then select **Properties** > **Security** > **Advanced** > **Owner**. Verify that the folder owner is the Administrators group.
1. Set the permissions as described in the following table and figure. Remove permissions for any groups and accounts that aren't listed here.  
  
   |User Account |Permission |Applies to |
   | --- | --- | --- |
   |System |Full control |This folder, subfolders, and files |
   |Administrators |Full Control |This folder, subfolders, and files |
   |Creator/Owner |Full Control |Subfolders&nbsp;and files only |
   |*newuser*<sup>1</sup> |Full Control |This folder, subfolders, and files |
   |Other groups and accounts |None (remove any other accounts from the access control list) | |

   <sup>1</sup> *newuser* represents the user name of the new user's account.  

   :::image type="content" source=".\media\deploy-folder-redirection\co-located-config-folder-redirect-perms-newuser.png" alt-text="Screenshot of setting the permissions for a new user’s folder under the root of the Folder Redirection share.":::

## Step 4: Create a GPO for Folder Redirection

If you don't already have a Group Policy object (GPO) that manages the Folder Redirection and Offline Files functionality, use the following procedure to create one.

1. On a computer that has Group Policy Management installed, open Server Manager.
1. Select **Tools** > **Group Policy Management**.
1. In Group Policy Management, right-click the domain or OU in which you want to set up Folder Redirection, and then select **Create a GPO in this domain, and Link it here**.
1. In the **New GPO** dialog box, enter a name for the GPO (for example, **Folder Redirection Settings**), and then select **OK**.
1. Right-click the newly created GPO, and then clear the **Link Enabled** checkbox. This change prevents the GPO from being applied until you finish configuring it.
1. Select the GPO. Select **Scope** > **Security Filtering** > **Authenticated Users**, and then select **Remove** to prevent the GPO from being applied to everyone.
1. In the **Security Filtering** section, select **Add**.
1. In the **Select User, Computer, or Group** dialog box, configure the option that corresponds to your configuration:
   - **File servers without Remote Desktop Services**: Enter the name of the security group that you created in [Step 1: Create a folder redirection security group](#step-1-create-a-folder-redirection-security-group) (for example, Folder Redirection Users), and then select **OK**.
   - **File servers with Remote Desktop Services**: Enter the user name that you used for the user folder in [Step 3: Precreate folders for new users on servers that also host Remote Desktop Services](#step-3-precreate-folders-for-new-users-on-servers-that-also-host-remote-desktop-services) and then select **OK**.

1. Select **Delegation** > **Add**, and then enter **Authenticated Users**. Select **OK**, and then select **OK** again to accept the default **Read** permission.

   > [!IMPORTANT]  
   > This step is necessary because of security changes made in [MS16-072](https://support.microsoft.com/help/3163622/ms16-072-security-update-for-group-policy-june-14-2016). You must give the Authenticated Users group delegated Read permissions to the Folder Redirection GPO. If you don't, the GPO isn't applied to users, or if it's already applied, the GPO is removed, redirecting folders back to the local PC. For more information, see [Deploying Group Policy Security Update MS16-072](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/deploying-group-policy-security-update-ms16-072-kb3163622/ba-p/400434).

## Step 5: Configure the Group Policy settings for Folder Redirection and Offline Files

After you create a GPO for Folder Redirection settings, follow these steps to edit the Group Policy settings that enable and configure Folder Redirection.

> [!NOTE]  
> By default, the Offline Files feature is enabled for redirected folders on Windows client computers, and disabled on Windows Server computers. Users can enable this feature, or you can use Group Policy to control it. The policy is **Allow or disallow use of the Offline Files feature**.  
>
> For information about some of the other Offline Files Group Policy settings, see [Enable Advanced Offline Files Functionality](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn270369(v=ws.11)), and [Configuring Group Policy for Offline Files](/previous-versions/windows/it-pro/windows-server-2003/cc759721(v=ws.10)).

1. In Group Policy Management, right-click the GPO you created (for example, **Folder Redirection Settings**), and then select **Edit**.
1. In the Group Policy Management Editor window, navigate to **User Configuration** > **Policies** > **Windows Settings** > **Folder Redirection**.
1. Right-click a folder that you want to redirect (for example, **Documents**), and then select **Properties**.
1. In the **Properties** dialog box, from the **Settings** box, select **Basic - Redirect everyone’s folder to the same location**.

    (Optional) In the **Policy Removal** section, select **Redirect the folder back to the local userprofile location when the policy is removed**. This setting can help make Folder Redirection behave more predictably for administrators and users.

1. In the **Target folder location** section, select **Create a folder for each user under the root path**.
1. In the **Root Path** box, enter the path to the file share that stores the redirected folders, such as `\\fs1.corp.contoso.com\users$`.
1. Select **OK**, and then select **Yes** in the **Warning** dialog box.

## Step 6: Enable the Folder Redirection GPO

After you finish configuring the Folder Redirection Group Policy settings, the next step is to enable the GPO. This change allows the GPO to be applied to affected users.

> [!TIP]  
> If you plan to implement primary computer support or other policy settings, do so now, before you enable the GPO. Implementing these settings prevents user data from being copied to non-primary computers before primary computer support is enabled.

1. Open Group Policy Management.
1. Right-click the GPO that you created, and then select **Link Enabled**. A checkbox appears next to the menu item.

## Step 7: Test Folder Redirection

To test Folder Redirection, sign in to a computer by using a user account that is configured to use redirected folders. Then confirm that the folders and profiles are redirected.

1. Sign in to a primary computer (if you enabled primary computer support) by using a user account for which you have enabled Folder Redirection.
1. If the user has previously signed in to the computer, open an elevated command prompt, and then enter the following command to ensure that the latest Group Policy settings are applied to the client computer:

   ```console
   gpupdate /force
   ```

1. Open File Explorer.
1. Right-click a redirected folder (for example, the My Documents folder in the Documents library), and then select **Properties**.
1. Select the **Location** tab, and confirm that the path displays the file share you specified instead of a local path.

## Appendix A: Checklist for deploying Folder Redirection

|Complete |Task or item |
| - | - |
| |**Prepare domain and other prerequisites** |
| |- Join computers to domain |
| |- Create user accounts |
| |- Check file server prerequisites and compatibility with other services |
| |- Does the file server also host Remote Desktop Services? |
| |- Restrict access to the file server |
| |**Step 1: Create a folder redirection security group** |
| |- Group name: |
| |- Members: |
| |**Step 2: Create a file share for redirected folders** |
| |- File share name: |
| |**Step 3: Precreate folders for new users on servers that also host Remote Desktop Services** |
| |**Step 4: Create a GPO for Folder Redirection** |
| |- GPO name: |
| |**Step 5: Configure the Group Policy settings for Folder Redirection and Offline Files** |
| |- Redirected folders: |
| |- Windows 2000, Windows XP, and Windows Server 2003 support enabled? |
| |- Offline Files enabled? (enabled by default on Windows client computers) |
| |- Always Offline Mode enabled? |
| |- Background file synchronization enabled? |
| |- Optimized Move of redirected folders enabled? |
| |(Optional) Enable primary computer support: |
| |- Computer-based or User-based? |
| |- Designate primary computers for users |
| |- Location of user and primary computer mappings: |
| |- (Optional) Enable primary computer support for Folder Redirection |
| |- (Optional) Enable primary computer support for Roaming User Profiles |
| |**Step 6: Enable the Folder Redirection GPO** |
| |**Step 7: Test Folder Redirection** |

<!-- ## Change history

The following table summarizes some of the most important changes to this article.

|Date |Description |Reason |
| --- | --- | --- |
|March 9, 2021 |Added instructions for different configurations. |Changes required to improve access control in different configurations. |
|January 18, 2017 |Added a step to [Create a GPO for Folder Redirection](#step-4-create-a-gpo-for-folder-redirection) to delegate Read permission to Authenticated Users, which is now required because of a Group Policy security update. |Customer feedback. |
-->
## Related links

- [Folder Redirection, Offline Files, and Roaming User Profiles overview](folder-redirection-rup-overview.md)
- [Deploy primary computers for Folder Redirection and Roaming User Profiles](deploy-primary-computers.md)
- [Enable Always Offline mode for faster access to files](enable-always-offline.md)
- [Information about Microsoft support policy for a DFS-R and DFS-N deployment scenario](/troubleshoot/windows-server/networking/support-policy-for-dfsr-dfsn-deployment)
- [Sideload Apps with DISM](/windows-hardware/manufacture/desktop/sideload-apps-with-dism-s14)
- [Troubleshooting packaging, deployment, and query of Windows apps](/windows/win32/appxpkg/troubleshooting)
