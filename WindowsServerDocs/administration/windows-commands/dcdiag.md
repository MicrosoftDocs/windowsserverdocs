---
title: dcdiag
description: DCDiag is used to diagnose Active Directory domain controller health and as a troubleshooting tool by performing several network connectivity tests.
ms.topic: reference
ms.date: 10/08/2023
ms.author: alalve
author: orthomas
ms.custom: template-how-to, team=cloud_advocates #Required; leave this attribute/value as-is.
ms.contributor: nedpyle
---

# DCDiag

> Applies To: Windows Server 2022, Windows Server 2019, Windows Server 2016

`DCDiag.exe` analyzes the state of domain controllers (DC) in a forest or enterprise and reports any problems to help in troubleshooting. As an end-user reporting program, DCDiag is a command-line tool that encapsulates detailed knowledge of how to identify abnormal behavior in the system.

By default, DCDiag is readily available if logged into a DC. An alternative method to access DCDiag is to install the Remote Server Administration Tools (RSAT) on your device. DCDiag must be ran with administrative rights from an elevated command prompt (CMD) or PowerShell.

DCDiag consists of a framework for executing tests and a series of tests to verify different functional areas of the system. This framework selects which DC is tested according to scope directives from the user, such as enterprise, site, or single server. Testing the overall connectivity and responsiveness of the DC includes verifying:

- The DC can be located in DNS
- The DC responds to Internet Control Message Protocol (ICMP) pings
- The DC allows Lightweight Directory Access Protocol (LDAP) connectivity by binding to the instance
- The DC allows binding to the [AD RPC interface](/windows/win32/ad/dc-and-replication-management-functions) using the [DsBindWithCred](/windows/win32/api/ntdsapi/nf-ntdsapi-dsbindwithcreda) function.

> [!NOTE]
> Blocking ICMP prevents DCDiag from functioning as intended. While blocking ICMP is recommended at the Internet-edge of your network, internally blocking ICMP traffic leads to administrative issues that break legacy group policies, black hole router detection, or inefficient MTU sizes due to lack of a discovery option. Troubleshooting tools such as `ping.exe` or `tracert.exe` are also affected.

## DCDiag syntax

```
dcdiag [/s:<DomainController>] [/n:<NamingContext>] [/u:<Domain>\<UserName> /p:{* | <Password> | ""}] [{/a | /e}] [{/q | /v}] [/i] [/f:<LogFile>] [/c [/skip:<Test>]] [/test:<Test>] [/fix] [{/h | /?}] [/ReplSource:<SourceDomainController>]
```

DCDiag uses the following parameters:

|Parameter|Description|
|--|--|
| /s:`<DomainController>`| Specifies the name of the server to run the command against. If this parameter isn't specified, the tests are run against the local domain controller.<br><br>This parameter is ignored for DcPromo and RegisterInDns tests, which can only be run locally.|
| /n:`<NamingContext>`| Uses NamingContext as the naming context to test. You can specify domains in NetBIOS, Domain Name System (DNS), or distinguished name format.|
| /u:`<Domain>`\\`<UserName>` /p:{`<Password>` \| ""} | Uses Domain\\UserName. DCDiag uses the current credentials of the user (or process) that is logged on. If alternate credentials are needed, use the following options to provide those credentials for binding with Password as the password: Use quotation marks ("") for an empty or null password. Use the wildcard character (*) to prompt for the password.|
| /a| Tests all the servers on this AD DS site.|
| /e| Tests all the servers in the enterprise. This overrides `/a`.|
| /q| Quiet. Prints only error messages.|
| /v| Verbose. Prints extended information.|
| /fix| Affects the MachineAccount test only. This parameter causes the test to fix the Service Principal Names (SPNs) on the Machine Account object of the domain controller.|
| /f:`<LogFile>`| Redirects all output to a log file.|
| /c| Comprehensive. Runs all tests except DCPromo and RegisterInDNS, including non-default tests. Optionally, you can use this parameter with the `/skip` parameter to skip specified tests.<br><br>The following tests aren't run by default:<br><ul><li>Topology<br><li> CutoffServers<br><li>OutboundSecureChannels.|
| /h or /?| Displays help at the command prompt.|
| /test:`<Test>`| Runs this test only. The connectivity test, which you can't skip, is also run. This can't be used with `/skip` parameter.|
| /ReplSource:`<SourceDomainController>`| Tests the connection between the domain controller on which you run the command and the source domain controller. (This parameter is used for the CheckSecurityError test.)<br><br>SourceDomainController is the DNS name, NetBIOS name, or distinguished name of a real or potential server that will be the source domain controller for replication, as represented by a real or potential connection object.|

