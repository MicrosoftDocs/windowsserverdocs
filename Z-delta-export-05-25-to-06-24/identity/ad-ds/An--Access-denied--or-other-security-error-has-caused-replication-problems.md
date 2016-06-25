---
title: An &quot;Access denied&quot; or other security error has caused replication problems
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 282cee9f-abef-43c9-9f33-b2c416cf8c38
---
# An &quot;Access denied&quot; or other security error has caused replication problems
This problem typically occurs when a replication destination domain controller cannot contact its source replication partner to get Active Directory updates as a result of one or more security errors occurring on the connection between the two domain controllers. You can test and diagnose replication problems that have security causes by using the Dcdiag.exe tool.  
  
-   [Diagnosis](#BKMK_Cause)  
  
-   [Resolution](#BKMK_Solution)  
  
    -   [Test a domain controller for replication security errors](#BKMK_Test_Security)  
  
    -   [Test the connection between two domain controllers for replication security errors](#BKMK_Test_Connection)  
  
##  <a name="BKMK_Cause"></a> Diagnosis  
 A replication destination domain controller cannot contact its source replication partner to get Active Directory updates as a result of one or more security errors occurring on the connection between the two domain controllers.  
  
##  <a name="BKMK_Solution"></a> Resolution  
 Run the replication security error diagnostic test in Dcdiag.  
  
###  <a name="BKMK_Test_Security"></a> Test a domain controller for replication security errors  
 You can test any or all domain controllers in your forest for security errors.  
  
 **Requirements**  
  
-   Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   Tool: Dcdiag.exe  
  
-   Operating system: The replication security test that is used in this procedure is available in versions of Dcdiag that are included with the following operating systems:  
  
    -   Windows Server 2003 with Service Pack 1 \(SP1\)  
  
    -   Windows Server 2003 with Service Pack 2 \(SP2\)  
  
    -   Windows Server 2003 R2  
  
    -   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
-   Although you can run the enhanced version of Dcdiag from computers running Windows XP Professional and Windows Server 2003 with no service pack installed, you cannot run the replication security test \(**\/test:CheckSecurityError**\) from these computers.  
  
-   Target operating systems:  
  
     You can run the Dcdiag replication security tests against domain controllers that are running the following operating systems:  
  
    -   Windows 2000 Server with Service Pack 3 \(SP3\)  
  
    -   Windows 2000 Server with Service Pack 4 \(SP4\)  
  
    -   Windows Server 2003  
  
    -   Windows Server 2003 with Service Pack 1 \(SP1\)  
  
    -   Windows Server 2003 R2  
  
    -   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
##### To test a domain controller for replication security errors  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Enterprise Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:CheckSecurityError /s:<DomainControllerName>`  
  
     where `<DomainControllerName>` is the Domain Name System \(DNS\) name, network basic input\/output system \(NetBIOS\) name, or distinguished name of the domain controller on which you want to test.  
  
     If you do not use the `/s:` switch, the test is run against the local domain controller. You can also test all domain controllers in the forest by using `/e:` instead of `/s:`.  
  
3.  Copy the report into Notepad or an equivalent text editor  
  
4.  Scroll to the Summary table near the bottom of the Dcdiag log file.  
  
5.  Note the names of all domain controllers that reported “Warn” or “Fail” status in the Summary table.  
  
6.  Find the detailed breakout section for the problem domain controller by searching for the string “DC: \<DomainControllerName\>”.  
  
7.  Make the required configuration changes on the domain controllers.  
  
     Rerun `Dcdiag /test:CheckSecurityError` with the `/e:` or `/s:` switch to validate the configuration changes.  
  
###  <a name="BKMK_Test_Connection"></a> Test the connection between two domain controllers for replication security errors  
 You can test the connection between two domain controllers in your forest for replication security errors. The domain controller that represents the source of the inbound connection does not have to be an existing source to run this test. That is, a connection object from that domain controller does not have to exist on the destination domain controller. This test is useful in the following scenarios:  
  
-   A connection exists between a source and a destination, and you receive a security error.  
  
-   A connection should be created automatically by the Knowledge Consistency Checker \(KCC\), and you want to test why the connection does not exist.  
  
-   You are trying to create a connection between two domain controllers, and you receive a security error.  
  
-   You want to determine whether a connection can be created if you want to add one on this destination from the specified source.  
  
 **Requirements**  
  
-   Membership in **Domain Admins**, or equivalent, is the minimum required to test the connection between domain controllers in your domain. Membership in **Enterprise Admins**, or equivalent, is the minimum required to test the connection between domain controllers in different domains. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   Tool: Dcdiag.exe  
  
-   Operating system: The replication security test that is used in this procedure is available in versions of Dcdiag that are included with the following operating systems:  
  
    -   Windows Server 2003 with SP1  
  
    -   Windows Server 2003 with SP2  
  
    -   Windows Server 2003 R2  
  
    -   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
-   Although you can run the enhanced version of Dcdiag from computers running Windows XP Professional and Windows Server 2003 with no service pack installed, you cannot run the replication security test \(**\/test:CheckSecurityError**\) from these computers.  
  
-   Target operating systems: You can run the Dcdiag replication security tests against domain controllers that are running the following operating systems:  
  
    -   Windows 2000 Server with SP3  
  
    -   Windows 2000 Server with SP4  
  
    -   Windows Server 2003  
  
    -   Windows Server 2003 with SP1  
  
    -   Windows Server 2003 R2  
  
    -   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
##### To test the connection between two domain controllers for replication security errors  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Enterprise Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:CheckSecurityError /ReplSource:<SourceDomainControllerName>`  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |\/test:CheckSecurityError|Locates security errors or errors that are possibly related to security problems, and performs initial diagnosis of the problem. This command tests the connection between the domain controller on which you run the command and the source replication partner that you specify in \<SourceDomainControllerName\>.|  
    |\/ReplSource|Targets a specified replication source domain controller|  
    |\<SourceDomainControllerName\>|The DNS name, NetBIOS name, or distinguished name of the real or potential source \("from"\) server that is represented by a real or potential connection object that you want to test|  
  
3.  Copy the report into Notepad or an equivalent text editor.  
  
4.  Scroll to the Summary table near the bottom of the Dcdiag log file.  
  
5.  Note the names of all domain controllers that reported “Warn” or “Fail” status in the Summary table  
  
6.  Find the detailed breakout section for the problem domain controller by searching for the string “DC: \<DomainControllerName\>”.  
  
7.  Make the required configuration changes on the domain controllers.  
  
8.  Rerun `dcdiag /test:CheckSecurityError /ReplSource:<SourceDomainControllerName>` to validate configuration changes.