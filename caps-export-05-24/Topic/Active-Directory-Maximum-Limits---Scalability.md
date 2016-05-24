---
title: Active Directory Maximum Limits - Scalability
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d2fc40d8-50ba-450c-959b-28fd7e31b996
author: Femila
---
# Active Directory Maximum Limits - Scalability
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic describes Active Directory scalability and other limitations, as well as recommendations that apply when you are designing or implementing an Active Directory infrastructure. These limitations include the following: </para>
    <list class="nobullet">
      <listItem>
        <para>
          <link xlink:href="#BKMK_Objects">Maximum Number of Objects</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_SIDs">Maximum Number of Security Identifiers</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_SIDSperObject">Maximum Number of entries in Discretionary and Security Access Control Lists</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Groups">Group Memberships for Security Principals</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_FQDN">FQDN Length Limitations</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_FileName">File Name and Path Length Limitations</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_NameLimits">Additional Name Length Limitations</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_GPO">Maximum Number of GPOs Applied</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Trust">Trust Limitations</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_LDAP">Maximum Number of Accounts per LDAP Transaction</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Users">Recommended Maximum Number of Users in a Group</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Forest">Recommended Maximum Number of Domains in a Forest</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_DCDomain">Recommended Maximum Number of Domain Controllers in a Domain</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Kerb">Recommended Maximum Kerberos Settings</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Objects">
    <title>Maximum Number of Objects</title>
    <content>
      <para>Each domain controller in an Active Directory forest can create a little bit less than 2.15 billion objects during its lifetime. </para>
      <para>Each Active Directory domain controller has a unique identifier that is specific to the individual domain controller. These identifiers, which are called Distinguished Name Tags (DNTs), are not replicated or otherwise visible to other domain controllers. The range of values for DNTs is from 0 through 2,147,483,393 (2<superscript>31</superscript> minus 255). As objects are created on a domain controller, a unique value is used. A DNT is not reused when an object is deleted. Therefore, domain controllers are limited to creating approximately 2 billion objects (including objects that are created through replication). This limit applies to the aggregate of all objects from all partitions (domain NC, configuration, schema, and any application directory partitions) that are hosted on the domain controller. </para>
      <para>Because new domain controllers start with low initial DNT values (typically, anywhere from 100 up to 2,000), it may be possible to work around the domain controller lifetime creation limit—assuming, of course, that the domain is currently maintaining less than 2 billion objects. For example, if the lifetime creation limit is reached because approximately 2 billion objects are created, but 500 million objects are removed from the domain (for example, deleted and then permanently removed from the database through the garbage collection process), installing a new domain controller and allowing it to replicate the remaining objects from the existing domain controllers is a potential workaround. However, it is important that the new domain controller receives the objects through replication and that such domain controllers not be promoted with the Install from Media (IFM) option. Domain controllers that are installed with IFM inherit the DNT values from the domain controller that was used to create the IFM backup. </para>
      <para>At the database level, the error that occurs when the DNT limit is reached is “Error: Add: Operations Error. &lt;1&gt; Server error: 000020EF: SvcErr: DSID-0208044C, problem 5012 (DIR_ERROR), data -1076.”</para>
      <alert class="note">
        <para>KB article <externalLink><linkText>2548145</linkText><linkUri>http://support.microsoft.com/kb/2548145</linkUri></externalLink> includes a hotfix to correct a problem where the size of the Active Directory database can increase rapidly on a domain controller that hosts the DNS server role, with most of the growth contributed by deleted DNS records. To remove those records, the garbage collection task processes a maximum of 5000 records in a single database transaction (also known as MAX_DUMPSTER_SIZE), and will continue to re-schedule itself until it is done. The hotfix does not change the garbage collection process; it only changes behavior in the DNS Server component and how it deals with deletions of dnsNode objects. For more information about garbage collection, see <externalLink><linkText>How the Active Directory–Data Store Really Works (Inside NTDS.dit)–Part 4</linkText><linkUri>http://blogs.chrisse.se/2012/11/28/how-the-active-directory-data-store-really-works-inside-ntds.dit-part-4/</linkUri></externalLink>. </para>
      </alert>
      <para>Beginning with Windows Server 2012, you can check a rootDSE operational attribute named <embeddedLabel>approximateHighestInternalObjectID</embeddedLabel> to determine the actual highest DNT in use on a domain controller. The following script can be used to retrieve this attribute value:</para>
      <code>$ossupported = $false
 
