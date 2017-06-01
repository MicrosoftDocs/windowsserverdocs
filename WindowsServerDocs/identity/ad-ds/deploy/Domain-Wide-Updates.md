---
ms.assetid: 2a5d5271-6ac6-4c1b-b4ef-9b568932a55a
title: Domain-Wide Updates
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Domain-Wide Updates

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can review the following set of changes to help understand and prepare for the schema updates that are performed by adprep /domainprep in Windows Server 2012. There are no domain-wide operations performed by the **domainprep** command in Windows Server 2012 R2.  
  
Beginning in Windows Server 2012, Adprep commands run automatically as needed during AD DS installation. They can also be run separately in advance of AD DS installation. For more information, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018(v=ws.10).aspx).  
  
For more information about how to interpret the access control entry (ACE) strings, see [ACE strings](http://msdn.microsoft.com/library/aa374928(VS.85).aspx). For more information about how to interpret the security ID (SID) strings, see [SID strings](http://msdn.microsoft.com/library/aa379602(VS.85).aspx).  
  
## Windows Server 2012 R2: Domain-wide updates  
Although no operations are performed by **domainprep** in Windows Server 2012 R2, after the command completes, the **revision** attribute for the CN=ActiveDirectoryUpdate,CN=DomainUpdates,CN=System,DC=ForestRootDomain object is set to **10**.  
  
## Windows Server 2012: Domain-wide updates  
After the operations that are performed by **domainprep** in Windows Server 2012 (operations 78, 79, 80, and 81) complete, the **revision** attribute for the CN=ActiveDirectoryUpdate,CN=DomainUpdates,CN=System,DC=ForestRootDomain object is set to **9**.  
  
|Operations number and GUID|Description|Attributes|Permissions|  
|------------------------------|---------------|--------------|---------------|  
|**Operation 78**: {c3c927a6-cc1d-47c0-966b-be8f9b63d991}|Create a new object CN=TPM Devices in the Domain partition.|-   Object class: msTPM-InformationObjectsContainer|N/A|  
|**Operation 79**: {54afcfb9-637a-4251-9f47-4d50e7021211}|Created an access control entry for the TPM service.|N/A|-   (OA;CIIO;WP;ea1b7b93-5e48-46d5-bc6c-4df4fda78a35;bf967a86-0de6-11d0-a285-00aa003049e2;PS)|  
|**Operation 80**: {f4728883-84dd-483c-9897-274f2ebcf11e}|Grant "Clone DC" extended right to **Cloneable Domain Controllers** group|N/A|-   (OA;;CR;3e0f7e18-2c7a-4c10-ba82-4d926db99a3e;;*domain SID*-522)|  
|**Operation 81**: {ff4f9d27-7157-4cb0-80a9-5d6f2b14c8ff}|Grant ms-DS-Allowed-To-Act-On-Behalf-Of-Other-Identity to Principal Self on all objects.|N/A|-   (OA;CIOI;RPWP;3f78c3e5-f79a-46bd-a0b8-9d18116ddc79;;PS)|  
  


