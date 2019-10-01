---
title: AD Forest Recovery - Cleanup
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
# AD Forest Recovery - Cleanup

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

 Perform the following post recovery steps as needed:  
  
- After the entire forest is recovered, you can revert to the original DNS configuration, including configuration of the preferred and alternate DNS servers on each of the DCs. After the DNS servers are configured as they were before the malfunction, their previous name resolution capabilities will be restored. Delete any DNS records for DCs that have not been recovered.  
- Delete Windows Internet Name Service (WINS) records for all DCs that have not been recovered.  
- You can transfer the operations master roles to other DCs in the domain or forest and add more global catalog servers based on the configuration before the failure.  
- Because the entire forest is restored to a previous state, any objects (such as users and computers) that were added and all updates (such as password changes) that were made to existing objects after this point are lost. Therefore, you should re-create these missing objects and reapply the missing updates as appropriate.  
- You might also need to restore outgoing trusts with external domains and forests, because these external trust relationships are not restored automatically from backups.

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