# max possible DNTs
$maxdnts = [System.Math]::Pow(2, 31) - 255
 
# connect rootDSE
$root = [ADSI]"LDAP://rootDSE"
 
# get operational attribute dsaVersionString
$root.RefreshCache("dsaVersionString")
 
# get version string usable in System.Version
$osverstring = $root.dsaVersionString[0].Substring(0, $root.dsaVersionString[0].IndexOf(" "))
 
try
{
    $osver = New-Object System.Version $osverstring
 
    # we need at least W2K12 DC to see the approximateHighestInternalObjectID exposed
    if ($osver.Major -gt 6)
    { $ossupported = $true }
 
    elseif ($osver.Major -eq 6)
    { $ossupported = ($osver.Minor -ge 2) }
}
 
catch
{ Write-Host "ERROR: Could not evaluate DC OsVer!"  }
 
if ($ossupported)
{
    # get operational attribute approximateHighestInternalObjectID
    $root.RefreshCache("approximateHighestInternalObjectID")
 
    Write-Host "Approx highest committed DNT: $($root.approximateHighestInternalObjectID[0])"
 
    Write-Host "DNTs left for new assignments: $($maxdnts - $root.approximateHighestInternalObjectID[0]) from $maxdnts"
}
 
else
{ Write-Host "approximateHighestInternalObjectID not exposed (DC OsVer: $osverstring)" } 
 
