---
ms.assetid: c84c866c-0f72-4fd3-b609-0e00560703eb
title: Replication error 5 Access is denied
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 5 Access is denied

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic explains symptoms, causes and how to resolve Active Directory replication error 5: Access is denied.</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="87acf6ce-5166-4ab4-b8d7-42b03bab226a#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="87acf6ce-5166-4ab4-b8d7-42b03bab226a#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="87acf6ce-5166-4ab4-b8d7-42b03bab226a#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <para>This article describes the symptoms, cause and resolution steps for situations where Active Directory replication operations fail with error 5: Access is denied.</para>
      <list class="ordered">
        <listItem>
          <para>DCDIAG reports that Active Directory Replications test has failed with error status code (5): "access is denied:"</para>
          <code>Testing server: &lt;site name&gt;&lt;destination dc name&gt;
Starting test: Replications
* Replications Check
[Replications Check,&lt;destination DC name] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: &lt;directory partition DN path&gt;
<codeFeaturedElement>The replication generated an error (5):
Access is denied</codeFeaturedElement>.
The failure occurred at &lt;date&gt; &lt;time&gt;.
The last success occurred at &lt;date&gt; &lt;time&gt;.
3 failures have occurred since the last success.</code>
        </listItem>
<listItem><para>REPADMIN.EXE reports that the last replication attempt has failed with status 5.</para><para>REPADMIN commands that commonly cite the 5 status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><tbody><tr><TD><list class="bullet"><listItem><para>REPADMIN /KCC</para></listItem><listItem><para>REPADMIN /REPLICATE</para></listItem><listItem><para>REPADMIN /REPLSUM</para></listItem></list></TD><TD><list class="bullet"><listItem><para>REPADMIN /SHOWREPL</para></listItem><listItem><para>REPADMIN /SHOWREPS</para></listItem><listItem><para>REPADMIN /SYNCALL</para></listItem></list></TD></tr></tbody></table><para>The following sample output from "REPADMIN /SHOWREPS" shows inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the "replication access was denied" error:</para><code>Default-First-Site-NameCONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01
DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01
==== INBOUND NEIGHBORS ======================================
DC=contoso,DC=com
Default-First-Site-NameCONTOSO-DC2 via RPC
DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2
Last attempt @ &lt;date&gt; &lt;time&gt; failed, <codeFeaturedElement>result 5(0x5):
Access is denied.</codeFeaturedElement>
&lt;#&gt; consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;.
</code></listItem><listItem><para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 5 status are logged in the Directory Services log in Event Viewer.</para><para>Active Directory events that commonly cite the 5 status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event ID</para></TD><TD><para>Event Source</para></TD><TD><para>Event String</para></TD></tr></thead><tbody><tr><TD><para>1655</para></TD><TD><para>NTDS General</para></TD><TD><para>Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.</para></TD></tr><tr><TD><para>1925</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The attempt to establish a replication link for the following writable directory partition failed.</para></TD></tr><tr><TD><para>1926</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The attempt to establish a replication link to a read-only directory partition with the following parameters failed.</para></TD></tr></tbody></table></listItem><listItem><para>The <ui>Replicate now</ui> command in Active Directory Sites and Services returns "Access is denied."</para><para>Right-clicking on the connection object from a source DC and choosing "replicate now" fails with "Access is denied. The on-screen error message text and screenshot is shown below:</para><para>Dialog title text: Replicate Now</para><para>Dialog message text: </para><para>The following error occurred during the attempt to synchronize naming context &lt;%directory partition name%&gt; from Domain Controller &lt;Source DC&gt; to Domain Controller &lt;Destination DC&gt;:</para><para>
Access is denied</para><para>The operation will not continue</para><para>&lt;insert ADDS_ReplError_AccessIsDenied&gt;</para></listItem>
</list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>Valid root causes for error 5: "access is denied" include:</para>
      <list class="ordered">
        <listItem>
          <para>The "Access this computer from network" user right is not granted to the "Enterprise Domain Controllers" group or the administrator triggering immediate replication.</para>
        </listItem>
        <listItem>
          <para>The "CrashOnAuditFail" setting in the registry of the destination DC has a value of 2.</para>
        </listItem>
        <listItem>
          <para>There is a time difference between the KDC used by the destination DC and the source DC that exceeds the maximum time skew allowed by Kerberos defined in Default Domain Policy.</para>
        </listItem>
        <listItem>
          <para>There is an SMB signing mismatch between the source and destination DCs.</para>
        </listItem>
        <listItem>
          <para>There is an LMCompatiblity mismatch between the source and destination DCs.</para>
        </listItem>
        <listItem>
          <para>Service principal names are either not registered or not present due to simple replication latency or a replication failure.</para>
        </listItem>
        <listItem>
          <para>UDP formatted Kerberos packets are being fragmented by network infrastructure devices like routers and switches.</para>
        </listItem>
        <listItem>
          <para>The secure channel on the source or destination DC is invalid.</para>
        </listItem>
        <listItem>
          <para>Trust relationships in the trust chain are broken or invalid.</para>
        </listItem>
        <listItem>
          <para>The KDCNames setting in the HKLMSystemCurrentControlSetControlLSAKerberosDomains section of the registry incorrectly contains the local Active Directory domain name</para>
        </listItem>
        <listItem>
          <para>Some network adapters have a "Large Send Offload" feature that has been known to cause this issue.</para>
        </listItem>
        <listItem>
          <para>Antivirus software that uses a mini-firewall network adapter filter driver on the source or destination DC has been known to cause this issue.</para>
        </listItem>
      </list>
      <para>Active Directory errors and events like those cited in the symptoms section of this topic can also fail with error 8453 with similar error string "Replication Access was denied." The following root cause reasons can cause AD operations to fail with 8453: "replication access was denied" but do not cause failures with error 5: "replication is denied":</para>
      <list class="ordered">
        <listItem>
          <para>NC head not granted the "replicating directory changes" permission.</para>
        </listItem>
        <listItem>
          <para>The security principal initiating replication is not a member of a group that has been granted "replicating directory changes."</para>
        </listItem>
        <listItem>
          <para>Missing flags in the <embeddedLabel>UserAccountControl</embeddedLabel> attribute including SERVER_TRUST_ACCOUNT and TRUSTED_FOR_DELEGATION.</para>
        </listItem>
        <listItem>
          <para>An RODC was promoted into the domain without previously running ADPREP /RODCPREP.</para>
        </listItem>
      </list>
      <para>For more information, see Active Directory replication error 8453: Replication access was denied. </para>
    </content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <para>There are multiple root causes for Active Directory Replication failing with error 5. Attack the problem initially by using tools like DCDIAG, DCDIAG /TEST:CheckSecurityError and NETDIAG to expose common problems. </para>
      <para>Run DCDIAG, DCDIAG /TEST:CheckSecurityError and NETDIAG</para>
      <para>The generic DCDIAG runs multiple tests. <embeddedLabel>DCDIAG /TEST:CheckSecurityErrors</embeddedLabel> was written to perform specific tests (including an SPN registration check) to troubleshoot Active Directory operations replication failing with error 5: "access is denied" and error 8453: "replication access was denied" but is NOT run as part of the default execution of DCDIAG.</para>
      <list class="ordered">
        <listItem>
          <para>Run DCDIAG on the destination DC.</para>
        </listItem>
        <listItem>
          <para>Run DCDAIG /TEST:CheckSecurityError</para>
        </listItem>
        <listItem>
          <para>Run NETDIAG</para>
        </listItem>
        <listItem>
          <para>Resolve any faults identified by DCDIAG and NETDIAG. Retry the previously failing replication operation. If still failing, proceed to the next Resolution options.</para>
        </listItem>
      </list>
      <list class="ordered">
        <listItem>
          <para>Check "Access this computer from network" rights</para>
          <para>In a default installation of Windows, the Default Domain Controllers Policy is linked to the domain controllers OU and it grants the "Access this computer from network" user right to the following security groups:</para>
          <list class="bullet">
            <listItem>
              <para>Administrators</para>
            </listItem>
            <listItem>
              <para>Authenticated Users</para>
            </listItem>
            <listItem>
              <para>Everyone</para>
            </listItem>
            <listItem>
              <para>Enterprise Domain Controllers</para>
            </listItem>
            <listItem>
              <para>[Pre-Windows 2000 compatible access]</para>
            </listItem>
          </list>
          <para>If Active Directory operations are failing with error 5: "access is denied", verify that:</para>
          <list class="bullet">
            <listItem>
              <para>Security groups in the list above have been granted the "Access this computer from network" user right in the Default Domain Controllers Policy.</para>
            </listItem>
            <listItem>
              <para>Domain controller computer accounts are located in the <ui>Domain Controllers</ui> OU.</para>
            </listItem>
            <listItem>
              <para>Default Domain Controllers Policy is linked to the <ui>Domain Controllers</ui> OU or alternate OUs hosting computer accounts.</para>
            </listItem>
            <listItem>
              <para>Group Policy is applying on the destination domain controller currently logging error 5.</para>
            </listItem>
            <listItem>
              <para>"Deny access this computer from network" user right has NOT been enabled or does not reference failing direct or nested groups.</para>
            </listItem>
            <listItem>
              <para>Group Policy precedence, blocked inheritance, WMI filtering or similar settings do NOT prevent the "Access this computer from network" user right from applying to domain controllers.</para>
            </listItem>
          </list>
          <para>Group Policy settings can be validated with RSOP.MSC but "GPRESULT /Z" is the preferred tool because it is more accurate.</para>
          <para>Note: Local policy takes precedence over policy defined in Sites, Domains and OU.</para>
          <para>Note: At one time it was common for administrators to remove the <ui>Enterprise Domain Controllers</ui> and <ui>Everyone</ui> groups from the "Access this computer from network" user right in Default Domain Controllers Policy. Removing both is ill advised. There is no reason to remove <ui>Enterprise Domain Controllers</ui> from this right as only domain controllers are a member of this group.</para>
