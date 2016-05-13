---
title: Replication error 1127 While accessing the hard disk, a disk operation failed even after retries
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: b2381837-cd5c-433a-ba9c-37eae91e57c2
---
# Replication error 1127 While accessing the hard disk, a disk operation failed even after retries
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This article describes symptoms, cause and resolution steps for cases where Active Directory operations fail with Win32 error 1127: "While accessing the hard disk, a disk operation failed even after retries."</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="b2381837-cd5c-433a-ba9c-37eae91e57c2#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="b2381837-cd5c-433a-ba9c-37eae91e57c2#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="b2381837-cd5c-433a-ba9c-37eae91e57c2#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>The DCPROMO promotion of a new domain controller fails with error 1127: While accessing the hard disk, a disk operation failed even after retries.</para>
          <para>The on-screen error displayed in DCPROMO is:</para>
          <para>Dialog title text: Active Directory Installation Wizard</para>
          <para>Message text:</para>
          <para>The operation failed because: </para>
          <para>
Active Directory could not replicate the directory partition &lt;DN path of failing partition&gt; from the remote domain controller &lt;fully qualified computer name of helper DC&gt;.</para>
          <para>
"While accessing the hard disk, a disk operation failed even after retries."</para>
          <para>DCPROMO.LOG contains the following text:</para>
          <code>[INFO] Replicating the &lt;partition name&gt; directory partition
[INFO] Error - Active Directory could not replicate the directory partition &lt;partition DN&gt; from the remote domain controller &lt;helper DC&gt;. (1127)
[INFO] NtdsInstall for &lt;DNS domain&gt; returned 1127 
[INFO] DsRolepInstallDs returned 1127 [ERROR] Failed to install to Directory Service (1127)</code>
        </listItem>
