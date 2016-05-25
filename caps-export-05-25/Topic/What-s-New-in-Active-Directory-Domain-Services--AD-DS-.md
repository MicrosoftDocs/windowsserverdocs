---
title: What&#39;s New in Active Directory Domain Services (AD DS)
ms.custom: 
  - AD
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4ba7666f-dce6-42ad-888f-595743707434
author: Femila
---
# What&#39;s New in Active Directory Domain Services (AD DS)
You can use Active Directory Domain Services \(AD DS\) in Windows Server to more rapidly and easily deploy domain controllers \(on\-premises and in the cloud\), increase flexibility when auditing and authorizing access to files, and more easily perform administrative tasks at scale \(locally or remotely\) through consistent graphical and scripted management experiences.  
  
## What's New in Active Directory Domain Services in Windows Server 2012  
AD DS improvements in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] include:  
  
-   [Virtualization that just works](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_VirtualizationJustWorks)  
  
    [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides greater support for the capabilities of public and private clouds through virtualization\-safe technologies and the rapid deployment of virtual domain controllers through cloning.  
  
-   [Simplified deployment and upgrade preparation](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_SimplifiedDeployment)  
  
    The upgrade and preparation processes \(dcpromo and adprep\) have been replaced with a new streamlined domain controller promotion wizard that is integrated with Server Manager and built on Windows PowerShell. It validates prerequisites, automates forest and domain preparation, requires only a single set of logon credentials, and it can remotely install AD DS on a target server.  
  
-   [Simplified management](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_simplified_mang_adds)  
  
    Examples of simplified management include the integration of claims\-based authorization into AD DS and the Windows platform, two critical components of a broader feature known as Dynamic Access Control \(DAC\). DAC comprises central access policies, directory attributes, the Windows file\-classification engine, and compound\-identities that combine user and machine identity into one. In addition, the Active Directory Administrative Center \(ADAC\) now allows you to perform graphical tasks that automatically generate the equivalent Windows PowerShell commands. The commands can be easily copied and pasted into a script simplifying the automation of repetitive administrative actions.  
  
-   [AD DS Platform Changes](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_ad_platform_changes)  
  
    The AD DS platform comprises core functionality, including the “under\-the\-covers” behaviors that govern the components upon which the rest of the directory service is built. Updates to the AD DS platform include improved allocation and scale of RIDs \(relative identifiers\), deferred index creation, various Kerberos enhancements and support for Kerberos claims \(see [Dynamic Access Control](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_dynamic_access_control)\) in AD FS.  
  
Active Directory and AD DS has been at the center of IT infrastructure for over 10 years, and its features, adoption, and business\-value have grown release over release. Today, the majority of that Active Directory infrastructure remains on the premises, but there is an emerging trend toward cloud computing. The adoption of cloud computing, however, will not occur overnight, and migrating suitable on\-premises workloads or applications is an incremental and long\-term exercise. New hybrid infrastructures will emerge, and it is essential that AD DS support the needs of these new and unique deployment models that include services hosted entirely in the cloud, services that comprise cloud and on\-premises components, and services that remain exclusively on the premises. These hybrid models will increase the importance, visibility, and emphasis around security and compliance, and they will compound the already complex and time\-consuming exercise of ensuring that access to corporate data and services is appropriately audited and accurately expresses the business intent.  
  
The following sections describe how AD DS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] addresses these emerging needs.  
  
For more information about installing AD DS, see [Deploy Active Directory Domain Services \(AD DS\) in Your Enterprise](http://technet.microsoft.com/library/hh472160.aspx) and [Upgrade Domain Controllers to Windows Server 2012](http://technet.microsoft.com/library/hh994618.aspx).  
  
### <a name="BKMK_VirtualizationJustWorks"></a>Virtualization that just works  
  
#### Rapid deployment with cloning  
AD DS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] allows you to deploy replica virtual domain controllers by “cloning” existing virtual domain controllers. You can promote a single virtual domain controller by using the domain controller promotion interface in Server Manager, and then rapidly deploy additional virtual domain controllers within the same domain, through cloning.  
  
