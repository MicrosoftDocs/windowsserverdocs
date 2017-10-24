---
ms.assetid: 11dc987a-2c34-4d02-8286-fc7b8f747c46
title: Replication error 8451 The replication operation encountered a database error
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 8451 The replication operation encountered a database error

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This article covers symptoms, root causes, and how to resolve Active Directory replication error 8451: The replication operation encountered a database error. </para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="21a0ba4f-48e5-4a8b-a02a-a92bb0ef36de#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="21a0ba4f-48e5-4a8b-a02a-a92bb0ef36de#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="21a0ba4f-48e5-4a8b-a02a-a92bb0ef36de#BKMK_Resolution">Resolution</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="21a0ba4f-48e5-4a8b-a02a-a92bb0ef36de#BKMK_MoreInfo">More information</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <para>You might encounter one of more of the following symptoms:</para>
      <list class="ordered">
        <listItem>
          <para>On-screen errors, logged events, or diagnostic output identify the existence of a database error, with possible formats as shown in the following table.</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Hex</para>
                </TD>
                <TD>
                  <para>Decimal</para>
                </TD>
                <TD>
                  <para>Symbolic</para>
                </TD>
                <TD>
                  <para>Error String</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>0x2103</para>
                </TD>
                <TD>
                  <para>8451</para>
                </TD>
                <TD>
                  <para>ERROR_DS_DRA_DB_ERROR</para>
                </TD>
                <TD>
                  <para>The replication operation encountered a database error.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>0xfffffc06</para>
                </TD>
                <TD>
                  <para>-1018</para>
                </TD>
                <TD>
                  <para>JET_errReadVerifyFailure</para>
                </TD>
                <TD>
                  <para>Checksum error on a database page</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>0xfffffbe9</para>
                </TD>
                <TD>
                  <para>-1047</para>
                </TD>
                <TD>
                  <para>JET_errInvalidBufferSize</para>
                </TD>
                <TD>
                  <para>Data buffer does not match column size</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>0xfffffbc</para>
                </TD>
                <TD>
                  <para>-1075</para>
                </TD>
                <TD>
                  <para>JET_errOutOfLongValueID</para>
                </TD>
                <TD>
                  <para>Long-value ID counter has reached maximum value. (perform offline defrag to reclaim free/unused LongValueIDs)</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>0xfffffb4a</para>
                </TD>
                <TD>
                  <para>-1206</para>
                </TD>
                <TD>
                  <para>JET_errDatabaseCorrupted</para>
                </TD>
                <TD>
                  <para>Non-database file or corrupted db</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>0xfffffa7a</para>
                </TD>
                <TD>
                  <para>-1414</para>
                </TD>
                <TD>
                  <para>JET_errSecondaryIndexCorrupted</para>
                </TD>
                <TD>
                  <para>Secondary index is corrupt. The database must be defragmented</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>0xfffffa0a</para>
                </TD>
                <TD>
                  <para>-1526</para>
                </TD>
                <TD>
                  <para>JET_errLVCorrupted</para>
                </TD>
                <TD>
                  <para>Corruption encountered in long-value tree</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>0xfffff9bf</para>
                </TD>
                <TD>
                  <para>-1601</para>
                </TD>
                <TD>
                  <para>JET_errRecordNotFound</para>
                </TD>
                <TD>
                  <para>The key was not found</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>0xfffff9b</para>
                </TD>
                <TD>
                  <para>-1603</para>
                </TD>
                <TD>
                  <para>JET_errNoCurrentRecord</para>
                </TD>
                <TD>
                  <para>Currency not on a record</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>DCPROMO fails with error 8451</para>
          <para>Error in DCRPOMO UI</para>
          <code>"The operation failed because:
