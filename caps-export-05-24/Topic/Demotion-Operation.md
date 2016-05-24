---
title: Demotion Operation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fc59b4e1-71d6-46fa-b2a9-646a3157e7aa
author: Femila
---
# Demotion Operation
  The new options in the following table are available for unattended removal of Active Directory Domain Services \(AD DS\). Options that are new in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] are shown in bold type.  
  
|Parameter|Possible values|Default value|Description|  
|---------------|---------------------|-------------------|-----------------|  
|\/AdministratorPassword|*admin\_password*||Sets the local administrator password for the computer during removal of a domain controller.|  
|**\/DemoteFSMO**|Yes &#124; No|No|Indicates that a forced removal should continue even if an operations master \(also known as flexible single master operations or FSMO\) role is held by the domain controller.|  
|**\/DNSDelegationPassword**|*Password* &#124; \*||Specifies the password for the user name \(the account credentials\) that is used to create or remove the Domain Name System \(DNS\) delegation. Specify \* to prompt the user to enter credentials.|  
|**\/DNSDelegationUserName**|*user\_name*||Specifies the user name to be used when the DNS delegation is created or removed. If you do not specify a value, the account credentials that you specify for the installation or removal of AD DS are used for the DNS delegation.|  
|**\/IgnoreIsLastDcInDomainMismatch**|Yes &#124; No|No|Specifies whether to continue the demotion of the domain controller when either the switch \/IsLastDCInDomain:Yes is specified and Dcpromo detects that there is actually another active domain controller in the domain or when the switch \/IsLastDCInDomain:No is specified and Dcpromo cannot contact any other domain controller in the domain.|  
|**\/IgnoreIsLastDNSServerForZone**|Yes &#124; No|No|Specifies whether to continue the demotion despite the fact that the domain controller is the last DNS server for one or more Active Directory–integrated DNS zones that it hosts.|  
|\/IsLastDCInDomain|Yes &#124; No|No|Specifies whether the computer that is being demoted is the last domain controller in the domain.|  
|\/Password|*Password* &#124; \*||Specifies the password corresponding to the user name \(account credentials\) that is used to promote the domain controller. Specify \* to prompt the user to enter credentials.|  
|**\/RebootOnCompletion**|Yes &#124; No|Yes|Specifies whether to restart the computer upon completion, regardless of success.|  
|**\/RebootOnSuccess**|Yes &#124; No&#124; NoAndNoPromptEither|Yes|Specifies whether to restart the computer upon successful completion of an operation.|  
|\/RemoveApplicationPartitions|Yes &#124; No|No|Specifies whether to remove application directory partitions during removal of a domain controller.|  
|**\/RemoveDNSDelegation**|Yes &#124; No|Yes|Specifies whether to remove DNS delegations that point to this DNS server from the parent DNS zone.|  
|\/RetainDCMetadata|Yes &#124; No|No|Retains domain controller metadata in the domain after removal of AD DS to allow a delegated administrator to remove AD DS from an RODC.|  
|\/UserDomain|*domain\_name*||Specifies the domain name for the user name \(account credentials\) that is used for promoting a domain controller.|  
|\/UserName|*Domain\\user\_name*||Specifies the user name \(account credentials\) that is used for promoting a domain controller. We recommend that you specify the account credentials in the domain\\user\_name format.|  
  
  