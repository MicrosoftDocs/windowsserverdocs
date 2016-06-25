---
title: Event ID 2042: It has been too long since this machine replicated
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: eee53935-a1f0-4c65-9386-e0f5d97bdb6b
translation.priority.ht: 
  - de-de
  - es-es
  - fr-fr
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-tw
---
# Event ID 2042: It has been too long since this machine replicated
If a domain controller has not replicated with its partner for longer than a tombstone lifetime, it is possible that a lingering object problem exists on one or both domain controllers. The tombstone lifetime in an Active Directory forest determines how long a deleted object \(called a “tombstone”\) is retained in Active Directory Domain Services \(AD DS\). The tombstone lifetime is determined by the value of the **tombstoneLifetime** attribute on the Directory Service object in the configuration directory partition.  
  
 When the condition that causes Event ID 2042 to be logged occurs, inbound replication with the source partner is stopped on the destination domain controller and Event ID 2042 is logged in the Directory Service event log. The event identifies the source domain controller and the appropriate steps to take to either remove the outdated domain controller or remove lingering objects and restore replication from the source domain controller.  
  
 The following is an example of the event text:  
  
```  
  
Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: <Time>  
Event ID: 2042  
Task Category: Replication   
Level: Error  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: <domain controller hostname>  
Description:  
It has been too long since this machine last replicated with the   
named source machine. The time between replications with this source   
has exceeded the tombstone lifetime. Replication has been stopped   
with this source.   
The reason that replication is not allowed to continue is that   
the two machine's views of deleted objects may now be different.   
The source machine may still have copies of objects that have   
been deleted (and garbage collected) on this machine. If they   
were allowed to replicate, the source machine might return   
objects which have already been deleted.   
Time of last successful replication:  
<date> <time>   
Invocation ID of source:   
<Invocation ID>   
Name of source:   
<GUID>._msdcs.<domain>   
Tombstone lifetime (days):  
<TSL number in days>  
  
The replication operation has failed.  
  
User Action:  
  
Determine which of the two machines was disconnected from the   
forest and is now out of date. You have three options:   
  
1. Demote or reinstall the machine(s) that were disconnected.   
2. Use the "repadmin /removelingeringobjects" tool to remove   
inconsistent deleted objects and then resume replication.   
3. Resume replication. Inconsistent deleted objects may be introduced.   
You can continue replication by using the following registry key.   
Once the systems replicate once, it is recommended that you remove   
the key to reinstate the protection.   
Registry Key:   
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters\Allow Replication With Divergent and Corrupt Partner  
```  
  
 The **repadmin \/showrepl** command also reports error 8416, as shown in the following example:  
  
```  
Source: Default-First-Site-Name\DC1  
******* <number> CONSECUTIVE FAILURES since <date> <time>  
Last error: 8614 (0x21a6):  
            The Active Directory Domain Services cannot replicate with this server   
because the time since the last replication with this server has   
exceeded the tombstone lifetime.  
```  
  
## Cause  
 There are a few potential causes for the logging of Event ID 2042, which include the following:  
  
-   Windows Server 2003 pre–Service Pack 1 \(SP1\) domain controllers having a software issue that causes replication failures  
  
-   Replication failures that have existed longer than the configured tombstone lifetime value  
  
-   System time advance or rollback that causes objects to be deleted on some—but not all—domain controllers  
  
## Resolution  
 The resolution of this issue depends on the actual cause or causes of the issue. To resolve this issue, check for each of the following conditions:  
  
1.  Determine whether there are any Windows Server 2003 domain controllers that do not have at least SP1 applied. If you find any such domain controllers, ensure that you update them to at least SP1 to resolve this issue.  
  
2.  Determine whether there are any replication failures that have been allowed to exceed the tombstone lifetime of the forest. Typically, the tombstone lifetime of the forest is 60 to 180 days by default. The event message indicates the tombstone lifetime of the forest as it is currently configured.  
  
     Run the command **repadmin \/showrepl** to determine whether a replication issue exists. If you suspect that there is a replication issue, see [Monitoring and Troubleshooting Active Directory Replication Using Repadmin](http://go.microsoft.com/fwlink/?linkid=140631) \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=140631\) for information about how to resolve the issue.  
  
3.  Determine whether there are lingering objects. You can do this by running the command **repadmin \/removelingeringobjects** in advisory mode, as described in the following procedure.  
  
 You must first identify an authoritative domain controller. If you know that a specific domain controller has the latest changes, you can use that domain controller as the authoritative domain controller. Otherwise, you may have to complete the following procedure on multiple domain controllers until you identify a domain controller that you believe has the latest changes. Then, you can use that domain controller as your authoritative domain controller.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[gen_win7_review_details](../Token/gen_win7_review_details_md.md)]  
  