## DCDiag known tests

The following table displays known tests that run by default unless specified otherwise.

|Test|Description|
|--|--|
|Advertising| Checks whether each domain controller advertises itself in the roles that it should be capable of performing. This test validates that the public [DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamea) function used by computers to locate domain controllers will correctly locate any DCs. <br><br> This test fails if the Netlogon Service has stopped or failed to start. If the [Key Distribution Key](/windows/win32/secauthn/key-distribution-center) (KDC) service is stopped, the Advertising test fails since the flag returned from DsGetDcName won't include KDC. If port 88 over TCP and UDP is blocked on a firewall, the Advertising test will pass despite the KDC not being able to answer Kerberos tickets requests.|
|CheckSDRefDom| Checks that all application directory partitions have appropriate security descriptor reference domains. <br><br> This test uses LDAP and validates  [cross reference objects](/windows/win32/adschema/c-crossref) located in **cn=partitions,cn=configuration,dc=\<forest root domain>** contain the correct domain names in their [msDS-SDReferenceDomain](/openspecs/windows_protocols/ms-ada2/fab57b2b-5f1e-4ebd-893b-a4b6b6be78e0) attributes.|
|CheckSecurityError| Test is **not** run by default. Performs various security checks for errors related to the security components of the DC, such as issues with the security policy or the security database using LDAP, RPC, RPC over SMB, and ICMP. It checks: <br><ul><li> That at least one KDC is online for each domain and is reachable. <li> That DCs computer object has replicated to other DCs. <li> If packet fragmentation of Kerberos over UDP might be an issue based on current MTU size by sending non-fragmenting ICMP packets. <li> That there aren't any replication or [KCC](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731537(v=ws.10)) connection issues for connected partners by querying the function [DsReplicaGetInfo](/windows/win32/api/ntdsapi/nf-ntdsapi-dsreplicagetinfow) to get any security-related errors. <li> If the DCs computer account exists in Active Directory (AD) as part of the default “Domain Controllers” OU along with the correct UserAccountControl flags for DCs, the correct ServerReference attributes are set, and has the minimum required Service Principal Names (SPN) configured.</ul></li><br> When the **/ReplSource** parameter is added, the partner also checks: <br><ul><li> The time skew calculated between the servers to verify it's less than 300 seconds (5 minutes) for Kerberos. It does **not** check the Kerberos policy to see if allowed skew has been modified. <li> Permissions on all the naming contexts (such as Schema, Configuration, etc.) on the source DC that validates replication and connectivity functions between DCs. <li> Connectivity to validate that the user running DCDiag can connect to and read the SYSVOL and NETLOGON shares without any security errors. <li> The "**Access this computer from the network**" privilege on the DC is checked to verify it's held by the _Administrators_, _Authenticated Users_, and _Everyone_ groups. <li> The DC's computer object is checked to ensure it's the latest version on the DCs. This is done to prove [replication convergence](/previous-versions/windows/it-pro/windows-server-2003/cc772726(v=ws.10)) along with checking versions, USNs, originating servers, and timestamps. </ul></li> |
|Connectivity| Verifies that the DSA and DNS are registered and reachable using LDAP and RPC. |
|CrossRefValidation| Retrieves a list of [naming contexts](/openspecs/windows_protocols/ms-adts/f0f1e85a-3ac2-466a-87bf-2a8a1d18e4b8) located in **cn=partitions,cn=configuration,dc=\<forest root domain>** with their cross references and then validates them similar to the CheckSDRefDom test using LDAP. This test looks at the nCName, dnsRoot, nETBIOSName, and systemFlags attributes to: <br><ul><li> Ensure DNs names aren't invalid or null. <li> Confirm DNs haven't been altered by CNF or 0ADEL. <li> Ensure systemFlags are correct for that object. <li> Call out empty (orphaned) replica sets. </ul></li> |
|CutoffServers| Tests AD replication to ensure there aren't DCs without working connection objects between partners. Any servers that can't replicate inbound or outbound from any DCs are considered “cut off” using the [DsReplicaSyncAll](/windows/win32/api/ntdsapi/nf-ntdsapi-dsreplicasyncalla) function, which triggers replication on the DCs. Use the `/e` parameter with caution if there are poorly implemented WAN links that are kept clean using schedules. <br><br> If a server can't be contacted or is unavailable to LDAP on the network, then it provides no error or test results, even if the `/v` parameter is specified. This test uses RPC. |
|DcPromo| Tests against the server specified in the client DNS settings if the infrastructure meets the necessary requirements to promote your device to a DC. This test uses DNS on the network and checks: <br><ul><li> If at least one network adapter has a primary DNS server set. <li> If there's a disjointed namespace based on the DNS suffix. <li> That proposed authoritative DNS zone can be contacted. <li> If dynamic DNS updates are possible for the server’s A record. It checks both the setting on the authoritative DNS zone and client registry configuration for DnsUpdateOnAllAdapters and DisableDynamicUpdate. <li> If an LDAP DClocator record, like **_ldap._tcp.dc._msdcs.\<domain>**, is returned when querying for existing forests. |
|DFSREvent| This test validates the Distributed File System Replication (DFSR) service’s health by checking the DFSR event log warning and error entries from the past 24 hours. This test uses RPC and EventLog Remoting Protocol. |
|DNS| Tests enterprise-wide DNS health checks using DNS, RPC, and WMI protocols. To learn about DNS sub tests, see [DNS test syntax](dcdiag.md#dns-test-syntax). |
|FrsEvent| Checks to see if there are errors in the File Replication Service (FRS) event log from the past 24 hours as failing replication of the SysVol share can cause policy problems. This test uses RPC and EventLog Remoting Protocol. |
|Intersite| Checks for failures that would prevent or temporarily hold up intersite replication and predicts how long it would take for the KCC to recover. This test uses DRS functions to check for conditions that would prevent intersite AD replication within a specific site or all sites by: <br><ul><li> Locating and connecting to the Intersite Topology Generators (ISTG). <li> Locating and connecting to the bridgehead servers. <li> Reporting back any replication failures after triggering a replication. <li> Validating all DCs within sites with inbound connections to this site are available. <li> Checking the KCC values for **IntersiteFailuresAllowed** and **MaxFailureTimeForIntersiteLink** overrides within the registry key: **KEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters**. </ul></li><br> The `/a` or `/e` parameter must be used as not providing a site would allow the test to run but skips actual testing. This test uses RPC over the network to test the replication aspects and will make registry connections to check for NTDS override entries. LDAP is also used to locate connection info. |
|KccEvent| This test queries the Knowledge Consistency Checker (KCC) on the DC for errors and warnings generated in the Directory Services event log during the last 15 minutes. This 15 minute threshold is irrespective of the [Repl topology update period (secs)](/previous-versions/windows/it-pro/windows-server-2003/cc739941(v=ws.10)#repltopology-update-delay-secs) registry value on the DC. <br><br> By default, remote connections to the event log are disabled by the Windows Server 2008/R2 firewall rules so this test will fail. [KB2512643](/troubleshoot/windows-server/identity/dcdiag-commands-running-errors#resolution) covers enabling those rules to allow the test to succeed. This test uses RPC along with the EventLog Remoting Protocol. |
|KnowsOfRoleHolders| This test returns the DCs knowledge of the five Flexible Single Master Operation (FSMO) roles but doesn't check all DCs knowledge for consistency. Using the `/e` parameter provides data for comparison. This test uses RPC to return [DSListRoles](/windows/win32/api/ntdsapi/nf-ntdsapi-dslistrolesa) within the [Directory Replication Service](/openspecs/windows_protocols/ms-drsr/06205d97-30da-4fdc-a276-3fd831b272e0) (DRS) functions. |
|MachineAccount| Checks whether the machine account has properly registered and that the services are advertised using LDAP and RPC over SMB. This includes checking: <br><ul><li> The DC's computer account exists in AD. <li> It’s within the Domain Controllers OU. <li> It has the correct [UserAccountControl](/troubleshoot/windows-server/identity/useraccountcontrol-manipulate-account-properties) flags for DCs. <li> The correct [ServerReference](/openspecs/windows_protocols/ms-ada3/f08d0b62-0b0a-4268-9d8e-da4c62f647f1) attributes are set. <li> The minimum [Service Principal Names](/windows/win32/ad/service-principal-names) (SPN) are set. This test is identical to **CheckSecurityError** as they use the same internal test. </ul></li><br> This test also has two repair options: <br><ul><li> `/RecreateMachineAccount` - Recreates a missing DC computer object. This is **not** a recommended fix as it does not recreate any child objects of a DC, such as FRS and DFSR subscriptions. The best practice is to use a valid SystemState backup to authoritatively restore the DC's deleted object and child objects. If you use this option, the DC needs to be gracefully demoted and promoted to repair all the missing relationships. <li> `/FixMachineAccount` - Adds the UserAccountControl flags **TRUSTED_FOR_DELEGATION** and **SERVER_TRUST_ACCOUNT** to a DCs computer object. Using this repair option is preferred over trying to set these flags yourself through **ADSIEDIT** or other LDAP editors. |
|NCSecDesc| Checks permissions on all the naming contexts (such as Schema, Configuration, etc.) on the source DC to validate that replication and connectivity will work between DCs. It makes sure that “Enterprise Domain Controllers” and “Administrators” groups have the correct minimum permissions. This is the same performed test within **CheckSecurityError**. This test uses LDAP. </ul></li>|
|NetLogons| Validates that the user running DCDiag can connect to and read the SYSVOL and NETLOGON shares without any security errors. It also verifies that the Administrators, Authenticated Users, and Everyone group have the “**access this computer from the network**” privilege on the DC.|
|ObjectsReplicated| Checks that the Machine Account and Directory System Agent (DSA) objects have replicated. Two objects are validated by default and that they exist in each DC and are up to date on all other DCs: <br><ul><li> **CN=NTDS Settings** <li> **CN=\<DC name>** </ul></li><br> You can use the `/objectdn:dn` parameter with the `/n:nc` parameter to specify an additional object to check. This test is done using RPC with DRS functions. |
|OutboundSecureChannels| Checks that secure channels exist from all of the domain controllers in the domain to the domains that are specified by the `/testdomain` parameter. The `/nositerestriction` parameter prevents DCDiag from limiting the test to the domain controllers in the site.|
|Replications| Checks for timely replication and any replication errors between domain controllers.|
|RidManager| Checks whether the relative identifier (RID) master is accessible and if it contains the proper information.|
|Services| Checks whether the appropriate domain controller services are running.|
|SysVolCheck| This test reads the DCs Netlogon [SysVolReady](/previous-versions/cc939543(v=technet.10)) registry key to validate that SYSVOL is ready. The value name has to exist with a value of 1 to pass this test and works with either FRS or DFSR replicated SYSVOLs. It doesn’t check if the SYSVOL and NELOGON shares are accessible as this is performed by _CheckSecurityError_. This test uses RPC over SMB. |
|SystemLog| Checks that the system is running without errors.|
|VerifyEnterpriseReferences| Checks that specified system references are intact for the FRS and replication infrastructure across all objects in the enterprise on each domain controller.|
|VerifyReferences| Checks that certain system references are intact for the FRS and replication infrastructure.|
|VerifyReplicas| Checks that all application directory partitions are fully instantiated on all replica servers.|

> [!NOTE]
> Connectivity checks on domain controllers that are registered on the network and connect with other resources like DNS, LDAP, and RPC **can't** be skipped.

## DNS test syntax

```
dcdiag /test:DNS [/DnsBasic | /DnsForwarders | /DnsDelegation | /DnsDynamicUpdate | /DnsRecordRegistration | /DnsResolveExtName [/DnsInternetName:<InternetName>] | /DnsAll] [/f:<LogFile>] [/x:<XMLLog.xml>] [/xsl:<XSLFile.xsl> or <XSLTFile.xslt>] [/s:<DomainController>] [/e] [/v]
```

DNS test uses the following parameters:

|Parameter|Description|
|--|--|
| /test:DNS| Performs the specified DNS test. If no test is specified, defaults to `/DnsAll`.|
| /DnsBasic| Performs basic DNS tests, including network connectivity, DNS client configuration, service availability, and zone existence.|
| /DnsForwarders| Performs the `/DnsBasic` tests and also checks the configuration of forwarders.|
| /DnsDelegation| Performs the `/DnsBasic` tests and also checks for proper delegations.|
| /DnsDynamicUpdate| Performs `/DnsBasic` tests and also determines if dynamic update is enabled in the Active Directory zone.|
| /DnsRecordRegistration| Performs the `/DnsBasic` tests, and also checks if the address (A), canonical name (CNAME) and well-known service (SRV) resource records are registered. In addition, creates an inventory report based on the test results.|
| /DnsResolveExtName [/DnsInternetName:\\`<InternetName>`]| Performs the `/DnsBasic` tests, and also attempts to resolve InternetName. If `/DnsInternetName` isn't specified, attempts to resolve the name <www.microsoft.com>. If `/DnsInternetName` is specified, attempts to resolve the Internet name supplied by the user.|
| /DnsAll| Performs all tests, except for the `/DnsResolveExtName` test, and generates a report.|
| /f:`<LogFile>`| Redirects all output to a log file.|
| /s:`<DomainController>`| Runs the tests against the domain controller. If this parameter isn't specified, the tests are run against the local domain controller.|
| /e| Runs all tests specified by `/test:DNS` against all domain controllers in the Active Directory forest.|
| /v | Verbose. Presents extended information about successful test results in addition to information about errors and warnings.<br>When the `/v` parameter isn't used, provides only error and warning information. Use the `/v` switch when errors or warnings are reported in the summary table.|
| /x:`<XMLLog.xml>`| Redirects all output to xmllog.xml. This parameter works only with the `/test:DNS` option.|
| /xsl:`<XSLFile.xsl>` or <br>/xsl:`<XSLTFile.xslt>`| Adds the processing instructions that reference the specified sheet. This parameter only works with the `/test:DNS /x:<XMLLog.xml` option.|

> [!NOTE]
> Run times for DNS tests can be significant in large enterprises when the **`/e`** parameter is used. Domain controllers and DNS servers that are offline will increase run times due to long time-out periods for RPC and other protocols.

## Examples

### Connectivity test

To run a series of connectivity tests on the local domain, run the following command:

```powershell
dcdiag
```

The following is a successful connectivity test output:

```output
Directory Server Diagnosis


Performing initial setup:

   Trying to find home server...

   Home Server = MapleWaffle-WS22

   * Identified AD Forest. 
   Done gathering initial info.


Doing initial required tests

   
   Testing server: Default-First-Site-Name\MAPLEWAFFLE-WS2

      Starting test: Connectivity

         ......................... MAPLEWAFFLE-WS2 passed test Connectivity


Doing primary tests

      Testing server: Default-First-Site-Name\MAPLEWAFFLE-WS2

      Starting test: Advertising
         ......................... MAPLEWAFFLE-WS2 passed test Advertising

      Starting test: FrsEvent
         ......................... MAPLEWAFFLE-WS2 passed test FrsEvent

      Starting test: DFSREvent
         ......................... MAPLEWAFFLE-WS2 passed test DFSREvent

      Starting test: SysVolCheck
         ......................... MAPLEWAFFLE-WS2 passed test SysVolCheck

      Starting test: KccEvent
         ......................... MAPLEWAFFLE-WS2 passed test KccEvent

      Starting test: KnowsOfRoleHolders
         ......................... MAPLEWAFFLE-WS2 passed test KnowsOfRoleHolders

      Starting test: MachineAccount
         ......................... MAPLEWAFFLE-WS2 passed test MachineAccount

      Starting test: NCSecDesc
         ......................... MAPLEWAFFLE-WS2 passed test NCSecDesc

      Starting test: NetLogons
         ......................... MAPLEWAFFLE-WS2 passed test NetLogons

      Starting test: ObjectsReplicated
         ......................... MAPLEWAFFLE-WS2 passed test ObjectsReplicated

      Starting test: Replications
         ......................... MAPLEWAFFLE-WS2 passed test Replications

      Starting test: RidManager
         ......................... MAPLEWAFFLE-WS2 passed test RidManager

      Starting test: Services
         ......................... MAPLEWAFFLE-WS2 passed test Services

      Starting test: SystemLog
         ......................... MAPLEWAFFLE-WS2 passed test SystemLog

      Starting test: VerifyReferences
         ......................... MAPLEWAFFLE-WS2 passed test VerifyReferences
 
   Running partition tests on : ForestDnsZones

      Starting test: CheckSDRefDom
         ......................... ForestDnsZones passed test CheckSDRefDom

      Starting test: CrossRefValidation
         ......................... ForestDnsZones passed test CrossRefValidation

   Running partition tests on : DomainDnsZones

      Starting test: CheckSDRefDom
         ......................... DomainDnsZones passed test CheckSDRefDom

      Starting test: CrossRefValidation
         ......................... DomainDnsZones passed test CrossRefValidation
   
   Running partition tests on : Schema

      Starting test: CheckSDRefDom
         ......................... Schema passed test CheckSDRefDom

      Starting test: CrossRefValidation
         ......................... Schema passed test CrossRefValidation
   
   Running partition tests on : Configuration

      Starting test: CheckSDRefDom
         ......................... Configuration passed test 
         CheckSDRefDom

      Starting test: CrossRefValidation
         ......................... Configuration passed test 
         CrossRefValidation
   
   Running partition tests on : corp

      Starting test: CheckSDRefDom
         ......................... corp passed test CheckSDRefDom

      Starting test: CrossRefValidation
         ......................... corp passed test CrossRefValidation
   
   Running enterprise tests on : corp.contoso.com

      Starting test: LocatorCheck
         ......................... corp.contoso.com passed test
         LocatorCheck

      Starting test: Intersite
         ......................... corp.contoso.com passed test 
         Intersite
```

To run a series of connectivity tests on a specific domain controller, run the following command:

```powershell
dcdiag /s:<DomainControllerName>
```

It should generate similar results as the local test if no issues are encountered.

### Output to a log file

DCDiag is able to save the output results to a text file by running the following:

```powershell
dcdiag /s:<DomainControllerName> /f:<FileName.txt>
```

If no `<FilePath>` is specified, results are saved to `C:\Users\<UserName>\<FileName.txt>` by default.

To save to a specific location, run the following:

```powershell
dcdiag /s:<DomainControllerName> /f:<DriveLetter>\<FilePath>\<FileName.txt>
```

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