</listItem>
        <listItem>
          <para>CrashOnAuditFail=2</para>
          <para>Active Directory replication fails when HKLMSystemCurrentControlSetControlLSACrashOnAuditFail has a value of "2".</para>
          <para>A CrashOnAduitFail value of 2 is triggered when the "Audit: Shut down system immediately if unable to log security audits" setting in Group Policy has been enabled AND the local Security log in Event Viewer becomes full.</para>
          <para>Active Directory domain controllers are especially prone to maximum capacity Security logs when auditing has been enabled AND the size of the Security event log has been constrained by the "Do not overwrite events (clear log manually) or "Overwrite as needed" options in Event Viewer or Group Policy equivalents.</para>
          <para>
            <embeddedLabel>User Action</embeddedLabel>
          </para>
          <para>If HKLMSystemCCSControlLSACrashOnAuditFail has a value of "2": </para>
          <list class="ordered">
            <listItem>
              <para>Clear the security event log (save to alternate location as required).</para>
            </listItem>
            <listItem>
              <para>Re-evaluate any size constraints on the Security event log, including Group Policy settings. </para>
            </listItem>
            <listItem>
              <para>Recreate "CrashOnAuditFail (REG_DWORD) with a value of 1.</para>
            </listItem>
            <listItem>
              <para>Reboot.</para>
            </listItem>
          </list>
          <para>
            <embeddedLabel>Related Content</embeddedLabel>
          </para>
          <para>
            <externalLink>
              <linkText>MSKB 888179</linkText>
              <linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;888179</linkUri>
            </externalLink>: Issues that occur when the CrashOnAuditFail registry value is set to 1 on an Exchange computer or that occur when the Security event log reaches the maximum size in Windows 2000 Server</para>
          <para>
            <externalLink>
              <linkText>MSKB 140058</linkText>
              <linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;140058</linkUri>
            </externalLink>: How To Prevent Auditable Activities When Security Log Is Full</para>
        </listItem>
        <listItem>
          <para>Excessive Time Skew</para>
          <para>Kerberos Group Policy settings in the Default Domain Policy allow for a 5 minute difference (default value) in system time between Key Distribution Center (KDC) domain controllers and a Kerberos target servers in order to prevent replay attacks. Some documentation states that time between the client and the Kerberos target must have time within 5 minutes of each other. Others state that in the context of Kerberos authentication, the time that matters is the delta between the KDC used by the caller and the time on the Kerberos target. Also, whether system time on the relevant DCs matches current time is not significant to Kerberos, only that <placeholder>relative</placeholder> time difference between the KDC and target DC is inside the (default 5 minutes or less) maximum time skew allowed by Kerberos policy.</para>
          <para>In the context of Active Directory operations, the target server is the source DC being contacted by the destination DC. Every domain controller in an Active Directory forest (currently running the KDC service) is a potential KDC so you need to consider time accuracy on all other DCs against the source DC including time on the destination DC itself.</para>
          <para>Two methods to check time accuracy include:</para>
          <code>C:&gt;DCDIAG /TEST:CheckSecurityError</code>
          <para>And</para>
          <code>C:&gt;W32TM /MONITOR</code>
          <para>Sample output from DCDIAG /TEST:CheckSecurityError depicting excessive time skew on Windows Server 2003 and Windows Server 2008 R2 domain controllers can be found in the <link xlink:href="87acf6ce-5166-4ab4-b8d7-42b03bab226a#BKMK_MoreInfo">More Information</link> section of this article.</para>
          <para>Look for LSASRV 40960 events on the destination DC at the time of the failing replication request that cite a GUID in the CNAME record of the source DC with extended error 0xc000133: "the time at the Primary Domain Controller is different than the time at the Backup Domain Controller or member server by too large an amount."</para>
          <para>Network traces capturing the destination computer connecting to a shared folder on the source DC (as well as other operations) may show the on-screen error "an extended error has occurred." while a network trace shows:</para>
          <code>-&gt; KerberosV5 KerberosV5:TGS Request Realm: &lt;- TGS request from source DC 
