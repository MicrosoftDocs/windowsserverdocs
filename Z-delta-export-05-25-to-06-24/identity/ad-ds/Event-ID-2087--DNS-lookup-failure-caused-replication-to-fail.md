---
title: Event ID 2087: DNS lookup failure caused replication to fail
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
ms.assetid: 85b1d179-f53e-4f95-b0b8-5b1c096a8076
---
# Event ID 2087: DNS lookup failure caused replication to fail
This problem typically occurs when a Domain Name System \(DNS\) lookup failure causes replication to fail. When a destination domain controller receives Event ID 2087 in the Directory Service event log, attempts to resolve the globally unique identifier \(GUID\) in the alias \(CNAME\) resource record, the fully qualified domain name \(FQDN\), and the NetBIOS name to the IP address of the source domain controller have all failed. Failure to locate the source replication partner prevents replication with that source until the problem is fixed.  
  
 The following is an example of the event text:  
  
```  
Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: 3/9/2008  11:00:21 AM  
Event ID: 2087  
Task Category: DS RPC Client   
Level: Error  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: DC3.contoso.com  
Description:  
Active Directory could not resolve the following DNS host name of   
the source domain controller to an IP address. This error prevents   
additions, deletions and changes in Active Directory Domain Services from replicating   
between one or more domain controllers in the forest. Security   
groups, group policy, users and computers and their passwords will   
be inconsistent between domain controllers until this error is   
resolved, potentially affecting logon authentication and access   
to network resources.   
  
Source domain controller:   
  DC2   
Failing DNS host name:   
  b0069e56-b19c-438a-8a1f-64866374dd6e._msdcs.contoso.com   
  
NOTE: By default, only up to 10 DNS failures are shown for any   
given 12 hour period, even if more than 10 failures occur.  To   
log all individual failure events, set the following diagnostics   
registry value to 1:   
  
Registry Path:   
HKLM\System\CurrentControlSet\Services\NTDS\Diagnostics\22 DS RPC Client   
  
User Action:   
  
1) If the source domain controller is no longer functioning or   
its operating system has been reinstalled with a different   
computer name or NTDSDSA object GUID, remove the source domain   
controller's metadata with ntdsutil.exe, using the steps outlined   
in MSKB article 216498.   
  
2) Confirm that the source domain controller is running Active   
Directory Domain Services and is accessible on the network by typing   
"net view \\<source DC name>" or "ping <source DC name>".   
  
3) Verify that the source domain controller is using a valid   
DNS server for DNS services, and that the source domain   
controller's host record and CNAME record are correctly   
registered, using the DNS Enhanced version of DCDIAG.EXE   
available on http://www.microsoft.com/dns   
  
dcdiag /test:dns   
  
4) Verify that this destination domain controller is using   
a valid DNS server for DNS services, by running the DNS Enhanced   
version of DCDIAG.EXE command on the console of the destination   
domain controller, as follows:   
  
dcdiag /test:dns   
  
5) For further analysis of DNS error failures see KB 824449:   
http://support.microsoft.com/?kbid=824449   
  
Additional Data   
Error value:   
11004 The requested name is valid, but no data of the requested   
type was found.  
  
```  
  
## Diagnosis  
 Failure to resolve the current alias \(CNAME\) resource record of the source domain controller to an IP address can have the following causes:  
  
-   The source domain controller is powered off, is offline, or resides on an isolated network, and Active Directory and DNS data for the offline domain controller has not been deleted to indicate that the domain controller is inaccessible.  
  
-   One of the following conditions exists:  
  
    -   The source domain controller has not registered its resource records in DNS.  
  
    -   The destination domain controller is configured to use an invalid DNS server.  
  
    -   The source domain controller is configured to use an invalid DNS server.  
  
    -   The DNS server that the source domain controller uses does not host the correct zones, or the zones are not configured to accept dynamic updates.  
  
    -   The direct DNS servers that the destination domain controller queries cannot resolve the IP address of the source domain controller as a result of nonexistent or invalid forwarders or delegations.  
  
