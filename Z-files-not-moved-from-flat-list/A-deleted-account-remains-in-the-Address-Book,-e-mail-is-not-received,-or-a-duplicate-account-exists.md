---
title: A deleted account remains in the Address Book, e-mail is not received, or a duplicate account exists
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 89ba26cf-e64c-4728-b9bf-2e445f2303bf
author: Femila
---
# A deleted account remains in the Address Book, e-mail is not received, or a duplicate account exists
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>Deleted accounts remaining in the global address list (GAL), e-mail messages for existing accounts not being received, or duplicate objects existing in Active Directory Domain Services (AD DS) are all symptoms that can indicate a lingering object problem. If you have no error or event that identifies the lingering object and its directory partition (for example, Event ID 1388 or Event ID 1988), you must search the global catalog for an object that you believe might be causing the problem. When you identify the lingering object and the directory partition of the object, you can perform the procedures to remove it.</para>
    <para>
      <embeddedLabel>In this topic</embeddedLabel>
    </para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="#BKMK_Cause">Diagnosis</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_Solution">Resolution</link>
        </para>
        <list class="bullet">
          <listItem>
            <para>
              <link xlink:href="#BKMK_Identify_Object">Identify the duplicate (lingering) object</link>
            </para>
          </listItem>
          <listItem>
            <para>
              <link xlink:href="#BKMK_Identify_Partition">Identify the directory partition of the object</link>
            </para>
          </listItem>
          <listItem>
            <para>
              <link xlink:href="#BKMK_Remove_Object">Remove the lingering object</link>
            </para>
          </listItem>
        </list>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Cause">
    <title>Diagnosis</title>
    <content>
      <para>A lingering object exists in the global catalog in a read-only directory partition.</para>
    </content>
  </section>
  <section address="BKMK_Solution">
    <title>Resolution</title>
    <content>
      <para>Based on these symptoms of a lingering object, you usually have a good idea of the name of the object and you can use the following steps to solve the problem: </para>
      <list class="bullet">
        <listItem>
          <para>Use this name to identify the object in the global catalog.</para>
        </listItem>
        <listItem>
          <para>Identify the directory partition of the object.</para>
        </listItem>
        <listItem>
          <para>Remove all lingering objects from that directory partition on all global catalog servers in the forest.</para>
        </listItem>
      </list>
    </content>
    <sections>
      <section address="BKMK_Identify_Object">
        <title>Identify the duplicate (lingering) object</title>
        <content>
          <para>You can use the following procedure to identify the duplicate (lingering) object by searching the global catalog for its distinguished name. Use an attribute that uniquely identifies the object for the account that is not receiving e-mail, cannot be created because it already exists, or appears in the Address Book or in access control lists (ACLs) when it has already been deleted.</para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in <embeddedLabel>Domain Admins</embeddedLabel>, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tool: Ldp.exe (Windows Support Tools)</para>
            </listItem>
          </list>
          <procedure>
            <title>To establish the distinguished name of an object</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Open Ldp as an administrator: Click <ui>Start</ui> and then, in <ui>Start Search</ui>, type <userInput>ldp</userInput>. At the top of the <ui>Start</ui> menu, right-click <ui>ldp.exe</ui>, and then click <ui>Run as administrator</ui>. If the <ui>User Account Control</ui> dialog box appears, provide Domain Admins credentials, and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>On the <ui>Connection</ui> menu, click <ui>Connect</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In <ui>Port</ui>, type <ui>3268</ui>, and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>On the <ui>Connection</ui> menu, click <ui>Bind</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the <ui>Bind</ui> dialog box, provide credentials for a user account in the forest, and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>On the <ui>View</ui> menu, click <ui>Tree</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the <ui>Tree View</ui> dialog box, in <ui>BaseDN</ui>, type the distinguished name of the forest root domain, and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the console tree, right-click the forest root domain, and then click <ui>Search</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the <ui>Search</ui> dialog box, in <ui>Filter</ui>, replace the default filter (objectClass=*) to create a filter of the following form:</para>
                  <para>(<placeholder>attribute</placeholder>=<placeholder>value</placeholder>)</para>
                  <para>where <placeholder>attribute</placeholder> is the Lightweight Directory Access Protocol (LDAP) name of an attribute and <placeholder>value</placeholder> is the value that you know or suspect to be associated with the object that you are searching for. For example, use (userPrincipalName=JanD@contoso.com), (sAMAccountName=JanD), or (sn=Dryml) to locate the duplicate user object Jan Dryml. You can use the asterisk (*) in the <placeholder>value</placeholder> field if you want to search all objects.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the <ui>Scope</ui> box, click <ui>Subtree</ui>, and then click <ui>Run</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Click <ui>Close</ui>, and then view the results. You must identify which of the displayed objects should be removed from AD DS. An indication that you have found a lingering object that exists only on a global catalog server is that the object does not exist in a writable replica of the directory partition. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>If necessary, repeat steps 8 through 10 to rephrase the query, and then run it again.</para>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
      <section address="BKMK_Identify_Partition">
        <title>Identify the directory partition of the object</title>
        <content>
          <para>After you identify the distinguished name of the object that is causing problems, if it is a domain object, identify the domain in which it is located by looking at the DC= part of the distinguished name. For example, if the object that you find has the distinguished name CN=Jan Dryml,CN=Users,DC=Region1,DC=Contoso,DC=com, the directory partition name for the user account is DC=Region1,DC=Contoso,DC=com.</para>
        </content>
      </section>
      <section address="BKMK_Remove_Object">
        <title>Remove the lingering object</title>
        <content>
          <para>Use the directory partition name in the procedure "To use Repadmin to remove lingering objects" to remove the lingering object from all domain controllers and global catalog servers in the forest, as described in <link xlink:href="d8e0b934-be71-4929-b377-d3330c6811e9">Event ID 1988 or 1388: A lingering object is detected</link>.</para>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>

