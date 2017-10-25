---
ms.assetid: 4325fe83-dc64-4660-9bf8-fc15fc648c3c
title: Event ID 1925 - Attempt to establish a replication link failed due to connectivity problem
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Event ID 1925: Attempt to establish a replication link failed due to connectivity problem

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>The description text in event ID 1925 reports that the attempt to establish a replication link for the following writable directory partition failed, and the description text provides the distinguished name of the directory partition that the destination is attempting to replicate from the source. The error code in the event gives more specific information about the cause of the problem.</para>
    <para>The following is an example of the event text: </para>
    <code>Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Date: 3/12/2008  8:14:13 AM
Event ID: 1925
Task Category: Knowledge Consistency Checker 
Level: Warning
Keywords: Classic
User: ANONYMOUS LOGON
Computer: DC3.contoso.com
Description:
The attempt to establish a replication link for the following 
writable directory partition failed. 

Directory partition: 
CN=Configuration,DC=contoso,DC=com 
Source domain controller: 
CN=NTDS Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com 
Source domain controller address: 
f8786828-ecf5-4b7d-ad12-8ab60178f7cd._msdcs.contoso.com 
Intersite transport (if any): 
CN=IP,CN=Inter-Site Transports,CN=Sites,CN=Configuration,DC=contoso,DC=com
This domain controller will be unable to replicate with the source 
domain controller until this problem is corrected.

User Action 
Verify if the source domain controller is accessible or network 
connectivity is available. 

