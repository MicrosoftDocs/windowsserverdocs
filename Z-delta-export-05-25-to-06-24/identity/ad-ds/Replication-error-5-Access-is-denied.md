---
title: Replication error 5 Access is denied
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
ms.assetid: 87acf6ce-5166-4ab4-b8d7-42b03bab226a
---
# Replication error 5 Access is denied
This topic explains symptoms, causes and how to resolve Active Directory replication error 5: Access is denied.  
  
-   [Symptoms](../../identity/ad-ds/Replication-error-5-Access-is-denied.md#BKMK_Symptoms)  
  
-   [Causes](../../identity/ad-ds/Replication-error-5-Access-is-denied.md#BKMK_Causes)  
  
-   [Resolutions](../../identity/ad-ds/Replication-error-5-Access-is-denied.md#BKMK_Resolutions)  
  
##  <a name="BKMK_Symptoms"></a> Symptoms  
 This article describes the symptoms, cause and resolution steps for situations where Active Directory replication operations fail with error 5: Access is denied.  
  
1.  DCDIAG reports that Active Directory Replications test has failed with error status code \(5\): "access is denied:"  
  
    ```  
    Testing server: <site name>\<destination dc name>  
    Starting test: Replications  
    * Replications Check  
    [Replications Check,<destination DC name] A recent replication attempt failed:  
    From <source DC> to <destination DC>  
    Naming Context: <directory partition DN path>  
    The replication generated an error (5):  
    Access is denied.  
    The failure occurred at <date> <time>.  
    The last success occurred at <date> <time>.  
    3 failures have occurred since the last success.  
    ```  
  
2.  REPADMIN.EXE reports that the last replication attempt has failed with status 5.  
  
     REPADMIN commands that commonly cite the 5 status include but are not limited to:  
  
    |||  
    |-|-|  
    |-   REPADMIN \/KCC<br />-   REPADMIN \/REPLICATE<br />-   REPADMIN \/REPLSUM|-   REPADMIN \/SHOWREPL<br />-   REPADMIN \/SHOWREPS<br />-   REPADMIN \/SYNCALL|  
  
     The following sample output from "REPADMIN \/SHOWREPS" shows inbound replication from CONTOSO\-DC2 to CONTOSO\-DC1 failing with the "replication access was denied" error:  
  
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
    Last attempt @ <date> <time> failed, result 5(0x5):  
    Access is denied.  
    <#> consecutive failure(s).  
    Last success @ <date> <time>.  
  
    ```  
  
3.  NTDS KCC, NTDS General or Microsoft\-Windows\-ActiveDirectory\_DomainService events with the 5 status are logged in the Directory Services log in Event Viewer.  
  
     Active Directory events that commonly cite the 5 status include but are not limited to:  
  
    |Event ID|Event Source|Event String|  
    |--------------|------------------|------------------|  
    |1655|NTDS General|Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.|  
    |1925|NTDS KCC|The attempt to establish a replication link for the following writable directory partition failed.|  
    |1926|NTDS KCC|The attempt to establish a replication link to a read\-only directory partition with the following parameters failed.|  
  
4.  The **Replicate now** command in Active Directory Sites and Services returns "Access is denied."  
  
     Right\-clicking on the connection object from a source DC and choosing "replicate now" fails with "Access is denied. The on\-screen error message text and screenshot is shown below:  
  
     Dialog title text: Replicate Now  
  
     Dialog message text:  
  
     The following error occurred during the attempt to synchronize naming context \<%directory partition name%\> from Domain Controller \<Source DC\> to Domain Controller \<Destination DC\>:  
  
     Access is denied  
  
     The operation will not continue  
  
     \<insert ADDS\_ReplError\_AccessIsDenied\>  
  
##  <a name="BKMK_Causes"></a> Causes  
 Valid root causes for error 5: "access is denied" include:  
  
1.  The "Access this computer from network" user right is not granted to the "Enterprise Domain Controllers" group or the administrator triggering immediate replication.  
  
2.  The "CrashOnAuditFail" setting in the registry of the destination DC has a value of 2.  
  
3.  There is a time difference between the KDC used by the destination DC and the source DC that exceeds the maximum time skew allowed by Kerberos defined in Default Domain Policy.  
  
4.  There is an SMB signing mismatch between the source and destination DCs.  
  
5.  There is an LMCompatiblity mismatch between the source and destination DCs.  
  
6.  Service principal names are either not registered or not present due to simple replication latency or a replication failure.  
  
7.  UDP formatted Kerberos packets are being fragmented by network infrastructure devices like routers and switches.  
  
8.  The secure channel on the source or destination DC is invalid.  
  
9. Trust relationships in the trust chain are broken or invalid.  
  
10. The KDCNames setting in the HKLM\\System\\CurrentControlSet\\Control\\LSA\\Kerberos\\Domains section of the registry incorrectly contains the local Active Directory domain name  
  
11. Some network adapters have a "Large Send Offload" feature that has been known to cause this issue.  
  
12. Antivirus software that uses a mini\-firewall network adapter filter driver on the source or destination DC has been known to cause this issue.  
  
 Active Directory errors and events like those cited in the symptoms section of this topic can also fail with error 8453 with similar error string "Replication Access was denied." The following root cause reasons can cause AD operations to fail with 8453: "replication access was denied" but do not cause failures with error 5: “replication is denied":  
  
1.  NC head not granted the "replicating directory changes" permission.  
  
2.  The security principal initiating replication is not a member of a group that has been granted "replicating directory changes."  
  
3.  Missing flags in the **UserAccountControl** attribute including SERVER\_TRUST\_ACCOUNT and TRUSTED\_FOR\_DELEGATION.  
  
4.  An RODC was promoted into the domain without previously running ADPREP \/RODCPREP.  
  
 For more information, see Active Directory replication error 8453: Replication access was denied.  
  
##  <a name="BKMK_Resolutions"></a> Resolutions  
 There are multiple root causes for Active Directory Replication failing with error 5. Attack the problem initially by using tools like DCDIAG, DCDIAG \/TEST:CheckSecurityError and NETDIAG to expose common problems.  
  
 Run DCDIAG, DCDIAG \/TEST:CheckSecurityError and NETDIAG  
  
 The generic DCDIAG runs multiple tests. **DCDIAG \/TEST:CheckSecurityErrors** was written to perform specific tests \(including an SPN registration check\) to troubleshoot Active Directory operations replication failing with error 5: ”access is denied” and error 8453: “replication access was denied" but is NOT run as part of the default execution of DCDIAG.  
  
1.  Run DCDIAG on the destination DC.  
  
2.  Run DCDAIG \/TEST:CheckSecurityError  
  
3.  Run NETDIAG  
  
4.  Resolve any faults identified by DCDIAG and NETDIAG. Retry the previously failing replication operation. If still failing, proceed to the next Resolution options.  
  
1.  Check "Access this computer from network" rights  
  
     In a default installation of Windows, the Default Domain Controllers Policy is linked to the domain controllers OU and it grants the "Access this computer from network" user right to the following security groups:  
  
    -   Administrators  
  
    -   Authenticated Users  
  
    -   Everyone  
  
    -   Enterprise Domain Controllers  
  
    -   \[Pre\-Windows 2000 compatible access\]  
  
     If Active Directory operations are failing with error 5: "access is denied", verify that:  
  
    -   Security groups in the list above have been granted the "Access this computer from network" user right in the Default Domain Controllers Policy.  
  
    -   Domain controller computer accounts are located in the **Domain Controllers** OU.  
  
    -   Default Domain Controllers Policy is linked to the **Domain Controllers** OU or alternate OUs hosting computer accounts.  
  
    -   Group Policy is applying on the destination domain controller currently logging error 5.  
  
    -   "Deny access this computer from network" user right has NOT been enabled or does not reference failing direct or nested groups.  
  
    -   Group Policy precedence, blocked inheritance, WMI filtering or similar settings do NOT prevent the "Access this computer from network" user right from applying to domain controllers.  
  
     Group Policy settings can be validated with RSOP.MSC but "GPRESULT \/Z" is the preferred tool because it is more accurate.  
  
     Note: Local policy takes precedence over policy defined in Sites, Domains and OU.  
  
     Note: At one time it was common for administrators to remove the **Enterprise Domain Controllers** and **Everyone** groups from the "Access this computer from network" user right in Default Domain Controllers Policy. Removing both is ill advised. There is no reason to remove **Enterprise Domain Controllers** from this right as only domain controllers are a member of this group.  
  
2.  CrashOnAuditFail\=2  
  
     Active Directory replication fails when HKLM\\System\\CurrentControlSet\\Control\\LSA\\CrashOnAuditFail has a value of "2".  
  
     A CrashOnAduitFail value of 2 is triggered when the "Audit: Shut down system immediately if unable to log security audits" setting in Group Policy has been enabled AND the local Security log in Event Viewer becomes full.  
  
     Active Directory domain controllers are especially prone to maximum capacity Security logs when auditing has been enabled AND the size of the Security event log has been constrained by the "Do not overwrite events \(clear log manually\) or "Overwrite as needed" options in Event Viewer or Group Policy equivalents.  
  
     **User Action**  
  
     If HKLM\\System\\CCS\\Control\\LSA\\CrashOnAuditFail has a value of "2":  
  
    1.  Clear the security event log \(save to alternate location as required\).  
  
    2.  Re\-evaluate any size constraints on the Security event log, including Group Policy settings.  
  
    3.  Recreate "CrashOnAuditFail \(REG\_DWORD\) with a value of 1.  
  
    4.  Reboot.  
  
     **Related Content**  
  
     [MSKB 888179](http://support.microsoft.com/default.aspx?scid=kb;EN-US;888179): Issues that occur when the CrashOnAuditFail registry value is set to 1 on an Exchange computer or that occur when the Security event log reaches the maximum size in Windows 2000 Server  
  
     [MSKB 140058](http://support.microsoft.com/default.aspx?scid=kb;EN-US;140058): How To Prevent Auditable Activities When Security Log Is Full  
  
3.  Excessive Time Skew  
  
     Kerberos Group Policy settings in the Default Domain Policy allow for a 5 minute difference \(default value\) in system time between Key Distribution Center \(KDC\) domain controllers and a Kerberos target servers in order to prevent replay attacks. Some documentation states that time between the client and the Kerberos target must have time within 5 minutes of each other. Others state that in the context of Kerberos authentication, the time that matters is the delta between the KDC used by the caller and the time on the Kerberos target. Also, whether system time on the relevant DCs matches current time is not significant to Kerberos, only that *relative* time difference between the KDC and target DC is inside the \(default 5 minutes or less\) maximum time skew allowed by Kerberos policy.  
  
     In the context of Active Directory operations, the target server is the source DC being contacted by the destination DC. Every domain controller in an Active Directory forest \(currently running the KDC service\) is a potential KDC so you need to consider time accuracy on all other DCs against the source DC including time on the destination DC itself.  
  
     Two methods to check time accuracy include:  
  
    ```  
    C:\>DCDIAG /TEST:CheckSecurityError  
    ```  
  
     And  
  
    ```  
    C:\>W32TM /MONITOR  
    ```  
  
     Sample output from DCDIAG \/TEST:CheckSecurityError depicting excessive time skew on Windows Server 2003 and Windows Server 2008 R2 domain controllers can be found in the [More Information](../../identity/ad-ds/Replication-error-5-Access-is-denied.md#BKMK_MoreInfo) section of this article.  
  
     Look for LSASRV 40960 events on the destination DC at the time of the failing replication request that cite a GUID in the CNAME record of the source DC with extended error 0xc000133: "the time at the Primary Domain Controller is different than the time at the Backup Domain Controller or member server by too large an amount."  
  
     Network traces capturing the destination computer connecting to a shared folder on the source DC \(as well as other operations\) may show the on\-screen error "an extended error has occurred." while a network trace shows:  
  
    ```  
    -> KerberosV5 KerberosV5:TGS Request Realm: <- TGS request from source DC   
    <- Kerberosvs Kerberosvs:KRB_ERROR - KRB_AP_ERR_TKE_NVV (33) <- TGS response where "KRB_AP_ERR_TKE_NYV  
    <- maps to "Ticket not yet valid"  
    ```  
  
     The TKE\_NYV response indicates that the date range on the TGS ticket is newer than time on the target, indicating excessive time skew.  
  
     Note: W32TM \/MONITOR only checks time on DCs in the test computers domain so you need to run this in each domain and compare time between the domains.  
  
     Note: if system time was found to be inaccurate, make an effort to figure out why and what can be done to prevent inaccurate time going forward. Was the forest root PDC configured with an external time source? Are reference time sources online and available on the network? Was the time service running? Are DC role computers configured to use NT5DS hierarchy to source time? Was time rollback protection described in [MSKB 884776](http://support.microsoft.com/default.aspx?scid=kb;EN-US;884776) in place? Do system clocks have good batteries and accurate time in the bios? Are virtual host and guest computers configured to source time correctly?  
  
     Note: When the time difference is too great on Windows Server 2008 R2 destination DCs, the **Replicate now** command in DSSITE.MSC fails with the on\-screen error "There is a time and \/ or date difference between the client and the server." This error string maps to error 1398 decimal \/ 0x576 hex with symbolic error name ERROR\_TIME\_SKEW.  
  
     **Related Content**  
  
     [Setting Clock Synchronization Tolerance to Prevent Replay Attacks](http://technet.microsoft.com/library/cc784130\(WS.10\).aspx) \(http:\/\/technet.microsoft.com\/library\/cc784130\(WS.10\).aspx\)  
  
4.  SMB signing mismatch  
  
     The best compatibility matrix for SMB signing is documented in the graphic and text "interoperability matrix" sections of [MSKB 916846](http://support.microsoft.com/default.aspx?scid=kb;EN-US;916846) and is defined by four policy settings and their registry\-based equivalents:  
  
    |Policy Setting|Registry Path|  
    |--------------------|-------------------|  
    |Microsoft network client: Digitally sign communications \(if server agrees\)|HKLM\\SYSTEM\\CCS\\Services\\Lanmanworkstation\\Parameters\\Enablesecuritysignature|  
    |Microsoft network client: Digitally sign communications \(always\)|HKLM\\SYSTEM\\CCS\\Services\\Lanmanworkstation\\Parameters\\Requiresecuritysignature|  
    |Microsoft network server: Digitally sign communications \(if server agrees\)|HKLM\\SYSTEM\\CCS\\Services\\Lanmanserver\\Parameters\\Enablesecuritysignature|  
    |Microsoft network server: Digitally sign communications \(always\)|HKLM\\SYSTEM\\CCS\\Services\\Lanmanserver\\Parameters\\Requiresecuritysignature|  
  
     Focus on SMB signing mismatches between the destination and source domain controllers with the classic cases being the setting enabled or required on one side but disabled on the other.  
  
     Note: internal testing showed SMB signing mismatches causing replication to fail with error 1722: The RPC Server is unavailable.  
  
5.  UDP formatted Kerberos packet fragmentation  
  
     Network routers and switches may fragment or completely drop large UDP formatted network packets used by Kerberos and EDNS0 \(DNS\). Computers running Windows 2000 and Windows Server 2003 operating system families are particularly vulnerable to UDP fragmentation relative to computers running Windows Server 2008 and Windows Server 2008 R2.  
  
     **User Action**  
  
    -   From the console of the destination DC, ping the source DC by its fully qualified computer name to identify the largest packet supported by the network route.  
  
        ```  
        c:\>Ping <source DC hostname>.<fully qualified computer name> -f -l 1472  
        ```  
  
    -   If the largest non\-fragmented packet is less than 1472 bytes, either \(in order of preference\):  
  
        -   Modify your network infrastructure to properly support large UDP frames. This may require a firmware upgrade or configuration change on routers, switches or firewalls.  
  
         Or  
  
        -   Set maxpacketsize \(on the destination DC\) to the largest packet identified by the PING \-f \-l command less 8 bytes to account for the TCP header and reboot the modified DC.  
  
         Or  
  
        -   Set maxpacketsize \(on the destination DC\) to a value of "1" which triggers Kerberos to use a TCP. Reboot the modified DC to make the change take effect.  
  
    -   Retry the failing Active Directory operation.  
  
6.  Invalid Secure channel \/ Password Mismatch  
  
     Validate the secure channel with "nltest \/sc:query" or "netdom verify".   
    On condition, reset the destination DCs password with NETDOM \/RESETPWD as described in multiple articles including [MSKB 325850](http://support.microsoft.com/default.aspx?scid=kb;EN-US;325850).  
  
     **User Action**  
  
    -   Disable the KDC service on the DC being rebooted.  
  
    -   From the console of the destination DC, run NETDOM RESETPWD to reset the password for the destination DC.  
  
        ```  
        :\>netdom resetpwd /server: server_name /userd: domain_name \administrator /passwordd: administrator_password  
        ```  
  
    -   Ensure that likely KDCs AND the source DC \(if in the same domain\) inbound replicate knowledge of the destination DCs new password.  
  
    -   Reboot the destination DC to flush Kerberos tickets and retry the replication operation.  
  
     **Related Content**  
  
     [MSKB 325850](http://support.microsoft.com/default.aspx?scid=kb;EN-US;325850) How to use Netdom.exe to reset machine account passwords of a Windows Server domain controller  
  
7.  Invalid Trust  
  
     If Active Directory replication is failing between DCs in *different* domains, verify the health of the trust relationship along the trust path.  
  
     When able, use the **NETDIAG Trust Relationship** test to check for broken trusts. NETDIAG identifies broken trusts with the following text:  
  
     Trust relationship test. . . . . . : Failed Test to ensure DomainSid of domain '\<domainname\>' is correct. \[FATAL\] Secure channel to domain '\<domainname\>' is broken. \[\<%variable status code%\>\]  
  
     For example, if you have a multidomain forest containing root domain Contoso.COM, child domain B.Contoso.COM, grandchild domain C.B.Contoso.COM and "tree domain in same forest" Fabrikam.COM where replication is failing between DCs in grandchild domain C.B.Contoso.COM and tree domain Fabrikam.COM, then verify trust health between C.B.Contoso.COM and B.Contoso.COM, B.Contoso.COM and Contoso.COM then finally Contoso.COM and Fabrikam.COM.  
  
     If a short cut trust exists between the destination domains, the trust path chain does not have to be validated. Instead validate the short cut trust between the destination and source domain.  
  
     Check for recent password changes to the trust:  
  
    ```  
    Repadmin /showobjmeta * <DN path for Trusted Domain Object (TDO) in question>  
    ```  
  
     **Commands to reset trusts**  
  
     From forest root domain PDC emulator:  
  
    ```  
    netdom trust <Root Domain> /Domain:<Child Domain> /UserD:CHILD /PasswordD:* /UserO:ROOT /PasswordO:* /Reset /TwoWay  
    ```  
  
     From child domain PDC emulator:  
  
    ```  
    netdom trust <Child Domain> /Domain:<Root Domain> /UserD:Root /PasswordD:* /UserO:Child /PasswordO:* /Reset /TwoWay  
    ```  
  
8.  Invalid Kerberos realm \- PolAcDmN \/ PolPrDmN  
  
     Copied from [MKSB 837513](http://support.microsoft.com/default.aspx?scid=kb;EN-US;837513) Domain controller is not functioning correctly  
  
    1.  Start Registry Editor.  
  
    2.  In the left pane, expand Security.  
  
    3.  On the Security menu, click Permissions to grant the Administrators local group Full Control of the SECURITY hive and its child containers and objects.  
  
    4.  Locate the HKEY\_LOCAL\_MACHINE\\SECURITY\\Policy\\PolPrDmN key.  
  
    5.  In the right pane of Registry Editor, click the \<No Name\>: REG\_NONE entry one time.  
  
    6.  On the View menu, click Display Binary Data. In the Format section of the dialog box, click Byte.  
  
    7.  The domain name appears as a string in the right side of the Binary Data dialog box. The domain name is the same as the Kerberos realm.  
  
    8.  Locate the HKEY\_LOCAL\_MACHINE\\SECURITY\\Policy\\PolACDmN registry key.  
  
    9. In the right pane of Registry Editor, double\-click the \<No Name\>: REG\_NONE entry.  
  
    10. In the Binary Editor dialog box, paste the value from PolPrDmN. \(The value from PolPrDmN will be the NetBIOS domain name\).  
  
    11. Restart the domain controller.  
  
9. Invalid Kerberos realm \- KdcNames  
  
     **User Action**  
  
    1.  On the console of the destination DC, run "REGEDIT".  
  
    2.  Locate the following path in the registry: HKLM\\system\\ccs\\control\\lsa\\kerberos\\domains  
  
    3.  For each \<fully qualified domain\> under HKLM\\system\\ccs\\control\\lsa\\kerberos\\domains, verify that the value for "KdcNames" refers to a valid *external* Kerberos realm and NOT the local domain or another domain in the same Active Directory forest.  
  
10. Network Adapters with "IPv4 Large Send Offload" enabled:  
  
     **User Action**  
  
    1.  Open network adapter Properties.  
  
    2.  Click Configure.  
  
    3.  Click Advanced tab.  
  
    4.  Disable "IPv4 Large Send Offload".  
  
    5.  Reboot.  
  
##  <a name="BKMK_MoreInfo"></a> More Information  
 Sample DCDIAG \/test:CHECKSECURITYERROR output from a Windows Server 2008 R2 DC caused by excessive time skew:  
  
```  
Doing primary tests  
Testing server: Default-First-Site-Name\CONTOSO-DC1  
Starting test: CheckSecurityError  
Source DC CONTOSO-DC2 has possible security error (1398).  
Diagnosing...  
Time skew error between client and 1 DCs! ERROR_ACCESS_DENIED  
or down machine received by:  
CONTOSO-DC2  
[CONTOSO-DC2] DsBindWithSpnEx() failed with error 1398,  
There is a time and/or date difference between the client and server..  
Ignoring DC CONTOSO-DC2 in the convergence test of object  
CN=CONTOSO-DC1,OU=Domain Controllers,DC=contoso,DC=com, because we  
cannot connect!  
......................... CONTOSO-DC1 failed test CheckSecurityError  
  
```  
  
 Sample DCDIAG \/CHECKSECURITYERROR output from a Windows Server 2003 DC caused by excessive time skew:  
  
```  
Doing primary tests  
Testing server: Default-First-Site-Name\CONTOSO-DC3  
Starting test: CheckSecurityError  
Source DC CONTOSO-DC1 has possible security error (5). Diagnosing...  
Time skew error between client and 1 DCs! ERROR_ACCESS_DENIED or down machine recieved by:  
CONTOSO-DC1  
Source DC CONTOSO-DC2 has possible security error (5). Diagnosing...  
Time skew error: 7205 seconds different between:.  
CONTOSO-DC2  
CONTOSO-DC3  
[CONTOSO-DC1] DsBindWithSpnEx() failed with error 5,  
Access is denied..  
Ignoring DC CONTOSO-DC1 in the convergence test of object CN=CONTOSO-DC3,OU=Domain Controllers,DC=contoso,DC=com, because we cannot connect!  
......................... CONTOSO-DC3 failed test CheckSecurityError  
  
```  
  
 Sample DCDIAG \/CHECKSECURITYERROR output showing missing SPN names \(the output of which could vary from environment to environment\). Sample output is shown below:  
  
```  
Doing primary tests  
Testing server: <site name>\<dc name>  
Test omitted by user request: Advertising  
Starting test: CheckSecurityError  
* Dr Auth: Beginning security errors check’  
Found KDC <KDC DC> for domain <DNS Name of AD domain> in site <site name>  
Checking machine account for DC <DC name> on DC <DC Name>  
* Missing SPN :LDAP/<hostname>.<DNS domain name>/<DNS domain name>  
* Missing SPN :LDAP/<hostname>.<DNS domain name>  
* Missing SPN :LDAP/<hostname>  
* Missing SPN :LDAP/<hostname>.<DNS domain name>/<NetBIOS domain name>  
* Missing SPN :LDAP/bba727ef—be4e—477d—9796—63b6cee3bSf.<forest root domain DN>  
* SPN found :E3514235—4B06—I1D1—ABØ4-00c04fc2dcd2/<NTDS Settings object GUID>/<forest root domain DNS name>  
* Missing SPN :HOST/<hostname>.<DNS domain name>/<DNS domain name>  
* SPN found :HOST/<hostname>.<DNS domain name>  
* SPN found :HOST/<hostname>  
* Missing SPN :HOST/<hostname>.<DNS domain name>/<NetBIOS domain name>  
* Missing SPN :GC/<hostname>.<DNS domain name>/<DNS domain name>  
Unable to verify the machine account (<DN path for Dc machine account>) for <DC Name> on <DC name>.  
  
```  
  
 Sample DCDIAG \/CHECKSECURITYERROR output from a Windows Server 2003 DC caused by excessive time skew:  
  
```  
Testing server: <site name>\<dc name>  
Test omitted by user request: Advertising  
Starting test: CheckSecurityError  
* Dr Auth: Beginning security errors check’  
Found KDC <KDC DC> for domain <DNS Name of AD domain> in site <site name>  
Checking machine account for DC <DC name> on DC <DC Name>  
* Missing SPN :LDAP/<hostname>.<DNS domain name>/<DNS domain name>  
* Missing SPN :LDAP/<hostname>.<DNS domain name>  
* Missing SPN :LDAP/<hostname>  
* Missing SPN :LDAP/<hostname>.<DNS domain name>/<NetBIOS domain name>  
* Missing SPN :LDAP/bba727ef—be4e—477d—9796—63b6cee3bSf.<forest root domain DN>  
* SPN found :E3514235—4B06—I1D1—ABØ4-00c04fc2dcd2/<NTDS Settings object GUID>/<forest root domain DNS name>  
* Missing SPN :HOST/<hostname>.<DNS domain name>/<DNS domain name>  
* SPN found :HOST/<hostname>.<DNS domain name>  
* SPN found :HOST/<hostname>  
* Missing SPN :HOST/<hostname>.<DNS domain name>/<NetBIOS domain name>  
* Missing SPN :GC/<hostname>.<DNS domain name>/<DNS domain name>  
Unable to verify the machine account (<DN path for Dc machine account>) for <DC Name> on <DC name>.  
  
```  
  
## See Also  
 [Troubleshooting Active Directory operations that fail with error 5: Access is denied](http://support.microsoft.com/kb/2002013)   
 [How the Active Directory Replication Model Works](http://technet.microsoft.com/library/cc772726\(WS.10\).aspx)   
 [repsFrom, RepsFrom](http://msdn.microsoft.com/library/cc228409\(PROT.13\).aspx)