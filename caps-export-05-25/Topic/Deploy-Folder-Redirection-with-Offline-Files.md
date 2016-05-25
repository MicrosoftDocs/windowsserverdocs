---
title: Deploy Folder Redirection with Offline Files
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5d86acdc-b7b5-491b-8c0b-cc7d3dc17295
author: JasonGerend
---
# Deploy Folder Redirection with Offline Files
This topic describes how to use Windows Server to deploy Folder Redirection with Offline Files to Windows client computers.  
  
**In this document**  
  
-   [Prerequisites](#FolderRedirection_Prerequisites)  
  
-   [Step 1: Create a folder redirection security group](#FolderRedirection_Step1Createafolderredirectionsecuritygroup)  
  
-   [Step 2: Create a file share for redirected folders](#FolderRedirection_Step2Createafileshareforredirectedfolders)  
  
-   [Step 3: Create a GPO for Folder Redirection](#FolderRedirection_Step3CreateaGPOforFolderRedirection)  
  
-   [Step 4: Configure folder redirection](#FolderRedirection_Step4Configurefolderredirection)  
  
-   [Step 5: Enable the Folder Redirection GPO](#FolderRedirection_Step5EnabletheFolderRedirectionGPO)  
  
-   [Step 6: Test Folder Redirection](#FolderRedirection_Step6TestFolderRedirection)  
  
-   [Appendix A: Deploy Folder Redirection Checklist](#FolderRedirection_AppendixADeployFolderRedirectionChecklist)  
  
## <a name="FolderRedirection_Prerequisites"></a>Prerequisites  
  
### Hardware requirements  
Folder Redirection requires an x64\-based or x86\-based computer; it is not supported by [!INCLUDE[winrt_1](../Token/winrt_1_md.md)].  
  
### Software requirements  
Folder Redirection has the following software requirements:  
  
-   To administer Folder Redirection, you must be signed in as a member of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group.  
  
-   Client computers must run [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, Windows Vista, Windows XP, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003.  
  
-   Client computers must be joined to the Active Directory Domain Services \(AD DS\) that you are managing.  
  
-   A computer must be available with Group Policy Management and Active Directory Administration Center installed.  
  
-   A file server must be available to host redirected folders.  
  
    -   If the file share uses DFS Namespaces, the DFS folders \(links\) must have a single target to prevent users from making conflicting edits on different servers.  
  
    -   If the file share uses DFS Replication to replicate the contents with another server, users must be able to access only the source server to prevent users from making conflicting edits on different servers.  
  
    -   When using a clustered file share, disable continuous availability on the file share to avoid performance issues with Folder Redirection and Offline Files. Additionally, Offline Files might not transition to offline mode for 3\-6 minutes after a user loses access to a continuously available file share, which could frustrate users who aren’t yet using the Always Offline mode of Offline Files.  
  
> [!NOTE]  
> To use new features in Folder Redirection, there are additional client computer and Active Directory schema requirements. For more information, see [Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md).  
  
## <a name="FolderRedirection_Step1Createafolderredirectionsecuritygroup"></a>Step 1: Create a folder redirection security group  
If your environment is not already set up with Folder Redirection, the first step is to create a security group that contains all users to which you want to apply Folder Redirection policy settings.  
  
#### To create a security group for Folder Redirection  
  
1.  Open Server Manager on a computer with Active Directory Administration Center installed.  
  
2.  On the **Tools** menu, click **Active Directory Administration Center**. Active Directory Administration Center appears.  
  
3.  Right\-click the appropriate domain or OU, click **New**, and then click **Group**.  
  
4.  In the **Create Group** window, in the **Group** section, specify the following settings:  
  
    -   In **Group name**, type the name of the security group, for example: **Folder Redirection Users**.  
  
    -   In **Group scope**, click **Security**, and then click **Global**.  
  
5.  In the **Members** section, click **Add**. The Select Users, Contacts, Computers, Service Accounts or Groups dialog box appears.  
  
6.  Type the names of the users or groups  to which you want to deploy Folder Redirection, click **OK**, and then click **OK** again.  
  
## <a name="FolderRedirection_Step2Createafileshareforredirectedfolders"></a>Step 2: Create a file share for redirected folders  
If you do not already have a file share for redirected folders, use the following procedure to create a file share on a server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!NOTE]  
> Some functionality might differ or be unavailable if you create the file share on a server running another version of Windows Server.  
  
#### To create a file share on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
1.  In the Server Manager navigation pane, click **File and Storage Services**, and then click **Shares** to display the Shares page.  
  
2.  In the **Shares** tile, click **Tasks**, and then click **New Share**. The New Share Wizard appears.  
  
3.  On the **Select Profile** page, click **SMB Share – Quick**. If you have File Server Resource Manager installed and are using folder management properties, instead click **SMB Share \- Advanced**.  
  
4.  On the **Share Location** page, select the server and volume on which you want to create the share.  
  
5.  On the **Share Name** page, type a name for the share \(for example, **Users$**\) in the **Share name** box.  
  
    > [!TIP]  
    > When creating the share, hide the share by putting a **$** after the share name. This will hide the share from casual browsers.  
  
6.  On the **Other Settings** page, clear the Enable continuous availability checkbox, if present, and optionally select the **Enable access\-based enumeration** and **Encrypt data access** checkboxes.  
  
7.  On the **Permissions** page, click **Customize permissions…**. The Advanced Security Settings dialog box appears.  
  
8.  Click **Disable inheritance**, and then click **Convert inherited permissions into explicit permission on this object**.  
  
9. Set the permissions as described Table 1 and shown in Figure 1, removing permissions for unlisted groups and accounts, and adding special permissions to the Folder Redirection Users group that you created in Step 1.  
  
    ![](../Image/DeployFolderRedirection.gif)  
  
    **Figure 1** Setting the permissions for the redirected folders share  
  
10. If you chose the **SMB Share \- Advanced** profile, on the **Management Properties** page, select the **User Files** Folder Usage value.  
  
11. If you chose the **SMB Share \- Advanced** profile, on the **Quota** page, optionally select a quota to apply to users of the share.  
  
12. On the **Confirmation** page, click **Create.**  
  
### Table 1 Required permissions for the file share hosting redirected folders  
  
||||  
|-|-|-|  
|User Account|Access|Applies to|  
|System|Full control|This folder, subfolders and files|  
|Administrators|Full Control|This folder only|  
|Creator\/Owner|Full Control|Subfolders and files only|  
|Security group of users needing to put data on share \(Folder Redirection Users\)|List folder \/ read data<sup>1</sup><br /><br />Create folders \/ append data<sup>1</sup>|This folder only|  
|Other groups and accounts|None \(remove\)||  
  
1 Advanced permissions  
  
## <a name="FolderRedirection_Step3CreateaGPOforFolderRedirection"></a>Step 3: Create a GPO for Folder Redirection  
If you do not already have a GPO created for Folder Redirection  settings, use the following procedure to create one.  
  
#### To create a GPO for Folder Redirection  
  
1.  Open Server Manager on a computer with Group Policy Management installed.  
  
2.  From the **Tools** menu click **Group Policy Management**. Group Policy Management appears.  
  
3.  Right\-click the domain or OU in which you want to setup Folder Redirection and then click **Create a GPO in this domain, and Link it here**.  
  
4.  In the **New GPO** dialog box, type a name for the GPO \(for example, **Folder Redirection Settings**\), and then click **OK**.  
  
5.  Right\-click the newly created GPO and then clear the **Link Enabled** checkbox. This prevents the GPO from being applied until you finish configuring it.  
  
6.  Select the GPO. In the **Security Filtering** section of the **Scope** tab, select **Authenticated Users**, and then click **Remove**.  
  
7.  In the **Security Filtering** section, click **Add**.  
  
8.  In the **Select User, Computer, or Group** dialog box, type the name of the security group you created in Step 1 \(for example, **Folder Redirection Users**\), and then click **OK**.  
  
## <a name="FolderRedirection_Step4Configurefolderredirection"></a>Step 4: Configure folder redirection with Offline Files  
After creating a GPO for Folder Redirection settings, edit the Group Policy settings to enable and configure Folder Redirection, as discussed in the following procedure.  
  
> [!NOTE]  
> Offline Files is enabled by default for redirected folders on Windows client computers, and disabled on computers running Windows Server, unless changed by the user. To use Group Policy to control whether Offline Files is enabled, use the **Allow or disallow use of the Offline Files feature** policy setting.  
>   
> For information about some of the other Offline Files Group Policy settings, see [Enable Advanced Offline Files Functionality](../Topic/Enable-Advanced-Offline-Files-Functionality.md), and [Configuring Group Policy for Offline Files](http://technet.microsoft.com/library/cc759721(v=WS.10).aspx).  
  
#### To configure Folder Redirection in Group Policy  
  
1.  In Group Policy Management, right\-click the GPO you created \(for example, **Folder Redirection Settings**\), and then click **Edit**.  
  
2.  In the Group Policy Management Editor window, navigate to **User Configuration**, then **Policies**, then **Windows Settings**, and then **Folder Redirection**.  
  
3.  Right\-click a folder that you want to redirect \(for example, **Documents**\), and then click **Properties**.  
  
4.  In the **Properties** dialog box, from the **Setting** box click **Basic \- Redirect everyone’s folder to the same location**.  
  
    > [!NOTE]  
    > To apply Folder Redirection to client computers running Windows XP or Windows Server 2003, click the **Settings** tab and select the **Also apply redirection policy to Windows 2000, Windows 2000 Server, Windows XP, and Windows Server 2003 operating systems** checkbox.  
  
5.  In the **Target folder location** section, click **Create a folder for each user under the root path** and then in the **Root Path** box, type the path to the file share storing redirected folders, for example: **\\\\fs1.corp.contoso.com\\users$**  
  
6.  Click the **Settings** tab, and in the **Policy Removal** section, optionally click **Redirect the folder back to the local userprofile location when the policy is removed** \(this setting can help make Folder Redirection behave more predictably for adminisitrators and users\).  
  
7.  Click **OK**, and then click **Yes** in the Warning dialog box.  
  
## <a name="FolderRedirection_Step5EnabletheFolderRedirectionGPO"></a>Step 5: Enable the Folder Redirection GPO  
Once you have completed configuring the Folder Redirection Group Policy settings, the next step is to enable the GPO, permitting it to be applied to affected users.  
  
> [!TIP]  
> If you plan to implement primary computer support or other policy settings, do so now, before you enable the GPO. This prevents user data from being copied to non\-primary computers before primary computer support is enabled.  
  
#### To enable the Folder Redirection GPO  
  
1.  Open Group Policy Management.  
  
2.  Right\-click the GPO that you created, and then click **Link Enabled**. A checkbox appears next to the menu item.  
  
## <a name="FolderRedirection_Step6TestFolderRedirection"></a>Step 6: Test Folder Redirection  
To test Folder Redirection, sign in to a computer with a user account configured for Folder Redirection. Then confirm that the folders and profiles are redirected.  
  
#### To test Folder Redirection  
  
1.  Sign in to a primary computer \(if you enabled primary computer support\) with a user account for which you have enabled Folder Redirection.  
  
2.  If the user has previously signed in to the computer, open an elevated command prompt, and then type the following command to ensure that the latest Group Policy settings are applied to the client computer:  
  
    ```  
    gpupdate /force  
    ```  
  
3.  Open [!INCLUDE[win8_explorer](../Token/win8_explorer_md.md)].  
  
4.  Right\-click a redirected folder \(for example, the My Documents folder in the Documents library\), and then click **Properties**.  
  
5.  Click the **Location** tab, and confirm that the path displays the file share you specified instead of a local path.  
  
## <a name="FolderRedirection_AppendixADeployFolderRedirectionChecklist"></a>Appendix A: Checklist for deploying Folder Redirection  
  
|||  
|-|-|  
||1. Prepare domain|  
||-   Join computers to domain|  
||-   Create user accounts|  
||2. Create security group for Folder Redirection|  
||-   Group name:|  
||-   Members:|  
||3. Create a file share for redirected folders|  
||-   File share name:|  
||4. Create a GPO for Folder Redirection|  
||-   GPO name:|  
||5. Configure Folder Redirection and Offline Files policy settings|  
||-   Redirected folders:|  
||-   Windows 2000, Windows XP, and Windows Server 2003 support enabled?|  
||-   Offline Files enabled? \(enabled by default on Windows client computers\)|  
||-   Always Offline Mode enabled?|  
||-   Background file synchronization enabled?|  
||-   Optimized Move of redirected folders enabled?|  
||6. \(Optional\) Enable primary computer support|  
||<ul><li>Designate primary computers for users<br /><br /><ul><li>Location of user and primary computer mappings:</li></ul></li></ul>|  
||<ul><li>\(Optional\) Enable primary computer support for Folder Redirection<br /><br /><ul><li>Computer\-based or User\-based?</li></ul></li></ul>|  
||-   \(Optional\) Enable primary computer support for Roaming User Profiles|  
||7. Enable the Folder Redirection GPO|  
||8. Test Folder Redirection|  
  
## See Also  
[Deploy Folder Redirection, Offline Files, and Roaming User Profiles](../Topic/Deploy-Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles.md)  
[Deploy Primary Computers for Folder Redirection and Roaming User Profiles](../Topic/Deploy-Primary-Computers-for-Folder-Redirection-and-Roaming-User-Profiles.md)  
[Enable Advanced Offline Files Functionality](../Topic/Enable-Advanced-Offline-Files-Functionality.md)  
[Microsoft’s Support Statement Around Replicated User Profile Data](http://blogs.technet.com/b/askds/archive/2010/09/01/microsoft-s-support-statement-around-replicated-user-profile-data.aspx)  
[How to Add and Remove Apps](http://go.microsoft.com/fwlink/p/?LinkID=231020)  
[Troubleshooting packaging, deployment, and query of Windows Runtime\-based apps](http://msdn.microsoft.com/library/windows/desktop/hh973484.aspx)  
  
