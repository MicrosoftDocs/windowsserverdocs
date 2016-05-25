---
title: Mark an Object or Objects as Authoritative
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5d038848-0793-4e34-9559-eae0884d3e49
author: Femila
---
# Mark an Object or Objects as Authoritative
  You can use this procedure to mark Active Directory objects as authoritative when you perform an authoritative restore. In this procedure, you use the **ntdsutil** command to select objects that are to be marked authoritative when they replicate to other domain controllers.  
  
 This procedure has the following preliminary requirements:  
  
-   You must know the full distinguished name of the object or objects that you want to restore.  
  
-   If the deletions that you are recovering have replicated to the recovery domain controller, you must have completed a nonauthoritative restore procedure, after which you did not restart the domain controller and it remains in Directory Services Restore Mode \(DSRM\).  
  
-   If the deletions that you are recovering have not replicated to the recovery domain controller, you can perform this procedure in normal mode with Active Directory Domain Services \(AD DS\) stopped.  
  
 The Ntdsutil functionality that is described in this procedure is available on domain controllers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. To perform authoritative restore on a domain controller that is running a version of Windows Server 2003, see Performing an Authoritative Restore of Active Directory Objects \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=44194](http://go.microsoft.com/fwlink/?LinkId=44194)\).  
  
> [!NOTE]  
>  If you are able to stop inbound replication on a global catalog server or other domain controller in the domain before it has received the deletion that you want to restore, you can skip the nonauthoritative restore process.  
  
 Perform this procedure to recover deleted objects in the domain and to restore back\-links for those objects in this domain. If you are running the authoritative restore procedure on a global catalog server, back\-links for objects in other domains are also updated if the forward link is stored in the global catalog. For example, the values for back\-link attribute **memberOf** are restored in this procedure if the forward link **member** is stored in the global catalog or in the domain directory partition. In the case of domain local groups, the **member** attribute is not stored in the global catalog and it is not stored in the recovery domain if the group exists in a different domain. In this case, you must perform additional steps to recover domain local group memberships of restored security principals. These steps are described in [Create an LDIF File for Recovering Back-Links for Authoritatively Restored Objects](../Topic/Create-an-LDIF-File-for-Recovering-Back-Links-for-Authoritatively-Restored-Objects.md)  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To mark a subtree or individual object authoritative  
  
1.  In DSRM, click **Start**, click **Run**, type **ntdsutil**, and then press ENTER.  
  
2.  At the `ntdsutil:` prompt, type `activate instance ntds`, and then press ENTER.  
  
3.  At the `ntdsutil:` prompt, type `authoritative restore`, and then press ENTER.  
  
4.  To restore a subtree or individual object, type one of the following commands, as appropriate, and then press ENTER:  
  
     To restore a subtree \(for example, an organizational unit \(OU\) and all child objects\):  
  
     `restore subtree <DistinguishedName>`  
  
     To restore a single object:  
  
     `restore object <DistinguishedName>`  
  
     Where `<DistinguishedName>` is the distinguished name of the subtree or object that is to be marked authoritative.  
  
5.  Click **Yes** in the message box to confirm the command.  
  
     For example, if you want to restore a deleted OU named Marketing NorthAm in the corp.contoso.com domain, type:  
  
     `restore subtree “OU=Marketing NorthAm,DC=corp,DC=contoso,DC=com”`  
  
     \(Always enclose the distinguished name in quotes when there is a space or other special characters within the distinguished name.\)  
  
     Ntdsutil attempts to mark the object as authoritative. The output message indicates the status of the operation. The most common cause of failure is an incorrectly specified distinguished name or a backup for which the distinguished name does not exist. \(This occurs if you try to restore a deleted object that was created after the backup\).  
  
    > [!NOTE]  
    >  If the object is marked authoritative and the restore did not work as expected and then the same backup is used to restore the Active Directory database again, the attribute version numbers of the object to be restored authoritatively must be increased higher than the default of 100000 or the object will not replicate out after the second restore. The syntax below is needed to script an increased version number higher than 100000 \(default\): ntdsutil "authoritative restore" "restore object \\"CN\=Smith\\, John,OU\=sales,DC\=contoso,DC\=com\\" verinc 150000\\"" q q  
    >   
    >  If the script prompts for confirmation on each object being restored you can turn off the prompts. The syntax to turn off the prompts is: ntdsutil "popups off" "authoritative restore" "restore object \\"CN\=John Smith,OU\=sales,DC\=contoso,DC\=com\\" verinc 150000\\"" q q  
  
     The following sample output shows that Ntdsutil created a text file \(.txt\) and an LDAP Data Interchange Format \(LDIF\) \(.ldf\) file when the marked object was found to have back\-links:  
  
    ```  
    Successfully updated 3 records.  
  
    The following text file with a list of authoritatively restored  
    objects has been created in the current working directory:          
    ar_20080209-091249_objects.txt  
  
    One or more specified objects have back-links in this domain. The  
    following LDIF files with link restore operations have been created  
    in the current working directory:  
            ar_20080209-091249_links_Corp.Contoso.com.ldf  
  
    Authoritative Restore completed successfully.  
  
    ```  
  
6.  Make a note of the location of the .txt and .ldf files, if any. We recommend that you use the .ldf file to restore back\-links in this domain, even if restored objects are members of groups that were created before linked\-value replication \(LVR\) was in effect. However, in all cases where any of the restored objects listed in the .txt file has memberships in groups in a different domain, you must use the .txt file to generate an .ldf file to restore back\-links in those domains. If you have other domains in which you want to restore back\-links for this restored object, make a copy of this .txt file to use on a domain controller in each additional domain.  
  
7.  At the `authoritative restore:` and `ntdsutil:` prompts, type `quit,` and then press ENTER.  
  
8.  Restart the domain controller in normal operating mode.  
  
## Additional references  
  
-   [Run an LDIF File to Recover Back-Links](../Topic/Run-an-LDIF-File-to-Recover-Back-Links.md)  
  
  