---
title: Performing an Authoritative Restore of Deleted AD DS Objects_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f4e9ee21-ee35-4650-acca-798555c0c32c
author: femila
---
# Performing an Authoritative Restore of Deleted AD DS Objects_deleted
To perform an authoritative restore of objects in Active Directory Domain Services \(AD DS\), you use the **ntdsutil authoritative restore** command to mark an object or objects as authoritative.  
  
Authoritative restore of AD DS has the following requirements:  
  
-   The object that you want to restore must exist in the Active Directory database on the domain controller where you perform the authoritative restore.  
  
-   You must stop the Active Directory Domain Services service before you run the **ntdsutil authoritative restore** command and restart the service after the command is complete.  
  
    To stop the service, you can run the **net stop ntds** command or you can restart the domain controller in Directory Services Restore Mode \(DSRM\).  
  
    To start the service, run the **net start ntds** command.  
  
For procedures to perform an authoritative restore, see Performing an Authoritative Restore of Active Directory Objects \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=115332](http://go.microsoft.com/fwlink/?LinkId=115332)\). Skip the first step in that procedure: Restore from Backup Media.  
  
