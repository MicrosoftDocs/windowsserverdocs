---
ms.assetid: 4d47ebd2-e0ac-4f14-96fd-211a13a1ce11
title: Event ID 2042 - It has been too long since this machine replicated
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Event ID 2042: It has been too long since this machine replicated

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>If a domain controller has not replicated with its partner for longer than a tombstone lifetime, it is possible that a lingering object problem exists on one or both domain controllers. The tombstone lifetime in an Active Directory forest determines how long a deleted object (called a "tombstone") is retained in Active Directory Domain Services (AD DS). The tombstone lifetime is determined by the value of the <system>tombstoneLifetime</system> attribute on the Directory Service object in the configuration directory partition. </para>

    <para>When the condition that causes Event ID 2042 to be logged occurs, inbound replication with the source partner is stopped on the destination domain controller and Event ID 2042 is logged in the Directory Service event log. The event identifies the source domain controller and the appropriate steps to take to either remove the outdated domain controller or remove lingering objects and restore replication from the source domain controller.</para>
    <para>The following is an example of the event text: </para>
    <code>
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Date: &lt;Time&gt;
Event ID: 2042
Task Category: Replication 
Level: Error
Keywords: Classic
User: ANONYMOUS LOGON
Computer: &lt;domain controller hostname&gt;
Description:
It has been too long since this machine last replicated with the 
named source machine. The time between replications with this source 
has exceeded the tombstone lifetime. Replication has been stopped 
with this source. 
The reason that replication is not allowed to continue is that 
the two machine's views of deleted objects may now be different. 
The source machine may still have copies of objects that have 
been deleted (and garbage collected) on this machine. If they 
were allowed to replicate, the source machine might return 
objects which have already been deleted. 
Time of last successful replication:
&lt;date&gt; &lt;time&gt; 
Invocation ID of source: 
&lt;Invocation ID&gt; 
Name of source: 
&lt;GUID&gt;._msdcs.&lt;domain&gt; 
Tombstone lifetime (days):
&lt;TSL number in days&gt;

The replication operation has failed.

User Action:

Determine which of the two machines was disconnected from the 
forest and is now out of date. You have three options: 

1. Demote or reinstall the machine(s) that were disconnected. 
2. Use the "repadmin /removelingeringobjects" tool to remove 
inconsistent deleted objects and then resume replication. 
3. Resume replication. Inconsistent deleted objects may be introduced. 
You can continue replication by using the following registry key. 
Once the systems replicate once, it is recommended that you remove 
the key to reinstate the protection. 
Registry Key: 
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters\Allow Replication With Divergent and Corrupt Partner</code>
    <para>The <system>repadmin /showrepl</system> command also reports error 8416, as shown in the following example:</para>
    <code>Source: Default-First-Site-Name\DC1
******* &lt;number&gt; CONSECUTIVE FAILURES since &lt;date&gt; &lt;time&gt;
Last error: 8614 (0x21a6):
            The Active Directory Domain Services cannot replicate with this server 
