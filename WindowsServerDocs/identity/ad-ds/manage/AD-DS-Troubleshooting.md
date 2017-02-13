---
ms.assetid: fd3bc84a-48eb-4f00-9dc2-846bf2c2668b
title: AD DS Troubleshooting
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# AD DS Troubleshooting

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This guide provides troubleshooting information for Active Directory Domain Services (AD DS) in the <token>firstref_longhorincludes> operating system. It is designed to help you identify and resolve problems that may be related to AD DS. Conditions for domain controllers that are running versions of Windows Server 2003 in a <token>nextref_longhorincludes> forest are also discussed.</para>
    <para>This release of this guide includes troubleshooting recommendations and procedures for diagnosing and fixing problems that may occur with Active Directory replication in a <token>nextref_longhorincludes> forest. This content focuses primarily on responses to Directory Service event log messages and tool-based error messages that might be reported by the Repadmin.exe and Dcdiag.exe tools. These tools are available on all domain controllers that are running <token>nextref_longhorincludes>. You can also install Remote Server Administration Tools (RSAT) on a member server that is running <token>nextref_longhorincludes> or on a computer that is running Windows Vista with Service Pack 1 (SP1). For information about installing RSAT, see <link xlink:href="dcf023ca-4e29-4893-a699-8a5c3e1f4980">Configuring a Computer for Troubleshooting Active Directory</link>.</para>
    <para>
      <embeddedLabel>In this guide</embeddedLabel> </para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="dcf023ca-4e29-4893-a699-8a5c3e1f4980">Configuring a Computer for Troubleshooting Active Directory</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="13964079-3aaa-4551-9140-9687b333e752">Troubleshooting Active Directory Replication Problems</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="16b28028-e0f9-483b-bf2a-3c2f43f0e462">Additional Resources for Troubleshooting Active Directory</link>
        </para>
      </listItem>
    </list>
    <para>
      <embeddedLabel>Acknowledgments</embeddedLabel>
    </para>
    <para>Produced by: Microsoft Windows Server Directory and Access Services (DAS) IT Pro Content Team</para>
    <para>Writer: Mary Hillman</para>
    <para>Editor: Jim Becker</para>
    <para>Technical reviewers: Arren Conner, Kurt Hudson, Gregory Johnson, Rob Kochman, Ajit Krishnan, Dave Tesar</para>
  </introduction>
  <relatedTopics />
</developerConceptualDocument>


