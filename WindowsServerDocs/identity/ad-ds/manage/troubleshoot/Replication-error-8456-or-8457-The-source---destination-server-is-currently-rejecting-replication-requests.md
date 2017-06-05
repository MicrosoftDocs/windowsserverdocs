---
ms.assetid: 7fc8f228-9bd8-4615-8139-344be9b61eed
title: Replication error 8456 or 8457 The source | destination server is currently rejecting replication requests
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 8456 or 8457 The source | destination server is currently rejecting replication requests

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic explains the symptoms, causes, and how to resolve Active Directory replication error 8456: the source server is currently rejecting replication requests or Active Directory replication error 8457: the destination server is currently rejecting replication requests. </para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="01360da7-92b6-4890-9e4d-ea38e63169c3#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="01360da7-92b6-4890-9e4d-ea38e63169c3#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="01360da7-92b6-4890-9e4d-ea38e63169c3#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>The DCPROMO promotion of a new domain controller in an existing forest fails with the error "The source server is currently rejecting replication requests." </para>
          <para>Dialog title text:  </para>
          <para>Active Directory Installation Wizard </para>
          <para>Dialog message text:</para>
          <para>The operation failed because:  Active Directory could not transfer the remaining data in directory partition &lt;directory partition DN path&gt; to domain controller &lt;destination DC&gt;.  "The source server is currently rejecting replication requests."</para>
        </listItem>
        <listItem>
          <para>DCDIAG reports the error "The source server is currently rejecting replication requests" or "The destination server is currently rejecting replication requests."</para>
          <code>Testing server: Default-First-Site-Name&lt;DC NAME&gt;
      Starting test: Replications
         * Replications Check
         [Replications Check,&lt;DC NAME&gt;] A recent replication attempt failed:
            From IADOMINO to &lt;DC NAME&gt;
            Naming Context: DC=&lt;DN path of partition&gt;
           <codeFeaturedElement>The replication generated an error (8456):
            The source server is currently rejecting replication requests.</codeFeaturedElement>
            The failure occurred at &lt;Date&gt; &lt;Time&gt;.
            The last success occurred at &lt;Date&gt; &lt;time&gt;.
            957 failures have occurred since the last success.
            Replication has been explicitly disabled through the server options

Testing server: Default-First-Site-Name\&lt;DC NAME&gt;
      Starting test: Replications
         * Replications Check
         [Replications Check,&lt;DC NAME&gt;] A recent replication attempt failed:
            From IADOMINO to &lt;DC NAME&gt;
            Naming Context: DC=&lt;DN path of partition&gt;
           <codeFeaturedElement>The replication generated an error (8457):
            The destination server is currently rejecting replication requests.</codeFeaturedElement>
            The failure occurred at &lt;Date&gt; &lt;Time&gt;.
            The last success occurred at &lt;Date&gt; &lt;time&gt;.
            957 failures have occurred since the last success.
            Replication has been explicitly disabled through the server options
</code>
        </listItem>
        <listItem>
          <para>REPADMIN indicates that incoming and outgoing Active Directory replication may be failing with the error "The source | destination server is currently rejecting replication."</para>
          <code>DC=Contoso,DC=COM
    &lt;site name&gt;\&lt;dc name&gt; via RPC
        DC object GUID: &lt;objectguid of source DCs NTDS settings object&gt;
        Last attempt @ &lt;date&gt; &lt;time&gt; failed, result 8457 (0x2109):
            The destination server is currently rejecting replication requests.