Additional Data 
Error value: 
1908 Could not find the domain controller for this domain.</code>
  </introduction>
  <section>
    <title>Diagnosis</title>
    <content>
      <para>When Event ID 1925 contains error 1908, "Could not find the domain controller for this domain," Active Directory replication has failed as a result of a connectivity problem between the domain controller that reported the error and the source domain controller that is named in the event text. </para>
    </content>
  </section>
  <section>
    <title>Resolution</title>
    <content>
      <para>Use the following tests to solve this problem: </para>
      <list class="bullet">
        <listItem>
          <para>
            <link xlink:href="#BKMK_verifyWAN">Verify WAN connectivity</link>
          </para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="#BKMK_MaxPacket">Determine the maximum packet size</link>, and change it if necessary.</para>
        </listItem>
      </list>
    </content>
    <sections>
      <section address="BKMK_verifyWAN">
        <title>Verify WAN connectivity</title>
        <content>
          <para>Verify that there are no basic connectivity problems with the underlying network between the domain controllers, especially if they are separated by a wide area network (WAN) link or firewalls. For information about testing this type of problem, see article 310099 (<externalLink><linkText>https://go.microsoft.com/fwlink/?LinkId=69995</linkText><linkUri>https://go.microsoft.com/fwlink/?LinkId=69995</linkUri></externalLink>) and article 159211 (<externalLink><linkText>https://go.microsoft.com/fwlink/?LinkId=69996</linkText><linkUri>https://go.microsoft.com/fwlink/?LinkId=69996</linkUri></externalLink>) in the Microsoft Knowledge Base).</para>
        </content>
      </section>
      <section address="BKMK_MaxPacket">
        <title>Determine maximum packet size</title>
        <content>
          <para>By default, the Kerberos authentication protocol in Windows 2000, Windows XP, Windows Server 2003, Windows Server 2003 R2, Windows Vista, and <token>nextref_longhorincludes> uses the User Datagram Protocol (UDP) when the data can be fit into packets of less than 2,000 bytes. Any data larger than this value uses TCP to carry the packets. Packets of more than 1,500 bytes are often dropped by a device, such as a firewall on the network. </para>
          <para>To avoid this problem, you can determine the size of packet that your network can accommodate. Then, you can edit the registry so that the maximum number of bytes for using UDP is set to the lowest value that you receive, less 8 bytes to account for header size.</para>
          <para>You can use the <system>ping</system> command to test the size of packets that the network can accommodate. </para>
          <para>Membership in <embeddedLabel>Domain Users</embeddedLabel>, or equivalent, and the <embeddedLabel>Log on locally</embeddedLabel> right on the domain controller are the minimum required to complete this procedure. <token>review_detailincludes></para>
          <procedure>
            <title>To determine the lowest common packet size</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>From the destination domain controller, ping the source domain controller by its IP address. At a command prompt, type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>ping &lt;IP_address&gt; -f -l 1472</codeInline>
                  </para>
                </content>
              </step>
              <step>
                <content>
                  <para>From the source domain controller, use the command in step 1 to ping the destination domain controller by its IP address.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>If the <codeInline>ping</codeInline> command completes in both directions, no additional modification is required.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>If the <codeInline>ping</codeInline> command fails in either direction, monotonically lower the number that you use in the <codeInline>-l</codeInline> parameter until you find the lowest common packet size that works between the source and destination domain controllers.</para>
                </content>
              </step>
            </steps>
          </procedure>
          <alert class="note">
            <para>Dcdiag.exe provides the following method to perform this test: </para>
            <para>
              <codeInline>dcdiag /test:CheckSecurityError /s:&lt;SourceDomainControllerName&gt;</codeInline>
            </para>
          </alert>
          <para>You can edit the registry to set the maximum size of packets to the value that you determined by the PING method, minus 8 bytes to account for header size. As an alternative, you can edit the registry so that the maximum number of bytes for using UDP is always exceeded and therefore Kerberos always uses TCP.</para>
          <para>You can change the default value of 2,000 bytes by modifying the registry entry <embeddedLabel>MaxPacketSize</embeddedLabel> in <embeddedLabel>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetControlLsaKerberosParameters</embeddedLabel>. Use the following procedure to change this registry setting.</para>
          <alert class="caution">
            <para>It is recommended that you do not directly edit the registry unless there is no other alternative. Modifications to the registry are not validated by the registry editor or by Windows before they are applied, and as a result, incorrect values can be stored. This can result in unrecoverable errors in the system. When possible, use Group Policy or other Windows tools, such as Microsoft Management Console (MMC), to accomplish tasks rather than editing the registry directly. If you must edit the registry, use extreme caution.</para>
          </alert>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Credentials: Membership in <embeddedLabel>Domain Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure.</para>
            </listItem>
            <listItem>
              <para>Tool: Regedit.exe</para>
            </listItem>
          </list>
          <procedure>
            <title>To change the maximum packet size</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Click <ui>Start</ui>, click <ui>Run</ui>, type <userInput>regedit</userInput>, and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Navigate to <ui>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetControlLsaKerberosParameters</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Edit?or, if it does not exist in the details pane, create?the entry <embeddedLabel>MaxPacketSize</embeddedLabel> as follows:</para>
                  <list class="ordered">
                    <listItem>
                      <para>To edit the entry if it exists in the details pane:</para>
                      <para>Right-click <ui>MaxPacketSize</ui>, click <ui>Modify</ui>, and then, in the <ui>Value data</ui> box, type <ui>1</ui> to force Kerberos to use TCP, or type the value that you established to lower the value to the appropriate maximum size.</para>
                    </listItem>
                    <listItem>
                      <para>To create the entry if it does not exist in the details pane: </para>
                      <para>Right-click <ui>Parameters</ui>, click <ui>New DWORD Value</ui>, type the name <userInput>MaxPacketSize</userInput>, and then go to step 3a to edit the entry.</para>
                    </listItem>
                  </list>
                </content>
              </step>
              <step>
                <content>
                  <para>Click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>You must restart the domain controller for this change to take effect.</para>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics>
<externalLink><linkText>Monitoring and Troubleshooting Active Directory Replication Using Repadmin</linkText><linkAlternateText>https://go.microsoft.com/fwlink/?LinkId=122830</linkAlternateText><linkUri>https://go.microsoft.com/fwlink/?LinkId=122830</linkUri></externalLink>
</relatedTopics>
</developerConceptualDocument>