The process of cloning involves creating a copy of an existing virtual domain controller, authorizing the source domain controller to be cloned in AD DS, and running Windows PowerShell cmdlets to create a configuration file that contains detailed promotion instructions \(name, IP address, Domain Name System \[DNS\] servers, and so on\). Or you can leave the configuration file empty, which allows the system to automatically fill in the information. Cloning reduces the number of steps and time involved by eliminating repetitive deployment tasks, and it enables you to fully deploy additional domain controllers that are authorized and configured for cloning by the Active Directory domain administrator.  
  
For detailed information about virtualized domain controller cloning, see [Active Directory Domain Services \(AD DS\) Virtualization](http://go.microsoft.com/fwlink/p/?LinkId=238316).  
  
#### Safer virtualization of domain controllers  
AD DS has been virtualized for several years, but features present in most hypervisors can invalidate strong assumptions made by the Active Directory replication algorithms. Primarily, the logical clocks that are used by domain controllers to determine relative levels of convergence only go forward in time. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], a virtual domain controller uses a unique identifier that is exposed by the hypervisor. This is called the virtual machine GenerationID. The virtual machine GenerationID changes whenever the virtual machine experiences an event that affects its position in time. The virtual machine GenerationID is exposed to the virtual machine’s address space within its BIOS, and it is made available to the operating system and applications through a driver in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
During boot and before completing any transaction, a virtual domain controller running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] compares the current value of the virtual machine GenerationID against the value that it stored in the directory. A mismatch is interpreted as a “rollback” event, and the domain controller employs AD DS safeguards that are new in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. These safeguards allow the virtual domain controller to converge with other domain controllers, and they prevent the virtual domain controller from creating duplicate security principals. For [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] virtual domain controllers to gain this extra level of protection, the virtual domain controller must be hosted on a virtual machine GenerationID–aware hypervisor such as [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] with the Hyper\-V role.  
  
For detailed information about the virtualization\-safe technology feature, see [Active Directory Domain Services \(AD DS\) Virtualization](http://go.microsoft.com/fwlink/p/?LinkId=238316).  
  
### <a name="BKMK_SimplifiedDeployment"></a>Simplified deployment and upgrade preparation  
AD DS deployment in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] integrates all the required steps to deploy new domain controllers into a single graphical interface. It requires only one enterprise\-level credential, and it can prepare the forest or domain by remotely targeting the appropriate operations master roles. The new deployment process conducts extensive prerequisite validation tests that minimize the opportunity for errors that might have otherwise blocked or slowed the installation. The AD DS installation process is built on Windows PowerShell, integrated with Server Manager, able to target multiple servers, and remotely deploy domain controllers, which results in a deployment experience that is simpler, more consistent, and less time consuming. The following figure shows the AD DS Configuration Wizard in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
![](../Image/ADDS_SMI_TR_ForestReviewOptions.png)  
  
**Figure 1** AD DS Configuration Wizard  
  
An AD DS installation includes the following features:  
  
-   **Adprep.exe integration into the AD DS installation process.** Reduces the time required to install AD DS and reduces the chances for errors that might block domain controller promotion.  
  
-   **The AD DS server role installation, which is built on Windows PowerShell and can be run remotely on multiple servers.** Reduces the likelihood of administrative errors and the overall time that is required for installation, especially when you are deploying multiple domain controllers across global regions and domains.  
  
-   **Prerequisite validation in the AD DS Configuration Wizard.** Identifies potential errors before the installation begins. You can correct error conditions before they occur without the concerns that result from a partially complete upgrade.  
  
-   **Configuration pages grouped in a sequence that mirror the requirements of the most common promotion options, with related options grouped in fewer wizard pages.** Provides better context for making installation choices and reduces the number of steps and time that are required to complete the domain controller installation.  
  
-   **A wizard that exports a Windows PowerShell script that contains all the options that were specified during the graphical installation.** Simplifies the process by automating subsequent AD DS installations through automatically generated Windows PowerShell scripts.  
  
