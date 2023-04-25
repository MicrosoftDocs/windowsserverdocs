---
title: dcdiag
description: Dcdiag is used to diagnose Active Directory domain controller health and as a troubleshooting tool by performing several network connectivity tests.
ms.topic: reference
ms.date: 04/25/2023
ms.author: alalve
author: orthomas
---

# Dcdiag

> Applies To: Windows Server 2022, Windows Server 2019, Windows Server 2016

Dcdiag.exe analyzes the state of domain controllers in a forest or enterprise and reports any problems to help in troubleshooting.

As an end-user reporting program, dcdiag is a command-line tool that encapsulates detailed knowledge of how to identify abnormal behavior in the system. Dcdiag displays command output at the command prompt.

Dcdiag consists of a framework for executing tests and a series of tests to verify different functional areas of the system. This framework selects which domain controllers are tested according to scope directives from the user, such as enterprise, site, or single server.

To use dcdiag, you must run dcdiag from an elevated command prompt or PowerShell with administrative rights.

## Dcdiag syntax

`dcdiag [/s:<DomainController>] [/n:<NamingContext>] [/u:<Domain>\<UserName> /p:{* | <Password> | ""}] [{/a | /e}] [{/q | /v}] [/i] [/f:<LogFile>] [/c [/skip:<Test>]] [/test:<Test>] [/fix] [{/h | /?}] [/ReplSource:<SourceDomainController>]`

Dcdiag uses the following parameters:

|Parameter|Description|
|--|--|
| /s:\<DomainController\>| Specifies the name of the server to run the command against. If this parameter isn't specified, the tests are run against the local domain controller.<br><br>This parameter is ignored for DcPromo and RegisterInDns tests, which can only be run locally.|
| /n:\<NamingContext>| Uses NamingContext as the naming context to test. You can specify domains in NetBIOS, Domain Name System (DNS), or distinguished name format.|
| /u:\<Domain\>\\<UserName\> /p:{\<Password\> \| ""} | Uses Domain\\UserName. Dcdiag uses the current credentials of the user (or process) that is logged on. If alternate credentials are needed, use the following options to provide those credentials for binding with Password as the password: Use quotation marks ("") for an empty or null password. Use the wildcard character (*) to prompt for the password.|
| /a| Tests all the servers on this AD DS site.|
| /e| Tests all the servers in the enterprise. This overrides **/a**.|
| /q| Quiet. Prints only error messages.|
| /v| Verbose. Prints extended information.|
| /fix| Affects the MachineAccount test only. This parameter causes the test to fix the Service Principal Names (SPNs) on the Machine Account object of the domain controller.|
| /f:\<LogFile\>| Redirects all output to a log file.|
| /c| Comprehensive. Runs all tests except DCPromo and RegisterInDNS, including non-default tests. Optionally, you can use this parameter with the **/skip** parameter to skip specified tests.<br><br>The following tests aren't run by default:<br><ul><li>Topology<br><li> CutoffServers<br><li>OutboundSecureChannels.|
| /h or /?| Displays help at the command prompt.|
| /test:\<Test\>| Runs this test only. The connectivity test, which you can't skip, is also run. This can't be used with **/skip** parameter.|
| /ReplSource:\<SourceDomainController\>| Tests the connection between the domain controller on which you run the command and the source domain controller. (This parameter is used for the CheckSecurityError test.)<br><br>SourceDomainController is the DNS name, NetBIOS name, or distinguished name of a real or potential server that will be the source domain controller for replication, as represented by a real or potential connection object.|

## Dcdiag default tests

The following table shows tests that run by default.