</code>
    </content>
  </section>
  <section address="BKMK_SIDs">
    <title>Maximum Number of Security Identifiers</title>
    <content>
      <para>Beginning with <token>win8_server_2</token>, the maximum number of security identifiers that can be created over the life of a domain is increased to 2,147,483,647 RIDs. This increase is part of a series of improvements made to how RIDS are issued and monitored. For more information, see <externalLink><linkText>Managing RID Issuance</linkText><linkUri>http://technet.microsoft.com/library/jj574229.aspx</linkUri></externalLink>.  </para>
      <para>In Windows Server 2008 R2 and earlier operating systems, there is a limit of approximately 1 billion security identifiers (SIDs) over the life of a domain. This limit is due to the size of the global relative identifier (RID) pool of 30 bits that makes each SID (that is assigned to user, group, and computer accounts) in a domain unique. The actual limit is 2<superscript>30</superscript> or 1,073,741,823 RIDs. Because RIDs are not reused—even if security principals are deleted—the maximum limit applies, even if there are less than 1 billion security principals in the domain.</para>
      <alert class="note">
        <para>RIDs are assigned in blocks of 500 by default from the domain controller that holds the RID operations master role in each domain. If a domain controller is demoted, the unused RIDs that were allocated to the domain controller are not returned to the global RID pool and are therefore no longer available for use in the domain.</para>
      </alert>
      <para>Beginning in <token>win8_server_2</token>, an artificial ceiling is introduced when the number of available RIDs reaches within 10 percent of the limit for the global RID space. When within one percent of the artificial ceiling, domain controllers that request RID pools will log Directory-Services-SAM warning event 16656 to their System event log. For more information, see <externalLink><linkText>Managing RID Issuance</linkText><linkUri>http://technet.microsoft.com/library/jj574229.aspx</linkUri></externalLink>.  </para>
      <para>In Windows Server 2008 R2 and earlier operating systems, when all the available RIDs are assigned for a domain, the Directory Service log in the Application and Service Logs of Event Viewer also displays Event ID 16644 from an event log source of the Security Accounts Manager (SAM) that reads “The maximum domain account identifier value has been reached. No further account-identifier pools can be allocated to domain controllers in this domain.” If you run Dcdiag when all the available RIDs are assigned for a domain, you see the error message “The DS has corrupt data: rIDAvailablePool value is not valid.”</para>
      <para>A partial work-around to this limitation is to create an additional domain to hold accounts and then migrate accounts to the new domain. However, you must create a trust relationship to migrate accounts in advance of reaching the limit. Creating a trust requires the creation of a security principal, which is also known as a trust user account. For more information about this limit, see articles 316201 (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=115211</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=115211</linkUri></externalLink>) and 305475 (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=115212</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=115212</linkUri></externalLink>) in the Microsoft Knowledge Base.</para>
      <alert class="note">
        <para>The Active Directory database does not set limits on the number of objects in a container, such as organizational units (OUs). You might experience limits when you work with multiple thousands of objects. These limits are configured to help provide a certain level of application or service availability. For example, the Active Directory Users and Computers snap-in is configured by default to display a maximum of 2,000 objects per container. You can adjust this value by using the <ui>Filter Options</ui> settings on the <ui>View</ui> menu. There are also adjustable Lightweight Directory Access Protocol (LDAP) policies that are set by default to improve domain controller performance. These policies are described in article 315071 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=135481</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=135481</linkUri></externalLink>). </para>
      </alert>
    </content>
  </section>
  <section address="BKMK_SIDSperObject">
    <title>Maximum Number of entries in Discretionary and Security Access Control Lists</title>
    <content>
      <para>The limitation for the number of entries in a discretionary access control list (DACL) or a security access control list (SACL) of an Active Directory object using the ntSecurityDescriptor attribute comes from a limitation in the size of the access control list (ACL), which is 64K. Since access control entries (ACEs) vary in size, the actual number of entries (SIDs) is approximately 1,820. For additional details, see <externalLink><linkText>How Security Descriptors and Access Control Lists Work</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=214683</linkUri></externalLink> (http://go.microsoft.com/fwlink/?LinkId=214683).</para>
    </content>
  </section>
  <section address="BKMK_Groups">
    <title>Group Memberships for Security Principals</title>
    <content>
      <para>Security principals (that is, user, group, and computer accounts) can be members of a maximum of approximately 1,015 groups. This limitation is due to the size limit for the access token that is created for each security principal. The limitation is not affected by how the groups may or may not be nested. For more information, see article 328889 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=115213</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=115213</linkUri></externalLink>). For a detailed discussion of access token limitations, see Addressing Problems Due to Access Token Limitation (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=146571</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=146571</linkUri></externalLink>).</para>
      <para>For more information about how a domain controller creates the data structure that is used for authorization decisions, see: </para>
      <list class="bullet">
        <listItem>
          <para>
            <externalLink>
              <linkText>[MS-PAC]: Privilege Attribute Certificate Data Structure</linkText>
              <linkUri>http://msdn.microsoft.com/library/cc237917(PROT.13).aspx</linkUri>
            </externalLink> (http://msdn.microsoft.com/library/cc237917(PROT.13).aspx)</para>
        </listItem>
        <listItem>
          <para>
            <externalLink>
              <linkText>3.3.5.3.2 Initial Population of the PAC</linkText>
              <linkUri>http://msdn.microsoft.com/library/cc233956(PROT.13).aspx</linkUri>
            </externalLink> (http://msdn.microsoft.com/library/cc233956(PROT.13).aspx)</para>
        </listItem>
        <listItem>
          <para>
            <externalLink>
              <linkText>3.3.5.4.3 Domain Local Group Membership</linkText>
              <linkUri>http://msdn.microsoft.com/library/cc233950(PROT.13).aspx</linkUri>
            </externalLink> (http://msdn.microsoft.com/library/cc233950(PROT.13).aspx)</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_FQDN">
    <title>FQDN Length Limitations</title>
    <content>
      <para>Fully qualified domain names (FQDNs) in Active Directory cannot exceed 64 characters in total length, including hyphens and periods (.). For example, the following host name has 65 characters; therefore, it is not valid in an Active Directory domain: </para>
      <para>server10.branch-15.southaz.westernregion.northamerica.contoso.com </para>
      <para>This is an important limitation to keep in mind when you name domains. This limitation is due to the MAX_PATH length of 260 characters that the Win32 application programming interfaces (APIs) define, in combination with the way in which Group Policy objects (GPOs) are stored in the SYSVOL share. For more information, see article 245809 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=115219</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=115219</linkUri></externalLink>). For more information about naming limitations, see article 909264 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=106629</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=106629</linkUri></externalLink>).</para>
    </content>
  </section>
  <section address="BKMK_FileName">
    <title>File Name and Path Length Limitations</title>
    <content>
      <para>The physical files that Active Directory components use, such as SYSVOL, database (NTDS.DIT), and log file paths, are constrained by the MAX_PATH length of 260 characters, as defined by the Win32 APIs. When you are determining where to place your SYSVOL and database files during Active Directory installation, avoid nested folder structures that make the full file path to the SYSVOL folder, database, and log files longer than 260 characters. For more information, see article 245809 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=115219</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=115219</linkUri></externalLink>).</para>
    </content>
  </section>
  <section address="BKMK_NameLimits">
    <title>Additional Name Length Limitations</title>
    <content>
      <para>There are additional limitations regarding name lengths in Active Directory. The following limits are described in article 909264 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=106629</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=106629</linkUri></externalLink>): </para>
      <list class="bullet">
        <listItem>
          <para>NetBIOS computer and domain names are limited to 15 characters.</para>
        </listItem>
        <listItem>
          <para>Domain Name System (DNS) host names are limited to 24 characters.</para>
        </listItem>
        <listItem>
          <para>OU names are limited to 64 characters.</para>
        </listItem>
      </list>
    </content>
    <sections>
      <section>
        <title>Name Length Limits from the Schema</title>
        <content>
          <para>Default limits on attribute names for Active Directory objects that are imposed by the schema include the following. These items provide examples of schema-limited name attributes:</para>
          <list class="bullet">
            <listItem>
              <para>Display names are limited to 256 characters. For more information, see Display-Name Attribute (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=153705</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=153705</linkUri></externalLink>).</para>
            </listItem>
            <listItem>
              <para>Common names are limited to 64 characters. For more information, see Common-Name Attribute (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=153706</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=153706</linkUri></externalLink>).</para>
            </listItem>
            <listItem>
              <para>The <embeddedLabel>SAM-Account-Name</embeddedLabel> attribute (also known as the pre–Windows 2000 user logon name) is limited to 256 characters in the schema. However, for the purpose of backward compatibility the limit is 20 characters. For more information, see SAM-Account-Name Attribute (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=153707</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=153707</linkUri></externalLink>). </para>
            </listItem>
          </list>
        </content>
      </section>
      <section>
        <title>Name Length Limitations for LDAP Simple Bind Operations</title>
        <content>
          <para>During binds to the directory, simple LDAP bind operations limit the distinguished name (also known as DN) of the user to 255 total characters. If you attempt a simple LDAP bind with more than 255 characters, you might experience authentication errors, such as the following: </para>
          <code>Error &lt;49&gt;: ldap_simple_bind_s() failed: Invalid Credentials 