-   Active Directory Domain Services \(AD DS\) has been removed on the source domain controller and then reinstalled with the same IP address, but knowledge of the new NTDS Settings GUID has not reached the destination domain controller.  
  
-   AD DS has been removed on the source domain controller and then reinstalled with a different IP address, but the current host address \(A\) resource record for the IP address of the source domain controller is either not registered or does not exist on the DNS servers that the destination domain controller queries as a result of replication latency or replication error.  
  
-   The operating system of the source domain controller has been reinstalled with a different computer name, but its metadata either has not been removed or has been removed and not yet inbound\-replicated by the destination domain controller.  
  
## Resolution  
 First, determine whether the source domain controller is functioning. If the source domain controller is not functioning, remove its remaining metadata from AD DS.  
  
 If the source domain controller is functioning, continue with procedures to diagnose and solve the DNS problem, as necessary:  
  
-   Use Dcdiag to diagnose DNS problems.  
  
-   Register DNS service \(SRV\) resource records plus host records.  
  
-   Synchronize replication between the source and destination domain controllers.  
  
-   Verify consistency of the NTDS Settings GUID.  
  
### Determine whether a domain controller is functioning  
 To determine whether the source domain controller is functioning, use the following test.  
  
 **Requirements**  
  
-   Membership in the **Domain Users** group in the domain of the domain controller, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   Tools: Net view  
  
##### To determine whether a domain controller is functioning  
  
-   To confirm that the domain controller is running AD DS and is accessible on the network, at a command prompt type the following command, and then press ENTER:  
  
     `net view \\<SourceDomainControllerName>`  
  
     where `<SourceDomainControllerName>` is the NetBIOS name of the domain controller.  
  
 This command displays the Netlogon and SYSVOL shares, indicating that the server is functioning as a domain controller. If this test shows that the domain controller is not functioning on the network, determine the nature of the disconnection and whether the domain controller can be recovered or whether its metadata must be removed from AD DS manually. If the domain controller is not functioning and cannot be restored, use the procedure in the following section, "Clean up domain controller metadata," to delete the data that is associated with that server from AD DS.  
  
### Clean up domain controller metadata  
 If tests show that the domain controller is no longer functioning but you still see objects representing the domain controller in the Active Directory Sites and Services snap\-in, replication will continue to be attempted, and you must remove these objects from AD DS manually. You must use the Ntdsutil tool to clean up \(delete\) the metadata for the defunct domain controller.  
  
 If the defunct domain controller is the last domain controller in the domain, you should also remove the metadata for the domain. Allow sufficient time for all global catalog servers in the forest to inbound\-replicate the domain deletion before you promote a new domain with the same name.  
  
 The process for cleaning up metadata is improved in the version of Ntdsutil that is included with Windows Server 2003 Service Pack 1 \(SP1\). Instructions for cleaning up metadata with the Windows Server 2003 version of Ntdsutil and the Windows Server 2003 SP1 version of Ntdsutil are provided in the following procedure.  
  
 **Requirements**  
  
-   Membership in Enterprise Admins, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   Tools: Ntdsutil \(System32 command\-line tool\)  
  
##### To clean up server metadata  
  
1.  Open a Command Prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `ntdsutil`  
  
3.  At the `ntdsutil:` command prompt, type the following command, and then press ENTER:  
  
     `metadata cleanup`  
  