&lt;- Kerberosvs Kerberosvs:KRB_ERROR - KRB_AP_ERR_TKE_NVV (33) &lt;- TGS response where "KRB_AP_ERR_TKE_NYV
&lt;- maps to "Ticket not yet valid"</code>
          <para>The TKE_NYV response indicates that the date range on the TGS ticket is newer than time on the target, indicating excessive time skew. </para>
          <para>Note: W32TM /MONITOR only checks time on DCs in the test computers domain so you need to run this in each domain and compare time between the domains. </para>
          <para>Note: if system time was found to be inaccurate, make an effort to figure out why and what can be done to prevent inaccurate time going forward. Was the forest root PDC configured with an external time source? Are reference time sources online and available on the network? Was the time service running? Are DC role computers configured to use NT5DS hierarchy to source time? Was time rollback protection described in <externalLink><linkText>MSKB 884776</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;884776</linkUri></externalLink> in place? Do system clocks have good batteries and accurate time in the bios? Are virtual host and guest computers configured to source time correctly? </para>
          <para>Note: When the time difference is too great on Windows Server 2008 R2 destination DCs, the <ui>Replicate now</ui> command in DSSITE.MSC fails with the on-screen error "There is a time and / or date difference between the client and the server." This error string maps to error 1398 decimal / 0x576 hex with symbolic error name ERROR_TIME_SKEW. </para>
          <para>
            <embeddedLabel>Related Content </embeddedLabel> </para>
          <para>
            <externalLink>
              <linkText>Setting Clock Synchronization Tolerance to Prevent Replay Attacks</linkText>
              <linkUri>http://technet.microsoft.com/library/cc784130(WS.10).aspx</linkUri>
            </externalLink> (http://technet.microsoft.com/library/cc784130(WS.10).aspx)</para>
        </listItem>
        <listItem>
          <para>SMB signing mismatch</para>
          <para>The best compatibility matrix for SMB signing is documented in the graphic and text "interoperability matrix" sections of <externalLink><linkText>MSKB 916846</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;916846</linkUri></externalLink> and is defined by four policy settings and their registry-based equivalents:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Policy Setting</para>
                </TD>
                <TD>
                  <para>Registry Path</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>Microsoft network client: Digitally sign communications (if server agrees)</para>
                </TD>
                <TD>
                  <para>HKLMSYSTEMCCSServicesLanmanworkstationParametersEnablesecuritysignature</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Microsoft network client: Digitally sign communications (always)</para>
                </TD>
                <TD>
                  <para>HKLMSYSTEMCCSServicesLanmanworkstationParametersRequiresecuritysignature</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Microsoft network server: Digitally sign communications (if server agrees)</para>
                </TD>
                <TD>
                  <para>HKLMSYSTEMCCSServicesLanmanserverParametersEnablesecuritysignature</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Microsoft network server: Digitally sign communications (always)</para>
                </TD>
                <TD>
                  <para>HKLMSYSTEMCCSServicesLanmanserverParametersRequiresecuritysignature</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Focus on SMB signing mismatches between the destination and source domain controllers with the classic cases being the setting enabled or required on one side but disabled on the other. </para>
          <para>Note: internal testing showed SMB signing mismatches causing replication to fail with error 1722: The RPC Server is unavailable.</para>
        </listItem>
        <listItem>
          <para>UDP formatted Kerberos packet fragmentation</para>
          <para>Network routers and switches may fragment or completely drop large UDP formatted network packets used by Kerberos and EDNS0 (DNS). Computers running Windows 2000 and Windows Server 2003 operating system families are particularly vulnerable to UDP fragmentation relative to computers running Windows Server 2008 and Windows Server 2008 R2.</para>
          <para>
            <embeddedLabel>User Action</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>From the console of the destination DC, ping the source DC by its fully qualified computer name to identify the largest packet supported by the network route.</para>
              <code>c:&gt;Ping &lt;source DC hostname&gt;.&lt;fully qualified computer name&gt; -f -l 1472</code>
            </listItem>
            <listItem>
              <para>If the largest non-fragmented packet is less than 1472 bytes, either (in order of preference):</para>
              <list class="bullet">
                <listItem>
                  <para>Modify your network infrastructure to properly support large UDP frames. This may require a firmware upgrade or configuration change on routers, switches or firewalls.</para>
                </listItem>
              </list>
              <para>Or</para>
              <list class="bullet">
                <listItem>
                  <para>Set maxpacketsize (on the destination DC) to the largest packet identified by the PING -f -l command less 8 bytes to account for the TCP header and reboot the modified DC.</para>
                </listItem>
              </list>
              <para>Or</para>
              <list class="bullet">
                <listItem>
                  <para>Set maxpacketsize (on the destination DC) to a value of "1" which triggers Kerberos to use a TCP. Reboot the modified DC to make the change take effect.</para>
                </listItem>
              </list>
            </listItem>
            <listItem>
              <para>Retry the failing Active Directory operation.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Invalid Secure channel / Password Mismatch</para>
          <para>Validate the secure channel with "nltest /sc:query" or "netdom verify". 
On condition, reset the destination DCs password with NETDOM /RESETPWD as described in multiple articles including <externalLink><linkText>MSKB 325850</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;325850</linkUri></externalLink>.</para>
          <para>
            <embeddedLabel>User Action</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Disable the KDC service on the DC being rebooted.</para>
            </listItem>
            <listItem>
              <para>From the console of the destination DC, run NETDOM RESETPWD to reset the password for the destination DC.</para>
              <code>:&gt;netdom resetpwd /server: server_name /userd: domain_name administrator /passwordd: administrator_password</code>
            </listItem>
            <listItem>
              <para>Ensure that likely KDCs AND the source DC (if in the same domain) inbound replicate knowledge of the destination DCs new password.</para>
            </listItem>
            <listItem>
              <para>Reboot the destination DC to flush Kerberos tickets and retry the replication operation.</para>
            </listItem>
          </list>
          <para>
            <embeddedLabel>Related Content</embeddedLabel>
          </para>
          <para>
            <externalLink>
              <linkText>MSKB 325850</linkText>
              <linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;325850</linkUri>
            </externalLink> How to use Netdom.exe to reset machine account passwords of a Windows Server domain controller</para>
        </listItem>
        <listItem>
          <para>Invalid Trust</para>
          <para>If Active Directory replication is failing between DCs in <placeholder>different</placeholder> domains, verify the health of the trust relationship along the trust path.</para>
          <para>When able, use the <embeddedLabel>NETDIAG Trust Relationship</embeddedLabel> test to check for broken trusts. NETDIAG identifies broken trusts with the following text:</para>
          <para>Trust relationship test. . . . . . : Failed Test to ensure DomainSid of domain '&lt;domainname&gt;' is correct. [FATAL] Secure channel to domain '&lt;domainname&gt;' is broken. [&lt;%variable status code%&gt;]</para>
          <para>For example, if you have a multidomain forest containing root domain Contoso.COM, child domain B.Contoso.COM, grandchild domain C.B.Contoso.COM and "tree domain in same forest" Fabrikam.COM where replication is failing between DCs in grandchild domain C.B.Contoso.COM and tree domain Fabrikam.COM, then verify trust health between C.B.Contoso.COM and B.Contoso.COM, B.Contoso.COM and Contoso.COM then finally Contoso.COM and Fabrikam.COM.</para>
          <para>If a short cut trust exists between the destination domains, the trust path chain does not have to be validated. Instead validate the short cut trust between the destination and source domain.</para>
          <para>Check for recent password changes to the trust: </para>
          <code>Repadmin /showobjmeta * &lt;DN path for Trusted Domain Object (TDO) in question&gt;</code>
          <para>
            <embeddedLabel>Commands to reset trusts</embeddedLabel>
          </para>
          <para>From forest root domain PDC emulator:</para>
          <code>netdom trust &lt;Root Domain&gt; /Domain:&lt;Child Domain&gt; /UserD:CHILD /PasswordD:* /UserO:ROOT /PasswordO:* /Reset /TwoWay</code>
          <para>From child domain PDC emulator:</para>
          <code>netdom trust &lt;Child Domain&gt; /Domain:&lt;Root Domain&gt; /UserD:Root /PasswordD:* /UserO:Child /PasswordO:* /Reset /TwoWay</code>
        </listItem>
        <listItem>
          <para>Invalid Kerberos realm - PolAcDmN / PolPrDmN </para>
          <para>Copied from <externalLink><linkText>MKSB 837513</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;837513</linkUri></externalLink> Domain controller is not functioning correctly</para>
          <list class="ordered">
            <listItem>
              <para>Start Registry Editor.</para>
            </listItem>
            <listItem>
              <para>In the left pane, expand Security.</para>
            </listItem>
            <listItem>
              <para>On the Security menu, click Permissions to grant the Administrators local group Full Control of the SECURITY hive and its child containers and objects.</para>
            </listItem>
            <listItem>
              <para>Locate the HKEY_LOCAL_MACHINESECURITYPolicyPolPrDmN key.</para>
            </listItem>
            <listItem>
              <para>In the right pane of Registry Editor, click the &lt;No Name&gt;: REG_NONE entry one time.</para>
            </listItem>
            <listItem>
              <para>On the View menu, click Display Binary Data. In the Format section of the dialog box, click Byte.</para>
            </listItem>
            <listItem>
              <para>The domain name appears as a string in the right side of the Binary Data dialog box. The domain name is the same as the Kerberos realm.</para>
            </listItem>
            <listItem>
              <para>Locate the HKEY_LOCAL_MACHINESECURITYPolicyPolACDmN registry key.</para>
            </listItem>
            <listItem>
              <para>In the right pane of Registry Editor, double-click the &lt;No Name&gt;: REG_NONE entry.</para>
            </listItem>
            <listItem>
              <para>In the Binary Editor dialog box, paste the value from PolPrDmN. (The value from PolPrDmN will be the NetBIOS domain name).</para>
            </listItem>
            <listItem>
              <para>Restart the domain controller.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Invalid Kerberos realm - KdcNames</para>
          <para>
            <embeddedLabel>User Action</embeddedLabel>
          </para>
          <list class="ordered">
            <listItem>
              <para>On the console of the destination DC, run "REGEDIT".</para>
            </listItem>
            <listItem>
              <para>Locate the following path in the registry: HKLMsystemccscontrollsakerberosdomains</para>
            </listItem>
            <listItem>
              <para>For each &lt;fully qualified domain&gt; under HKLMsystemccscontrollsakerberosdomains, verify that the value for "KdcNames" refers to a valid <placeholder>external</placeholder> Kerberos realm and NOT the local domain or another domain in the same Active Directory forest.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Network Adapters with "IPv4 Large Send Offload" enabled:</para>
          <para>
            <embeddedLabel>User Action</embeddedLabel>
          </para>
          <list class="ordered">
            <listItem>
              <para>Open network adapter Properties.</para>
            </listItem>
            <listItem>
              <para>Click Configure.</para>
            </listItem>
            <listItem>
              <para>Click Advanced tab.</para>
            </listItem>
            <listItem>
              <para>Disable "IPv4 Large Send Offload".</para>
            </listItem>
            <listItem>
              <para>Reboot.</para>
            </listItem>
          </list>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_MoreInfo">
    <title>More Information</title>
    <content>
      <para>Sample DCDIAG /test:CHECKSECURITYERROR output from a Windows Server 2008 R2 DC caused by excessive time skew:</para>
      <code>Doing primary tests
Testing server: Default-First-Site-NameCONTOSO-DC1
Starting test: CheckSecurityError
Source DC CONTOSO-DC2 has possible security error (1398).
Diagnosing...
Time skew error between client and 1 DCs! ERROR_ACCESS_DENIED
or down machine received by:
CONTOSO-DC2
[CONTOSO-DC2] DsBindWithSpnEx() failed with error 1398,
There is a time and/or date difference between the client and server..
Ignoring DC CONTOSO-DC2 in the convergence test of object
CN=CONTOSO-DC1,OU=Domain Controllers,DC=contoso,DC=com, because we
cannot connect!
......................... CONTOSO-DC1 failed test CheckSecurityError
</code>
      <para>Sample DCDIAG /CHECKSECURITYERROR output from a Windows Server 2003 DC caused by excessive time skew:</para>
      <code>Doing primary tests
Testing server: Default-First-Site-NameCONTOSO-DC3
Starting test: CheckSecurityError
Source DC CONTOSO-DC1 has possible security error (5). Diagnosing...
Time skew error between client and 1 DCs! ERROR_ACCESS_DENIED or down machine recieved by:
CONTOSO-DC1
Source DC CONTOSO-DC2 has possible security error (5). Diagnosing...
Time skew error: 7205 seconds different between:.
CONTOSO-DC2
CONTOSO-DC3
[CONTOSO-DC1] DsBindWithSpnEx() failed with error 5,
Access is denied..
Ignoring DC CONTOSO-DC1 in the convergence test of object CN=CONTOSO-DC3,OU=Domain Controllers,DC=contoso,DC=com, because we cannot connect!
......................... CONTOSO-DC3 failed test CheckSecurityError
</code>
      <para>Sample DCDIAG /CHECKSECURITYERROR output showing missing SPN names (the output of which could vary from environment to environment). Sample output is shown below:</para>
      <code>Doing primary tests
Testing server: &lt;site name&gt;&lt;dc name&gt;
Test omitted by user request: Advertising
Starting test: CheckSecurityError
* Dr Auth: Beginning security errors check'
Found KDC &lt;KDC DC&gt; for domain &lt;DNS Name of AD domain&gt; in site &lt;site name&gt;
Checking machine account for DC &lt;DC name&gt; on DC &lt;DC Name&gt;
* Missing SPN :LDAP/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;DNS domain name&gt;
* Missing SPN :LDAP/&lt;hostname&gt;.&lt;DNS domain name&gt;
* Missing SPN :LDAP/&lt;hostname&gt;
* Missing SPN :LDAP/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;NetBIOS domain name&gt;
* Missing SPN :LDAP/bba727efbe4e477d979663b6cee3bSf.&lt;forest root domain DN&gt;
* SPN found :E35142354B06I1D1AB4-00c04fc2dcd2/&lt;NTDS Settings object GUID&gt;/&lt;forest root domain DNS name&gt;
* Missing SPN :HOST/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;DNS domain name&gt;
* SPN found :HOST/&lt;hostname&gt;.&lt;DNS domain name&gt;
* SPN found :HOST/&lt;hostname&gt;
* Missing SPN :HOST/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;NetBIOS domain name&gt;
* Missing SPN :GC/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;DNS domain name&gt;
Unable to verify the machine account (&lt;DN path for Dc machine account&gt;) for &lt;DC Name&gt; on &lt;DC name&gt;.
</code>
      <para>Sample DCDIAG /CHECKSECURITYERROR output from a Windows Server 2003 DC caused by excessive time skew:</para>
      <code>Testing server: &lt;site name&gt;&lt;dc name&gt;
Test omitted by user request: Advertising
Starting test: CheckSecurityError
* Dr Auth: Beginning security errors check'
Found KDC &lt;KDC DC&gt; for domain &lt;DNS Name of AD domain&gt; in site &lt;site name&gt;
Checking machine account for DC &lt;DC name&gt; on DC &lt;DC Name&gt;
* Missing SPN :LDAP/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;DNS domain name&gt;
* Missing SPN :LDAP/&lt;hostname&gt;.&lt;DNS domain name&gt;
* Missing SPN :LDAP/&lt;hostname&gt;
* Missing SPN :LDAP/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;NetBIOS domain name&gt;
* Missing SPN :LDAP/bba727efbe4e477d979663b6cee3bSf.&lt;forest root domain DN&gt;
* SPN found :E35142354B06I1D1AB4-00c04fc2dcd2/&lt;NTDS Settings object GUID&gt;/&lt;forest root domain DNS name&gt;
* Missing SPN :HOST/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;DNS domain name&gt;
* SPN found :HOST/&lt;hostname&gt;.&lt;DNS domain name&gt;
* SPN found :HOST/&lt;hostname&gt;
* Missing SPN :HOST/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;NetBIOS domain name&gt;
* Missing SPN :GC/&lt;hostname&gt;.&lt;DNS domain name&gt;/&lt;DNS domain name&gt;
Unable to verify the machine account (&lt;DN path for Dc machine account&gt;) for &lt;DC Name&gt; on &lt;DC name&gt;.
</code>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 5: Access is denied</linkText>
      <linkUri>http://support.microsoft.com/kb/2002013</linkUri>
    </externalLink>
    <externalLink>
      <linkText>How the Active Directory Replication Model Works</linkText>
      <linkUri>http://technet.microsoft.com/library/cc772726(WS.10).aspx</linkUri>
    </externalLink>
<externalLink><linkText>repsFrom, RepsFrom</linkText><linkUri>http://msdn.microsoft.com/library/cc228409(PROT.13).aspx</linkUri></externalLink></relatedTopics>
</developerConceptualDocument>


