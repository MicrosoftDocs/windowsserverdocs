---
title: Upgrade Domain Controllers: Microsoft Support Quick Start for Adding Windows Server 2008 or Windows Server 2008 R2 Domain Controllers to Existing Domains
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 255b83fa-5f20-455a-b6b0-bef198979268
author: Femila
---
# Upgrade Domain Controllers: Microsoft Support Quick Start for Adding Windows Server 2008 or Windows Server 2008 R2 Domain Controllers to Existing Domains
This topic explains the process for upgrading domain controllers to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. This information is based on the experience of the Microsoft Customer Service and Support \(CSS\) team. This topic includes links to related information about the upgrade process.  
  
To obtain a copy of this guide in a printable .doc file format, see [Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains](http://go.microsoft.com/fwlink/?LinkId=178585) at the Microsoft Download Center \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178585\).  
  
-   [What’s new in AD DS in Windows Server 2008 and Windows Server 2008 R2](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Whatsnew)  
  
-   [System requirements for installing Windows Server 2008 and Windows Server 2008 R2](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_SystemReq)  
  
-   [Supported in\-place upgrade paths](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_SupportedUpgrade)  
  
-   [Functional level features and requirements and considerations for operations master roles](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_FL)  
  
-   [Client, server, and application interoperability](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_OSInterop)  
  
-   [Read\-only Domain Controllers](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_RODC)  
  
-   [Networking and name resolution](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Networking)  
  
-   [Known issues for upgrades to Windows Server 2008 and Windows Server 2008 R2](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_KnownIssues)  
  
-   [Secure default settings in Windows Server 2008 and Windows Server 2008 R2](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_SecureDefault)  
  
-   [Virtualized domain controllers on Hyper\-V, VMWARE, and other virtualization software](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_VM)  
  
-   [Administration, remote administration, and cross\-version administration](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Admin)  
  
-   [Configuring the Windows Time service for Windows Server 2008 and Windows Server 2008 R2](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Time)  
  
-   [Verifications you can make and recommended hotfixes you can install before you begin](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Begin)  
  
-   [Run Adprep commands](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_RunAdprep)  
  
-   [Upgrade domain controllers](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Upgrade)  
  
-   [Troubleshooting errors](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Tshoot)  
  
## <a name="BKMK_Whatsnew"></a>What’s new in AD DS in Windows Server 2008 and Windows Server 2008 R2  
The following table has links to more information about new features and functionality in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
|Operating system|What’s new|  
|--------------------|--------------|  
|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]|For information about each feature, special considerations, and how to prepare for deployment, see [Changes in Functionality from Windows Server 2003 with Service Pack 1 \(SP1\) to Windows Server 2008](http://go.microsoft.com/fwlink/?LinkId=164410) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164410\).<br /><br />For information about specific features in Active Directory Domain Services \(AD DS\) in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see [Active Directory Domain Services Role](http://go.microsoft.com/fwlink/?LinkId=164414) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164414\).<br /><br />Some functionality that was available in previous versions of Windows Server is deprecated in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. For example, SMTP Replication is removed by default. For more information, see [article 947057](http://go.microsoft.com/fwlink/?LinkId=164416) in the Microsoft Knowledge base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164416\). The Browser Service is disabled by default in Windows Server 2008 and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers.|  
|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|For information about each feature, special considerations, and how to prepare for deployment, see [Changes in Functionality from Windows Server 2008 to Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkID=139049) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=139049\). For information about specific features in AD DS in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [What's New in Active Directory Domain Services](http://go.microsoft.com/fwlink/?LinkID=139655) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=139655\).<br /><br />In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Dcpromo.exe does not allow the creation of a domain that has a single\-label Domain Name System \(DNS\) name. If you try to promote an additional domain controller in a domain that has a single\-label DNS name \(such as contoso, instead of contoso.com\), the check box to install a DNS server is not available in Dcpromo.exe. Upgrading Windows Server 2003 domain controllers in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] single\-label domains is supported. Promoting additional [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers into existing single\-label DNS domains is supported.<br /><br />[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] does not support MSMQ in domain mode for Windows NT 4 and Windows 2000 MSMQ clients running against [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers that have no [!INCLUDE[server2003all](../Token/server2003all_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controllers in the same environment.<br /><br />For more information about other functionality in [!INCLUDE[server2003all](../Token/server2003all_md.md)] that is deprecated in [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Deprecated Features for Windows 7 and Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=177815) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=177815\).|  
  
For more information about other known issues for AD DS, see [Known Issues for Installing and Removing AD DS](http://go.microsoft.com/fwlink/?LinkId=164418) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164418\).  
  
## <a name="BKMK_SystemReq"></a>System requirements for installing Windows Server 2008 and Windows Server 2008 R2  
For system requirements for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see “System Requirements” in [Installing Windows Server 2008](http://go.microsoft.com/fwlink/?LinkId=164421) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164421\).  
  
For disk\-space requirements for AD DS in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see [Disk space and component location issues](http://go.microsoft.com/fwlink/?LinkId=164423) in Known Issues for Installing and Removing AD DS \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164423\).  
  
For system requirements for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Installing Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkID=160341) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=160341\).  
  
For disk\-space requirements for AD DS in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Disk space and component location issues](http://go.microsoft.com/fwlink/?LinkID=164423) in Known Issues for Installing and Removing AD DS \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164423\).  
  
The AD DS database \(Ntds.dit\) on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers can be larger than in previous versions of Windows, for the following reasons:  
  
-   There are changes in the online defragmentation process on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers.  
  
-   [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] **Adprep \/forestprep** adds two new indices on the large link table.  
  
-   The [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] Active Directory Recycle Bin feature, when it is enabled, preserves attributes on deleted objects for the recycled object lifetime.  
  
The Active Directory database on a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller that is promoted into a Windows 2000 domain should be a size that is similar to the size of the Active Directory databases on the Windows 2000 domain controllers. While [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] additions increase the database size, the addition of a single\-instance store that is supported by domain controllers that run Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, or Windows Server 2008 R2 offsets that increase. [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers are estimated to be 10 percent larger than [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controllers, not counting the Active Directory Recycle Bin.  
  
In a production [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain at Microsoft, the Active Directory Recycle Bin feature increased the database size by an additional 15 to 20 percent of the original AD DS database size, using the default **deletedObjectLifetime** and **recycledObjectLifetime** values of 180 days. Additional space requirements depend on the size and count of the objects that can be recycled.  
  
If an in\-place upgrade to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] rolls back silently to the previous operating system version, check for sufficient free disk space on the partitions that host the AD DS database and log files.  
  
## <a name="BKMK_SupportedUpgrade"></a>Supported in\-place upgrade paths  
For upgrades to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see “Supported upgrade paths” in [Guide for Upgrading to Windows Server 2008](http://go.microsoft.com/fwlink/?LinkID=146616) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=146616\).  
  
For upgrades to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see “Supported upgrade paths” in [Installing Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkID=160341) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=160341\) and [Windows Server 2008 R2 Upgrade Paths](http://go.microsoft.com/fwlink/?LinkID=154894) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=154894\).  
  
When you upgrade existing domain controllers or promote new domain controllers into existing domains, consider the following:  
  
-   Computers running Windows NT 4 or Windows 2000 Server cannot be in\-place upgraded to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   In\-place upgrades from Windows Server 2003 or Windows Server 2003 R2 to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] are supported \(subject to supported [Windows Server 2008 R2 Upgrade Paths](http://go.microsoft.com/fwlink/?LinkId=205863)\), with the following exception: x86\-based operating systems cannot be in\-place upgraded to x64\-based versions of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] \(which only runs on x64\-based computers\).  
  
-   An x64\-based version of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] can be in\-place upgraded to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   A writeable domain controller cannot be upgraded to be an RODC. The reverse is also true.  
  
-   A server that runs the full installation of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] cannot be upgraded to be a server that runs a Server Core installation of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. The reverse is also true.  
  
-   The best practice for adding new operating systems hosting the domain controller role is to promote replica domain controllers \(as opposed to in\-place upgrading existing DCs\). Transfer FSMO roles and install additional server roles as required.  
  
-   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] both auto\-install Internet Protocol version 6 \(IPv6\). Do not arbitrarily disable or remove IPv6.  
  
[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] does not allow outbound trusts to be created between domains that have domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and Windows NT 4 domains. [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] inbound trusts with Windows NT 4.0 domains can be made to work but are not tested or supported. This can have an impact on the sequence in which you choose to upgrade domains and domain controllers.  
  
For example, suppose a domain with Windows Server 2003 domain controllers has a trust with a domain that has Windows NT 4 domain controllers. In this situation, you need to replace the domain controllers in the Windows NT 4 domain with domain controllers that run Windows 2000 or later before you upgrade or replace domain controllers in the Windows Server 2003 domain. If the domain controllers in the Windows Server 2003 domain are replaced or upgraded first in this situation, the trust between the domains will no longer function.  
  
first  
  
If you replace domain controllers, use the metadata cleanup method in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. Manually remove DNS and Windows Internet Name Service \(WINS\) records for the original role holder. For more information, see [Clean Up Server Metadata](http://go.microsoft.com/fwlink/?LinkID=148150) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=148150\).  
  
If you want to migrate the AD DS server role, DNS server roles, IP address, computer name, and supporting configuration state, from an existing server to a new Windows Server 2008 or Windows Server 2008 R2 destination server, see [AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles](http://go.microsoft.com/fwlink/?LinkId=177812) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=177812\). For example, refer to this article if you want to ensure that the new server has the same IP address or server name as the legacy server, or if you have made configuration changes, such as registry changes or file\-based DNS zones, on the legacy DNS server and you want them retained on the new DNS server.  
  
## <a name="BKMK_FL"></a>Functional level features and requirements and considerations for operations master roles  
Features that are enabled for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain and forest functional levels are documented in [Understanding Domain and Forest Functionality](http://go.microsoft.com/fwlink/?LinkId=164555) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164555\). Domain and forest functional level requirements for the deployment of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers are as follows:  
  
-   **Adprep \/forestprep** does not have any domain or forest functional level requirements.  
  
    > [!NOTE]  
    > The import of PAS.LDF, which is normally completed by running **Adprep \/forestprep**, requires a forest functional level higher than Windows 2000. If PAS.LDF is not imported because Adprep \/forestprep was run when the forest functional level was Windows 2000, then a search using Active Directory Users and Computers for BitLocker Recovery Password can unexpectedly return 0 results. For more information, see [Troubleshooting: Active Directory Users and Computers unexpectedly returns 0 results when searching for BitLocker Recovery Password](http://social.technet.microsoft.com/wiki/contents/articles/3345.aspx).  
  
-   **Adprep \/domainprep** requires a Windows 2000 native or higher domain functional level in each target domain.  
  
-   **Adprep \/rodcprep** does not have any functional\-level requirements.  
  
-   You can install Windows 2000, Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers in the same domain or forest without any functional\-level requirement.  
  
-   The promotion of read\-only domain controllers \(RODCs\) requires Windows Server 2003 forest functional level or higher.  
  
There are new well\-known and built\-in groups that area created after you upgrade or transfer the domain controller that holds the role of the primary domain controller \(PDC\) emulator master in each domain in the forest to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or after you add a read\-only domain controller \(RODC\) to your domain. For more information, see [Appendix A: Background Information for Upgrading Active Directory Domains](../Topic/Appendix-A--Background-Information-for-Upgrading-Active-Directory-Domains.md).  
  
There are no changes in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to recommendations for placing operations master roles \(also known as flexible single master operations or FSMO\). For more information about current recommendations, see [Planning Operations Master Role Placement](http://go.microsoft.com/fwlink/?LinkId=185222) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185222\).  
  
## <a name="BKMK_OSInterop"></a>Client, server, and application interoperability  
  
|Client Operating Systems|Domain Controller Operating Systems|  
|----------------------------|---------------------------------------|  
||Windows NT 4|Windows 2000 Server|Windows Server 2003|Windows Server 2003 R2|Windows Server 2008|Windows Server 2008 R2|Comments|  
|Windows NT 4|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Not tested by Windows product groups and therefore not supported. CSS can provide best\-effort support, but escalation support or hotfixes will not be provided.<br /><br />Improved default security settings block domain join and maintaining a secure channel. Although not recommended, those operations can work after default security settings are relaxed. For more information, see [article 942564](http://go.microsoft.com/fwlink/?LinkId=164558) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164558\).|Secure channels between computers running Windows NT 4.0 and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] are not tested by Windows product groups and are therefore not supported. Affected operations include validation of trusts, creation of outbound trusts, domain joins, and authentications over secure channels. CSS can provide best\-effort support, but escalation support or hotfixes will not be provided.<br /><br />Improved default security settings block establishing and maintaining domain join and a secure channel but those operations can work after default security settings are changed.<br /><br />For more information about outbound trusts between [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and Windows NT 4 domains, see [article 2021766](http://go.microsoft.com/fwlink/?LinkID=205835) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=205835\).|AllowNT4Crypto policy is set to 0 by default on domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. For more information, see [Secure default settings in Windows Server 2008 and Windows Server 2008 R2](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_SecureDefault).|  
|Windows 2000|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Not tested by Windows product groups and therefore not supported, but there are no known issues. CSS can provide best\-effort support, but escalation support or hotfixes will not be provided.|Not tested by Windows product groups and therefore not supported, but there are no known issues. CSS can provide best\-effort support, but escalation support or hotfixes will not be provided.||  
|Windows XP|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|See [article 944043](http://go.microsoft.com/fwlink/?LinkID=122974) if you are deploying RODCs.|  
|Windows Server 2003|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|See [article 944043](http://go.microsoft.com/fwlink/?LinkID=122974) if you are deploying RODCs.|  
|Windows Server 2003 R2|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported||  
|Windows Vista|Not tested by Windows product groups and therefore not supported. CSS can provide best\-effort support, but escalation support or hotfixes are not provided.<br /><br />The domain controller operating system is beyond its supported lifecycle.|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|[Unable to Join Windows Server 2008 R2 or Windows 7 Computer to Active Directory Domain](http://go.microsoft.com/fwlink/?LinkId=192570) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192570\)|  
|Windows Server 2008|Not tested by Windows product groups and therefore not supported. CSS can provide best\-effort support, but escalation support or hotfixes are not provided.<br /><br />The domain controller operating system is beyond its supported lifecycle.|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|[Unable to Join Windows Server 2008 R2 or Windows 7 Computer to Active Directory Domain](http://go.microsoft.com/fwlink/?LinkId=192570) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192570\)|  
|Windows 7|Hard\-block and cannot be made to work<br /><br />The domain controller operating system is beyond its supported lifecycle.|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|[Windows 7 and Samba 3 Interoperability](http://go.microsoft.com/fwlink/?LinkId=192568) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192568\)<br /><br />[Unable to Join Windows Server 2008 R2 or Windows 7 Computer to Active Directory Domain](http://go.microsoft.com/fwlink/?LinkId=192570) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192570\)|  
|Windows Server 2008 R2|Not tested by Windows product groups and therefore not supported. CSS can provide best\-effort support, but escalation support or hotfixes are not provided.<br /><br />The domain controller operating system is beyond its supported lifecycle.<br /><br />For more information about outbound trusts between [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and Windows NT 4 domains, see [article 2021766](http://go.microsoft.com/fwlink/?LinkID=205835) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=205835\).|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|Fully tested and supported|[Windows 7 and Samba 3 Interoperability](http://go.microsoft.com/fwlink/?LinkId=192568) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192568\)<br /><br />[Unable to Join Windows Server 2008 R2 or Windows 7 Computer to Active Directory Domain](http://go.microsoft.com/fwlink/?LinkId=192570) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192570\)|  
  
-   The following table lists supportability information for client operating systems that interact with domain controllers.  
  
-   Windows XP, Windows Server 2003, Windows Vista, and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] client computers are fully compatible with writable [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers. For member\-computer interoperability with RODCs, see [Known Issues for Deploying RODCs](http://go.microsoft.com/fwlink/?LinkID=164418) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164418\).  
  
-   For more information about which versions of Microsoft Exchange Server can interoperate with different versions of Windows, see [Exchange Server Supportability Matrix](http://go.microsoft.com/fwlink/?LinkID=165034) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=165034\).  
  
-   The Group Chat feature in Office Communications Server 2007 R2 does not work in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domains. For more information, see [article 982020](http://go.microsoft.com/fwlink/?LinkId=190459) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=190459\), For more information about using Office Communications Server 2007 R2 with domain controllers that have different versions of Windows Server and different domain and forest functional levels, see [Supported Active Directory Environments by Office Communications Server Version](http://go.microsoft.com/fwlink/?LinkId=190457) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=190457\).  
  
-   For a list of applications that are compatible or incompatible with [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see [article 948680](http://go.microsoft.com/fwlink/?LinkId=184903) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184903\) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184903\).  
  
-   For a list of applications that are compatible or incompatible with [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Microsoft Server Applications Supported on Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=184918) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184918\).  
  
-   For a list of applications that are compatible with RODCs, see [Applications That Are Known to Work with RODCs](http://go.microsoft.com/fwlink/?LinkID=133779) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133779\). Exchange Server requires a writable domain controller; therefore, it does not work with RODCs.  
  
-   It is not required to upgrade a certification authority \(CA\) that runs Windows Server 2003 when you upgrade domain controllers that run Windows Server 2003. But [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] provide many new features and improvements related to CAs. For more information about what is new in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see [Active Directory Certificate Services Role](http://technet.microsoft.com/library/cc753254(WS.10).aspx) \(http:\/\/technet.microsoft.com\/library\/cc753254\(WS.10\).aspx\). For more information about what is new in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [What's New in Active Directory Certificate Services](http://technet.microsoft.com/en-us/library/dd448537(WS.10).aspx)\(http:\/\/technet.microsoft.com\/library\/dd448537\(WS.10\).aspx\).  
  
-   For information about how to move a CA from an older server to a new server, see [AD CS Migration: Migrating the Certification Authority](http://technet.microsoft.com/library/ee126140(WS.10).aspx). For information about how to move a Certificate Server database and log files, see [article 238193](http://go.microsoft.com/fwlink/?LinkId=185023) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185023\) in the Microsoft Knowledge Base.  
  
-   VM guests fail to start with error "insufficient system resources" when the AD DS server role is added to a RemoteFX\-enabled Windows Server 2008 R2 SP1 Hyper\-V host computer. The best practice is to not install the AD DS \(domain controller\) role on a computer that also hosts the Hyper\-V server role. If you must have the Hyper\-V and the AD DS roles installed on the same physical computer, do not install RemoteFX, a subcomponent of the Remote Desktop Virtual host.  
  
-   Windows Vista and Windows Server 2008 and later operating systems use a higher range of ports for outgoing connections than previous versions of Windows. The new default start port is 49152, and the default end port is 65535. If you receive errors indicating that “the endpoint mapper is out of endpoints,” especially after retiring domain controllers that run Windows 2000 or Windows Server 2003, you might need to reconfigure firewalls and routers to use the new default port range. For more information, see [article 929851](http://go.microsoft.com/fwlink/?LinkID=153117) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=153117\).  
  
## <a name="BKMK_RODC"></a>Read\-only Domain Controllers  
This section covers hotfixes and known issues that are related to read\-only domain controllers \(RODCs\).  
  
[KB 944043](http://support.microsoft.com/kb/944043): Windows Server 2008 RODC compatibility pack. This set of hotfixes addresses several known issues that affect RODCs. It is also applicable to RODCs that run Windows Server 2008 R2.  
  
[KB 2641192](http://support.microsoft.com/kb/2641192): The badPwdCount attribute is not reset to 0 on a Windows Server 2008 R2\-based or Windows Server 2008\-based PDC when the reset request is sent from an RODC.  
  
[KB 983531](http://support.microsoft.com/kb/983531): You experience a significant delay when you try to log on to an Active Directory site from a computer that is running Windows 7 or Windows Server 2008 R2  
  
## <a name="BKMK_Networking"></a>Networking and name resolution  
This section covers considerations for using IPv6 and hotfixes and known issues for DNS servers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
### DNS server hotfixes and known issues  
The following table lists known issues for DNS servers and how to resolve them, including applicable hotfixes.  
  
|Known Issue|How to resolve|  
|---------------|------------------|  
|Domain controllers that host Active Directory–integrated DNS zones and point to themselves as Preferred DNS servers experience lengthy startup times of 20 minutes or longer and see Event ID 4013 in the DNS log.<br /><br />When you open the DNS snap\-in, you might see the following error message:<br /><br />“The Server Win2k8DC could not be contacted. The error was: The server is unavailable. Would you like to add it anyway?”<br /><br />When you open Active Directory Users and Computers, you might see this error message:<br /><br />“Naming information could not be located.”<br /><br />This error occurs when the DNS Server service is waiting for initial synchronization of AD DS to complete, but AD DS initial synchronization cannot complete because DNS records that must be resolved are stored in Active Directory–integrated zones cannot be accessed by the local DNS server.|Try the following configuration changes to prevent the condition that logs Event ID 4013:<br /><br />-   Remove references in AD DS to domain controllers that no longer exist.<br />-   Resume operations for domain controllers that are currently offline in your Active Directory forest.<br />-   Avoid single points of failures in your DNS configuration. For example, list multiple Alternate DNS servers.<br />-   Configure domain controllers that host Active Directory–integrated DNS zones to point to other DNS servers in the same site and in hub sites.<br />-   Stagger the restarts of DNS servers in your enterprise when possible.<br />-   Install uninterruptible power supply \(UPS\) devices in strategic places to ensure the availability of DNS servers after power outages, and augment your UPS\-backed DNS servers with onsite generators.|  
|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] DNS servers that are configured to use root hints for name resolution of Internet names can fail to resolve top\-level domain names.|[Article 968372](http://go.microsoft.com/fwlink/?LinkId=190467) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=190467\).|  
|DNS servers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] have Extension Mechanisms for DNS \(EDNS\) enabled by default.|If you notice queries that used to work on DNS servers that run Windows 2000, Windows Server 2003, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] fail after those DNS servers are upgraded or replaced with DNS servers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or you notice that queries that the old DNS servers can resolve cannot be resolved by [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DNS servers, disable EDNS by using the following command:<br /><br />**dnscmd \/Config \/EnableEDnsProbes 0**<br /><br />If you leave EDNS enabled and a DNS server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] receives a “Name Error 3” message from another DNS server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], install [hotfix 2550719](http://support.microsoft.com/kb/2550719) \(http:\/\/support.microsoft.com\/kb\/2550719\).|  
|There are also hotfixes available to resolve other DNS\-related problems. For more information, see [Verifications that you can make and recommended hotfixes that you can install before you begin](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Begin).||  
  
### <a name="BKMK_IPv6"></a>Interoperability for IPv6 and AAAA records  
This section describes interoperability issues for IPv6 and AAAA resource records for DNS servers that run different versions of Windows Server. For more information about using DNS with IPV4 and IPv6, see [Configuring DNS for IPv6\/IPv4 Coexistence](http://go.microsoft.com/fwlink/?LinkId=186688) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=186688\).  
  
|Operation|Windows Server 2008 R2|Windows Server 2008|Windows Server 2003|  
|-------------|--------------------------|-----------------------|-----------------------|  
|Registers AAAA records|Yes|Yes|Yes|  
|Replicates AAAA records|Yes|Yes|Yes|  
|Supports AAAA record type|Yes|Yes|Yes|  
|Listens on IPv6 network interface|Yes|Requires [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2|No|  
|Provides Dnscmd.exe IPv6 support|Yes|Yes|No|  
  
## <a name="BKMK_KnownIssues"></a>Known issues for upgrades to Windows Server 2008 and Windows Server 2008 R2  
Read the following release notes for more information about specific issues that can affect these versions of Windows Server:  
  
[Release notes for Windows Server 2008](http://go.microsoft.com/fwlink/?LinkID=99299) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=99299\)  
  
[Release notes for Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkID=139330) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=139330\)  
  
### Logoff takes several minutes if there is no LDAP connectivity to the forest root domain  
When you log on or log off from a domain with a newly built client computer, you experience delays of about 5 to 10 minutes. This problem appears after you join the computer to an Active Directory domain. This affects computers that run Windows Vista, [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. The problem is caused by lack of connectivity between the client computer and the forest root domain controllers. For more information about the cause of this problem and the steps to take to resolve it, see [article 971198](http://go.microsoft.com/fwlink/?LinkId=184883) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184883\) in the Microsoft Knowledge Base.  
  
### Windows Server 2008 R2 domain controllers fail to authenticate DES\-enabled clients  
If you deploy a domain controller that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] into an existing domain that contains Windows Server 2003 and Windows Server 2008 domain controllers and you run a service account that has the **Use DES encryption types for this account** check box selected, you might see Event ID 16 in the System log of the domain controller that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], even after you enable Data Encryption Standard \(DES\) encryption for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] \(which is disabled by default\). Windows Server 2003 and Windows Server 2008 domain controllers service authentication requests without error.  
  
This problem occurs because Windows Server 2008 R2 domain controllers fail to use a second data structure BLOB that contains DES encryption settings, even though that structure was successfully inbound\-replicated by the authenticating Windows Server 2008 R2 domain controller. This problem is fixed on domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] with SP1.  
  
To resolve this problem on a domain controller that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] without SP1:  
  
1.  Link or modify a Group Policy object \(GPO\) on the domain controller’s organizational unit \(OU\) that enables the DES encryption.  
  
    For more information, see [article 977321](http://go.microsoft.com/fwlink/?LinkId=177717) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=177717\). Make sure that the policy is configured to enable all encryption types.  
  
2.  Select the **Use DES encryption types for this account** check box on the SAP Service account in the Active Directory Users and Computers snap\-in.  
  
3.  Install the hotfix from [article 978055](http://go.microsoft.com/fwlink/?LinkId=185219) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185219\) on all domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] without SP1. You can install the hotfix without removing and reinstalling AD DS on existing domain controllers.  
  
## <a name="BKMK_SecureDefault"></a>Secure default settings in Windows Server 2008 and Windows Server 2008 R2  
[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers have the following secure default settings, compared to Windows 2000 and Windows Server 2003 domain controllers.  
  
|||||  
|-|-|-|-|  
|Encryption type or policy|Windows Server 2008 default|Windows Server 2008 R2 default|Comment|  
|AllowNT4Crypto|Disabled|Disabled|Third\-party Server Message Block \(SMB\) clients may be incompatible with the secure default settings on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers. In all cases, these settings can be relaxed to allow interoperability at the expense of security. For more information, see [article 942564](http://go.microsoft.com/fwlink/?LinkId=164558) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164558\).|  
|DES|Enabled|Disabled|[Article 977321](http://go.microsoft.com/fwlink/?LinkId=177717) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=177717\)|  
|CBT\/Extended Protection for Integrated Authentication|N\/A|Enabled|See [Microsoft Security Advisory \(937811\)](http://go.microsoft.com/fwlink/?LinkId=164559) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164559\) and [article 976918](http://go.microsoft.com/fwlink/?LinkId=178251) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178251\).<br /><br />Review and install the hotfix in [article 977073](http://go.microsoft.com/fwlink/?LinkId=186394) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=186394\) in the Microsoft Knowledge Base as required.|  
|LMv2|Enabled|Disabled|[Article 976918](http://go.microsoft.com/fwlink/?LinkId=178251) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178251\)|  
  
## <a name="BKMK_VM"></a>Virtualized domain controllers on Hyper\-V™, VMware, and other virtualization software  
Regardless of the virtual host software product that you are using, read [Running Domain Controllers in Hyper\-V](http://go.microsoft.com/fwlink/?LinkID=139651) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=139651\) for special requirements related to running virtualized domain controllers. Specific requirements include the following:  
  
-   Avoid single points of failure such as having all domain controllers in a domain or forest on the same VM host, or the same SAN or datacenter, and so on.  
  
-   Do not stop or pause domain controllers.  
  
-   Do not restore snapshots of domain controller role computers. This action causes an update sequence number \(USN\) rollback that can result in permanent inconsistencies between domain controller databases.  
  
-   All physical\-to\-virtual \(P2V\) conversions for domain controller role computers should be done in offline mode. System Center Virtual Machine Manager enforces this for Hyper\-V. For information about other virtualization software, see the vendor documentation.  
  
-   Configure virtualized domain controllers to synchronize with a time source in accordance with the recommendations for your hosting software.  
  
-   For more considerations about running domain controllers in virtual machines, see [article 888794](http://go.microsoft.com/fwlink/?LinkID=141292) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=141292\).  
  
## <a name="BKMK_Admin"></a>Administration, remote administration, and cross\-version administration  
The following changes have been made to local and remote administration tools for the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating systems.  
  
-   The installation of a server role, such as Active Directory Domain Services, by Server Manager also locally installs all GUI and command\-line tools that you can use to administer that role. To install tools locally to manage other server roles, click **Add Features** in Server Manager.  
  
-   The GUI and command\-line tools that were formerly in the Administrative Tools Pack \(ADMINPACK.MSI\), Support Tools \(SUPPTOOLS.MSI\), and Resource Kit tools have been consolidated into a single collection called Remote Server Administration Tools \(RSAT\), which you can obtain from the Microsoft Download Center and install on client operating systems such as Windows Vista or Windows 7.  
  
-   As 64\-bit hardware and operating systems became more popular, x86\-based \(32\-bit\) and x64\-based \(64\-bit\) versions of administration tools were released.  
  
-   Additional steps are required to make the administration tools that RSAT installs appear in the **Start** menu of Windows Vista computers. For these additional steps, see the following procedure.  
  
#### To display the administration tools on the Start menu  
  
1.  Right\-click **Start**, and then click **Properties**.  
  
2.  On the **Start Menu** tab, click **Customize**.  
  
3.  In the **Customize Start Menu** dialog box, scroll down to **System administrative tools**, and then click **Display on the All Programs menu and the Start menu**.  
  
4.  Click **OK**.  
  
As a general rule, the administrative tools only install and run correctly on the operating system versions with which they were released. For example, the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] administration tools install and run only on Windows Vista client computers and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] server computers. As another example, if you try to administer [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DNS servers using The DNS snap\-in or Dnscmd.exe from Windows Server 2003, you receive “access is denied” errors.  
  
Administration tools whose files are copied from the server operating system disk will generally not execute on the corresponding client operating system and are not supported. For example, tools that are copied from the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system disk to Windows Vista will not work. Instead of copying the tools, download the correct version of RSAT for the client computers that you use to administer servers.  
  
For more information, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](http://go.microsoft.com/fwlink/?LinkId=177813) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=177813\).  
  
For more information, see [Installing Remote Server Administration Tools](http://go.microsoft.com/fwlink/?LinkID=153624) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=153624\).  
  
## <a name="BKMK_Time"></a>Configuring the Windows Time service for Windows Server 2008 and Windows Server 2008 R2  
Make sure that you have the following domain controller roles configured properly to synchronize the Windows Time service \(W32time\).  
  
The forest\-root primary domain controller \(PDC\) on a physical computer should synchronize time from a reliable external time source. For more information, see [Configure the Windows Time service on the PDC emulator](http://go.microsoft.com/fwlink/?LinkId=91969) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=91969\).  
  
All other domain controllers that are installed on physical hardware or Hyper\-V should use the default domain hierarchy \(no configuration change required\).  
  
For domain controllers running on non\-Microsoft virtualization software, consult the vendor.  
  
Windows Server 2008 and Windows Server 2008 R2 domain controllers added time\-rollback protection to help prevent domain controllers from adopting bad time. We recommend that you add time\-rollback protection on Windows Server 2003 domain controllers and Windows Server 2008 and Windows Server 2008 R2 Hyper\-V hosts by using Group Policy, making sure that you have the policy detail fixes in place before you do. For more information, see [article 884776](http://go.microsoft.com/fwlink/?LinkId=178255) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178255\).  
  
Finally, time on workgroup virtual host and domain\-joined virtual host computers should be configured as follows:  
  
For workgroup host computers:  
  
-   HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\services\\W32Time\\Parameters\\TYPE \(REG\_SZ\) \= NTP  
  
-   HKLM\\system\\CurrentControlSet\\Services\\W32Time\\Parameters\\NtpServer \(REG\_DWORD\) \= <fully qualified host name of time server, such as time.windows.com>,0x08  
  
-   HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\W32Time\\TimeProviders\\NtpClient\\SpecialPollInterval \(REG\_DWORD\) \= 900 \(decimal\)  
  
-   HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\W32Time\\Config\\MaxPosPhaseCorrection \(REG\_DWORD\): 2a300 \(hexadecimal\) or 172800 \(decimal\)  
  
-   HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\W32Time\\Config\\MaxNegPhaseCorrection \(REG\_DWORD\): 2a300 \(hexadecimal\) or 172800 \(decimal\)  
  
For domain\-joined host computers:  
  
-   HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\W32time\\Config\\MinPollInterval \(REG\_DWORD\): 6 \(decimal\)  
  
-   HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\W32time\\Config\\MaxPollInterval \(REG\_DWORD\): 10 \(decimal\)  
  
-   HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\W32Time\\Config\\MaxPosPhaseCorrection \(REG\_DWORD\): 2a300 \(hexadecimal\) or 172800 \(decimal\)  
  
-   HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\W32Time\\Config\\MaxNegPhaseCorrection \(REG\_DWORD\): 2a300 \(hexadecimal\) or 172800 \(decimal\)  
  
## <a name="BKMK_Begin"></a>Verifications that you can make and recommended hotfixes that you can install before you begin  
  
1.  All domain controllers in the forest should meet the following conditions:  
  
    1.  Be online.  
  
    2.  Be healthy \(Run **dcdiag \/v** to see if there are any problems.\)  
  
    3.  Have successfully inbound\-replicated and outbound\-replicated all locally held Active Directory partitions \(**repadmin \/showrepl \* \/csv** viewed in Excel\). For more information, see “CSV Format” in [Repadmin Requirements, Syntax, and Parameter Descriptions](http://go.microsoft.com/fwlink/?LinkID=147380) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=147380\).  
  
    4.  Have successfully inbound\-replicated and outbound\-replicated SYSVOL.  
  
    5.  Metadata for stale or nonexistent domain controllers, or domain controllers that cannot be made to replicate, should be removed from their respective domains. For more information, see [Clean Up Server Metadata](http://go.microsoft.com/fwlink/?LinkID=148150) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=148150\).  
  
    6.  All domains must be at the Windows 2000 native functional level or higher to run **adprep \/domainprep**. Windows NT 4.0 domain controllers are not permitted in this functional level.  
  
    7.  Have sufficient free disk space to accommodate the upgrade.  
  
        For more information about disk\-space requirements for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [System requirements for installing Windows Server 2008 and Windows Server 2008 R2](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_SystemReq). The task for administrators is to accurately forecast the immediate and long\-term growth for Ntds.dit files on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers so that hard drives and partitions that host Active Directory files can be sized properly on physical and virtual domain controllers.  
  
2.  Check for incompatibilities with secure defaults in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. For more information, see [Secure default settings in Windows Server 2008 and Windows Server 2008 R2](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_SecureDefault).  
  
3.  Download the latest service pack and relevant hotfixes that apply to your Active Directory forest before you deploy [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers.  
  
    1.  For upgrades to either [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], create integrated installation media \(“slipstream”\) by adding the latest service pack and hotfixes for your operating system. As of September 2009, the latest service pack for Windows Server 2008 is Service Pack 2 \(SP2\). For information about obtaining the latest service pack, see [article 968849](http://go.microsoft.com/fwlink/?LinkId=164585) in the Microsoft Knowledge base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164585\) and see [Installing Windows Server 2008 with Service Pack 2](http://go.microsoft.com/fwlink/?LinkId=164586) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164586\). [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] includes updates from [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2. To make sure that you have all of the latest updates, see [Windows Update](http://go.microsoft.com/fwlink/?LinkID=47290) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=47290\) or see [article 968849](http://go.microsoft.com/fwlink/?LinkID=164585) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164585\) for download information.  
  
        1.  If you are deploying RODCs, review [article 944043](http://go.microsoft.com/fwlink/?LinkID=122974) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122974\). Download and install the hotfixes on the Windows computers and scenarios that apply to your computing environment.  
  
        2.  For [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]: If Active Directory Management Tool \(ADMT\) 3.1 is installed on Windows Server 2008 computers that are being upgraded in\-place to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], remove ADMT 3.1 before the upgrade; otherwise, it cannot be uninstalled. In addition, ADMT 3.1 cannot be installed on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] computers.  
  
        3.  The following table lists hotfixes for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. You can install a hotfix individually, or you can install the service pack that includes it.  
  
            ||||  
            |-|-|-|  
            |Description|Microsoft Knowledge Base article|Service pack|  
            |Unexpected behavior occurs in the Windows Time service when you enable the Windows Time Service Group Policy setting in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or in Windows Vista SP1|[961027](http://go.microsoft.com/fwlink/?LinkId=182336) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=182336\)|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2|  
            |Domain controllers that are configured to use the Japanese language locale|[949189](http://go.microsoft.com/fwlink/?LinkId=164588) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164588\)|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2|  
            |EFS file access encrypted on a Windows Server 2003 file server upgraded to Windows Server 2008|[948690](http://go.microsoft.com/fwlink/?LinkID=106115) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=106115\)|Not included in any [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Service Pack|  
            |Records on Windows Server 2008 secondary DNS server are deleted after zone transfer|[953317](http://go.microsoft.com/fwlink/?LinkId=164590) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164590\)|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2|  
            |Use root hints if no forwarders are available|[2001154](http://go.microsoft.com/fwlink/?LinkId=165959) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=165959\)||  
            |Setting Locale information in Group Policy Preferences causes Event Log and dependent services to fail. If you change “Regional Option – User Locale – enabled,” the Windows Event Log Service, DNS Server Service, and task Scheduler Service fail to start.|For prevention and resolution, see [951430](http://go.microsoft.com/fwlink/?LinkId=165960) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=165960\).|To be included in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP3|  
            |GPMC Filter fix|[949360](http://go.microsoft.com/fwlink/?LinkID=184908) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=184908\)|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2|  
            |If you use devolution to resolve DNS names \(instead of suffix search list\), apply the DNS devolution hotfix.|[957579](http://go.microsoft.com/fwlink/?LinkId=178224) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178224\)|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2|  
            |Group Policy Preferences rerelease|[943729](http://go.microsoft.com/fwlink/?LinkId=164591) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164591\)<br /><br />[974266](http://go.microsoft.com/fwlink/?LinkID=165035) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=165035\)|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2|  
            |Synchronize the Directory Services Restore Mode \(DSRM\) Administrator password with a domain user account|[961320](http://go.microsoft.com/fwlink/?LinkId=177814) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=177814\)||  
            |An application that uses Crypt32.dll crashes on a computer that is running Windows Vista or Windows Server 2008|[982416](http://go.microsoft.com/fwlink/?LinkID=196889) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=196889\)|Windows Server 2008 SP3|  
            |If you have [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] servers that are running IIS, hosting SSL certs, then you may need to install the hotfix in article 2379016|[2379016](http://go.microsoft.com/fwlink/?LinkId=199533) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=199533\)|Windows Server 2008 SP3|  
            |AAAA record of a Windows Server 2008 domain controller is deleted automatically if the domain controller uses an Active Directory–integrated zone and has a Microsoft 6to4 adapter|[2408181](http://go.microsoft.com/fwlink/?LinkId=204910) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=204910\)|Windows Server 2008 SP3|  
            |Add Printer Wizard lists published printers in AD DS slowly in Windows Vista or in Windows Server 2008|[2571564](http://support.microsoft.com/kb/2571564)|Windows Vista SP3 or Windows Server 2008 SP3|  
  
            > [!NOTE]  
            > If you are operating a domain with domain controllers that run Windows Server 2003 and Windows Server 2008, install hotfix [939820](http://support.microsoft.com/kb/939820) \(http:\/\/support.microsoft.com\/kb\/939820\).  
  
            The following table lists hotfixes for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
            ||||  
            |-|-|-|  
            |Description|Microsoft Knowledge Base article|Comment|  
            |Windows Server 2008 R2 Dynamic DNS updates to BIND servers log NETLOGON event 5774 with error status 9502|[977158](http://go.microsoft.com/fwlink/?LinkId=178225) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178225\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP1|  
            |Event ID 1202 logged with status 0x534 if security policy modified|[974639](http://go.microsoft.com/fwlink/?LinkId=165961) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=165961\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP1|  
            |**TimeZoneKeyName** registry entry name is corrupt on 64\-bit upgrades|[2001086](http://go.microsoft.com/fwlink/?LinkId=178226) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178226\)|Occurs only on x64\-based server upgrades in Dynamic DST time zones. To see if your servers are affected, click the taskbar clock. If the clock fly\-out indicates a time zone problem, click the link to open the date and time control panel.|  
            |Event ID 1988 Logged in Directory Service Log after Schema Update|[2005074](http://go.microsoft.com/fwlink/?LinkId=185205) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185205\)|Some deleted objects that are nearing the tombstone lifetime may still exist on the source of a replication agreement and have an attribute added to the partial attribute set of the object that should be replicated out. If the same object was garbage\-collected on the target domain controller when it was replicated, the destination domain controller logs Event ID 1988 and possibly Event ID 1388.|  
            |Windows Server 2008 R2 DNS servers that use root hints are unable to resolve some DNS queries.|[832223](http://go.microsoft.com/fwlink/?LinkId=186576) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=186576\)|The KB article describes a workaround. A hotfix is also included in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP1.|  
            |Windows Server 2008 R2 domain controllers fail to authenticate DES\-enabled clients.|[article 978055](http://go.microsoft.com/fwlink/?LinkId=185219) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185219\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP1|  
            |Digest authentication fails on a Windows XP or Windows Server 2003 member server when authenticating against a Windows Server 2008 R2 domain controller|[977073](http://go.microsoft.com/fwlink/?LinkId=186934) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=186934\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP1|  
            |In Windows Server 2008 R2, the DNS Server service might crash when it handles many concurrent queries that are submitted through the DNS server plug\-in interface|[2411958](http://go.microsoft.com/fwlink/?LinkID=204908) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=204908\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP1|  
            |Slow performance occurs when many user authentication requests are handled in Windows Server 2008 R2|[2545833](http://support.microsoft.com/kb/2545833) \(http:\/\/support.microsoft.com\/kb\/2545833\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP2|  
            |Scalability of the I\/O performance decreases in Windows Server 2008 R2 if more than 256 GB of physical memory is used|[2566205](http://support.microsoft.com/kb/2566205) \(http:\/\/support.microsoft.com\/kb\/2566205\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP2|  
            |Tuple index is corrupted in a Windows Server 2008 R2 domain|[2566592](http://support.microsoft.com/kb/2566592) \(http:\/\/support.microsoft.com\/kb\/2566592\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] SP2|  
            |ILM Management Agents and Windows 2008 Active Directory|[2018683](http://support.microsoft.com/kb/2018683) \(http:\/\/support.microsoft.com\/kb\/2018683\)|N\/A<br /><br />MIIS 2003 and ILM 2007 will work with a forest upgrade to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] as long as the Active Directory Recycle Bin feature is not enabled. Use ILM 2007 SP1 or FIM 2010 to synchronize operations that involve Active Directory Recycle Bin.|  
  
            If you have a Group Policy central store that is hosted with [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] administrative template \(ADMX\) files, you may have to upgrade the ADMX files or remove the central store. For more information, see [Windows 7, Windows Server 2008 R2 and the Group Policy Central Store](http://go.microsoft.com/fwlink/?LinkId=182337) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=182337\).  
  
## <a name="BKMK_RunAdprep"></a>Run Adprep commands  
This section describes how to run the following **adprep** commands.  
  
-   [Add schema changes using adprep \/forestprep](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Fprep)  
  
-   [If you are deploying RODCs, run adprep \/rodcprep](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_rodcprep)  
  
-   [Run adprep \/domainprep \/gpprep](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_GPPrep)  
  
If you encounter errors when you run an Adprep command, see [Adprep errors](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_AdprepErrors).  
  
### <a name="BKMK_Fprep"></a>Add schema changes using adprep \/forestprep  
  
1.  Identify the domain controller that holds the schema operations master role \(also known as flexible single master operations or FSMO role\) and verify that it has inbound\-replicated the schema partition since startup:  
  
    1.  Run the **dcdiag \/test:knowsofroleholders** command. If the schema role is assigned to a domain controller with a deleted NTDS settings object, follow the steps in [article 255504](http://go.microsoft.com/fwlink/?LinkID=70776) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=70776\) to seize the role to a live domain controller in the forest root domain.  
  
    2.  Log on to the schema operations master with an account that has Enterprise Admins, Schema Admins, and Domain Admins credentials in the forest root domain. By default, the built\-in administrator account in a forest root domain has these credentials.  
  
    3.  On the schema master, run the **repadmin \/showreps** command. If schema master has inbound\-replicated the schema partition since startup, continue to the next step. Otherwise, use the **replicate now** command **Dssite.msc** to trigger inbound replication of the schema partition to the schema master. \(See [Force replication over a connection](http://go.microsoft.com/fwlink/?LinkId=164634) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164634\)\). You can also use the **repadmin \/replicate <name of schema master> <GUID of replication partner>** command. The **showreps** command returns the globally unique identifier \(GUID\) of all replication partners of the schema master.  
  
2.  Locate the correct version of Adprep for your upgrade:  
  
    -   The [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] installation media contain one version of **adprep**, Adprep.exe, in the \\sources\\adprep folder [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] installation disk, that runs on both x86\-based and x64\-based operations masters.  
  
    -   [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] installation media contain both x86\-based \(Adprep32.exe\) and x64\-based \(Adprep.exe\) versions of **adprep** in the \\support\\adprep folder of the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] installation disk.  
  
    -   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] schema updates can be added directly to forests with Windows 2000 Server, Windows Server 2003, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] schema versions.  
  
    -   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] versions of adprep.exe can be run directly on Windows Server 2000 SP4, Windows Server 2003, Windows Server 2003 R2, and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] \(for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]\) operations masters.  
  
    -   If you copy Adprep.exe from the installation media to a local computer or a network share, copy the entire adprep folder and provide the full path to the Adprep.exe file.  
  
3.  Update the forest schema with **adprep \/forestprep**.  
  
    While you are still logged on to the console of the schema master with an account that has Enterprise Admins, Schema Admin, and Domain Admin credentials, run the appropriate version of **adprep \/forestprep** from the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] installation media. Specify the full path to Adprep.exe to prevent running another version of Adprep that may be present in the PATH environment variable.  
  
    For example, if you are running the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] version of Adprep from a DVD drive or network path that is assigned the drive letter D:, the command to run is as follows:  
  
    ```  
    >D:\sources\adprep\adprep /forestprep  
    ```  
  
    The syntax for running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] Adprep on a 64\-bit schema master is as follows:  
  
    ```  
    <dvd drive letter>:\support\adprep\adprep /forestprep  
    ```  
  
    The syntax for running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] Adprep on a 32\-bit, x86\-based schema master is as follows:  
  
    ```  
    D:\support\adprep\adprep32 /forestprep  
    ```  
  
    For a list of operations that [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] **adprep \/forestprep** performs, see [Windows Server 2008: Forest\-Wide Updates](http://go.microsoft.com/fwlink/?LinkId=164636) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164636\).  
  
    For a list of operations that [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] **adprep \/forestprep** performs , see [Windows Server 2008 R2: Forest\-Wide Updates](http://go.microsoft.com/fwlink/?LinkId=164637) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164637\).  
  
If you encounter errors, see “Forestprep errors” later in this topic.  
  
### <a name="BKMK_rodcprep"></a>If you are deploying RODCs, run adprep \/rodcprep  
You do not have to run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] **adprep \/rodcprep** in a forest that has already been prepared with [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] **adprep \/rodcprep**. Proceed to **adprep \/domainprep**.  
  
If you are deploying RODCs for the first time:  
  
While still logged on with Enterprise Admins credentials on the schema master, run **adprep \/rodcprep**.  
  
> [!NOTE]  
> Rodcprep will run on any member computer or domain controller in the forest if you are logged on with Enterprise Admin credentials. You can run **adprep \/rodcprep** before or after **adprep \/domainprep**. We recommend running **adprep \/rodcprep** on the schema master immediately after **adprep \/forestprep** as a matter of convenience because that operation also requires Enterprise Admins credentials.  
  
For [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Rodcprep, specify the full path to Adprep. For example, if the DVD or network path is assigned drive D:, run the following command:  
  
```  
c:\windows >D:\sources\adprep\adprep /rodcprep  
```  
  
For [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]:  
  
1.  If the computer where you run Rodcprep is a 64\-bit computer, run the following command:  
  
    ```  
    D:\support\adprep\adprep /rodcprep  
    ```  
  
2.  If the computer where you run Rodcprep is a 32\-bit computer, run the following command:  
  
    ```  
    D:\support\adprep\adprep32 /rodcprep  
    ```  
  
If you encounter errors, see “Rodcprep errors” later in this topic.  
  
Before you deploy RODCs, install the RODC compatibility pack on computers that Windows XP or Windows Server 2003 as needed. For more information, see [article 944043](http://go.microsoft.com/fwlink/?LinkID=122974) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122974\).  
  
### <a name="BKMK_GPPrep"></a>Run adprep \/domainprep \/gpprep  
For each domain that you intend to add [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers to:  
  
1.  Run **netdom query fsmo or dcdiag \/test:<name of FSMO test>** to identify the infrastructure operations master.  
  
2.  If operations master roles are assigned to deleted or offline domain controllers, transfer or seize the roles as required.  
  
3.  Log on to the infrastructure master with an account that has Domain Admins credentials.  
  
4.  Run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] **adprep \/domainprep \/gpprep** from the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system disk using the following syntax:  
  
    > [!NOTE]  
    > You do not have to add the **\/gpprep** parameter in the following command if you already ran it for Windows Server 2003.  
  
    ```  
    <drive>:\<path>\adprep /domainprep /gpprep  
    ```  
  
    For example, if the DVD or network path is assigned drive D, use the following syntax:  
  
    ```  
    D:\sources\adprep\adprep /domainprep /gpprep  
    ```  
  
    For [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]:  
  
    If the infrastructure master is 64\-bit, use the following syntax:  
  
    ```  
    D:\support\adprep\adprep /domainprep /gpprep  
    ```  
  
    If the infrastructure master is 32\-bit, use the following syntax:  
  
    ```  
    D:\support\adprep\adprep32 /domainprep /gpprep  
    ```  
  
    If you encounter errors, see “Domainprep errors” later in this topic  
  
## <a name="BKMK_Upgrade"></a>Upgrade domain controllers  
For background information about which types of operating systems and domain controllers can be upgraded, see [Supported in\-place upgrade paths](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_SupportedUpgrade). This section includes the following topics:  
  
-   [Upgrading and promoting new domain controllers into an existing domain](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Newdomain)  
  
-   [Post\-installation tasks](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Post)  
  
-   [Fixes to install after AD DS installation](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_Fixes)  
  
### <a name="BKMK_Newdomain"></a>Upgrading and promoting new domain controllers into an existing domain  
Complete the following steps if you are performing either of these in\-place upgrades:  
  
-   Upgrading to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] from Windows Server 2003 domain controllers  
  
-   Upgrading to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] from [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003 or domain controllers  
  
1.  If you have the Japanese language locale installed on Windows Server 2003 domain controllers that are being upgraded in place to Windows Server 2008, read and comply with [article 949189](http://go.microsoft.com/fwlink/?LinkID=164588) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164588\).  
  
2.  If the Active Directory Migration Tool \(ADMT\) version 3.1 is installed on a Windows Server 2003 or Windows Server 2008 domain controller that is being upgraded to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], uninstall ADMT 3.1 before the upgrade.  
  
3.  When promoting new domain controllers, make sure that object information about the newly promoted domain controllers \(the computer account in the domain partition and the NTDS Settings object in the configuration partition\) has outbound replicated to a sufficient number of domain controllers that are remaining in the forest before you retire the only domain controller in the forest that has that object information. For example, if you promote DC2 and use DC1 as the helper domain controller, then make sure that DC1 has outbound replicated object information about DC2 to other domain controllers before you retire DC1. This is particularly an issue where the helper domain controllers used by newly promoted domain controllers are rapidly demoted before outbound reapplication takes place.  
  
4.  Run **<dvd or network path>:\\setup.exe**.  
  
5.  Read [article 942564](http://go.microsoft.com/fwlink/?LinkID=164558) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164558\) and consider the right setting for the AllowNT4Cryto policy for your environment.  
  
6.  If dcpromo.exe fails, see [Dcpromo errors](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_DcpromoErrors).  
  
7.  If you have remotely encrypted Encrypting File System \(EFS\) files on Windows Server 2003 computers that are being upgraded in place to Windows Server 2008, read and comply with [article 948690](http://go.microsoft.com/fwlink/?LinkID=106115) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=106115\). This problem does not apply to domain controllers that are upgraded to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
8.  Consider installing the following fixes after the in\-place upgrade unless they are integrated into your installation media:  
  
    -   If you are installing Windows Server 2008, install Service Pack 2 \(SP2\). [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] includes [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] SP2 fixes.  
  
    -   If you are using Group Policy Preferences on Windows Vista or Windows Server 2008 computers, download the July 2009 update to [article 943729](http://go.microsoft.com/fwlink/?LinkID=164591) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164591\).  
  
    -   Download the fix for a Group Policy Management Console \(GPMC\) filter bug in [article 949360](http://go.microsoft.com/fwlink/?LinkID=184908) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=184908\) in the Microsoft Knowledge Base.  
  
    -   If you use devolution \(as opposed to suffix search lists\) to resolve DNS queries for single\-label and non\-fully qualified DNS names, download the DNS devolution fix. See [article 957579](http://go.microsoft.com/fwlink/?LinkId=166140) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=166140\).  
  
Complete the following steps if you are performing an in\-place upgrade of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] writable domain controllers into existing Windows 2000 Server, Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domains:  
  
1.  Verify that the target domain is at the Windows 2000 native domain functional level or higher.  
  
2.  If you are promoting [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controllers that are configured to use the Japanese language, read and comply with [article 949189](http://go.microsoft.com/fwlink/?LinkID=164588) in the Microsoft Knowledge base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164588\). The hotfix should be installed immediately after promotion and before the first boot into normal mode.  
  
3.  From the Windows **Start** menu, run Dcpromo.exe \(or install the Active Directory Domain Services Role in Server Manager, and then run Dcpromo\).  
  
4.  When the AllowNT4Crytpo page appears, read [article 942564](http://go.microsoft.com/fwlink/?LinkID=164558) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164558\) consider the right setting for AllowNT4Cryto for your environment.  
  
5.  If you encounter an error, see the list of [Dcpromo errors](../Topic/Upgrade-Domain-Controllers--Microsoft-Support-Quick-Start-for-Adding-Windows-Server-2008-or-Windows-Server-2008-R2-Domain-Controllers-to-Existing-Domains.md#BKMK_DcpromoErrors) at the end of this topic.  
  
Do the following if you are performing an in\-place upgrade of Windows Server 2008 RODCs into existing Windows Server 2003 domains, Windows Server 2008 domains, or domains that have a mix of those operating systems:  
  
1.  If the option to install RODC is not available in Dcpromo, verify that the forest functional level is Windows Server 2003 or higher.  
  
2.  If the option to install RODC is not available and the error message indicates that there is no [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in the domain, verify that a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller exists in the domain and that it is accessible on the network to the RODC that you are promoting.  
  
3.  If an error message indicates that access is denied, see the Microsoft Knowledge Base.  
  
### <a name="BKMK_Post"></a>Post\-installation tasks  
For all domain controllers:  
  
-   Configure the forest root PDC with an external time source. For more information, see [Configure the forest root PDC with an external time source](http://go.microsoft.com/fwlink/?LinkId=91969) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=91969\).  
  
-   Enable delete protection on organizational units \(OUs\) and other strategic containers to prevent accidental deletions.  
  
-   Make a system state backup of upgraded and newly promoted domain controllers. If you promoted the first domain controller in a new domain and do not yet have additional domain controllers, making a system state backup is more important for recovering accidental deletions. For more information, see [AD DS Backup and Recovery Step\-by\-Step Guide](http://go.microsoft.com/fwlink/?LinkId=190448) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=190448\).  
  
-   Use only Active Directory–aware backup applications to restore domain controllers or roll back the contents of AD DS. Restoring snapshots that were created by imaging software is not supported on domain controllers.  
  
### <a name="BKMK_Fixes"></a>Fixes to install after AD DS installation  
After installation of AD DS, install the following hotfixes.  
  
> [!NOTE]  
> It is impossible to provide a complete list of hotfixes. The following is a list of hotfixes that are available as of October 2010 that focus on the AD DS and DNS Server roles.  
  
|Hotfix|To apply the hotfix for Windows Server 2008|To apply the hotfix for Windows Server 2008 R2|  
|----------|-----------------------------------------------|--------------------------------------------------|  
|[Article 949189](http://go.microsoft.com/fwlink/?LinkID=164588) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164588\): Japanese Language Locale|Install [Article 949189](http://go.microsoft.com/fwlink/?LinkID=164588) or Windows Server 2008 SP2.|Not applicable|  
|[Article 949360](http://go.microsoft.com/fwlink/?LinkId=184908) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184908\): GPMC filter bug|Install [MSKB 949360](http://go.microsoft.com/fwlink/?LinkId=184908) or Windows Server 2008 SP2.|Not applicable|  
|[Article 951191](http://go.microsoft.com/fwlink/?LinkId=184906) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184906\): KERB5KDC\_ERR\_C\_PRINICPAL\_UNKNOWN error|Install [MSKB 951191](http://go.microsoft.com/fwlink/?LinkId=184906) or Windows Server 2008 SP2.|Not applicable|  
|[Article 943729](http://go.microsoft.com/fwlink/?LinkID=164591) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164591\): GPP rerelease|Install [MSKB 943729](http://go.microsoft.com/fwlink/?LinkID=164591) or Windows Server 2008 SP3 when available.|Not applicable|  
|[Article 957579](http://go.microsoft.com/fwlink/?LinkId=184907) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184907\): DNS devolution fix|Install [MSKB 957579](http://go.microsoft.com/fwlink/?LinkId=184907) or Windows Server 2008 SP3 when available.|Not applicable|  
|[Article 971438](http://go.microsoft.com/fwlink/?LinkId=185193) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185193\): A GPO is not applied to a computer that is a member of a nested group|Install [MSKB 971438](http://go.microsoft.com/fwlink/?LinkId=185193) or Windows Server 2008 SP3 when available.|Not applicable|  
|[Article 981370](http://go.microsoft.com/fwlink/?LinkId=206168) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=206168\):The DNS Server service on an RODC does not respond to DNS queries for several minutes if the link to some RWDCs breaks in Windows Server 2008|Install [MSKB 981370](http://go.microsoft.com/fwlink/?LinkId=206168) or Windows Server 2008 SP3 when available.|Not applicable|  
|[Article 976494](http://go.microsoft.com/fwlink/?LinkId=206174) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=206174\):Error 1789 when you use the LookupAccountName function on a computer that is running Windows 7 or Windows Server 2008 R2|Not applicable|Install [MSKB 976494](http://go.microsoft.com/fwlink/?LinkId=206174) or Windows Server 2008 R2 SP1 when available.|  
|[Article 978277](http://go.microsoft.com/fwlink/?LinkId=184911) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184911\): The specified account does not exist|Not applicable|Install [MSKB 978277](http://go.microsoft.com/fwlink/?LinkId=184911) or Windows Server 2008 R2 SP1 when available.|  
|[Article 978387](http://go.microsoft.com/fwlink/?LinkId=184915) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184915\): Dcdiag fails with error code 0x621|Not applicable|Install [MSKB 978387](http://go.microsoft.com/fwlink/?LinkId=184915) or Windows Server 2008 R2 SP1 when available.|  
|[Article 978516](http://go.microsoft.com/fwlink/?LinkId=185190) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185190\): Significant delays when you read the same set of files several times|Not applicable|Install [MSKB 978516](http://go.microsoft.com/fwlink/?LinkId=185190) or Windows Server 2008 R2 SP1 when available.|  
|[Article 978837](http://go.microsoft.com/fwlink/?LinkId=185191) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185191\): Group Policy Management Editor window crashes when you apply some changes for NRPT policy settings|Not applicable|Install [MSKB 978837](http://go.microsoft.com/fwlink/?LinkId=185191) or Windows Server 2008 R2 SP1 when available.|  
|[Article 2309290](http://go.microsoft.com/fwlink/?LinkId=204904) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=204904\): The DNS Server service does not respond to multi\-label name resolution request correctly when background zone loading occurs in Windows Server 2008 R2|Not applicable|Install [MSKB 2309290](http://go.microsoft.com/fwlink/?LinkId=204904) or Windows Server 2008 R2 SP1 when available.|  
|[Article 2413670](http://go.microsoft.com/fwlink/?LinkId=214821) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=214821\) Events 1659, 1481, and 1173 are recorded in the Directory Service event log on Windows Server 2008 R2\-based domain controllers after you remove Active Directory Domain Services from the last domain controller in a tree root domain|Not applicable|Install [MSKB 2413670](http://go.microsoft.com/fwlink/?LinkId=214821) or Windows Server 2008 R2 SP2 when available.|  
|[Article 983534](http://go.microsoft.com/fwlink/?LinkId=215717) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=215717\) Performance of the DNS Server service keeps decreasing under a heavy load situation in Windows Server 2008 R2|Not applicable|Install [MSKB 983534](http://go.microsoft.com/fwlink/?LinkId=215717) or Windows Server 2008 R2 SP2 when available.|  
|[Article 2522461](http://support.microsoft.com/kb/2522461) Filtering does not work in the DNS Manager snap\-in when you reverse lookup DNS zones to filter records in Windows Server 2008 R2|Not applicable|Install [MSKB 2522461](http://support.microsoft.com/kb/2522461) or Windows Server 2008 R2 SP2 when available.|  
|[Article 2548145](http://support.microsoft.com/kb/2548145) The size of the Active Directory increases rapidly on a Windows Server 2008 R2\-based domain controller that hosts the DNS Server role|Not applicable|Install [MSKB 2548145](http://support.microsoft.com/kb/2548145) or Windows Server 2008 R2 SP2 when available.|  
|[Article 2520155](http://support.microsoft.com/kb/2520155) DNS Host record of a computer is deleted after you change the DNS server assignment|Install [MSKB 2520155](http://support.microsoft.com/kb/2520155) or Vista SP3 or Windows Server 2008 SP3 when available.|Install [MSKB 2520155](http://support.microsoft.com/kb/2520155) or Windows 7 SP2 or Windows Server 2008 R2 SP2 when available.|  
|Articles [2499016](http://support.microsoft.com/kb/2499016) and [2518874](http://support.microsoft.com/kb/2518874) The Windows Event Log service may crash|Install [MSKB 2518874](http://support.microsoft.com/kb/2518874) or Vista SP3 or Windows Server 2008 SP3 when available.|Install [MSKB 2499016](http://support.microsoft.com/kb/2499016) or Windows 7 SP2 or Windows Server 2008 R2 SP2 when available.|  
|[Article 2457402](http://support.microsoft.com/kb/2457402) You experience delays with an application or service that uses NTDSA APIs for passing changes from RWDC data centers to RODC data centers|Not applicable|Install [MSKB 2457402](http://support.microsoft.com/kb/2457402) or Windows Server 2008 R2 SP2 when available.<br /><br />Install the hotfix on the RODC.|  
|[Article 2413670](http://support.microsoft.com/kb/2413670) Events 1659, 1481, and 1173 are recorded in the Directory Service event log on Windows Server 2008 R2\-based domain controllers after you remove Active Directory Domain Services from the last domain controller in a tree root domain|Not Applicable|Install [MSKB 2413670](http://support.microsoft.com/kb/2413670) or Windows Server 2008 R2 SP2 when available.|  
  
For RODCs:  
  
-   If you are deploying RODCs, install the hotfix in [article 953392](http://go.microsoft.com/fwlink/?LinkID=150337) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=150337\) on all [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] writable domain controllers. This fix is not required on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] writable domain controllers.  
  
-   Read [article 944043](http://go.microsoft.com/fwlink/?LinkID=122974) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122974\), and install the corrective fixes on the Windows client and server computers that are affected by the scenarios that are listed in the Knowledge Base article.  
  
## <a name="BKMK_Tshoot"></a>Troubleshooting errors  
This section describes errors in Adprep.exe and Dcpromo.exe. If you encounter an error that is not covered, search site:Microsoft.com: “*error description*” or post your problem to the following community sites:  
  
-   [Directory Services](http://go.microsoft.com/fwlink/?LinkId=166141) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=166141\)  
  
-   [Discussions in microsoft.public.windows.server.active\_directory](http://go.microsoft.com/fwlink/?LinkID=166142) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=166142\)  
  
### <a name="BKMK_AdprepErrors"></a>Adprep errors  
These sections describe errors for the **forestprep**, **domainprep**, and **rodcprep** commands.  
  
#### Forestprep errors  
  
-   If an error message indicates that the schema operations master is assigned to a deleted domain controller, see the Microsoft Knowledge Base.  
  
-   If the error message says “Adprep was unable to extend the schema” or “Adprep failed to verify whether the schema master has completed a replication cycle after last reboot,” verify that the schema master has inbound\-replicated the schema partition since the reboot. See [Force a replication event with all partners](http://go.microsoft.com/fwlink/?LinkId=164668) in Forcing Replication \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164668\), and run the **repadmin \/syncall** command.  
  
-   If the error message says “The callback function failed,” see [Adprep was unable to complete because the call back function failed](http://go.microsoft.com/fwlink/?LinkId=164669) in Running Adprep.exe \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164669\).  
  
-   If the error message says “There is a schema conflict with Exchange 2000. The schema is not upgraded.”, see [article 314649](http://go.microsoft.com/fwlink/?LinkId=166190) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=166190\).  
  
-   If the error message says ”An attribute with the same link identifier already exists,” see [article 969307](http://go.microsoft.com/fwlink/?LinkId=164670) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164670\).  
  
-   For all other error messages, run a query for the error message that is enclosed in quotation marks at [Microsoft Help and Support](http://go.microsoft.com/fwlink/?LinkID=56290) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=56290\).  
  
#### Domainprep errors  
  
1.  If the error message says “Adprep detected that the domain is not in native mode,” see [Raise the domain functional level](http://go.microsoft.com/fwlink/?LinkID=141249) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=141249\).  
  
2.  If the error message indicates that the callback function failed, see [Adprep was unable to complete because the call back function failed](http://go.microsoft.com/fwlink/?LinkID=164669) in Running Adprep.exe \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=164669\).  
  
3.  For all other error messages, run a query for the error message that is enclosed in quotation marks at [Microsoft Help and Support](http://go.microsoft.com/fwlink/?LinkID=56290) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=56290\).  
  
#### Rodcprep errors  
  
1.  If Rodcprep fails with the error message “Adprep could not contact a replica for partition <distinguished name for the forest\-wide or domain\-wide DNS application partition>” that is documented in [article 949257](http://go.microsoft.com/fwlink/?LinkID=140285) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=140285\), run the Fixfsmo.vbs script in the same article, and then rerun Rodcprep until it runs successfully.  
  
2.  For all other error messages, run a query for the error message that is enclosed in quotation marks at [Microsoft Help and Support](http://go.microsoft.com/fwlink/?LinkID=56290) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=56290\).  
  
### <a name="BKMK_DcpromoErrors"></a>Dcpromo errors  
  
1.  If the upgrade rolls back without any onscreen error or recorded error in a debug log, verify that you have sufficient free disk space on the volumes that are hosting %systemdrive, Ntds.dit, and SYSVOL.  
  
2.  If an error message says "To install a domain controller into this Active Directory forest, you must first prepare the forest using ""adprep \/forestprep""… ", verify that **\/forestprep** has been run and that the helper domain controller has inbound\-replicated **\/forestprep** changes. For more information, see [Running adprep.exe](http://go.microsoft.com/fwlink/?LinkID=142597) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=142597\).  
  
3.  If an error message says "To install a domain controller into this Active Directory domain, you must first prepare the forest using ""adprep \/domainprep""…” and verify that **\/domainprep** has been run and that the helper domain controller has inbound\-replicated **\/domainprep** changes. For more information, see [Running adprep.exe](http://go.microsoft.com/fwlink/?LinkID=142597) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=142597\).  
  
4.  If an error message says:  
  
    The operation failed because: The attempt to join this computer to the <target DNS domain> failed. “The specified user already exists.”  
  
    The cause is that the computer being promoted has identified a previously promoted computer account in the target domain with the same host name.  
  
    To resolve this error:  
  
    1.  If computer being promoted is replacing a previously demoted domain controller with the same computer name, verify that metadata for demoted domain controller is removed from AD DS, and retry the promotion. For more information, see [Cleaning metadata of removed writable domain controllers](http://go.microsoft.com/fwlink/?LinkID=164553).  
  
    2.  If then error persists, review the %systemroot%\\debug\\DCPROMOUI.LOG to identify the name of the replication source domain controller that is being used by domain controller being promoted.  
  
    3.  Verify that the replication source domain controller has inbound replicated the removal of the conflicting domain controller account. Failure of the removal to replicate to the source domain controller could be caused by replication failure or replication latency.  
  
    4.  The error can have other root causes. For more information, see the following articles in the Microsoft Knowledge Base:  
  
        -   [266633](http://go.microsoft.com/fwlink/?LinkId=179118) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=179118\)  
  
        -   [273875](http://go.microsoft.com/fwlink/?LinkId=179119) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=179119\)  
  
        -   [938447](http://go.microsoft.com/fwlink/?LinkId=179120) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=179120\)  
  
5.  If an error message says:  
  
    “You cannot install an additional domain controller at this time because the RID master <domain controller name> is offline” or “You will not be able to install a writable domain controller at this time because the RID master <domain controller name> is offline. Do you want to continue?”  
  
    The cause is that Dcpromo attempts to identify the owner of the RID Master role by reading the **fsmoRoleOwner** attribute of CN\=RID Manager$,CN\=System,DC\=<domain> and extracting the **dnsHostName** of the RID Master. Dcpromo then tries to initiate an LDAP connection over port 389 to the RID Master Server using its fully qualified computer name. If the LDAP connection fails for any reason, Dcpromo determines the RID Master to be offline. Initial sync failures by the RID FSMO should not cause this error.  
  
    1.  Run **repadmin \/showattr fsmo\_rid: ncobj:domain: \/filter:\(objectclass\=ridmanager\) \/subtree** and either **netdom query fsmo** or **dcdiag \/test:<name of FSMO test>**  
  
    2.  The output of the **repadmin** command will include the **fSMORoleOwner**. If the **fSMORoleOwner** distinguished name path that is returned from the command in the previous step is mangled or assigned to a deleted domain controller, remove the metadata for that domain controller and seize the role to a live domain controller that hosts a writable copy of the domain partition.  
  
    3.  Verify that RID master role is assigned to a live domain controller that has successfully inbound\-replicated the domain directory partition since it last restarted from at least one other domain controller in the same domain.  
  
    4.  If the current role holder is the only live domain controller in the domain but its copy of Active Directory or AD DS refers to domain controllers that no longer exist, remove the stale metadata for those domain controllers, restart the live domain controller, and try promotion again.  
  
    For more information, see article 2009385 in the Microsoft Knowledge Base.  
  
6.  If a warning indicates that there is no static IP address configured for an IPv6 address on a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller, click **Yes** and complete the wizard.  
  
7.  If the check box for installing the DNS Server role is unavailable, either the Active Directory domain has a single\-label DNS name or Dcpromo.exe cannot discover another Microsoft DNS server in the domain.  
  
8.  If you see the error message “A delegation for this DNS Server cannot be created because the authoritative parent zone cannot be found…,” see [Known Issues for Installing and Removing AD DS](http://go.microsoft.com/fwlink/?LinkId=164418) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164418\).  
  
9. If you see the error message “The DNS zone could not be created...," see the Microsoft Knowledge Base.  
  
10. If Event ID 16651 appears in the Directory Services log, see [article 316201](http://go.microsoft.com/fwlink/?LinkId=184855) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184855\) in the Microsoft Knowledge Base.  
  
11. If the system is unable to share SYSVOL, see the Microsoft Knowledge Base.  
  
12. If Dcpromo fails with an error message that says “Failed to modify the necessary properties for the machine account. Access is denied,” make sure that administrators are granted the **Enable computer and user accounts to be trusted for delegation** permission in Default Domain Controllers Policy and that the policy has been linked to the Domain Controllers OU. Also make sure that the helper domain controller’s machine account resides in the Domain Controllers OU and that it has successfully applied policy. For more information, see [article 232070](http://go.microsoft.com/fwlink/?LinkId=166198) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=166198\).  
  
13. If Dcpromo fails with an error message that says “Active Directory could not create the NTDS Settings object for this domain controller,” see the Microsoft Knowledge Base.  
  
    In the domain controller is multihomed, disable host \(A\) resource record registration by network adapters that are not available to calls on the production network.  
  
    In the domain controller is multihomed and a network cable is not attached to a network adapter, disable unused network adapters to prevent them from registering host \(A\) resource records for APIPA assigned addresses \(169.254.\*.\*\) that can never be resolved by clients.  
  
    You should also enable DNS scavenging and aging. For more information, see [Enable Aging and Scavenging for DNS](http://go.microsoft.com/fwlink/?LinkId=184877) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184877\).  
  
