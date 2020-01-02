
# Troubleshooting the error 8304 during Active Directory replication

This article discusses the causes and solutions for the Active Directory replication error 8304 (0x2070): "The maximum size on an object has been exceeded".

## Symptom 1

The **dcdiag** command reports that the Active Directory replication test failed and generated error 8304: "The maximum size of an object has been exceeded."

```
Starting test: Replications
    [Replications Check, <DESTINATION DC>] A recent replication attempt failed:
        From <SOURCE DC>to <DESTINATION DC>
        Naming Context: <directory partition DN path>
        The replication generated an error (8304):
        The maximum size of an object has been exceeded.
        The failure occurred at <date><time>.
        The last success occurred at <date><time>.
    ......................... <DESTINATION DC> failed test Replications
```

## Symptom 2

When you right-click a connection object from a source domain controller (DC), and then you select **Replicate now**, the replication is unsuccessful and generates the following error message:

```
Replicate Now
The following error occurred during the attempt to synchronize naming context <active directory partition name> from domain controller <source DC> to domain controller <destination DC>:

The maximum size of an object has been exceeded

The operation will not continue
```

## Symptom 3

Various repadmin.exe commands fail and generate error 8304. These commands include, but are not limited to, the following:

- repadmin /add
- repadmin /replsum
- repadmin /showrepl
- repadmin /showrepl
- repadmin /syncall

## Symptom 4

Event ID 1084 is logged in the Directory Service event log of DCs that are trying to replicate Active Directory objects inbound.

```
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      1084
Task Category: Replication
Level:         Error
User:          ANONYMOUS LOGON
Computer:      <Destination DC>
Description:
Internal event: Active Directory Domain Services could not update the following object with changes received from the following source directory service. This is because an error occurred during the application of the changes to Active Directory Domain Services on the directory service. 

Object:
CN=john\0ADEL:2549ea14-27f7-4891-abaf-d0098c117e79,CN=Deleted Objects,<directory partition DN path>
Object GUID:
2549ea14-27f7-4891-abaf-d0098c117e79
Source directory service:
92a193be-3419-41f7-9cc5-c072acc81098._msdcs.contoso.com

Synchronization of the directory service with the source directory service is blocked until this update problem is corrected. 

This operation will be tried again at the next scheduled replication.

User Action
Restart the local computer if this condition appears to be related to low system resources (for example, low physical or virtual memory). 

Additional Data
Error value:
8304 The maximum size of an object has been exceeded.
```

You may also see an event 1093:

```
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      1093
Task Category: Replication
Level:         Warning
Computer:      <Destination DC>
Description:
Active Directory Domain Services could not update the following object with attribute changes because the incoming change caused the object to exceed the maximum object record size. The incoming change to the following attribute will be reversed in an attempt to complete the update. 

Object: 
CN=<MachineName>\0ADEL:afed8cd5-06be-42c1-80bc-ca2b2bbd5498,CN=Deleted  
Objects,DC=xxxx,DC=domainname,DC=com  

Object GUID: 
afed8cd5-06be-42c1-80bc-ca2b2bbd5498 

Attribute: 
9030d (lastKnownParent) 
The current value (without changes) of the attribute on the local directory partition will replicate to all other directory services. This will counteract the change to the rest of the directory services. The reversal values may be recognized as follows: 

Version:
2 

Time of change: 
2010-12-15 09:20:11 

Update sequence number: 
65064475
Note this event may not quote the attribute that has the most data or values. It quotes the update for the attribute that made the object size overflow.
```

## Cause

Error 8304 is logged when the domain controller tries to replicate an object that exceeds the maximum size. This most commonly occurs when an object that has a very large attribute is deleted and the Active Directory recycle bin is enabled.

The typical cause is having a non-linked attribute with a big number of values. The internal structure of the Active Directory database together with the Active Directory database record size of 8KB sets this limit at about 1200-1300 values, depending on the population of other non-linked attributes.

