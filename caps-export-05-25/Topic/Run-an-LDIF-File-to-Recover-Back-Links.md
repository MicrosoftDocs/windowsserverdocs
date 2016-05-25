---
title: Run an LDIF File to Recover Back-Links
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b0806d08-97e1-48eb-a45d-b73712c88882
author: Femila
---
# Run an LDIF File to Recover Back-Links
  When you perform an authoritative restore on a domain controller that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server 2003 R2, Windows Server 2003 with Service Pack 1 \(SP1\), or Windows Server 2003 with Service Pack 2 \(SP2\), the output of the authoritative restore procedure includes an LDAP Data Interchange Format \(LDIF\) \(.ldf\) file. This .ldf file contains information about the forward\-links that are required so that the group memberships \(back\-links\) of any restored user, group, or computer objects in Active Directory Domain Services \(AD DS\) can be recovered in the domain in which the deletions occurred. You can use this procedure to run an .ldf file to recover back\-links for Active Directory objects.  
  
 **Restore group memberships in the domain of the deletions**  
  
 For each object or subtree that you authoritatively restore, run the .ldf file on the restored domain controller to recover group memberships in the domain of the deletions.  
  
 **Restore group memberships in other domains**  
  
 To recover group memberships in other domains in the forest, you must first generate an .ldf file in that domain, as described in [Create an LDIF File for Recovering Back-Links for Authoritatively Restored Objects](../Topic/Create-an-LDIF-File-for-Recovering-Back-Links-for-Authoritatively-Restored-Objects.md). Then, use this procedure in the respective domain to recover back\-links.  
  
 When you recover group memberships in domains other than the domain of the deletions, you first perform a nonauthoritative restore of the domain controller to return AD DS to a state in which it contained the deleted memberships and then use the .txt file to generate the .ldf file. The domain controller that you restore from backup has old data until it has finished replicating from another domain controller in the domain. If you add users to groups on the restored computer before it is up to date, you might lose some of the changes that you make when this domain controller is updated through inbound replication. For this reason, run the .ldf file on a different, up\-to\-date domain controller in the same domain.  
  
> [!NOTE]  
>  This procedure is critical for recovering group memberships for deleted users, groups, or computers, but it applies to any restored objects that have back\-link attributes.  
  
 This procedure explains how to use the Ldifde tool and an .ldf file to recover back\-links for authoritatively restored objects in a single domain. Perform this procedure on an up\-to\-date domain controller in the domain of the group or groups whose memberships you are recovering.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To run an .ldf file to recover back\-links after authoritative restore  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**. Change directories, if necessary, to the directory of the .ldf file and its respective log files.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `ldifde -i -k -f <FileName>`  
  
     Where `<FileName>` is the name of the .ldf file that you want to run, for example, ar\_20080609\-174604\_links\_corp.contoso.com.ldf.  
  
## Additional references  
  
-   [Create an LDIF File for Recovering Back-Links for Authoritatively Restored Objects](../Topic/Create-an-LDIF-File-for-Recovering-Back-Links-for-Authoritatively-Restored-Objects.md)  
  
  