---
description: "Learn more about: AD Forest Recovery - Adding the GC"
title: AD Forest Recovery - Adding the GC
ms.author: daveba
author: iainfoulds
manager: daveba
ms.date: 06/21/2023
ms.topic: article
ms.custom: 5a291f65-794e-4fc3-996e-094c5845a383, inhenkel
---

# Active Directory Forest Recovery - Add the GC

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Use the following procedure to add the global catalog to a DC.

## Add the global catalog

1. Select **Start**, point to **All Programs**, point to **Administrative Tools**, and then select **Active Directory Sites and Services**.
1. In the console tree, expand the **Sites** container, and then select the appropriate site that contains the target server.
1. Expand the **Servers** container, and then expand the server object for the DC to which you want to add the global catalog.
1. Right-click **NTDS Settings**, and then select **Properties**.
1. Select the **Global Catalog** check box.

:::image type="content" source="media/adsi1.png" alt-text="Add GC":::

## Add the global catalog using repadmin

- Open an elevated command prompt, type the following command, and press ENTER:

   ```cli
   repadmin.exe /options DC_NAME +IS_GC
   ```

The following are ways to speed up the process of adding the global catalog to the DC in the root domain:

- Ideally, the DC in the root domain should be a replication partner of the restored DCs in the nonroot domains. If so, confirm that the Knowledge Consistency Checker (KCC) has created the corresponding **repsFrom** object for the source DC and partition in the root DC. You can confirm this by running the `repadmin /showreps /v` command.

- If there's no **repsFrom** object created, create this object for the configuration partition. This way, the DC in the root domain can determine which DCs in the nonroot domain have been deleted. You can do this with the following commands:

   ```cli
   repadmin /add ConfigurationNamingContext DestinationDomainController SourceDomainControllerCNAME
   ```

   ```cli
   repadmin /options DSA -Disable_NTDSCONN_XLATE
   ```

   The format for the *SourceDomainControllerCNAME* is:

   ```cli
   sourceDCGuid._msdcs.root domain
   ```

   For example, the repadmin /add command for the configuration partition of the contoso.com domain could be:

   ```cli
   repadmin /add cn=configuration,DC=contoso,DC=com DC01 937ef930-7356-43c8-88dc-8baaaa781cf6._msdcs.dDSP17A22.contoso.com
   ```

- If the **repsFrom** object is present, try to sync the DC in the root domain with the DC in the nonroot domain as follows:

   ```cli
   repadmin /sync DomainNamingContext DestinationDomainController SourceDomainControllerGUID
   ```

   Where *DestinationDomainController* is the DC in the root domain and *SourceDomainController* is the restored DC in the nonroot domain.

- The root domain DNS server should have the alias (CNAME) resource records for the source DC. Ensure that the parent DNS zone contains delegation resource records (name server (NS) and host (A) resource records) for the correct DCs (the DCs that have been restored from backup) in the child zone.
- Make sure that the DC in the root domain is contacting the correct Key Distribution Center (KDC) in the nonroot domain. To test this, at the command prompt, type the following command, and then press ENTER:

   ```cli
   nltest /dsgetdc:nonroot domain name /KDC /Force
   ```

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]