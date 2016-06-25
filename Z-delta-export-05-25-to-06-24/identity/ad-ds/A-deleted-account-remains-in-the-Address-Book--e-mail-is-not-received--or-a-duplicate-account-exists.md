---
title: A deleted account remains in the Address Book, e-mail is not received, or a duplicate account exists
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
ms.assetid: 89ba26cf-e64c-4728-b9bf-2e445f2303bf
---
# A deleted account remains in the Address Book, e-mail is not received, or a duplicate account exists
Deleted accounts remaining in the global address list \(GAL\), e\-mail messages for existing accounts not being received, or duplicate objects existing in Active Directory Domain Services \(AD DS\) are all symptoms that can indicate a lingering object problem. If you have no error or event that identifies the lingering object and its directory partition \(for example, Event ID 1388 or Event ID 1988\), you must search the global catalog for an object that you believe might be causing the problem. When you identify the lingering object and the directory partition of the object, you can perform the procedures to remove it.  
  
 **In this topic**  
  
-   [Diagnosis](#BKMK_Cause)  
  
-   [Resolution](#BKMK_Solution)  
  
    -   [Identify the duplicate (lingering) object](#BKMK_Identify_Object)  
  
    -   [Identify the directory partition of the object](#BKMK_Identify_Partition)  
  
    -   [Remove the lingering object](#BKMK_Remove_Object)  
  
##  <a name="BKMK_Cause"></a> Diagnosis  
 A lingering object exists in the global catalog in a read\-only directory partition.  
  
##  <a name="BKMK_Solution"></a> Resolution  
 Based on these symptoms of a lingering object, you usually have a good idea of the name of the object and you can use the following steps to solve the problem:  
  
-   Use this name to identify the object in the global catalog.  
  
-   Identify the directory partition of the object.  
  
-   Remove all lingering objects from that directory partition on all global catalog servers in the forest.  
  
###  <a name="BKMK_Identify_Object"></a> Identify the duplicate \(lingering\) object  
 You can use the following procedure to identify the duplicate \(lingering\) object by searching the global catalog for its distinguished name. Use an attribute that uniquely identifies the object for the account that is not receiving e\-mail, cannot be created because it already exists, or appears in the Address Book or in access control lists \(ACLs\) when it has already been deleted.  
  
 **Requirements**  
  
-   Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   Tool: Ldp.exe \(Windows Support Tools\)  
  
##### To establish the distinguished name of an object  
  
1.  Open Ldp as an administrator: Click **Start** and then, in **Start Search**, type **ldp**. At the top of the **Start** menu, right\-click **ldp.exe**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, and then click **OK**.  
  
2.  On the **Connection** menu, click **Connect**.  
  
3.  In **Port**, type **3268**, and then click **OK**.  
  
4.  On the **Connection** menu, click **Bind**.  
  
5.  In the **Bind** dialog box, provide credentials for a user account in the forest, and then click **OK**.  
  
6.  On the **View** menu, click **Tree**.  
  
7.  In the **Tree View** dialog box, in **BaseDN**, type the distinguished name of the forest root domain, and then click **OK**.  
  
8.  In the console tree, right\-click the forest root domain, and then click **Search**.  
  
9. In the **Search** dialog box, in **Filter**, replace the default filter \(objectClass\=\*\) to create a filter of the following form:  
  
     \(*attribute*\=*value*\)  
  
     where *attribute* is the Lightweight Directory Access Protocol \(LDAP\) name of an attribute and *value* is the value that you know or suspect to be associated with the object that you are searching for. For example, use \(userPrincipalName\=JanD@contoso.com\), \(sAMAccountName\=JanD\), or \(sn\=Dryml\) to locate the duplicate user object Jan Dryml. You can use the asterisk \(\*\) in the *value* field if you want to search all objects.  
  
10. In the **Scope** box, click **Subtree**, and then click **Run**.  
  
11. Click **Close**, and then view the results. You must identify which of the displayed objects should be removed from AD DS. An indication that you have found a lingering object that exists only on a global catalog server is that the object does not exist in a writable replica of the directory partition.  
  
12. If necessary, repeat steps 8 through 10 to rephrase the query, and then run it again.  
  
###  <a name="BKMK_Identify_Partition"></a> Identify the directory partition of the object  
 After you identify the distinguished name of the object that is causing problems, if it is a domain object, identify the domain in which it is located by looking at the DC\= part of the distinguished name. For example, if the object that you find has the distinguished name CN\=Jan Dryml,CN\=Users,DC\=Region1,DC\=Contoso,DC\=com, the directory partition name for the user account is DC\=Region1,DC\=Contoso,DC\=com.  
  
###  <a name="BKMK_Remove_Object"></a> Remove the lingering object  
 Use the directory partition name in the procedure "To use Repadmin to remove lingering objects" to remove the lingering object from all domain controllers and global catalog servers in the forest, as described in [Event ID 1388 or 1988: A lingering object is detected](../Topic/Event%20ID%201388%20or%201988:%20A%20lingering%20object%20is%20detected.md).