|Test|Description|
|--|--|
|Advertising| Checks whether each domain controller advertises itself in the roles that it should be capable of performing. This test fails if the Netlogon Service has stopped or failed to start.|
|CheckSDRefDom| Checks that all application directory partitions have appropriate security descriptor reference domains.|
|CrossRefValidation| Checks the validity of cross-references.|
|FrsEvent| Checks to see if there are errors in the file replication system. Failing replication of the SysVol share can cause policy problems.|
|FrsSysVol| Checks that the file replication system and system volume are ready.|
|FSMOCheck| Checks that the domain controller can contact a Kerberos Key Distribution Center (KDC), a time server, a preferred time server, a primary domain controller (PDC), and a global catalog server. This test doesn't test any of the servers for operations master roles.|
|Intersite| Checks for failures that would prevent or temporarily hold up intersite replication and predicts how long it would take for the Knowledge Consistency Checker (KCC) to recover.|
|KccEvent| Checks that the KCC is completing without errors.|
|KnowsOfRoleHolders| Checks whether the domain controller can contact the servers that hold the five operations master roles (also known as flexible single master operations or FSMO roles).|
|MachineAccount| Checks whether the machine account has properly registered and that the services are advertised. Use the **/RecreateMachineAccount** parameter to attempt a repair if the local machine account is missing. Use the **/FixMachineAccount** parameter if the machine account flags are incorrect.|
|NCSecDesc| Checks that the security descriptors on the naming context heads have appropriate permissions for replication.|
|NetLogons| Checks that the appropriate logon privileges exist to allow replication to proceed.|
|ObjectsReplicated| Checks that the Machine Account and Directory System Agent (DSA) objects have replicated. You can use the **/objectdn:dn** parameter with the **/n:nc** parameter to specify an additional object to check.|
|OutboundSecureChannels| Checks that secure channels exist from all of the domain controllers in the domain to the domains that are specified by the **/testdomain** parameter. The **/nositerestriction** parameter prevents dcdiag from limiting the test to the domain controllers in the site.|
|Replications| Checks for timely replication and any replication errors between domain controllers.|
|RidManager| Checks whether the relative identifier (RID) master is accessible and if it contains the proper information.|
|Services| Checks whether the appropriate domain controller services are running.|
|SystemLog| Checks that the system is running without errors.|
|VerifyEnterpriseReferences| Checks that specified system references are intact for the FRS and replication infrastructure across all objects in the enterprise on each domain controller.|
|VerifyReferences| Checks that certain system references are intact for the FRS and replication infrastructure.|
|VerifyReplicas| Checks that all application directory partitions are fully instantiated on all replica servers.|

> [!NOTE]
> Connectivity checks on domain controllers that are  registered on the network and connect with other resources like DNS, LDAP, and RPC **cannot** be skipped.

## DNS test syntax

`dcdiag /test:DNS [/DnsBasic | /DnsForwarders | /DnsDelegation | /DnsDynamicUpdate | /DnsRecordRegistration | /DnsResolveExtName [/DnsInternetName:<InternetName>] | /DnsAll] [/f:<LogFile>] [/x:<XMLLog.xml>] [/xsl:<XSLFile.xsl> or <XSLTFile.xslt>] [/s:<DomainController>] [/e] [/v]`

DNS test uses the following parameters:

|Parameter|Description|
|--|--|
| /test:DNS| Performs the specified DNS test. If no test is specified, defaults to **/DnsAll**.|
| /DnsBasic| Performs basic DNS tests, including network connectivity, DNS client configuration, service availability, and zone existence.|
| /DnsForwarders| Performs the /DnsBasic tests and also checks the configuration of forwarders.|
| /DnsDelegation| Performs the /DnsBasic tests and also checks for proper delegations.|
| /DnsDynamicUpdate| Performs /DnsBasic tests and also determines if dynamic update is enabled in the Active Directory zone.|
| /DnsRecordRegistration| Performs the /DnsBasic tests, and also checks if the address (A), canonical name (CNAME) and well-known service (SRV) resource records are registered. In addition, creates an inventory report based on the test results.|
| /DnsResolveExtName [/DnsInternetName:\<InternetName\>]| Performs the /DnsBasic tests, and also attempts to resolve InternetName. If /DnsInternetName isn't specified, attempts to resolve the name www.microsoft.com. If /DnsInternetName is specified, attempts to resolve the Internet name supplied by the user.|
| /DnsAll| Performs all tests, except for the /DnsResolveExtName test, and generates a report.|
| /f:\<LogFile\>| Redirects all output to a log file.|
| /s:\<DomainController\>| Runs the tests against the domain controller. If this parameter isn't specified, the tests are run against the local domain controller.|
| /e| Runs all tests specified by /test:DNS against all domain controllers in the Active Directory forest.|
| /v | Verbose. Presents extended information about successful test results in addition to information about errors and warnings.<br>When the /v parameter isn't used, provides only error and warning information. Use the /v switch when errors or warnings are reported in the summary table.|
| /x:\<XMLLog.xml\>| Redirects all output to \<XMLLog.xml\>. This parameter works only with the /test:DNS option.|
| /xsl:\<XSLFile.xsl\> or <br>/xsl:\<XSLTFile.xslt\>| Adds the processing instructions that reference the specified sheet. This parameter only works with the **/test:DNS /x:\<XMLLog.xml\>** option.|