4.  Perform metadata cleanup as follows:  
  
    > [!NOTE]  
    >  If you are removing domain metadata as well as server metadata, skip the following procedure and use the procedure that begins at step a.  
  
    -   If you are performing server metadata cleanup only and you are using the version of Ntdsutil.exe that is included with Windows Server 2003 SP1, at the `metadata cleanup:` command prompt, type the following command, and then press ENTER:  
  
         `remove selected server <ServerName>`  
  
         Or  
  
         `remove selected server <ServerName1> on <ServerName2>`  
  
        |Parameter|Description|  
        |---------------|-----------------|  
        |\<ServerName\>, \<ServerName1\>|The distinguished name of the domain controller whose metadata you want to remove, in the form cn\=\<ServerName\>,cn\=Servers,cn\=\<SiteName\>, cn\=Sites,cn\=Configuration,dc\=\<ForestRootDomain\>|  
        |\<ServerName2\>|The DNS name of the domain controller to which you want to connect and from which you want to remove server metadata|  
  
    -   If you are performing metadata cleanup by using the version of Ntdsutil.exe that is included with Windows Server 2003 with no service pack, or if you are performing both domain metadata cleanup and server metadata cleanup, perform metadata cleanup as follows:  
  
    1.  At the `metadata cleanup:` prompt, type the following command, and then press ENTER:  
  
         `connection`  
  
    2.  At the `server connections:` prompt, type the following command, and then press ENTER:  
  
         `connect to server <Server>`  
  
    3.  At the `connection:` prompt, type the following command, and then press ENTER:  
  
         `quit`  
  
    4.  At the `metadata cleanup:` prompt, type the following command, and then press ENTER:  
  
         `select operation target`  
  
    5.  At the `select operation target:` prompt, type the following command, and then press ENTER:  
  
         `list sites`  
  
    6.  A numbered list of sites appears. Type the following command, and then press ENTER:  
  
         `select site <SiteNumber>`  
  
    7.  At the `select operation target:` prompt, type the following command, and then press ENTER:  
  
         `list domains in site`  
  
    8.  A numbered list of domains in the selected site appears. Type the following command, and then press ENTER:  
  
         `select domain <DomainNumber>`  
  
    9. At the `select operation target:` prompt, type the following command, and then press ENTER:  
  
         `list servers in site`  
  
    10. A numbered list of servers in a domain and site is displayed. Type the following command, and then press ENTER:  
  
         `select server <ServerNumber>`  
  
    11. At the `select operation target:` prompt, type the following command, and then press ENTER:  
  
         `quit`  
  
    12. At the `metadata cleanup:` prompt, type the following command, and then press ENTER:  
  
         `remove selected server`  
  
    13. If the server whose metadata you have removed is the last domain controller in the domain and you want to remove the domain metadata, at the `metadata cleanup:` prompt, type the following command, and then press ENTER:  
  
         `remove selected domain`  
  
         Metadata for the domain that you selected in step h is removed.  
  
    14. At the `metadata cleanup:` and `ntdsutil:` prompts, type `quit`, and then press ENTER.  
  
        |Parameter|Description|  
        |---------------|-----------------|  
        |\<Server\>|The DNS name of a domain controller that you want to connect to|  
        |\<SiteNumber\>|The number that is associated with the site of the server that you want to clean up, which appears in the list|  
        |\<DomainNumber\>|The number that is associated with the domain of the server that you want to clean up, which appears in the list|  
        |\<ServerNumber\>|The number that is associated with the server that you want to clean up, which appears in the list|  
  
### Use Dcdiag to diagnose DNS problems  
 If the domain controller is functioning online, continue by using the Dcdiag tool to diagnose and fix DNS problems that might be interfering with Active Directory replication.  
  
 Use the following procedures to complete this process:  
  
-   Verify connectivity and basic DNS functionality.  
  
-   Verify registration of the alias \(CNAME\) resource record in DNS.  
  
-   Verify and enable secure dynamic updates.  
  
 Before you begin these procedures, gather the following information, which is contained in the Event ID 2087 message text:  
  
-   The FQDN of the source domain controller and destination domain controller  
  
-   The IP address of the source domain controller  
  
 The updated version of Dcdiag that is included in Windows Support Tools in Windows Server 2003 SP1 contains tests that provide consolidated and improved testing of basic and advanced DNS features. You can use this tool to diagnose basic DNS functionality and dynamic updates.  
  
 When you use the enhanced SP1 version of Dcdiag for DNS testing, there are specific requirements that do not apply to all Dcdiag tests.  
  
 **Requirements**  
  
-   Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete the new DNS tests that are available in the SP1 version of Dcdiag. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   Tools: Dcdiag.exe  
  
