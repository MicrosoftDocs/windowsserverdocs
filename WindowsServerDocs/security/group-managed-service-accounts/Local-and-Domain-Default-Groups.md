---
title: Local and Domain Default Groups
ms.prod: windows-server-threshold
description: "Windows Server Security"
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a328fe83-b2f6-441b-b2f8-52cfd9e81aef
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Local and Domain Default Groups

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>Default groups are created when you install Windows client or server operating systems and Active Directory Domain Services (AD DS) domains. Domain member computers and stand-alone computers have default local groups that are created automatically in their local security accounts database. Domain controllers are an exception: they use the central Active Directory database to create default groups. All domain member computers can access the central Active Directory database.</para>
  </introduction>
  <section>
    <title>Default local groups</title>
    <content>
      <para>The Groups folder in the Local Users and Groups Microsoft Management Console (MMC) snap-in displays the default local groups as well as the local groups that you create. Belonging to a local group gives a user the rights and abilities to perform various tasks on the local computer. For more information about domain-based groups, see <link xlink:href="#BKMK_DomainDefaultGroups">Default domain groups</link>. </para>
      <para>You can add local user accounts, domain user accounts, computer accounts, and group accounts to local groups. However, you cannot add local user accounts and local group accounts to domain group accounts. For more information about adding members to local groups, see Add a member to a local group (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=148785</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=148785</linkUri></externalLink>).</para>
      <para>The following table describes the default groups in the Groups folder, and it lists the default user rights for each group. These user rights are assigned in the local security policy. For complete descriptions of the user rights that are listed in the table, see User Rights Assignment (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=148787</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=148787</linkUri></externalLink>). For information about editing these rights, see Assign user rights for your local computer (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=148788</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=148788</linkUri></externalLink>).</para>
      <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
        <thead>
          <tr>
            <TD colspan="1">
              <para>Group</para>
            </TD>
            <TD colspan="1">
              <para>Description</para>
            </TD>
            <TD colspan="1">
              <para>Default user rights</para>
            </TD>
          </tr>
        </thead>
        <tbody>
          <tr>
            <TD colspan="1">
              <para>Administrators</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group have full control of the server, and they can assign user rights and access control permissions to users as necessary. The Administrator account is also a default member of this group. When this server is joined to a domain, the Domain Admins group is automatically added to this group. Because this group has full control of the server, add users to this group with caution. For more information, see Default local groups (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=149101</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=149101</linkUri></externalLink>) and Default groups (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=131422</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=131422</linkUri></externalLink>).</para>
            </TD>
            <TD colspan="1">
              <list class="bullet">
                <listItem>
                  <para>Access this computer from the network</para>
                </listItem>
                <listItem>
                  <para>Adjust memory quotas for a process</para>
                </listItem>
                <listItem>
                  <para>Allow logon locally</para>
                </listItem>
                <listItem>
                  <para>Allow logon through Terminal Services</para>
                </listItem>
                <listItem>
                  <para>Back up files and directories</para>
                </listItem>
                <listItem>
                  <para>Bypass traverse checking</para>
                </listItem>
                <listItem>
                  <para>Change the system time</para>
                </listItem>
                <listItem>
                  <para>Create a pagefile</para>
                </listItem>
                <listItem>
                  <para>Debug programs</para>
                </listItem>
                <listItem>
                  <para>Force shutdown from a remote system</para>
                </listItem>
                <listItem>
                  <para>Increase scheduling priority</para>
                </listItem>
                <listItem>
                  <para>Load and unload device drivers</para>
                </listItem>
                <listItem>
                  <para>Manage auditing and security log</para>
                </listItem>
                <listItem>
                  <para>Modify firmware environment variables</para>
                </listItem>
                <listItem>
                  <para>Perform volume maintenance tasks</para>
                </listItem>
                <listItem>
                  <para>Profile single process</para>
                </listItem>
                <listItem>
                  <para>Profile system performance</para>
                </listItem>
                <listItem>
                  <para>Remove computer from docking station</para>
                </listItem>
                <listItem>
                  <para>Restore files and directories</para>
                </listItem>
                <listItem>
                  <para>Shut down the system</para>
                </listItem>
                <listItem>
                  <para>Take ownership of files or other objects</para>
                </listItem>
              </list>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Backup Operators</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group can back up and restore files on the server, regardless of any permissions that protect those files. This is because the right to perform a backup takes precedence over all file permissions. Members of this group cannot change security settings.</para>
            </TD>
            <TD colspan="1">
              <list class="bullet">
                <listItem>
                  <para>Access this computer from the network</para>
                </listItem>
                <listItem>
                  <para>Allow logon locally</para>
                </listItem>
                <listItem>
                  <para>Back up files and directories</para>
                </listItem>
                <listItem>
                  <para>Bypass traverse checking</para>
                </listItem>
                <listItem>
                  <para>Restore files and directories</para>
                </listItem>
                <listItem>
                  <para>Shut down the system</para>
                </listItem>
              </list>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>DHCP Administrators (installed with the DHCP Server service)</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group have administrative access to the Dynamic Host Configuration Protocol (DHCP) Server service. This group provides a way to assign limited administrative access to the DHCP server role only, while not providing full access to the server. Members of this group can administer DHCP on a server by using the DHCP console or the <system>netsh</system> command, but they are not able to perform other administrative actions on the server.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>DHCP Users (installed with the DHCP Server service)</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group have read-only access to the DHCP Server service. This access allows members to view information and properties that are stored at a specified DHCP server. This information is useful to support staff when they need to obtain DHCP status reports.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Guests</para>
            </TD>
            <TD colspan="1">
              <para>A member of this group will have a temporary profile created when they log on, and when they log off, the profile will be deleted. The Guest account (which is disabled by default) is also a default member of this group.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>HelpServicesGroup</para>
            </TD>
            <TD colspan="1">
              <para>Administrators can use this group to set rights that are common to all support applications. By default, the only group member is the account that is associated with Microsoft support applications, such as Remote Assistance. Do not add users to this group.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Network Configuration Operators</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group can make changes to TCP/IP settings, and they can renew and release TCP/IP addresses. This group has no default members.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Performance Monitor Users</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group can monitor performance counters on the server, locally and from remote clients, without being members of the Administrators or Performance Log Users groups.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Performance Log Users</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group can manage performance counters, logs, and alerts on the server, locally and from remote clients, without being members of the Administrators group.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Power Users</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group can create user accounts and then modify and delete the accounts that they created. They can create local groups and then add or remove users from the local groups that they created. They can also add or remove users from the Power Users, Users, and Guests groups. Members can create shared resources and administer the shared resources that they created. They cannot take ownership of files, back up or restore directories, load or unload device drivers, or manage security and auditing logs.</para>
            </TD>
            <TD colspan="1">
              <list class="bullet">
                <listItem>
                  <para>Access this computer from the network</para>
                </listItem>
                <listItem>
                  <para>Allow logon locally</para>
                </listItem>
                <listItem>
                  <para>Bypass traverse checking</para>
                </listItem>
                <listItem>
                  <para>Change the system time</para>
                </listItem>
                <listItem>
                  <para>Profile single process</para>
                </listItem>
                <listItem>
                  <para>Remove computer from docking station</para>
                </listItem>
                <listItem>
                  <para>Shut down the system</para>
                </listItem>
              </list>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Print Operators</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group can manage printers and print queues.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Remote Desktop Users</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group can log on remotely to a server.</para>
              <para>For more information, see Enabling users to connect remotely to the server (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=136310</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=136310</linkUri></externalLink>).</para>
            </TD>
            <TD colspan="1">
              <para>Allow log on through Terminal Services</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Replicator</para>
            </TD>
            <TD colspan="1">
              <para>The Replicator group supports replication functions. The only member of the Replicator group should be a domain user account that is used <?Comment JHB: Kurt, I don’t quite get the syntax here? Are they logging on “to�? the services? Is that possible? Or are they logging the Replicator services “on�? to the DC? Can you clarify this? Thanks. 2009-04-17T09:14:00Z  Id='0?>to log on the <?CommentEnd Id='0'
    ?>Replicator services of a domain controller. Do not add user accounts of actual users to this group.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Terminal Server Users</para>
            </TD>
            <TD colspan="1">
              <para>This group contains any users who are currently logged on to the system with Terminal Server. Any program that a user can run with Windows NT 4.0 will run for a member of the Terminal Server User group. The default permissions that are assigned to this group enable its members to run most earlier programs. </para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>Users</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group can perform common tasks, such as running applications, using local and network printers, and locking the server. Users cannot share directories or create local printers. By default, the Domain Users, Authenticated Users, and Interactive groups are members of this group. Therefore, any user account that is created in the domain becomes a member of this group.</para>
            </TD>
            <TD colspan="1">
              <list class="bullet">
                <listItem>
                  <para>Access this computer from the network</para>
                </listItem>
                <listItem>
                  <para>Allow logon locally</para>
                </listItem>
                <listItem>
                  <para>Bypass traverse checking</para>
                </listItem>
              </list>
            </TD>
          </tr>
          <tr>
            <TD colspan="1">
              <para>WINS Users (installed with WINS service)</para>
            </TD>
            <TD colspan="1">
              <para>Members of this group are permitted read-only access to Windows Internet Name Service (WINS). This allows members of the group to view information and properties that are stored at a specified WINS server. This information is useful to support staff when they need to obtain WINS status reports.</para>
            </TD>
            <TD colspan="1">
              <para>No default user rights</para>
            </TD>
          </tr>
        </tbody>
      </table>
      <para>For more information about the most common default groups, see Default security settings for groups (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=149130</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=149130</linkUri></externalLink>).</para>
    </content>
  </section>
  <section address="BKMK_DomainDefaultGroups">
    <title> Default domain groups</title>
    <content>
      <para>Default groups, such as the Domain Admins group, are security groups that are created automatically when you create an Active Directory domain. You can use these predefined groups to help control access to shared resources and to delegate specific domain-wide administrative roles.</para>
      <para>Many default groups are automatically assigned a set of user rights that authorize members of the group to perform specific actions in a domain, such as logging on to a local system or backing up files and folders. For example, a member of the Backup Operators group has the right to perform backup operations for all domain controllers in the domain.</para>
      <para>When you add a user to a group, the user receives all the user rights that are assigned to the group and all the permissions that are assigned to the group on any shared resources. For more information about user rights and permissions, see Group types (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=149131</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=149131</linkUri></externalLink>).</para>
      <para>You can manage groups by using the Active Directory Users and Computers snap-in. Default groups are located in the Builtin container and the Users container. The Builtin container contains groups that are defined with domain local scope. The Users container contains groups that are defined with global scope and groups that are defined with domain local scope. You can move groups that are located in these containers to other groups or organizational units (OUs) within the domain, but you cannot move them to other domains.</para>
      <para>As a security best practice, we recommend that members of default groups with broad administrative access use the <ui>Run as</ui> command to perform administrative tasks. For more information, see Using Run as (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=149133</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=149133</linkUri></externalLink>). For information about security best practices, see Active Directory Best Practices (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=149135</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=149135</linkUri></externalLink>). For information about additional security measures that you can use to protect Active Directory, see Securing Active Directory (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=149136</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=149136</linkUri></externalLink>).</para>
    </content>
    <sections>
      <section address="H2_53859399">
        <title>Groups in the Builtin container</title>
        <content>
          <para>The following table provides descriptions of the default groups that are located in the Builtin container, and it lists the assigned user rights for each group. For complete descriptions of the user rights that are listed in the table, see <link xlink:href="71b2772f-e3c0-4134-b7f0-54c244ee9aef">User rights assignment</link>. For information about editing these rights, see <link xlink:href="02e1b4dc-00a7-41b1-8610-38d43d5e5d5d">To edit a security setting on a Group Policy object</link>.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD colspan="1">
                  <para>Group</para>
                </TD>
                <TD colspan="1">
                  <para>Description</para>
                </TD>
                <TD colspan="1">
                  <para>Default user rights</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD colspan="1">
                  <para>Account Operators</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can create, modify, and delete accounts for users, groups, and computers that are located in the Users or Computers containers and OUs in the domain, except the Domain Controllers OU. Members of this group do not have permission to modify the Administrators or the Domain Admins groups, nor do they have permission to modify the accounts for members of those groups. Members of this group can log on locally to domain controllers in the domain and shut them down. Because this group has significant power in the domain, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <list class="bullet">
                    <listItem>
                      <para>Allow logon locally</para>
                    </listItem>
                    <listItem>
                      <para>Shut down the system</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Administrators</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group have full control of all domain controllers in the domain. By default, the Domain Admins and Enterprise Admins groups are members of the Administrators group. The Administrator account is also a default member of the Administrators group. Because this group has full control in the domain, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <list class="bullet">
                    <listItem>
                      <para>Access this computer from the network</para>
                    </listItem>
                    <listItem>
                      <para>Adjust memory quotas for a process</para>
                    </listItem>
                    <listItem>
                      <para>Back up files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Bypass traverse checking</para>
                    </listItem>
                    <listItem>
                      <para>Change the system time</para>
                    </listItem>
                    <listItem>
                      <para>Create a pagefile</para>
                    </listItem>
                    <listItem>
                      <para>Debug programs</para>
                    </listItem>
                    <listItem>
                      <para>Enable computer and user accounts to be trusted for delegation</para>
                    </listItem>
                    <listItem>
                      <para>Force a shutdown from a remote system</para>
                    </listItem>
                    <listItem>
                      <para>Increase scheduling priority</para>
                    </listItem>
                    <listItem>
                      <para>Load and unload device drivers</para>
                    </listItem>
                    <listItem>
                      <para>Allow logon locally</para>
                    </listItem>
                    <listItem>
                      <para>Manage auditing and security log</para>
                    </listItem>
                    <listItem>
                      <para>Modify firmware environment values</para>
                    </listItem>
                    <listItem>
                      <para>Profile single process</para>
                    </listItem>
                    <listItem>
                      <para>Profile system performance</para>
                    </listItem>
                    <listItem>
                      <para>Remove computer from docking station</para>
                    </listItem>
                    <listItem>
                      <para>Restore files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Shut down the system</para>
                    </listItem>
                    <listItem>
                      <para>Take ownership of files or other objects</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Backup Operators</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can back up and restore all files on domain controllers in the domain, regardless of their own individual permissions on those files. Backup Operators can also log on to domain controllers and shut them down. This group has no default members. Because this group has significant power on domain controllers, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <list class="bullet">
                    <listItem>
                      <para>Back up files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Allow logon locally</para>
                    </listItem>
                    <listItem>
                      <para>Restore files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Shut down the system</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Guests</para>
                </TD>
                <TD colspan="1">
                  <para>By default, the Domain Guests group is a member of this group. The Guest account (which is disabled by default) is also a default member of this group.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Incoming Forest Trust Builders (appears only in the forest root domain)</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can create one-way, incoming forest trusts to the forest root domain. For example, members of this group that reside in Forest A can create a one-way, incoming forest trust from Forest B. This one-way, incoming forest trust allows users in Forest A to access resources in Forest B. Members of this group are granted the permission Create Inbound Forest Trust on the forest root domain. This group has no default members. For more information about creating forest trusts, see Create a forest trust (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=149137</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=149137</linkUri></externalLink>).</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Network Configuration Operators</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can make changes to TCP/IP settings and renew and release TCP/IP addresses on domain controllers in the domain. This group has no default members.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Performance Monitor Users</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can monitor performance counters on domain controllers in the domain, locally and from remote clients, without being members of the Administrators or Performance Log Users groups.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Performance Log Users</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can manage performance counters, logs, and alerts on domain controllers in the domain, locally and from remote clients, without being members of the Administrators group.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Pre-Windows 2000 Compatible Access</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group have read access on all users and groups in the domain. This group is provided for backward compatibility for computers running Windows NT 4.0 and earlier. By default, the special identity Everyone is a member of this group. For more information about special identities, see Special identities (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=149138</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=149138</linkUri></externalLink>). Add users to this group only if they are running Windows NT 4.0 or earlier.</para>
                </TD>
                <TD colspan="1">
                  <list class="bullet">
                    <listItem>
                      <para>Access this computer from the network</para>
                    </listItem>
                    <listItem>
                      <para>Bypass traverse checking</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Print Operators</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can manage, create, share, and delete printers that are connected to domain controllers in the domain. They can also manage Active Directory printer objects in the domain. Members of this group can log on locally to domain controllers in the domain and shut them down. This group has no default members. Because members of this group can load and unload device drivers on all domain controllers in the domain, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <list class="bullet">
                    <listItem>
                      <para>Allow logon locally</para>
                    </listItem>
                    <listItem>
                      <para>Shut down the system</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Remote Desktop Users</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can log on remotely to domain controllers in the domain. This group has no default members.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Replicator</para>
                </TD>
                <TD colspan="1">
                  <para>This group supports directory replication functions. The File Replication service uses this group on domain controllers in the domain. This group has no default members. Do not add users to this group.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Server Operators</para>
                </TD>
                <TD colspan="1">
                  <para>On domain controllers, members of this group can log on interactively, create and delete shared resources, start and stop some services, back up and restore files, format the hard disk, and shut down the computer. This group has no default members. Because this group has significant power on domain controllers, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <list class="bullet">
                    <listItem>
                      <para>Back up files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Change the system time</para>
                    </listItem>
                    <listItem>
                      <para>Force shutdown from a remote system</para>
                    </listItem>
                    <listItem>
                      <para>Allow logon locally</para>
                    </listItem>
                    <listItem>
                      <para>Restore files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Shut down the system</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Users</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can perform most common tasks, such as running applications, using local and network printers, and locking the server. By default, Domain Users, Authenticated Users, and Interactive are members of this group. Therefore, any user account that is created in the domain becomes a member of this group.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </content>
      </section>
      <section address="H2_53863367">
        <title>Groups in the Users container</title>
        <content>
          <para>The following table describes the default groups that are located in the Users container, and it lists the assigned user rights for each group. For complete descriptions of the user rights that listed in the table, see User rights assignment (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=148787</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=148787</linkUri></externalLink>). For information about editing these rights, see Edit security settings on a Group Policy object (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=149139</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=149139</linkUri></externalLink>).</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD colspan="1">
                  <para>Group</para>
                </TD>
                <TD colspan="1">
                  <para>Description</para>
                </TD>
                <TD colspan="1">
                  <para>Default user rights</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD colspan="1">
                  <para>Cert Publishers</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group are permitted to publish certificates for users and computers. This group has no default members.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>DnsAdmins (installed with Domain Name System (DNS))</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group have administrative access to the DNS Server service. This group has no default members.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>DnsUpdateProxy (installed with DNS)</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group are DNS clients that can perform dynamic updates on behalf of other clients, such as DHCP servers. This group has no default members.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Domain Admins</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group have full control of the domain. By default, this group is a member of the Administrators group on all domain controllers, all domain workstations, and all domain member servers at the time that they are joined to the domain. By default, the Administrator account is a member of this group. Because the group has full control in the domain, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <list class="bullet">
                    <listItem>
                      <para>Access this computer from the network</para>
                    </listItem>
                    <listItem>
                      <para>Adjust memory quotas for a process</para>
                    </listItem>
                    <listItem>
                      <para>Back up files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Bypass traverse checking</para>
                    </listItem>
                    <listItem>
                      <para>Change the system time</para>
                    </listItem>
                    <listItem>
                      <para>Create a pagefile</para>
                    </listItem>
                    <listItem>
                      <para>Debug programs</para>
                    </listItem>
                    <listItem>
                      <para>Enable computer and user accounts to be trusted for delegation</para>
                    </listItem>
                    <listItem>
                      <para>Force a shutdown from a remote system</para>
                    </listItem>
                    <listItem>
                      <para>Increase scheduling priority</para>
                    </listItem>
                    <listItem>
                      <para>Load and unload device drivers</para>
                    </listItem>
                    <listItem>
                      <para>Allow logon locally</para>
                    </listItem>
                    <listItem>
                      <para>Manage auditing and security log</para>
                    </listItem>
                    <listItem>
                      <para>Modify firmware environment values</para>
                    </listItem>
                    <listItem>
                      <para>Profile single process</para>
                    </listItem>
                    <listItem>
                      <para>Profile system performance</para>
                    </listItem>
                    <listItem>
                      <para>Remove computer from docking station</para>
                    </listItem>
                    <listItem>
                      <para>Restore files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Shut down the system</para>
                    </listItem>
                    <listItem>
                      <para>Take ownership of files or other objects</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Domain Computers</para>
                </TD>
                <TD colspan="1">
                  <para>This group contains all workstations and servers that are joined to the domain. By default, any computer account that is created becomes a member of this group automatically.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Domain Controllers</para>
                </TD>
                <TD colspan="1">
                  <para>This group contains all domain controllers in the domain.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Domain Guests</para>
                </TD>
                <TD colspan="1">
                  <para>This group contains all domain guests.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Domain Users</para>
                </TD>
                <TD colspan="1">
                  <para>This group contains all domain users. By default, any user account that is created in the domain becomes a member of this group automatically. This group can be used to represent all users in the domain. For example, if you want all domain users to have access to a printer, you can assign permissions for the printer to this group. (Or you can add the Domain Users group to a local group—on the print server—that has permissions for the printer.)</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Enterprise Admins (appears only in the forest root domain)</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group have full control of all domains in the forest. By default, this group is a member of the Administrators group on all domain controllers in the forest. By default, the Administrator account is a member of this group. Because this group has full control of the forest, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <list class="bullet">
                    <listItem>
                      <para>Access this computer from the network</para>
                    </listItem>
                    <listItem>
                      <para>Adjust memory quotas for a process</para>
                    </listItem>
                    <listItem>
                      <para>Back up files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Bypass traverse checking</para>
                    </listItem>
                    <listItem>
                      <para>Change the system time</para>
                    </listItem>
                    <listItem>
                      <para>Create a pagefile</para>
                    </listItem>
                    <listItem>
                      <para>Debug programs</para>
                    </listItem>
                    <listItem>
                      <para>Enable computer and user accounts to be trusted for delegation</para>
                    </listItem>
                    <listItem>
                      <para>Force shutdown from a remote system</para>
                    </listItem>
                    <listItem>
                      <para>Increase scheduling priority</para>
                    </listItem>
                    <listItem>
                      <para>Load and unload device drivers</para>
                    </listItem>
                    <listItem>
                      <para>Allow logon locally</para>
                    </listItem>
                    <listItem>
                      <para>Manage auditing and security log</para>
                    </listItem>
                    <listItem>
                      <para>Modify firmware environment values</para>
                    </listItem>
                    <listItem>
                      <para>Profile single process</para>
                    </listItem>
                    <listItem>
                      <para>Profile system performance</para>
                    </listItem>
                    <listItem>
                      <para>Remove computer from docking station</para>
                    </listItem>
                    <listItem>
                      <para>Restore files and directories</para>
                    </listItem>
                    <listItem>
                      <para>Shut down the system</para>
                    </listItem>
                    <listItem>
                      <para>Take ownership of files or other objects</para>
                    </listItem>
                  </list>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Group Policy Creator Owners</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can modify Group Policy in the domain. By default, the Administrator account is a member of this group. Because this group has significant power in the domain, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>IIS_WPG (installed with IIS)</para>
                </TD>
                <TD colspan="1">
                  <para>The IIS_WPG group is the Internet Information Services (IIS) 6.0 worker process group. IIS 6.0 contains worker processes that serve specific namespaces. For example, www.microsoft.com is a namespace that is served by one worker process, which can run under an identity that is added to the IIS_WPG group, such as MicrosoftAccount. This group has no default members.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>RAS and IAS Servers</para>
                </TD>
                <TD colspan="1">
                  <para>Servers in this group are permitted access to the remote access properties of users.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>Schema Admins (appears only in the forest root domain)</para>
                </TD>
                <TD colspan="1">
                  <para>Members of this group can modify the Active Directory schema. By default, the Administrator account is a member of this group. Because this group has significant power in the forest, add users to this group with caution.</para>
                </TD>
                <TD colspan="1">
                  <para>No default user rights</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics>
    <link xlink:href="8782f8ab-9538-4111-8a68-7bfd130c21c0">Using Run as</link>
    <link xlink:href="b41edbcc-7413-4b0b-80f2-5abb6882514d">Run a program with administrative credentials</link>
    <link xlink:href="9ab05e52-2bd5-4c3d-bfb4-ff47636b79be">Create a shortcut using the runas command</link>
    <link xlink:href="7fa5714e-3897-4edb-a1ce-8fa322b0ee55">Why you should not run your computer as an administrator</link>
  </relatedTopics>
</developerConceptualDocument>

