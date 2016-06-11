---
title: Appendix B: Do Not Use a Lag Site as a Disaster Recovery Strategy
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 811652d2-d6ca-4eed-8fe4-bbd48261b20b
author: Femila
---
# Appendix B: Do Not Use a Lag Site as a Disaster Recovery Strategy
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction />
  <section>
    <content>
      <para>A "lag site" is an Active Directory site that is configured with a replication latency. For example, the site may replicate only one day of the week. Microsoft supports a replication latency up to the equivalent of the tombstone lifetime of the Active Directory forest, which is 180 days by default. In this case, a lag site is simply an out-of-date site compared to the data that is held by the majority replicas. </para>
      <para>Some <?Comment JH: The revision here was “admins can use” but the points we want to convey are:theyshould not use it as a general rule.thetypical Chris Green admin should not try it.somecustomers have this notions that they can do this, maybe they hear it from other customers.If they are doing it they do it at their own risk.Feedback from Dell at EEC was that a lot of customers do it, so I suspect many customers hear about it from other customers. 2009-04-23T15:16:00Z  Id='0?>users perceive that a lag site, with a “quasi-offline domain controller,” can be used to<?CommentEnd Id='0'
    ?> recover accidentally deleted objects faster by avoiding a restore of the affected domain controllers from backups. Some organizations have incorporated lag sites as part of their disaster recovery strategies. </para>
      <para>However, Microsoft does not support the use of a lag site as a disaster recovery strategy. Organizations are not encouraged to deploy a lag site as their sole disaster recovery solution. If they do deploy a lag site for this purpose, they do this at their own risk. </para>
      <para>In particular, hotfixes and service packs, as well as monitoring products, such as Microsoft Operations Manager (MOM) and Microsoft System Center Operations Manager, do not recognize a quasi-offline domain controller state that is differentiated by functioning replication but client computers not using the server services. Microsoft makes no guarantees that our servicing and monitoring products will not re-enable Netlogon and Key Distribution Center (KDC) services in a lag site. In addition, other Microsoft products, such as Exchange Server, are not designed to operate in a lag site and they may not function properly with lag site domain controllers.</para>
      <para>The following are some additional points to consider if your organization decides to deploy a lag site—even after acknowledgement that Microsoft does not support the use of a lag site as a disaster recovery strategy:</para>
      <list class="bullet">
        <listItem>
          <para>A lag site is not guaranteed to be intact in a disaster, such as accidental bulk deletion of objects. </para>
          <para>If the disaster is not discovered in time before replication occurs, the problem is replicated to the lag site, and the lag site cannot be used to undo the disaster.</para>
          <para>Therefore, administrators must act immediately when a disaster occurs: inbound and outbound replication must be disabled, and the <system>repadmin /force</system> command must not be used.</para>
        </listItem>
        <listItem>
          <para>Replication from a lag site might have unrecoverable consequences. </para>
          <para>Because a lag site contains out-of-date data, using it as a replication source might result in data loss, depending on the amount of latency (for example, if latency exceeds the tombstone lifetime) between the disaster event and the last replication to the lag site.</para>
          <para>If something goes wrong during recovery from a lag site, a forest recovery might be necessary to roll back the changes.</para>
        </listItem>
        <listItem>
          <para>A lag site poses security threats to the corporate environment. </para>
          <para>For example, when an employee is terminated from an organization, the employee’s user account is deleted immediately from Active Directory Domain Services (AD DS) in the main site, but the account might remain active in the lag site. If the lag site domain controllers allow logons (that is, Netlogon is not disabled), this might lead to unauthorized users having access to corporate resources.</para>
        </listItem>
      </list>
      <para>Configuring and deploying a lag site requires careful consideration: </para>
      <list class="bullet">
        <listItem>
          <para>An administrator must decide the number of lag sites to deploy in a forest. The more domains that have lag sites, the more likely that a domain can recover from a replicated disaster. However, this can also mean increased hardware and maintenance costs.</para>
        </listItem>
        <listItem>
          <para>An administrator must decide the amount of latency. The shorter the latency, the more up to date and useful the data will be in the lag site. However, this also means that administrators must act quickly to stop replication to the lag site when a disaster occurs.</para>
        </listItem>
      </list>
      <para>This list of considerations is not exhaustive, and there might be other problems with deploying lag sites as a disaster recovery strategy. Some organizations that deploy lag sites as part of a disaster recovery strategy might implement various ways of mitigating these problems. For example, an organization might implement staggered lag sites to help address the problem with replication latency or use virtualization to minimize hardware and maintenance costs. But as Microsoft has always strongly recommended, the best way to prepare for an Active Directory malfunction is to back up domain controllers frequently and verify these backups regularly through test restorations. A lag site is not a replacement for backups.</para>
      <para>Even though Microsoft does not support the use of a lag site as a disaster recovery strategy, the following will continue to be supported:</para>
      <list class="bullet">
        <listItem>
          <para>Delayed replication sites are supported. For example, you might configure a site to replicate on a custom schedule to reduce wide area network (WAN) utilization costs or to reserve WAN link utilization for other applications. This delayed replication site should not be used to restore Active Directory data or to roll back from recent changes.</para>
        </listItem>
        <listItem>
          <para>Authoritatively restoring objects on any arbitrary domain controller in a domain is supported.</para>
        </listItem>
        <listItem>
          <para>Disabling registration of domain service (SRV) resource-record-specific Domain Name System (DNS) entries that point to a given site is supported.</para>
        </listItem>
        <listItem>
          <para>Disabling replication entirely (or shutting domain controllers down) for periods not exceeding the forest tombstone lifetime on a given domain controller or on every domain controller in a site is supported.</para>
        </listItem>
      </list>
      <para>To view past Active Directory data, consider using snapshots in <token>nextref_longhorincludes>. For more information, see Active Directory Database Mounting Tool Step-by-Step Guide (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=132577</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=132577</linkUri></externalLink>).</para>
      <para>
To recover accidentally deleted objects, use Active Directory Recycle Bin, which is a new feature in <token>nextref_server_includes>. For more information, see the Active Directory Recycle Bin Step-by-Step Guide (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkID=139659</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=139659</linkUri></externalLink>).</para>
    </content>
  </section>
  <relatedTopics>
    <link xlink:href="28882508-357e-43a3-a405-c573d830c5cc">Creating a Site Design</link>
<link xlink:href="d35bcae0-fe46-4f6f-8cf2-df09e5896546">Creating a Site Link Design</link>
</relatedTopics>
</developerConceptualDocument>

