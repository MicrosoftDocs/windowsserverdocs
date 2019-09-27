---
title: AD Forest Recovery - Backing up a full server 
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 398918dc-c8ab-41a6-a377-95681ec0b543
ms.technology: identity-adds
---
# Resetting a trust password on one side of the trust  

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

 If the forest recovery is related to a security breach, use the following procedure to reset a trust password on one side of the trust. This includes implicit trusts between child and parent domains as well as explicit trusts between this domain (the trusting domain) and another domain (the trusted domain). 
  
 Reset the password on only the trusting domain side of the trust, also known as the incoming trust (the side where this domain belongs). Then, use the same password on the trusted domain side of the trust, also known as the outgoing trust. Reset the password of the outgoing trust when you restore the first DC in each of the other (trusted) domains. 
  
 Resetting the trust password ensures that the DC does not replicate with potentially bad DCs outside its domain. By setting the same trust password while restoring the first DC in each of the domains, you ensure that this DC replicates with each of the recovered DCs. Subsequent DCs in the domain that are recovered by installing AD DS will automatically replicate these new passwords during the installation process. 
  
## To reset a trust password on one side of the trust  
  
1. At a command prompt, type the following command, and then press ENTER:  

   ```  
   netdom experthelp trust  
   ```  
  
2. Use the syntax that this command provides for using the NetDom tool to reset the trust password.
   For example, if there are two domains in the forest—parent and child—and you are running this command on the restored DC in the parent domain, use the following command syntax:  

   ```  
   netdom trust parent domain name /domain:child domain name /resetOneSide /passwordT:password /userO:administrator /passwordO:*  
   ```  

   When you run this command in the child domain, use the following command syntax:  

   ```  
   netdom trust child domain name /domain:parent domain name /resetOneSide /passwordT:password /userO:administrator /passwordO:*  
   ```  

   > [!NOTE]
   > **passwordT** should be the same value on both sides of the trust. Run this command only once (unlike the **netdom resetpwd** command) because it automatically resets the password twice. 
  
## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
