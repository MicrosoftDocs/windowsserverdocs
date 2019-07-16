---
ms.assetid: d2429185-9720-4a04-ad94-e89a9350cdba
title: Deploying Work Folders
ms.prod: windows-server-threshold
ms.technology: storage-work-folders
ms.topic: article
author: JasonGerend
manager: dongill
ms.author: jgerend
ms.date: 6/24/2017
description: How to deploy Work Folders, including installing the server role, creating sync shares, and creating DNS records.
---
# Deploying Work Folders

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10, Windows 8.1, Windows 7

This topic discusses the steps needed to deploy Work Folders. It assumes that you've already read [Planning a Work Folders deployment](plan-work-folders.md).  
  
 To deploy Work Folders, a process that can involve multiple servers and technologies, use the following steps.  
  
> [!TIP]
>  The simplest Work Folders deployment is a single file server (often called a sync server) without support for syncing over the Internet, which can be a useful deployment for a test lab or as a sync solution for domain-joined client computers. To create a simple deployment, these are minimum steps to follow: 
>  -   Step 1: Obtain SSL certificates  
>  -   Step 2: Create DNS records 
>  -   Step 3: Install Work Folders on file servers  
>  -   Step 4: Binding the SSL certificate on the sync servers
>  -   Step 5: Create security groups for Work Folders  
>  -   Step 7: Create sync shares for user data  
  
## Step 1: Obtain SSL certificates  
 Work Folders uses HTTPS to securely synchronize files between the Work Folders clients and the Work Folders server. The requirements for SSL certificates used by Work Folders are as follows:  
  
- The certificate must be issued by a trusted certification authority. For most Work Folders implementations, a publicly trusted CA is recommended, since certificates will be used by non-domain-joined, Internet-based devices.  
  
- The certificate must be valid.  
  
- The private key of the certificate must be exportable (as you will need to install the certificate on multiple servers).  
  
- The subject name of the certificate must contain the public Work Folders URL used for discovering the Work Folders service from across the Internet – this must be in the format of `workfolders.`*<domain_name>*.  
  