For detailed information about AD DS integration with Server Manager see [Deploy Active Directory Domain Services \(AD DS\) in Your Enterprise](http://go.microsoft.com/fwlink/p/?LinkId=238318).  
  
### <a name="BKMK_simplified_mang_adds"></a>Simplified management  
Numerous areas were addressed with a view towards simplifying AD DS management experience. These areas include:  
  
-   [Dynamic Access Control](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_dynamic_access_control)  
  
-   [DirectAccess Offline Domain Join](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_off_prem_domain_join)  
  
-   [Active Directory Federation Services (AD FS)](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_adfs_win8)  
  
-   [Windows PowerShell History Viewer](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_windows_powershell_his_viewer)  
  
-   [Active Directory Recycle Bin User Interface](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_recycle_bin_ui)  
  
-   [Fine-Grained Password Policy User Interface](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_fine_grained_passowrd_policy_ui)  
  
-   [Active Directory Replication and Topology Windows PowerShell cmdlets](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_ad_rep_top_cmdlets)  
  
-   [Active Directory Based Activation (AD BA)](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_actdir_adba)  
  
-   [Group Managed Service Accounts (gMSA)](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_group_managed_sa)  
  
#### <a name="BKMK_dynamic_access_control"></a>Dynamic Access Control  
Today, it is difficult to translate business\-intent using the existing authorization model. The existing capabilities of access control entries \(ACEs\) make it hard or impossible to fully express requirements. In addition, there are no central administration capabilities. Finally, modern\-day increases in regulatory and business requirements around compliance further compound the problem.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] AD DS addresses these challenges by introducing:  
  
-   A new claims\-based authorization platform that enhances, not replaces, the existing model, which includes:  
  
    -   User\-claims and device\-claims  
  
    -   User \+ device claims \(also known as compound identity\)  
  
-   New central access policies \(CAP\) model  
  
-   Use of file\-classification information in authorization decisions  
  
-   Easier access\-denied remediation experience  
  
-   Access policies and audit policies can be defined flexibly and simply:  
  
    -   IF `resource.Confidentiality` \= `high` THEN `audit.Success` WHEN `user.EmployeeType` \= `vendor`  
  
**Requirements**  
  
-   One or more [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controllers  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] file server  
  
-   Enable the claims\-policy in the Default Domain Controllers Policy  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Active Directory Administrative Center  
  
-   For device\-claims, compound ID must be switched on at the target service account by using Group Policy or editing the object directly  
  
For more information about Dynamic Access Control see the [Dynamic Access Control](http://go.microsoft.com/fwlink/p/?LinkId=238336) section of the technical library.  
  
#### <a name="BKMK_off_prem_domain_join"></a>DirectAccess Offline Domain Join  
The offline domain\-join feature that was added to AD DS in Windows Server 2008 R2 effectively allows client computers to be joined to a domain without requiring network connectivity to a domain controller, but the client computer could not also be preconfigured for DirectAccess as part of the domain join.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] AD DS provides the following improvements:  
  
-   Extends offline domain\-join by allowing the blob to accommodate DirectAccess prerequisites  
  
    -   Certs  
  
    -   Group Policies  
  
-   What does this mean?  
  
    -   A computer can now be domain\-joined over the Internet if the domain is DirectAccess enabled  
  
    -   Getting the blob to the non\-domain\-joined machine is an offline process and the responsibility of the administrator  
  
**Requirements**  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controllers  
  
For more information, see [DirectAccess Offline Domain Join](http://technet.microsoft.com/library/jj574150.aspx).  
  
#### <a name="BKMK_adfs_win8"></a>Active Directory Federation Services \(AD FS\)  
AD FS v2.0 shipped out\-of\-band of the Windows Server release. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], AD FS \(v2.1\) ships in\-the\-box as a server role. This provides:  
  
-   Simplified trust\-setup and automatic trust management  
  
-   SAML\-protocol support  
  
-   Extensible attribute store  
  
-   Allows claims to be sourced from anywhere in the enterprise  
  
-   Active Directory Lightweight Directory Service \(AD LDS\) and SQL attribute\-store providers supplied out\-of\-the\-box  
  