Active Directory Domain Services could not replicate the directory partition 
&lt;DN path of failing partition&gt; from the remote Active Directory Domain Controller 
&lt;helper DC&gt;.&lt;dns domain name&gt;.&lt;top level domain&gt;.
"The replication operation encountered a database error."
</code>
          <para>Error text from DCPROMO.LOG:</para>
          <code>&lt;date&gt; &lt;time&gt; [INFO] NtdsInstall for contoso.com returned 8451
&lt;date&gt; &lt;time&gt; [INFO] DsRolepInstallDs returned 8451
&lt;date&gt; &lt;time&gt; [ERROR] Failed to install to Directory Service (8451)
&lt;date&gt; &lt;time&gt; [INFO] Starting service NETLOGON
</code>
        </listItem>
        <listItem>
          <para>REPADMIN commands that commonly cite the 8606 status include but are not limited to:</para>
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
Last attempt @ &lt;date&gt; &lt;time&gt; failed, result 8451 (0x2103):
The replication operation encountered a database error.
consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;.
</code>
        </listItem>
        <listItem>
          <para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 8451 status are logged in the directory service event log.</para>
          <para>Active Directory events that commonly cite the 8451 status include but are not limited to:</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
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
                  <para>1039 with extended error 8451</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-ActiveDirectory_DomainService</para>
                </TD>
                <TD>
                  <para>Internal event: Active Directory Domain Services could not process the following object. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1084 with extended error 84511655</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-ActiveDirectory_DomainService</para>
                </TD>
                <TD>
                  <para>Internal event: Active Directory could not update the following object 
with changes received from the following source domain controller. This is because an error occurred during the application of the changes to Active Directory on the domain controller. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1308 with extended error 8451</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-
ActiveDirectory_DomainService</para>
                </TD>
                <TD>
                  <para>The Knowledge Consistency Checker (KCC) has detected that successive attempt to replicate with the following directory service failed.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1699 with extended error 8451</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-
ActiveDirectory_DomainService</para>
                </TD>
                <TD>
                  <para>The local domain controller failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send the change requests to the domain controller at the following network address.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>2108 with extended error 8451 with secondary error value 
-1075</para>
                </TD>
                <TD>
                  <para>NTDS Replication</para>
                </TD>
                <TD>
                  <para>This event contains REPAIR PROCEDURES for the 1084 event which has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made. </para>
                  <code>Object:
CN=justintu@contoso.com,OU=marketing,OU=5thWard,OU=Houston,DC=Contoso,DC=com 
Object GUID:
2843919c-345c-4f57-bc1a-4ed5acbcf9e2 
Source domain controller:
173ee10f-4c28-4acd-a2d7-61af8d4d3010._msdcs.Contoso.com 
User Action
If none of these actions succeed and the replication error continues, you should demote this domain controller and promote it again. 
Additional Data 
Primary Error value:
8451 The replication operation encountered a database error. 
Secondary Error value:
-1075
</code>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>2108 with extended error 8451 with secondary error value 
-1526</para>
                </TD>
                <TD>
                  <para>NTDS Replication</para>
                </TD>
                <TD>
                  <para>This event contains REPAIR PROCEDURES for the 1084 event which has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made. </para>
                  <code>Object:
CN=justintu@contoso.com,OU=marketing,OU=5thWard,OU=Houston,DC=Contoso,DC=com 
Object GUID:
2843919c-345c-4f57-bc1a-4ed5acbcf9e2 
Source domain controller:
173ee10f-4c28-4acd-a2d7-61af8d4d3010._msdcs.Contoso.com 
User Action
If none of these actions succeed and the replication error continues, you should demote this domain controller and promote it again. 
Additional Data 
Primary Error value:
8451 The replication operation encountered a database error. 
Secondary Error value:
-1526
</code>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>2108 with extended error 8451 with secondary error value 
-1414</para>
                </TD>
                <TD>
                  <para>NTDS Replication</para>
                </TD>
                <TD>
                  <para>This event contains REPAIR PROCEDURES for the 1084 event which has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made. </para>
                  <code>
