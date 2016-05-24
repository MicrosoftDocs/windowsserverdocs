---
title: Determine the tombstone lifetime for the forest
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f3df8a52-81ea-4a1d-9823-4e51fbd3422a
author: Femila
---
# Determine the tombstone lifetime for the forest
  The tombstone lifetime in an Active Directory forest determines how long a deleted object \(called a “tombstone”\) is retained in Active Directory Domain Services \(AD DS\). The tombstone lifetime is determined by the value of the **tombstoneLifetime** attribute on the Directory Service object in the configuration directory partition.  
  
 You can use this procedure to determine the tombstone lifetime for the forest.  
  
 Membership in **Domain Users**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine the tombstone lifetime for the forest using ADSIEdit  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **ADSI Edit**.  
  
2.  In ADSI Edit, right\-click **ADSI Edit**, and then click **Connect to**.  
  
3.  For **Connection Point**, click **Select a well known Naming Context**, and then click **Configuration**.  
  
4.  If you want to connect to a different domain controller, for **Computer**, click **Select or type a domain or server: \(Server | Domain \[:port\]\)**. Provide the server name or the domain name and Lightweight Directory Access Protocol \(LDAP\) port \(389\), and then click **OK**.  
  
5.  Double\-click **Configuration**, **CN\=Configuration,DC\=***ForestRootDomainName*, **CN\=Services**, and **CN\=Windows NT**.  
  
6.  Right\-click **CN\=Directory Service**, and then click **Properties**.  
  
7.  In the **Attribute** column, click **tombstoneLifetime**.  
  
8.  Note the value in the **Value** column. If the value is **\<not set\>**, the value is 60 days.  
  
### To determine the tombstone lifetime for the forest using Dsquery  
  
1.  Open a Command Prompt window. To open a command prompt, click **Start**, click **Run**, type **cmd**, and then press ENTER.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    dsquery * "cn=directory service,cn=windows nt,cn=services,cn=configuration,dc=<forestDN>" -scope base -attr tombstonelifetime  
    ```  
  
     Be sure to replace `<forestDN>` with the actual distinguished name of the forest. For example, if your forest name is corp.proseware.com, type the following, and then press ENTER:  
  
    ```  
    dsquery * "cn=directory service,cn=windows nt,cn=services,cn=configuration,dc=corp,dc=proseware,dc=com" -scope base -attr tombstonelifetime  
    ```  
  
  