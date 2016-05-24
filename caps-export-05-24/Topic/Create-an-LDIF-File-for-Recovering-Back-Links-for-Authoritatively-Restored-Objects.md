---
title: Create an LDIF File for Recovering Back-Links for Authoritatively Restored Objects
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8eab14ab-5da5-4573-8195-f30572376e79
author: Femila
---
# Create an LDIF File for Recovering Back-Links for Authoritatively Restored Objects
  When you perform an authoritative restore in a domain where deletions of Active Directory objects occurred, the Ntdsutil tool generates a text \(.txt\) file that identifies the objects that have been restored. You can use this .txt file to generate an LDAP Data Interchange Format \(LDIF\) file \(.ldf\) in other domains that might have back\-links from the restored objects.  
  
 This procedure generates the .ldf file that you need to recover back\-links in this domain. Perform this procedure on a domain controller in the domain that might have the back\-links.After you complete this procedure, you must use the Ldifde tool to run the .ldf file on a domain controller in the same domain, as described in [Run an LDIF File to Recover Back-Links](../Topic/Run-an-LDIF-File-to-Recover-Back-Links.md).  
  
> [!NOTE]  
>  To ensure that current group objects are updated, run the .ldf file on a domain controller other than the domain controller that you use to generate the .ldf file.  
  
 Before you perform this procedure, you must:  
  
-   Copy the .txt file that Ntdsutil created during the authoritative restore procedure, which you performed on the first domain controller, to a location on this domain controller or a network share.  
  
-   Restore this domain controller from backup.  
  
 After you restore this domain controller from backup, perform this procedure while the domain controller is still running in Directory Services Restore Mode \(DSRM\).  
  
 To perform this procedure, you must provide the Administrator password for DSRM.  
  
### To create an .ldf file for restoring back\-links for authoritatively restored objects  
  
1.  In DSRM, click **Start**, click **Run**, type **ntdsutil**, and then press ENTER.  
  
2.  At the `ntdsutil:` prompt, type `authoritative restore`, and then press ENTER.  
  
3.  At the `authoritative restore:` prompt, type the following command, and then press ENTER:  
  
     `create ldif files from <TextFilePath>`  
  
     Where `<TextFilePath>` is the location and file name of the .txt file that Ntdsutil created during the initial authoritative restore of the object whose back\-links you want to restore, for example, d:\\ldif\\ar\_20080609\_091558\_objects.txt.  
  
     Ntdsutil displays a message stating that one or more specified objects have back\-links in this domain and an .ldf file has been created in the current working directory.  
  
4.  At the `authoritative restore:` and `ntdsutil:` prompts, type `quit`.  
  
## Additional references  
  
-   [Restore AD DS from Backup &#40;Nonauthoritative Restore&#41;](../Topic/Restore-AD-DS-from-Backup--Nonauthoritative-Restore-.md)  
  
-   [Run an LDIF File to Recover Back-Links](../Topic/Run-an-LDIF-File-to-Recover-Back-Links.md)  
  
  