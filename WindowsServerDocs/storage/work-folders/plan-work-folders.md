---
ms.assetid: a7c39656-81ee-4c2b-80ef-4d017dd11b07
title: Planning a Work Folders deployment
ms.prod: windows-server
ms.technology: storage-work-folders
ms.topic: article
author: JasonGerend
manager: dongill
ms.author: jgerend
ms.date: 4/5/2017
description: How to plan a Work Folders deployment including system requirements and how to prepare your network environment.
---
# Planning a Work Folders deployment

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10, Windows 8.1, Windows 7

This topic explains the design process for a Work Folders implementation, and assumes that you have the following background:  
  
- Have a basic understanding of Work Folders (as described in [Work Folders](work-folders-overview.md))  
  
- Have a basic understanding of Active Directory Domain Services (AD DS) concepts  
  
- Have a basic understanding of Windows file sharing and related technologies  
  
- Have a basic understanding of SSL certificate usage  
  
- Have a basic understanding of enabling web access to internal resources via a web reverse proxy  
  
  The following sections will help you design your Work Folders implementation. Deploying Work Folders is discussed in the next topic, [Deploying Work Folders](deploy-work-folders.md).  
  
##  <a name="BKMK_SOFT"></a> Software requirements  

Work Folders has the following software requirements for file servers and your network infrastructure:  
  
-   A server running Windows Server 2012 R2 or Windows Server 2016 for hosting sync shares with user files  
  
-   A volume formatted with the NTFS file system for storing user files  
  
-   To enforce password policies on Windows 7 PCs, you must use Group Policy password policies. You also have to exclude the Windows 7 PCs from Work Folders password policies (if you use them).

-   A server certificate for each file server that will host Work Folders. These certificates should be from a certification authority (CA) that is trusted by your users—ideally a public CA.

-   (Optional) An Active Directory Domain Services forest with schema extensions in Windows Server 2012 R2 to support automatically referring PCs and devices to the correct file server when using multiple file servers. 
  
To enable users to sync across the Internet, there are additional requirements:  
  
-   The ability to make a server accessible from the Internet by creating publishing rules in your organization's reverse proxy or network gateway  
  
-   (Optional) A publicly registered domain name and the ability to create additional public DNS records for the domain  
  
-   (Optional) Active Directory Federation Services (AD FS) infrastructure when using AD FS authentication  
  
Work Folders has the following software requirements for client computers:  
  
-   Computers must be running one of the following operating systems:  
  
    -   Windows 10  
  
    -   Windows 8.1  
  
    -   Windows RT 8.1  
  
    -   Windows 7  
  
    -   Android 4.4 KitKat and later  
  
    -   iOS 10.2 and later  
  
-   Windows 7 PCs must be running one of the following editions of Windows:  
  
    -   Windows 7 Professional  
  
    -   Windows 7 Ultimate  
  
    -   Windows 7 Enterprise  
  
-   Windows 7 PCs must be joined to your organization's domain (they can't be joined to a workgroup).  
  
-   Enough free space on a local, NTFS-formatted drive to store all the user's files in Work Folders, plus an additional 6 GB of free space if Work Folders is located on the system drive, as it is by default. Work Folders uses the following location by default: **%USERPROFILE%\Work Folders**  
  
     However, users can change the location during setup (microSD cards and USB drives formatted with the NTFS file system are supported locations, though sync will stop if the drives are removed).  
  
     The maximum size for individual files is 10 GB by default. There is no per-user storage limit, although administrators can use the quotas functionality of File Server Resource Manager to implement quotas.  
  
-   Work Folders doesn't support rolling back the virtual machine state of client virtual machines. Instead perform backup and restore operations from inside the client virtual machine by using System Image Backup or another backup app.  
  