- Subject alternative names (SANs) must be present on the certificate listing the server name for each sync server in use.

  The Work Folders Certificate Management [blog](https://blogs.technet.microsoft.com/filecab/2013/08/09/work-folders-certificate-management/) provides additional information on using certificates with Work Folders.
  
## Step 2: Create DNS records  
 To allow users to sync across the Internet, you must create a Host (A) record in public DNS to allow Internet clients to resolve your Work Folders URL. This DNS record should resolve to the external interface of the reverse proxy server.  
  
 On your internal network, create a CNAME record in DNS named workfolders which resolves to the FDQN of a Work Folders server. When Work Folders clients use auto discovery, the URL used to discover the Work Folders server is https:\//workfolders.domain.com. If you plan to use auto discovery, the workfolders CNAME record must exist in DNS.  
  
## Step 3: Install Work Folders on file servers  
 You can install Work Folders on a domain-joined server by using Server Manager or by using Windows PowerShell, locally or remotely across a network. This is useful if you are configuring multiple sync servers across your network.  
  
To deploy the role in Server Manager, do the following:  
  
1.  Start the **Add Roles and Features Wizard**.  
  
2.  On the **Select installation type** page, choose **Role-based or feature-based deployment**.  
  
3.  On the **Select destination server** page, select the server on which you want to install Work Folders.  
  
4.  On the **Select server roles** page, expand **File and Storage Services**, expand **File and iSCSI Services**, and then select **Work Folders**.  
  
5.  When asked if you want to install **IIS Hostable Web Core**, click **Ok** to install the minimal version of Internet Information Services (IIS) required by Work Folders.  
  
6.  Click **Next** until you have completed the wizard.

To deploy the role by using Windows PowerShell, use the following cmdlet:
  
```powershell  
Add-WindowsFeature FS-SyncShareService  
```

## Step 4: Binding the SSL certificate on the sync servers
 Work Folders installs the IIS Hostable Web Core, which is an IIS component designed to enable web services without requiring a full installation of IIS. After installing the IIS Hostable Web Core, you should bind the SSL certificate for the server to the Default Web Site on the file server. However, the IIS Hostable Web Core does not install the IIS Management console.

 There are two options for binding the certificate to the Default Web Interface. To use either option you must have installed the private key for the certificate into the computer's personal store.

- Utilize the IIS management console on a server that has it installed. From within the console, connect to the file server you want to manage, and then select the Default Web Site for that server. The Default Web Site will appear disabled, but you can still edit the bindings for the site and select the certificate to bind it to that web site.

- Use the netsh command to bind the certificate to the Default Web Site https interface. The command is as follows:

    ```
    netsh http add sslcert ipport=<IP address>:443 certhash=<Cert thumbprint> appid={CE66697B-3AA0-49D1-BDBD-A25C8359FD5D} certstorename=MY
    ```

## Step 5: Create security groups for Work Folders
 Before creating sync shares, a member of the Domain Admins or Enterprise Admins groups needs to create some security groups in Active Directory Domain Services (AD DS) for Work Folders (they might also want to delegate some control as described in Step 6). Here are the groups you need:

- One group per sync share to specify which users are allowed to sync with the sync share

- One group for all Work Folders administrators so that they can edit an attribute on each user object that links the user to the correct sync server (if you're going to use multiple sync servers)

  Groups should follow a standard naming convention and should be used only for Work Folders to avoid potential conflicts with other security requirements.

  To create the appropriate security groups, use the following procedure multiple times – once for each sync share, and once to optionally create a group for file server administrators.

#### To create security groups for Work Folders

1. Open Server Manager on a Windows Server 2012 R2 or Windows Server 2016 computer with Active Directory Administration Center installed.

2.  On the **Tools** menu, click **Active Directory Administration Center**. Active Directory Administration Center appears.

3.  Right-click the container where you want to create the new group (for example, the Users container of the appropriate domain or OU), click **New**, and then click **Group**.

4.  In the **Create Group** window, in the **Group** section, specify the following settings:

    -   In **Group name**, type the name of the security group, for example: **HR Sync Share Users**, or **Work Folders Administrators**.  
  
    -   In **Group scope**, click **Security**, and then click **Global**.  
  
5.  In the **Members** section, click **Add**. The Select Users, Contacts, Computers, Service Accounts or Groups dialog box appears.  
  
6.  Type the names of the users or groups to which you grant access to a particular sync share (if you're creating a group to control access to a sync share), or type the names of the Work Folders administrators (if you're going to configure user accounts to automatically discover the appropriate sync server), click **OK**, and then click **OK** again.

To create a security group by using Windows PowerShell, use the following cmdlets:

```powershell  
$GroupName = "Work Folders Administrators"  
$DC = "DC1.contoso.com"  
$ADGroupPath = "CN=Users,DC=contoso,DC=com"  
$Members = "CN=Maya Bender,CN=Users,DC=contoso,DC=com","CN=Irwin Hume,CN=Users,DC=contoso,DC=com"  
  
New-ADGroup -GroupCategory:"Security" -GroupScope:"Global" -Name:$GroupName -Path:$ADGroupPath -SamAccountName:$GroupName -Server:$DC  
Set-ADGroup -Add:@{'Member'=$Members} -Identity:$GroupName -Server:$DC
```

## Step 6: Optionally delegate user attribute control to Work Folders administrators  
 If you are deploying multiple sync servers and want to automatically direct users to the correct sync server, you'll need to update an attribute on each user account in AD DS. However, this normally requires getting a member of the Domain Admins or Enterprise Admins groups to update the attributes, which can quickly become tiresome if you need to frequently add users or move them between sync servers.  
  
 For this reason, a member of the Domain Admins or Enterprise Admins groups might want to delegate the ability to modify the msDS-SyncServerURL property of user objects to the Work Folders Administrators group you created in Step 5, as described in the following procedure.  
  
#### Delegate the ability to edit the msDS-SyncServerURL property on user objects in AD DS  
  
1.  Open Server Manager on a Windows Server 2012 R2 or Windows Server 2016 computer with Active Directory Users and Computers installed.  
  
2.  On the **Tools** menu, click **Active Directory Users and Computers**. Active Directory Users and Computers appears.  
  
3.  Right-click the OU under which all user objects exist for Work Folders (if users are stored in multiple OUs or domains, right-click the container that is common to all of the users), and then click **Delegate Control…**. The Delegation of Control Wizard appears.  
  
4.  On the **Users or Groups** page, click **Add…** and then specify the group you created for Work Folders administrators (for example, **Work Folders Administrators**).  
  
5.  On the **Tasks to Delegate** page, click **Create a custom task to delegate**.  
  
6.  On the **Active Directory Object Type** page, click **Only the following objects in the folder**, and then select the **User objects** checkbox.  
  
7.  On the **Permissions** page, clear the **General** checkbox, select the **Property-specific** checkbox, and then select the **Read msDS-SyncServerUrl**, and **Write msDS-SyncServerUrl** checkboxes.

To delegate the ability to edit the msDS-SyncServerURL property on user objects by using Windows PowerShell, use the following example script that makes use of the DsAcls command.
  
```powershell  
$GroupName = "Contoso\Work Folders Administrators"  
$ADGroupPath = "CN=Users,dc=contoso,dc=com"  
  
DsAcls $ADGroupPath /I:S /G ""$GroupName":RPWP;msDS-SyncServerUrl;user"  
```  
  
> [!NOTE]
>  The delegation operation might take a while to run in domains with a large number of users.  
  
## Step 7: Create sync shares for user data  
 At this point, you're ready to designate a folder on the sync server to store your user's files. This folder is called a sync share, and you can use the following procedure to create one.  
  
1. If you don't already have an NTFS volume with free space for the sync share and the user files it will contain, create a new volume and format it with the NTFS file system.  
  
2. In Server Manager, click **File and Storage Services**, and then click **Work Folders**.  
  
3. A list of any existing sync shares is visible at the top of the details pane. To create a new sync share, from the **Tasks** menu choose **New Sync Share…**. The New Sync Share Wizard appears.  
  
4. On the **Select the server and path** page, specify where to store the sync share. If you already have a file share created for this user data, you can choose that share. Alternatively you can create a new folder.  
  
   > [!NOTE]
   >  By default, sync shares aren't directly accessible via a file share (unless you pick an existing file share). If you want to make a sync share accessible via a file share, use the **Shares** tile of Server Manager or the [New-SmbShare](https://technet.microsoft.com/library/jj635722.aspx) cmdlet to create a file share, preferably with access-based enumeration enabled.  
  
5. On the **Specify the structure for user folders** page, choose a naming convention for user folders within the sync share. There are two options available:  
  
   - **User alias** creates user folders that don't include a domain name. If you are using a file share that is already in use with Folder Redirection or another user data solution, select this naming convention. You can optionally select the **Sync only the following subfolder** checkbox to sync only a specific subfolder, such as the Documents folder.  
  
   - <strong>User alias@domain</strong> creates user folders that include a domain name. If you aren't using a file share already in use with Folder Redirection or another user data solution, select this naming convention to eliminate folder naming conflicts when multiple users of the share have identical aliases (which can happen if the users belong to different domains).  
  
6. On the **Enter the sync share name** page, specify a name and a description for the sync share. This is not advertised on the network but is visible in Server Manager and Windows Powershell to help distinguish sync shares from each other.  
  
7. On the **Grant sync access to groups** page, specify the group that you created that lists the users allowed to use this sync share.  
  
   > [!IMPORTANT]
   >  To improve performance and security, grant access to groups instead of individual users and be as specific as possible, avoiding generic groups such as Authenticated Users and Domain Users. Granting access to groups with large numbers of users increases the time it takes Work Folders to query AD DS. If you have a large number of users, create multiple sync shares to help disperse the load.  
  
8. On the **Specify device policies** page, specify whether to request any security restrictions on client PCs and devices. There are two device policies that can be individually selected:  
  
   -   **Encrypt Work Folders** Requests that Work Folders be encrypted on client PCs and devices  
  
   -   **Automatically lock screen, and require a password** Requests that client PCs and devices automatically lock their screens after 15 minutes, require a six-character or longer password to unlock the screen, and activate a device lockout mode after 10 failed retries  
  
       > [!IMPORTANT]
       >  To enforce password policies for Windows 7 PCs and for non-administrators on domain-joined PCs, use Group Policy password policies for the computer domains and exclude these domains from the Work Folders password policies. You can exclude domains by using the [Set-Syncshare -PasswordAutoExcludeDomain](https://technet.microsoft.com/library/dn296649\(v=wps.630\).aspx) cmdlet after creating the sync share. For information about setting Group Policy password policies, see [Password Policy](https://technet.microsoft.com/library/hh994572(v=ws.11).aspx).  
  
9. Review your selections and complete the wizard to create the sync share.

You can create sync shares using Windows PowerShell by using the [New-SyncShare](https://technet.microsoft.com/library/dn296635.aspx) cmdlet. Below is an example of this method:  
  
```powershell  
New-SyncShare "HR Sync Share" K:\Share-1 –User "HR Sync Share Users"  
```  
  
The example above creates a new sync share named *Share01* with the path *K:\Share-1*, and access granted to the group named *HR Sync Share Users*  
  
> [!TIP]
>  After you create sync shares you can use File Server Resource Manager functionality to manage the data in the shares. For example, you can use the **Quota** tile inside the Work Folders page in Server Manager to set quotas on the user folders. You can also use [File Screening Management](https://technet.microsoft.com/library/cc732074.aspx) to control the types of files that Work Folders will sync, or you can use the scenarios described in [Dynamic Access Control](https://technet.microsoft.com/windows-server-docs/identity/solution-guides/dynamic-access-control--scenario-overview) for more sophisticated file classification tasks.  
  
## Step 8: Optionally specify a tech support email address   
 After installing Work Folders on a file server, you probably want to specify an administrative contact email address for the server. To add an email address, use the following procedure:  
  
#### Specifying an administrative contact email 
  
1.  In Server Manager, click **File and Storage Services**, and then click **Servers**.  
  
2.  Right-click the sync server, and then click **Work Folders Settings**. The Work Folders Settings window appears.  
  
3.  In the navigation pane, click **Support Email** and then type the email address or addresses that users should use when emailing for help with Work Folders. Click **OK** when you're finished.  
  
     Work Folders users can click a link in the Work Folders Control Panel item that sends an email containing diagnostic information about the client PC to the address(es) you specify here.  
  
## Step 9: Optionally set up server automatic discovery  
 If you are hosting multiple sync servers in your environment, you should configure server automatic discovery by populating the **msDS-SyncServerURL** property on user accounts in AD DS.  
  
>[!NOTE]
>The msDS-SyncServerURL property in Active Directory should not be defined for remote users that are accessing Work Folders through a reverse proxy solution such as Web Application Proxy or Azure AD Application Proxy. If the msDS-SyncServerURL property is defined, the Work Folders client will try to access an internal URL that’s not accessible through the reverse proxy solution. When using Web Application Proxy or Azure AD Application Proxy, you need to create unique proxy applications for each Work Folders server. For more details, see [Deploying Work Folders with AD FS and Web Application Proxy: Overview](deploy-work-folders-adfs-overview.md) or [Deploying Work Folders with Azure AD Application Proxy](https://blogs.technet.microsoft.com/filecab/2017/05/31/enable-remote-access-to-work-folders-using-azure-active-directory-application-proxy/).


 Before you can do so, you must install a Windows Server 2012 R2 domain controller or update the forest and domain schemas by using the `Adprep /forestprep` and `Adprep /domainprep` commands. For information on how to safely run these commands, see [Running Adprep](https://technet.microsoft.com/library/dd464018.aspx).  
  
 You probably also want to create a security group for file server administrators and give them delegated permissions to modify this particular user attribute, as described in Step 5 and Step 6. Without these steps you would need to get a member of the Domain Admins or Enterprise Admins group to configure automatic discovery for each user.  
  
#### To specify the sync server for users  
  
1.  Open Server Manager on a computer with Active Directory Administration Tools installed.  
  
2.  On the **Tools** menu, click **Active Directory Administration Center**. Active Directory Administration Center appears.  
  
3.  Navigate to the **Users** container in the appropriate domain, right-click the user you want to assign to a sync share, and then click **Properties**.  
  
4.  In the Navigation pane, click **Extensions**.  
  
5.  Click the **Attribute Editor** tab, select **msDS-SyncServerUrl** and then click **Edit**. The Multi-valued String Editor dialog box appears.  
  
6.  In the **Value to add** box, type the URL of the sync server with which you want this user to sync, click **Add**, click **OK**, and then click **OK** again.  
  
    > [!NOTE]
    >  The sync server URL is simply `https://` or `http://` (depending on whether you want to require a secure connection) followed by the fully qualified domain name of the sync server. For example, **https:\//sync1.contoso.com**.

To populate the attribute for multiple users, use Active Directory PowerShell. Below is an example that populates the attribute for all members of the *HR Sync Share Users* group, discussed in Step 5.
  
```powershell  
$SyncServerURL = "https://sync1.contoso.com"  
$GroupName = "HR Sync Share Users"  
  
Get-ADGroupMember -Identity $GroupName |  
Set-ADUser –Add @{"msDS-SyncServerURL"=$SyncServerURL}  
  
```  
  
## Step 10: Optionally configure Web Application Proxy, Azure AD Application Proxy, or another reverse proxy  

To enable remote users to access their files, you need to publish the Work Folders server through a reverse proxy, making Work Folders available externally on the Internet. You can use Web Application Proxy, Azure Active Directory Application Proxy, or another reverse proxy solution.  
  
To configure Work Folders access using AD FS and Web Application Proxy, see [Deploying Work Folders with AD FS and Web Application Proxy (WAP)](deploy-work-folders-adfs-overview.md). For background information about Web Application Proxy, see [Web Application Proxy in Windows Server 2016](https://technet.microsoft.com/windows-server-docs/identity/web-application-proxy/web-application-proxy-windows-server). For details on publishing applications such as Work Folders on the Internet using Web Application Proxy, see [Publishing Applications using AD FS Preauthentication](https://technet.microsoft.com/windows-server-docs/identity/web-application-proxy/publishing-applications-using-ad-fs-preauthentication).
 
To configure Work Folders access using Azure Active Directory Application Proxy, see [Enable remote access to Work Folders using Azure Active Directory Application Proxy](https://blogs.technet.microsoft.com/filecab/?p=7945) 
  
## Step 11: Optionally use Group Policy to configure domain-joined PCs  

If you have a large number of domain-joined PCs to which you want to deploy Work Folders, you can use Group Policy to do the following client PC configuration tasks:  
  
- Specify which sync server users should sync with  
  
- Force Work Folders to be set up automatically, using default settings (review the Group Policy discussion in [Designing a Work Folders Implementation](plan-work-folders.md) before doing this)  
  
  To control these settings, create a new Group Policy object (GPO) for Work Folders and then configure the following Group Policy settings as appropriate:  
  
- "Specify Work Folders settings" policy setting in User Configuration\Policies\Administrative Templates\Windows Components\WorkFolders  
  
- "Force automatic setup for all users" policy setting in Computer Configuration\Policies\Administrative Templates\Windows Components\WorkFolders  
  
> [!NOTE]
>  These policy settings are available only when editing Group Policy from a computer running Group Policy Management on Windows 8.1, Windows Server 2012 R2 or later. Versions of Group Policy Management from earlier operating systems do not have this setting available. These policy settings do apply to Windows 7 PCs on which the [Work Folders for Windows 7](http://blogs.technet.com/b/filecab/archive/2014/04/24/work-folders-for-windows-7.aspx) app has been installed.  
  
##  <a name="BKMK_LINKS"></a> See also  
 For additional related information, see the following resources.  
  
|Content type|References|  
|------------------|----------------|  
|**Understanding**|-   [Work Folders](work-folders-overview.md)|  
|**Planning**|-   [Designing a Work Folders Implementation](plan-work-folders.md)|
|**Deployment**|-   [Deploying Work Folders with AD FS and Web Application Proxy (WAP)](deploy-work-folders-adfs-overview.md)<br />-   [Work Folders Test Lab Deployment](http://blogs.technet.com/b/filecab/archive/2013/07/10/work-folders-test-lab-deployment.aspx) (blog post)<br />-   [A new user attribute for Work Folders server Url](http://blogs.technet.com/b/filecab/archive/2013/10/09/a-new-user-attribute-for-work-folders-server-url.aspx) (blog post)|  
|**Technical Reference**|-   [Interactive logon: Machine account lockout threshold](https://technet.microsoft.com/library/jj966264(v=ws.11).aspx)<br />-   [Sync Share Cmdlets](https://docs.microsoft.com/powershell/module/syncshare/?view=win10-ps)|
