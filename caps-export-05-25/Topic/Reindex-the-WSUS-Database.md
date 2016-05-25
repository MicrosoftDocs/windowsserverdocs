---
title: Reindex the WSUS Database
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0077e395-434d-4f60-85a0-ed3091449235
author: britw
---
# Reindex the WSUS Database
We recommend that you reindex the WSUS database at least once a month.  
  
The [WsusDBMaintenance](http://go.microsoft.com/fwlink/?LinkId=87027) script allows you to reindex any version of the WSUS database, SQL Server or [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)].  
  
If you are using [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] for the WSUS database, you need to use the **sqlcmd** utility. For more information about the **sqlcmd** utility, see [sqlcmd Utility](http://go.microsoft.com/fwlink/?LinkId=81183).  
  
To use this script with [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)], you should run the following command:  
  
```  
sqlcmd -S np:\\.\pipe\MSSQL$MICROSOFT##SSEE\sql\query -i <scriptLocation>\WsusDBMaintenance.sql  
```  
  
where *<scriptLocation>* is the directory that contains the WsusDBMaintenance script.  
  