DC=Contoso,DC=COM
    &lt;site name&gt;\&lt;dc name&gt; via RPC
        DC object GUID: &lt;objectguid of source DCs NTDS settings object&gt;
        Last attempt @ &lt;date&gt; &lt;time&gt; failed, result 8456 (0x2108):
            The source server is currently rejecting replication requests.</code>
          <alert class="note">
            <para>REPADMIN commands may display both the hexadecimal and the decimal equivalent for the "currently rejecting replication" error.</para>
          </alert>
        </listItem>
        <listItem>
          <para>Event sources and event IDs that indicate that a USN rollback has occurred include but are not limited to the following:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Event</para>
                </TD>
                <TD>
                  <para>Source</para>
                </TD>
                <TD>
                  <para>Event String</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>1308</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following domain controller has consistently failed.</para>
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
              <tr>
                <TD>
                  <para>1926</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The attempt to establish a replication link to a read-only directory partition with the following parameters failed.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1586</para>
                </TD>
                <TD>
                  <para>NTDS Replication</para>
                </TD>
                <TD>
                  <para>The Windows NT 4.0 or earlier replication checkpoint with the PDC emulator master was unsuccessful. </para>
                  <para>A full synchronization of the security accounts manager (SAM) database to domain controllers running Windows NT 4.0 and earlier might occur if the PDC emulator master role is transferred to the local domain controller before the next successful checkpoint. </para>
                  <para>The checkpoint process will be tried again in four hours. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>2023</para>
                </TD>
                <TD>
                  <para>NTDS Replication</para>
                </TD>
                <TD>
                  <para>The local domain controller was unable to replicate changes to the following remote domain controller for the following directory partition.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>2095</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-ActiveDirectory_DomainServices</para>
                </TD>
                <TD>
                  <para>During an Active Directory Domain Services replication request, the local domain controller (DC) identified a remote DC which has received replication data from the local DC by using already acknowledged USN tracking numbers.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>2103</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-ActiveDirectory_DomainServices</para>
                </TD>
                <TD>
                  <para>The Active Directory Domain Services database was restored by using an unsupported restoration procedure. </para>
                  <para>Active Directory Domain Services will be unable to log on users while this condition persists. Therefore, the Net Logon service has paused. </para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Where embedded status codes 8456 and 8457 map to the following:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Decimal error</para>
                </TD>
                <TD>
                  <para>Hexadecimal error</para>
                </TD>
                <TD>
                  <para>Error string</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>8456</para>
                </TD>
                <TD>
                  <para>2108</para>
                </TD>
                <TD>
                  <para>The source server is currently rejecting replication</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>8457</para>
                </TD>
                <TD>
                  <para>2109</para>
                </TD>
                <TD>
                  <para>The destination server is currently rejecting replication.</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>NTDS General Event 2013 may be logged in the Directory Services event log. This indicates that a USN rollback occurred because of an unsupported rollback or restore of the Active Directory Database.</para>
          <para>Event Type: Error</para>
          <para>Event Source: NTDS General</para>
          <para>Event Category: Service Control</para>
          <para>Event ID: 2103</para>
          <para>Date: &lt;date&gt;</para>
          <para>Time: &lt;time&gt;</para>
          <para>User: &lt;user name&gt;</para>
          <para>Computer: &lt;computer name&gt;</para>
          <para>Description: The Active Directory database has been restored by using an unsupported restoration procedure. Active Directory will be unable to log on users while this condition persists. As a result, the Net Logon service has paused. User Action See previous event logs for details. For more information, visit the Help and Support Center at <externalLink><linkText>http://support.microsoft.com</linkText><linkUri>http://support.microsoft.com</linkUri></externalLink>.</para>
        </listItem>
        <listItem>
          <para>NTDS General Event 1393 may be logged in the Directory Services event log. This indicates that the physical or virtual drive that is hosting the Active Directory database or log files lacks sufficient free disk space:</para>
          <para>Event Type: Error</para>
          <para>Event Source: NTDS General</para>
          <para>Event Category: Service Control</para>
          <para>Event ID: 1393</para>
          <para>Date: &lt;date&gt;</para>
          <para>Time: &lt;time&gt;</para>
          <para>User: &lt;user name&gt;</para>
          <para>Computer: &lt;computer name&gt;</para>
          <para>Description: Attempts to update the Directory Service database are failing with error 112. Since Windows will be unable to log on users while this condition persists, the NetLogon service is being paused. Make sure that sufficient free disk space is available on the drives where the directory database and log files reside.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>Incoming or outgoing replication was automatically disabled by the operating system because of multiple root causes.</para>
      <para>Three events that disable inbound or outbound replication include:</para>
      <list class="ordered">
        <listItem>
          <para>A USN rollback occurred (NTDS General Event 2103).</para>
        </listItem>
        <listItem>
          <para>The hard disk is full (NTDS General Event 1393).</para>
        </listItem>
        <listItem>
          <para>A corrupt UTD vector is present (Event 2881).</para>
        </listItem>
      </list>
      <para>The operating system automatically makes four configuration changes when one of three conditions occurs. The four configuration changes are as follows: </para>
      <list class="ordered">
        <listItem>
          <para>Incoming Active Directory replication is disabled.</para>
        </listItem>
        <listItem>
          <para>Outgoing Active Directory replication is disabled.</para>
        </listItem>
        <listItem>
          <para>"DSA not writable" is set to a nonzero value in the registry.</para>
        </listItem>
        <listItem>
          <para>The NETLOGON service status is changed from "running" to "paused."</para>
        </listItem>
      </list>
      <para>The dominant root cause for this error condition is a USN rollback discussed in <externalLink><linkText>MSKB 875495 How to detect and recover from a USN rollback in Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;875495</linkUri></externalLink>.</para>
      <para>Do not assume that any nonzero value for "DSA not writable" or that a source or destination server "is currently rejecting replication requests" during DCPROMO or Active Directory Replication definitively means that a USN rollback has occurred and that such domain controllers implicitly have to be force-demoted or force-repromoted. Demotion <placeholder>may</placeholder> be the correct option. However, it may be excessive when the error is caused by insufficient free disk space.</para>

