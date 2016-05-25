---
title: Issues with the Database
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 46af7b4a-cdf7-46a0-9521-dc0d78e79e50
author: britw
---
# Issues with the Database
If you have problems with the SQL Server database or [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)], make sure that the WSUS database is in the correct SQL Server instance before you start to troubleshoot SQL Server issues.  
  
> [!NOTE]  
> You need to use the **sqlcmd** utility. For more information about the **sqlcmd** utility, see [sqlcmd Utility](http://go.microsoft.com/fwlink/?LinkId=81183).  
  
## Troubleshooting database issues  
  
##### To ensure that the WSUS database is in the correct SQL Server instance  
  
1.  Verify the SQL Server name by opening a Command Prompt window and typing the following:  
  
    **Reg query "HKLM\\SOFTWARE\\Microsoft\\Update Services\\Server\\Setup" \/v SqlServerName**  
  
    The output contains the SQL Server name to be used in the next step.  
  
2.  Type the following:  
  
    sqlcmd \-S *SqlServerName* \-E \-d SUSDB.  
  
    If you are using [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] as the WSUS database, use the following string in place of *SqlServerName* in the command:  
  
    **np:\\\\.\\pipe\\MSSQL$MICROSOFT\#\#SSEE\\sql\\query**.  
  
3.  Review any error messages and correct the problems.  
  
