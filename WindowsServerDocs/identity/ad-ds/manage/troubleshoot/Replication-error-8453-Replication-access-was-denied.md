---
ms.assetid: e4ff3f20-7284-40a8-8fe2-3a1b34fde1df
title: Replication error 8453 Replication access was denied
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 8453 Replication access was denied

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic explains symptoms, causes and how to resolve Active Directory replication error 8453 Replication access was denied.</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="985b9945-78c9-4754-8a69-146878d9f790#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="985b9945-78c9-4754-8a69-146878d9f790#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="985b9945-78c9-4754-8a69-146878d9f790#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>The DCDIAG Replication test (DCDIAG /TEST:NCSecDesc) reports that the tested DC "failed test Replications" with status 8453: Replication access was denied.</para>
          <code>Starting test: Replications
[Replications Check,&lt;destination DC] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;Destination DC
Naming Context: &lt;DN path of failing directory partition&gt;
<codeFeaturedElement>The replication generated an error (8453):
Replication access was denied.</codeFeaturedElement>
The failure occurred at &lt;date&gt; &lt;time&gt;.
The last success occurred at &lt;date&gt; &lt;time&gt;.
%#% failures have occurred since the last success.
The machine account for the destination &lt;destination DC&gt;.
is not configured properly.
Check the userAccountControl field.
Kerberos Error.
The machine account is not present, or does not match on the.
destination, source or KDC servers.
Verify domain partition of KDC is in sync with rest of enterprise.
The tool repadmin/syncall can be used for this purpose.
......................... <codeFeaturedElement>&lt;DC tested by DCDIAG&gt; failed test Replications</codeFeaturedElement></code>
        </listItem>
        <listItem>
          <para>The DCDIAG NCSecDesc test (DCDIAG /TEST:NCSecDes) reports that the DC tested by DCDIAG "failed test NCSecDec" and that one or more permissions are missing on the NC head of one or more directory partitions on the tested DC tested by DCDIAG:</para>
          <code>Starting test: NCSecDesc
Error NT AUTHORITYENTERPRISE DOMAIN CONTROLLERS doesn't have
Replicating Directory Changes 
Replication Synchronization 
Manage Replication Topology 
Replicating Directory Changes In Filtered Set 
access rights for the naming context: 
DC=contoso,DC=com 
Error CONTOSODomain Controllers doesn't have
Replicating Directory Changes All
access rights for the naming context:
DC=contoso,DC=com
Error CONTOSOEnterprise Read-only Domain Controllers doesn't have
Replicating Directory Changes
access rights for the naming context:
DC=contoso,DC=com
......................... <codeFeaturedElement>CONTOSO-DC2 failed test NCSecDesc</codeFeaturedElement>
</code>
          <alert class="note">
            <para>The list of missing access rights required for each security group could vary depending on your environment. </para>
          </alert>
        </listItem>
        <listItem>
          <para>The DCDIAG MachineAccount test (DCDIAG /TEST:MachineAccount) reports that the DC tested by DCDIAG "failed test MachineAccount" because the UserAccountControl attribute on the DCs computer account is missing the "SERVER_TRUST_ACCOUNT" OR "TRUSTED_FOR_DELEGATION" flags:</para>
          <code>Starting test: MachineAccount
<codeFeaturedElement>The account CONTOSO-DC2 is not trusted for delegation</codeFeaturedElement>. It cannot
replicate.
The account CONTOSO-DC2 is not a DC account. It cannot replicate.
Warning: Attribute userAccountControl of CONTOSO-DC2 is:
0x288 = ( HOMEDIR_REQUIRED | ENCRYPTED_TEXT_PASSWORD_ALLOWED | NORMAL_ACCOUNT )
Typical setting for a DC is
0x82000 = ( SERVER_TRUST_ACCOUNT | TRUSTED_FOR_DELEGATION )
This may be affecting replication?
......................... CONTOSO-DC2 <codeFeaturedElement>failed test MachineAccount</codeFeaturedElement></code>
        </listItem>
        <listItem>
          <para>The DCDIAG KCC Event log test cites the hexadecimal equivalent of Microsoft-Windows-ActiveDirectory_DomainService event 2896.</para>
          <para>B50 hex = 2896 decimal. This error may be logged every 60 seconds on the infrastructure master domain controller.</para>
          <code>Starting test: KccEvent
