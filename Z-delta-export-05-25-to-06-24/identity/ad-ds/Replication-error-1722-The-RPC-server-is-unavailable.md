---
title: Replication error 1722 The RPC server is unavailable
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
ms.assetid: 33500c62-ab27-4796-8b51-b7a812d56e04
---
# Replication error 1722 The RPC server is unavailable
This topic explains symptoms, causes and how to resolve Active Directory replication error 1722: The RPC server is unavailable.  
  
-   [Symptoms](../../identity/ad-ds/Replication-error-1722-The-RPC-server-is-unavailable.md#BKMK_Symptoms)  
  
-   [Causes](../../identity/ad-ds/Replication-error-1722-The-RPC-server-is-unavailable.md#BKMK_Causes)  
  
-   [Resolutions](../../identity/ad-ds/Replication-error-1722-The-RPC-server-is-unavailable.md#BKMK_Resolutions)  
  
##  <a name="BKMK_Symptoms"></a> Symptoms  
 This article describes the symptoms, cause and resolution for resolving Active Directory replication failing with Win32 error 1722: The RPC server is unavailable.  
  
1.  DCPROMO promotion of a replica DC fails to create an NTDS Settings object on the helper DC with error 1722.  
  
     Dialog Title Text:  
  
     Active Directory Domain Services Installation Wizard  
  
     Dialog Message text:  
  
     The operation failed because: Active Directory Domain Services could not create the NTDS Settings object for this Active Directory Domain Controller CN\=NTDS Settings,CN\=\<Name of DC being promoted\),CN\=Servers,CN\=\<site name\>,CN\=Sites,CN\=Configuration,DC\=\<forest root domain\> on the remote AD DC \<helper DC\>.\<domain name\>.\<top level domain\>. Ensure the provided network credentials have sufficient permissions. **"The RPC server is unavailable."**  
  
2.  DCDIAG reports that the Active Directory Replications test has failed with error 1722: “The RPC Server is unavailable"  
  
    ```  
    [Replications Check,<DC Name>] A recent replication attempt failed:  
    From <source DC> to <destination DC>  
    Naming Context: <DN path of directory partition>  
    The replication generated an error (1722):  
    The RPC server is unavailable.  
    The failure occurred at <date> <time>.  
    The last success occurred at <date> <time>.  
    <X> failures have occurred since the last success.  
    [<dc name>] DsBindWithSpnEx()failed with error 1722,  
    The RPC server is unavailable..  
    Printing RPC Extended Error Info:   
    <snip>  
    ```  
  
3.  REPADMIN.EXE reports that the last replication attempt has failed with status 1722 \(0x6ba\).  
  
     REPADMIN commands that commonly cite the 1722 \(0x6ba\) status include but are not limited to:  
  
    |||  
    |-|-|  
    |-   REPADMIN \/REPLSUM<br />-   REPADMIN \/SHOWREPL|-   REPADMIN \/SHOWREPS<br />-   REPADMIN \/SYNCALL|  
  
     Sample output from "REPADMIN \/SHOWREPS" and REPADMIN \/SYNCALL depicting "The RPC server is unavailable" error is shown below:  
  
    ```  
    c:\> repadmin /showreps  
    <site name>\<destination DC>  
    DC Options: <list of flags>  
    Site Options: (none)  
    DC object GUID: <NTDS settings object object GUID>  
    DC invocationID: <invocation ID string>  
    ==== INBOUND NEIGHBORS ==========  
    DC=<DN path for directory partition>  
    <site name>\<source DC via RPC  
    DC object GUID: <source DCs ntds settings object object guid>  
    Last attempt @ <date> <time> failed, result 1722 (0x6ba):The RPC server is unavailable.  
    <X #> consecutive failure(s).  
    Last success @ <date> <time>  
  
    ```  
  
     Sample output of "REPADMIN \/SYNCALL" depicting "The RPC server is unavailable" error is shown below:  
  
    ```  
    C:\>repadmin /syncall  
    CALLBACK MESSAGE: Error contacting server <object guid of NTDS  
    Settings object>._msdcs.<forest root domain>.<top level domain>  
    (network error): 1722 (0x6ba):  
    The RPC server is unavailable.  
  
    ```  
  
4.  The "replicate now" command in Active Directory Sites and Services returns "The RPC server is unavailable."  
  
     Right\-clicking on the connection object from a source DC and choosing **Replicate now** fails with "The RPC server is unavailable.” The on\-screen error message is shown below:  
  
     Dialog title text:  
  
     Replicate Now  
  
     Dialog message text:  
  
     The following error occurred during the attempt to synchronize naming context \<DNS name of directory partition\> from domain controller \<source Dc host name\> to domain controller \<destination DC hostname\>:The RPC server is unavailable. This operation will not continue. This condition may be caused by a DNS lookup problem. For information about troubleshooting common DNS lookup problems, please see the following Microsoft Web site: http:\/\/go.microsoft.com\/fwlink\/?LinkId\=5171.  
  
5.  NTDS KCC, NTDS General or Microsoft\-Windows\-ActiveDirectory\_DomainService events with the 1722 status are logged in the Directory Services log in Event Viewer.  
  
     Active Directory events that commonly cite the 1722 status include but are not limited to:  
  
    |Event ID|Event Source|Event String|  
    |--------------|------------------|------------------|  
    |1125|Microsoft\-Windows\-ActiveDirectory\_DomainService|The Active Directory Domain Services Installation Wizard \(Dcpromo\) was unable to establish connection with the following domain controller.|  
    |1311|NTDS KCC|The Knowledge Consistency Checker \(KCC\) has detected problems with the following directory partition.|  
    |1865|NTDS KCC|The Knowledge Consistency Checker \(KCC\) was unable to form a complete spanning tree network topology. As a result, the following list of sites cannot be reached from the local site.|  
    |1925|NTDS KCC|The attempt to establish a replication link for the following writable directory partition failed.|  
    |1960|NTDS Replication|Internal event: The following domain controller received an exception from a remote procedure call \(RPC\) connection. The operation may have failed.|  
  
##  <a name="BKMK_Causes"></a> Causes  
 RPC is an intermediate layer between the network transport and the application protocol. RPC itself has no special insight into failures but attempts to map lower layer protocol failures into an error at the RPC layer.  
  
 RPC error 1722 \/ 0x6ba \/ RPC\_S\_SERVER\_UNAVAILABLE is logged when a lower layer protocol reports a connectivity failure. The common case is that the abstract TCP CONNECT operation failed. In the context of Active Directory replication, the RPC client on the destination DC was not able to successfully connect to the RPC server on the source DC. Common causes for this are:  
  
1.  Link local failure  
  
2.  DHCP failure  
  
3.  DNS failure  
  
4.  WINS failure  
  
5.  Routing failure \(including blocked ports on firewalls\)  
  
6.  IPSec \/ Network authentication failures  
  
7.  UDP formatted Kerberos packets are being fragmented by network infrastructure devices like routers and switches.  
  
8.  Resource limitations  
  
9. Higher layer protocol not running  
  
10. Higher layer protocol is returning this error  
  
##  <a name="BKMK_Resolutions"></a> Resolutions  
 Basic Troubleshooting Steps to identify the problem:  
  
1.  Verify the startup value and service status is correct for the Remote Procedure Call \(RPC\), Remote Procedure Call \(RPC\) Locator and Kerberos Key Distribution Center. The operating system version will determine the correct values for the source and destination system that is logging the replication error. Use the following table to help validate the settings.  
  
    |Service Name|Windows 2000|Windows Server 2003\/R2|Windows Server 2008|Windows Server 2008 R2|  
    |------------------|------------------|-----------------------------|-------------------------|----------------------------|  
    |Remote Procedure Call \(RPC\)|Started \/ Automatic|Started \/ Automatic|Started \/ Automatic|Started \/ Automatic|  
    |Remote Procedure Call \(RPC\) Locator|Started \/ Automatic \(Domain Controllers\)<br /><br /> Not started \/ Manual \(Member Servers\)|Not started \/ Manual|Not started \/ Manual|Not started \/ Manual|  
    |Kerberos Key Distribution Center \(KDC\)|Started \/ Automatic \(Domain Controllers\)<br /><br /> Not started \/ Disabled\(Member Servers\)|Started \/ Automatic \(Domain Controllers\)<br /><br /> Not started \/ Disabled\(Member Servers\)|Started \/ Automatic \(Domain Controllers\)<br /><br /> Not started \/ Disabled\(Member Servers\)|Started \/ Automatic \(Domain Controllers\)<br /><br /> Not started \/ Disabled\(Member Servers\)|  
  
     If you make any changes to match the settings above, reboot the machine and verify both the startup value and service status match the values documented in the previous table.  
  
2.  Verify the **ClientProtocols** key exists under **HKLM\\Software\\Microsoft\\Rpc**, and that it contains the correct default protocols.  
  
    |Protocol Name|Type|Data Value|  
    |-------------------|----------|----------------|  
    |ncacn\_http|REG\_SZ|rpcrt4.dll|  
    |ncacn\_ip\_tcp|REG\_SZ|rpcrt4.dll|  
    |ncacn\_np|REG\_SZ|rpcrt4.dll|  
    |ncacn\_ip\_udp|REG\_SZ|rpcrt4.dll|  
  
     If the ClientProtocols key or any of the four default values are missing, import the key from a known good server.  
  
3.  Verify DNS is working. DNS lookup failures are the cause of a large amount of 1722 RPC errors when it comes to replication. There are a few tools to use to help identify DNS errors:  
  
    -   **DCDIAG \/TEST:DNS \/V \/E \/F:\<filename.log\>**  
  
         The `DCDIAG /TEST:DNS` command can validate DNS health of domain controllers that run Windows 2000 Server \(SP3 or later\), Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2. This test was first introduced with Windows Server 2003 Service Pack 1.  
  
         There are seven test groups for this command:  
  
        -   Authentication \(Auth\)  
  
        -   Basic \(Basc\)  
  
        -   Records registration \(RReg\)  
  
        -   Dynamic update \(Dyn\)  
  
        -   Delegations \(Del\)  
  
        -   Forwarders\/Root hints \(Forw\)  
  
         Sample Output  
  
        ```  
        TEST: Authentication (Auth)  
        Authentication test: Successfully completed  
  
        TEST: Basic (Basc)  
        Microsoft(R) Windows(R) Server 2003, Enterprise Edition (Service Pack level: 2.0) is supported  
        NETLOGON service is running  
        kdc service is running  
        DNSCACHE service is running  
        DNS service is running  
        DC is a DNS server  
        Network adapters information:  
        Adapter [00000009] Microsoft Virtual Machine Bus Network Adapter:  
        MAC address is 00:15:5D:40:CF:92  
        IP address is static  
        IP address: <IP Address  
        DNS servers:  
        <DNS IP Address> (DC.domain.com.) [Valid]  
        The A record for this DC was found  
        The SOA record for the Active Directory zone was found  
        The Active Directory zone on this DC/DNS server was found (primary)  
        Root zone on this DC/DNS server was not found  
        <omitted other tests for readability>  
        Summary of DNS test results:  
  
        Auth Basc Forw Del Dyn RReg Ext   
        ________________________________________________________________  
        Domain: Ca.fragale  
        DC1 PASS PASS FAIL PASS PASS PASS n/a   
        Domain: child.Ca.fragale  
        DC2 PASS PASS n/a n/a n/a PASS n/a   
  
        Enterprise DNS infrastructure test results:  
        For parent domain domain.com and subordinate domain child:  
        Forwarders or root hints are not misconfigured from parent domain to subordinate domain  
        Error: Forwarders are configured from subordinate to parent domain but some of them failed DNS server tests  
  
        (See DNS servers section for error details)  
        Delegation is configured properly from parent to subordinate domain  
        ......................... domain.com failed test DNS  
        The summary provides remediation steps for the more common  
  
        ```  
  
         The summary provides remediation steps for the more common failures from this test.  
        Explanation and additional options for this test can be found at [Domain Controller Diagnostics Tool \(dcdiag.exe\)](http://technet.microsoft.com/library/cc776854\(WS.10\).aspx).  
  
    -   **NLTEST \/DSGETDC:\<netbios or DNS domain name\>**  
  
         Nltest \/dsgetdc: is used to exercise the dc locator process. Thus \/dsgetdc:\< domain name \> tries to find the domain controller for the domain. Using the force flag forces domain controller location rather than using the cache. You can also specify options such as **\/gc** or **\/pdc** to locate a Global Catalog or a Primary Domain Controller emulator. For finding the Global Catalog, you must specify a "tree name," which is the DNS domain name of the root domain.  
  
         Sample Output:  
  
        ```  
        DC: \\DC.Domain.com  
        Address: \\<IP Address>  
        Dom Guid: 5499c0e6-2d33-429d-aab3-f45f6a06922b  
        Dom Name: Domain.com  
        Forest Name: Domain.com  
        Dc Site Name: Default-First-Site-Name  
        Our Site Name: Default-First-Site-Name  
        Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE  
        The command completed successfully  
        ```  
  
    -   **Netdiag \-v**  
  
         This command can be used with Windows Server 2003 and earlier versions to gather specific information for networking configuration and error. This tool takes some time to run when executing the \-v switch.  
  
         Sample Output for the DNS test:  
  
        ```  
        DNS test . . . . . . . . . . . . . : Passed  
        Interface {34FDC272-55DC-4103-B4B7-89234BC30C4A}  
        DNS Domain:   
        DNS Servers: <DNS Server Ip address >  
        IP Address: Expected registration with PDN (primary DNS domain name):  
        Hostname: DC.domain.com.  
        Authoritative zone: domain.com.  
        Primary DNS server: DC.domain.com <Ip Adress>  
        Authoritative NS:<Ip Adress>   
        Check the DNS registration for DCs entries on DNS server <DNS Server Ip address >  
        The Record is correct on DNS server '<DNS Server Ip address >'.  
        (You will see this line repeated several times for every entry for this DC. Including srv records.)  
        The Record is correct on DNS server '<DNS Server Ip address >'.  
        PASS - All the DNS entries for DC are registered on DNS server '<DNS Server Ip address >'.  
        ```  
  
    -   ping \-a \<IP\_of\_problem\_server\>  
  
         This a simple quick test to validate the host record for a domain controller is resolving to the correct machine.  
  
    -   **dnslint \/s IP \/ad IP**  
  
         DNSLint is a Microsoft Windows utility that helps you to diagnose common DNS name resolution issues. The output for this is an .htm file with a lot of information including:  
  
        ```  
  
                      DNS server: localhost  
        IP Address: 127.0.0.1  
        UDP port 53 responding to queries: YES  
        TCP port 53 responding to queries: Not tested  
        Answering authoritatively for domain: NOSOA record data from server:  
        Authoritative name server: DC.domain.com  
        Hostmaster: hostmaster  
        Zone serial number: 14  
        Zone expires in: 1.00 day(s)  
        Refresh period: 900 seconds  
        Retry delay: 600 seconds  
        Default (minimum) TTL: 3600 seconds  
  
        ```  
  
    -   Additional authoritative \(NS\) records from server:  
        DC2.domain.com \<IP Address\>  
  
        ```  
        Alias (CNAME) and glue (A) records for forest GUIDs from server:  
        CNAME: 98d4aa0c-d8e2-499a-8f90-9730b0440d9b._msdcs.domain.com  
        Alias: DC.domain.com  
        Glue: <IP Adress>  
  
        CNAME: a2c5007f-7082-4adb-ba7d-a9c47db1efc3._msdcs.domain.com  
        Alias: dc2.child.domain.com  
        Glue: <IP Address>  
        ```  
  
         For more information, see [Description of the DNSLint utility](http://support.microsoft.com/kb/321045).  
  
4.  Verify network ports are not blocked by a firewall or 3rd party application listening on the required ports.  
  
     The endpoint mapper \(listening on port 135\) tells the client which randomly assigned port a service \(FRS, AD replication, MAPI, and so on\) is listening on.  
  
    |Application protocol|Protocol|Ports|  
    |--------------------------|--------------|-----------|  
    |Global Catalog Server|TCP|3269|  
    |Global Catalog Server|TCP|3268|  
    |LDAP Server|TCP|389|  
    |LDAP Server|UDP|389|  
    |LDAP SSL|TCP|636|  
    |LDAP SSL|UDP|636|  
    |IPsec ISAKMP|UDP|500|  
    |NAT\-T|UDP|4500|  
    |RPC|TCP|135|  
    |RPC randomly allocated high TCP ports|TCP|1024\-5000<br /><br /> 49152\-65535 **Note:**  This is the range in Windows Server 2008, Windows Vista, Windows 7, and Windows 2008 R2.|  
  
     Portqry can be used to identify if a port is blocked from a Dc when targeting another DC. It can be downloaded at [PortQry Command Line Port Scanner Version 2.0](http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=17148).  
  
     Example syntax:  
  
    ```  
    portqry -n <problem_server> -e 135   
    ```  
  
    ```  
    portqry -n <problem_server> -r 1024-5000  
    ```  
  
     A graphical version of portqry, called Portqryui can be found at PortQryUI \- User Interface for the PortQry Command Line Port Scanner[PortQryUI \- User Interface for the PortQry Command Line Port Scanner](http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=24009).  
  
     If the Dynamic Port range has ports being blocked, please use the below links to configure a port range that manageable:  
  
    -   [How to configure RPC dynamic port allocation to work with firewalls](http://support.microsoft.com/?id=154596)  
  
    -   [Restricting Active Directory replication traffic and client RPC traffic to a specific port](http://support.microsoft.com/?id=224196)  
  
    -   [How to restrict FRS replication traffic to a specific static port](http://support.microsoft.com/?id=319553)  
  
    -   [How to configure a firewall for domains and trusts](http://support.microsoft.com/?id=179442)  
  
    -   [Service overview and network port requirements for the Windows Server system](http://support.microsoft.com/?id=832017)  
  
5.  Bad NIC drivers \- See network card vendors or OEMs for the latest drivers.  
  
6.  UDP fragmentation can cause replication errors that appear to have a source of RPC server is unavailable. Event ID 40960 & 40961 errors with a source of LSASRV are very common for this particular cause.  
  
7.  SMB signing mismatches between DCs. Using Default Domain Controllers Policy to configure consistent settings for SMB Signing under the following section will help address this cause:  
  
     Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
     Microsoft network client: Digitally sign communications \(always\) Disabled.  
  
     Microsoft network client: Digitally sign communications \(if server agrees\) Enabled.  
  
     Microsoft network server: Digitally sign communications \(always\) Disabled.  
  
     Microsoft network server: Digitally sign communications \(if client agrees\) Enabled.  
  
     The settings can be found under the following registry keys:  
  
     HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Services\\LanManWorkstation\\Parameters  
  
     HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters  
  
     RequireSecuritySignature\=always \(0 disable, 1 enable\).  
  
     EnableSecuritySignature\=is server agrees \(0 disable, 1 enable\).  
  
 **Additional Troubleshooting:**  
  
 If the above do not provide a solution to the 1722, then you can use the following Diagnostic logging to gather more information:  
  
 Windows Server 2003 SP2 computers logs extended RPC Server info in NTDS Replication events 1960, 1961, 1962 and 1963.  
  
 Crank up NTDS Diagnostic logging.  
  
 1 \= basic, 2 and 3 add verbosity, and 5 logs extended info.  
  
## See Also  
 [Troubleshooting Active Directory operations that fail with error 1722: The RPC server is unavailable](http://support.microsoft.com/kb/2102154)   
 [RPC Return Values](http://msdn.microsoft.com/library/aa378645\(VS.85\).aspx)   
 [Understanding Extended Error Information](http://msdn.microsoft.com/library/aa379109\(VS.85\).aspx)   
 [Extended Error Information Detection Locations](http://msdn.microsoft.com/library/aa373838\(VS.85\).aspx)   
 [Enabling Extended Error Information](http://msdn.microsoft.com/library/aa373803\(VS.85\).aspx)   
 [Network Connectivity](http://technet.microsoft.com/library/cc961803.aspx)