Server error: 80090308: LdapErr: DSID-0C0903AA, comment: AcceptSecurityContext error, data 57, v1771 
Error 0x80090308 The token supplied to the function is invalid
</code>
          <para>You can avoid this issue by ensuring that the applications, scripts, and utilities that attempt to bind to your directory use secure LDAP binds. You can also avoid this issue by reducing the depth of the OU structure or the length of the OU names. For example, the following distinguished name is 261 characters: </para>
          <code>CN=BobKelly,OU=CorporateVicePresidents,OU=CorporateOfficers,OU=ViewOfPugetSoundOffices,OU=TopFloor,OU=Building1557,OU=CorporateCampus,OU=Redmond,OU=Washington,OU=NorthWestern,OU=UnitedStatesOfAmerica,OU=NorthAmerica,DC=BusinessGroup,DC=humongousinsurance,DC=com</code>
          <para>If the OU named CorporateVicePresidents is shortened to CVP, the distinguished name for the user account BobKelly is only 242 characters.</para>
        </content>
      </section>
    </sections>
  </section>
  <section address="BKMK_GPO">
    <title>Maximum Number of GPOs Applied</title>
    <content>
      <para>There is a limit of 999 Group Policy objects (GPOs) that you can apply to a user account or computer account. This does not mean that the total number of policy settings on the system is limited to 999. Rather, a single user or computer will not be able to process more than 999 GPOs. This limit exists for performance reasons.</para>
    </content>
  </section>
  <section address="BKMK_Trust">
    <title>Trust Limitations</title>
    <content>
      <para>Trust limitations arise from the number of trusted domain objects (TDOs), the length of trust paths, and the ability of clients to discover available trusts. Limitations that apply include the following:</para>
      <list class="bullet">
        <listItem>
          <para>Kerberos clients can traverse a maximum of 10 trust links to locate a requested resource in another domain. If the trust path between the domains exceeds this limit, the attempt to access the domain fails. </para>
        </listItem>
        <listItem>
          <para>When a client searches out a trust path, the search is limited to the trusts that are established directly with a domain and the trusts that are transitive within a forest.</para>
        </listItem>
        <listItem>
          <para>Previous testing shows that the increased time to complete TDO-related operations, such as authentication across domains, deteriorates performance noticeably if the Active Directory implementation in an organization contains more than 2,400 TDOs.</para>
        </listItem>
      </list>
      <para>For more information about trust limitations, see “Practical Limitations of Trusts” in How Domain and Forest Trusts Work (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=35356</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=35356</linkUri></externalLink>).