-   Operating system:  
  
    -   You can run the enhanced version of Dcdiag on computers running the following operating systems:  
  
         Windows XP Professional  
  
         Windows Server 2003  
  
         Windows Server 2003 with SP1  
  
    -   You can run the new Dcdiag DNS tests against Microsoft DNS servers that are installed on domain controllers running the following operating systems:  
  
         Windows 2000 Server with Service Pack 3 \(SP3\)  
  
         Windows 2000 Server with Service Pack 4 \(SP4\)  
  
         Windows Server 2003  
  
         Windows Server 2003 with SP1  
  
> [!NOTE]  
>  You can use the **\/f:** switch in Dcdiag commands to save the output to a text file. Use **\/f:***FileName* to generate the file in the location that is indicated in *FileName*, for example, **\/f:c:\\Test\\DnsTest.txt**.  
  
#### Verify basic DNS functionality  
 To verify the settings that might interfere with Active Directory replication, you can begin by running the basic DNS test that ensures that DNS is operating properly on the domain controller.  
  
 The basic DNS test checks the following:  
  
-   Connectivity: The test determines whether domain controllers are registered in DNS, can be contacted by PING, and have Lightweight Directory Access Protocol \/ remote procedure call \(LDAP\/RPC\) connectivity. If the connectivity test fails on a domain controller, no other tests are run against that domain controller. The connectivity test is performed automatically before any other DNS test is run.  
  
-   Essential services: The test confirms that the following services are running and available on the tested domain controller:  
  
    -   DNS Client service  
  
    -   Net Logon service  
  
    -   Key Distribution Center \(KDC\) service  
  
    -   DNS Server service \(if DNS is installed on the domain controller\)  
  
-   DNS client configuration: The test confirms that DNS servers on all adapters are reachable.  
  
-   Resource record registrations: The test confirms that the host \(A\) resource record of each domain controller is registered on at least one of the DNS servers that is configured on the client.  
  
-   Zone and start of authority \(SOA\): If the domain controller is running the DNS Server service, the test confirms that the Active Directory domain zone and start of authority \(SOA\) resource record for the Active Directory domain zone are present.  
  
-   Root zone: Checks whether the root \(.\) zone is present.  
  
###### To verify basic DNS functionality  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:dns /s:<SourceDomainControllerName> /DnsBasic`  
  
     where `<SourceDomainControllerName>` is the distinguished name, NetBIOS name, or DNS name of the domain controller.  
  
     As an alternative, you can test all domain controllers in the forest by typing `/e:` instead of `/s:`.  
  
2.  Copy the report into Notepad or an equivalent text editor.  
  
3.  Scroll to the Summary table near the bottom of the Dcdiag log file.  
  
4.  Note the names of all domain controllers that report “Warn” or “Fail” status in the Summary table.  
  
5.  Find the detailed breakout section for the problem domain controller by searching for the string “DC: \<DomainControllerName\>”.  
  
6.  Make the required configuration changes on DNS clients and DNS servers.  
  
7.  To validate the configuration changes, rerun `Dcdiag /test:DNS` with the `/e:` or `/s:` switch.  
  
 If the basic DNS test shows no errors, continue by verifying that resource records that are used to locate domain controllers are registered in DNS.  
  
#### Verify resource record registration  
 The destination domain controller uses the DNS alias \(CNAME\) resource record to locate its source domain controller replication partner. Although domain controllers running Windows Server 2003 with SP1 can locate source replication partners by using FQDNs—or, if that fails, NetBIOS names—the presence of the alias \(CNAME\) resource record is expected and should be verified for proper DNS functioning.  
  
 You can use Dcdiag to verify registration of all resource records that are essential for domain controller location by using the **dcdiag \/test:dns \/DnsRecordRegistration** test. This test verifies registration of the following resource records in DNS:  
  
-   alias \(CNAME\) \(the GUID\-based resource record that locates a replication partner\)  
  
-   host \(A\) \(the host resource record that contains the IP address of the domain controller\)  
  
-   LDAP SRV \(the service \(SRV\) resource records that locate LDAP servers\)  
  
