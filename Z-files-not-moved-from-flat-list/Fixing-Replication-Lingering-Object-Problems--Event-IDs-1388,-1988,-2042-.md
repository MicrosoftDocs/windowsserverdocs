---
title: Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 53ea71ae-4ecb-475a-935b-cd6a9afff02e
author: Femila
---
# Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>If a domain controller does not replicate for a period of time that is longer than the tombstone lifetime and the domain controller is then reconnected to the replication topology, objects that were deleted from Active Directory Domain Services (AD DS) while the domain controller was offline can remain on the domain controller as lingering objects. </para>
    <para>A lingering object can be reintroduced into AD DS if it is allowed to replicate to another domain controller that has deleted the object and has also deleted (garbage-collected) the tombstone for the deleted object. This topic explains the criteria for when and how such replication can occur. Because domain controllers that are running Windows 2000 Server are capable of replicating lingering objects and because the upgrade path from Windows 2000 Server to <token>nextref_longhorincludes> can result in a <token>nextref_longhorincludes> domain controller that retains this capability, it is important to be aware of these conditions and correct them if you are upgrading a Windows 2000 Server forest to <token>nextref_longhorincludes>.</para>
    <para>
      <embeddedLabel>In this topic</embeddedLabel>
    </para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="#BKMK_TSL_Deletions">Tombstone lifetime and replication of deletions</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_How">How lingering objects occur</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Causes">Causes of long disconnections</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Indications">Indications that a domain controller could have lingering objects</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Symptoms">Symptoms associated with lingering objects</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Registry">Registry setting that determines whether lingering objects are replicated</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Default">Default settings for strict replication consistency</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Enabling">Enabling strict replication consistency</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Tool">Tool for removing lingering objects</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_TSL_Deletions">
    <title>Tombstone lifetime and replication of deletions</title>
    <content>
      <para>When an object is deleted, AD DS replicates the deletion as a tombstone object, which consists of a small subset of the attributes of the deleted object. By inbound-replicating this object, other domain controllers in the domain and forest become aware of the deletion. The tombstone is retained in AD DS for a specified period, called the tombstone lifetime. At the end of the tombstone lifetime, the tombstone is deleted from the directory permanently. </para>
      <para>The default value of the tombstone lifetime depends on the version of the operating system that is running on the first domain controller that is installed in a forest, as follows:</para>
      <list class="bullet">
        <listItem>
          <para>Windows 2000 Server or Windows Server 2003: The default value is 60 days.</para>
        </listItem>
        <listItem>
          <para>Windows Server 2003 with Service Pack 1 (SP1), Windows Server 2003 with Service Pack 2 (SP2), Windows Server 2003 R2, <token>nextref_longhorincludes>: The default value is 180 days.</para>
        </listItem>
      </list>
      <alert class="note">
        <para>The tombstone lifetime value is a forest-wide setting that you can change administratively. The tombstone lifetime value that is in effect when a domain controller is upgraded from a version of Windows 2000 Server or Windows Server 2003 without SP1 is not changed in the upgrade. The existing value is maintained until you change it manually.</para>
      </alert>
      <para>After the tombstone is removed permanently, the object deletion can no longer be replicated. Therefore, the tombstone lifetime determines how long domain controllers in the forest retain a record of a deleted object. Therefore, the tombstone lifetime determines the time during which a unique deletion must be received by all direct and transitive replication partners of the originating domain controller.</para>
    </content>
  </section>
  <section address="BKMK_How">
    <title>How lingering objects occur</title>
    <content>
      <para>When conditions beyond your control cause a domain controller to be disconnected from the replication topology for a period that is longer than the tombstone lifetime, one or more objects that are deleted from AD DS on all other domain controllers might remain on the disconnected domain controller. Such objects are called lingering objects. Because the domain controller is disconnected from the replication topology during the entire time that the tombstone exists in the directory, the domain controller never receives replication of the tombstone.</para>
      <para>When it is reconnected to the replication topology, this domain controller acts as a source replication partner that has an object that its destination replication partner does not have.</para>
      <para>Replication problems occur when the object on the source domain controller is updated. In this case, when the destination domain controller attempts to inbound-replicate the update, one of the following occurs:</para>
      <list class="bullet">
        <listItem>
          <para>If the destination domain controller has strict replication consistency enabled, it recognizes that it cannot update the object (because the object does not exist), and it locally halts inbound replication of the directory partition from that source domain controller.</para>
        </listItem>
        <listItem>
          <para>If the destination domain controller has strict replication consistency disabled, it requests the full replica of the updated object. In this case, the object is reintroduced into the directory.</para>
        </listItem>
      </list>
      <para>Lingering objects can reside in writable or read-only directory partitions that are potentially replicated between domain controllers in the same domain or in different domains in the same forest.</para>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes of long disconnections</title>
    <content>
      <para>Unexpectedly long disconnections can be caused by the following conditions:</para>
      <list class="bullet">
        <listItem>
          <para>A domain controller is left in a storage room and forgotten, or shipment of a prestaged domain controller to its remote location takes longer than a tombstone lifetime.</para>
        </listItem>
        <listItem>
          <para>Replication fails and monitoring is not in place. Failures can occur as follows:</para>
          <list class="bullet">
            <listItem>
              <para>A domain controller is started and connected to the corporate intranet, but the domain controller experiences inbound replication failure as a result of an underlying network connectivity failure, name resolution failure, or authentication failure that prevents replication from occurring.</para>
            </listItem>
            <listItem>
              <para>A bridgehead server is overloaded, and replication becomes backlogged. Excessively high replication load on a global catalog server, in combination with a short intersite replication interval, can result in updates not being replicated.</para>
            </listItem>
          </list>
        </listItem>
      </list>
      <alert class="note">
        <para>Global catalog servers replicate read-only replicas of all domain directory partitions in the forest. The replication of read-only replicas has a lower priority than the replication of writable replicas. In addition, global catalog servers are often bridgehead servers, which adds to the replication load. If the replication load on global catalog servers acting as bridgehead servers is too high as a result of an extremely short replication interval, excessive numbers of concurrent outbound replication partners, or a combination of both, the replication queue can become backlogged. If the condition persists, read-only replicas can remain in the queue indefinitely. These conditions can result in lingering objects on a global catalog server.</para>
      </alert>
      <list class="bullet">
        <listItem>
          <para>Wide area network (WAN) connections are unavailable for long periods. For example, a domain controller onboard a cruise ship might be unable to replicate because the ship is at sea for longer than the tombstone lifetime.</para>
        </listItem>
        <listItem>
          <para>The reported event is a false positive because an administrator shortened the tombstone lifetime to force tombstone deletion (garbage collection).</para>
        </listItem>
        <listItem>
          <para>The reported event is a false positive because the system clock on the source or destination domain controller is improperly rolled forward or back in time. Clock skews are most common following a system reboot and can have the following causes:</para>
          <list class="bullet">
            <listItem>
              <para>There are system clock battery or motherboard problems.</para>
            </listItem>
            <listItem>
              <para>The time source for a computer is improperly configured, including a time source server that is configured with Windows Time service (W32time), non-Microsoft time servers, and network routers.</para>
            </listItem>
            <listItem>
              <para>The system clock is advanced or rolled back by an administrator who is attempting to extend the useful life of a system state backup or accelerate the garbage collection of deleted objects. Make sure that the system clock reflects the actual time and that event logs do not contain events from the future or the invalid past. </para>
            </listItem>
          </list>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Indications">
    <title>Indications that a domain controller could have lingering objects</title>
    <content>
      <para>An outdated domain controller can store lingering objects with no noticeable effect as long as an administrator, application, or service does not update the lingering object or attempt to create an object with the same name in the domain or with the same user principal name (UPN) in the forest. However, the existence of lingering objects can cause problems, especially if the object is a security principal.</para>
    </content>
    <sections>
      <section address="BKMK_Symptoms">
        <title>Symptoms associated with lingering objects</title>
        <content>
          <para>The following symptoms indicate that a domain controller could have lingering objects: </para>
          <list class="bullet">
            <listItem>
              <para>A deleted user or group account remains in the global address list (GAL) on Exchange servers. Therefore, although the account name appears in the GAL, attempts to send e-mail messages result in errors.</para>
            </listItem>
            <listItem>
              <para>Multiple copies of an object appear in the object picker or GAL for an object that should be unique in the forest. Duplicate objects sometimes appear with altered names, causing confusion on directory searches. For example, if the relative distinguished name of two objects cannot be resolved, conflict resolution appends "*CNF:<placeholder>GUID</placeholder>" to the name, where * represents a reserved character, CNF is a constant that indicates a conflict resolution, and <placeholder>GUID</placeholder> represents the <embeddedLabel>objectGUID</embeddedLabel> attribute value.</para>
            </listItem>
            <listItem>
              <para>E-mail messages are not delivered to a user whose Active Directory account appears to be current. After an outdated domain controller or global catalog server becomes reconnected, both instances of the user object appear in the global catalog. Because both objects have the same e-mail address, e-mail messages cannot be delivered.</para>
            </listItem>
            <listItem>
              <para>A universal group that no longer exists continues to appear in a user’s access token. Although the group no longer exists, if a user account still has the group in its security token, the user might have access to a resource that you intended to be unavailable to that user.</para>
            </listItem>
            <listItem>
              <para>A new object or Exchange mailbox cannot be created, but you do not see the object in AD DS. An error message reports that the object already exists.</para>
            </listItem>
            <listItem>
              <para>Searches that use attributes of an existing object incorrectly find multiple copies of an object of the same name. One object has been deleted from the domain, but it remains in an isolated global catalog server.</para>
            </listItem>
          </list>
          <para>If an attempt is made to update a lingering object that resides in a writable directory partition, events are logged on the destination domain controller. However, if the only version of a lingering object exists in a read-only directory partition on a global catalog server, the object cannot be updated and this type of event will never be triggered.</para>
        </content>
      </section>
      <section address="BKMK_Registry">
        <title>Registry setting that determines whether lingering objects are replicated</title>
        <content>
          <para>If a writable lingering object exists in your environment and an attempt is made to update the object, the value in the <embeddedLabel>strict replication consistency</embeddedLabel> registry entry (type <embeddedLabel>REG_DWORD</embeddedLabel>) in <embeddedLabel>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSParameters</embeddedLabel> determines whether replication proceeds or is stopped, as follows:</para>
          <list class="bullet">
            <listItem>
              <para>
                <embeddedLabel>1</embeddedLabel> (enabled): Inbound replication of the specified directory partition from the source is stopped on the destination.</para>
            </listItem>
            <listItem>
              <para>
                <embeddedLabel>0</embeddedLabel> (disabled): The destination requests the full object from the source domain controller, and the lingering object is revived in the directory as a new object.</para>
            </listItem>
          </list>
        </content>
        <sections>
          <section address="BKMK_Default">
            <title>Default settings for strict replication consistency</title>
            <content>
              <para>The default value for the <embeddedLabel>strict replication consistency</embeddedLabel> registry entry on a domain controller is determined by the conditions under which the domain controller is installed into the forest.</para>
              <alert class="note">
                <para>Raising the domain or forest functional level does not change the replication consistency setting on any domain controller.</para>
              </alert>
              <para>
                <embeddedLabel>Strict replication consistency enabled</embeddedLabel>
              </para>
              <para>The default value of <embeddedLabel>strict replication consistency</embeddedLabel> is ENABLED (<embeddedLabel>1</embeddedLabel>) on domain controllers that are installed into a forest under the following conditions:</para>
              <list class="bullet">
                <listItem>
                  <para>The forest root domain of a new forest was created by installing AD DS on a server running one of the following operating systems:</para>
                  <list class="bullet">
                    <listItem>
                      <para>
                        <token>nextref_longhorincludes>
                      </para>
                    </listItem>
                    <listItem>
                      <para>Windows Server 2003</para>
                    </listItem>
                  </list>
                </listItem>
                <listItem>
                  <para>The forest root domain of a new forest was created by upgrading a Windows NT 4.0 primary domain controller (PDC) to Windows Server 2003 by using the Windows Server 2003 version of Winnt32.exe.</para>
                </listItem>
              </list>
              <para>
                <embeddedLabel>Strict replication consistency disabled</embeddedLabel>
              </para>
              <para>The default value of <embeddedLabel>strict replication consistency</embeddedLabel> is DISABLED (<embeddedLabel>0</embeddedLabel>) on domain controllers under the following conditions:</para>
              <list class="bullet">
                <listItem>
                  <para>A domain controller running Windows 2000 Server is upgraded to Windows Server 2003.</para>
                  <para>The same domain controller is upgraded to <token>nextref_longhorincludes>.</para>
                </listItem>
                <listItem>
                  <para>A new domain controller is created by installing Active Directory on a member server running Windows 2000 Server.</para>
                  <para>The same domain controller is upgraded to Windows Server 2003.</para>
                </listItem>
                <listItem>
                  <para>A member server running Windows 2000 Server is upgraded to Windows Server 2003, and Active Directory is subsequently installed.</para>
                  <para>The same domain controller is upgraded to <token>nextref_longhorincludes>.</para>
                </listItem>
              </list>
              <para>For more information about strict replication consistency, see "How the Active Directory Replication Model Works" in the Windows Server 2003 Technical Reference (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=27636</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=27636</linkUri></externalLink>).</para>
            </content>
          </section>
        </sections>
      </section>
    </sections>
  </section>
  <section address="BKMK_Enabling">
    <title>Enabling strict replication consistency</title>
    <content>
      <para>In scenarios in which strict replication consistency is disabled, you can enable strict replication manually in the following ways:</para>
      <list class="bullet">
        <listItem>
          <para>Single domain controller: Use Repadmin or Regedit to change the setting on the domain controller.</para>
          <alert class="note">
            <para>The Repadmin commands for setting replication consistency are available on domain controllers that are running at least Windows Server 2003 with SP1. For earlier versions, you must use Regedit.</para>
          </alert>
        </listItem>
        <listItem>
          <para>All domain controllers in the forest: Use Repadmin to change the setting on all domain controllers in the forest.</para>
        </listItem>
        <listItem>
          <para>All future domain controllers that are created in the forest: Use Ldifde.exe to create the operational GUID in the configuration directory partition that enables strict replication consistency on any new domain controller that is added to the forest.</para>
        </listItem>
      </list>
      <para>For instructions to enable strict replication consistency, see <link xlink:href="d8e0b934-be71-4929-b377-d3330c6811e9">Event ID 1988 or 1388: A lingering object is detected</link>.</para>
    </content>
  </section>
  <section address="BKMK_Tool">
    <title>Tool for removing lingering objects</title>
    <content>
      <para>On domain controllers running <token>nextref_longhorincludes>, Repadmin is installed by default. On domain controllers running Windows Server 2003 or Windows Server 2003 with SP1, use Repadmin.exe (in Windows Support Tools) to remove the lingering object or objects. Windows Support Tools are available on the operating system CD in the SupportTools folder or from the Microsoft Download Center (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=100114</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=100114</linkUri></externalLink>). The version of Repadmin that ships with Windows Server 2003 provides the option <system>/removelingeringobjects</system>, which safely removes instances of lingering objects from both writable directory partitions and read-only directory partitions.</para>
      <para>The <system>repadmin /removelingeringobjects</system> command does the following:</para>
      <list class="ordered">
        <listItem>
          <para>Compares the directory database objects on a reference domain controller with the objects on the target domain controller, which contains (or is suspected to contain) lingering objects. There must be connectivity between the reference domain controller and the target domain controller.</para>
        </listItem>
        <listItem>
          <para>Either removes the lingering objects or logs the potential deletions to the Directory Service event log, as follows:</para>
          <list class="bullet">
            <listItem>
              <para>If you use the <system>/advisory_mode</system> parameter, events are logged in the Directory Service event log for the objects that are found.</para>
            </listItem>
            <listItem>
              <para>If you do not use the <system>/advisory_mode</system> parameter, the found objects are deleted without replicating the deletions. That is, the deletions occur only on the target domain controller.</para>
            </listItem>
          </list>
        </listItem>
      </list>
      <para>From the following list, choose the problem that best describes your situation, and then complete the procedures for the suggested fix:</para>
      <list class="bullet">
        <listItem>
          <para>
            <link xlink:href="d8e0b934-be71-4929-b377-d3330c6811e9">Event ID 1988 or 1388: A lingering object is detected</link>
          </para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="89ba26cf-e64c-4728-b9bf-2e445f2303bf">A deleted account remains in the Address Book, e-mail is not received, or a duplicate account exists</link>
          </para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="eee53935-a1f0-4c65-9386-e0f5d97bdb6b">Event ID 2042: It has been too long since this machine replicated</link>
          </para>
        </listItem>
      </list>
    </content>
  </section>
  <relatedTopics />
</developerConceptualDocument>