<listItem><para>DCDIAG reports that the Active Directory Replications test has failed with error status (1127): While accessing the hard disk, a disk operation failed even after retries. Sample error text from DCDIAG is:</para><code>Testing server: &lt;site&gt;\&lt;DC name&gt;
Starting test: Replications
* Replications Check
[Replications Check,&lt;DC name&gt;] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: DC=&lt;DN path&gt;
<codeFeaturedElement>The replication generated an error (1127):</codeFeaturedElement>
<codeFeaturedElement>While accessing the hard disk, a disk operation failed even after retries.</codeFeaturedElement>
The failure occurred at &lt;date&gt; &lt;time&gt;.
The last success occurred at (never)| &lt;date&gt;.</code></listItem><listItem><para>REPADMIN.EXE reports that the last replication attempt has failed with status 1127.</para><para>REPADMIN commands that commonly cite the 1127 status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><tbody><tr><TD><list class="bullet"><listItem><para>REPADMIN /REPLSUM</para></listItem><listItem><para>REPADMIN /SHOWREPL</para></listItem></list></TD><TD><list class="bullet"><listItem><para>REPADMIN /SHOWREPS</para></listItem><listItem><para>REPADMIN /SYNCALL</para></listItem></list></TD></tr></tbody></table></listItem><listItem><para>The <ui>Replicate now</ui> command in Active Directory Sites and Services returns "While accessing the hard disk, a disk operation failed even after retries." </para><para>Right-clicking on the connection object from a source DC and choosing <ui>Replicate now</ui> fails with "Logon Failure: The target account name is incorrect.” The on-screen error message is shown below:</para><para>Dialog title text:</para><para>Replicate Now</para><para>Dialog message text: </para><para>The following error occurred during the attempt to synchronize naming context &lt;DNS name of directory partition&gt; from domain controller &lt;source DC&gt; 
to domain controller &lt;destination DC&gt;:
While accessing the hard disk, a disk operation failed even after retries.
This operation will not continue.</para></listItem><listItem><para>NTDS KCC, NTDS Replication events with the 1127 status are logged in the Directory Services log in Event Viewer.</para><para>Active Directory events that commonly cite the 1127 status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event ID</para></TD><TD><para>Event Source</para></TD><TD><para>Event String</para></TD></tr></thead><tbody><tr><TD><para>1926</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The attempt to establish a replication link to a read-only directory partition with the following parameters failed.</para></TD></tr><tr><TD><para>1084</para></TD><TD><para>NTDS Replication</para></TD><TD><para>Internal event: Active Directory could not update the following object with changes received from the following source domain controller. This is because an error occurred during the application of the changes to Active Directory on the domain controller. </para></TD></tr><tr><TD><para>1699</para></TD><TD><para>NTDS Replication</para></TD><TD><para>The local domain controller failed to retrieve the changes requested for the following directory partition. </para><para>As a result, it was unable to send the change requests to the domain controller at the following network address. </para></TD></tr><tr><TD><para>2108</para></TD><TD><para>NTDS Replication</para></TD><TD><para>This event contains REPAIR PROCEDURES for the 1084 event which has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made. </para></TD></tr></tbody></table></listItem><listItem><para>NTDS Replication event 2108 may be logged in the Directory Services Event log citing the object, source DC and jet error that is triggering the logging of the 1127 status in on-screen errors, logged events and diagnostic tool output. </para><para>Jet errors known to appear in NTDS Replication event 2108 with status 1127 include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Jet Error (decimal) </para></TD><TD><para>Symbolic Error</para></TD><TD><para>Error string</para></TD></tr></thead><tbody><tr><TD><para>-510</para></TD><TD><para>JET_errLogWriteFail</para></TD><TD><para>Failure writing to log file</para></TD></tr><tr><TD><para>-1018</para></TD><TD><para>JET_errReadVerifyFailure</para></TD><TD><para>Checksum error on a database page</para></TD></tr><tr><TD><para>-1019</para></TD><TD><para>JET_errPageNotInitialized</para></TD><TD><para>Blank database page</para></TD></tr><tr><TD><para>-1021</para></TD><TD><para>JET_errDiskReadVerificationFailure</para></TD><TD><para>The OS returned ERROR_CRC from file IO</para></TD></tr><tr><TD><para>-1022</para></TD><TD><para>JET_errDiskIO</para></TD><TD><para>Disk IO error</para></TD></tr><tr><TD><para>-1605</para></TD><TD><para>JET_errKeyDuplicate</para></TD><TD><para>Illegal duplicate key</para></TD></tr></tbody></table></listItem><listItem><para>NTDS ISAM events may be logged in the Directory Services event log indicating the existence of jet errors related to the 1127 status appearing in other on-screen errors, logged events and diagnostic tool output.</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event Source and Event ID</para></TD><TD><para>Event ID Text</para></TD></tr></thead><tbody><tr><TD><para>NTDS ISAM 474</para></TD><TD><para>The database page read from the file &lt;drive:\path\ntds.dit&gt; at offset &lt;decimal offset&gt; (&lt;hex offset&gt;) for &lt;decimal page size&gt; (&lt;hex page size&gt;) bytes failed verification to a page checksum mismatch…. The read operation will fail with error &lt;decimal jet error&gt; (&lt;hex jet error&gt;). ). If this condition persists then please restore the database from a previous backup. This problem is likely due to faulty hardware. Please contact your hardware vendor for further assistance diagnosing the problem. </para></TD></tr><tr><TD><para>NTDS ISAM 475</para></TD><TD><para>The database page read from the file &lt;drive:\path\ntds.dit&gt; at offset &lt;decimal offset&gt; (&lt;hex offset&gt;) for &lt;decimal page size&gt; (&lt;hex page size&gt;) bytes failed verification to a page number mismatch…. The read operation will fail with error &lt;decimal jet error&gt; (&lt;hex jet error&gt;). ). </para><para>If this condition persists then please restore the database from a previous backup. This problem is likely due to faulty hardware. Please contact your hardware vendor for further assistance diagnosing the problem.</para></TD></tr></tbody></table></listItem>
</list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>Active Directory is unable to write to the Active Directory database or log files. Root causes include:</para>
      <list class="ordered">
        <listItem>
          <para>Software on the local machine is interfering with the ability of Active Directory to write changes to the Active Directory database or log files.</para>
        </listItem>
        <listItem>
          <para>A defect exists in the disk subsystem including the motherboard, driver controller, firmware, driver, physical drives.</para>
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
            <embeddedLabel>Locate NTDS replication event 1084 events in the Directory Services Event Log</embeddedLabel>
          </para>
          <para>For DCs logging the 1127 status, open the Directory Service Event log and focus on NTDS Replication event 1084. </para>
          <para>NTDS Replication Event 1084 indicates that Active Directory could not write updates to an object in its local copy of Active Directory. </para>
          <para>Metadata in the Event 1084 identifies:</para>
          <list class="ordered">
            <listItem>
              <para>The DN path (and thus the objects host partition) that could not be updated</para>
            </listItem>
            <listItem>
              <para>The objectGUID for the object in question</para>
            </listItem>
            <listItem>
              <para>The fully qualified CNAME record of the source DC that is sending the update</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Locate the NTDS Replication Event 2108 logged immediately following each NTDS Replication 1084 event and identify the jet error logged in the 2108 event.</para>
          <para>NTDS Replication event 2108 is the "User Action" for the NTDS Replication 1084 event.</para>
          <para>For every NTDS replication 1084 event logged, there should be a corresponding NTDS replication 2108 event logged in the Directory Services event log that cites (1.) the same object DN path and (2.) objectguid and (3.) source DC logged in the preceding NTDS Replication 1084 event AND a jet error that defines / scopes the cause and your recovery plan to resolve the error condition.</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Execute the action plan for the Jet error logged in your NTDS Replication Event 2108:</embeddedLabel>
          </para>
          <para>If the Jet error logged in your NTDS replication events is listed in the table below, execute the user action, otherwise, skip to step 4.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Jet Error (decimal) </para>
                </TD>
                <TD>
                  <para>Symbolic Error + Error String</para>
                </TD>
                <TD>
                  <para>User Action</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>-510</para>
                </TD>
                <TD>
                  <para>JET_errLogWriteFail / 