* The KCC Event log test
An error event occurred. EventID: 0xC0000B50
Time Generated: 06/25/2010 07:45:07
Event String:
A client made a DirSync LDAP request for a directory partition. Access was denied due to the following error. 
Directory partition: 
&lt;DN path of directory partition&gt;
Error value: 
<codeFeaturedElement>8453 Replication access was denied.</codeFeaturedElement> 
User Action 
The client may not have access for this request. If the client requires it, they should be assigned the control access right "Replicating
Directory Changes" on the directory partition in question.
</code>
        </listItem>
        <listItem>
          <para>REPADMIN.EXE reports that replication attempt has failed with status 8453.</para>
          <para>REPADMIN commands that commonly cite the 8453 status include but are not limited to:</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <list class="bullet">
                    <listItem>
                      <para>REPADMIN /KCC</para>
                    </listItem>
                    <listItem>
                      <para>REPADMIN /REHOST</para>
                    </listItem>
                    <listItem>
                      <para>REPADMIN /REPLICATE</para>
                    </listItem>
                    <listItem>
                      <para>REPADMIN /REPLSUM</para>
                    </listItem>
                  </list>
                </TD>
                <TD>
                  <list class="bullet">
                    <listItem>
                      <para>REPADMIN /SHOWREPL</para>
                    </listItem>
                    <listItem>
                      <para>REPADMIN /SHOWREPS</para>
                    </listItem>
                    <listItem>
                      <para>REPADMIN /SHOWUTDVEC</para>
                    </listItem>
                    <listItem>
                      <para>REPADMIN /SYNCALL</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Sample output from "REPADMIN /SHOWREPS" depicting inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the "replication access was denied" error is shown below:</para>
          <code>Default-First-Site-NameCONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01
DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01
==== INBOUND NEIGHBORS ======================================
DC=contoso,DC=com
Default-First-Site-NameCONTOSO-DC2 via RPC
DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2
Last attempt @ &lt;date&gt; &lt;time&gt; failed, <codeFeaturedElement>result 8453 (0x2105):
Replication access was denied.</codeFeaturedElement>
&lt;#&gt; consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;.
</code>
        </listItem>
        <listItem>
          <para>The "replicate now" command in Active Directory Sites and Services returns "Replication access was denied."</para>
          <para>Right-clicking on the connection object from a source DC and choosing "replicate now" fails with "Replication access was denied. The on-screen error message is shown below:</para>
          <para>Dialog title text: Replicate Now</para>
          <para>
Dialog message text: The following error occurred during the attempt to synchronize naming context &lt;%directory partition name%&gt; from Domain Controller &lt;Source DC&gt; to Domain Controller &lt;Destination DC&gt;:</para>
          <para>
Replication access was denied</para>
          <para>

The operation will not continue</para>
          <para>
