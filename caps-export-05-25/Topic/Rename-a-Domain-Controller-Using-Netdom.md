---
title: Rename a Domain Controller Using Netdom
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 0c7bd6ab-9383-48b4-a2d9-035da474ccf7
author: Femila
---
# Rename a Domain Controller Using Netdom
  You can use this procedure to rename a domain controller by using the Netdom command\-line tool.  
  
 The **netdom** command updates the Service Principal Name \(SPN\) attributes in Active Directory Domain Services \(AD DS\) for the computer account. This command also registers Domain Name System \(DNS\) resource records for the new computer name. The SPN value of the computer account must be replicated to all domain controllers in the domain, and the DNS resource records for the new computer name must be distributed to all the authoritative DNS servers for the domain name. If the updates and registrations have not occurred before the removal of the old computer name, some clients might not be able to locate this computer using the new name or the old name.  
  
 The corresponding nTFRSMember or msDFSR\-Member object is not renamed automatically, but the reference attributes are correctly set so SYSVOL replication is not impacted. The only potential problem with not renaming these objects is that if another domain controller is created at a later date with the same NetBIOS name of the old domain controller, then a conflict can occur as described in [KB article 316826](http://support.microsoft.com/kb/316826). After the rename is complete, you can optionally [rename the nTFRSMember or msDFSR\-Member object](http://technet.microsoft.com/library/cc794759(v=ws.10).aspx) as part of cleanup.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To rename a domain controller using Netdom  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command to add the new domain controller name, and then press ENTER:  
  
     `netdom computername <CurrentComputerName> /add:<NewComputerName>`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |netdom computername|Manages the primary and alternate names for a computer.|  
    |\<CurrentComputerName\>|The current, or primary, fully qualified DNS name of the computer that you are renaming.|  
    |\/add:|Specifies that a new alternate DNS name should be added.|  
    |\<NewComputerName\>|The new fully qualified DNS name for the computer that you are renaming.|  
  
3.  Type the following command to designate the new name as the primary computer name, and then press ENTER:  
  
     `netdom computername <CurrentComputerName> /makeprimary:<NewComputerName>`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |netdom computername|Manages the primary and alternate names for a computer.|  
    |\<CurrentComputerName\>|The current, or primary, fully qualified domain name \(FQDN\)of the computer that you are renaming.|  
    |\/makeprimary:|Specifies that an existing alternate name should be made into the primary name.|  
    |\<NewComputerName\>|The new name for the computer. The *NewComputerName* must be a FQDN. The primary DNS suffix that is specified in the FQDN for *NewComputerName* must be the same as the primary DNS suffix of *CurrentComputerName*, or it must match the DNS name of the Active Directory domain that is hosted by this domain controller, or it must be contained in the list of allowed DNS suffixes that is specified in the **msDS\-AllowedDNSSuffixes** attribute of the domainDns object.|  
  
4.  Restart the computer.  
  
5.  After the computer restarts, open a Command Prompt.  
  
6.  At the command prompt, type the following command to remove the old domain controller name, and then press ENTER:  
  
     `netdom computername <NewComputerName> /remove:<OldComputerName>`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |netdom computername|Manages the primary and alternate names for a computer.|  
    |\<NewComputerName\>|The new FQDN that you added for the computer in step 2.|  
    |\/remove:|Specifies that an existing alternate name should be removed.|  
    |\<OldComputerName\>|The old FQDN of the renamed computer.|  
  
## See Also  
 [Rename a Domain Controller Using System Properties](../Topic/Rename-a-Domain-Controller-Using-System-Properties.md)  
  
  