---
title: Replication error 8524 The DSA operation is unable to proceed because of a DNS lookup failure
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adds
---

# Replication error 8524 The DSA operation is unable to proceed because of a DNS lookup failure

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic explains symptoms, causes and how to resolve Active Directory replication error 8524 The DSA operation is unable to proceed because of a DNS lookup failure.

1. [Symptoms](#symptoms)
2. [Causes](#causes)
3. [Resolutions](#resolutions)

## Symptoms

* DCDIAG reports that Active Directory Replications test has failed with status 8524:

   ```
   Testing server: <sitename><destination DC>
Starting test: Replications
[Replications Check,<destination DC>] A recent replication attempt failed:
From <source DC> to <destination dc>
Naming Context: 
CN=<DN path for failing directory partition>,DC=Contoso,DC=Com
The replication generated an error (8524):
The DSA operation is unable to proceed because of a DNS lookup failure.
   ```

* REPADMIN reports that a replication attempt has failed with status 8524. 
   REPADMIN commands that commonly cite the 8524 status include but are not limited to:
   * REPADMIN /REPLSUM
   * REPADMIN /SHOWREPS
   * REPADMIN /SHOWREPL
          
   Sample 8524 failures from REPADMIN /SHOWREPS is shown below:

   ```
   Default-First-Site-NameCONTOSO-DC1
   DSA Options: IS_GC 
   Site Options: (none)
   DSA object GUID: e15fc9a1-82f8-4a99-97f2-8e715f06e747
   DSA invocationID: e15fc9a1-82f8-4a99-97f2-8e715f06e747
   = INBOUND NEIGHBORS =
   DC=contoso,DC=com
   Default-First-Site-Name\CONTOSO-DC2 via RPC
   DSA object GUID: 8a7baee5-cd81-4c8c-9c0f-b10030574016
   Last attempt @ YYYY-MM-DD HH:MM:SS failed, result 8524 (0x214c):
   <codeFeaturedElement>The DSA operation is unable to proceed because of a DNS lookup failure.</codeFeaturedElement>
   1 consecutive failure(s).
   Last success @ YYYY-MM-DD HH:MM:SS. 
   <Remainder of /showrepl output truncated> 
   ```

* NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 8524 status are logged in the directory service event log.

Active Directory events that commonly cite the 8524 status include but are not limited to:

Event | Source | Event String
----- | ------ | -------
2023 | Microsoft-Windows-ActiveDirectory_DomainService | This directory server was unable to replicate changes to the following remote directory server for the following directory partition.
1655 | NTDS General | Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.
1308 | NTDS KCC | The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following directory service has consistently failed.
1865 | NTDS KCC | The Knowledge Consistency Checker (KCC) was unable to form a complete spanning tree network topology. As a result, the following list of sites cannot be reached from the local site.
1925 | NTDS KCC | The attempt to establish a replication link for the following writable directory partition failed.
1926 | NTDS KCC | The attempt to establish a replication link to a read-only directory partition with the following parameters failed.

* Domain controllers log NTDS Replication event 2087 and/or NTDS Replication event 2088 in their Directory Service event log.
   ```
      Log Name: Directory Service
      Source: Microsoft-Windows-ActiveDirectory_DomainService
      Date: <date> <time>
      Event ID: 2087
      Task Category: DS RPC Client
      Level: Error
      Keywords: Classic
      User: ANONYMOUS LOGON
      Computer: <dc name>.<domain name>
      Description: Active Directory Domain Services could not resolve the following DNS host name of the source domain controller to an IP address. This error prevents additions, deletions and changes in Active Directory Domain Services from replicating between one or more domain controllers in the forest. Security groups, group policy, users and computers and their passwords will be inconsistent between domain controllers until this error is resolved, potentially affecting logon authentication and access to network resources.
   
      Remainder of event truncated, see MSKB [824449](https://support.microsoft.com/?kbid=824449) for full text.
   ```

   ```
    Log Name: Directory Service
    Source: Microsoft-Windows-ActiveDirectory_DomainService
     Date: <date> <time>
    Event ID: 2088
    Task Category: DS RPC Client
    Level: Warning
    Keywords: Classic
    User: ANONYMOUS LOGON
    Computer: <dc name>.<domain name>
    Description:
    Active Directory Domain Services could not use DNS to resolve the IP address of the source domain controller listed below. To maintain the consistency of Security groups, group policy, users and computers and their passwords, Active Directory Domain Services successfully replicated using the NetBIOS or fully qualified computer name of the source domain controller.
         
    Invalid DNS configuration may be affecting other essential operations on member computers, domain controllers or application servers in this Active Directory Domain Services forest, including logon authentication or access to network resources.
         
    You should immediately resolve this DNS configuration error so that this domain controller can resolve the IP address of the source domain controller using DNS.
    
    <Remainder of event truncated, see MSKB [824449](https://support.microsoft.com/?kbid=824449) for full text.
    ```
## Causes

Error Status 8524 maps to error string "The DSA operation is unable to proceed because of a DNS lookup failure." - a catch-all error for all possible DNS failures affecting Active Directory on post Windows Server 2003 SP1 domain controllers.

Microsoft-Windows-ActiveDirectory_DomainService event 2087 is a partner event to other Active Directory events that cite the 8524 status if an Active Directory domain controller is unable to resolve a remote DC by its fully qualified CNAME record (<object guid for source DCs NTDS Settings object>._msdcs.<forest root domain>) using DNS.

Microsoft-Windows-ActiveDirectory_DomainService event 2088 is logged when a source domain controller is successfully resolved by its NetBIOS name but such name resolution fallback only occurs when DNS name resolution fails.

The presence of the 8524 status and the Microsoft-Windows-ActiveDirectory_DomainService event 2088 or 2087 events all indicate that DNS name resolution is failing Active Directory.

In summary, the 8524 replication status is logged when a destination DC is unable to resolve the source DC by its CNAME and Host "A" or Host "AAAA" records using DNS. Specific root causes include:

1. The source DC is offline, or no longer exists but its NTDS Settings object still exist in the destination DCs copy of Active Directory.
2. The source DC failed to register the CNAME or host records on one or more DNS Servers either because the registration attempts failed or DNS client settings on the source do not point to DNS Servers that either host, forwarded or delegate its _msdcs.<forest root domain zone and / or primary DNS suffix domain zones.
3. DNS client settings on the destination DC do not point to DNS Servers that either host, forward or delegate the DNS zones containing the CNAME or host records for the source DC.
4. CNAME and host records registered by the source DC do not exist on DNS servers queried by the destination DC due to simple replication latency, a replication failure or a zone transfer failure.
5. Invalid forwarders or delegations are preventing the destination DC from resolving CNAME or Host records for DCs in other domains in the forest. DNS Servers used by destination DC, source DC or intermediate DNS Servers are not functioning properly.

## Resolutions

### Verify whether the 8524 is caused by an offline DC or stale DC metadata

If the 8524 error / event refers to... | Then...
--- | ---
A DC that is currently offline but still a valid DC in the forest, | make it operational
An inactive DC (a DC install that no longer exists on the network but whose NTDS Settings object still exists in the destination DCs copy of Active Directory), | remove the stale metadata for that DC from the destination DCs copy of Active Directory

Microsoft CSS regularly finds stale metadata for nonexistent DCs, or from previous promotions of a DC with the same computer name that has not been removed from Active Directory.

### Remove stale DC metadata if present

GUI Metadata Cleanup using Active Directory Sites and Services (DSSITE.MSC):
1. Start the Windows 2008 or Windows Server 2008 R2 or W2K8 R2 Active Directory Sites and Services snap-in (DSSITE.MSC).<br><br>This can also be done by starting the Active Directory Sites and Services on a Windows Vista or Windows 7 computer that has been installed as part of the Remote Server Administration Tools (RSAT) package.
2. Focus the DSSITE.MSC snap-in on the *destination* DCs copy of Active Directory.<br><br>After starting DSSITE.MSC, right click on the *Active Directory Sites and Services*. Select the destination DC that is logging the 8524 error / event from the list of DCs visible in the *Change Domain Controller* list.
3. Delete the source DCs NTDS Settings object referenced in the 8524 errors and events. Active Directory Users and Computers (DSA.MSC) snap-in and delete either the source DCs NTDS Settings object.<br><br>A DCs NTDS Settings object appears below the Sites, Site Name, Servers container and %server name% container and above the inbound connection object displayed in in the right-hand pane of Active Directory Sites and Services. Right click on the stale NTDS Settings object you want to remove then click **Delete**.
   
Metadata cleanup can also be performed from the Windows Server 2008 or Windows Server 2008 R2 version of Active Directory Users and Computers snap-in as documented in [Clean Up Server Metadata](https://technet.microsoft.com/library/cc816907%28WS.10%29.aspx), or by using NTDSUTIL (documented in MSKB [216498](https://support.microsoft.com/default.aspx?scid=kb;EN-US;216498).

### Run DCDIAG /TEST:DNS on the source DC + destination DC. 

DCDIAG /TEST:DNS performs 7 different tests to quickly vet the DNS health of a domain controller. This test is NOT run as part of the default execution of DCDIAG. 
1. Log onto the console of the destination domain controllers logging the 8524 events with Enterprise Admin credentials.
2. Open an administrative privileged CMD prompt and run "DCDIAG /TEST:DNS /F on the DC logging the 8424 status AND the source DC that the destination DC is replicating from.
      * To run DCDIAG against all DCs in a forest, type "DCDIAG /TEST:DNS /V /E /F:<File name.txt>
      * To run DCDIAG TEST:DNS against a specific DC type "DCDIAG /TEST:DNS /V /S:<DC NAME> /F:<File name.txt>
3. Locate the summary table at the end of the DCDIAG /TEST:DNS output. Identify and reconcile warning or failure conditions on the relevant DCs of the report.
4. If DCDIAG does not identify the root cause, take "the long way around" using the steps below.

### Check Active Directory Name Resolution using PING

Destination DCs resolve source DCs in DNS by their fully qualified CNAME records which are derived from the object GUID of the remote DCs NTDS Settings object (the parent object to connection objects visible in the Active Directory Sites and Services snap-in). You can test a given DCs ability to resolve a source DC fully qualified CNAME record using the PING command.
   1. Locate the objectGUID of the source DCs NTDS Settings object in the source DCs copy of Active Directory.
      
      From the console of the source DC logging the 8524 error / event, type:
      ```
      c:\>repadmin /showreps <fully qualified hostname of <source> DC cited in the 8524 error / event >
      ```

      For example, if the DC referenced in the 8524 error/event is contoso-DC2 in the contoso.com domain type:
      ```
      c:\>repadmin /showreps contoso-dc2.contoso.com
      ```
      
      The "DSA Object GUID" field in the header of the /SHOWREPS command contains the objectGUID of the source DCs *current* NTDS settings object. Use the source DCs view of its NTDS Settings Object in case replication is slow or failing. The header of the repadmin output will look something like:
      
      ```
      Default-First-Site-Name\CONTOSO-DC1
      DSA Options: IS_GC 
      Site Options: (none)
      DSA object GUID: 8a7baee5-cd81-4c8c-9c0f-b10030574016
      ```
      
      Right-click and copy the GUID and paste it into the PING command in step d of this list.

   2. Locate the ObjectGUID of the source DC in the <destination> DCs copy of Active Directory.
      
      From the console of the destination DC logging the 8524 error / event, type:
      ```c:\>repadmin /showreps <fully qualified hostname of <destination> DC>>```
      
      For example, if the DC logging 8524 error / event is contoso-DC1 in the contoso.com domain type:
      ```c:\>repadmin /showreps contoso-dc1.contoso.com```

      REPADMIN /SHOWREPS output is shown below. The "DSA Object GUID" field is listed for each source DC the destination DC inbound replicates from.
       ```
      c:\>repadmin /showreps contoso-dc1.contoso.com
      Default-First-Site-Name\CONTOSO-DC1
      DSA Options: IS_GC 
      Site Options: (none)
      DSA object GUID: e15fc9a1-82f8-4a99-97f2-8e715f06e747
      DSA invocationID: e15fc9a1-82f8-4a99-97f2-8e715f06e747 
      ==== INBOUND NEIGHBORS ======================================
      DC=contoso,DC=com
      Default-First-Site-Name\CONTOSO-DC2 via RPC
      DSA object GUID: 8a7baee5-cd81-4c8c-9c0f-b10030574016 <- Object GUID for source DC derived from
      Last attempt @ 2010-03-24 15:45:15 failed, result 8524 (0x214c): \ destination DCs copy of Active Directory
      The DSA operation is unable to proceed because of a DNS lookup failure.
      23 consecutive failure(s).
      Last success @ YYYY-MM-DD HH:MM:SS.
      ```

   3. Compare the object GUID from step a and step b.
      
      If the object GUIDS are the same, then the source DC and destination DC know about the same instantiation (the same promotion) of the source DC. If they are different then figure who which one was created later. The NTDS setting object with the earlier create date is likely stale and should be removed.
   4. PING the source DC by its fully qualified CNAME.
      
      From the console of the destination DC, test Active Directory's name resolution with a PING of the source DCs fully qualified CNAME record:
      ```c:\>ping <ObjectGUID from source DCs NTDS Settings object._msdcs.<DNS name for Active Directory forest root domain>```
      
      Using our example of the 8a7baee5-cd81-4c8c-9c0f-b10030574016 objectGUID from the repadmin /showreps output above from the contoso-dc1 DC in the contoso.com domain, the PING syntax would be:
      ```c:\>ping 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com```
      
      If PING works, retry the failing operation in Active Directory. If PING fails, proceed to the "Resolve the 8524 DNS lookup failure" but retrying the PING test after each step until it resolves.

### Resolve the 8524 DNS lookup failure: "The long way around"

If the 8524 error / events are not caused by stale DC metadata and the CNAME PING test fails, vet the DNS health of the source DC, the destination DC and the DNS Servers used by the source and destination DCs. In summary, verify that:
   * The source DC has registered the CNAME and host records with a valid DNS.
   * The destination DC points to valid DNS Servers.
   * That the records of interest registered by source DCs are resolvable by destination DCs.

The error message text in DS RPC Client event 2087 documents a user action for resolving the 8524 error. A more detailed action plan follows.

### Verify that the source DC points to valid DNS Servers

On the source DC, verify that DNS Client settings point *exclusively*  to operational DNS Severs that either host, forward or delegate the:
* msdcs.<forest root domain> zone (i.e. All DCs in the contoso.com forest register CNAME records in the _msdcs.contoso.com zone), AND
* DNS zone for the Active Directory domain (i.e. a computer in the contoso.com domain would register host records in in contoso.com zone), AND
* Computers primary DNS suffix domain if different from the Active Directory domain name (see [Disjoint Namespace](https://technet.microsoft.com/library/cc731125.aspx)).

Options to validate that a DNS Server hosts, forwards or delegates (i.e. "can resolve") such zones include:
      - Start the DNS management tool for your DNS and verify that the DNS Servers that the source DC points to for name resolution host the zones in question.
      - Use NSLOOKUP to verify that all of the DNS Servers that the source DC points to can resolve queries for the DNS zones in question.
         Run IPCONFIG /ALL on the console of the source DC: 
         ```                  
         c:\>ipconfig /all
         DNS Servers . . . . . . . . . . . : 192.0.2.99 <- Primary DNS Server IP>
                                             192.0.2.101<- Secondary DNS Server IP> 
         ```
         Run the following NSLOOKUP queries:
         ```
         c:\>nslookup -type=soa <Source DC DNS domain name> <source DCs primary DNS Server IP >
         c:\>nslookup -type=soa < Source DC DNS domain name > <source DCs secondary DNS Server IP >
         c:\>nslookup -type=soa <_msdcs.<forest root DNS domain> <source DCs primary DNS Server IP >
         c:\>nslookup -type=soa <_msdcs.<forest root DNS domain> <source DCs secondary DNS Server IP >
         ```
        For example, if a DC in the CHILD.CONTOSO.COM domain of the contoso.com forest is configured with the primary and secondary DNS Server IPs "192.0.2.99" and "192.0.2.101", the NSLOOKUP syntax would be:
        ```
         c:\>nslookup -type=soa child.contoso.com 192.0.2.99
         c:\>nslookup -type=soa child.contoso.com 192.0.2.101
         c:\>nslookup -type=soa _msdcs.contoso.com 192.0.2.99
         c:\>nslookup -type=soa _msdcs.contoso.com 192.0.2.101
        ```
        
   >[!NOTE]
   > The SOA query for the _mscs.contoso.com zone will resolve correctly if the targeted DNS has a good forwarder or delegation for the _msdcs.<forest root zone>. This query will not resolve correctly if the _msdcs.<forest root zone> on the DNS Server being queried is a non-delegated sub-domain of <forest root zone> which is the zone relationship created by Windows 2000 domains.

   > CNAME records are always registered in the _msdcs.<forest root zone>, even for DCs in non-root domains.

   > Configuring the DNS client of a DC or member computer to point to an ISP DNS Server for name resolution is invalid unless that ISP has been contracted (paid) and is currently hosting, forwarding or delegating DNS queries for your Active Directory forest.

   > ISP DNS Servers typically do not accept dynamic DNS updates so CNAME, Host and SRV records may have to be manually registered.

### Verify that the source DC has registered its CNAME record.
Use step 1 from "Check Active Directory Name Resolution using PING" to locate the current CNAME of the source DC.

Run **ipconfig /all** on the console of the source DC to determine which DNS Servers the source DC points to name resolution.

```
c:\>ipconfig /all
DNS Servers . . . . . . . . . . . : 192.0.2.99 <- Primary DNS Server IP>
                                    192.0.2.101<- Secondary DNS Server IP> 
```

Use NSLOOKUP to query the current DNS Servers for the source DCs CNAME record (found by using the procedure in "Check Active Directory Name Resolution using PING").

```
c:\>nslookup -type=cname <fully qualified cname of source DC> <source DCs primary DNS Server IP >
c:\>nslookup -type=cname <fully qualified cname of source DC> <source DCs secondary DNS Server IP> 
```

Continuing the example where the NTDS Settings objectGUID for contoso-dc2 in the contoso.com domain is 8a7baee5-cd81-4c8c-9c0f-b10030574016 and points to "192.0.2.99" as primary for DNS name resolution, the NSLOOKUP syntax would be:

```
c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 192.0.2.99
c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 192.0.2.101
```

If the source DC has not registered its CNAME record on the DNS Servers it points to for name resolution, run the following command from the command prompt of the source DC then recheck the registration of the CNAME record:

```
c:\>net stop netlogon & net start netlogon
```

> [!NOTE]
> CNAME records are always registered in the _msdcs.<forest root zone>, even for DC in non-root domains.

> CNAME records are registered by the Net Logon service during operating system startup, Net Logon service startup and recurring intervals thereafter.

> Each promotion of a DC with the same name may create a new NTDS Settings object with a different objectGUID which therefore registers a different CNAME record. Verify registration of the CNAME record based the last promotion of the source DC versus the objectGUID for the NTDS Settings object on the destination DC if the source has been promoted more than once.

> Timing issues during OS startup can delay successful Dynamic DNS registration.

> If a DCs CNAME record was successfully registered but later disappears, check for the [zone transfer delete bug](https://support.microsoft.com/default.aspx?scid=kb;EN-US;953317), duplicate DNS zones in different replication scopes or overly aggressive scavenging by the DNS Server.

> If the CNAME record registration is failing on the DNS servers that the source DC points to for name resolution, review NETLOGN events in the SYSTEM event log for DNS registration failures.

### Verify that the source DC has registered its host records
From the console of the source DC, run **ipconfig /all** to determine which DNS Servers the source DC points to name resolution:

```
c:\>ipconfig /all

DNS Servers . . . . . . . . . . . : 192.0.2.99 <- Primary DNS Server IP>
                                    192.0.2.101<- Secondary DNS Server IP> 
```

Use NSLOOKUP to query the current DNS Servers for the host record:

```
c:\>nslookup -type=A+AAAA <fully qualified hostname of source DC> <source DCs primary DNS Server IP >
c:\>nslookup -type=A+AAAA <fully qualified hostname of source DC> <source DCs secondary DNS Server IP>
```

Continuing the example for the hostname for contoso-dc2 in the contoso.com domain is 8a7baee5-cd81-4c8c-9c0f-b10030574016 and points to self (127.0.0.1) as primary for DNS name resolution, the NSLOOKUP syntax would be:

```
c:\>nslookup -type=A+AAAA contoso-dc1.contoso.com 192.0.2.99
c:\>nslookup -type=A+AAAA contoso-dc1.contoso.com 192.0.2.101
```

Repeat the NSLOOKUP command against the source DCs secondary DNS Server IP address.

To dynamically register host "A" records, type the following from the console of the computer: ```c:\>ipconfig /registerdns```

> [!NOTE]
> Windows 2000 through Windows Server 2008 R2 computers all register IPv4 host "A" records.

> Windows Server 2008 and Windows Server 2008 R2 computers all register IPv6 host "AAAA" records.

> Host "A" and "AAAA" records are registered in the computers primary DNS suffix zone.

> Disable network adapters that do not have network cables attached.

> Disable host record registration on network adapters that are not accessible DCs and member computers on the network.

> It is not supported to disable the IPv6 protocol by clearing the IPv6 checkbox in Networks in Control Panel.

### Verify that the destination DC points to valid DNS Servers

On the destination DC, verify that DNS Client settings point *exclusively* to operational DNS Severs that either host, forward or delegate the:

* _msdcs.<forest root domain> zone (i.e. All DCs in the contoso.com forest register CNAME records in the _msdcs.contoso.com zone), AND
* DNS zone for the Active Directory domain (i.e. a computer in the contoso.com domain would register host records in in contoso.com zone), AND
* Computers primary DNS suffix domain if different from the Active Directory domain name (see [Disjoint Namespace](https://technet.microsoft.com/library/cc731125.aspx)

Options to validate that a DNS Server hosts, forwards or delegates (i.e. "can resolve") such zones include:

* Start the DNS management tool for your DNS and verify that the DNS Servers that the source DC points to for name resolution host the zones in question.
* Use NSLOOKUP to verify that all of the DNS Servers that the source DC points to can resolve queries for the DNS zones in question.
   Run IPCONFIG /ALL on the console of the source DC:
   ```
   c:\>ipconfig /all

   DNS Servers . . . . . . . . . . . : 192.0.2.99 <- Primary DNS Server IP>
                                       192.0.2.101<- Secondary DNS Server IP> 
   ```

   Run the following NSLOOKUP queries:
   ```
   c:\>nslookup -type=soa <Source DC DNS domain name> <source DCs primary DNS Server IP >
   c:\>nslookup -type=soa < Source DC DNS domain name > <source DCs secondary DNS Server IP >
   c:\>nslookup -type=soa <_msdcs.<forest root DNS domain> <source DCs primary DNS Server IP >
   c:\>nslookup -type=soa <_msdcs.<forest root DNS domain> <source DCs secondary DNS Server IP >
   ```
   
   For example, if a DC in the CHILD.CONTOSO.COM domain of the contoso.com forest is configured with the primary and secondary DNS Server IPs "192.0.2.99" and "192.0.2.101", the NSLOOKUP syntax would be:

   ```
   c:\>nslookup -type=soa child.contoso.com 192.0.2.99
   c:\>nslookup -type=soa child.contoso.com 192.0.2.101
   c:\>nslookup -type=soa _msdcs.contoso.com 192.0.2.99
   c:\>nslookup -type=soa _msdcs.contoso.com 192.0.2.101
   ```

> [!NOTE]
> The SOA query for the _mscs.contoso.com zone will resolve correctly if the targeted DNS has a good forwarder or delegation or for the _msdcs.<forest root zone>. This query will not resolve correctly if the _msdcs.<forest root zone> on the DNS Server being queried is a non-delegated sub-domain of <forest root zone> which is the zone relationship created by Windows 2000 domains.

> CNAME records are always registered in the _msdcs.<forest root zone>, even for DCs in non-root domains.

> Configuring the DNS client of a DC or member computer to point to an ISP DNS Server for name resolution is invalid unless that ISP has been contracted (paid) and is currently hosting, forwarding or delegating DNS queries for your Active Directory forest.

> ISP DNS Servers typically do not accept dynamic DNS updates so CNAME, Host and SRV records may have to be manually registered.

> The DNS resolver on the Windows computers is by-design "sticky" about using DNS servers that are responsive to queries, regardless of whether such DNS Servers host, forward or delegate the required zones. Restated, the DNS resolver will not fail over and query another DNS server as long as the active DNS server is responsive, even if the response from the DNS Server indicates that it does not host the record being queried or even host a copy of the zone for that record.

> Configuring the DNS client of a DC or member computer to point to an ISP DNS Server for name resolution is invalid unless that ISP has been contracted (paid) to host, forward or delegate DNS queries for your Active Directory forest.

### Verify that the DNS Server used by the destination DC can resolve the source DCs CNAME and HOST records
From the console of the destination DC, run "ipconfig /all" to determine which DNS Servers that destination DC points to for name resolution:

```
c:\>ipconfig /all

DNS Servers . . . . . . . . . . . : 192.0.2.102 <- Primary DNS Server IP>
                                    192.0.2.103<- Secondary DNS Server IP> 
```

From the console of the destination DC, use NSLOOKUP to query the DNS Servers configured on the destination DC for the source DCs cname and host records:

```
c:\>nslookup -type=cname <fully qualified CNAME of source DC> <destination DCs primary DNS Server IP >
c:\>nslookup -type=cname <fully qualified CNAME of source DC> <destination DCs secondary DNS Server IP>
c:\>nslookup -type=host <fully qualified hostname of source DC> <destination DCs primary DNS Server IP >
c:\>nslookup -type=host <fully qualified hostname of source DC> <destination DCs secondary DNS Server IP>
```

Continuing the example where contoso-dc2 in the contoso.com domain with GUID 8a7baee5-cd81-4c8c-9c0f-b10030574016 in the Contoso.com forest root domain points to DNS Servers "192.0.2.102" and "192.0.2.103", the NSLOOKUP syntax would be:

```
c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 192.0.2.102
c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 192.0.2.103
c:\>nslookup -type=A+AAAA contoso-dc1.contoso.com 192.0.2.102
c:\>nslookup -type=A+AAAA contoso-dc1.contoso.com 192.0.2.102
```

### Review the relationship between the DNS Servers used by the source and destination DCs
If the DNS Servers used by the source and destination host AD-integrated copies of the _msdcs.<forest root> and <primary DNS suffix> zones, check for:

* Replication latency between the DNS where the record was registered and the DNS where the record is being queried.
* A replication failure between the DNS where the record is registered and the DNS being queried. 
* The DNS zone hosting the record of interest resides in different replication scopes and therefore different contents, or is CNF / conflict-mangled on one or more DCs

If the DNS zones used by the source and destination DC are stored in primary and secondary copies of DNS zones, check for:
* The "allow zone transfers" checkbox is not enabled on the DNS that hosts the primary copy of the zone
* The "Only the following servers" checkbox is enabled but the IP address of the secondary DNS has not been added to the allow list on the primary DNS 
* The DNS zone on the Windows Server 2008 DNS hosting the secondary copy of the zone is empty due to MSKB [953317](https://support.microsoft.com/default.aspx?scid=kb;EN-US;953317).

If the DNS servers used by the source and destination DC have parent / child relationships, check for:
* Invalid delegations on the DNS that owns the parent zone that is delegating to the subordinate zone
* Invalid forwarder IP addresses on the DNS server trying to resolve the superior DNS zone (example: a DC in child.contoso.com trying to resolve host records in conto.com zone residing on DNS Servers in the root domain).