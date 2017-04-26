---
ms.assetid: b11f7a65-ec7b-4c11-8dc4-d7cabb54cd94
title: Troubleshooting Active Directory Replication Problems
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Troubleshooting Active Directory Replication Problems

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>Active Directory replication problems can have several different sources. For example, Domain Name System (DNS) problems, networking issues, or security problems can all cause Active Directory replication to fail. </para>
    <para>The rest of this topic explains tools and a general methodology to fix Active Directory replication errors. For a hands-on lab that demonstrates how to troubleshoot Active Directory replication problems, see <externalLink><linkText>TechNet Virtual Lab: Troubleshooting Active Directory Replication Errors</linkText><linkUri>http://go.microsoft.com/?linkid=9844718</linkUri></externalLink>. </para>
    <para>The following subtopics cover symptoms, causes, and how to resolve specific replication errors:</para>
    <list class="bullet">
      <listItem>
        <para>
          <externalLink>
            <linkText>Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)</linkText>
            <linkUri>http://technet.microsoft.com/library/cc949124(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Fixing Replication Security Problems</linkText>
            <linkUri>http://technet.microsoft.com/library/cc949132(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)</linkText>
            <linkUri>http://technet.microsoft.com/library/cc949133(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Fixing Replication Connectivity Problems (Event ID 1925)</linkText>
            <linkUri>http://technet.microsoft.com/library/cc949131(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Fixing Replication Topology Problems (Event ID 1311)</linkText>
            <linkUri>http://technet.microsoft.com/library/cc949129(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Verify DNS Functionality to Support Directory Replication</linkText>
            <linkUri>http://technet.microsoft.com/library/dd728017(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 8614 The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-8614-the-active-directory-cannot-replicate-with-this-server-because-the-time-since-the-last-replication-with-this-server-has-exceeded-the-tombstone-lifetime(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 8524 The DSA operation is unable to proceed because of a DNS lookup failure</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-8524-the-dsa-operation-is-unable-to-proceed-because-of-a-dns-lookup-failure(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 8456 or 8457 The source | destination server is currently rejecting replication requests</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-8456-the-source-server-is-currently-rejecting-replication-requests-or-replication-error-8457-the-destination-server-is-currently-rejecting-replication-requests(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 8453 Replication access was denied</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-8453-replication-access-was-denied(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 8452 The naming context is in the process of being removed or is not replicated from the specified server</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-8452-the-naming-context-is-in-the-process-of-being-removed-or-is-not-replicated-from-the-specified-server(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 5 Access is denied</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-5-access-is-denied(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error -2146893022 The target principal name is incorrect</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-2146893022-the-target-principal-name-is-incorrect(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 1753 There are no more endpoints available from the endpoint mapper</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-1753-there-are-no-more-endpoints-available-from-the-endpoint-mapper(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 1722 The RPC server is unavailable</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-1722-the-rpc-server-is-unavailable(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 1396 Logon Failure The target account name is incorrect</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-1396-logon-failure-the-target-account-name-is-incorrect(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 1256 The remote system is not available</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-1256-the-remote-system-is-not-available(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 1127 While accessing the hard disk, a disk operation failed even after retries</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-1127-while-accessing-the-hard-disk-a-disk-operation-failed-even-after-retries(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 8451 The replication operation encountered a database error</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-8451-the-replication-operation-encountered-a-database-error(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
      <listItem>
        <para>
          <externalLink>
            <linkText>Replication error 8606 Insufficient attributes were given to create an object</linkText>
            <linkUri>http://technet.microsoft.com/library/replication-error-8606-insufficient-attributes-were-given-to-create-an-object(WS.10).aspx</linkUri>
          </externalLink>
        </para>
      </listItem>
    </list>