Object:
CN=justintu@contoso.com,OU=marketing,OU=5thWard,OU=Houston,DC=Contoso,DC=com 
Object GUID:
2843919c-345c-4f57-bc1a-4ed5acbcf9e2 
Source domain controller:
173ee10f-4c28-4acd-a2d7-61af8d4d3010._msdcs.Contoso.com 
User Action
If none of these actions succeed and the replication error continues, you should demote this domain controller and promote it again. 
Additional Data 
Primary Error value:
8451 The replication operation encountered a database error. 
Secondary Error value: 
-1414
</code>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1039 with extended error 8451</para>
                </TD>
                <TD>
                  <para>NTDS General</para>
                </TD>
                <TD>
                  <para>Internal event: Active Directory could not process the following object. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1925 with extended error 8451</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The attempt to establish a replication link for the following 
writable directory partition failed. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1084 with extended error 8451</para>
                </TD>
                <TD>
                  <para>NTDS Replication</para>
                </TD>
                <TD>
                  <para>Internal event: Active Directory could not update the following object
with changes received from the following source domain controller. This is because an error occurred during the application of the changes to Active Directory on the domain controller</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1699 with extended error 8451</para>
                </TD>
                <TD>
                  <para>NTDS Replication</para>
                </TD>
                <TD>
                  <para>The local domain controller failed to retrieve the changes requested 
for the following directory partition. As a result, it was unable to 
send the change requests to the domain controller at the following 
network address.</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>The following table lists Event Sources and Event ID that frequently accompany other events that contain the 8451 error.</para>
          <para>Increasing NTDS diagnostic logging levels on the domain controller produces additional events.</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
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
                  <para>1481 with error 
-1601</para>
                </TD>
                <TD>
                  <para>Internal Processing</para>
                </TD>
                <TD>
                  <code>Internal error: The operation on the object failed.
Additional Data: 
Error value: 2 000020EF: NameErr: DSID-032500E8, problem 2001 (NO_OBJECT), data -1601, best match of: "
</code>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1173 with error 
-1075</para>
                </TD>
                <TD>
                  <para>Internal Processing</para>
                </TD>
                <TD>
                  <code>Internal event: Active Directory has encountered the following exception and associated parameters. 
Exception:
e0010004 
Parameter:
0 
Additional Data 
Error value:
-1075 
Internal ID:
205086d
</code>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1173 with error 
-1526</para>
                </TD>
                <TD>
                  <para>Internal Processing</para>
                </TD>
                <TD>
                  <code>Internal event: Active Directory has encountered the following exception and associated parameters. 
Exception:
e0010004 
Parameter:
0 
Additional Data 
Error value:
-1526 
Internal ID:
205036b
</code>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1173 with error 
-1603</para>
                </TD>
                <TD>
                  <para>Internal Processing</para>
                </TD>
                <TD>
                  <code>Internal event: Active Directory has encountered the following exception and associated parameters. 
Exception:
e0010004
Parameter:
0 
Additional Data
Error value:
-1603
Internal ID:
2050344
</code>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>474 with error 
-1018</para>
                </TD>
                <TD>
                  <para>NTDS ISAM</para>
                </TD>
                <TD>
                  <code>The database page read from the file 'E:NTDSDatantds.dit' at offset 3846455296 (0x00000000e5444000) for 8192 (0x00002000) bytes failed verification due to a page checksum mismatch. The expected checksum was 323677604 (0x134aeda4) and the actual checksum was 2081515684 (0x7c1168a4). The read operation will fail with error -1018 (0xfffffc06). If this condition persists then please restore the database from a previous backup. This problem is likely due to faulty hardware. Please contact your hardware vendor for further assistance diagnosing the problem.
</code>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>488</para>
                </TD>
                <TD>
                  <para>NTDS ISAM</para>
                </TD>
                <TD>
                  <code>NTDS (396) NTDSA: Data inconsistency detected in table datatable of database C:WINDOWSNTDSntds.dit (4621,7905).