> [!NOTE]
> Run times for DNS tests can be significant in large enterprises when the **/e** parameter is used. Domain controllers and DNS servers that are offline will increase run times due to long time-out periods for RPC and other protocols.

## Dcdiag warnings and errors

Dcdiag is able to identify a DNS client or DNS server misconfiguration when an error or warning is triggered during validation. See the table below for the reported issue types:

# [Errors](#tab/errors)

| Errors | Additional Information |
|--|--|
| Error: Authentication failed with specified credentials| Dcdiag requires Enterprise Admin credentials to run all the tests.|
| Error: No WMI connectivity| DNS test requires WMI connectivity to run on the remote computer.|
| Error: Can't read operating system version through WMI| This may be caused due to lack of a WMI connection on the remote computer.|
| Error: Open Service Control Manager failed| Unable to find whether the service is running or not.|
| Error: Kdc/netlogon/DNS/dnscache is not running| Some of the key services aren't running.|
| Error: All DNS servers are invalid| DNS servers that the client is pointing to are either unreachable or not a DNS server, or they have invalid IP addresses.|
| Error: The A record for this DC wasn't found| Every domain controller should register a host (A) resource record. Make sure that host (A) records are registered on all the DNS servers that the client is pointing to.|
| Error: Could not query DNS zones on this DC| Make sure that the zone in which the domain controller is supposed to register is present.|
| Error: Forwarders list has invalid forwarder:\<IP address of the forwarder>| Forwarders configured on the DNS server have an invalid IP address or aren't a DNS server, or name resolution isn't working. Meaning that it can't resolve the forest root domain SRV record if it's a non-root domain controller.|
| Error: Both root hints and forwarders are not configured. Configure either forwarders or root hints| Make sure that either forwarders or root hints are configured on the DNS server unless it hosts a root zone.|
| Error: Root hints list has invalid root hint server:\<IP address of Root hint server>| Root hint servers configured on the DNS server have an invalid IP address or aren't a DNS server, or name resolution isn't working meaning that it can't resolve the forest root domain SRV record if it's a non-root domain controller.|
| Error:\<Root hint server Name> IP:\<Unavailable> Status:\<status of the server>| Configured root hint servers don’t have corresponding IP address. Status field tells you the status of the server.|
| Error:\<Root hint server Name> IP:\<Unavailable> Status: A record not found| The configured root hint servers don’t have A record.|
| Error: Enumeration of Root hint servers failed on \<DNS server name>| Couldn’t list the root hint servers on the target DNS server.|
| Error: DNS server:\<Server name> IP:\<IP address> Error: Broken delegation -verbose| Delegation is configured but the name server isn't responding.|
| Error: Dynamic update is not enabled on the zone \<zone name>| Dynamic update isn't enabled on the Active Directory zone so the client can't register its records.|
| Error: Missing A record at DNS server \<DNS Server IP address>:\<A record name>| DC hasn’t registered its A record on the specified DNS server.|
| Error: Missing CNAME record at DNS server \<DNS Server IP address>:\<CNAME record name> | DC hasn’t registered its CNAME record on the specified DNS server.|
| Error: Missing DC SRV record at DNS server \<DNS Server IP address>:\<SRV record name> | The domain controller hasn’t registered its SRV record on the specified DNS server.|
| Error: Missing GC SRV record at DNS server \<DNS Server IP address>:\<SRV record name> | The domain controller hasn’t registered its GC SRV record on the specified DNS server.|
| Error: Missing PDC SRV record at DNS server \<DNS Server IP address>:\<SRV record name> | DC hasn’t registered specified PDC SRV record on the specified DNS server. All these records can be registered by stopping and starting the netlogon service.|
| Error: Record registrations cannot be found for all the network adapters| If there are multiple network adapters the test checks whether all the records are present on all the DNS servers configured on each adapter. This error occurs if the record registration is missing on the DNS server. |
| Error: Internet name \<name> cannot be resolved| Specified Internet name can't be resolved. Make sure the proxy client, servers, root hints, and forwarders are configured properly.|
| Error: Delegation is not configured on the parent domain| Delegation should be configured from parent to subordinate domain.|
| Error: Delegation is present but the glue record is missing| Delegation is configured but the name servers are missing their glue record.|
| Error: Forwarders are misconfigured from parent domain to subordinate domain| Forwarders must be configured from subordinate domain to parent domain.|
| Error: Forwarders are configured from subordinate to parent domain but some of them failed DNS server tests| Forwarders configured have an invalid IP address or aren't a valid DNS server, or name resolution isn't working.|
| Error: Root hints are misconfigured from parent domain to subordinate domain| Root hints must be configured from subordinate domain to parent domain.|
| Error: Root hints are configured from subordinate to parent domain but some of them failed DNS server tests| Root hints configured have an invalid IP address or aren't a valid DNS server, or name resolution isn't working.|

