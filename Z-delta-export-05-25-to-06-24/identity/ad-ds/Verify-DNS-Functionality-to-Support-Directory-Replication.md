---
title: Verify DNS Functionality to Support Directory Replication
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
ms.assetid: 2f7cb5ed-4730-49b7-ad76-c1bd240e8650
---
# Verify DNS Functionality to Support Directory Replication
To check Domain Name System \(DNS\) settings that might interfere with Active Directory replication, you can begin by running the basic test that ensures that DNS is operating properly for your domain. After you run the basic test, you can test other aspects of DNS functionality, including resource record registration and dynamic update.  
  
 Although you can run this test of basic DNS functionality on any domain controller, typically you run this test on domain controllers that you think may be experiencing replication issues, for example, domain controllers that report Event IDs 1844, 1925, 2087, or 2088 in the Event Viewer Directory Service DNS log.  
  
## Running the domain controller basic DNS test  
 The basic DNS test checks the following aspects of DNS functionality:  
  
-   **Connectivity:** The test determines whether domain controllers are registered in DNS, can be contacted by the **ping** command, and have Lightweight Directory Access Protocol \/ remote procedure call \(LDAP\/RPC\) connectivity. If the connectivity test fails on a domain controller, no other tests are run against that domain controller. The connectivity test is performed automatically before any other DNS test is run.  
  
-   **Essential services:** The test confirms that the following services are running and available on the tested domain controller: DNS Client service, Net Logon service, Key Distribution Center \(KDC\) service, and DNS Server service \(if DNS is installed on the domain controller\).  
  
-   **DNS client configuration:** The test confirms that DNS servers on all network adapters of the DNS client computer are reachable.  
  
-   **Resource record registrations:** The test confirms that the host \(A\) resource record of each domain controller is registered on at least one of the DNS servers that is configured on the client computer.  
  
-   **Zone and start of authority \(SOA\):** If the domain controller is running the DNS Server service, the test confirms that the Active Directory domain zone and start of authority \(SOA\) resource record for the Active Directory domain zone are present.  
  
-   **Root zone:** Checks whether the root \(.\) zone is present.  
  
 Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
 You can use the following procedure to verify basic DNS functionality.  
  
#### To verify basic DNS functionality  
  