</para>
    </content>
  </section>
  <section address="BKMK_LDAP">
    <title>Maximum Number of Accounts per LDAP Transaction
</title>
    <content>
      <para>When you write scripts or applications that perform LDAP transactions, the recommended limit is to perform no more than 5,000 operations per LDAP transaction. An LDAP transaction is a group of directory operations (such as add, delete, and modify) that are treated as one unit. If your script or application performs more than 5,000 operations in a single LDAP transaction, you are at risk of running into resource limits and an operational time-out. If that happens, all the operations (changes, additions, and modifications) in the transaction are rolled back, which means that you lose all those changes.</para>
      <para>As an example, if you are using Active Directory Service Interfaces (ADSI) to write a script, the SetInfo method completes a transaction. For more information about ADSI Methods, see Active Directory Service Interfaces (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=4487</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=4487</linkUri></externalLink>). </para>
      <para>As another example, when you use the System.DirectoryServices (S.DS) namespace in the Microsoft .NET Framework, the DirectoryEntry.CommitChanges method completes an LDAP transaction. For more information about the DirectoryEntry.CommitChanges method, see DirectoryEntry.CommitChanges () (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=115220</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=115220</linkUri></externalLink>).</para>
      <alert class="note">
        <para>Regardless of the method that you use for LDAP transactions, you should plan to send less than 5,000 directory operations in a single transaction. To learn more about the LDAP data structure that commits changes, see LDAPMod (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=115221</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=115221</linkUri></externalLink>).</para>
      </alert>
    </content>
  </section>
  <section address="BKMK_Users">
    <title>Recommended Maximum Number of Users in a Group</title>
    <content>
      <para>For Windows 2000 Active Directory environments, the recommended maximum number of members in a group is 5,000. This recommendation is based on the number of concurrent atomic changes that can be committed in a single database transaction. </para>
      <para>Starting with Windows Server 2003, the ability to replicate discrete changes to linked multivalued properties was introduced as a technology called Linked Value Replication (LVR). To enable LVR, you must increase the forest functional level to at least Windows Server 2003 interim. Increasing the forest functional level changes the way that group membership (and other linked multivalued attributes) is stored in the database and replicated between domain controllers. This allows the number of group memberships to exceed the former recommended limit of 5,000 for Windows 2000 or Windows Server 2003 at a forest functional level of Windows 2000. </para>
      <para>So far, testing in this area has yet to reveal any new recommended limits to the number of members in a group or any other linked multivalued attribute. Production environments have been reported to exceed 4 million members, and Microsoft scalability testing reached 500 million members.</para>
      <alert class="important">
        <para>Increasing the forest functional level to Windows Server 2003 interim or higher does not modify the way that existing group members are stored or replicated. To do that, you must remove the members that were added to the group before the forest functional level was increased to Windows Server 2003 and then add them back again to the appropriate groups. Any group members that you either add or remove after the forest functional level is increased will be LVR enabled, even if the group contains other members that are not LVR enabled.</para>
        <para>For more information about linked attributes, see Linked Attributes (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=142909</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=142909</linkUri></externalLink>). For more information about the replication process, see How the Active Directory Replication Model Works (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=142908</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=142908</linkUri></externalLink>).</para>
      </alert>
    </content>
  </section>
  <section address="BKMK_Forest">
    <title>Recommended Maximum Number of Domains in a Forest
