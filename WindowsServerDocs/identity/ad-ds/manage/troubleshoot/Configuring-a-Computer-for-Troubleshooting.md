---
ms.assetid: 155abe09-6360-4913-8dd9-7392d71ea4e6
title: Configuring a Computer for Troubleshooting
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---
# Configuring a Computer for Troubleshooting

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>Before you use advanced troubleshooting techniques to identify and fix Active Directory problems, configure your computers for troubleshooting. You should also have a basic understanding of <token>nextref_longhorincludes> troubleshooting concepts, procedures, and tools. </para>
    <para>For information about monitoring tools for Windows Server 2008, see the Step-by-Step Guide for Performance and Reliability Monitoring in Windows Server 2008 (<externalLink><linkText>https://go.microsoft.com/fwlink/?LinkId=123737</linkText><linkUri>https://go.microsoft.com/fwlink/?LinkId=123737</linkUri></externalLink>).</para>
  </introduction>
  <section>
    <title>Configuration tasks for troubleshooting</title>
    <content>
      <para>To configure your computer for troubleshooting Active Directory Domain Services (AD DS), perform the following tasks:</para>
      <para>
        <link xlink:href="#BKMK_2">Install Remote Server Administration Tools for AD DS</link>
      </para>
      <para>
        <link xlink:href="#BKMK_3">Configure Reliability and Performance Monitor</link>
      </para>
      <para>
        <link xlink:href="#BKMK_4">Set logging levels</link>
      </para>
    </content>
    <sections>
      <section address="BKMK_2">
        <title>Install Remote Server Administration Tools for AD DS</title>
        <content>
          <para>When you install AD DS to create a domain controller, the administrative tools that you use to manage AD DS are installed automatically. If you want to manage domain controllers remotely from a computer that is not a domain controller, you can install the administrative tools on a member server that is running <token>nextref_longhorincludes> or on a computer that is running Windows Vista with Service Pack 1 (SP1). On member servers that are running <token>nextref_longhorincludes>, you use the Remote Server Administration Tools (RSAT) feature in Server Manager to install Active Directory Domain Services Tools. RSAT replaces Windows Support Tools in Windows Server 2003. You can also install Active Directory Domain Services Tools on a computer that is running Windows Vista with Service Pack 1 (SP1) by downloading the tools to that computer.</para>
          <para>For information about installing RSAT, see <link xlink:href="610ba7d9-51b5-4e14-9232-0510a9091aba">Installing Remote Server Administration Tools for AD DS</link>.</para>
        </content>
      </section>
      <section address="BKMK_3">
        <title>Configure Reliability and Performance Monitor</title>
        <content>
          <para>Windows Server 2008 includes the Windows Reliability and Performance Monitor, which is a Microsoft Management Console (MMC) snap-in that combines the functionality of previous stand-alone tools, including Performance Logs and Alerts, Server Performance Advisor, and System Monitor. This snap-in provides a graphical user interface (GUI) for customizing Data Collector Sets and Event Trace Sessions. 
</para>
          <para>Reliability and Performance Monitor also includes Reliability Monitor, an MMC snap-in that tracks changes to the system and compares them to changes in system stability, providing a graphical view of their relationship. </para>
        </content>
      </section>
      <section address="BKMK_4">
        <title>Set logging levels</title>
        <content>
          <para>If the information that you receive in the Directory Service log in Event Viewer is not sufficient for troubleshooting, raise the logging levels by using the appropriate registry entry in <embeddedLabel>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSDiagnostics</embeddedLabel>. </para>
          <para>By default, the logging levels for all entries are set to <embeddedLabel>0</embeddedLabel>, which provides the minimum amount of information. The highest logging level is <embeddedLabel>5</embeddedLabel>. Increasing the level for an entry causes additional events to be logged in the Directory Service event log. </para>
          <para>You can use the following procedure to change the logging level for a diagnostic entry. </para>
          <alert class="caution">
            <para>We recommend that you do not directly edit the registry unless there is no other alternative. Modifications to the registry are not validated by the registry editor or by Windows before they are applied, and as a result, incorrect values can be stored. This can result in unrecoverable errors in the system. When possible, use Group Policy or other Windows tools, such as MMC snap-ins, to accomplish tasks, rather than editing the registry directly. If you must edit the registry, use extreme caution. </para>
          </alert>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in <embeddedLabel>Domain Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tools: Regedit.exe</para>
            </listItem>
          </list>
          <procedure>
            <title>To change the logging level for a diagnostic entry</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Click <ui>Start</ui>, click <ui>Run</ui>, type <userInput>regedit</userInput>, and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Navigate to the entry for which you want to set logging in <embeddedLabel>HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSDiagnostics</embeddedLabel>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Double-click the entry, and in <embeddedLabel>Base</embeddedLabel>, click <embeddedLabel>Decimal</embeddedLabel>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In <embeddedLabel>Value</embeddedLabel>, type an integer from <embeddedLabel>0</embeddedLabel> through <embeddedLabel>5</embeddedLabel>, and then click <ui>OK</ui>.</para>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>


