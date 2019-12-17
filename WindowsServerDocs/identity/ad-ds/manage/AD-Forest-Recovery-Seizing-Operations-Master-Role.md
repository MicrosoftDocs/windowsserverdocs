---
title: AD Forest Recovery - Seizing an Operations Master Role 
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 7e6bb370-f840-4416-b5e2-86b0ba715f4f
ms.technology: identity-adds
---
# AD Forest Recovery - Seizing an operations master role  

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Use the following procedure to seize an operations master role (also known as a flexible single master operations (FSMO) role). You can use Ntdsutil.exe, a command-line tool that is installed automatically on all DCs.  
  
## To seize an operations master role  
  
1. At the command prompt, type the following command, and then press ENTER:  

   ```  
   ntdsutil  
   ```  

2. At the **ntdsutil:** prompt, type the following command, and then press ENTER:  

   ```  
   roles  
   ```  

3. At the **FSMO maintenance:** prompt, type the following command, and then press ENTER:  

   ```  
   connections  
   ```  

4. At the **server connections:** prompt, type the following command, and then press ENTER:  

   ```  
   Connect to server ServerFQDN  
   ```  

   Where *ServerFQDN* is the fully qualified domain name (FQDN) of this DC, for example: **connect to server nycdc01.example.com**.  

   If *ServerFQDN* does not succeed, use the NetBIOS name of the DC.  

5. At the **server connections:** prompt, type the following command, and then press ENTER:  

   ```  
   quit  
   ```  

6. Depending on the role that you want to seize, at the **FSMO maintenance:** prompt, type the appropriate command as described in the following table, and then press ENTER.  
  
|Role|Credentials|Command|  
|----------|-----------------|-------------|  
|Domain naming master|Enterprise Admins|**Seize naming master**|  
|Schema master|Schema Admins|**Seize schema master**|  
|Infrastructure master **Note:**  After you seize the infrastructure master role, you may receive an error later if you need to run Adprep /Rodcprep. For more information, see KB article [949257](https://support.microsoft.com/kb/949257).|Domain Admins|**Seize infrastructure master**|  
|PDC emulator master|Domain Admins|**Seize pdc**|  
|RID master|Domain Admins|**Seize rid master**|  

After you confirm the request, Active Directory or AD DS attempts to transfer the role. When the transfer fails, some error information appears, and Active Directory or AD DS proceeds with the seizure. After the seizure is complete, a list of the roles and the Lightweight Directory Access Protocol (LDAP) name of the server that currently holds each role appears. You can also run **Netdom Query FSMO** at an elevated command prompt to verify current role holders.  
  
> [!NOTE]
> If this computer was not a RID master before the failure and you attempt to seize the RID master role, the computer tries to synchronize with a replication partner before accepting this role. However, because this step is performed when the computer is isolated, it will not succeed in synchronizing with a partner. Therefore, a dialog box appears asking you whether you want to continue with the operation despite this computer not being able to synchronize with a partner. Click **Yes**.  
  
## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