#### Identify lingering objects  
  
1.  On a domain controller that you expect to have the latest changes, open an elevated Command Prompt window. [!INCLUDE[cmd_elev](../Token/cmd_elev_md.md)]  
  
2.  Run the **repadmin** command in advisory mode. This makes it possible for you to assess the lingering objects without actually removing anything. The syntax of the command is `repadmin /removelingeringobjects <DestDCName> <SourceDCGUID> <LDAPPartition> /advisory_mode`. Substitute the following items for the placeholders in the command syntax:  
  
    -   `DestDCName`—The host name of the domain controller that you are targeting for lingering object clean\-up. For example, if you want to remove lingering objects from DC1 in the contoso.com domain, substitute `dc1.contoso.com` for `<DestDCName>`.  
  
    -   `SourceDCGUID`—Run the command `repadmin /showrepl AuthDCname |more`, where `AuthDCname` is the host name of the domain controller that you selected as authoritative. Substitute the first `DSA object GUID` that appears for `<SourceDCGUID>`.  
  
    -   `LDAPPartition`—The Lightweight Directory Access Partition \(LDAP\) name of the partition that you are targeting. For example, if the lingering objects are in the domain partition of the contoso.com domain, substitute `dc=contoso,dc=com` for `<LDAPPartition>`.  
  
     The following is an example command for identifying lingering objects: `repadmin /removelingeringobjects dc1.contoso.com 4a8717eb-8e58-456c-995a-c92e4add7e8e dc=contoso,dc=com /advisory_mode`  
  
 If necessary, repeat the previous steps on additional domain controllers until you determine the domain controller that you believe has the latest changes. Use that domain controller as your authoritative domain controller. Run the `repadmin /removelingeringobjects` command without the `/advisory_mode` switch to actually remove lingering objects. Repeat the command as necessary to remove lingering objects from each domain controller that has them.  
  
### Restart replication following Event ID 2042  
 The normal state of replication is one in which changes to objects and their attributes converge in a way that domain controllers receive the latest information. When a partner domain controller is discovered to be passing older changes, the changes from the partner are deemed to be “divergent.” The partner is said to be engaged in “divergent replication.” Domain controllers will normally stop replicating with any partner that is deemed to be engaged in divergent replication.  
  
 After you remove all lingering objects, you can restart replication on the domain controller that logged the event by editing the registry.  
  
> [!CAUTION]  
>  Restart replication only after you have removed all lingering objects. [!INCLUDE[Registry](../Token/Registry_md.md)]  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[gen_win7_review_details](../Token/gen_win7_review_details_md.md)]  
  
##### Use Repadmin to restart replication following Event ID 2042  
  
1.  Open an elevated Command Prompt. [!INCLUDE[cmd_elev](../Token/cmd_elev_md.md)]  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `repadmin /regkey <hostname> +allowDivergent`  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |\/regkey|Enables \(**\+**\) and disables \(**\-**\) the value for the **Strict Replication Consistency** registry entry in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Parameters**.|  
    |\<hostname\>|Substitute the name of a single domain controller, or use **\*** to apply the change to all domain controllers in the forest. For the domain controller name, you can use the Domain Name System \(DNS\) name, the distinguished name of the domain controller computer object, or the distinguished name of the domain controller server object.|  
    |\+allowDivergent|Enables replication to start again with the replication partner that had lingering objects. You should run this command only after all the lingering objects have been removed. After replication is running properly again, use the **–allowDivergent** switch to prevent divergent replication from occurring.|  
  
    > [!NOTE]  
    >  If you did not use **\*** to apply the change to all domain controllers, repeat step 2 for every domain controller on which you want to allow divergent replication.  
  
### Reset the registry to protect against outdated replication  
 When you are satisfied that lingering objects have been removed and replication has occurred successfully from the source domain controller, use Repadmin to prevent divergent replication. To do prevent divergent replication, run the command `repadmin /regkey <hostname> -allowDivergent`. For example, to restrict divergent replication on a domain controller named DC1 in the Fabrikam.com domain, run the command `repadmin /regkey dc1.fabrikam.com –allowDivergent`.  
  
> [!NOTE]  
>  If you did not remove all the lingering objects, attempting replication might result in replication of a lingering object. If strict replication consistency is enabled on the destination domain controller, replication with the source domain controller will be blocked again.