because the time since the last replication with this server has 
exceeded the tombstone lifetime.</code>
  </introduction>
  <section>
    <title>Cause</title>
    <content>
      <para>There are a few potential causes for the logging of Event ID 2042, which include the following:</para>
      <list class="bullet">
        <listItem>
          <para> Windows Server 2003 pre-Service Pack 1 (SP1) domain controllers having a software issue that causes replication failures</para>
        </listItem>
        <listItem>
          <para>Replication failures that have existed longer than the configured tombstone lifetime value</para>
        </listItem>
        <listItem>
          <para>System time advance or rollback that causes objects to be deleted on some?but not all?domain controllers</para>
        </listItem>
      </list>
    </content>
  </section>
  <section>
    <title>Resolution</title>
    <content>
      <para>The resolution of this issue depends on the actual cause or causes of the issue. To resolve this issue, check for each of the following conditions:</para>
      <list class="ordered">
        <listItem>
          <para>Determine whether there are any Windows Server 2003 domain controllers that do not have at least SP1 applied. If you find any such domain controllers, ensure that you update them to at least SP1 to resolve this issue.</para>
        </listItem>
        <listItem>
          <para>Determine whether there are any replication failures that have been allowed to exceed the tombstone lifetime of the forest. Typically, the tombstone lifetime of the forest is 60 to 180 days by default. The event message indicates the tombstone lifetime of the forest as it is currently configured. </para>
          <para>Run the command <system>repadmin /showrepl</system> to determine whether a replication issue exists. If you suspect that there is a replication issue, see <externalLink><linkText>Monitoring and Troubleshooting Active Directory Replication Using Repadmin</linkText><linkUri>https://go.microsoft.com/fwlink/?linkid=140631</linkUri></externalLink> (https://go.microsoft.com/fwlink/?linkid=140631) for information about how to resolve the issue.</para>
        </listItem>
        <listItem>
          <para>Determine whether there are lingering objects. You can do this by running the command <system>repadmin /removelingeringobjects</system> in advisory mode, as described in the following procedure. </para>
        </listItem>
      </list>
      <para>You must first identify an authoritative domain controller. If you know that a specific domain controller has the latest changes, you can use that domain controller as the authoritative domain controller. Otherwise, you may have to complete the following procedure on multiple domain controllers until you identify a domain controller that you believe has the latest changes. Then, you can use that domain controller as your authoritative domain controller.</para>
      <para>Membership in <system>Domain Admins</system>, or equivalent, is the minimum required to complete this procedure. <token>gen_win7_review_detailincludes></para>
      <procedure>
        <title>Identify lingering objects</title>
        <steps class="ordered">
          <step>
            <content>
              <para>On a domain controller that you expect to have the latest changes, open an elevated Command Prompt window. <token>cmd_eleincludes></para>
            </content>
          </step>
          <step>
            <content>
              <para>Run the <system>repadmin</system> command in advisory mode. This makes it possible for you to assess the lingering objects without actually removing anything. The syntax of the command is <codeInline>repadmin /removelingeringobjects &lt;DestDCName&gt; &lt;SourceDCGUID&gt; &lt;LDAPPartition&gt; /advisory_mode</codeInline>. Substitute the following items for the placeholders in the command syntax:</para>
              <list class="bullet">
                <listItem>
                  <para>
                    <codeInline>DestDCName</codeInline>?The host name of the domain controller that you are targeting for lingering object clean-up. For example, if you want to remove lingering objects from DC1 in the contoso.com domain, substitute <codeInline>dc1.contoso.com</codeInline> for <codeInline>&lt;DestDCName&gt;</codeInline>.</para>
                </listItem>
                <listItem>
                  <para>
                    <codeInline>SourceDCGUID</codeInline>?Run the command <codeInline>repadmin /showrepl AuthDCname |more</codeInline>, where <codeInline>AuthDCname</codeInline> is the host name of the domain controller that you selected as authoritative. Substitute the first <codeInline>DSA object GUID</codeInline> that appears for <codeInline>&lt;SourceDCGUID&gt;</codeInline>.</para>
                </listItem>
                <listItem>
                  <para>
                    <codeInline>LDAPPartition</codeInline>?The Lightweight Directory Access Partition (LDAP) name of the partition that you are targeting. For example, if the lingering objects are in the domain partition of the contoso.com domain, substitute <codeInline>dc=contoso,dc=com</codeInline> for <codeInline>&lt;LDAPPartition&gt;</codeInline>.</para>
                </listItem>
              </list>
              <para>The following is an example command for identifying lingering objects: <codeInline>repadmin /removelingeringobjects dc1.contoso.com 4a8717eb-8e58-456c-995a-c92e4add7e8e dc=contoso,dc=com /advisory_mode</codeInline></para>
            </content>
          </step>
        </steps>
      </procedure>
      <para>If necessary, repeat the previous steps on additional domain controllers until you determine the domain controller that you believe has the latest changes. Use that domain controller as your authoritative domain controller. Run the <codeInline>repadmin /removelingeringobjects</codeInline> command without the <codeInline>/advisory_mode</codeInline> switch to actually remove lingering objects. Repeat the command as necessary to remove lingering objects from each domain controller that has them.</para>
    </content>
    <sections>
      <section>
        <title>Restart replication following Event ID 2042</title>
        <content>
          <para>The normal state of replication is one in which changes to objects and their attributes converge in a way that domain controllers receive the latest information. When a partner domain controller is discovered to be passing older changes, the changes from the partner are deemed to be "divergent." The partner is said to be engaged in "divergent replication." Domain controllers will normally stop replicating with any partner that is deemed to be engaged in divergent replication. </para>
          <para>After you remove all lingering objects, you can restart replication on the domain controller that logged the event by editing the registry.</para>
          <alert class="caution">
            <para>Restart replication only after you have removed all lingering objects. <token>Registrincludes></para>
          </alert>
          <para>Membership in <embeddedLabel>Domain Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure. <token>gen_win7_review_detailincludes></para>
          <procedure>
            <title>Use Repadmin to restart replication following Event ID 2042</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Open an elevated Command Prompt. <token>cmd_eleincludes></para>
                </content>
              </step>
              <step>
                <content>
                  <para>At the command prompt, type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>repadmin /regkey &lt;hostname&gt; +allowDivergent</codeInline>
                  </para>
                  <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
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
                          <para>/regkey</para>
                        </TD>
                        <TD>
                          <para>Enables (<system>+</system>) and disables (<system>-</system>) the value for the <embeddedLabel>Strict Replication Consistency</embeddedLabel> registry entry in <embeddedLabel>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSParameters</embeddedLabel>.</para>
                        </TD>
                      </tr>
                      <tr>
                        <TD>
                          <para>&lt;hostname&gt;</para>
                        </TD>
                        <TD>
                          <para>Substitute the name of a single domain controller, or use <system>*</system> to apply the change to all domain controllers in the forest. For the domain controller name, you can use the Domain Name System (DNS) name, the distinguished name of the domain controller computer object, or the distinguished name of the domain controller server object.</para>
                        </TD>
                      </tr>
                      <tr>
                        <TD>
                          <para>+allowDivergent</para>
                        </TD>
                        <TD>
                          <para>Enables replication to start again with the replication partner that had lingering objects. You should run this command only after all the lingering objects have been removed. After replication is running properly again, use the <system>-allowDivergent</system> switch to prevent divergent replication from occurring. </para>
                        </TD>
                      </tr>
                    </tbody>
                  </table>
                  <alert class="note">
                    <para>If you did not use <system>*</system> to apply the change to all domain controllers, repeat step 2 for every domain controller on which you want to allow divergent replication.</para>
                  </alert>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
      <section>
        <title>Reset the registry to protect against outdated replication</title>
        <content>
          <para>When you are satisfied that lingering objects have been removed and replication has occurred successfully from the source domain controller, use Repadmin to prevent divergent replication. To do prevent divergent replication, run the command <codeInline>repadmin /regkey &lt;hostname&gt; -allowDivergent</codeInline>. For example, to restrict divergent replication on a domain controller named DC1 in the Fabrikam.com domain, run the command <codeInline>repadmin /regkey dc1.fabrikam.com -allowDivergent</codeInline>.</para>
          <alert class="note">
            <para>If you did not remove all the lingering objects, attempting replication might result in replication of a lingering object. If strict replication consistency is enabled on the destination domain controller, replication with the source domain controller will be blocked again.</para>
          </alert>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>


