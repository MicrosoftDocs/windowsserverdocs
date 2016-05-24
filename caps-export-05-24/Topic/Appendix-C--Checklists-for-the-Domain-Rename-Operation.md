---
title: Appendix C: Checklists for the Domain Rename Operation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 17e3c08e-17a1-42bd-9a38-88e6d668f071
author: Femila
---
# Appendix C: Checklists for the Domain Rename Operation
  This appendix provides checklists for the tasks to be performed during the various phases of the domain rename operation.  
  
 Complete the tasks in these checklists in the order in which they are presented. If a reference link takes you to a conceptual topic, return to the checklist after you review the conceptual topic so that you can proceed with the remaining tasks.  
  
## Satisfying domain rename requirements  
 This checklist provides the list of requirements that must be met before you can begin a domain rename operation.  
  
> [!IMPORTANT]  
>  The domain rename operation is not supported in Microsoft Exchange Server 2007 or Exchange Server 2010. Domain Name System \(DNS\) domain rename is supported in Exchange Server 2003. However, renaming of the NetBIOS domain name is not supported in any version of Exchange Server. Other non\-Microsoft applications might also not support domain rename.  
>   
>  For more information about other Microsoft applications that are incompatible with domain rename, see [article 300684](http://go.microsoft.com/fwlink/?LinkId=185229) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185229\) in the Microsoft Knowledge Base.  
  
 ![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Satisfying domain rename requirements**  
  
||Task|Reference|  
|-|----------|---------------|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Adjust the forest functional level.<br /><br /> You can rename domains only in a forest in which all the domain controllers are running [!INCLUDE[nextref_longhornstd](../Token/nextref_longhornstd_md.md)] or Windows Server 2003 Standard Edition, [!INCLUDE[nextref_longhornent](../Token/nextref_longhornent_md.md)] or Windows Server 2003 Enterprise Edition, or [!INCLUDE[nextref_longhorndat](../Token/nextref_longhorndat_md.md)] or Windows Server 2003 Datacenter Edition operating systems, and the Active Directory forest functional level has been raised to either Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. The domain rename operation will not succeed if the forest functional level is set to Windows 2000 native.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) For more information about forest functional levels and for procedures to determine and set forest functional levels, see Enabling Windows Server 2008 Advanced Features for Active Directory Domain Services \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=105303](http://go.microsoft.com/fwlink/?LinkID=105303)\).|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Obtain the necessary administrative credentials.<br /><br /> You must have Enterprise Admins credentials to perform the various steps in the domain rename procedures. If you are running Microsoft Exchange, the account that you use must also have Full Exchange Administrator credentials.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) The required credentials for each procedure in the domain rename operations are described throughout the topics in [Managing Active Directory Domain Rename](../Topic/Managing-Active-Directory-Domain-Rename.md).|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Set up the control station.<br /><br /> The computer that is to be used as the control station for the domain rename operation must be a member computer \(not a domain controller\) that is running [!INCLUDE[nextref_longhornstd](../Token/nextref_longhornstd_md.md)], [!INCLUDE[nextref_longhornent](../Token/nextref_longhornent_md.md)], or [!INCLUDE[nextref_longhorndat](../Token/nextref_longhorndat_md.md)].|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Set Up the Control Station](../Topic/Set-Up-the-Control-Station.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Configure Distributed File System \(DFS\) root servers.<br /><br /> If you want to rename a domain with domain\-based DFS roots, all DFS root servers must be running Windows 2000 Service Pack 3 \(SP3\) or a later release of Windows Server, up to Windows Server 2008.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) For more information, see Distributed File System Technology Center \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=18421](http://go.microsoft.com/fwlink/?LinkID=18421)\).|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Satisfy Exchange\-specific requirements:<br /><br /> -   Exchange 2003 SP1: If your Active Directory forest contains only Exchange 2003 Service Pack 1 \(SP1\) servers, you can run the domain rename operation, but you must also use the Exchange Domain Rename Fix\-up Tool to update Exchange attributes. So that you can perform a domain rename operation, Exchange must not be installed on any domain controllers. If a domain controller is running Exchange, move the Exchange data off the domain controller and uninstall Exchange.<br />-   Exchange 2003, Exchange 2000, or Exchange 5.5: The domain rename operation is not supported in an Active Directory forest that contains Exchange Server 2003, Exchange 2000, or Exchange 5.5 servers. If the domain rename tool detects Exchange 2000 servers, the tool will not proceed. The domain rename tool will not detect whether Exchange 5.5 servers exist. Therefore, do not attempt the domain rename operation if the forest contains Exchange 5.5 servers.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) The Exchange Domain Rename Fix\-up Tool is available at Microsoft Exchange Server Domain Rename Fixup \(XDR\-Fixup\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122982](http://go.microsoft.com/fwlink/?LinkID=122982)\).|  
  
## Preparing for the domain rename operation  
 This checklist provides the list of tasks for preparing for the domain rename operation.  
  
 ![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Preparing for the domain rename operation**  
  
||Task|Reference|  
|-|----------|---------------|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Adjust the forest functional level. **Note:**  You can rename domains only in a forest in which all of the domain controllers are running [!INCLUDE[nextref_longhornstd](../Token/nextref_longhornstd_md.md)] or Windows Server 2003 Standard Edition, [!INCLUDE[nextref_longhornent](../Token/nextref_longhornent_md.md)] or Windows Server 2003 Enterprise Edition, or [!INCLUDE[nextref_longhorndat](../Token/nextref_longhorndat_md.md)] or Windows Server 2003 Datacenter Edition operating systems, and the Active Directory forest functional level has been raised to either Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. The domain rename operation will not succeed if the forest functional level is set to Windows 2000 native.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Adjust Forest Functional Level](../Topic/Adjust-Forest-Functional-Level.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Create necessary shortcut trust relationships within the forest, and document all trusts.<br /><br /> -   Compile a list of domains to be renamed based on the new forest structure that you want.<br />-   Create shortcut trusts, if necessary.<br />-   Compile a list of all existing trusts—shortcut, external, and across forests—in the forest.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Create Necessary Shortcut Trust Relationships](../Topic/Create-Necessary-Shortcut-Trust-Relationships.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Prepare Domain Name System \(DNS\) zones.<br /><br /> -   Compile a list of DNS zones for the domain rename operation.<br />-   Create new DNS zones as necessary as a result of the name changes to be performed.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Prepare DNS Zones](../Topic/Prepare-DNS-Zones.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Redirect Special Folders to a Stand\-Alone Distributed File System Namespace \(DFSN\).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Redirect Special Folders to a Standalone DFSN](../Topic/Redirect-Special-Folders-to-a-Standalone-DFSN.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Relocate Roaming User Profiles to a Stand\-Alone DFSN.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Relocate Folder Redirection and Roaming User Profiles](../Topic/Relocate-Folder-Redirection-and-Roaming-User-Profiles.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Prepare member computers for host name changes.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Configure Member Computers for Host Name Changes](../Topic/Configure-Member-Computers-for-Host-Name-Changes.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Prepare certification authorities \(CAs\).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Prepare Certification Authorities](../Topic/Prepare-Certification-Authorities.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Prepare a domain that contains Exchange.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Exchange-Specific Steps: Prepare a Domain that Contains Exchange](../Topic/Exchange-Specific-Steps--Prepare-a-Domain-that-Contains-Exchange.md)|  
  
## Performing the domain rename operation  
 This checklist provides the list of tasks that to perform during the core domain rename operation.  
  
 ![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Performing the domain rename operation**  
  
||Task|Reference|  
|-|----------|---------------|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Set up your control station for the domain rename operation.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Set Up the Control Station](../Topic/Set-Up-the-Control-Station.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Freeze the Forest Configuration|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Freeze the Forest Configuration](../Topic/Freeze-the-Forest-Configuration.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Back up all the domain controllers in your forest.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Back Up All Domain Controllers](../Topic/Back-Up-All-Domain-Controllers.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Generate the current forest description.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Generate the Current Forest Description](../Topic/Generate-the-Current-Forest-Description.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Specify the new forest description.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Specify the New Forest Description](../Topic/Specify-the-New-Forest-Description.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Generate domain rename instructions.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Generate Domain Rename Instructions](../Topic/Generate-Domain-Rename-Instructions.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Push domain rename instructions to all domain controllers, and verify DNS readiness.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Push Domain Rename Instructions to All Domain Controllers and Verify DNS Readiness](../Topic/Push-Domain-Rename-Instructions-to-All-Domain-Controllers-and-Verify-DNS-Readiness.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Verify the readiness of the domain controllers.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Verify Readiness of Domain Controllers](../Topic/Verify-Readiness-of-Domain-Controllers.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Execute the domain rename instructions.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Run Domain Rename Instructions](../Topic/Run-Domain-Rename-Instructions.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Update the Exchange configuration, and restart the Exchange servers. **Note:**  This is an optional, Exchange\-specific task.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Exchange-Specific Steps: Update the Exchange Configuration and Restart Exchange Servers](../Topic/Exchange-Specific-Steps--Update-the-Exchange-Configuration-and-Restart-Exchange-Servers.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Unfreeze the forest configuration.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Unfreeze the Forest Configuration](../Topic/Unfreeze-the-Forest-Configuration.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Re\-establish external trusts.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Re-establish External Trusts](../Topic/Re-establish-External-Trusts.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Fix Group Policy objects \(GPOs\) and links.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Fix Group Policy Objects and Links](../Topic/Fix-Group-Policy-Objects-and-Links.md)|  
  
## Completing the domain rename operation  
 This checklist provides a list of tasks that have to be performed after the core domain rename procedures are complete. Some tasks may be optional, depending on your situation and business needs.  
  
 ![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Completing the domain rename operation**  
  
||Task|Reference|  
|-|----------|---------------|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Verify certificate security.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Verify Certificate Security](../Topic/Verify-Certificate-Security.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Perform certain miscellaneous procedures.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Perform Miscellaneous Tasks](../Topic/Perform-Miscellaneous-Tasks.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Back up domain controllers.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Back Up Domain Controllers](../Topic/Back-Up-Domain-Controllers.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Restart all member computers.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Restart Member Computers](../Topic/Restart-Member-Computers.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Verify the Exchange rename, and update Active Directory Connector. **Note:**  This is an optional, Exchange\-specific step.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Exchange-Specific Steps: Verify the Exchange Rename and Update Active Directory Connector](../Topic/Exchange-Specific-Steps--Verify-the-Exchange-Rename-and-Update-Active-Directory-Connector.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Perform attribute cleanup.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Perform Attribute Cleanup](../Topic/Perform-Attribute-Cleanup.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Rename domain controllers.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif) [Rename Domain Controllers](../Topic/Rename-Domain-Controllers.md)|  
  
  