-   GC SRV \(the service \(SRV\) resource records that locate global catalog servers\)  
  
-   PDC SRV \(the service \(SRV\) resource records that locate primary domain controller \(PDC\) emulator operations masters\)  
  
 As an alternative, you can use the following procedure to check for only the alias \(CNAME\) resource record.  
  
###### To verify alias \(CNAME\) resource record registration  
  
1.  In the DNS snap\-in, locate any domain controller that is running the DNS Server service, where the server hosts the DNS zone with the same name as the Active Directory domain of the domain controller.  
  
2.  In the console tree, click the zone that is named \_msdcs.*Dns\_Domain\_Name*.  
  
    > [!NOTE]  
    >  In Windows 2000 Server DNS, \_msdcs.*Dns\_Domain\_Name* is a subdomain of the DNS zone for the Active Directory domain name. In Windows Server 2003 DNS, \_msdcs.*Dns\_Domain\_Name* is a separate zone.  
  
3.  In the details pane, verify that the following resource records are present:  
  
    -   An alias \(CNAME\) resource record that is named *Dsa\_Guid*.\_msdcs.*Dns\_Domain\_Name*  
  
    -   A corresponding host \(A\) resource record for the name of the DNS server  
  
 If the alias \(CNAME\) resource record is not registered, verify that dynamic updates are functioning properly. Use the test in the following section.  
  
#### Verify dynamic updates  
 If the basic DNS test shows that resource records do not exist in DNS, use the dynamic update test to diagnose why the Net Logon service did not register the resource records automatically. To verify that the Active Directory domain zone is configured to accept secure dynamic updates and to perform registration of a test record \(\_dcdiag\_test\_record\), use the following procedure. The test record is deleted automatically after the test.  
  
###### To verify dynamic updates  
  
