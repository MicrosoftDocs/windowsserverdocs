---
title: AD Forest Recovery - Adding the GC 
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 5a291f65-794e-4fc3-996e-094c5845a383
ms.technology: identity-adds
---
# AD Forest Recovery - Adding the GC

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Use the following procedure to add the global catalog to a DC.  
  
## To add the global catalog  
  
1. Click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
2. In the console tree, expand the **Sites** container, and then select the appropriate site that contains the target server.  
3. Expand the **Servers** container, and then expand the server object for the DC to which you want to add the global catalog.  
4. Right-click **NTDS Settings**, and then click **Properties**.  
5. Select the **Global Catalog** check box.  
![Add GC](media/AD-Forest-Recovery-Add-GC/addgc1.png)

## To add the global catalog using Repadmin  

- Open an elevated command prompt, type the following command, and press ENTER:  

   ```  
   repadmin.exe /options DC_NAME +IS_GC  
   ```  

The following are ways to speed up the process of adding the global catalog to the DC in the root domain:  

- Ideally, the DC in the root domain should be a replication partner of the restored DCs in the non-root domains. If so, confirm that the Knowledge Consistency Checker (KCC) has created the corresponding **repsFrom** object for the source DC and partition in the root DC. You can confirm this by running the **repadmin /showreps /v** command. 

- If there is no **repsFrom** object created, create this object for the configuration partition. This way, the DC in the root domain can determine which DCs in the non-root domain have been deleted. You can do this with the following commands:  

   ```
   repadmin /add ConfigurationNamingContext DestinationDomainController SourceDomainControllerCNAME  
   ```

   ```
   repadmin /options DSA -Disable_NTDSCONN_XLATE  
   ```

   The format for the *SourceDomainControllerCNAME* is:  

   ```
  
   sourceDCGuid._msdcs.root domain  
   ```

   For example, the repadmin /add command for the configuration partition of the contoso.com domain could be:  

   ```
   repadmin /add cn=configuration,DC=contoso,DC=com DC01 937ef930-7356-43c8-88dc-8baaaa781cf6._msdcs.dDSP17A22.contoso.com  
   ```

- If the **repsFrom** object is present, try to sync the DC in the root domain with the DC in the non-root domain as follows:  

   ```
   Repadmin /sync DomainNamingContext DestinationDomainController SourceDomainControllerGUID  
   ```

   Where *DestinationDomainController* is the DC in the root domain and *SourceDomainController* is the restored DC in the non-root domain. 

- The root domain DNS server should have the alias (CNAME) resource records for the source DC. Ensure that the parent DNS zone contains delegation resource records (name server (NS) and host (A) resource records) for the correct DCs (the DCs that have been restored from backup) in the child zone. 
- Make sure that the DC in the root domain is contacting the correct Key Distribution Center (KDC) in the non-root domain. To test this, at the command prompt, type the following command, and then press ENTER:  

   ```
   nltest /dsgetdc:nonroot domain name /KDC /Force  
   ```

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