Failure writing to log file</para>
                </TD>
                <TD>
                  <para>A log write failure occurred on the destination DC. </para>
                  <para>

Check disk, partition and file system health on the destination DC. </para>
                  <para>

Check for software that may be creating locks on Active Directory log files such as antivirus software on the destination DC. </para>
                  <para>

See if problem persists following reboot or try clean boot</para>
                  <para>

Method 1: Stop services that create locks on files in the file system and focusing specifically on antivirus software. </para>
                  <para>

Method 2: Press F8 during OS boot and chose "Safe Mode with Networking". 
</para>
                  <para>
Method 3: Disable non-boot related 3rd party services. Reboot. 
</para>
                  <para>
Windows key + R -&gt; MSCONFIG -&gt; Services tab - &gt; Hide all Microsoft
Services -&gt; Disable checkbox for 3rd-party services
</para>
                  <para>
Windows key + R -&gt; MSCONFIG -&gt; Startup tab - &gt; Hide all Microsoft
Services -&gt; click "Disable all"</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1018</para>
                </TD>
                <TD>
                  <para>JET_errReadVerifyFailure /
Checksum error on a database page</para>
                </TD>
                <TD>
                  <para>DB is corrupt
</para>
                  <para>
Error caused by a hardware failure. 
</para>
                  <para>
Evaluate the disk stack including motherboard / controller, firmware, connecting cables and physical drives. and contact the relevant vendors for known issues. Compare current configuration against vendor’s reference configuration.
</para>
                  <para>
Evaluate whether problem can be resolved by latest firmware updates or was triggered by recent firmware update.
</para>
                  <para>
If some DCs are logging -1018s while other DCs in same environment are not, looks for differences in hardware configuration.
</para>
                  <para>
Databases logging this error cannot be recovered or repaired by integrity checks or semantic database analysis in NTDSUTIL or ESENTUTL. 
</para>
                  <para>
Offline defrags may resolve the problem in the unlikely case that problem is caused by an index consistency problem.
</para>
                  <para>
Try an offline defrag. Otherwise, restore a system state backup that pre-dates the corruption, OR force demote, perform a full metadata cleanup, and re-promote. If the -1018 error appears, repeat until hardware root cause is resolved. </para>
                  <para>One customer reported jet error -1018s on virtualized DCs running on the same virtual host only on computers using an on-board raid controller. Current thinking is that the UPS lacked sufficient power for on-board raid controllers to commit changes to disk following loss of electrical power. Workaround was to configure UPS software to shut down virtualized guests on loss of electrical power. Servers with dedicated (not on-board) raid controllers with their own battery backups did not experience the -1018 jet error.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1019</para>
                </TD>
                <TD>
                  <para>JET_errPageNotInitialized /
Blank database page</para>
                </TD>
                <TD>
                  <para>Similar to -1018 error but caused by a lost page flush.
</para>
                  <para>
A lost flush can represent a critical USN change. Failure to apply same to local DC or transitive replication partners could be harmful where a single replication path exists. 
</para>
                  <para>
Deploy OS on server class hardware and disk subsystem components
</para>
                  <para>
Install UPS on host computer. 
</para>
                  <para>
Install disk controller with battery backup. 
</para>
                  <para>