-   At a command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:dns /s:<SourceDomainControllerName> /DnsDynamicUpdate`  
  
     where \<SourceDomainControllerName\> is the distinguished name, NetBIOS name, or DNS name of the domain controller.  
  
     As an alternative, you can test all domain controllers by using the `/e:` switch instead of the `/s:` switch.  
  
 If secure dynamic update is not configured, use the following procedure to configure it.  
  
###### To enable secure dynamic updates  
  
1.  Open the DNS snap\-in.  
  
2.  In the console tree, right\-click the applicable zone, and then click **Properties**.  
  
3.  On the **General** tab, verify that the zone type is Active Directory–integrated.  
  
4.  In **Dynamic Updates**, click **Secure only**.  
  
### Register DNS resource records  
 If DNS resource records do not appear in DNS for the source domain controller, you have verified dynamic updates, and you want to register DNS resource records immediately, you can force the registration manually by using the following procedure. The Net Logon service on a domain controller registers the DNS resource records that are required for the domain controller to be located on the network. The DNS Client service registers the host \(A\) resource record that the alias \(CNAME\) record points to.  
  
 **Requirements**  
  
-   Membership in the **Domain Admins** group in the forest root domain or the **Enterprise Admins** group, or equivalent, is the minimum required to complete this procedure.  
  
-   Tools: **net stop\/start**, **ipconfig**  
  
##### To register DNS resource records manually  
  
1.  To initiate registration of domain controller Locator resource records manually on the source domain controller, at a command prompt type the following commands, and then press ENTER after each command:  
  
     `net stop net logon & net start net logon`  
  
2.  To initiate registration of the host A resource record manually, at a command prompt type the following command, and then press ENTER:  
  
     `ipconfig /flushdns & ipconfig /registerdns`  
  
3.  Wait 15 minutes, and then review events in Event Viewer to ensure proper registration of the resource records.  
  
 Repeat the procedure in the "Verify Resource Record Registration" section earlier in this section to verify that the resource records appear in DNS.  
  
### Synchronize replication between the source and destination domain controllers  
 After you complete DNS testing, use the following procedure to synchronize replication on the inbound connection from the source domain controller to the destination domain controller.  
  
 **Requirements**  
  
-   Membership in the **Domain Admins** group in the domain of the destination domain controller, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   Tool: Active Directory Sites and Services  
  
##### To synchronize replication from a source domain controller  
  
1.  Open Active Directory Sites and Services.  
  
2.  In the console tree, double\-click the **Sites** container, double\-click the site of the domain controller to which you want to synchronize replication, double\-click the **Servers** container, double\-click the server object of the domain controller, and then click **NTDS Settings**.  
  
3.  In the details pane, in the **From Server** column, locate the connection object that shows the name of the source domain controller.  
  
4.  Right\-click the appropriate connection object, and then click **Replicate Now**.  
  
5.  Click **OK**.  
  
 If replication does not succeed, use the procedure in the following section to verify consistency of the NTDS Settings GUID.  
  
### Verify consistency of the NTDS Settings GUID  
 If you have performed all DNS tests and other tests and replication does not succeed, use the following procedure to verify that the GUID of the NTDS Settings object that the destination domain controller is using to locate its replication partner matches the GUID that is currently in effect on the source domain controller itself. To perform this test, you view the object GUID as it appears in the local directories of each domain controller.  
  
 **Requirements**  
  
-   Membership in the **Domain Admins** group in the domain of the destination domain controller, or equivalent, is the minimum required to complete this procedure.  
  
-   Tool: Ldp.exe \(Windows Support Tools\)  
  
##### To verify consistency of the NTDS Settings GUID  
  
1.  Click **Start**, click **Run**, type **Ldp**, and then click **OK**.  
  
2.  On the **Connection** menu, click **Connect**.  
  
3.  In the **Connect** dialog box, leave the **Server** box empty.  
  
4.  In **Port**, type **389**, and then click **OK**.  
  
5.  On the **Connection** menu, click **Bind**.  
  
6.  In the **Bind** dialog box, provide Enterprise Admins credentials. If it is not already selected, click **Domain**.  
  
7.  In **Domain**, type the name of the forest root domain, and then click **OK**.  
  
8.  On the **View** menu, click **Tree**.  
  
9. In the **Tree View** dialog box, type:  
  
     **CN\=Configuration,DC\=Forest\_Root\_Domain**  
  
     and then click **OK**.  
  
10. Navigate to the object CN\=NTDS Settings,CN\=*SourceServerName*,CN\=Servers,CN\=*SiteName*, CN\=Sites,CN\=configuration,DC\=*ForestRootDomain*.  
  
11. Double\-click the **NTDS Settings** object and, in the details pane, view the value for the attribute **objectGUID**. Right\-click that value, and then copy it to Notepad.  
  
12. On the **Connection** menu, click **Disconnect**.  
  
13. Repeat steps 2 through 11, but in step 3, type the name of the source domain controller, for example, DC03.  
  
14. In Notepad, compare the values of the two GUIDs.  
  
15. If the values do not match, the destination domain controller must receive replication of the valid GUID. Check the GUID value on other domain controllers and attempt replication on the destination domain controller with a different domain controller that has the correct GUID.  
  
16. If the values match, verify that the GUID matches the GUID in the *Dsa\_Guid*.\_msdcs.*Dns\_Domain\_Name* resource record for the source domain controller, as follows:  
  
    1.  Note the primary DNS servers that each domain controller identifies in the TCP\/IP properties in their Network Settings. All the DNS servers that are listed in the respective TCP\/IP properties should be able to indirectly or directly resolve this alias \(CNAME\) resource record.  
  
    2.  From the servers that are listed, identify the authoritative name server or servers for this domain zone by looking at the server names that are listed for the name server \(NS\) resource records at the root of the zone. \(In the DNS snap\-in, select the forward lookup zone for the root domain, and then view the name server \(NS\) records in the details pane.\)  
  
    3.  On the name server or servers obtained in step b, open the DNS snap\-in, and double\-click the forward lookup zone for the forest root domain name. Double\-click the \_msdcs folder, and note the alias \(CNAME\) resource records that exist for your server name.  
  
    4.  If there are no records present or the records are incorrect, see article 241505 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=69994](http://go.microsoft.com/fwlink/?LinkId=69994)\).