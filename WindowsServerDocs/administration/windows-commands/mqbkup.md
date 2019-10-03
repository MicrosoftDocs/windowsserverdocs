---
title: mqbkup
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7bdd41c4-75ef-455f-b241-1d64a4c7acf5

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# mqbkup

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Backs up MSMQ message files and registry settings to a storage device and restores previously-stored messages and settings.   
Both the backup and the restore operation will stop the local MSMQ service. If the MSMQ service was started beforehand, the utility will attempt to restart the MSMQ service at the end of the backup or the restore operation. If the service was already stopped before running the utility, no attempt to restart the service is made.  
Before using the MSMQ Message Backup/Restore utility you must close all local applications that are using MSMQ.  
## Syntax  
```  
mqbkup {/b | /r} <folder path_to_storage_device>  
```  
### Parameters  
|Parameter|Description|  
|-------|--------|  
|/b|Specifies backup operation|  
|/r|Specifies restore operation|  
|<folder path_to_storage\_device>|Specifies the path where the MSMQ message files and registry settings are stored|  
|/?|Displays help at the command prompt.|  
## <a name="BKMK_Examples"></a>Examples  
To backup all MSMQ message files and registry settings and store them in the *Msmqbkup* folder on your C: drive.  
```  
mqbkup /b c:\msmqbkup  
```  
if the specified folder does not exist, the utility will automatically create one. If you choose to specify an existing folder, this folder must be empty. If you specify a non-empty folder, the utility will delete every file and subfolder contained within it. In this case, you will be prompted to give permission to delete existing files and subfolders. You can use the **/y** parameter to indicate that you agree beforehand to the deletion of all existing files and subfolders in the specified folder.  
To delete all files and subfolders in the *Oldbkup* folder on your C: drive and store MSMQ message files and registry settings in this folder.  
```  
mqbkup /b /y c:\oldbkup  
```  
To restore MSMQ messages and registry settings:  
```  
mqbkup /r c:\msmqbkup  
```  
The locations of folders used to store MSMQ message files are stored in the registry. Thus, the utility will restore MSMQ message files to the folders specified in the registry and not to the storage folders used before the restore operation. If the folders specified in the registry do not exist, the restore operation will automatically create them. If folders directories do exist and are not empty, the utility will prompt you for permission to delete the current contents of these folders.  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