Buttons in Dialog: OK</para>
          <mediaLink>
            <image xlink:href="d6bdf81a-dce0-4426-911e-b57b88ff766d" />
          </mediaLink>
        </listItem>
        <listItem>
          <para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 8453 status are logged in the directory service event log.</para>
          <para>Active Directory events that commonly cite the 8453 status include but are not limited to:</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Event ID</para>
                </TD>
                <TD>
                  <para>Event Source</para>
                </TD>
                <TD>
                  <para>Event String</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>1699</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-ActiveDirectory_DomainService</para>
                </TD>
                <TD>
                  <para>This directory service failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send change requests to the directory service at the following network address.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>2896</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-ActiveDirectory_DomainService</para>
                </TD>
                <TD>
                  <para>A client made a DirSync LDAP request for a directory partition. Access was denied due to the following error.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1655</para>
                </TD>
                <TD>
                  <para>NTDS General</para>
                </TD>
                <TD>
                  <para>Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1265</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The attempt to establish a replication link with parameters</para>
                  <para>Partition: &lt;partition DN path&gt;</para>
                  <para>Source DSA DN: &lt;DN of source DC NTDS Settings object&gt;</para>
                  <para>Source DSA Address: &lt;source DCs fully qualified CNAME&gt;</para>
                  <para>Inter-site Transport (if any): &lt;dn path&gt;</para>
                  <para>failed with the following status:</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1925</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The attempt to establish a replication link for the following writable directory partition failed.</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>The status 8453: "Replication Access was denied" has multiple root causes including: </para>
      <list class="ordered">
        <listItem>
          <para>The UserAccountControl attribute on the destination domain controller computer account is missing either the SERVER_TRUST_ACCOUNT or TRUSTED_FOR_DELEGATION flags.</para>
        </listItem>
        <listItem>
          <para>The default permissions do not exist on one or more directory partitions to allow scheduled replication to occur <?Comment JTH: Ask Arren what does this mean? 2011-08-22T10:58:00Z  Id='1?>in the operating system's security context<?CommentEnd Id='1'
    ?>.</para>
        </listItem>
        <listItem>
          <para>The default or custom permissions do not exist on one or more directory partitions to allow users triggering ad-hoc or immediate replication using DSSITE.MSC -&gt; "replicate now", "repadmin /replicate", "repadmin /syncall" or similar commands.</para>
        </listItem>
        <listItem>
          <para>The permissions needed to trigger ad-hoc replication is correctly defined on the relevant directory partitions but the user is <embeddedLabel>*NOT*</embeddedLabel> a member any security groups that have been granted the replication directory changes permission. </para>
        </listItem>
        <listItem>
          <para>The user triggering ad-hoc replication <embeddedLabel>*IS*</embeddedLabel> a member of the required security groups AND those security groups have been granted the "replicating directory changes" permission but membership in the group granting the "replicating directory changes" permission has been removed from the users security token by the <externalLink><linkText>User Account Control</linkText><linkUri>https://technet.microsoft.com/library/cc772207(WS.10).aspx</linkUri></externalLink> (split user access token) feature introduced in Windows Vista and Windows Server 2008.</para>
          <alert class="note">
            <para>Do not confuse the User Account Control split token security feature introduced in Windows Vista and Windows Server 2008 with the <embeddedLabel>UserAccountControl</embeddedLabel> attribute defined on DC role computer accounts stored in Active Directory.</para>
          </alert>
        </listItem>
        <listItem>
          <para>RODCPREP has not been run in domains currently hosting read-only domain controllers.</para>
        </listItem>
        <listItem>
          <para>DCs running new operating system versions have been added to an existing forest where Office Communication Server has been installed.</para>
        </listItem>
      </list>
      <para>Active Directory errors and events like those cited in the symptoms section of this topic can also fail with error 5: "Access is denied".</para>
      <para>Applying the resolution steps for error 5: "access is denied" listed below WILL NOT resolve replication failures on computers that are currently failing replication with error status 8453 and vice versa. Common root causes for Active Directory operations failing with error 5: "access is denied" include:</para>
      <list class="bullet">
        <listItem>
          <para>Excessive Time Skew</para>
        </listItem>
        <listItem>
          <para>The fragmentation of UDP-formatted Kerberos packets by intermediate devices on the network</para>
        </listItem>
        <listItem>
          <para>Missing "access this computer from network" rights.</para>
        </listItem>
        <listItem>
          <para>Broken secure channels or intradomain trusts</para>
        </listItem>
        <listItem>
          <para>CrashOnAuditFail = 2 in the Registry</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>
            <embeddedLabel>Perform a health-check with DCDIAG + DCDIAG /test:CheckSecurityError</embeddedLabel>
          </para>
          <list class="ordered">
            <listItem>
              <para>Run DCDIAG on the "destination DC" reporting the 8453 error or event.</para>
            </listItem>
            <listItem>
              <para>Run DCDIAG on the "source DC" that the DC reporting the 8453 error or event is "pulling from."</para>
            </listItem>
            <listItem>
              <para>Run DCDIAG /test:CheckSecurityError on the "destination DC" reporting the 8453 error or event.</para>
            </listItem>
            <listItem>
              <para>Run DCDIAG /test:CheckSecurityError on the "source DC" that the DC reporting the 8453 error or event is "pulling from."</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Fix Invalid UserAccountControl</embeddedLabel>
          </para>
          <para>The UserAccountControl attribute consists of a bitmask that defines the capabilities and the state of a user or computer account. More information on UserAccountControl flags can be found in <externalLink><linkText>MSKB 305144</linkText><linkUri>https://support.microsoft.com/kb/305144</linkUri></externalLink> and <externalLink><linkText>MSDN</linkText><linkUri>https://msdn.microsoft.com/library/ms680832(VS.85).aspx</linkUri></externalLink>.</para>
          <para>The typical UserAccountControl attribute value for a <placeholder>writable</placeholder> ("full") domain controller computer account is 532480 decimal or 82000 hex. UserAccountControl values for a domain controller computer account may vary but <placeholder>must</placeholder> contain the SERVER_TRUST_ACCOUNT and TRUSTED_FOR_DELEGATION flags shown in the table below:</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Property flag</para>
                </TD>
                <TD>
                  <para>Hex value</para>
                </TD>
                <TD>
                  <para>Decimal Value</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>SERVER_TRUST_ACCOUNT</para>
                </TD>
                <TD>
                  <para>0x2000</para>
                </TD>
                <TD>
                  <para>8192</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>TRUSTED_FOR_DELEGATION</para>
                </TD>
                <TD>
                  <para>0x80000</para>
                </TD>
                <TD>
                  <para>524288</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>UserAccountControl Value</para>
                </TD>
                <TD>
                  <para>0x82000</para>
                </TD>
                <TD>
                  <para>532480</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>The typical UserAccountControl attribute value for a <placeholder>read-only domain controller</placeholder> computer account is 83890176 decimal or 5001000 hex:</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Property flag</para>
                </TD>
                <TD>
                  <para>Hex value</para>
                </TD>
                <TD>
                  <para>Decimal Value</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>WORKSTATION_TRUST_ACCOUNT</para>
                </TD>
                <TD>
                  <para>0x1000</para>
                </TD>
                <TD>
                  <para>4096</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</para>
                </TD>
                <TD>
                  <para>0x1000000</para>
                </TD>
                <TD>
                  <para>16777216</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>PARTIAL_SECRETS_ACCOUNT</para>
                </TD>
                <TD>
                  <para>0X4000000</para>
                </TD>
                <TD>
                  <para>67108864</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Typical UserAccountControl Value for RODC</para>
                </TD>
                <TD>
                  <para>0x5001000</para>
                </TD>
                <TD>
                  <para>83890176</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <list class="ordered">
            <listItem>
              <para>
                <embeddedLabel>The UserAccountControl attribute on the destination DC is missing the SERVER_TRUST_ACCOUNT flag</embeddedLabel>
              </para>
              <para>If the DCDIAG MachineAccount test fails with "failed test MachineAcccount" AND the UserAccountControl attribute on the tested DC is missing the SERVER_TRUST_ACCOUNT flag, add the missing flag in the tested DCs copy of Active Directory.</para>
              <procedure>
                <title>To add the SERVER_TRUST_ACCOUNT flag to the UserAccountControl attribute</title>
                <steps class="ordered">
                  <step>
                    <content>
                      <para>Start ADSIEDIT.MSC on the console of DC missing the SERVER_TRUST_ACCOUNT reported by DCDIAG.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Right-click <ui>ADSI Edit</ui> in the top left pane of ADSIEDIT.MSC and chose <ui>Connect to...</ui>.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Within the Connection Settings dialog:</para>
                      <list class="bullet">
                        <listItem>
                          <para>Click <ui>Select a well known Naming Context</ui> and chose <ui>Default naming context</ui> (that is, the computer account's domain partition).</para>
                        </listItem>
                        <listItem>
                          <para>Click <ui>Default (Domain or server that you are logged on to)</ui>.</para>
                        </listItem>
                        <listItem>
                          <para>Click <ui>OK</ui>.</para>
                        </listItem>
                      </list>
                      <para>&lt;&lt;Insert ADDS_ADSIEditConnectionSettings&gt;&gt;</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>In the domain naming context, locate and then right-click the domain controller computer account and chose <ui>Properties</ui>.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Double-click the <ui>userAccountControl</ui> attribute and record its decimal value.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Start the Windows calculator in Scientific (Windows 2000 or Windows Server 2003) or Programmer mode (Windows Server 2008 and later) and enter the decimal value for userAccountControl.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Convert the decimal value to its hexadecimal equivalent.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Add 0x80000 to the existing value and press "=".</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Convert the new calculated userAccountControl value to its decimal equivalent.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Type the new decimal value from the Windows calculator in the <ui>userAccountControl</ui> attribute in ADSIEDIT.MSC. Click <ui>OK</ui> twice to save.</para>
                    </content>
                  </step>
                </steps>
              </procedure>
            </listItem>
            <listItem>
              <para>
                <embeddedLabel>The userAccountControl attribute on the destination DC is missing the TRUSTED_FOR_DELEGATION flag</embeddedLabel>
              </para>
              <para>If the DCDIAG MachineAccount test fails with "failed test MachineAcccount" AND the userAccountControl attribute on the tested DC is missing the TRUSTED _FOR_DELEGATION flag, add the missing flag in the tested DCs copy of Active Directory.</para>
              <procedure>
                <title>To add the TRUSTED _FOR_DELEGATION flag to the userAccountControl attribute</title>
                <steps class="ordered">
                  <step>
                    <content>
                      <para>Start Active Directory Users and Computers (DSA.MSC) on the console of the DC tested by DCDIAG.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Right-click the DC computer account, and then click <ui>Properties</ui>.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Click the <ui>Delegation</ui> tab.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Click <ui>Trust this computer for delegation to any service (Kerberos only)</ui>, and click OK.</para>
                      <para>&lt;&lt;insert ADDS_DCDelegationTab&gt;&gt;</para>
                    </content>
                  </step>
                </steps>
              </procedure>
            </listItem>
          </list>
</listItem>
        <listItem>
          <para>
            <embeddedLabel>Fix Invalid Default Security Descriptors</embeddedLabel>
          </para>
          <para>Active Directory operations take place in the security context of the account that initiated the operation. Default permissions on Active Directory partitions allow:</para>
          <list class="bullet">
            <listItem>
              <para>Members of the Enterprise Administrators group to initiate ad-hoc replication between any DC in any domain in the same forest.</para>
            </listItem>
            <listItem>
              <para>Members of the Built-in Administrators group to initiate ad-hoc replication between domain controllers in the same domain.</para>
            </listItem>
            <listItem>
              <para>Domain Controllers in the same forest to initiate replication using either change notification or replication schedule.</para>
            </listItem>
          </list>
          <para>Default permissions on Active Directory partitions do not allow the following by default and, by design, will fail until default permissions or group memberships are modified:</para>
          <list class="bullet">
            <listItem>
              <para>Members of the Built-in Administrators group in one domain cannot initiate ad-hoc replication to DCs in that domain from DCs in different domains.</para>
            </listItem>
            <listItem>
              <para>Users that are NOT members of the Built-in administrators group cannot initiate ad-hoc replication from any other DC in the same domain or forest.</para>
            </listItem>
          </list>
          <para>Permissions are defined on the top of each directory partition (called a naming context or "NC" head) and inherited throughout the partition tree. Verify that explicit groups (groups that the user is direct member of) and implicit groups (those that explicit groups have nested membership of) have the required permissions and that Deny permissions assigned to implicit or explicit groups are not trumping the required permissions.</para>
          <para>More information about default directory partitions is available at <externalLink><linkText>Default Security of the Configuration Directory Partition</linkText><linkUri>https://technet.microsoft.com/library/cc961739.aspx</linkUri></externalLink>.</para>
          <list class="ordered">
            <listItem>
              <para>Verify that default permissions exist in the "top" of each directory partition that is failing with the "Replication access was denied" error.</para>
              <list class="bullet">
                <listItem>
                  <para>If ad-hoc replication is failing between DCs in different domains, or between DCs in the same domain for non-domain administrators, see the "Grant non-domain admins permissions..." section below.</para>
                </listItem>
                <listItem>
                  <para>If ad-hoc replication for member of the Enterprise Admins group, focus on NC head permissions granted to the Enterprise Admins group.</para>
                </listItem>
                <listItem>
                  <para>If ad-hoc replication is failing for members of a Domain Admins group, focus on permissions granted to the built-in Administrators security group.</para>
                </listItem>
                <listItem>
                  <para>If scheduled replication initiated by domain controllers in a forest are failing with 8453, focus on permissions for the Enterprise Domain Controllers and Enterprise Read-Only Domain Controllers security groups.</para>
                </listItem>
                <listItem>
                  <para>If scheduled replication initiated by domain controllers on a read-only domain controller (RODC) is failing with error 8453, verify that the Enterprise Read-only Domain Controllers security group has been granted the required access on the NC head of each directory partition.</para>
                </listItem>

</list>
              <para>The table below shows the default permission defined on the schema, configuration, domain and DNS applications by operating system version:</para>
              <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
                <thead>
                  <tr>
                    <TD>
                      <para>DACL required on each directory partition</para>
                    </TD>
                    <TD>
                      <para>Windows 2000</para>
                    </TD>
                    <TD>
                      <para>Windows Server 2003</para>
                    </TD>
                    <TD>
                      <para>Windows Server 2008 and later</para>
                    </TD>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <TD>
                      <para>Manage Replication Topology</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>Replicating Directory Changes</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>Replication Synchronization</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>Replicating Directory Changes All</para>
                    </TD>
                    <TD>
                      <para />
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>Replicating Changes in Filter Set</para>
                    </TD>
                    <TD>
                      <para />
                    </TD>
                    <TD>
                      <para />
                    </TD>
                    <TD>
                      <para>X</para>
                    </TD>
                  </tr>
                </tbody>
              </table>
              <alert class="note">
                <para>The DCDIAG NcSecDesc test may report false positive errors when run in environments with mixed operating system versions as documented in <externalLink><linkText>MSKB 829306</linkText><linkUri>https://support.microsoft.com/kb/829306</linkUri></externalLink>. </para>
              </alert>
              <para>The DSACLS command can be used to dump the permissions on a given directory partition using the syntax "DSACLS &lt;DN path of directory partition&gt;".</para>
              <code>C:\&gt;dsacls dc=contoso,dc=com</code>
              <para>The command can be targeted to a remote domain controller using the syntax:</para>
              <code>c:\&gt;dsacls \contoso-dc2\dc=contoso,dc=com</code>
              <para>Be wary of "DENY" permission on NC heads removing the permissions for groups that the failing user is a direct or nested member of.</para>
            </listItem>
            <listItem>
              <para>Add required permissions that are missing</para>
              <para>Use the Active Directory ACL editor in ADSIEDIT.MSC to add the missing DACLS.</para>
              <para>ACLS can be "restored" to their default settings using the "DSACLS &lt;DN path of directory partition&gt; /S /T" command.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Grant non-domain admins permissions to replicate between DCs in the same domain or non-enterprise administrators to replicate between DCs in different domains</embeddedLabel>
          </para>
          <para>Default permissions on Active Directory partitions do not allow the following and will fail until permissions on directory partitions are modified:</para>
          <list class="bullet">
            <listItem>
              <para>Members of the Built-in Administrators group in one domain cannot initiate ad-hoc replication from DCs in different domains.</para>
            </listItem>
            <listItem>
              <para>Users that are NOT members of the built-in Domain Admins group cannot initiate ad-hoc replication between DCs in the same domain or different domain.</para>
            </listItem>
          </list>
          <para>There are two solutions to this problem: </para>
          <list class="ordered">
            <listItem>
              <para>Add users to existing groups that have already been the granted the required permissions to replicate directory partitions (Domain Admins groups for replication in the same domain or the Enterprise Admins group to trigger ad-hoc replication between different domains).</para>
              <para>-Or-</para>
            </listItem>
            <listItem>
              <para>Create your own group, grant that group the required permissions on directory partitions throughout the forest, and then add users to those groups.</para>
              <para>
                <externalLink>
                  <linkText>MSKB 303972</linkText>
                  <linkUri>https://support.microsoft.com/kb/303972</linkUri>
                </externalLink> describes the process of creating a security group, adding the required members to those groups, then granting the group the required DACLS on Active Directory partitions. Grant the security group in question the same permissions listed in the table of the "Fix Invalid Default Security Descriptors" section this article.</para>
              <para>Related content:</para>
              <para>
                <externalLink>
                  <linkText>MSKB article 303305</linkText>
                  <linkUri>https://support.microsoft.com/kb/303305</linkUri>
                </externalLink>: "Access Denied" Error Message When You Use the Active Directory Sites and Services Tool</para>
              <para>
                <externalLink>
                  <linkText>Best Practices for delegating Active Directory</linkText>
                  <linkUri>https://www.microsoft.com/download/en/details.aspx?displaylang=en&amp;id=21678</linkUri>
                </externalLink>
              </para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Verify group membership in the required security groups</embeddedLabel>
          </para>
          <para>Once the right security groups have been granted the required permissions on directory partitions, the last remaining task is to verify that users initiating replication have effective membership in direct or nested security groups being granted replication permissions.</para>
          <list class="ordered">
            <listItem>
              <para>Log on with the user account where ad-hoc replication is failing with "replication access was denied."</para>
            </listItem>
            <listItem>
              <para>From a CMD prompt type "WHOAMI /ALL" and verify membership in the security groups that have been granted the "replicating directory changes" permissions on the relevant directory partitions.</para>
              <para>If the user was added to the permissioned group modified <placeholder>after</placeholder> the last user logon, log on again and retry the "whoami /all" command.</para>
              <para>If "WHOAMI /ALL" still does not show membership in the expected security groups, launch an elevated CMD prompt (right-click <ui>Command Prompt</ui> and click <ui>Run as Administrator</ui>) on the local machine and run the "WHOAMI /ALL" from inside the elevated CMD prompt.</para>
              <para>If the group membership is different between the WHOAMI /ALL output generated by elevated and non-elevated CMD prompts, refer to <externalLink><linkText>MSKB 976063</linkText><linkUri>https://support.microsoft.com/default.aspx?scid=kb;EN-US;976063</linkUri></externalLink>.</para>
            </listItem>
            <listItem>
              <para>Verify that the expected nested group memberships exist.</para>
              <para>If a user is obtaining the permissions to perform ad-hoc replication by being a member of a tested group that is a member of group that has been directly granted replication permissions, verify the nested group membership chain. For example, Microsoft CSS has seen ad-hoc AD Replication fail because Domain Admins and Enterprise Admins groups were removed from the Built-in Administrators groups.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>RODC Replication</embeddedLabel>
          </para>
          <para>If computer-initiated replication is failing on RODCs, verify that you have run ADPREP /RODCPREP as specified in <externalLink><linkText>MSKB 967482</linkText><linkUri>https://support.microsoft.com/kb/967482</linkUri></externalLink> AND that the Enterprise Read-only Domain Controllers group has been granted "replicate directory changes" right on each NC head.</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Office Communication Server</embeddedLabel>
          </para>
          <para>If you notice AD operations failing with 8453 "replication access was denied", in an existing forest running either Office Communication Server 2005 or Office Communication Server 2007 immediately after the promotion of, or upgrade to Windows Server 2008 or Windows Server 2008 R2 domain controllers, see MSKB articles:</para>
          <para>
            <externalLink>
              <linkText>982020</linkText>
              <linkUri>https://support.microsoft.com/default.aspx?scid=kb;EN-US;982020</linkUri>
            </externalLink>: Office Communications Server 2007 R2, OCS 2007 or LCS 2005 does not work correctly after you upgrade to Windows Server 2008 R2</para>
          <para>
            <externalLink>
              <linkText>982021</linkText>
              <linkUri>https://support.microsoft.com/default.aspx?scid=kb;EN-US;982021</linkUri>
            </externalLink>: Supportability is available for Office Communications Server 2007 R2 member server role on a Windows Server 2008 R2 operating system</para>
        </listItem>
      </list>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 8453: "Replication access was denied."</linkText>
      <linkUri>https://support.microsoft.com/kb/2022387</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>