**Requirements**  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
For detailed information about AD FS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [AD FS](http://go.microsoft.com/fwlink/p/?LinkId=238320).  
  
#### <a name="BKMK_windows_powershell_his_viewer"></a>Windows PowerShell History Viewer  
Windows PowerShell is a key technology in creating a consistent experience between the command\-line and the graphical user interface. Windows PowerShell increases productivity, but also requires investment in learning how to use it.  
  
To minimize the learning investment, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes the new Windows PowerShell History Viewer. The benefits include:  
  
-   Allow administrators to view the Windows PowerShell commands executed when using the Active Directory Administrative Center. For example:  
  
    -   The administrator adds a user to a group  
  
    -   The UI displays the equivalent Windows PowerShell for Active Directory command  
  
    -   The administrator copies the resulting syntax and integrates it into a script  
  
    -   Reduces Windows PowerShell learning\-curve  
  
    -   Increases confidence in scripting  
  
    -   Further enhances Windows PowerShell discoverability  
  
**Requirements**  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Active Directory Administrative Center  
  
For more information about the Windows PowerShell History Viewer, see [Active Directory Administrative Center Enhancements](http://go.microsoft.com/fwlink/p/?LinkId=238331).  
  
#### <a name="BKMK_recycle_bin_ui"></a>Active Directory Recycle Bin User Interface  
The Active Directory Recycle Bin feature introduced with [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] provided an architecture permitting complete object recovery. Scenarios that require object recovery by using the Active Directory Recycle Bin are typically high\-priority, such as recovery from accidental deletions, for example, resulting in failed logons or work stoppages. But the absence of a rich, graphical user interface complicated its usage and slowed recovery.  
  
To address this challenge, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] AD DS has a user interface for the Active Directory Recycle Bin that provides the following advantages:  
  
-   Simplifies object recovery through the inclusion of a **Deleted Objects** node in the Active Directory Administrative Center \(ADAC\)  
  
    -   Deleted objects can now be recovered within the graphical user interface  
  
-   Reduces recovery\-time by providing a discoverable, consistent view of deleted object  
  
**Requirements**  
  
-   Recycle Bin requirements must be met:  
  
    -   [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] forest functional level  
  
    -   Recycle Bin optional\-feature must be enabled  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Active Directory Administrative Center  
  
-   Objects requiring recovery must have been deleted within Deleted Object Lifetime \(DOL\)  
  
    -   By default, DOL is set to 180 days  
  
For more information about the user interface for AD DS Recycle Bin, see [Active Directory Administrative Center Enhancements](http://go.microsoft.com/fwlink/p/?LinkId=238331).  
  
#### <a name="BKMK_fine_grained_passowrd_policy_ui"></a>Fine\-Grained Password Policy User Interface  
The Fine\-Grained Password Policy \(FGPP\) introduced with Windows Server 2008 provided more precise management of password\-policies. In order to leverage the feature, administrators had to manually create password\-settings objects \(PSOs\). It proved difficult to ensure that the manually defined policy\-values behaved as desired, which resulted in time\-consuming, trial and error administration.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]:  
  
-   Creating, editing and assigning PSOs now managed through the Active Directory Administrative Center  
  
-   Greatly simplifies management of password\-settings objects  
  
**Requirements**  
  
-   FGPP requirements must be met:  
  
    -   [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] domain functional level  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Active Directory Administrative Center  
  
For more information about the user interface for fine\-grained password policies, see [Active Directory Administrative Center Enhancements](http://go.microsoft.com/fwlink/p/?LinkId=238331).  
  
#### <a name="BKMK_ad_rep_top_cmdlets"></a>Active Directory Replication and Topology Windows PowerShell cmdlets  
Administrators require a variety of tools to manage Active Directory’s site topology  
  
-   repadmin  
  
-   ntdsutil  
  
-   Active Directory Sites and Services  
  
The usage of multiple tools results in an inconsistent experience that is difficult to automate.  
  
Using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] AD DS, administrators can:  
  
-   Manage replication and site\-topology with Windows PowerShell  
  
    -   Create and manage sites, site\-links, site\-link bridges, subnets and connections  
  
    -   Replicate objects between domain controllers  
  
    -   View replication metadata on object attributes  
  
    -   View replication failures  
  
-   Take advantage of a consistent and easily scriptable experience  
  
-   Compatible and interoperable with other Windows PowerShell cmdlets  
  
**Requirements**  
  
-   Active Directory Web Service \(also known as Active Directory Management Gateway for Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]\)  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controller or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] with the Role Administration Tools \(RSAT\) for AD DS and AD LDS installed  
  