<para><embeddedLabel>In this topic</embeddedLabel></para><list class="nobullet"><listItem><para><link xlink:href="13964079-3aaa-4551-9140-9687b333e752#BKMK_Intro">Introduction and resources for troubleshooting Active Directory replication</link></para></listItem><listItem><para><link xlink:href="#BKMK_event_tool">Event and tool solution recommendations</link></para></listItem><listItem><para><link xlink:href="#BKMK_ruling_out">Ruling out intentional disruptions or hardware failures</link></para></listItem><listItem><para><link xlink:href="#BKMK_root_causes">Root causes</link></para></listItem><listItem><para><link xlink:href="#BKMK_general_approach">General approach to fixing problems</link></para></listItem><listItem><para><link xlink:href="#BKMK_using_repadmin">Using Repadmin to retrieve replication status</link></para></listItem><listItem><para><link xlink:href="#BKMK_problems_resolutions">Replication problems and resolutions</link></para></listItem><listItem><para><link xlink:href="#BKMK_event_messages">Event messages that indicate Active Directory replication problems</link></para></listItem></list></introduction>
  <section address="BKMK_Intro">
    <title>Introduction and resources for troubleshooting Active Directory replication</title>
    <content>
      <para>Inbound or outbound replication failure causes Active Directory objects that represent the replication topology, replication schedule, domain controllers, users, computers, passwords, security groups, group memberships, and Group Policy to be inconsistent between domain controllers. Directory inconsistency and replication failure cause either operational failures or inconsistent results, depending on the domain controller that is contacted for the operation, and can prevent the application of Group Policy and access control permissions. Active Directory Domain Services (AD DS) depends on network connectivity, name resolution, authentication and authorization, the directory database, the replication topology, and the replication engine. When the root cause of a replication problem is not immediately obvious, determining the cause among the many possible causes requires systematic elimination of probable causes. </para>
      <para>For a UI-based tool to help monitor replication and diagnose errors, see <externalLink><linkText>Active Directory Replication Status Tool</linkText><linkUri>http://www.microsoft.com/download/details.aspx?id=30005</linkUri></externalLink>. There is also a <externalLink><linkText>hands-on lab</linkText><linkUri>http://go.microsoft.com/?linkid=9844718</linkUri></externalLink> that demonstrates how to use Active Directory Replication Status and other tools to troubleshoot errors. </para>
      <para>For a comprehensive document that describes how you can use the Repadmin tool to troubleshoot Active Directory replication is available; see Monitoring and Troubleshooting Active Directory Replication Using Repadmin (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=122830</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=122830</linkUri></externalLink>).</para>
      <para>For information about how Active Directory replication works, see the following technical references:</para>
      <list class="bullet">
        <listItem>
          <para>Active Directory Replication Model Technical Reference (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=65958</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=65958</linkUri></externalLink>)</para>
        </listItem>
        <listItem>
          <para>Active Director Replication Topology Technical Reference (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=93578</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=93578</linkUri></externalLink>)</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_event_tool">
    <title>Event and tool solution recommendations</title>
    <content>
      <para>Ideally, the red (Error) and yellow (Warning) events in the Directory Service event log suggest the specific constraint that is causing replication failure on the source or destination domain controller. If the event message suggests steps for a solution, try the steps that are described in the event. The Repadmin tool and other diagnostic tools also provide information that can help you resolve replication failures. </para>
      <para>For detailed information about using Repadmin for troubleshooting replication problems, see Monitoring and Troubleshooting Active Directory Replication Using Repadmin (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=122830</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=122830</linkUri></externalLink>).</para>
    </content>
  </section>
  <section address="BKMK_ruling_out">
    <title>Ruling out intentional disruptions or hardware failures</title>
    <content>
      <para>Sometimes replication errors occur because of intentional disruptions. For example, when you troubleshoot Active Directory replication problems, rule out intentional disconnections and hardware failures or upgrades first.</para>
    </content>
    <sections>
      <section>
        <title>Intentional disconnections</title>
        <content>
          <para>If replication errors are reported by a domain controller that is attempting replication with a domain controller that has been built in a staging site and is currently offline awaiting its deployment in the final production site (a remote site, such as a branch office), you can account for those replication errors. To avoid separating a domain controller from the replication topology for extended periods, which causes continuous errors until the domain controller is reconnected, consider adding such computers initially as member servers and using the install from media (IFM) method to install Active Directory Domain Services (AD DS). You can use the Ntdsutil command-line tool to create installation media that you can store on removable media (CD, DVD, or other media) and ship to the destination site. Then, you can use the installation media to install AD DS on the domain controllers at the site, without the use of replication. For more information about IFM, see <link xlink:href="3dc846c2-ec2b-4413-9a96-2b134bb18f93">Installing an Additional Domain Controller by Using IFM</link>.</para>
        </content>
      </section>
      <section>
        <title>Hardware failures or upgrades</title>
        <content>
          <para>If replication problems occur as a result of hardware failure (for example, failure of a motherboard, disk subsystem, or hard drive), notify the server owner so that the hardware problem can be resolved.</para>
          <para>Periodic hardware upgrades can also cause domain controllers to be out of service. Ensure that your server owners have a good system of communicating such outages in advance.</para>
        </content>
      </section>
      <section>
        <title>Firewall configuration</title>
        <content>
          <para>By default, Active Directory replication remote procedure calls (RPCs) occur dynamically over an available port through the RPC Endpoint Mapper (RPCSS) on port 135. Make sure that Windows Firewall with Advanced Security and other firewalls are configured properly to allow for replication. For information about specifying the port for Active Directory replication and port settings, see article 224196 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=22578</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=22578</linkUri></externalLink>). For information about the ports that Active Directory replication uses, see Active Directory Replication Tools and Settings (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=123774</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=123774</linkUri></externalLink>). For information about managing Active Directory replication over firewalls, see Active Directory Replication over Firewalls (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=123775</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=123775</linkUri></externalLink>).</para>
        </content>
      </section>
    </sections>
  </section>
  <section>
    <title>Responding to failure of an outdated server running Windows 2000 Server</title>
    <content>
      <para>If a domain controller running Windows 2000 Server has failed for longer than the number of days in the tombstone lifetime, the solution is always the same: </para>
      <list class="ordered">
        <listItem>
          <para>Move the server from the corporate network to a private network.</para>
        </listItem>
        <listItem>
          <para>Either forcefully remove Active Directory or reinstall the operating system.</para>
        </listItem>
        <listItem>
          <para>Remove the server metadata from Active Directory so that the server object cannot be revived. </para>
        </listItem>
      </list>
      <alert class="note">
        <para>You can use a script to clean up server metadata on most Windows operating systems. For information about using this script, see Remove Active Directory Domain Controller Metadata (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=123599</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=123599</linkUri></externalLink>). By default, NTDS Settings objects that are deleted are revived automatically for a period of 14 days. Therefore, if you do not remove server metadata (use Ntdsutil or the script mentioned previously to perform metadata cleanup), the server metadata is reinstated in the directory, which prompts replication attempts to occur. In this case, errors will be logged persistently as a result of the inability to replicate with the missing domain controller.</para>
      </alert>
    </content>
  </section>
  <section address="BKMK_root_causes">
    <title>Root causes</title>
    <content>
      <para>If you rule out intentional disconnections, hardware failures, and outdated Windows 2000 domain controllers, the remainder of replication problems almost always have one of the following root causes: </para>
      <list class="bullet">
        <listItem>
          <para>Network connectivity: The network connection might be unavailable, or network settings are not configured properly.</para>
        </listItem>
        <listItem>
          <para>Name resolution: DNS misconfigurations are a common cause of replication failures.</para>
        </listItem>
        <listItem>
          <para>Authentication and authorization: Authentication and authorization problems cause "Access denied" errors when a domain controller tries to connect to its replication partner.</para>
        </listItem>
        <listItem>
          <para>Directory database (store): The directory database might not be able to process transactions fast enough to keep up with replication time-outs.</para>
        </listItem>
        <listItem>
          <para>Replication engine: If intersite replication schedules are too short, replication queues might be too large to process in the time that is required by the outbound replication schedule. In this case, replication of some changes can be stalled indefinitelypotentially, long enough to exceed the tombstone lifetime.</para>
        </listItem>
        <listItem>
          <para>Replication topology: Domain controllers must have intersite links in AD DS that map to real wide area network (WAN) or virtual private network (VPN) connections. If you create objects in AD DS for the replication topology that are not supported by the actual site topology of your network, replication that requires the misconfigured topology fails.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_general_approach">
    <title>General approach to fixing problems</title>
    <content>
      <para>Use the following general approach to fixing replication problems: </para>
      <list class="ordered">
        <listItem>
          <para>Monitor replication health daily, or use Repadmin.exe to retrieve replication status daily.</para>
        </listItem>
        <listItem>
          <para>Attempt to resolve any reported failure in a timely manner by using the methods that are described in event messages and this guide. If software might be causing the problem, uninstall the software before you continue with other solutions.</para>
        </listItem>
        <listItem>
          <para>If the problem that is causing replication to fail cannot be resolved by any known methods, remove AD DS from the server and then reinstall AD DS. For more information about reinstalling AD DS, see Decommissioning a Domain Controller (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=128290</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=128290</linkUri></externalLink>).</para>
        </listItem>
        <listItem>
          <para>If AD DS cannot be removed normally while the server is connected to the network, use one of the following methods to resolve the problem:</para>
          <list class="bullet">
            <listItem>
              <para>Force AD DS removal in Directory Services Restore Mode (DSRM), clean up server metadata, and then reinstall AD DS.</para>
            </listItem>
            <listItem>
              <para>Reinstall the operating system, and rebuild the domain controller.</para>
            </listItem>
          </list>
          <para>For more information about forcing removal of AD DS, see Forcing the Removal of a Domain Controller (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=128291</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=128291</linkUri></externalLink>).</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_using_repadmin">
    <title>Using Repadmin to retrieve replication status</title>
    <content>
      <para>Replication status is an important way for you to evaluate the status of the directory service. If replication is working without errors, you know the domain controllers that are online. You also know that the following systems and services are working:</para>
      <list class="bullet">
        <listItem>
          <para>DNS infrastructure</para>
        </listItem>
        <listItem>
          <para>Kerberos authentication protocol</para>
        </listItem>
        <listItem>
          <para>Windows Time service (W32time)</para>
        </listItem>
        <listItem>
          <para>Remote procedure call (RPC)</para>
        </listItem>
        <listItem>
          <para>Network connectivity</para>
        </listItem>
      </list>
      <para>Use Repadmin to monitor replication status daily by running a command that assesses the replication status of all the domain controllers in your forest. The procedure generates a .csv file that you can open in Microsoft Excel and filter for replication failures.</para>
      <para>You can use the following procedure to retrieve the replication status of all domain controllers in the forest. </para>
      <para>
        <embeddedLabel>Requirements</embeddedLabel>
      </para>
      <list class="bullet">
        <listItem>
          <para>Membership in <embeddedLabel>Enterprise Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
        </listItem>
        <listItem>
          <para>Tools: </para>
          <para>Repadmin.exe </para>
          <para>Excel (Microsoft Office)</para>
        </listItem>
      </list>
      <procedure>
        <title>To generate a repadmin /showrepl spreadsheet for domain controllers</title>
        <steps class="ordered">
          <step>
            <content>
              <para>Open a Command Prompt as an administrator: On the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, provide Enterprise Admins credentials, if required, and then click <ui>Continue</ui>. </para>
            </content>
          </step>
          <step>
            <content>
              <para>At the command prompt, type the following command, and then press ENTER:</para>
              <para>
                <codeInline>repadmin /showrepl * /csv &gt;showrepl.csv</codeInline>
              </para>
            </content>
          </step>
          <step>
            <content>
              <para>Open Excel.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Click the <ui>Office</ui> button, click <ui>Open</ui>, navigate to <ui>showrepl.csv</ui>, and then click <ui>Open</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Hide or delete column <ui>A</ui> as well as the <ui>Transport Type</ui> column, as follows:</para>
            </content>
          </step>
          <step>
            <content>
              <para>Select a column that you want to hide or delete.</para>
              <list class="bullet">
                <listItem>
                  <para>To hide the column, right-click the column, and then click <ui>Hide</ui>.</para>
                  <para>Or</para>
                </listItem>
                <listItem>
                  <para>To delete the column, right-click the selected column, and then click <ui>Delete</ui>.</para>
                </listItem>
              </list>
            </content>
          </step>
          <step>
            <content>
              <para>Select row 1 beneath the column heading row. On the <ui>View</ui> tab, click <ui>Freeze Panes</ui>, and then click <ui>Freeze Top Row</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Select the entire spreadsheet. On the <ui>Data</ui> tab, click <ui>Filter</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>In the <ui>Last Success Time</ui> column, click the down arrow, and then click <ui>Sort Ascending</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>In the <ui>Source DC</ui> column, click the filter down arrow, point to <ui>Text Filters</ui>, and then click <ui>Custom Filter</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>In the <ui>Custom AutoFilter</ui> dialog box, under <ui>Show rows where</ui>, click <ui>does not contain</ui>. In the adjacent text box, type <userInput>del</userInput> to eliminate from view the results for deleted domain controllers.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Repeat step 11 for the <ui>Last Failure Time</ui> column, but use the value <ui>does not equal</ui>, and then type the value <userInput>0</userInput>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Resolve replication failures.</para>
            </content>
          </step>
        </steps>
      </procedure>
      <para>For every domain controller in the forest, the spreadsheet shows the source replication partner, the time that replication last occurred, and the time that the last replication failure occurred for each naming context (directory partition). By using <ui>Autofilter</ui> in Excel, you can view the replication health for working domain controllers only, failing domain controllers only, or domain controllers that are the least or most current, and you can see the replication partners that are replicating successfully.</para>
    </content>
  </section>
  <section address="BKMK_problems_resolutions">
    <title>Replication problems and resolutions</title>
    <content>
      <para>Replication problems are reported in event messages and in various error messages that occur when an application or service attempts an operation. Ideally, these messages are collected by your monitoring application or when you retrieve replication status.</para>
      <para>Most replication problems are identified in the event messages that are logged in the Directory Service event log. Replication problems might also be identified in the form of error messages in the output of the <system>repadmin /showrepl</system> command. </para>
    </content>
    <sections>
      <section>
        <title>repadmin /showrepl error messages that indicate replication problems</title>
        <content>
          <para>To identify Active Directory replication problems, use the <system>repadmin /showrepl</system> command, as described in the previous section. The following table shows error messages that this command generates, along with the root causes of the errors and links to topics that provide solutions for the errors.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD colspan="1">
                  <para>Repadmin error</para>
                </TD>
                <TD colspan="1">
                  <para>Root cause</para>
                </TD>
                <TD colspan="1">
                  <para>Solution</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD colspan="1">
                  <para>The time since last replication with this server has exceeded the tombstone lifetime.</para>
                </TD>
                <TD colspan="1">
                  <para>A domain controller has failed inbound replication with the named source domain controller long enough for a deletion to have been tombstoned, replicated, and garbage-collected from AD DS.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="eee53935-a1f0-4c65-9386-e0f5d97bdb6b">Event ID 2042: It has been too long since this machine replicated</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>No inbound neighbors.</para>
                </TD>
                <TD colspan="1">
                  <para>If no items appear in the "Inbound Neighbors" section of the output that is generated by <system>repadmin /showrepl</system>, the domain controller was not able to establish replication links with another domain controller.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b1afb017-b3de-41e4-9c5c-481a702a3faa">Fixing Replication Connectivity Problems (Event ID 1925)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Access is denied.</para>
                </TD>
                <TD colspan="1">
                  <para>A replication link exists between two domain controllers, but replication cannot be performed properly as a result of an authentication failure.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b1edd538-2fc4-4a24-bd28-440d02922585">Fixing Replication Security Problems</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Last attempt at &lt;date - time&gt; failed with the "Target account name is incorrect."</para>
                </TD>
                <TD colspan="1">
                  <para>This problem can be related to connectivity, DNS, or authentication issues.</para>
                  <para>If this is a DNS error, the local domain controller could not resolve the globally unique identifier (GUID)-based DNS name of its replication partner.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b506eb78-51ad-4be2-b205-85756cabe766">Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)</link>
                  </para>
                  <para>
                    <link xlink:href="b1edd538-2fc4-4a24-bd28-440d02922585">Fixing Replication Security Problems</link>
                  </para>
                  <para>
                    <link xlink:href="b1afb017-b3de-41e4-9c5c-481a702a3faa">Fixing Replication Connectivity Problems (Event ID 1925)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>LDAP Error 49.</para>
                </TD>
                <TD colspan="1">
                  <para>The domain controller computer account might not be synchronized with the Key Distribution Center (KDC).</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b1edd538-2fc4-4a24-bd28-440d02922585">Fixing Replication Security Problems</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Cannot open LDAP connection to local host</para>
                </TD>
                <TD colspan="1">
                  <para>The administration tool could not contact AD DS.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b506eb78-51ad-4be2-b205-85756cabe766">Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Active Directory replication has been preempted.</para>
                </TD>
                <TD colspan="1">
                  <para>The progress of inbound replication was interrupted by a higher-priority replication request, such as a request that was generated manually with the <system>repadmin /sync</system> command.</para>
                </TD>
                <TD colspan="1">
                  <para>Wait for replication to complete. This informational message indicates normal operation.</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Replication posted, waiting.</para>
                </TD>
                <TD colspan="1">
                  <para>The domain controller posted a replication request and is waiting for an answer. Replication is in progress from this source.</para>
                </TD>
                <TD colspan="1">
                  <para>Wait for replication to complete. This informational message indicates normal operation.</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </content>
      </section>
      <section address="BKMK_event_messages">
        <title>Event messages that indicate Active Directory replication problems</title>
        <content>
          <para>The following table lists common events that might indicate problems with Active Directory replication, along with root causes of the problems and links to topics that provide solutions for the problems.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD colspan="1">
                  <para>Event ID and source</para>
                </TD>
                <TD colspan="1">
                  <para>Root cause</para>
                </TD>
                <TD colspan="1">
                  <para>Solution</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD colspan="1">
                  <para>1311  NTDS KCC</para>
                </TD>
                <TD colspan="1">
                  <para>The replication configuration information in AD DS does not accurately reflect the physical topology of the network.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="9c4c29cf-8aff-4a98-af2a-88df9880f7f6">Fixing Replication Topology Problems (Event ID 1311)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>1388  NTDS Replication</para>
                </TD>
                <TD colspan="1">
                  <para>Strict replication consistency is not in effect, and a lingering object has been replicated to the domain controller.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="53ea71ae-4ecb-475a-935b-cd6a9afff02e">Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>1925  NTDS KCC</para>
                </TD>
                <TD colspan="1">
                  <para>The attempt to establish a replication link for a writable directory partition failed. This event can have different causes, depending on the error.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b1afb017-b3de-41e4-9c5c-481a702a3faa">Fixing Replication Connectivity Problems (Event ID 1925)</link>
                  </para>
                  <para>
                    <link xlink:href="b506eb78-51ad-4be2-b205-85756cabe766">Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>1988  NTDS Replication</para>
                </TD>
                <TD colspan="1">
                  <para>The local domain controller has attempted to replicate an object from a source domain controller that is not present on the local domain controller because it may have been deleted and already garbage-collected. Replication will not proceed for this directory partition with this partner until the situation is resolved.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="53ea71ae-4ecb-475a-935b-cd6a9afff02e">Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>2042  NTDS Replication</para>
                </TD>
                <TD colspan="1">
                  <para>Replication has not occurred with this partner for a tombstone lifetime, and replication cannot proceed.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="53ea71ae-4ecb-475a-935b-cd6a9afff02e">Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>2087  NTDS Replication</para>
                </TD>
                <TD colspan="1">
                  <para>AD DS could not resolve the DNS host name of the source domain controller to an IP address, and replication failed.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b506eb78-51ad-4be2-b205-85756cabe766">Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>2088  NTDS Replication</para>
                </TD>
                <TD colspan="1">
                  <para>AD DS could not resolve the DNS host name of the source domain controller to an IP address, but replication succeeded.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b506eb78-51ad-4be2-b205-85756cabe766">Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)</link>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>5805  Net Logon</para>
                </TD>
                <TD colspan="1">
                  <para>A machine account failed to authenticate, which is usually caused by either multiple instances of the same computer name or the computer name not replicating to every domain controller.</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <link xlink:href="b1edd538-2fc4-4a24-bd28-440d02922585">Fixing Replication Security Problems</link>
                  </para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>For more information about replication concepts, see "Active Directory Replication Technologies" in the Windows Server 2003 Technical Reference (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=41950</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=41950</linkUri></externalLink>).</para>
          <para address="BKMK_InThisSection">
            <embeddedLabel>In this section</embeddedLabel>
          </para>
          <para>See the following topics for detailed information about troubleshooting Active Directory replication problems:</para>
          <para>
            <link xlink:href="53ea71ae-4ecb-475a-935b-cd6a9afff02e">Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)</link>
          </para>
          <para>
            <link xlink:href="b1edd538-2fc4-4a24-bd28-440d02922585">Fixing Replication Security Problems</link>
          </para>
          <para>
            <link xlink:href="b506eb78-51ad-4be2-b205-85756cabe766">Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)</link>
          </para>
          <para>
            <link xlink:href="b1afb017-b3de-41e4-9c5c-481a702a3faa">Fixing Replication Connectivity Problems (Event ID 1925)</link>
          </para>
          <para>
            <link xlink:href="9c4c29cf-8aff-4a98-af2a-88df9880f7f6">Fixing Replication Topology Problems (Event ID 1311)</link>
          </para>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>