</title>
    <content>
      <para>For Windows 2000 Server, the recommended maximum number of domains in a forest is 800. For Windows Server 2003, the recommended maximum number of domains when the forest functional level is set to Windows Server 2003 (also known as forest functional level 2) is 1,200. This restriction is a limitation of multivalued, nonlinked attributes in Windows Server 2003. For more information, see “Maximum Database Record Size” in How the Data Store Works (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=134791</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=134791</linkUri></externalLink>).</para>
    </content>
  </section>
  <section address="BKMK_DCDomain">
    <title>Recommended Maximum Number of Domain Controllers in a Domain</title>
    <content>
      <para>To ensure reliable recovery of SYSVOL, we recommend a limit of 1200 domain controllers per domain.  </para>
      <para>If any Active Directory domain in your network is expected to exceed 800 domain controllers and those domain controllers are hosting Active Directory–integrated Domain Name System (DNS) zones, review article 267855 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=115222</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=115222</linkUri></externalLink>).</para>
      <para>For more information about FRS limitations, see the FRS Technical Reference (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=115302</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=115302</linkUri></externalLink>). </para>
    </content>
  </section>
  <section address="BKMK_Kerb">
    <title>Recommended Maximum Kerberos Settings 
</title>
    <content>
      <para>The maximum recommended size for a Kerberos ticket is 48,000 bytes, which is configured through the <embeddedLabel>MaxTokenSize</embeddedLabel> REG_DWORD value in the registry (<embeddedLabel>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Lsa\Kerberos\Parameters</embeddedLabel>) or through Group Policy, as described in KB article <externalLink><linkText>938118</linkText><linkUri>http://support.microsoft.com/kb/938118</linkUri></externalLink>. </para>
      <alert class="note">
        <para>The maximum allowed value of MaxTokenSize is 65,535 bytes. If you are using Kerberos for IPSEC key management, the limit of 65,536 bytes. However, because of HTTP’s base64 encoding of authentication context tokens, we do not recommend that you set the maxTokenSize registry entry to a value larger than 48,000 bytes. Starting with Windows Server 2012, the default value of the MaxTokenSize registry entry is 48,000 bytes.</para>
      </alert>
      <para>For additional information about Kerberos tickets, including error conditions that can occur when Kerberos ticket size limits are set too low or too high, see Additional Resources for Troubleshooting Kerberos (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=134740</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=134740</linkUri></externalLink>).

</para>
    </content>
  </section>
  <relatedTopics />
</developerConceptualDocument>