> [!NOTE]
>  Make sure to install the Windows 8.1 and Windows Server 2012 R2 General Availability update rollup on all Work Folders servers and any client computers running Windows 8.1 or Windows Server 2012 R2. For more information, see article [2883200](https://support.microsoft.com/kb/2883200) in the Microsoft Knowledge Base.  
  
## Deployment scenarios  
 Work Folders can be implemented on any number of file servers within a customer environment. This allows Work Folders implementations to scale based on customer needs and can result in highly individualized deployments. However, most deployments will fall into one of the following three basic scenarios.  
  
### Single-Site Deployment  
 In a single-site deployment, file servers are hosted within a central site in the customer infrastructure. This deployment type is seen most often in customers with a highly centralized infrastructure or with smaller branch offices that do not maintain local file servers. This deployment model can be easier for IT staff to administer, since all server assets are local, and internet ingress/egress is likely centralized at this location as well. However, this deployment model also relies on good WAN connectivity between the central site and any branch offices, and users in branch offices are vulnerable to an interruption of service due to network conditions.  
  
### Multiple-Site Deployment  
 In a multiple-site deployment, file servers are hosted in multiple locations within the customer's infrastructure. This could mean multiple datacenters or it could mean that branch offices maintain individual file servers. This deployment type is seen most often in larger customer environments or in customers that have several larger branch offices that maintain local server assets. This deployment model is more complex for IT personnel to administer, and relies on careful coordination of data storage and maintenance of Active Directory Domain Services (AD DS) to ensure that users are using the correct sync server for Work Folders.  
  
### Hosted Deployment  
 In a hosted deployment, sync servers are deployed in an IAAS (Infrastructure-as-a-Service) solution such as Windows Azure VM. This deployment method has the advantage of making the availability of file servers less dependent on WAN connectivity within a customer's business. If a device is able to connect to the Internet, it can get to its sync server. However, the servers deployed in the hosted environment still need to be able to reach the organization's Active Directory domain to authenticate users, and the customer trades infrastructure requirements on-premises for additional complexity in maintaining that connection.  
  
## Deployment technologies  
 Work Folders deployments consist of a number of technologies that work together to provide service to devices on both the internal and external networks. Before designing a Work Folders deployment, customers should be familiar with the requirements of each of the following technologies.  
  
### Active Directory Domain Services  
 AD DS provides two important services in a Work Folders deployment. First, as the back-end for Windows authentication, AD DS provides the security and authentication services that are used to grant access to user data. If a domain controller cannot be reached, a file server will be unable to authenticate an incoming request and the device will not be able to access any data stored in that file server's sync share.  
  
 Second, AD DS (with the Windows Server 2012 R2 schema update) maintains the msDS-SyncServerURL attribute on each user, which is used to automatically direct users to the appropriate sync server.  
  
### File Servers  
 File servers running Windows Server 2012 R2 or Windows Server 2016 host the Work Folders role service, and host the sync shares that store users' Work Folders data. File servers can also host data stored by other technologies operating on the internal network (such as file shares), and can be clustered to provide fault tolerance for user data.  
  
###  <a name="GroupPolicy"></a> Group Policy  
 If you have Windows 7 PCs in your environment, we recommend the following:  
  
- Use Group Policy to control password policies for all domain-joined PCs that use Work Folders.  
  
- Use the Work Folders **Automatically lock screen, and require a password** policy on PCs that aren't joined to your domain.  
  
  You can also use Group Policy to specify a Work Folders server to domain-joined PCs. This simplifies Work Folders setup a little bit– users would otherwise need to enter their work email address to lookup the settings (assuming that Work Folders is set up properly), or enter the Work Folders URL that you explicitly provided them via email or another means of communication.  
  
  You can also use Group Policy to forcibly set up Work Folders on a per-user or per-computer basis, though doing so causes Work Folders to sync on every PC a user signs in to (when using the per-user policy setting), and prevents users from specifying an alternate location for Work Folders on their PC (such as on a microSD card to conserve space on the primary drive). We suggest carefully evaluating your user's needs before forcing automatic setup.  
  
### Windows Intune  
 Windows Intune also provides a layer of security and manageability for non-domain-joined devices that would not otherwise be present. You can use Windows Intune to configure and manage users' personal devices such as tablets that connect to Work Folders from across the Internet. Windows Intune can provide devices with the sync server URL to use – otherwise users must enter their work email address to lookup the settings (if you publish a public Work Folders URL in the form of https://workfolders.<em>contoso.com</em>), or enter the sync server URL directly.  
  
 Without a Windows Intune deployment, users must configure external devices manually, which can result in increased demands on a customer's help desk staff.  
  
 You can also use Windows Intune to selectively wipe the data from Work Folders on a user's device without affecting the rest of their data – handy for if a user leaves your organization or has their device stolen.  
  
### Web Application Proxy/Azure AD Application Proxy  
 Work Folders is built around the concept of allowing Internet-connected devices to retrieve business data securely from the internal network, which allows users to "take their data with them" on their tablets and devices that would not normally be able to access work files. To do this, a reverse proxy must be used to publish sync server URLs and make them available to Internet clients. 
 
Work Folders supports using Web Application Proxy, Azure AD Application Proxy or 3rd party reverse proxy solutions: 

-  Web Application Proxy is an on-premises reverse proxy solution. To learn more, see [Web Application Proxy in Windows Server 2016](https://technet.microsoft.com/windows-server-docs/identity/web-application-proxy/web-application-proxy-windows-server).  
  
-  Azure AD Application Proxy is a cloud reverse proxy solution. To learn more, see [How to provide secure remote access to on-premises applications](https://docs.microsoft.com/azure/active-directory/active-directory-application-proxy-get-started)

## Additional design considerations  
 In addition to understanding each of the components noted above, customers need to spend time in their design thinking about the number of sync servers and shares to operate, and whether or not to leverage failover clustering to provide fault tolerance on those sync servers  
  
### Number of Sync Servers  
 It is possible for a customer to operate multiple sync servers in an environment. This can be a desirable configuration for several reasons:  
  
- Geographic distribution of users – for example, branch office files servers or regional datacenters  
  
- Data storage requirements – certain business departments might have specific data storage or handling requirements that are easier with a dedicated server  
  
- Load balancing – in large environments, storing user data on multiple servers can increase server performance and uptime.  
  
  For information on Work Folders server scaling and performance, see [Performance Considerations for Work Folders Deployments](https://blogs.technet.com/b/filecab/archive/2013/11/01/performance-considerations-for-large-scale-work-folders-deployments.aspx).  
  
> [!NOTE]
>  When using multiple sync servers, we recommend setting up automatic server discovery for users. This process relies upon the configuration of an attribute on each user account in AD DS. The attribute is named **msDS-SyncServerURL** and becomes available on user accounts after a Windows Server 2012 R2 domain controller is added to the domain or the Active Directory schema updates are applied. This attribute should be set for each user to ensure that users connect to the appropriate sync server. By using automatic server discovery, organizations can publish Work Folders behind a "friendly" URL such as *https://workfolders.contoso.com*, regardless of the number of sync servers in operation.  
  
### Number of Sync Shares  
 Individual sync servers can maintain multiple sync shares. This can be useful for the following reasons:  
  
-   Auditing and security requirements – If data used by a certain department must be more heavily audited or retained for a longer period of time, separate sync shares can help administrators keep user folders with differing audit levels separated.  
  
-   Differing quotas or file screens – If you want to set different storage quotas or limits on which file types are allowed in Work Folders (file screens) for different groups of users, separate sync shares can help.  
  
-   Departmental control – If administrative duties are distributed by department, utilizing separate shares for different departments can aid administrators in enforcing quotas or other policies.  
  
-   Differing device policies –If an organization needs to maintain multiple device policies (such as encrypting Work Folders) for different groups of users, using multiple shares enables this.  
  
-   Storage capacity –If a file server has multiple volumes, additional shares can be used to take advantage of these additional volumes. An individual share has access to only the volume that it is hosted on, and is unable to take advantage of additional volumes on a file server.  
  
#### Access to Sync Shares  

While the sync server that a user accesses is determined by the URL entered at their client (or the URL published for that user in AD DS when using server automatic discovery), access to individual sync shares is determined by the permissions present on the share.  
  
As a result, if a customer is hosting multiple sync shares on the same server, care must be taken to ensure that individual users have permissions to access only one of those shares. Otherwise, when users connect to the server, their client may connect to the wrong share. This can be accomplished by creating a separate security group for each sync share.  
  
Further, access to an individual user's folder inside a sync share is determined by ownership rights on the folder. When creating a sync share, Work Folders by default grants users exclusive access to their files (disabling inheritance and making them the owner of their individual folders).  
  
## Design checklist  

The following set of design questions is intended to aid customers in designing a Work Folders implementation that best serves their environment. Customers should work through this checklist prior to attempting to deploy servers.  
  
-   Intended Users  
  
    -   Which users will use Work Folders?  
  
    -   How are users organized? (Geographically, by office, by department, etc)  
  
    -   Do any users have special requirements for data storage, security, or retention?  
  
    -   Do any users have specific device policy requirements, such as encryption?  
  
    -   Which client computers and devices do you need to support? (Windows 8.1, Windows RT 8.1, Windows 7)  
  
         If you're supporting Windows 7 PCs and want to use password policies, exclude the domain storing their computer accounts from the Work Folders password policy, and instead use Group Policy password policies for domain-joined PCs in that domain.  
  
    -   Do you need to interoperate with or migrate from other user data management solutions such as Folder Redirection?  
  
    -   Do users from multiple domains need to sync across the Internet with a single server?  
  
    -   Do you need to support users who aren't members of the Local Administrators group on their domain-joined PCs? (If so, you'll need to exclude the relevant domains from Work Folders device policies such as encryption and password policies)  
  
-   Infrastructure and Capacity Planning  
  
    -   In what sites should sync servers be located on the network?  
  
    -   Will any sync servers be hosted by an Infrastructure as a Service (IaaS) provider such as in an Azure VM?  
  
    -   Will dedicated servers be needed for any specific user groups, and if so, how many users for each dedicated server?  
  
    -   Where are the Internet ingress/egress points on the network?  
  
    -   Will sync servers be clustered for fault-tolerance?  
  
    -   Will sync servers need to maintain multiple data volumes to host user data?  
  
-   Data Security  
  
    -   Will multiple sync shares need to be created on any sync servers?  
  
    -   What groups will be used to provide access to sync shares?  
  
    -   If you're using multiple sync servers, what security group will you create for the delegated ability to modify the msDS-SyncServerURL property of user objects?  
  
    -   Are there any special security or auditing requirements for individual sync shares?  
  
    -   Is multi-factor authentication (MFA) required?  
  
    -   Do you need the ability to remotely wipe Work Folders data from PCs and devices?  
  
-   Device Access  
  
    -   What URL will be used to provide access for Internet-based devices (*the default URL that is required for email-based automatic server discovery is workfolders.domainname*)?  
  
    -   How will the URL be published to the Internet?  
  
    -   Will automatic server discovery be used?  
  
    -   Will Group Policy be used to configure domain-joined PCs?  
  
    -   Will Windows Intune be used to configure external devices?  
  
    -   Will Device Registration be required for devices to connect?  
  
## Next steps  
 After designing your Work Folders implementation, it's time to deploy Work Folders. For more information, see [Deploying Work Folders](deploy-work-folders.md).  
  
## See also  
 For additional related information, see the following resources.  
  
|Content type|References|  
|------------------|----------------|  
|**Product evaluation**|-   [Work Folders](work-folders-overview.md)<br />-   [Work Folders for Windows 7](https://blogs.technet.com/b/filecab/archive/2014/04/24/work-folders-for-windows-7.aspx) (blog post)|  
|**Deployment**|-   [Designing a Work Folders Implementation](plan-work-folders.md)<br />-   [Deploying Work Folders](deploy-work-folders.md)<br />-   [Deploying Work Folders with AD FS and Web Application Proxy (WAP)](deploy-work-folders-adfs-overview.md)<br />- [Deploying Work Folders with Azure AD Application Proxy](https://blogs.technet.microsoft.com/filecab/2017/05/31/enable-remote-access-to-work-folders-using-azure-active-directory-application-proxy/)<br />-   [Performance Considerations for Work Folders Deployments](https://blogs.technet.com/b/filecab/archive/2013/11/01/performance-considerations-for-large-scale-work-folders-deployments.aspx)<br />-   [Work Folders for Windows 7 (64 bit download)](https://www.microsoft.com/download/details.aspx?id=42558)<br />-   [Work Folders for Windows 7 (32 bit download)](https://www.microsoft.com/download/details.aspx?id=42559)<br />-   [Work Folders Test Lab Deployment](https://blogs.technet.com/b/filecab/archive/2013/07/10/work-folders-test-lab-deployment.aspx) (blog post)|