For more information about the Windows PowerShell cmdlets to manage Active Directory topology and replication, see [Active Directory Replication and Topology Management Using Windows PowerShell](http://go.microsoft.com/fwlink/p/?LinkId=238337).  
  
#### <a name="BKMK_actdir_adba"></a>Active Directory Based Activation \(AD BA\)  
Today, Volume Licensing for Windows and Office requires Key Management Service \(KMS\) servers. That solution requires minimal training, and is a turnkey solution that covers about 90% of deployments.  
  
But there is complexity caused by the lack of a graphical administration console. The solution requires RPC traffic on the network, which complicates matters, and it does not support any kind of authentication. The end\-user licensing agreement \(EULA\) prohibits the customer from connecting the KMS server to any external network. For example, connectivity\-alone to the service equates to *activated*.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the Active Directory\-based activation provides the following improvements:  
  
-   Uses your existing Active Directory infrastructure to activate your clients  
  
    -   No additional machines required  
  
    -   No RPC requirement; uses LDAP exclusively  
  
    -   Includes RODCs  
  
-   Beyond installation and service\-specific requirements, no data is written back to the directory  
  
    -   Activating initial CSVLK \(customer\-specific volume license key\) requires:  
  
        -   One\-time contact with Microsoft Activation Services over the Internet \(identical to retail activation\)  
  
        -   Key entered using volume activation server role or using command line.  
  
        -   Repeat the activation process for additional forests up to 6 times by default  
  
-   Activation\-object maintained in configuration partition  
  
    -   Represents proof of purchase  
  
    -   Computers can be member of any domain in the forest  
  
-   All Windows 8 computers will automatically activate  
  
**Requirements**  
  
-   Only Windows 8 computers can leverage AD BA  
  
-   KMS and AD BA can coexist  
  
    -   You still need KMS if you require down\-level volume\-licensing  
  
-   Requires [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Active Directory schema, not [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controllers  
  
For more information about AD BA see the following:  
  
-   [Volume Activation Overview](http://technet.microsoft.com/library/hh831612.aspx)  
  
-   [Test Lab Guide: Demonstrate Volume Activation Services](http://technet.microsoft.com/library/hh831794.aspx)  
  
#### <a name="BKMK_group_managed_sa"></a>Group Managed Service Accounts \(gMSA\)  
Managed Service Accounts \(MSAs\) were introduced with [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. Clustered or load\-balanced services that needed to share a single security\-principal were unsupported. As a result, MSAs were not able to be used in many desirable scenarios.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes the following changes:  
  
-   Introduces a new security principal type known as a gMSA  
  
-   Services running on multiple hosts can run under the same gMSA account  
  
-   One or more [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controllers required  
  
    -   gMSAs can authenticate against any domain controllers that run any version of Windows Server  
  
    -   Passwords computed by Group Key Distribution Service \(GKDS\) running on all [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controllers  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] hosts using gMSAs obtain password and password\-updates from GKDS  
  
    -   Password retrieval limited to authorized computers  
  
-   Password\-change interval defined at gMSA account creation \(30 days by default\)  
  
-   Like MSAs, gMSAs are supported only by the Windows Service Control Manager \(SCM\) and IIS application pools  
  
**Requirements**  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Active Directory schema updated in forests containing gMSAs  
  
-   One or more [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controllers to provide password computation and retrieval  
  
-   Only services running on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can use gMSAs  
  
For more information about group managed service accounts. see [Managed Service Accounts](http://go.microsoft.com/fwlink/p/?LinkId=238339).  
  
### <a name="BKMK_ad_platform_changes"></a>AD DS Platform Changes  
Numerous platform changes were made around scalability, throttling, and security. These areas include:  
  
-   [AD DS Claims in AD FS](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_adds_claims_adfs)  
  
-   [Relative ID (RID) Improvements](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_relativeID)  
  
-   [Deferred Index Creation](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_deferred_index_creation)  
  
-   [Kerberos Enhancements](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_kerberos_enhancements)  
  
#### <a name="BKMK_adds_claims_adfs"></a>AD DS Claims in AD FS  
AD FS v2.0 is able to generate user\-claims directly from Windows NT tokens. AD FS v2.0 was also capable of further expanding claims based on attributes in AD DS and other attribute stores.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Kerberos tickets can be populated with user and device attributes serving as claims. AD FS 2.0 cannot read claims from Kerberos tickets. Therefore, a separate LDAP call to Active Directory must be made to source user\-attribute claims, and AD FS 2.0 cannot leverage device\-attribute claims at all.  
  
AD FS v2.1 in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is able to populate SAML tokens with user\- and device\-claims taken directly from the Kerberos ticket.  
  
**Requirements**  
  
-   Dynamic Access Control enabled and configured  
  
-   Compound ID must be switched on for the AD FS service account  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] AD FS v2.1  
  
For detailed information about AD FS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [AD FS](http://go.microsoft.com/fwlink/p/?LinkId=238320).  
  
#### <a name="BKMK_relativeID"></a>Relative ID \(RID\) Improvements  
The following RID improvements in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provide greater ability to react to any potential exhaustion of the global RID pool space:  
  
-   **Periodic RID consumption warning**  
  
    -   At 10% of remaining global space, system logs informational event  
  
        -   First event at 100,000,000 RIDs used, second event logged at 10% of remainder  
  
            -   Remainder \= 900,000,000  
  
            -   10% of remainder \= 90,000,000  
  
        -   Second event logged at 190,000,000  
  
            -   Existing RID consumption plus 10% of remainder  
  
    -   Events become more frequent as the global space is further depleted  
  
-   **RID Manager artificial ceiling protection mechanism**  
  
    -   A soft ceiling that is 90% of the global RID space and is not configurable  
  
    -   The soft ceiling is deemed as ”reached” when a RID pool containing the 90% RID is issued  
  
    -   Blocks further allocations of RID pools  
  
        -   When the ceiling is reached, system sets ***msDS\-RIDPoolAllocationEnabled*** attribute of the **RID Manager$** object to **FALSE**. An administrator must set it back to **TRUE** to override.  
  
    -   Log an event indicating that the ceiling is reached  
  
        -   An initial warning is logged when the global RID spaces reaches 80%  
  
    -   The attribute can only be set to **FALSE** by the **SYSTEM** and is mastered by the RID master \(for example, write it against the RID master\)  
  
        -   Domain Admin can set it back to TRUE  
  
            > [!NOTE]  
            > It is set to TRUE by default  
  
-   **Increased the global RID space per domain, doubling the number of security principals that can be created throughout the lifetime of a domain from 1 billion to 2 billion.**  
  
**Requirements**  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] RID master  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Domain Controllers  
  
For more information on RID improvements, see [Managing RID Issuance](../Topic/Managing-RID-Issuance.md).  
  
#### <a name="BKMK_deferred_index_creation"></a>Deferred Index Creation  
In the past, index creation could adversely impact domain controller performance. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces a new capability that allows forest administrators to defer index creation to a point in time they choose. By default, domain controllers create indices when they receive the appropriate schema change through replication. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], a new DSheuristic was introduced to control whether or not domain controllers defer index creation. The details are as follows:  
  
-   Setting the 19<sup>th</sup> byte to 1 causes any [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DC \(DCs that run earlier operating systems will ignore the setting\) to defer building indices until:  
  
    -   It receives the ***UpdateSchemaNow*** rootDSE mod \(triggers rebuild of the schema cache\)  
  
    -   It is rebooted \(which requires that the schema cache be rebuilt and, in turn, the deferred indices\)  
  
-   Any attribute that is in a deferred index state will be logged in the Event Log every 24 hours  
  
    -   **2944: Index deferred** – logged once  
  
    -   **2945: Index still pending** – logged every 24 hours  
  
    -   **1137: Index created** – logged once \(not a new event\)  
  
**Requirements**  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controllers  
  
#### <a name="BKMK_kerberos_enhancements"></a>Kerberos Enhancements  
  
-   [Kerberos Constrained Delegation across domains](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_kerb_const_del_domains)  
  
-   [Flexible Authentication Secure Tunneling (FAST)](../Topic/What-s-New-in-Active-Directory-Domain-Services--AD-DS-.md#BKMK_flexible_auth_secure_tunn)  
  
##### <a name="BKMK_kerb_const_del_domains"></a>Kerberos Constrained Delegation across domains  
Kerberos Constrained Delegation \(KCD\) was introduced with Windows Server 2003. KCD permits a service’s account \(*front\-end*\) to act on the behalf of users in multi\-tier applications for a limited set of *back\-end* services. For example:  
  
1.  User accesses web site as *user1*  
  
2.  User requests information from web site \(*front\-end*\) that requires the web server to query a SQL database *\(back\-end*\)  
  
3.  Access to this data is authorized according to who accessed the *front\-end*  
  
4.  In this case, the web service must impersonate *user1* when making the request to SQL  
  
The front\-end needed to be configured with the services \(by SPN\) to which it can impersonate users. Setup and administration requires Domain Admin credentials. KCD delegation only works for back\-end services in the same domain as the front\-end service\-accounts.  
  
The KCD in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] moves the authorization decision to the resource\-owners, which provides these advantages:  
  
-   Permits back\-end to authorize which front\-end service\-accounts can impersonate users against their resources  
  
-   Supports across\-domain, across\-forest scenarios  
  
-   No longer requires Domain Admin privileges  
  
    -   Requires only administrative permission to the back\-end service\-account  
  
**Requirements**  
  
-   Clients run Windows XP or later  
  
-   Client domain’s domain controllers running Windows Server 2003 or later  
  
-   Front\-end server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
-   One or more domain controllers in front\-end domain running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
-   One or more domain controllers in back\-end domain running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
-   Back\-end server account configured with the accounts that are permitted for impersonation  
  
    -   Not exposed through Active Directory Administrative Center  
  
    -   Configured through Windows PowerShell:  
  
        -   `New/Set-ADComputer [-name] <string> [-PrincipalsAllowedToDelegateToAccount <ADPrincipal[]>]`  
  
        -   `New/Set-ADServiceAccount [-name] <string> [-PrincipalsAllowedToDelegateToAccount <ADPrincipal[]>]`  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] schema update in back\-end server’s forest  
  
-   Back\-end application server running Windows Server 2003 or later  
  
For more information about Kerberos constrained delegation see the [Kerberos](http://go.microsoft.com/fwlink/p/?LinkID=238338) section of the technical library.  
  
##### <a name="BKMK_flexible_auth_secure_tunn"></a>Flexible Authentication Secure Tunneling \(FAST\)  
Today, offline dictionary attack against password\-based logons is possible. There is a relatively well\-known concern around Kerberos errors being spoofed. Clients may:  
  
-   Fallback to less\-secure legacy protocols  
  
-   Weaken their cryptographic key strength and\/or ciphers  
  
Kerberos in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports Flexible Authentication Secure Tunneling \(FAST\)  
  
-   Defined by RFC 6113  
  
-   Sometimes referred to as Kerberos armoring  
  
-   Provides a protected channel between a domain\-joined client and DC  
  
    -   Protects pre\-authentication data for user’s AS\_REQs  
  
        -   Uses LSK \(logon session key\) from computer’s TGT as shared secret  
  
        -   Note that computer authentication is NOT armored  
  
    -   Allows DCs to return authenticated Kerberos errors thereby protecting them from spoofing  
  
-   Once all Kerberos clients and DCs support FAST \(the admin’s decision to make\)  
  
    -   The domain can be configured to either require Kerberos armoring or use it upon request  
  
        -   Must first ensure all or enough DCs are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
        -   Enable the appropriate policy  
  
            -   “Support CBAC and Kerberos armoring”  
  
            -   “All DCs can support CBAC and Require Kerberos armoring”  
  
**Requirements**  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] servers  
  
-   Ensure that all domains the client uses including transited referral domains:  
  
    -   Enable the “Support CBAC and Kerberos armoring” policy for all [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DCs  
  
    -   Have a sufficient number of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DCs to support FAST  
  
-   Enable “Require FAST” policy on supported clients  
  
-   RFC\-compliant FAST interoperability requires [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain functional level  
  
## See also  
  
-   [Active Directory Domain Services Overview](../Topic/Active-Directory-Domain-Services-Overview.md)  
  
-   [What's New in Active Directory Domain Services in Windows Server 2008 R2](http://technet.microsoft.com/library/dd378796(v=ws.10).aspx)  
  
-   [What's New in Active Directory Domain Services in Windows Server 2008](http://technet.microsoft.com/library/cc755093(v=ws.10).aspx)  
  
