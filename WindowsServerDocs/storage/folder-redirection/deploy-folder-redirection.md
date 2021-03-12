---
title: Deploy Folder Redirection with Offline FilesDeploy Folder Redirection with Offline Files
description: This article describes the requirements for deploying the Folder Redirection and Offline Files features together, including the steps that you need to follow to control access to the redirected files.
ms.topic: article
author: JasonGerend
ms.author: jgerend
ms.date: 03/10/2021
ms.localizationpriority: medium
---

# Deploy Folder Redirection with Offline Files

> Applies to: Windows 10, Windows 7, Windows 8, Windows 8.1, Windows Vista, Windows Server 2019, Windows Server 2016, Windows Server 2012, Windows Server 2012 R2, Windows Server 2008 R2, Windows Server (Semi-annual Channel)

This article describes the requirements for deploying the Folder Redirection and Offline Files features together, including the steps that you need to follow to control access to the redirected files.

> [!IMPORTANT]
> Because of the security changes made in [MS16-072](https://support.microsoft.com/help/3163622/ms16-072-security-update-for-group-policy-june-14-2016)), we updated [Step 5: Create a GPO for Folder Redirection](#step-5-create-a-gpo-for-folder-redirection) of this article so that Windows can properly apply the Folder Redirection policy (and not revert redirected folders on affected client computers).

For a list of recent changes to this article, see [Change history](#change-history).

## Prerequisites

### Administration requirements

- To administer Folder Redirection, you must be signed in as a member of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group.
- A computer must be available that has Group Policy Management and Active Directory Administration Center installed.

### File server requirements

The file server is the computer that hosts the redirected folders.

> [!NOTE]  
> Folder Redirection requires that the file server be an x64-based or x86-based computer. Folder Redirection is not supported on PCs powered by ARM processors.  

#### Interoperability with Remote Desktop Services

Your remote access configuration affects how you configure the file server, file shares, and policies. You can configure one of two different scenarios:

- **Separate servers**. The most straightforward scenario is to use different computers for the file server and for Remote Desktop Services (RDS, also known as the Terminal Services).
- **Co-located servers**. In this scenario, a single computer functions as both the file server and RDS.

> [!IMPORTANT]  
> Most of the procedures in the rest of this section apply to both configurations. The procedures or steps that are specific to one configuration or the other are identified as *separate server* or *co-located server* procedures or steps.

#### Restrict access to the file server

Apply the following changes to the file server, as appropriate for your configuration:

- **All configurations.** Make sure that only required IT administrators have administrative access to the file server. The procedure in the next step configures access for the individual file shares.
- **Separate server configuration**. Disable the Remote Desktop Services service (termserv).

### Client requirements

- Client computers must run Windows 10, Windows 8.1, Windows 8, Windows 7, Windows Server 2019, Windows Server 2016, Windows Server (Semi-annual Channel), Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008.
- Client computers must be joined to the Active Directory Domain Services (AD DS) domain that you are managing.

> [!NOTE]  
> Some newer features in Folder Redirection have additional client computer and Active Directory schema requirements. For more info, see [Deploy primary computers](deploy-primary-computers.md), [Disable Offline Files on folders](disable-offline-files-on-folders.md), [Enable Always Offline mode](enable-always-offline.md), and [Enable optimized folder moving](enable-optimized-moving.md).

## <a id="ss-securitygroup"></a>Step 1 (Separate server configuration): Create a folder redirection security group

Use this procedure if you are using the separate server configuration (the file server and Remote Desktop Services run on separate computers).

This procedure creates a security group that contains all users to which you want to apply Folder Redirection policy settings.

1. On a computer that has Active Directory Administration Center installed, open Server Manager.
2. Select **Tools** > **Active Directory Administration Center**. Active Directory Administration Center appears.
3. Right-click the appropriate domain or OU, and then select **New** > **Group**.
4. In the **Create Group** window, in the **Group** section, specify the following settings:
   - In **Group name**, enter the name of the security group, for example: **Folder Redirection Users**.
   - In **Group scope**, select **Security** > **Global**.

5. In the **Members** section, select **Add**. The **Select Users, Contacts, Computers, Service Accounts or Groups** dialog box appears.
6. Enter the names of the users or groups to which you want to deploy Folder Redirection, select **OK**, and then select **OK** again.

## Step 2: Create a file share for redirected folders

If you do not already have a file share for redirected folders, use the following procedure to create a file share on a server that runs Windows Server 2012 or a later version.

> [!NOTE]  
> Some functionality might differ or be unavailable if you create the file share on a server that runs a different version of Windows Server.

1. In the Server Manager navigation pane, select **File and Storage Services** > **Shares** to display the **Shares** page.
2. In the **Shares** page, select **Tasks** > **New Share**. The New Share Wizard appears.
3. On the **Select Profile** page, do one of the following:
   - If you have File Server Resource Manager installed and are using folder management properties, select **SMB Share - Advanced**.
   - If you do not have File Server Resource Manager installed or you are not using folder management properties, select **SMB Share – Quick**.

4. On the **Share Location** page, select the server and volume on which you want to create the share.
5. On the **Share Name** page, type a name for the share (for example, **Users$**) in the **Share name** box.
   > [!TIP]  
   > When you create the share, hide the share by putting a `$` after the share name. This change hides the share from casual browsers.
6. On the **Other Settings** page, clear the **Enable continuous availability** checkbox, if present. Optionally, select the **Enable access-based enumeration** and **Encrypt data access** checkboxes.
7. On the **Permissions** page, select **Customize permissions** to open the **Advanced Security Settings** dialog box.
8. Select **Disable inheritance**, and then select **Convert inherited permissions into explicit permission on this object**.
9. Set the permissions as described in the following tables and figures.
   > [!IMPORTANT]  
   > The permissions that you use depend on your remote access configuration, so make sure that you use the correct table.

   - **Separate server configuration:**  
  
      |User Account |Permission |Applies to |
      | --- | --- | --- |
      |System |Full Control |This folder, subfolders, and files |
      |Administrators |Full Control |This folder only |
      |Creator/Owner |Full Control |Subfolders and files only |
      |Security group of users who need to put data on share (Folder Redirection Users) |List folder/read data<sup>1</sup><br />Create&nbsp;folders/append data<sup>1</sup><br />Read attributes<sup>1</sup><br />Read extended attributes<sup>1</sup><br />Read<sup>1</sup><br />Traverse folder/execute file<sup>1</sup> |This&nbsp;folder&nbsp;only |
      |Other groups and accounts |None (Remove any accounts that this table does not list) | |

      *<sup>1</sup> Advanced permissions*

      ![Advanced permissions page showing the permissions configuration for the separate server configuration.](.\media\deploy-folder-redirection\setting-the-permissions-for-the-redirected-folders-share.png)

   - **Co-located server configuration**  
  
      |User Account or Role |Permission |Applies to |
      | --- | --- | --- |
      |System |Full Control |This folder, subfolders, and files |
      |Administrators |Full Control |This folder, subfolders, and files |
      |Creator/Owner |Full Control |Subfolders and files only |
      |Other groups and accounts |None (remove any other accounts from the access control list) | |

      ![Advanced permissions page showing the permissions configuration for the co-located server configuration.](.\media\deploy-folder-redirection\co-located-config-folder-redirect-perms.png)
10. If you chose the **SMB Share - Advanced** profile earlier in this procedure, follow these additional steps:

    - On the **Management Properties** page, select the **User Files** Folder Usage value.
    - Optionally, select a quota to apply to users of the share.
11. On the **Confirmation** page, select **Create.**

## <a id="cls-usernames"></a>Step 3 (co-located server configuration): Pre-create the folders for new users

1. In the file share that you created in the previous procedure, navigate to the file share's root folder.
2. Create a new folder. You can use one of the following methods:
   - Right-click the root folder, and then select **New** > **Folder**. For the name of the folder, enter the user name of the new user.
   - Alternatively, to use Windows PowerShell to create the new folder, open a PowerShell Command Prompt window and run the following cmdlet:

     ```powershell
      New-Item -Path 'c:\shares\frdeploy\<newuser>' -ItemType Directory
     ```

     > [!NOTE]  
     > In this command, \<*newuser*> represents the user name of the new user.

3. Right-click the new folder, and then select **Properties** > **Security** > **Advanced** > **Owner**. Verify that the folder owner is the Administrators group.
4. Set the permissions as described in the following table and figure. Remove permissions for any groups and accounts that are not listed here.  
  
   |User Account |Permission |Applies to |
   | --- | --- | --- |
   |System |Full control |This folder, subfolders, and files |
   |Administrators |Full Control |This folder, subfolders, and files |
   |Creator/Owner |Full Control |Subfolders&nbsp;and files only |
   |*newuser*<sup>1</sup> |Full Control |This folder, subfolders, and files |
   |Other groups and accounts |None (remove any other accounts from the access control list) | |

   <sup>1</sup> newuser *represents the user name of the new user's account*.  

   ![Setting the permissions for newuser’s folder under the root of the Folder Redirection share](.\media\deploy-folder-redirection\co-located-config-folder-redirect-perms-newuser.png)

## Step 4: Configure Folder Redirection file shares to work with other storage features

To make sure that Folder Redirection and Offline Files interact correctly with other storage features, check the following configurations.

- If the file share uses DFS Namespaces, the DFS folders (links) must have a single target to prevent users from making conflicting edits on different servers.
- If the file share uses DFS Replication to replicate the contents with another server, users must be able to access only the source server to prevent users from making conflicting edits on different servers.
- When using a clustered file share, disable continuous availability on the file share to avoid performance issues with Folder Redirection and Offline Files. Additionally, Offline Files might not transition to offline mode for 3-6 minutes after a user loses access to a continuously available file share, which could frustrate users who aren’t yet using the Always Offline mode of Offline Files.

## Step 5: Create a GPO for Folder Redirection

If you do not already have a Group Policy object (GPO) that manages the Folder Redirection and Offline Files functionality, use the following procedure to create one.

1. On a computer that has Group Policy Management installed, open Server Manager.
2. Select **Tools** > **Group Policy Management**.
3. In Group Policy Management, right-click the domain or OU in which you want to set up Folder Redirection, and then select **Create a GPO in this domain, and Link it here**.
4. In the **New GPO** dialog box, enter a name for the GPO (for example, **Folder Redirection Settings**), and then select **OK**.
5. Right-click the newly created GPO, and then clear the **Link Enabled** checkbox. This change prevents the GPO from being applied until you finish configuring it.
6. Select the GPO. Select **Scope** > **Security Filtering** > **Authenticated Users**, and then select **Remove** to prevent the GPO from being applied to everyone.
7. In the **Security Filtering** section, select **Add**.
8. In the **Select User, Computer, or Group** dialog box, do one of the following, depending on your configuration:
   - **Separate server configuration**. Enter the name of the security group that you created in [Create a folder redirection security group](#ss-securitygroup) (for example, Folder Redirection Users), and then select **OK**.
   - **Co-located server configuration**. Enter the user name that you used for the user folder in [Pre-create the folders for new users](#cls-usernames) and then select **OK**.

9. Select **Delegation** > **Add**, and then enter **Authenticated Users**. Select **OK**, and then select **OK** again to accept the default **Read** permission.
   > [!IMPORTANT]  
   > This step is necessary because of security changes made in [MS16-072](https://support.microsoft.com/help/3163622/ms16-072-security-update-for-group-policy-june-14-2016), you now must give the Authenticated Users group delegated Read permissions to the Folder Redirection GPO - otherwise the GPO won't get applied to users, or if it's already applied, the GPO is removed, redirecting folders back to the local PC. For more info, see [Deploying Group Policy Security Update MS16-072](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/deploying-group-policy-security-update-ms16-072-kb3163622/ba-p/400434).

## Step 6: Configure the Group Policy settings for Folder Redirection and Offline Files

After you create a GPO for Folder Redirection settings, follow these steps to edit the Group Policy settings that enable and configure Folder Redirection.

> [!NOTE]  
> By default, the Offline Files feature is enabled for redirected folders on Windows client computers, and disabled on Windows Server computers. Users can enable this feature, or you can use Group Policy to control it. The policy is **Allow or disallow use of the Offline Files feature**.  
>
> For information about some of the other Offline Files Group Policy settings, see [Enable Advanced Offline Files Functionality](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn270369(v=ws.11)), and [Configuring Group Policy for Offline Files](https://technet.microsoft.com/library/cc759721(v=ws.10).aspx).

1. In Group Policy Management, right-click the GPO you created (for example, **Folder Redirection Settings**), and then select **Edit**.
2. In the Group Policy Management Editor window, navigate to **User Configuration** > **Policies** > **Windows Settings** > **Folder Redirection**.
3. Right-click a folder that you want to redirect (for example, **Documents**), and then select **Properties**.
4. In the **Properties** dialog box, from the **Setting** box, select **Basic - Redirect everyone’s folder to the same location**.
   > [!NOTE]  
   > To apply Folder Redirection to client computers that run Windows XP or Windows Server 2003, select the **Settings** tab and then select the **Also apply redirection policy to Windows 2000, Windows 2000 Server, Windows XP, and Windows Server 2003 operating systems** checkbox.

5. In the **Target folder location** section, select **Create a folder for each user under the root path** and then in the **Root Path** box, enter the path to the file share that stores the redirected folders, for example: **\\\\`fs1.corp.contoso.com`\\`users$`**.
6. (Optional) Select the **Settings** tab, and in the **Policy Removal** section, select **Redirect the folder back to the local userprofile location when the policy is removed** (this setting can help make Folder Redirection behave more predictably for administrators and users).
7. Select **OK**, and then select **Yes** in the **Warning** dialog box.

## Step 7: Enable the Folder Redirection GPO

After you finish configuring the Folder Redirection Group Policy settings, the next step is to enable the GPO. This change allows the GPO to be applied to affected users.
> [!TIP]  
  > If you plan to implement primary computer support or other policy settings, do so now, before you enable the GPO. This prevents user data from being copied to non-primary computers before primary computer support is enabled.

1. Open Group Policy Management.
2. Right-click the GPO that you created, and then select **Link Enabled**. A checkbox appears next to the menu item.

## Step 8: Test Folder Redirection

To test Folder Redirection, sign in to a computer by using a user account that is configured to use redirected folders. Then confirm that the folders and profiles are redirected.

1. Sign in to a primary computer (if you enabled primary computer support) by using a user account for which you have enabled Folder Redirection.
2. If the user has previously signed in to the computer, open an elevated command prompt, and then type the following command to ensure that the latest Group Policy settings are applied to the client computer:

   ```console
   gpupdate /force
   ```

3. Open File Explorer.
4. Right-click a redirected folder (for example, the My Documents folder in the Documents library), and then select **Properties**.
5. Select the **Location** tab, and confirm that the path displays the file share that you specified instead of a local path.

## Appendix A: Checklist for deploying Folder Redirection

|Complete |Task or item |
| - | - |
| |**Prepare domain** |
| |- Join computers to domain |
| |- Create user accounts |
| |**Configure user groups and storage** |
| |1. Choose the type of file server configuration to use (separate server configuration or co-located server configuration. |
| |2. Separate server configuration: Create a folder redirection security group. |
| |   - Group name: |
| |   - Members: |
| |3. Restrict access to the file server. |
| |4. Create a file share for redirected folders. |
| |- File share name: |
| |5. Co-located server configuration: Pre-create the folders for new users. |
| |6. Configure other storage features to work with Folder Redirection file shares. |
| |- DFS Namespaces |
| |- DFS Replication |
| |- Clustering |
| |**Configure Group Policy** |
| |1. Create a GPO for Folder Redirection. |
| |- GPO name: |
| |2. Configure the Group Policy settings for Folder Redirection and Offline Files. |
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
| |**Enable Group Policy and test Folder Redirection** |
| |1. Enable the Folder Redirection GPO. |
| |2. Test Folder Redirection. |

## Change history

The following table summarizes some of the most important changes to this topic.

|Date |Description |Reason |
| --- | --- | --- |
|March 9, 2021 |Added instructions for different configurations. |Changes required to improve access control in different configurations. |
|January 18, 2017 |Added a step to [Create a GPO for Folder Redirection](#step-5-create-a-gpo-for-folder-redirection) to delegate Read permission to Authenticated Users, which is now required because of a Group Policy security update. |Customer feedback. |

## More information

- [Folder Redirection, Offline Files, and Roaming User Profiles](folder-redirection-rup-overview.md)
- [Deploy Primary Computers for Folder Redirection and Roaming User Profiles](deploy-primary-computers.md)
- [Enable Advanced Offline Files Functionality](enable-always-offline.md)
- [Microsoft's Support Statement Around Replicated User Profile Data](https://docs.microsoft.com/archive/blogs/askds/microsofts-support-statement-around-replicated-user-profile-data)
- [Sideload Apps with DISM](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-8.1-and-8/hh852635(v=win.10))
- [Troubleshooting packaging, deployment, and query of Windows Runtime-based apps](https://docs.microsoft.com/windows/win32/appxpkg/troubleshooting)
