---
title: Replication error 1396 Logon Failure The target account name is incorrect
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
ms.assetid: d3a01966-74c9-4c49-ba11-354b9acf7519
---
# Replication error 1396 Logon Failure The target account name is incorrect
This article describes the symptoms, cause and how to resolve Active Directory replication failing with Win32 error 1396: "Logon failure: The target account name is incorrect."  
  
-   [Symptoms](../../identity/ad-ds/Replication-error-1396-Logon-Failure-The-target-account-name-is-incorrect.md#BKMK_Symptoms)  
  
-   [Causes](../../identity/ad-ds/Replication-error-1396-Logon-Failure-The-target-account-name-is-incorrect.md#BKMK_Causes)  
  
-   [Resolutions](../../identity/ad-ds/Replication-error-1396-Logon-Failure-The-target-account-name-is-incorrect.md#BKMK_Resolutions)  
  
##  <a name="BKMK_Symptoms"></a> Symptoms  
  
1.  DCDIAG reports that the Active Directory Replications test has failed with error 1396: Logon failure: The target account name is incorrect."  
  
    ```  
    Testing server: <Site name>\<DC Name>  
    Starting test: Replications  
    [Replications Check,<DC Name>] A recent replication attempt failed:  
    From <source DC> to <destination DC>  
    Naming Context: CN=<DN path of naming context>  
    The replication generated an error (1396):  
    Logon Failure: The target account name is incorrect.  
    The failure occurred at <date> <time>.  
    The last success occurred at <date> <time>.  
    XX failures have occurred since the last success  
    ```  
  
2.  REPADMIN.EXE reports that the last replication attempt has failed with status 1396.  
  
     REPADMIN commands that commonly cite the 1396 status include but are not limited to:  
  
    |||  
    |-|-|  
    |-   REPADMIN \/ADD<br />-   REPADMIN \/REPLSUM<br />-   REPADMIN \/REHOST<br />-   REPADMIN \/SHOWVECTOR \/LATENCY|-   REPADMIN \/SHOWREPS<br />-   REPADMIN \/SHOWREPL<br />-   REPADMIN \/SYNCALL|  
  
     Sample output from "REPADMIN \/SHOWREPS" depicting inbound replication from CONTOSO\-DC2 to CONTOSO\-DC1 failing with the "Logon Failure: The target account name is incorrect." error is shown below::  
  
    ```  
    Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC   
    Site Options: (none)  
    DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01  
    DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01  
    ==== INBOUND NEIGHBORS ==========  
    DC=contoso,DC=com  
    Default-First-Site-Name\CONTOSO-DC2 via RPC  
    DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2  
    Last attempt @ <date> <time> failed, result 1396 (0x574):  
    Logon Failure: The target account name is incorrect.  
    <#> consecutive failure(s).  
    Last success @ <date> <time>.  
  
    ```  
  
3.  The **Replicate now** command in Active Directory Sites and Services returns "Logon Failure: The target account name is incorrect."  
  
     Right\-clicking on the connection object from a source DC and choosing **Replicate now** fails with "Logon Failure: The target account name is incorrect.” The on\-screen error message is shown below:  
  
     Dialog title text:  
  
     Replicate Now  
  
     Dialog message text:  
  
     The following error occurred during the attempt to synchronize naming context \<partition DNS path\> from domain controller \<source DC\> to domain controller \<destination DC\>: Logon Failure: The target account name is incorrect. This operation will not continue.  
  
4.  NTDS KCC, NTDS General or Microsoft\-Windows\-ActiveDirectory\_DomainService events with the 1396 status are logged in the Directory Services log in Event Viewer.  
  
     Active Directory events that commonly cite the 1396 status include but are not limited to:  
  
    |Event ID|Event Source|Event String|  
    |--------------|------------------|------------------|  
    |1125|Microsoft\-Windows\-ActiveDirectory\_DomainService|The Active Directory Domain Services Installation Wizard \(Dcpromo\) was unable to establish connection with the following domain controller.|  
    |1645<br /><br /> This event lists the three\-part SPN.|NTDS Replication|Active Directory did not perform an authenticated remote procedure call \(RPC\) to another domain controller because the desired service principal name \(SPN\) for the destination domain controller is not registered on the Key Distribution Center \(KDC\) domain controller that resolves the SPN.|  
    |1655|Microsoft\-Windows\-ActiveDirectory\_DomainService|Active Directory Domain Services attempted to communicate with the following global catalog and the attempts were unsuccessful.|  
    |2847|Microsoft\-Windows\-ActiveDirectory\_DomainService|The Knowledge Consistency Checker located a replication connection for the local read\-only directory service and attempted to update it remotely on the following directory service instance. The operation failed. It will be retried.|  
    |1925|NTDS KCC|The attempt to establish a replication link for the following writable directory partition failed.|  
    |1926|NTDS KCC|The attempt to establish a replication link to a read\-only directory partition with the following parameters failed.|  
    |5781|NETLOGON|The server cannot register its name in DNS.|  
  
5.  DCPROMO fails with an onscreen error  
  
     Dialog Title Text:  
  
     Active Directory Installation Failed  
  
     Dialog Message text:  
  
     The operation failed because: The Directory Service failed to create the server object for CN\=NTDS Settings,CN\=ServerBeingPromoted,CN\=Servers,CN\=Site,CN\=Sites,CN\=Configuration,DC\=contoso,DC\=com on server ReplicationSourceDC.contoso.com.  
  
     Please ensure  
    the network credentials provided have sufficient access to add a replica.  
  
     "Logon Failure: The target account name is incorrect. "  
  
     In this case, Event ID 1645, 1168, and 1125 are logged on the server that is being promoted.  
  
6.  Map a drive using **net use**:  
  
    ```  
    C:\>net use z: \\<server_name>\c$  
    System error 1396 has occurred.  
    Logon Failure: The target account name is incorrect.  
    ```  
  
     In this case, the server can also logging Event ID 333 in the system event log and use a high amount of virtual memory for an application such as SQL Server.  
  
7.  The DC time is incorrect.  
  
8.  The KDC will not start on an RODC after a restore of the krbtgt account for the RODC, which had been deleted. For example, after a restore, error 1396 appears.  
  
     Event ID 1645 is logged on the RODC.  
  
     Dcdiag also reports an error that it cannot update the RODC krbtgt account.  
  
##  <a name="BKMK_Causes"></a> Causes  
  
1.  The SPN does not exist on the global catalog searched by the KDC on behalf of the client attempting to authenticate using Kerberos.  
  
     In the context of Active Directory replication, the Kerberos client is the destination DC, the KDC performing the SPN lookup is likely the destination DC itself but could be a remote DC.  
  
2.  The user or service account that should contain the service principal name being looked up does not exist on the global catalog searched by the KDC on behalf of destination DC attempting to replicate.  
  
     In the context of Active Directory replication, the source DC computer account does not exist on the global catalog searched by the DC on behalf of the destination DC performing inbound replication.  
  
3.  The destination DC lacks an LSA secret for the source DCs domain.  
  
4.  The SPN being looked up exists on a different computer account than the source DC.  
  
##  <a name="BKMK_Resolutions"></a> Resolutions  
  
1.  Check the Directory Service event log on the destination DC for NTDS Replication event 1645 and note the following:  
  
     The name of the destination DC  
  
     The SPN being looked up \(E3514235\-4B06\-11D1\-AB04\-00C04FC2DCD2\/\<object guid for source DCs NTDS Settings object\>\/\<target domain\>.\<tld\>@\<target domain\>.\<tld\>  
  
     The KDC being used by the destination DC  
  
2.  From the console of the KDC identified in step 1, type:  
  
    ```  
    nltest /dsgetdc <forest root DNS domain name > /gc  
    ```  
  
     Run the NLTEST locator test immediately following a replication attempt that fails with the 1396 error on the destination DC.  
  
     This should identify that GC that the KDC is performing SPN lookups against.  
  
     The GC being searched by the KDC may also be captured in Microsoft\-Windows\-ActiveDirectory\_DomainService event 1655.  
  
3.  Search for the SPN discovered in step 1 on the global catalog discovered in step 2.  
  
    ```  
    C:\>repadmin /showattr Server_Name DC=corp,DC=contoso,dc=com <GC used by KDC> <DN path of forest root domain> /filter:"(serviceprincipalname=<SPN cited in the NTDS Replication event 1645>)" /gc /subtree /atts:cn,serviceprincipalname  
    ```  
  
     OR  
  
    ```  
    C:\>dsquery * forestroot -scope subtree -filter "(serviceprincipalname=E3514235-4B06-11D1-AB04-00C04FC2DCD2/65cead9f-4949-46a3-a49a-f1fbfe13d2b3*)" -attr * -s Server_Name.europe.corp.contoso.com  
    ```  
  
     Verify that the host object for the SPN exists.  
  
     Verify the DN path for the host object including whether the object is CNF \/ conflict mangled or resides in the lost and found container.  
  
     Verify that the source DCs Active Directory Replication SPN is registered only on the source DCs computer account.  
  
     If the replication SPN is missing, determine if the source DC has registered its SPN with itself, and whether the SPN is missing on the GC used by the KDC due to simple replication latency or a replication failure.  
  
4.  Check the secure channel health and trust health.  
  
## See Also  
 [Troubleshooting Active Directory operations that fail with error 1396: Logon Failure: The target account name is incorrect.](http://support.microsoft.com/kb/2183411/en-gb)