1.  On the domain controller that you want to test or on a domain member computer that has Active Directory Domain Services \(AD DS\) Tools installed, open a command prompt as an administrator. To open a command prompt as an administrator, click **Start**. In **Start Search**, type **Command Prompt**. At the top of the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    dcdiag /test:dns /v /s: <DCName> /DnsBasic f:/dcdiagreport.txt  
    ```  
  
     Substitute the actual distinguished name, NetBIOS name, or DNS name of the domain controller for `<DCName>`. As an alternative, you can test all the domain controllers in the forest by typing `/e:` instead of `/s:`.  
  
     The `/f` switch specifies a file name, which in the previous command is dcdiagreport.txt. If you want to place the file in a location other than the current working directory, you can specify a file path, such as `/f:c:\reports\dcdiagreport.txt`.  
  
3.  Open the dcdiagreport.txt file in Notepad or a similar text editor. To open the file in Notepad, at the command prompt, type `notepad dcdiagreport.txt`, and then press ENTER. If you placed the file in a different working directory, include the path to the file. For example, if you placed the file in c:\\reports, type `notepad c:\reports\dcdiagreport.txt`, and then press ENTER.  
  
4.  Scroll to the Summary table near the bottom of the file.  
  
5.  Note the names of all the domain controllers that report “Warn” or “Fail” status in the Summary table.  
  
6.  Try to determine if there is a problem domain controller by finding the detailed breakout section by searching for the string “DC: *DCName*,” where *DCName* is the actual name of the domain controller.  
  
7.  If you see obvious configuration changes that are required, make them, as appropriate. For example, if you notice that one of your domain controllers has an obviously incorrect IP address, you can correct it. Then, rerun the test.  
  
8.  To validate the configuration changes, rerun the `Dcdiag /test:DNS /v` command with the `/e:` or `/s:` switch, as appropriate. If you do not have IP version 6 \(IPv6\) enabled on the domain controller, you should expect the host \(AAAA\) validation portion of the test to fail, but if you are not using IPv6 on your network, these records are not necessary.  
  
## Verifying resource record registration  
 The destination domain controller uses the DNS alias \(CNAME\) resource record to locate its source domain controller replication partner. Although domain controllers running Windows Server \(starting with Windows Server 2003 with Service Pack 1 \(SP1\)\) can locate source replication partners by using fully qualified domain names \(FQDNs\)—or, if that fails, NetBIOS names—the presence of the alias \(CNAME\) resource record is expected and should be verified for proper DNS functioning.  
  
 You can use the following procedure to verify resource record registration, including alias \(CNAME\) resource record registration.  
  
#### To verify resource record registration  
  
1.  Open a command prompt as an administrator. To open a command prompt as an administrator, click **Start**. In **Start Search**, type **Command Prompt**. At the top of the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  You can use the Dcdiag tool to verify registration of all the resource records that are essential for domain controller location by running the **dcdiag \/test:dns \/DnsRecordRegistration** command.  
  
 This command verifies registration of the following resource records in DNS:  
  
-   **alias \(CNAME\):** the globally unique identifier \(GUID\)\-based resource record that locates a replication partner  
  
-   **host \(A\):** the host resource record that contains the IP address of the domain controller  
  
-   **LDAP SRV:** the service \(SRV\) resource records that locate LDAP servers  
  
-   **GC SRV:** the service \(SRV\) resource records that locate global catalog servers  
  
-   **PDC SRV:** the service \(SRV\) resource records that locate primary domain controller \(PDC\) emulator operations masters  
  
 You can use the following procedure to verify alias \(CNAME\) resource record registration alone.  
  
#### To verify alias \(CNAME\) resource record registration  
  
1.  Open the DNS snap\-in. To open DNS, click **Start**. In **Start Search**, type **dnsmgmt.msc**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that it displays the action you want, and then click **Continue**.  
  
2.  Use the DNS snap\-in to locate any domain controller that is running the DNS Server service, where the server hosts the DNS zone with the same name as the Active Directory domain of the domain controller.  
  
3.  In the console tree, click the zone that is named \_msdcs.*Dns\_Domain\_Name*.  
  
4.  In the details pane, verify that the following resource records are present: an alias \(CNAME\) resource record that is named Dsa\_Guid.\_msdcs.*Dns\_Domain\_Name* and a corresponding host \(A\) resource record for the name of the DNS server.  
  
 If the alias \(CNAME\) resource record is not registered, verify that dynamic update is functioning properly. Use the test in the following section to verify dynamic update.  
  
## Verifying dynamic update  
 If the basic DNS test shows that resource records do not exist in DNS, use the dynamic update test to determine why the Net Logon service did not register the resource records automatically. To verify that the Active Directory domain zone is configured to accept secure dynamic updates and to perform registration of a test record \(\_dcdiag\_test\_record\), use the following procedure. The test record is deleted automatically after the test.  
  
#### To verify dynamic update  
  
1.  Open a command prompt as an administrator. To open a command prompt as an administrator, click **Start**. In **Start Search**, type **Command Prompt**. At the top of the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    dcdiag /test:dns /v /s:<DCName> /DnsDynamicUpdate  
    ```  
  
     Substitute the distinguished name, NetBIOS name, or DNS name of the domain controller for `<DCName>`. As an alternative, you can test all the domain controllers in the forest by typing `/e:` instead of `/s:`. If you do not have IPv6 enabled on the domain controller, you should expect the host \(AAAA\) resource record portion of the test to fail, which is a normal condition when IPv6 is not enabled.  
  
 If secure dynamic updates are not configured, you can use the following procedure to configure them.  
  
#### To enable secure dynamic updates  
  
1.  Open the DNS snap\-in. To open DNS, click **Start**. In **Start Search**, type **dnsmgmt.msc**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that it displays the action you want and then click **Continue**.  
  
2.  In the console tree, right\-click the applicable zone, and then click **Properties**.  
  
3.  On the **General** tab, verify that the zone type is **Active Directory–integrated**.  
  
4.  In **Dynamic Updates**, click **Secure only**.  
  
## Registering DNS resource records  
 If DNS resource records do not appear in DNS for the source domain controller, you have verified dynamic updates, and you want to register DNS resource records immediately, you can force registration manually by using the following procedure. The Net Logon service on a domain controller registers the DNS resource records that are required for the domain controller to be located on the network. The DNS Client service registers the host \(A\) resource record that the alias \(CNAME\) record points to.  
  
#### To register DNS resource records manually  
  
1.  Open a command prompt as an administrator. To open a command prompt as an administrator, click **Start**. In **Start Search**, type **Command Prompt**. At the top of the **Start**, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  To initiate registration of domain controller locator resource records manually on the source domain controller, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net stop net logon & net start net logon  
    ```  
  
3.  To initiate registration of the host \(A\) resource record manually, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    ipconfig /flushdns & ipconfig /registerdns  
    ```  
  
4.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    dcdiag /test:dns /v /s:<DCName>  
    ```  
  
     Substitute the distinguished name, NetBIOS name, or DNS name of the domain controller for `<DCName>`. Review the output of the test to ensure that the DNS tests passed. If you do not have IPv6 enabled on the domain controller, you should expect the host \(AAAA\) resource record portion of the test to fail, which is a normal condition when IPv6 is not enabled.