Disable write-back cache on drive controller.
</para>
                  <para>
Avoid placing NTDS.DIT and LOG files on IDE drives
</para>
                  <para>
Databases logging this error cannot be recovered or repaired by integrity checks or semantic database analysis in NTDSUTIL or ESENTUTL. 
</para>
                  <para>
Offline defrags may resolve the problem in the unlikely case that problem is caused by index consistency problem.
</para>
                  <para>
Try an offline defrag, otherwise, restore a system state backup that pre-dates the corruption, OR force demote, perform a full metadata cleanup, and re-promote. Repeat until hardware root cause is resolved.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1021</para>
                </TD>
                <TD>
                  <para>JET_errDiskReadVerificationFailure / The OS returned ERROR_CRC from file IO</para>
                </TD>
                <TD>
                  <para>Jet error -1021 is new to Windows Server 2008 R2.
</para>
                  <para>
Pre-Windows Server 2008 R2 operating systems return -1022 for this case. 
</para>
                  <para>
-1021 identifies that a -1018 error occurred at the disk level. Restated, -1021 indicates that a disk drive returned a bad check sum error and is the specific source of the problem in the disk stack. 
</para>
                  <para>
Problem may be caused by bad blocks on the hard drive which the hard drive may keep track of. 
</para>
                  <para>
Demoting and re-promoting the domain controller may trigger the storage of data on healthy blocks. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1022</para>
                </TD>
                <TD>
                  <para>JET_errDiskIO / Disk IO error</para>
                </TD>
                <TD>
                  <para>Generic disk error 
</para>
                  <para>
Disk IO errors mean that the OS encountered a non-specific error accessing the disk. This error may be logged when controllers return generic errors like "device not working". Some disks and versions of jet return this error for CRC problems.</para>
                  <para>

Check whole driver stack. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1605</para>
                </TD>
                <TD>
                  <para>JET_errKeyDuplicate / Illegal duplicate key</para>
                </TD>
                <TD>
                  <para>Sporadic error. </para>
                  <para>
Demote and repromote. 
May be caused by index corruption. </para>
                  <para>
Run NTDUSITL semantic database analysis. If still unresolved, perform an offline defrag. </para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>If the Jet error in the NTDS replication event is NOT in table above, validate the vertical Jet database stack</embeddedLabel>
          </para>
          <para>If the 2108 event logs a jet error NOT cited in the table, use the <externalLink><linkText>Microsoft Exchange Server Error Code Look-up</linkText><linkUri>http://www.microsoft.com/download/en/details.aspx?displaylang=en&amp;id=985</linkUri></externalLink> utility to resolve the jet error to its symbolic and friendly error string using the syntax "err &lt;jet error&gt;". It is critical that you add the leading "-" prefix character when resolving jet errors using ERR.EXE. (eg. "c:\&gt;err -1018").</para>
          <para>The event message text in NTDS Replication event 2108 contains a partial user action for the NTDS Replication 1084 event.</para>
          <para>The NTDS Replication 2108 user action is documented in the linked <externalLink><linkText>KB article 837932</linkText><linkUri>http://support.microsoft.com/kb/837932</linkUri></externalLink>. If the user action for your event is not cited in the table above, execute a modified version of the action plan in article 837932 by validating the vertical jet database stack from the bottom up (proceeding up to the next layer only when the underlying layer checks out "good"), just like you do with TCP.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Layer</para>
                </TD>
                <TD>
                  <para>NTDSUTIL command</para>
                </TD>
                <TD>
                  <para>ESENTUTL</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>Physical consistency</para>
                </TD>
                <TD>
                  <para>no equivalent</para>
                </TD>
                <TD>
                  <para>ESENTUTL /K</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>ESE Logical consistency</para>
                </TD>
                <TD>
                  <para>NTDSUTIL FILES INTEGRITY</para>
                </TD>
                <TD>
                  <para>ESENTUTL /G</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Application logical consistency</para>
                </TD>
                <TD>
                  <para>NTDSUTIL -&gt;Semantic database analysis</para>
                  <para>+</para>
                  <para>NTDSUTIL -&gt; Offline Defrag</para>
                </TD>
                <TD>
                  <para>no equivalent for SDA</para>
                  <para>+</para>
                  <para>ESENTUTL / D</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
      </list>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 1127: While accessing the hard disk, a disk operation failed even after retries</linkText>
      <linkUri>http://support.microsoft.com/kb/2025726</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>

