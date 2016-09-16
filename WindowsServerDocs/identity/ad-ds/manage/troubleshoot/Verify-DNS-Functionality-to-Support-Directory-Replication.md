---
title: Verify DNS Functionality to Support Directory Replication
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: identity-adds
ms.author: markvi
  
ms.tgt_pltfrm: na
ms.assetid: 2f7cb5ed-4730-49b7-ad76-c1bd240e8650
author: Femila
---
# Verify DNS Functionality to Support Directory Replication

>Applies To: Windows Server Technical Preview

<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>To check Domain Name System (DNS) settings that might interfere with Active Directory replication, you can begin by running the basic test that ensures that DNS is operating properly for your domain. After you run the basic test, you can test other aspects of DNS functionality, including resource record registration and dynamic update.</para>
    <para>Although you can run this test of basic DNS functionality on any domain controller, typically you run this test on domain controllers that you think may be experiencing replication issues, for example, domain controllers that report Event IDs 1844, 1925, 2087, or 2088 in the Event Viewer Directory Service DNS log.</para>
  </introduction>
  <section>
    <title>Running the domain controller basic DNS test</title>
    <content>
      <para>The basic DNS test checks the following aspects of DNS functionality:</para>
      <list class="bullet">
        <listItem>
          <para>
            <embeddedLabel>Connectivity:</embeddedLabel> The test determines whether domain controllers are registered in DNS, can be contacted by the <system>ping</system> command, and have Lightweight Directory Access Protocol / remote procedure call (LDAP/RPC) connectivity. If the connectivity test fails on a domain controller, no other tests are run against that domain controller. The connectivity test is performed automatically before any other DNS test is run.</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Essential services:</embeddedLabel> The test confirms that the following services are running and available on the tested domain controller: DNS Client service, Net Logon service, Key Distribution Center (KDC) service, and DNS Server service (if DNS is installed on the domain controller).</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>DNS client configuration:</embeddedLabel> The test confirms that DNS servers on all network adapters of the DNS client computer are reachable.</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Resource record registrations:</embeddedLabel> The test confirms that the host (A) resource record of each domain controller is registered on at least one of the DNS servers that is configured on the client computer.</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Zone and start of authority (SOA):</embeddedLabel> If the domain controller is running the DNS Server service, the test confirms that the Active Directory domain zone and start of authority (SOA) resource record for the Active Directory domain zone are present.</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Root zone:</embeddedLabel> Checks whether the root (.) zone is present.</para>
        </listItem>
      </list>
      <para>Membership in <embeddedLabel>Enterprise Admins</embeddedLabel>, or equivalent, is the minimum required to complete these procedures. <token>review_detailincludes></para>
      <para>You can use the following procedure to verify basic DNS functionality.</para>
      <procedure>
        <title>To verify basic DNS functionality</title>
        <steps class="ordered">
          <step>
            <content>
              <para>On the domain controller that you want to test or on a domain member computer that has Active Directory Domain Services (AD DS) Tools installed, open a command prompt as an administrator. To open a command prompt as an administrator, click <ui>Start</ui>. In <ui>Start Search</ui>, type <userInput>Command Prompt</userInput>. At the top of the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, confirm that the action it displays is what you want, and then click <ui>Continue</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>At the command prompt, type the following command, and then press ENTER: </para>
              <code>dcdiag /test:dns /v /s: &lt;DCName&gt; /DnsBasic f:/dcdiagreport.txt</code>
              <para>Substitute the actual distinguished name, NetBIOS name, or DNS name of the domain controller for <codeInline>&lt;DCName&gt;</codeInline>. As an alternative, you can test all the domain controllers in the forest by typing <codeInline>/e:</codeInline> instead of <codeInline>/s:</codeInline>. </para>
              <para>The <codeInline>/f</codeInline> switch specifies a file name, which in the previous command is dcdiagreport.txt. If you want to place the file in a location other than the current working directory, you can specify a file path, such as <codeInline>/f:c:reportsdcdiagreport.txt</codeInline>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Open the dcdiagreport.txt file in Notepad or a similar text editor. To open the file in Notepad, at the command prompt, type <codeInline>notepad dcdiagreport.txt</codeInline>, and then press ENTER. If you placed the file in a different working directory, include the path to the file. For example, if you placed the file in c:reports, type <codeInline>notepad c:reportsdcdiagreport.txt</codeInline>, and then press ENTER.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Scroll to the Summary table near the bottom of the file. </para>
            </content>
          </step>
          <step>
            <content>
              <para>Note the names of all the domain controllers that report "Warn" or "Fail" status in the Summary table.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Try to determine if there is a problem domain controller by finding the detailed breakout section by searching for the string "DC: <placeholder>DCName</placeholder>," where <placeholder>DCName</placeholder> is the actual name of the domain controller.</para>
            </content>
          </step>
          <step>
            <content>
              <para>If you see obvious configuration changes that are required, make them, as appropriate. For example, if you notice that one of your domain controllers has an obviously incorrect IP address, you can correct it. Then, rerun the test.</para>
            </content>
          </step>
          <step>
            <content>
              <para>To validate the configuration changes, rerun the <codeInline>Dcdiag /test:DNS /v</codeInline> command with the <codeInline>/e:</codeInline> or <codeInline>/s:</codeInline> switch, as appropriate. If you do not have IP version 6 (IPv6) enabled on the domain controller, you should expect the host (AAAA) validation portion of the test to fail, but if you are not using IPv6 on your network, these records are not necessary.</para>
            </content>
          </step>
        </steps>
      </procedure>
    </content>
  </section>
  <section>
    <title>Verifying resource record registration</title>
    <content>
      <para>The destination domain controller uses the DNS alias (CNAME) resource record to locate its source domain controller replication partner. Although domain controllers running Windows Server (starting with Windows Server 2003 with Service Pack 1 (SP1)) can locate source replication partners by using fully qualified domain names (FQDNs)or, if that fails, NetBIOS namesthe presence of the alias (CNAME) resource record is expected and should be verified for proper DNS functioning. </para>
      <para>You can use the following procedure to verify resource record registration, including alias (CNAME) resource record registration.</para>
      <procedure>
        <title>To verify resource record registration</title>
        <steps class="ordered">
          <step>
            <content>
              <para>Open a command prompt as an administrator. To open a command prompt as an administrator, click <ui>Start</ui>. In <ui>Start Search</ui>, type <userInput>Command Prompt</userInput>. At the top of the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, confirm that the action it displays is what you want, and then click <ui>Continue</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>You can use the Dcdiag tool to verify registration of all the resource records that are essential for domain controller location by running the <system>dcdiag /test:dns /DnsRecordRegistration</system> command.</para>
            </content>
          </step>
        </steps>
      </procedure>
      <para>This command verifies registration of the following resource records in DNS:</para>
      <list class="bullet">
        <listItem>
          <para>
            <embeddedLabel>alias (CNAME):</embeddedLabel> the globally unique identifier (GUID)-based resource record that locates a replication partner</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>host (A):</embeddedLabel> the host resource record that contains the IP address of the domain controller</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>LDAP SRV:</embeddedLabel> the service (SRV) resource records that locate LDAP servers</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>GC SRV:</embeddedLabel> the service (SRV) resource records that locate global catalog servers</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>PDC SRV:</embeddedLabel> the service (SRV) resource records that locate primary domain controller (PDC) emulator operations masters</para>
        </listItem>
      </list>
      <para>You can use the following procedure to verify alias (CNAME) resource record registration alone.</para>
      <procedure>
        <title>To verify alias (CNAME) resource record registration</title>
        <steps class="ordered">
          <step>
            <content>
              <para>Open the DNS snap-in. To open DNS, click <ui>Start</ui>. In <ui>Start Search</ui>, type <userInput>dnsmgmt.msc</userInput>, and then press ENTER. If the <ui>User Account Control</ui> dialog box appears, confirm that it displays the action you want, and then click <ui>Continue</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Use the DNS snap-in to locate any domain controller that is running the DNS Server service, where the server hosts the DNS zone with the same name as the Active Directory domain of the domain controller.</para>
            </content>
          </step>
          <step>
            <content>
              <para>In the console tree, click the zone that is named _msdcs.<placeholder>Dns_Domain_Name</placeholder>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>In the details pane, verify that the following resource records are present: an alias (CNAME) resource record that is named Dsa_Guid._msdcs.<placeholder>Dns_Domain_Name</placeholder> and a corresponding host (A) resource record for the name of the DNS server.</para>
            </content>
          </step>
        </steps>
      </procedure>
      <para>If the alias (CNAME) resource record is not registered, verify that dynamic update is functioning properly. Use the test in the following section to verify dynamic update.</para>
    </content>
  </section>
  <section>
    <title>Verifying dynamic update</title>
    <content>
      <para>If the basic DNS test shows that resource records do not exist in DNS, use the dynamic update test to determine why the Net Logon service did not register the resource records automatically. To verify that the Active Directory domain zone is configured to accept secure dynamic updates and to perform registration of a test record (_dcdiag_test_record), use the following procedure. The test record is deleted automatically after the test.</para>
      <procedure>
        <title>To verify dynamic update</title>
        <steps class="ordered">
          <step>
            <content>
              <para>Open a command prompt as an administrator. To open a command prompt as an administrator, click <ui>Start</ui>. In <ui>Start Search</ui>, type <userInput>Command Prompt</userInput>. At the top of the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, confirm that the action it displays is what you want, and then click <ui>Continue</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>At the command prompt, type the following command, and then press ENTER: </para>
              <code>dcdiag /test:dns /v /s:&lt;DCName&gt; /DnsDynamicUpdate</code>
              <para>Substitute the distinguished name, NetBIOS name, or DNS name of the domain controller for <codeInline>&lt;DCName&gt;</codeInline>. As an alternative, you can test all the domain controllers in the forest by typing <codeInline>/e:</codeInline> instead of <codeInline>/s:</codeInline>. If you do not have IPv6 enabled on the domain controller, you should expect the host (AAAA) resource record portion of the test to fail, which is a normal condition when IPv6 is not enabled.</para>
            </content>
          </step>
        </steps>
      </procedure>
      <para>If secure dynamic updates are not configured, you can use the following procedure to configure them.</para>
      <procedure>
        <title>To enable secure dynamic updates</title>
        <steps class="ordered">
          <step>
            <content>
              <para>Open the DNS snap-in. To open DNS, click <ui>Start</ui>. In <ui>Start Search</ui>, type <userInput>dnsmgmt.msc</userInput>, and then press ENTER. If the <ui>User Account Control</ui> dialog box appears, confirm that it displays the action you want and then click <ui>Continue</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>In the console tree, right-click the applicable zone, and then click <ui>Properties</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>On the <ui>General</ui> tab, verify that the zone type is <ui>Active Directory-integrated</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>In <ui>Dynamic Updates</ui>, click <ui>Secure only</ui>.</para>
            </content>
          </step>
        </steps>
      </procedure>
    </content>
  </section>
  <section>
    <title>Registering DNS resource records</title>
    <content>
      <para>If DNS resource records do not appear in DNS for the source domain controller, you have verified dynamic updates, and you want to register DNS resource records immediately, you can force registration manually by using the following procedure. The Net Logon service on a domain controller registers the DNS resource records that are required for the domain controller to be located on the network. The DNS Client service registers the host (A) resource record that the alias (CNAME) record points to.</para>
      <procedure>
        <title>To register DNS resource records manually</title>
        <steps class="ordered">
          <step>
            <content>
              <para>Open a command prompt as an administrator. To open a command prompt as an administrator, click <ui>Start</ui>. In <ui>Start Search</ui>, type <userInput>Command Prompt</userInput>. At the top of the <ui>Start</ui>, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, confirm that the action it displays is what you want, and then click <ui>Continue</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>To initiate registration of domain controller locator resource records manually on the source domain controller, at the command prompt, type the following command, and then press ENTER:</para>
              <code>net stop net logon &amp; net start net logon</code>
            </content>
          </step>
          <step>
            <content>
              <para>To initiate registration of the host (A) resource record manually, at the command prompt, type the following command, and then press ENTER: </para>
              <code>ipconfig /flushdns &amp; ipconfig /registerdns</code>
            </content>
          </step>
          <step>
            <content>
              <para>At the command prompt, type the following command, and then press ENTER: </para>
              <code>dcdiag /test:dns /v /s:&lt;DCName&gt;</code>
              <para>Substitute the distinguished name, NetBIOS name, or DNS name of the domain controller for <codeInline>&lt;DCName&gt;</codeInline>. Review the output of the test to ensure that the DNS tests passed. If you do not have IPv6 enabled on the domain controller, you should expect the host (AAAA) resource record portion of the test to fail, which is a normal condition when IPv6 is not enabled.</para>
            </content>
          </step>
        </steps>
      </procedure>
    </content>
  </section>
  <relatedTopics />
</developerConceptualDocument>


