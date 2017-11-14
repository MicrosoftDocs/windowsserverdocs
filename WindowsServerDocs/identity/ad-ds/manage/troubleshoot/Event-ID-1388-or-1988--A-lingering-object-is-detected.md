---
ms.assetid: 24136758-d192-44f3-9c6e-41af70aa1d1c
title: Event ID 1388 or 1988 - A lingering object is detected
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Event ID 1388 or 1988: A lingering object is detected

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>If a destination domain controller logs Event ID 1388 or Event ID 1988, a lingering object has been detected and one of two conditions exists on the destination domain controller: </para>
    <list class="bullet">
      <listItem>
        <para>Event ID 1388: Inbound replication of the lingering object has occurred on the destination domain controller. </para>
      </listItem>
      <listItem>
        <para>Event ID 1988: Inbound replication of the directory partition of the lingering object has been blocked on the destination domain controller. </para>
      </listItem>
    </list>
    <para>
      <embeddedLabel>In this topic</embeddedLabel>
    </para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="#BKMK_1388">Event ID 1388</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_1988">Event ID 1988</link>
        </para>
      </listItem>
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
              <link xlink:href="#BKMK_Identify_GUID">Use Repadmin to identify the GUID of an authoritative domain controller</link>
            </para>
          </listItem>
          <listItem>
            <para>
              <link xlink:href="#BKMK_RemoveLingeringObjects">Use Repadmin to remove lingering objects</link>
            </para>
          </listItem>
        </list>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Enable_Strict">Enable strict replication consistency</link>
        </para>
        <list class="bullet">
          <listItem>
            <para>
              <link xlink:href="#BKMK_Use_Repadmin">Use Repadmin to enable strict replication consistency</link>
            </para>
          </listItem>
          <listItem>
            <para>
              <link xlink:href="#BKMK_Edit_Registry">Use Regedit to enable strict replication consistency</link>
            </para>
          </listItem>
        </list>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Ensure_Strict">Ensure that strict replication consistency is enabled for newly promoted domain controllers</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_1388">
    <title>Event ID 1388</title>
    <content>
      <para>This event indicates that a destination domain controller that does not have strict replication consistency enabled received a request to update an object that does not reside in the local copy of the Active Directory database. In response, the destination domain controller requested the full object from the source replication partner. In this way, a lingering object was replicated to the destination domain controller. Therefore, the lingering object was reintroduced into the directory. </para>
      <alert class="important">
        <para>When Event ID 1388 occurs, if either the source domain controller (the replication partner that is outbound-replicating the lingering object) or the destination domain controller (the inbound replication partner that reports Event ID 1388) is running Windows 2000 Server, you cannot use the Repadmin tool to remove lingering objects. For information about how to remove lingering objects in this case, see article 314282 in the Microsoft Knowledge Base (<externalLink><linkText>https://go.microsoft.com/fwlink/?LinkId=41410</linkText><linkUri>https://go.microsoft.com/fwlink/?LinkId=41410</linkUri></externalLink>). The procedures and information in this article apply to the removal of lingering objects from global catalog servers as well as from domain controllers that are not global catalog servers. </para>
      </alert>
      <para>The event text identifies the source domain controller and the outdated (lingering) object. The following is an example of the event text:</para>
      <code>
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Date: 5/3/2008  3:34:01 PM
Event ID: 1388
Task Category: Replication 
Level: Error
Keywords: Classic
User: ANONYMOUS LOGON
Computer: DC3.contoso.com
Description:
Another domain controller (DC) has attempted to replicate into this DC an 
object which is not present in the local Active Directory Domain Services database.  The 
object may have been deleted and already garbage collected (a tombstone 
lifetime or more has past since the object was deleted) on this DC. The 
attribute set included in the update request is not sufficient to create 
the object. The object will be re-requested with a full attribute set 
and re-created on this DC.

Source DC (Transport-specific network address):
4a8717eb-8e58-456c-995a-c92e4add7e8e._msdcs.contoso.com 
Object:
CN=InternalApps,CN=Users,DC=contoso,DC=com 
Object GUID:
a21aa6d9-7e8a-4a8f-bebf-c3e38d0b733a 
Directory partition:
DC=contoso,DC=com 
Destination highest property USN:
20510 
User Action:
Verify the continued desire for the existence of this object. To 
discontinue re-creation of future similar objects, the following 
registry key should be created.

Registry Key:
HKLM\System\CurrentControlSet\Services\NTDS\Parameters\Strict Replication Consistency</code>
    </content>
  </section>
  <section address="BKMK_1988">
    <title>Event ID 1988</title>
    <content>
      <para>This event indicates that a destination domain controller that has strict replication consistency enabled has received a request to update an object that does not exist in its local copy of the Active Directory database. In response, the destination domain controller blocked replication of the directory partition containing that object from that source domain controller. The event text identifies the source domain controller and the outdated (lingering) object. The following is an example of the event text:</para>
      <code>Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Date: 2/7/2008  8:20:11 AM
Event ID: 1988
Task Category: Replication 
Level: Error
Keywords: Classic
User: ANONYMOUS LOGON
Computer: DC5.contoso.com
Description:
Active Directory Domain Services Replication encountered the existence of objects 
in the following partition that have been deleted from the local 
domain controllers (DCs) Active Directory Domain Services database. Not all direct 
or transitive replication partners replicated in the deletion 
before the tombstone lifetime number of days passed. Objects that 
have been deleted and garbage collected from an Active Directory Domain Services 
partition but still exist in the writable partitions of other DCs 
in the same domain, or read-only partitions of global catalog servers 
in other domains in the forest are known as "lingering objects". 

This event is being logged because the source DC contains a lingering 
object which does not exist on the local DCs Active Directory Domain Services database.  
This replication attempt has been blocked.

The best solution to this problem is to identify and remove all 
lingering objects in the forest.

Source DC (Transport-specific network address):
4a8717eb-8e58-456c-995a-c92e4add7e8e._msdcs.contoso.com 
Object:
CN=InternalApps,CN=Users,DC=contoso,DC=com 
Object GUID:
a21aa6d9-7e8a-4a8f-bebf-c3e38d0b733a </code>
    </content>
  </section>
  <section address="BKMK_Cause">
    <title>Diagnosis</title>
    <content>
      <para>An object that has been permanently deleted from AD DS (that is, its tombstone has been garbage-collected on all connected domain controllers) remains on a disconnected domain controller. The domain controller failed to receive direct or transitive replication of the object deletion because it was disconnected (it is offline or experiencing an inbound replication failure) from the replication topology for a period that exceeded a tombstone lifetime. The domain controller is now reconnected to the topology and that object has been updated on the domain controller, causing a replication notification to the replication partner that an update is ready for replication. The replication partner responded according to its replication consistency setting. This notification applies to attempted replication of a writable object. A copy of the writable lingering object might also exist on a global catalog server.</para>
    </content>
  </section>
  <section address="BKMK_Solution">
    <title>Resolution</title>
    <content>
      <para>If replication of a lingering object is detected, you can remove the object from AD DS, along with any read-only replicas of the object, by identifying the domain controllers that might store this object (including global catalog servers) and running a <system>repadmin</system> command to remove lingering objects on these servers (<system>repadmin /removelingeringobjects</system>). This command is available on domain controllers that are running <token>nextref_longhorincludes>. It is also available on domain controllers that are not running <token>nextref_longhorincludes> but are running the version of Repadmin.exe that is included with Windows Support Tools in Windows Server 2003.</para>
      <para>To remove lingering objects, do the following:</para>
      <list class="ordered">
        <listItem>
          <para>Use the event text to identify the following:</para>
          <list class="ordered">
            <listItem>
              <para>The directory partition of the object</para>
            </listItem>
            <listItem>
              <para>The source domain controller that attempted replication of the lingering object</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="#BKMK_Identify_GUID">Use Repadmin to identify the GUID of an authoritative domain controller</link>
          </para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="#BKMK_RemoveLingeringObjects">Use Repadmin to remove lingering objects</link>
          </para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="#BKMK_Enable_Strict">Enable strict replication consistency</link>, if necessary</para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="#BKMK_Ensure_Strict">Ensure strict replication consistency on new domain controllers when upgrading a Windows Server 2000 Forest</link>, if necessary</para>
        </listItem>
      </list>
    </content>
    <sections>
      <section address="BKMK_Identify_GUID">
        <title>Use Repadmin to identify the GUID of an authoritative domain controller</title>
        <content>
          <para>To perform the procedure that removes lingering objects, you must identify the globally unique identifier (GUID) of an up-to-date domain controller that has a writable replica of the directory partition that contains the lingering object that has been reported. The directory partition is identified in the event message.</para>
          <para>The object GUID of a domain controller is stored in the <system>objectGUID</system> attribute of the NTDS Settings object.</para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in <embeddedLabel>Domain Admins</embeddedLabel> in the domain of the domain controller whose GUID you want to identify is the minimum required to complete this procedure. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tool: Repadmin.exe</para>
            </listItem>
          </list>
          <procedure>
            <title>To identify the GUID of a domain controller</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>At a command prompt, type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>repadmin /showrepl &lt;ServerName&gt;</codeInline>
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
                          <para>/showrepl</para>
                        </TD>
                        <TD>
                          <para>Displays the replication status, including when the domain controller that is specified by &lt;ServerName&gt; last attempted inbound replication of Active Directory partitions. Also displays the GUID of the specified domain controller.</para>
                        </TD>
                      </tr>
                      <tr>
                        <TD>
                          <para>&lt;ServerName&gt;</para>
                        </TD>
                        <TD>
                          <para>The name of the domain controller whose GUID you want to display.</para>
                        </TD>
                      </tr>
                    </tbody>
                  </table>
                </content>
              </step>
              <step>
                <content>
                  <para>In the first section of the output, locate the <system>objectGuid</system> entry. Select and copy the GUID value into a text file so that you can use it elsewhere.</para>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
      <section address="BKMK_RemoveLingeringObjects">
        <title>Use Repadmin to remove lingering objects</title>
        <content>
          <para>If the destination domain controller and source domain controller are running either Windows Server 2003 or <token>nextref_longhorincludes>, you can use this procedure to remove lingering objects with Repadmin. If either domain controller is running Windows 2000 Server, follow the instructions in article 314282 in the Microsoft Knowledge Base (<externalLink><linkText>https://go.microsoft.com/fwlink/?LinkId=41410</linkText><linkUri>https://go.microsoft.com/fwlink/?LinkId=41410</linkUri></externalLink>).</para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in <embeddedLabel>Domain Admins</embeddedLabel> in the domain of the domain controller that has lingering objects, or <embeddedLabel>Enterprise Admins</embeddedLabel> if the directory partition that has lingering objects is the configuration or schema directory partition, is the minimum required to complete this procedure. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Operating system: Windows Server 2003 or <token>nextref_longhorincludes> for &lt;ServerName&gt; and &lt;ServerGUID&gt;</para>
            </listItem>
            <listItem>
              <para>Tool: Repadmin.exe</para>
            </listItem>
          </list>
          <procedure>
            <title>To use Repadmin to remove lingering objects</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Open a Command Prompt as an administrator: On the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, provide Domain Admins or Enterprise Admins credentials, if required, and then click <ui>Continue</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>At the command prompt, type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>repadmin /removelingeringobjects &lt;ServerName&gt; &lt;ServerGUID&gt; &lt;DirectoryPartition&gt; /advisory_mode</codeInline>
                  </para>
                  <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
                    <thead>
                      <tr>
                        <TD colspan="1">
                          <para>Parameter</para>
                        </TD>
                        <TD colspan="1">
                          <para>Description</para>
                        </TD>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <TD colspan="1">
                          <para>/removelingeringobjects</para>
                        </TD>
                        <TD colspan="1">
                          <para>Removes lingering objects from the domain controller that is specified by &lt;ServerName&gt; for the directory partition that is specified by &lt;DirectoryPartition&gt;.</para>
                        </TD>
                      </tr>
                      <tr>
                        <TD colspan="1">
                          <para>&lt;ServerName&gt;</para>
                        </TD>
                        <TD colspan="1">
                          <para>The name of the domain controller that has lingering objects, as identified in the event message (Event ID 1388 or Event ID 1988). You can use the Domain Name System (DNS) name or the distinguished name, for example, the distinguished name CN=DC5,OU=Domain Controllers,DC=contoso,DC=com or the DNS name DC5.contoso.com.</para>
                        </TD>
                      </tr>
                      <tr>
                        <TD colspan="1">
                          <para>&lt;ServerGUID&gt;</para>
                        </TD>
                        <TD colspan="1">
                          <para>The GUID of a domain controller that has an up-to-date, writable replica of the directory partition that contains the lingering object</para>
                        </TD>
                      </tr>
                      <tr>
                        <TD colspan="1">
                          <para>&lt;DirectoryPartition&gt;</para>
                        </TD>
                        <TD colspan="1">
                          <para>The distinguished name of the directory partition that is identified in the event message, for example: </para>
                          <list class="bullet">
                            <listItem>
                              <para>For the Sales domain directory partition in the contoso.com forest: DC=sales,DC=contoso,DC=com</para>
                            </listItem>
                            <listItem>
                              <para>For the configuration directory partition in the contoso.com forest: CN=configuration,DC=contoso,DC=com </para>
                            </listItem>
                            <listItem>
                              <para>For the schema directory partition in the contoso.com forest: CN=schema,CN=configuration,DC=contoso,DC=com</para>
                            </listItem>
                          </list>
                        </TD>
                      </tr>
                      <tr>
                        <TD colspan="1">
                          <para>/advisory_mode</para>
                        </TD>
                        <TD colspan="1">
                          <para>Logs the lingering objects that will be removed so that you can review them, but does not remove them.</para>
                        </TD>
                      </tr>
                    </tbody>
                  </table>
                </content>
              </step>
              <step>
                <content>
                  <para>Repeat step 2 without <codeInline>/advisory_mode</codeInline> to delete the identified lingering objects from the directory partition.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Repeat steps 2 and 3 for every domain controller that might have lingering objects.</para>
                </content>
              </step>
            </steps>
          </procedure>
          <alert class="note">
            <para>The &lt;ServerName&gt; parameter uses the <codeInline>DC_LIST</codeInline> syntax for <codeInline>repadmin</codeInline>, which allows the use of <codeInline>*</codeInline> for all domain controllers in the forest and <codeInline>gc:</codeInline> for all global catalog servers in the forest. To see the <codeInline>DC_LIST</codeInline> syntax, type <codeInline>repadmin /listhelp</codeInline>. For information about the syntax of the <codeInline>/regkey</codeInline> and <codeInline>/removelingeringobjects</codeInline> parameters, type <codeInline>repadmin /experthelp</codeInline>.</para>
          </alert>
        </content>
      </section>
      <section address="BKMK_Enable_Strict">
        <title>Enable strict replication consistency</title>
        <content>
          <para>To ensure that lingering objects cannot be replicated if they occur, enable strict replication consistency on all domain controllers. The setting for replication consistency is stored in the registry on each domain controller. However, on domain controllers that are running Windows Server 2003 with Service Pack 1 (SP1), Windows Server 2003 with Service Pack 2 (SP2), Windows Server 2003 R2, or <token>nextref_longhorincludes>, you can use Repadmin to enable strict replication consistency on one or all domain controllers.</para>
          <para>On domain controllers running Windows Server 2003 without SP1 or running any version of Windows 2000 Server, you must edit the registry to enable the setting.</para>
        </content>
        <sections>
          <section address="BKMK_Use_Repadmin">
            <title>Use Repadmin to enable strict replication consistency</title>
            <content>
              <para>Use this procedure to remove lingering objects on a domain controller that is running Windows Server 2003 with SP1, Windows Server 2003 with SP2, Windows Server 2003 R2, or <token>nextref_longhorincludes>.</para>
              <para>Membership in <embeddedLabel>Domain Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure on a single domain controller. Membership in <embeddedLabel>Enterprise Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure on all domain controllers in the forest. <token>review_detailincludes></para>
              <procedure>
                <title>To use Repadmin to enable strict replication consistency</title>
                <steps class="ordered">
                  <step>
                    <content>
                      <para>Open a Command Prompt as an administrator: On the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, provide Domain Admins or Enterprise Admins credentials, if required, and then click <ui>Continue</ui>.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>At the command prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>repadmin /regkey &lt;DC_LIST&gt; +strict</codeInline>
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
                              <para>Enables (<codeInline>+</codeInline>) and disables (<codeInline>-</codeInline>) the value for the <embeddedLabel>Strict Replication Consistency</embeddedLabel> registry entry in <embeddedLabel>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSParameters</embeddedLabel></para>
                            </TD>
                          </tr>
                          <tr>
                            <TD>
                              <para>&lt;DC_LIST&gt;</para>
                            </TD>
                            <TD>
                              <para>The name of a single domain controller, or<system>*</system> to apply the change to all domain controllers in the forest. For the domain controller name, you can use the DNS name, the distinguished name of the domain controller computer object, or the distinguished name of the domain controller server object, for example, the distinguished name CN=DC5,OU=Domain Controllers,DC=contoso,DC=com or the DNS name DC5.contoso.com.</para>
                            </TD>
                          </tr>
                          <tr>
                            <TD>
                              <para>+strict</para>
                            </TD>
                            <TD>
                              <para>Enables the <embeddedLabel>Strict Replication Consistency</embeddedLabel> registry entry.</para>
                            </TD>
                          </tr>
                        </tbody>
                      </table>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>If you do not use <codeInline>*</codeInline> to apply the change to all domain controllers, repeat step 2 for every domain controller on which you want to enable strict replication consistency.</para>
                    </content>
                  </step>
                </steps>
              </procedure>
              <alert class="note">
                <para>For more naming options and information about the syntax of the &lt;DC_LIST&gt; parameter, at the command prompt type <codeInline>repadmin /listhelp</codeInline>. For information about the syntax of the <codeInline>/regkey</codeInline> and <codeInline>/removelingeringobjects</codeInline> parameters, type <codeInline>repadmin /experthelp</codeInline>.</para>
              </alert>
            </content>
          </section>
          <section address="BKMK_Edit_Registry">
            <title>Use Regedit to enable strict replication consistency</title>
            <content>
              <para>As an alternative to using Repadmin, you can enable strict replication consistency by editing the registry directly. The registry method is required for a domain controller that is running a version of Windows Server that is earlier than Windows Server 2003 with SP1. The setting for replication consistency is stored in the <embeddedLabel>Strict Replication Consistency</embeddedLabel> entry in <embeddedLabel>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSParameters</embeddedLabel>.</para>
              <para>The values for the <embeddedLabel>Strict Replication Consistency</embeddedLabel> registry entry are as follows:</para>
              <list class="bullet">
                <listItem>
                  <para>Value: <system>1</system> (<system>0</system> to disable)</para>
                </listItem>
                <listItem>
                  <para>Default: <system>1</system> (enabled) in a new Windows Server 2003 or <token>nextref_longhorincludes> forest; otherwise <system>0</system>.</para>
                </listItem>
                <listItem>
                  <para>Data type: <system>REG_DWORD</system></para>
                </listItem>
              </list>
              <para>
                <embeddedLabel>Requirements:</embeddedLabel>
              </para>
              <list class="bullet">
                <listItem>
                  <para>Membership in <embeddedLabel>Domain Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
                </listItem>
                <listItem>
                  <para>Tool: Regedit.exe</para>
                </listItem>
              </list>
              <alert class="caution">
                <para>It is recommended that you do not directly edit the registry unless there is no other alternative. Modifications to the registry are not validated by the registry editor or by Windows before they are applied, and as a result, incorrect values can be stored. This can result in unrecoverable errors in the system. When possible, use Group Policy or other Windows tools, such as Microsoft Management Console (MMC), to accomplish tasks rather than editing the registry directly. If you must edit the registry, use extreme caution.</para>
              </alert>
              <procedure>
                <title>To use Regedit to enable strict replication consistency</title>
                <steps class="ordered">
                  <step>
                    <content>
                      <para>Open Regedit as an administrator: Click <ui>Start</ui> and then, in <ui>Start Search</ui>, type <userInput>regedit</userInput>. At the top of the <ui>Start</ui> menu, right-click <ui>regedit.exe</ui>, and then click <ui>Run as administrator</ui>. In the <ui>User Account Control</ui> dialog box, provide Domain Admins credentials, and then click <ui>OK</ui>.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Navigate to the <system>Strict Replication Consistency</system> entry in <system>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSParameters</system>.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Set the value in the <system>Strict Replication Consistency</system> entry to <system>1.</system></para>
                    </content>
                  </step>
                </steps>
              </procedure>
            </content>
          </section>
        </sections>
      </section>
    </sections>
  </section>
  <section address="BKMK_Ensure_Strict">
    <title>Ensure that strict replication consistency is enabled for newly promoted domain controllers</title>
    <content>
      <para>If you are upgrading a forest that was originally created using a computer running Windows 2000 Server, you should ensure that the forest is configured to enable strict replication consistency on newly promoted domain controllers to help avoid lingering objects. After you update the forest as described in Upgrading Active Directory Domains to Windows Server 2008 AD DS Domains (<externalLink><linkText>https://go.microsoft.com/fwlink/?LinkId=89032</linkText><linkUri>https://go.microsoft.com/fwlink/?LinkId=89032</linkUri></externalLink>), all new domain controllers that you subsequently add to the forest are created with strict replication consistency disabled. However, you can implement a forest configuration change that causes new domain controllers to have strict replication consistency enabled. To ensure that new domain controllers that you add to the forest have strict replication consistency enabled, you can use the Ldifde.exe tool to create an object in the configuration directory partition of the forest. This object is responsible for enabling strict replication consistency on any Windows Server 2003 or <token>nextref_longhorincludes> domain controller that is promoted into the forest.</para>
      <para>The object that you create is an operational GUID with the following name:</para>
      <para>CN=94fdebc6-8eeb-4640-80de-ec52b9ca17fa,CN=Operations,CN=ForestUpdates,CN=Configuration,DC=&lt;ForestRootDomain&gt;</para>
      <para>You can use the following procedure on any domain controller in the forest to add this object to the configuration directory partition.</para>
      <para>Membership in <embeddedLabel>Enterprise Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
      <procedure>
        <title>To create the object that ensures strict replication consistency on new domain controllers</title>
        <steps class="ordered">
          <step>
            <content>
              <para>In a text editor, such as Notepad, create the following text file:</para>
              <code>dn:
CN=94fdebc6-8eeb-4640-80de-ec52b9ca17fa,CN=Operations,CN=ForestUpdates,CN=Configuration,DC=&lt;ForestRootDomain&gt;
changetype: add
objectClass: container
showInAdvancedViewOnly: TRUE
name: 94fdebc6-8eeb-4640-80de-ec52b9ca17fa
objectCategory: CN=Container,CN=Schema,CN=Configuration,DC=&lt;ForestRootDomain&gt;</code>
              <para>Where &lt;ForestRootDomain&gt; contains all domain components (DC=) of the forest root domain, for example, for the contoso.com forest, DC=contoso,DC=com; for the fineartschool.net forest, DC=fineartschool,DC=net.</para>
            </content>
          </step>
          <step>
            <content>
              <para>Open a Command Prompt as an administrator: On the <ui>Start</ui> menu, right-click <ui>Command Prompt</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, provide Enterprise Admins credentials, if required, and then click <ui>Continue</ui>.</para>
            </content>
          </step>
          <step>
            <content>
              <para>At the command prompt, type the following command, and then press ENTER: </para>
              <para>
                <codeInline>ldifde -i -f &lt;Path&gt;&lt;FileName&gt;</codeInline>
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
                      <para>-i</para>
                    </TD>
                    <TD>
                      <para>Specifies the import mode. If the import mode is not specified, the default mode is export.</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>-f</para>
                    </TD>
                    <TD>
                      <para>Identifies the import or export file name.</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>&lt;Path&gt;&lt;FileName&gt;</para>
                    </TD>
                    <TD>
                      <para>The path and name of the import file that you created in step 1, for example, C:ldifde.txt.</para>
                    </TD>
                  </tr>
                </tbody>
              </table>
            </content>
          </step>
        </steps>
      </procedure>
      <para>For information about using Ldifde, see LDIFDE (<externalLink><linkText>https://go.microsoft.com/fwlink/?LinkId=42656</linkText><linkUri>https://go.microsoft.com/fwlink/?LinkId=42656</linkUri></externalLink>).</para>
    </content>
  </section>
  <relatedTopics />
</developerConceptualDocument>