# [Warnings](#tab/warnings)

| Warnings | Additional Information |
|--|--|
| Warning: Adapter \<adapter name> has dynamic IP address| Static IP addresses are recommended for all DNS servers.|
| Warning: Adapter \<adapter name> has invalid DNS server: \<name> \<IP address>| DNS server may not be reachable.|
| Warning: No DNS RPC connectivity (error or non Microsoft DNS server is running)| Disregard this warning if the DNS server is a BIND (Berkeley Internet Name Domain) or other non-Microsoft DNS server.|
| Warning: DNS server: \<DnsServer name> IP: \<Ipaddress> Failure: Missing glue A record| The configured delegation is missing glue A record.|
| Warning: Dynamic update is enabled on the zone but not secure \<zone name>| Secure dynamic updates are recommended.|
| Warning: Failed to add test record _dcdiag_test_record with error \<error code> in zone \<zone name>| Test adds a dummy record dynamically.|
| Warning: Failed to delete test record _dcdiag_test_record with error \<error code> in zone \<zone name>| Deletes the added record as well.|
| Warning: Missing DC SRV record at DNS server \<record name>| Ignore the error if DNSAvoidRegisterRecord registry key or its Group Policy has been configured to prevent registration of this record.|
| Warning: Missing GC SRV record at DNS server \<record name>| Ignore the error if DNSAvoidRegisterRecord registry key or its Group Policy has been configured to prevent registration of this record.|
| Warning: Missing PDC SRV record at DNS server \<record name>| Ignore the error if DNSAvoidRegisterRecord registry key or its Group Policy has been configured to prevent registration of this record.|
| Warning: Neither forwarders nor root hints are configured from subordinate domain to parent domain| Forwarder or root hints need to be configured in the DNS servers of either the parent or subordinate domains that are hosting the authoritative zones for their respective domain to enable name resolution to work.|

---

## Examples

### Connectivity test

To run a series of connectivity tests on the local domain, run the following command:

```powershell
dcdiag
```

A successful connectivity test output can be seen below:

```powershell
PS C:\Users\Administrator> dcdiag

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
   
   Running enterprise tests on : corp.baconpancake.com

      Starting test: LocatorCheck
         ......................... corp.baconpancake.com passed test
         LocatorCheck

      Starting test: Intersite
         ......................... corp.baconpancake.com passed test 
         Intersite

PS C:\Users\Administrator>
```

To run a series of connectivity tests on a specific domain controller, run the following command:

```powershell
dcdiag /s:<DomainControllerName>
```

It should generate similar results as the local test if no issues are encountered.

### Output to a log file

Dcdiag is able to save the output results to a text file by running the following:

```powershell
dcdiag /s:<DomainControllerName> /f:<FileName.txt>
```

If no `<FilePath>` is specified, results are saved to `C:\Users\<UserName>\<FileName.txt>` by default.

To save to a specific location, run the following:

```powershell
dcdiag /s:<DomainControllerName> /f:<DriveLetter>\<FilePath>\<FileName.txt>
```

## Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