</code>
                </TD>
              </tr>
            </tbody>
          </table>


</listItem>
        <listItem>
          <para>DCDIAG output:</para>
          <code>Starting test: Replications

* Replications Check
[Replications Check,&lt;DC Name&gt;] A recent replication attempt
failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: &lt;DN path of failing naming context&gt;
The replication generated an error (8451):
The replication operation encountered a database error
</code>
        </listItem>
        <listItem>
          <para>The <ui>Replicate now</ui> command in the Active Directory Sites and Services snap-in DSSITE.MSC returns the following error: "The replication operation encountered a database error." </para>
          <para>Dialog title text:</para>
          <para>Replicate Now</para>
          <para>Dialog message text: </para>
          <para>The following error occurred during the attempt to synchronize naming context &lt;DNS name of directory partition&gt; from domain controller &lt;source DC&gt; 
to domain controller &lt;destination DC&gt;:</para>
          <para>The replication operation encountered a database error.</para>
          <para>This operation will not continue.</para>
        </listItem>
        <listItem>
          <para>Error codes decoded with <externalLink><linkText>Microsoft Exchange Server Error Code Lookup</linkText><linkUri>https://www.microsoft.com/download/en/details.aspx?displaylang=en&amp;id=985</linkUri></externalLink> (err.exe) relating to the 8451 error and accompanying errors:</para>
          <code>C:\&gt;err 8451
