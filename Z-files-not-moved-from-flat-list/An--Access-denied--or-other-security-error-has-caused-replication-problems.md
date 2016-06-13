---
title: An &quot;Access denied&quot; or other security error has caused replication problems
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 282cee9f-abef-43c9-9f33-b2c416cf8c38
author: Femila
---
# An &quot;Access denied&quot; or other security error has caused replication problems
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This problem typically occurs when a replication destination domain controller cannot contact its source replication partner to get Active Directory updates as a result of one or more security errors occurring on the connection between the two domain controllers. You can test and diagnose replication problems that have security causes by using the Dcdiag.exe tool.</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="#BKMK_Cause">Diagnosis</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Solution">Resolution</link>
        </para>
        <list class="bullet">
          <listItem>
            <para>
              <link xlink:href="#BKMK_Test_Security">Test a domain controller for replication security errors</link>
            </para>
          </listItem>
          <listItem>
            <para>
              <link xlink:href="#BKMK_Test_Connection">Test the connection between two domain controllers for replication security errors</link>
            </para>
          </listItem>
        </list>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Cause">
    <title>Diagnosis</title>
    <content>
      <para>A replication destination domain controller cannot contact its source replication partner to get Active Directory updates as a result of one or more security errors occurring on the connection between the two domain controllers.</para>
    </content>
  </section>
  <section address="BKMK_Solution">
    <title>Resolution</title>
    <content>
      <para>Run the replication security error diagnostic test in Dcdiag.</para>
    </content>
    <sections>
      <section address="BKMK_Test_Security">
        <title>Test a domain controller for replication security errors</title>
        <content>
          <para>You can test any or all domain controllers in your forest for security errors. </para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in <embeddedLabel>Enterprise Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tool: Dcdiag.exe </para>
            </listItem>
            <listItem>
              <para>Operating system: The replication security test that is used in this procedure is available in versions of Dcdiag that are included with the following operating systems:</para>
              <list class="bullet">
                <listItem>
                  <para>Windows Server 2003 with Service Pack 1 (SP1)</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003 with Service Pack 2 (SP2)</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003 R2</para>
                </listItem>
                <listItem>
                  <para>
                    <token>nextref_longhorincludes>
                  </para>
                </listItem>
              </list>
            </listItem>
            <listItem>
              <para>Although you can run the enhanced version of Dcdiag from computers running Windows XP Professional and Windows Server 2003 with no service pack installed, you cannot run the replication security test (<system>/test:CheckSecurityError</system>) from these computers.</para>
            </listItem>
            <listItem>
              <para>Target operating systems: </para>
              <para>You can run the Dcdiag replication security tests against domain controllers that are running the following operating systems:</para>
              <list class="bullet">
                <listItem>
                  <para>Windows 2000 Server with Service Pack 3 (SP3)</para>
                </listItem>
                <listItem>
                  <para>Windows 2000 Server with Service Pack 4 (SP4)</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003 with Service Pack 1 (SP1)</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003 R2</para>
                </listItem>
                <listItem>
                  <para>
                    <token>nextref_longhorincludes>
                  </para>
                </listItem>
              </list>
            </listItem>
          </list>
          <procedure>
            <title>To test a domain controller for replication security errors</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Open a Command Prompt as an administrator: On the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, provide Enterprise Admins credentials, if required, and then click <ui>Continue</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>At the command prompt, type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>dcdiag /test:CheckSecurityError /s:&lt;DomainControllerName&gt;</codeInline>
                  </para>
                  <para>where <codeInline>&lt;DomainControllerName&gt;</codeInline> is the Domain Name System (DNS) name, network basic input/output system (NetBIOS) name, or distinguished name of the domain controller on which you want to test.</para>
                  <para>If you do not use the <codeInline>/s:</codeInline> switch, the test is run against the local domain controller. You can also test all domain controllers in the forest by using <codeInline>/e:</codeInline> instead of <codeInline>/s:</codeInline>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Copy the report into Notepad or an equivalent text editor </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Scroll to the Summary table near the bottom of the Dcdiag log file. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Note the names of all domain controllers that reported “Warn” or “Fail” status in the Summary table. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Find the detailed breakout section for the problem domain controller by searching for the string “DC: &lt;DomainControllerName&gt;”. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Make the required configuration changes on the domain controllers.</para>
                  <para>Rerun <codeInline>Dcdiag /test:CheckSecurityError</codeInline> with the <codeInline>/e:</codeInline> or <codeInline>/s:</codeInline> switch to validate the configuration changes.</para>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
      <section address="BKMK_Test_Connection">
        <title>Test the connection between two domain controllers for replication security errors</title>
        <content>
          <para>You can test the connection between two domain controllers in your forest for replication security errors. The domain controller that represents the source of the inbound connection does not have to be an existing source to run this test. That is, a connection object from that domain controller does not have to exist on the destination domain controller. This test is useful in the following scenarios: </para>
          <list class="bullet">
            <listItem>
              <para>A connection exists between a source and a destination, and you receive a security error.</para>
            </listItem>
            <listItem>
              <para>A connection should be created automatically by the Knowledge Consistency Checker (KCC), and you want to test why the connection does not exist.</para>
            </listItem>
            <listItem>
              <para>You are trying to create a connection between two domain controllers, and you receive a security error.</para>
            </listItem>
            <listItem>
              <para>You want to determine whether a connection can be created if you want to add one on this destination from the specified source.</para>
            </listItem>
          </list>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in <embeddedLabel>Domain Admins</embeddedLabel>, or equivalent, is the minimum required to test the connection between domain controllers in your domain. Membership in <embeddedLabel>Enterprise Admins</embeddedLabel>, or equivalent, is the minimum required to test the connection between domain controllers in different domains. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tool: Dcdiag.exe</para>
            </listItem>
            <listItem>
              <para>Operating system: The replication security test that is used in this procedure is available in versions of Dcdiag that are included with the following operating systems: </para>
              <list class="bullet">
                <listItem>
                  <para>Windows Server 2003 with SP1</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003 with SP2</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003 R2</para>
                </listItem>
                <listItem>
                  <para>
                    <token>nextref_longhorincludes>
                  </para>
                </listItem>
              </list>
            </listItem>
            <listItem>
              <para>Although you can run the enhanced version of Dcdiag from computers running Windows XP Professional and Windows Server 2003 with no service pack installed, you cannot run the replication security test (<system>/test:CheckSecurityError</system>) from these computers.</para>
            </listItem>
            <listItem>
              <para>Target operating systems: You can run the Dcdiag replication security tests against domain controllers that are running the following operating systems: </para>
              <list class="bullet">
                <listItem>
                  <para>Windows 2000 Server with SP3</para>
                </listItem>
                <listItem>
                  <para>Windows 2000 Server with SP4</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003 with SP1</para>
                </listItem>
                <listItem>
                  <para>Windows Server 2003 R2</para>
                </listItem>
                <listItem>
                  <para>
                    <token>nextref_longhorincludes>
                  </para>
                </listItem>
              </list>
            </listItem>
          </list>
          <procedure>
            <title>To test the connection between two domain controllers for replication security errors</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Open a Command Prompt as an administrator: On the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, provide Enterprise Admins credentials, if required, and then click <ui>Continue</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>At the command prompt, type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>dcdiag /test:CheckSecurityError /ReplSource:&lt;SourceDomainControllerName&gt;</codeInline>
                  </para>
                  <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
                    <thead>
                      <tr>
                        <TD>
                          <para>Parameter</para>
                        </TD>
                        <TD>
                          <para>Description</para>
                        </TD>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <TD>
                          <para>/test:CheckSecurityError</para>
                        </TD>
                        <TD>
                          <para>Locates security errors or errors that are possibly related to security problems, and performs initial diagnosis of the problem. This command tests the connection between the domain controller on which you run the command and the source replication partner that you specify in &lt;SourceDomainControllerName&gt;.</para>
                        </TD>
                      </tr>
                      <tr>
                        <TD>
                          <para>/ReplSource</para>
                        </TD>
                        <TD>
                          <para>Targets a specified replication source domain controller</para>
                        </TD>
                      </tr>
                      <tr>
                        <TD>
                          <para>&lt;SourceDomainControllerName&gt;</para>
                        </TD>
                        <TD>
                          <para>The DNS name, NetBIOS name, or distinguished name of the real or potential source ("from") server that is represented by a real or potential connection object that you want to test</para>
                        </TD>
                      </tr>
                    </tbody>
                  </table>
                </content>
              </step>
              <step>
                <content>
                  <para>Copy the report into Notepad or an equivalent text editor. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Scroll to the Summary table near the bottom of the Dcdiag log file. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Note the names of all domain controllers that reported “Warn” or “Fail” status in the Summary table </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Find the detailed breakout section for the problem domain controller by searching for the string “DC: &lt;DomainControllerName&gt;”. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Make the required configuration changes on the domain controllers.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Rerun <codeInline>dcdiag /test:CheckSecurityError /ReplSource:&lt;SourceDomainControllerName&gt;</codeInline> to validate configuration changes.</para>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>

