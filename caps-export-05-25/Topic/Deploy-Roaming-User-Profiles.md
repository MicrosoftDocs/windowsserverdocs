---
title: Deploy Roaming User Profiles
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 65840ed4-02af-49fc-a99d-292a4b50dfd4
author: JasonGerend
---
# Deploy Roaming User Profiles
This topic describes how to use Windows Server to deploy Roaming User Profiles to Windows client computers.  
  
For a list of recent changes to this topic, see the [Change History](#BKMK_ChangeHistory) section of this topic.  
  
**In this document**  
  
-   [Prerequisites](#RUP_Prerequisites)  
  
-   [Step 1: Enable the use of separate profile versions](../Topic/Deploy-Roaming-User-Profiles.md#EnableProfileVersions)  
  
-   [Step 2: Create a roaming user profiles security group](#RUP_Step1Createaroaminguserprofilessecuritygroup)  
  
-   [Step 3: Create a file share for roaming user profiles](#RUP_Step2Createafileshareforroaminguserprofiles)  
  
-   [Step 4: Create a GPO for Roaming User Profiles](#RUP_Step3CreateaGPOforRoamingUserProfiles)  
  
-   [Step 5: Optionally set up Roaming User Profiles on user accounts](#RUP_Step4OptionallysetupRoamingUserProfilesonuseraccounts)  
  
-   [Step 6: Optionally set up Roaming User Profiles on computers](#RUP_Step5OptionallysetupRoamingUserProfilesoncomputers)  
  
-   [Step 7: Enable the Roaming User Profiles GPO](#RUP_Step6EnabletheRoamingUserProfilesGPO)  
  
-   [Step 8: Test Roaming User Profiles](#RUP_Step7TestRoamingUserProfiles)  
  
-   [Appendix A: Deploy Roaming User Profiles Checklist](#RUP_AppendixADeployRoamingUserProfilesChecklist)  
  
-   [Appendix B: Profile version reference information](../Topic/Deploy-Roaming-User-Profiles.md#ProfileReference)  
  
## <a name="RUP_Prerequisites"></a>Prerequisites  
  
### Hardware requirements  
Roaming User Profiles require an x64\-based or x86\-based computer; it is not supported by [!INCLUDE[winrt_1](../Token/winrt_1_md.md)].  
  
### Software requirements  
Roaming User Profiles has the following software requirements:  
  
-   If you are deploying Roaming User Profiles with Folder Redirection in an environment with existing local user profiles, deploy Folder Redirection before Roaming User Profiles to minimize the size of roaming profiles. After the existing user folders have been successfully redirected, you can deploy Roaming User Profiles.  
  
-   To administer Roaming User Profiles, you must be signed in as a member of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group.  
  
-   Client computers must run [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, Windows Vista, Windows XP, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003. Windows XP and Windows Server 2003 support Roaming User Profiles only when set up on user accounts by using AD DS \- they don’t support enabling Roaming User Profiles on a per\-computer basis by using Group Policy.  
  
-   Client computers must be joined to the Active Directory Domain Services \(AD DS\) that you are managing.  
  
-   A computer must be available with Group Policy Management and Active Directory Administration Center installed.  
  
-   A file server must be available to host roaming user profiles.  
  
    -   If the file share uses DFS Namespaces, the DFS folders \(links\) must have a single target to prevent users from making conflicting edits on different servers.  
  
    -   If the file share uses DFS Replication to replicate the contents with another server, users must be able to access only the source server to prevent users from making conflicting edits on different servers.  
  
    -   If the file share is clustered, disable continuous availability on the file share to avoid performance issues.  
  
> [!NOTE]  
> To use new features in Roaming User Profiles, there are additional client computer and Active Directory schema requirements. For more information, see [Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md).  
  
### <a name="BKMK_MultiVersion"></a>Considerations when using Roaming User Profiles on multiple versions of Windows  
If you decide to use Roaming User Profiles across multiple versions of Windows, we recommend taking the following actions:  
  
-   Configure Windows to maintain separate profile versions for each operating system version. This helps prevent undesirable and unpredictable issues such as profile corruption.  
  
-   Use Folder Redirection to store user files such as documents and pictures outside of user profiles. This enables the same files to be available to users across operating system versions. It also keeps profiles small and sign\-ins quick.  
  
-   Allocate sufficient storage for Roaming User Profiles. If you support two operating system versions, profiles will double in number \(and thus total space consumed\) because a separate profile is maintained for each operating system version.  
  
-   Don’t use Roaming User Profiles across computers running Windows Vista\/Windows Server 2008 and Windows 7\/Windows Server 2008 R2. Roaming between these operating system versions isn’t supported due to incompatibilities in their profile versions.  
  
-   Inform your users that changes made on one operating system version won’t roam to another operating system version.  
  
-   When moving your environment to a new version of Windows users will receive a new, empty profile. There isn’t a supported method of migrating user profiles from one operating system version to another.  
  
## <a name="EnableProfileVersions"></a>Step 1: Enable the use of separate profile versions  
If you are deploying Roaming User Profiles on computers running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], or Windows Server 2012, we recommend making a couple of changes to your Windows environment prior to deploying. These changes help ensure that future operating system upgrades go smoothly, and facilitate the ability to simultaneously run multiple versions of Windows with Roaming User Profiles.  
  
To make these changes, use the following procedure.  
  
#### Enable the use of separate profiles for each version of Windows  
  
1.  Download and install the appropriate software update on all computers on which you’re going to use roaming, mandatory, super\-mandatory, or domain default profiles:  
  
    -   [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]: install the software update described in article [2887595](http://support.microsoft.com/kb/2887595) in the Microsoft Knowledge Base \(when released\).  
  
    -   Windows 8 or Windows Server 2012: install the software update described in article [2887239](http://support.microsoft.com/kb/2887239) in the Microsoft Knowledge Base.  
  
2.  On all computers running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], or Windows Server 2012 on which you will use Roaming User Profiles, use Registry Editor or Group Policy to create the following registry key DWORD Value and set it to **1**. For information about creating registry keys by using Group Policy, see [Configure a Registry Item](http://technet.microsoft.com/library/cc753092.aspx).  
  
    ```  
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ProfSvc\Parameters\UseProfilePathExtensionVersion  
    ```  
  
    > [!CAUTION]  
    > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  
  
3.  Restart the computers.  
  
## <a name="RUP_Step1Createaroaminguserprofilessecuritygroup"></a>Step 2: Create a Roaming User Profiles security group  
If your environment is not already set up with Roaming User Profiles, the first step is to create a security group that contains all users and\/or computers to which you want to apply Roaming User Profiles policy settings.  
  
-   Administrators of general\-purpose roaming user profiles deployments typically create a security group for users.  
  
-   Administrators of Remote Desktop Services or virtualized desktop deployments typically use a security group for users and the shared computers.  
  
#### To create a security group for Roaming User Profiles  
  
1.  Open Server Manager on a  computer with Active Directory Administration Center installed.  
  
2.  On the **Tools** menu, click **Active Directory Administration Center**. Active Directory Administration Center appears.  
  
3.  Right\-click the appropriate domain or OU, click **New**, and then click **Group**.  
  
4.  In the **Create Group** window, in the **Group** section, specify the following settings:  
  
    -   In **Group name**, type the name of the security group, for example: **Roaming User Profiles Users and Computers**.  
  
    -   In **Group scope**, click **Security**, and then click **Global**.  
  
5.  In the **Members** section, click **Add**. The Select Users, Contacts, Computers, Service Accounts or Groups dialog box appears.  
  
6.  If you want to include computer accounts in the security group, click **Object Types**, select the **Computers** check box and then click **OK**.  
  
7.  Type the names of the users, groups, and\/or computers to which you want to deploy Roaming User Profiles, click **OK**, and then click **OK** again.  
  
## <a name="RUP_Step2Createafileshareforroaminguserprofiles"></a>Step 3: Create a file share for roaming user profiles  
If you do not already have a separate file share for roaming user profiles \(independent from any shares for redirected folders to prevent inadvertent caching of the roaming profile folder\), use the following procedure to create a file share on a server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!NOTE]  
> Some functionality might differ or be unavailable if you create the file share on a server running another version of Windows Server.  
  
#### To create a file share on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
1.  In the Server Manager navigation pane, click **File and Storage Services**, and then click **Shares** to display the Shares page.  
  
2.  In the Shares tile, click **Tasks**, and then click **New Share**. The New Share Wizard appears.  
  
3.  On the **Select Profile** page, click **SMB Share – Quick**. If you have File Server Resource Manager installed and are using folder management properties, instead click **SMB Share \- Advanced**.  
  
4.  On the **Share Location** page, select the server and volume on which you want to create the share.  
  
5.  On the **Share Name** page, type a name for the share \(for example, **User Profiles$**\) in the **Share name** box.  
  
    > [!TIP]  
    > When creating the share, hide the share by putting a **$** after the share name. This hides the share from casual browsers.  
  
6.  On the **Other Settings** page, clear the **Enable continuous availability** checkbox, if present, and optionally select the **Enable access\-based enumeration** and **Encrypt data access** checkboxes.  
  
7.  On the **Permissions** page, click **Customize permissions…**. The Advanced Security Settings dialog box appears.  
  
8.  Click **Disable inheritance**, and then click **Convert inherited permissions into explicit permission on this object**.  
  
9. Set the permissions as described Table 1 and shown in Figure 1, removing permissions for unlisted groups and accounts, and adding special permissions to the Roaming User Profiles Users and Computers group that you created in Step 1.  
  
    ![](../Image/DeployRoamingUserProfiles_SharePerms.png)  
  
    **Figure 1** Setting the permissions for the roaming user profiles share  
  
10. If you chose the **SMB Share \- Advanced** profile, on the **Management Properties** page, select the **User Files** Folder Usage value.  
  
11. If you chose the **SMB Share \- Advanced** profile, on the **Quota** page, optionally select a quota to apply to users of the share.  
  
12. On the **Confirmation** page, click **Create.**  
  
### Table 1 Required permissions for the file share hosting roaming user profiles  
  
||||  
|-|-|-|  
|User Account|Access|Applies to|  
|System|Full control|This folder, subfolders and files|  
|Administrators|Full Control|This folder only|  
|Creator\/Owner|Full Control|Subfolders and files only|  
|Security group of users needing to put data on share \(Roaming User Profiles Users and Computers\)|List folder \/ read data<sup>1</sup><br /><br />Create folders \/ append data<sup>1</sup>|This folder only|  
|Other groups and accounts|None \(remove\)||  
  
1 Advanced permissions  
  
## <a name="RUP_Step3CreateaGPOforRoamingUserProfiles"></a>Step 4: Optionally create a GPO for Roaming User Profiles  
If you do not already have a GPO created for Roaming User Profiles settings, use the following procedure to create an empty GPO for use with Roaming User Profiles. This GPO allows you to configure Roaming User Profiles settings \(such as primary computer support, which is discussed separately\), and can also be used to enable Roaming User Profiles on computers, as is typically done when deploying in virtualized desktop environments or with Remote Desktop Services.  
  
#### To create a GPO for Roaming User Profiles  
  
1.  Open Server Manager on a computer with Group Policy Management installed.  
  
2.  From the **Tools** menu click **Group Policy Management**. Group Policy Management appears.  
  
3.  Right\-click the domain or OU in which you want to setup Roaming User Profiles and then click **Create a GPO in this domain, and Link it here**.  
  
4.  In the **New GPO** dialog box, type a name for the GPO \(for example, **Roaming User Profile Settings**\), and then click **OK**.  
  
5.  Right\-click the newly created GPO and then clear the **Link Enabled** checkbox. This prevents the GPO from being applied until you finish configuring it.  
  
6.  Select the GPO. In the **Security Filtering** section of the **Scope** tab, select **Authenticated Users**, and then click **Remove**.  
  
7.  In the **Security Filtering** section, click **Add**.  
  
8.  In the **Select User, Computer, or Group** dialog box, type the name of the security group you created in Step 1 \(for example, **Roaming User Profiles Users and Computers**\), and then click **OK**.  
  
## <a name="RUP_Step4OptionallysetupRoamingUserProfilesonuseraccounts"></a>Step 5: Optionally set up Roaming User Profiles on user accounts  
If you are deploying Roaming User Profiles to user accounts, use the following procedure to specify roaming user profiles for user accounts in Active Directory Domain Services. If you are deploying Roaming User Profiles to computers, as is typically done for Remote Desktop Services or virtualized desktop deployments, instead use the procedure documented in Step 5 of this topic.  
  
> [!NOTE]  
> If you set up Roaming User Profiles on user accounts by using Active Directory and on computers by using Group Policy, the computer\-based policy setting takes precedence.  
  
#### To set up Roaming User Profiles on user accounts  
  
1.  In Active Directory Administration Center, navigate to the **Users** container \(or OU\) in the appropriate domain.  
  
2.  Select all users to which you want to assign a roaming user profile, right\-click the users and then click **Properties**.  
  
3.  In the **Profile** section, select the **Profile path:** checkbox and then enter the path to the file share where you want to store the user’s roaming user profile, followed by **%username%** \(which is automatically replaced with the user name the first time the user signs in\). For example:  
  
    **\\\\fs1.corp.contoso.com\\User Profiles$\\%username%**  
  
    To specify a mandatory roaming user profile, specify the path to the NTuser.man file that you created previously, for example, **\\\\fs1.corp.contoso.com\\User Profiles$\\default**. For more information, see [Creating a Mandatory User Profile](http://technet.microsoft.com/library/gg241183).  
  
4.  Click **OK**.  
  
> [!NOTE]  
> By default, deployment of all Windows® Runtime\-based \(Windows Store\) apps is allowed when using Roaming User Profiles. However, when using a special profile, apps are not deployed by default. Special profiles are user profiles where changes are discarded after the user signs out:  
>   
> -   Roaming user profiles to which the **Delete cached copies of roaming profiles** Group Policy setting applies \(located in Computer Configuration\\Policies\\Administrative Templates\\System\\User Profiles\)  
> -   Mandatory user profiles and super\-mandatory profiles, created by an administrator  
> -   Temporary user profiles, created when an error prevents the correct profile from loading  
> -   User profiles for the Guest account and members of the Guests group  
>   
> To remove restrictions on app deployment for special profiles, enable the **Allow deployment operations in special profiles** policy setting \(located in Computer Configuration\\Policies\\Administrative Templates\\Windows Components\\App Package Deployment\). However, deployed apps in this scenario will leave some data stored on the computer, which could accumulate, for example, if there are hundreds of users of a single computer. To cleanup apps, locate or develop a tool that uses the [CleanupPackageForUserAsync](http://msdn.microsoft.com/library/windows/apps/windows.management.deployment.packagemanager.cleanuppackageforuserasync.aspx) API to cleanup app packages for users who no longer have a profile on the computer.  
>   
> For additional background information about Windows Store apps, see [Manage Client Access to the Windows Store](assetId:///bd1a8a9b-def4-4b44-9225-4a1b97f8047f).  
  
## <a name="RUP_Step5OptionallysetupRoamingUserProfilesoncomputers"></a>Step 6: Optionally set up Roaming User Profiles on computers  
If you are deploying Roaming User Profiles to computers, as is typically done for Remote Desktop Services or virtualized desktop deployments, use the following procedure. If you are deploying Roaming User Profiles to user accounts, use the procedure described in Step 4 of this topic.  
  
You can use Group Policy to apply Roaming User Profiles to computers running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, Windows Vista, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Server 2008 R2, or Windows Server 2008.  
  
> [!NOTE]  
> If you set up Roaming User Profiles on computers by using Group Policy and on user accounts by using Active Directory, the computer\-based policy setting takes precedence.  
  
#### To set up Roaming User Profiles on computers  
  
1.  Open Server Manager on a computer with Group Policy Management installed.  
  
2.  From the **Tools** menu click **Group Policy Management**. Group Policy Management appears.  
  
3.  In Group Policy Management, right\-click the GPO you created in Step 3 \(for example, **Roaming User Profiles Settings**\), and then click **Edit**.  
  
4.  In the Group Policy Management Editor window, navigate to **Computer Configuration**, then **Policies**, then **Administrative Templates**, then **System**, and then **User Profiles**.  
  
5.  Right\-click **Set roaming profile path for all users logging onto this computer** and then click **Edit**.  
  
    > [!TIP]  
    > A user's home folder, if configured, is the default folder used by some programs such as Windows PowerShell. You can configure an alternative local or network location on a per\-user basis by using the **Home folder** section of the user account properties in AD DS. To configure the home folder location for all users of a computer running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in a virtual desktop environment, enable the **Set user home folder** policy setting, and then specify the file share and drive letter to map \(or specify a local folder\). Do not use environment variables or ellipses. The user’s alias is appended to the end of the path specified during user sign on.  
  
6.  In the **Properties** dialog box, click **Enabled**  
  
7.  In the **Users logging onto this computer should use this roaming profile path** box, enter the path to the file share where you want to store the user’s roaming user profile, followed by **%username%** \(which is automatically replaced with the user name the first time the user signs in\). For example:  
  
    **\\\\fs1.corp.contoso.com\\User Profiles$\\%username%**  
  
    To specify a mandatory roaming user profile, which is a preconfigured profile to which users cannot make permanent changes \(changes are reset when the user signs out\), specify the path to the NTuser.man file that you created previously, for example, **\\\\fs1.corp.contoso.com\\User Profiles$\\default**. For more information, see [Creating a Mandatory User Profile](http://technet.microsoft.com/library/gg241183).  
  
8.  Click **OK**.  
  
## <a name="RUP_Step6EnabletheRoamingUserProfilesGPO"></a>Step 7: Enable the Roaming User Profiles GPO  
If you set up Roaming User Profiles on computers by using Group Policy, or if you customized other Roaming User Profiles settings by using Group Policy, the next step is to enable the GPO, permitting it to be applied to affected users.  
  
> [!TIP]  
> If you plan to implement primary computer support or other policy settings, do so now, before you enable the GPO. This prevents user data from being copied to non\-primary computers before primary computer support is enabled.  
  
#### To enable the Roaming User Profile GPO  
  
1.  Open Group Policy Management.  
  
2.  Right\-click the GPO that you created and then click **Link Enabled**. A checkbox appears next to the menu item.  
  
## <a name="RUP_Step7TestRoamingUserProfiles"></a>Step 8: Test Roaming User Profiles  
To test Roaming User Profiles, sign in to a computer with a user account configured for Roaming User Profiles, or sign in to a computer configured for Roaming User Profiles. Then confirm that the profile is redirected.  
  
#### To test Roaming User Profiles  
  
1.  Sign in to a primary computer \(if you enabled primary computer support\) with a user account for which you have enabled Roaming User Profiles enabled. If you enabled Roaming User Profiles on specific computers, sign in to one of these computers.  
  
2.  If the user has previously signed in to the computer, open an elevated command prompt, and then type the following command to ensure that the latest Group Policy settings are applied to the client computer:  
  
    ```  
    GpUpdate /Force  
    ```  
  
3.  To confirm that the user profile is roaming, open **Control Panel**, click **System and Security**, click **System**, click **Advanced System Settings**, click **Settings** in the User Profiles section and then look for **Roaming** in the **Type** column.  
  
## <a name="RUP_AppendixADeployRoamingUserProfilesChecklist"></a>Appendix A: Checklist for deploying Roaming User Profiles  
  
|||  
|-|-|  
||1. Prepare domain|  
||-   Join computers to domain|  
||-   Enable the use of separate profile versions|  
||-   Create user accounts|  
||-   \(Optional\) Deploy Folder Redirection|  
||2. Create security group for Roaming User Profiles|  
||-   Group name:|  
||-   Members:|  
||3. Create a file share for Roaming User Profiles|  
||-   File share name:|  
||4. Create a GPO for Roaming User Profiles|  
||-   GPO name:|  
||5. Configure Roaming User Profiles policy settings|  
||6. Enable Roaming User Profiles:|  
||-   Enabled in AD DS on user accounts?|  
||-   Enabled in Group Policy on computer accounts?|  
||7. Enable primary computer support|  
||<ul><li>Designate primary computers for users<br /><br /><ul><li>Location of user and primary computer mappings:</li></ul></li></ul>|  
||<ul><li>\(Optional\) Enable primary computer support for Folder Redirection<br /><br /><ul><li>Computer\-based or User\-based?</li></ul></li></ul>|  
||-   \(Optional\) Enable primary computer support for Roaming User Profiles|  
||8. Enable the Roaming User Profiles GPO|  
||9. Test Roaming User Profiles|  
  
## <a name="ProfileReference"></a>Appendix B: Profile version reference information  
The following table lists the location of Roaming User Profiles on various versions of Windows.  
  
|Operating system version|Roaming User Profile location|  
|----------------------------|---------------------------------|  
|Windows XP and Windows Server 2003|\\\\*<servername>*\\*<fileshare>*\\*<username>*|  
|Windows Vista and Windows Server 2008|\\\\*<servername>*\\*<fileshare>*\\*<username>*.V2|  
|Windows 7 and Windows Server 2008 R2|\\\\*<servername>*\\*<fileshare>*\\*<username>*.V2|  
|Windows 8 and Windows Server 2012|\\\\*<servername>*\\*<fileshare>*\\*<username>*.V3 \(after the software update and registry key are applied\)<br /><br />\\\\*<servername>*\\*<fileshare>*\\*<username>*.V2 \(before the software update and registry key are applied\)|  
|[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|HYPERLINK \\\\<servername>\\<fileshare>\\<username>.V4 \(after the software update and registry key are applied\)<br /><br />\\\\*<servername>*\\*<fileshare>*\\*<username>*.V2 \(before the software update and registry key are applied\)|  
  
## <a name="BKMK_ChangeHistory"></a>Change History  
The following table summarizes some of the most important changes to this topic.  
  
|Date|Description|Reason|  
|--------|---------------|----------|  
|July 7th, 2015|Added requirement and step to disable continuous availability when using a clustered file server.|Clustered file shares have better performance for small writes \(which are typical with roaming user profiles\) when continuous availability is disabled.|  
|March 19th, 2014|Capitalized profile version suffixes \(.V2, .V3, .V4\) in [Appendix B: Profile version reference information](../Topic/Deploy-Roaming-User-Profiles.md#ProfileReference)|Although Windows is case insensitive, if you use NFS with the file share, it’s important to have the correct \(uppercase\) capitalization for the profile suffix|  
|October 9th, 2013|Revised for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], clarified a few things, and added the [Considerations when using Roaming User Profiles on multiple versions of Windows](../Topic/Deploy-Roaming-User-Profiles.md#BKMK_MultiVersion) and [Appendix B: Profile version reference information](../Topic/Deploy-Roaming-User-Profiles.md#ProfileReference) sections.|Updates for new version; customer feedback|  
  
## See Also  
[Deploy Folder Redirection, Offline Files, and Roaming User Profiles](../Topic/Deploy-Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles.md)  
[Deploy Primary Computers for Folder Redirection and Roaming User Profiles](../Topic/Deploy-Primary-Computers-for-Folder-Redirection-and-Roaming-User-Profiles.md)  
[Implementing User State Management](http://technet.microsoft.com/library/cc784645)  
[Microsoft’s Support Statement Around Replicated User Profile Data](http://blogs.technet.com/b/askds/archive/2010/09/01/microsoft-s-support-statement-around-replicated-user-profile-data.aspx)  
[How to Add and Remove Apps](http://go.microsoft.com/fwlink/p/?LinkID=231020)  
[Troubleshooting packaging, deployment, and query of Windows Runtime\-based apps](http://msdn.microsoft.com/library/windows/desktop/hh973484.aspx)  
  