</content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>Check the value for "DSA not writable."</para>
          <para>For each domain controller that is logging the 8456 or 8457 error, determine whether one of the three triggering events automatically disabled incoming or outgoing Active Directory Replication by reading the value for "DSA not writable" from the local registry.</para>
          <para>When replication is automatically disabled, the operating system writes one of four possible values to "DSA not writable":</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <para>Path</para>
                </TD>
                <TD>
                  <para>HKLMSystemCurrentControlSetServicesNTDS</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Setting</para>
                </TD>
                <TD>
                  <para>DSA not writable</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Type</para>
                </TD>
                <TD>
                  <para>(Reg_dword)</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Values</para>
                </TD>
                <TD>
                  <para>#define DSA_WRITABLE_GEN 1</para>
                  <para>#define DSA_WRITABLE_NO_SPACE 2</para>
                  <para>#define DSA_WRITABLE_USNROLLBCK 4</para>
                  <para>#define DSA_WRITABLE_CORRUPT_UTDV 8</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>A value of 1 can be written only when the forest version is incompatible with the operating system (for example, a Windows 2000 domain controller is promoted into a forest at Windows Server 2003 forest functional level, or similar).</para>
          <para>A value of 2 means that the physical or virtual drive that is hosting the Active Directory database or log files lacks sufficient free disk space.</para>
          <para>A value of 4 means that a USN rollback occurred because the Active Directory database was incorrectly rolled back in time. Operations that are known to cause a USN rollback include the following:</para>
          <list class="bullet">
            <listItem>
              <para>The booting from previously saved virtual machine snapshots of domain controller role computers on Hyper-V or VMWARE hosts.</para>
            </listItem>
            <listItem>
              <para>Incorrect physical-to-virtual (P2V) conversions in forests that contain more than one domain controller.</para>
            </listItem>
            <listItem>
              <para>Restoring DC role computers by using imaging products such as Ghost.</para>
            </listItem>
            <listItem>
              <para>Rolling the contents of a partition that is hosting the active directory database back in time by using an advanced disk subsystem.</para>
            </listItem>
          </list>
          <para>A value of 8 indicates that the up-to-dateness-vector is corrupted on the local DC.</para>
          <para>Technically, "DSA not writable" could consist of multiple values. For example, a registry value of 10 would indicate insufficient disk space <placeholder>and</placeholder> a corrupted UTD. Typically, a single value is written to "DSA not writable."</para>
          <alert class="note">
            <para>It is common for support professionals and administrators to partly disable the replication quarantine by enabling outgoing replication, by enabling incoming replication, by changing the startup value for the NETLOGON service from disabled to automatic, and by starting the NETLOGON service. Therefore, the full quarantine configuration may not be in place when it is examined.</para>
          </alert>
        </listItem>
        <listItem>
          <para>Check the Directory Service event log for quarantine events.</para>
          <para>Assuming the Directory Service event log has not wrapped, you may find one or more related events logged in the Directory Service event log of a domain controller that is logging the 8456 or 8457 error.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <para>NTDS General 2103</para>
                </TD>
                <TD>
                  <para>The Active Directory database was restored by using an unsupported restoration procedure. Active Directory will be unable to log on users while this condition persists. Therefore, the Net Logon service has paused. User Action: See previous event logs for more information.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>NTDS General Event 1393</para>
                </TD>
                <TD>
                  <para>There is insufficient space on the disk.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Event 2881</para>
                </TD>
                <TD>
                  <para>Not applicable</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>Perform the recovery based on the value of "DSA not writable" or on events that are logged on the system:</para>
          <list class="bullet">
            <listItem>
              <para>If "DSA not writable" equals 4 or if NTDS General Event 2103 is logged, perform the recovery steps for a USN Rollback. For more information, see Microsoft Knowledge Base article <externalLink><linkText>875495</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;875495</linkUri></externalLink>.</para>
            </listItem>
            <listItem>
              <para>If "DSA not writable" equals 2 or if NTDS General event 1393 is logged, check for sufficient free disk space on the physical and virtual partitions that are hosting the Active Directory database and log files. Free up space as required.</para>
            </listItem>
            <listItem>
              <para>If "DSA not writable" equals 8, demote and then re-promote the domain controller before it can replicate its bad value to other domain controllers in the forest.</para>
            </listItem>
          </list>
        </listItem>
      </list>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 8456 or 8457: "The source | destination server is currently rejecting replication requests"</linkText>
      <linkUri>http://support.microsoft.com/kb/2023007</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>

