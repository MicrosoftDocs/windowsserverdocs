---
title: Use Repadmin to Remove Lingering Objects
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b888936a-2965-4a3c-aa62-fe96f3617abc
author: Femila
---
# Use Repadmin to Remove Lingering Objects
  You can use the Repadmin tool to remove lingering objects when you reconnect a domain controller that has been offline for longer than a tombstone lifetime and you want to ensure that lingering objects do not exist or, if they do, that they are removed before they are replicated. You can also use this procedure when event ID 1388 or event ID 1988 is logged on a domain controller. In this case, the information that you need to perform the procedure is provided in the event. For information about removing lingering objects when event ID 1388 or event ID 1988 has been logged, see Fixing Replication Lingering Object Problems \(Event IDs 1388, 1988, 2042\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120797](http://go.microsoft.com/fwlink/?LinkID=120797)\).  
  
 If you are running the procedure without having received Event ID 1388 or Event ID 1988, you must gather the following information before you begin the procedure:  
  
-   The name of the server that has or might have lingering objects. This name can be the Domain Name System \(DNS\) name, NetBIOS name, or distinguished name of the domain controller.  
  
-   The globally unique identifier \(GUID\) of the NTDS Settings object of a domain controller that is authoritative for the domain of the domain controller from which you want to remove lingering objects. This domain controller is the source domain controller. The source domain controller and the domain controller from which you want to remove lingering objects must be running a version of either Windows Server 2003 or Windows Server 2008. If either domain controller is running Windows 2000 Server, follow the instructions in article 314282 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=37924](http://go.microsoft.com/fwlink/?LinkId=37924)\).  
  
 Use the following procedure to determine the GUID of a domain controller.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine the GUID of a domain controller  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At a command prompt, type the following command, and then press ENTER:  
  
     `repadmin /showrepl <DomainControllerName>`  
  
     Where `<DomainControllerName>` is the NetBIOS name of the domain controller whose GUID you want to determine.  
  
3.  In the top portion of the output, note the value in `DC object GUID`:  
  
 Use the following procedure to remove lingering objects by using Repadmin. There must be connectivity between the server that has or might have lingering objects and the server that has an up\-to\-date, writable replica of the directory partition.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To use Repadmin to remove lingering objects  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `repadmin /removelingeringobjects <ServerName ServerGUID DirectoryPartition> /advisory_mode`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |repadmin \/removelingeringobjects|Removes objects that have been deleted and permanently removed from replication partners but remain on this domain controller.|  
    |\<ServerName\>|The DNS name or the distinguished name of the domain controller that has or might have lingering objects.|  
    |\<ServerGUID\>|The GUID of a domain controller that has an up\-to\-date, writable replica of the directory partition|  
    |\<DirectoryPartition\>|The distinguished name of the domain directory partition that might have lingering objects. For example, DC\=*RegionalDomainName*,DC\=*ForestRootDomainName*,DC\=com. Also run the command against the configuration directory partition \(CN\=configuration,DC\=*ForestRootDomainName*,DC\=com\), the schema directory partition \(CN\=schema,CN\=configuration,DC\=*ForestRootDomainName*\), and any application directory partitions that are hosted on the domain controller that you are checking for lingering objects.|  
  
     **\/advisory\_mode** logs the lingering objects that will be removed so that you can review them, but it does not remove them.  
  
2.  If lingering objects are found, repeat step 1 without **\/advisory\_mode** to delete the identified lingering objects from the directory partition.  
  
3.  Repeat steps 1 and 2 for every domain controller that might have lingering objects.  
  
> [!NOTE]  
>  The *ServerName* parameter uses the **DC\_LIST** syntax for **repadmin**, which allows the use of **\*** for all domain controllers in the forest and **gc:** for all global catalog servers in the forest. To see the **DC\_LIST** syntax, at a command prompt, type **repadmin \/listhelp**, and then press ENTER.  
  
## See Also  
 [Article 2005074 in the Microsoft Knowledge Base](http://go.microsoft.com/fwlink/?LinkID=185205)  
  
  