In the output of the object on the source server in tools like LDP or with "repadmin /showattr /allvalues /extended", the attribute values are listed similar to:

```
1> distinguishedName:<GUID=99b2040278b2254081979b3228f7408b>;CN=Allowedclients\0ADEL:0204b299-b278-4025-8197-9b3228f7408b,CN=Deleted Objects,CN=Configuration,DC=contoso,DC=com
1> instanceType: 0x4 = ( WRITE )
1> whenCreated: 25.4.2018. 13:48:07Central European Daylight Time
…
1> msDS-LastKnownRDN: Allowed clients
1>msExchSmtpReceiveMaxRecipientsPerMessage: 200
1243> msExchSmtpReceiveRemoteIPRanges:10.142.241.142;…
```

Attributes you may encounter this for are, but not limited to:
- proxyAddresses
- userCertificate
- msExchSmtpReceiveRemoteIPRanges
- dnsRecord
- msiFileList
- msTSProperty01, msTSProperty02, …
- registeredAddress

This may happen for any multi-valued non-linked attribute. Attribute with syntax linked or linked with data are not affected by this problem.

Depending on the available resources and actual local database page population, the limit may be hit at different number of values. This is why a certain change can be taken by some Domain Controller or LDS instances, but not on others.

This limit is independent of the Microsoft LDAP Server OS version. There is no way around this limitation. You need to potentially revise your application and how it uses this attribute.

#### Resolution

The 1084 event will list the object that has exceeded the maximum size. If the object is an alive object, identify the attribute that has too many values and remove some of the values on the source Domain Controller.

If the object is a deleted object, and the Active Directory recycle bin is enabled, the best method to correct the issue is to force the object to become a recycled object. When the object is recycled, Active Directory removes most attributes. This typically reduces the size of the object enough so that it can be replicated successfully. This process will truly delete the object and make it unrecoverable from the recycle bin. If the object is a security principal such as a user account, we recommend that you do not undelete the object. If a sufficiently large object is undeleted, it may prevent some attributes from being correctly set. This can cause the object to be damaged and may prevent the object from being used or even deleted.

The following PowerShell command can be used to force the object into the recycled state.

> [!NOTE]
> The following command must be run on the DC listed in the 1084 event as the source domain controller. The event will also list the object distinguished name.

```PowerShell
Get-ADObject <dn of object> -IncludeDeletedObjects | Remove-ADObject
```

For example:

```PowerShell
Get-ADObject "CN=john\0ADEL:2549ea14-27f7-4891-abaf-d0098c117e79,CN=Deleted Objects,dc=contoso,dc=com" | Remove-ADObject
```

After the object is recycled, use Active Directory Sites and Services to try to force replication.

## Suggestions to avoid the limit from past Microsoft issues:

### dnsRecord

Each IP address or SRV name target is an additional value of the dnsRecord attribute. By default each Domain Controller in Active Directory registers a series of names with DNS, some based on the sites the DC covers, some site-less. When you approach 1200 Domain Controllers in a domain, there may be issues updating the DNS object for the name with the additional values. In such a domain, it is also often not desired to have this many entries for site-less names.
To avoid this limit, a registry value “DnsAvoidRegisterRecords” was created where an Administrator would set this on the DCs that should not be present in site-less names. In our deployment history, this was most often applied to branch site DCs in an enterprise with many sites.

### DHCP Server activation

In order to avoid rogue DHCP servers, Windows DHCP servers that are member of a domain need to find their IP address on an AD object. Only then it would move ahead and offer IP addresses from its scopes to clients.
Similar to the dnsRecord issue, this IP address was stored as a value on an AD object, this time forest-wide in the configuration NC. And again, as a company deployed more DHCP servers in the forest, they would hit this limit, and no more DHCP servers could be authorized.
The solution of the DHCP team was to have a separate AD object per DHCP Server, with one IP address per object.