# for decimal 8451 / hex 0x2103 :
ERROR_DS_DRA_DB_ERROR winerror.h
# The replication operation encountered a database error.
# 2 matches found for "8451"
C:\&gt;err -1414
# for decimal -1414 / hex 0xfffffa7a :
JET_errSecondaryIndexCorrupted esent98.h
# /* Secondary index is corrupt. The database must be
# defragmented */
# 1 matches found for "-1414"
C:\&gt;err -1526
# for decimal -1526 / hex 0xfffffa0a :
JET_errLVCorrupted esent98.h
# /* Corruption encountered in long-value tree */
# 1 matches found for "-1526"
C:\&gt;err -1603
# for decimal -1603 / hex 0xfffff9bd :
JET_errNoCurrentRecord esent98.h
# /* Currency not on a record */
# 1 matches found for "-1603"
C:\&gt;err -1075
# for decimal -1075 / hex 0xfffffbcd :
JET_errOutOfLongValueIDs esent98.h
# /* Long-value ID counter has reached maximum value.
# (perform offline defrag to reclaim free/unused
# LongValueIDs) */
# 1 matches found for "-1075"
C:\&gt;err -1601
# for decimal -1601 / hex 0xfffff9bf :
JET_errRecordNotFound esent98.h
# /* The key was not found */
# 1 matches found for "-1601"
C:\&gt;err -1047
# for decimal -1047 / hex 0xfffffbe9 :
JET_errInvalidBufferSize esent98.h
# /* Data buffer does not match column size */
# 1 matches found for "-1047"
C:\&gt;err -1018
# for decimal -1018 / hex 0xfffffc06 :
JET_errReadVerifyFailure ese.h
# /* Checksum error on a database page */
JET_errReadVerifyFailure esent98.h
# /* Checksum error on a database page */
# 2 matches found for "-1018"
C:\&gt;err -1206
# for decimal -1206 / hex 0xfffffb4a :
JET_errDatabaseCorrupted esent98.h
# /* Non database file or corrupted db */
# 1 matches found for "-1206"
</code>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>The status 8453: "The replication operation encountered a database error" has multiple root causes. Corrupted Active Directory database or Corrupted Active Directory database index which could be caused by:</para>
      <list class="ordered">
        <listItem>
          <para>Failing hardware</para>
          <list class="ordered">
            <listItem>
              <para>Disk</para>
            </listItem>
            <listItem>
              <para>Controller</para>
            </listItem>
            <listItem>
              <para>Controller cache</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Outdated drivers</para>
          <para>Controller</para>
        </listItem>
        <listItem>
          <para>Outdated firmware</para>
          <list class="ordered">
            <listItem>
              <para>Machine BIOS</para>
            </listItem>
            <listItem>
              <para>Controller</para>
            </listItem>
            <listItem>
              <para>Disk</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Sudden power loss</para>
        </listItem>
        <listItem>
          <para>Lingering objects</para>
        </listItem>
        <listItem>
          <para>Long-value ID counter has reached maximum value</para>
          <para>The ESE column types JET_coltypLongText and JET_coltypLongBinary are called long value column types. These columns are large string and large binary objects that may be stored in separate B+ trees away from the primary index. When long values are stored separate from the primary record, they are internally keyed on a long value ID (LID).</para>
        </listItem>
        <listItem>
          <para>Invalid security descriptor in the <embeddedLabel>msExchSecurityDescriptor</embeddedLabel> attribute</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Resolution">
    <title>Resolution</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>Do not demote and re-promote to resolve the issue unless absolutely necessary. Gather data and make an informed decision.</para>
        </listItem>
        <listItem>
          <para>Enable NTDS diagnostic logging for Replication Events and Internal Processing at a level of 5.</para>
          <para>To increase NTDS diagnostic logging, change the following REG_DWORD values in the registry of the destination domain controller under the following registry key:</para>
          <para>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSDiagnostics</para>
          <para>Set the value of the following subkeys to 5:</para>
          <list class="bullet">
            <listItem>
              <para>5 Replication Events</para>
            </listItem>
            <listItem>
              <para>9 Internal Processing</para>
            </listItem>
          </list>
          <alert class="note">
            <para>Level 5 logging is extremely verbose and the values of both subkeys should be set back to the default of 0 after the problem is resolved. Filtering the Directory Services event log should be performed to isolate and identify these events</para>
          </alert>
        </listItem>
        <listItem>
          <para>Review the event logs for the new events that were generate from the increased logging for error values that will give a definitive view of the original 8451 error. For example, an Internal Processing event ID 1173 with error value of -1526 would indicate that we have a corruption in long-value tree.</para>
        </listItem>
        <listItem>
          <para>Based on the additional information from the increased logging consult the table below for a potential resolution.</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Error (decimal)</para>
                </TD>
                <TD>
                  <para>Error (hex)</para>
                </TD>
                <TD>
                  <para>Symbolic name</para>
                </TD>
                <TD>
                  <para>Error message</para>
                </TD>
                <TD>
                  <para>Potential resolution</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>-1018</para>
                </TD>
                <TD>
                  <para>0xfffffc06</para>
                </TD>
                <TD>
                  <para>JET_errReadVerifyFailure</para>
                </TD>
                <TD>
                  <para>Checksum error on a database page</para>
                </TD>
                <TD>
                  <para>Hardware + firmware + driver check. Restore from backup. Demote/promote.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1047</para>
                </TD>
                <TD>
                  <para>0xfffffbe9</para>
                </TD>
                <TD>
                  <para>JET_errInvalidBufferSize</para>
                </TD>
                <TD>
                  <para>Data buffer does not match column size</para>
                </TD>
                <TD>
                  <para>
                    <externalLink>
                      <linkText>832851</linkText>
                      <linkUri>https://support.microsoft.com/default.aspx?scid=kb;EN-US;832851</linkUri>
                    </externalLink>
                  </para>
                  <para>Inbound Replication Fails on Domain Controllers with Event ID: 1699, Error 8451 or jet error -1601</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1075</para>
                </TD>
                <TD>
                  <para>0xfffffbcd</para>
                </TD>
                <TD>
                  <para>JET_errOutOfLongValueIDs</para>
                </TD>
                <TD>
                  <para>Long-value ID counter has reached maximum value. (perform offline defrag to reclaim free/unused LongValueIDs)</para>
                </TD>
                <TD>
                  <para>Offline Defrag</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1206</para>
                </TD>
                <TD>
                  <para>0xfffffb4a</para>
                </TD>
                <TD>
                  <para>JET_errDatabaseCorrupted</para>
                </TD>
                <TD>
                  <para>Non database file or corrupted db</para>
                </TD>
                <TD>
                  <para>Hardware + firmware + driver check. </para>
                  <para>ESENTUTIL /K + NTDSUTIL FILE INTEGRITY + UTDSUTIL Semantic Database Analysis + Offline Defrag. </para>
                  <para>Otherwise restore from backup or demote/promote</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1414</para>
                </TD>
                <TD>
                  <para>0xfffffa7a</para>
                </TD>
                <TD>
                  <para>JET_errSecondaryIndexCorrupted</para>
                </TD>
                <TD>
                  <para>Secondary index is corrupt. The database must be defragmented</para>
                </TD>
                <TD>
                  <para>Offline Defrag</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1526</para>
                </TD>
                <TD>
                  <para>0xfffffa0a</para>
                </TD>
                <TD>
                  <para>JET_errLVCorrupted</para>
                </TD>
                <TD>
                  <para>Corruption encountered in long-value tree</para>
                </TD>
                <TD>
                  <para>Hardware + firmware + driver check. </para>
                  <para>ESENTUTIL /K + NTDSUTIL FILE INTEGRITY + UTDSUTIL Semantic Database Analysis + Offline Defrag. </para>
                  <para>Otherwise restore from backup or demote/promote</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1601</para>
                </TD>
                <TD>
                  <para>0xfffff9bf</para>
                </TD>
                <TD>
                  <para>JET_errRecordNotFound</para>
                </TD>
                <TD>
                  <para>The key was not found</para>
                </TD>
                <TD>
                  <para>Hardware + firmware + driver check. </para>
                  <para>ESENTUTIL /K + NTDSUTIL FILE INTEGRITY + UTDSUTIL Semantic Database Analysis + Offline Defrag. </para>
                  <para>Otherwise restore from backup or demote/promote</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>-1603</para>
                </TD>
                <TD>
                  <para>0xfffff9bd</para>
                </TD>
                <TD>
                  <para>JET_errNoCurrentRecord</para>
                </TD>
                <TD>
                  <para>Currency not on a record</para>
                </TD>
                <TD>
                  <para>Hardware + firmware + driver check. </para>
                  <para>ESENTUTIL /K + NTDSUTIL FILE INTEGRITY + UTDSUTIL Semantic Database Analysis + Offline Defrag. </para>
                  <para>Otherwise restore from backup or demote/promote</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>8451</para>
                </TD>
                <TD>
                  <para>0x2103</para>
                </TD>
                <TD>
                  <para>ERROR_DS_DRA_DB_ERROR</para>
                </TD>
                <TD>
                  <para>The replication operation encountered a database error</para>
                </TD>
                <TD>
                  <para>Hardware + firmware + driver check. </para>
                  <para>ESENTUTIL /K + NTDSUTIL FILE INTEGRITY + UTDSUTIL Semantic Database Analysis + Offline Defrag. </para>
                  <para>Otherwise restore from backup or demote/promote</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>If all else fails then restore from backup or demote/promote.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_MoreInfo">
    <title>More information</title>
    <content>
      <para>Validate the vertical jet database stack from the bottom up (proceeding up to the next layer only when the underlying layer checks out "good"), just like you do with TCP.</para>
      <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
        <thead>
          <tr>
            <TD>
              <para>Layer</para>
            </TD>
            <TD>
              <para>NTDSUTIL command</para>
            </TD>
            <TD>
              <para>ESENTUTL command</para>
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
              <para>
+</para>
              <para>
ESENTUTL / D</para>
            </TD>
          </tr>
        </tbody>
      </table>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory Operations that fail with error 8451: The replication operation encountered a database error</linkText>
      <linkUri>https://support.microsoft.com/kb/2645996/en-gb</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>


