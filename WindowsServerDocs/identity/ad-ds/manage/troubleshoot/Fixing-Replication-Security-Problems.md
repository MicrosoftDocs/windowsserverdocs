---
ms.assetid: 104df2f0-6731-4a1d-b17c-815ac8a5aaa7
title: Fixing Replication Security Problems
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Fixing Replication Security Problems

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This section provides a description of security problems that you might experience when Active Directory replication is enabled. When security problems cause replication to fail, various event log messages and Repadmin messages contain error codes that identify the problems.</para>
    <para>The Dcdiag.exe tool reports on the overall health of replication with respect to Active Directory Domain Services (AD DS). Dcdiag detects common causes of "Access denied" events, "Account unknown" events, and similar events. The Dcdiag security test was introduced in Windows Server 2003 with Service Pack 1 (SP1). It is not available in earlier versions of Windows Server.</para>
    <para>The error codes that Dcdiag detects are described in the following table. Error codes that are marked with an asterisk (*) are not always caused by a security problem. </para>
    <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
      <thead>
        <tr>
          <TD colspan="1">
            <para>Error code</para>
          </TD>
          <TD colspan="1">
            <para>Description</para>
          </TD>
        </tr>
      </thead>
      <tbody>
        <tr>
          <TD colspan="1">
            <para>5</para>
          </TD>
          <TD colspan="1">
            <para>Access is denied.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>1314*</para>
          </TD>
          <TD colspan="1">
            <para>A required privilege is not held by the client.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>1326</para>
          </TD>
          <TD colspan="1">
            <para>Logon failure: unknown user name or bad password.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>1396</para>
          </TD>
          <TD colspan="1">
            <para>Logon failure: The target account name is incorrect.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>1908</para>
          </TD>
          <TD colspan="1">
            <para>Could not find the domain controller for this domain.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>1397*</para>
          </TD>
          <TD colspan="1">
            <para>Mutual authentication failed. The server's password is out of date at the domain controller.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>1398*</para>
          </TD>
          <TD colspan="1">
            <para>There is a time and/or date difference between the client and server.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>1722*</para>
          </TD>
          <TD colspan="1">
            <para>The remote procedure call (RPC) server is unavailable.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>2202*</para>
          </TD>
          <TD colspan="1">
            <para>The specified username is invalid.</para>
          </TD>
        </tr>
        <tr>
          <TD colspan="1">
            <para>8453</para>
          </TD>
          <TD colspan="1">
            <para>Replication access was denied.</para>
          </TD>
        </tr>
      </tbody>
    </table>
    <para>Use the procedures in <link xlink:href="282cee9f-abef-43c9-9f33-b2c416cf8c38">An "Access denied" or other security error has caused replication problems</link> to diagnose and fix replication security problems.</para>
  </introduction>
  <relatedTopics />
</developerConceptualDocument>


