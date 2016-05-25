---
title: Appendix C: Possible Issues When Restoring Attributes Used by Directory-Enabled Applications
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f99a010d-c5b1-460e-99a0-1bc72ca5b41a
author: Femila
---
# Appendix C: Possible Issues When Restoring Attributes Used by Directory-Enabled Applications
Directory\-enabled applications use Active Directory Domain Services \(AD DS\) as their directory store by storing data in the attributes of objects. Sometimes, directory\-enabled applications use the attributes that the default Active Directory schema provides. Other times, directory\-enabled applications extend the default Active Directory schema by introducing new attributes. Directory\-enabled applications require the values of some of these attributes to be unique. However, it is important to note that AD DS does not guarantee or enforce the uniqueness of attributes that applications use to store data—whether they are included in the default schema or they are introduced into it by a directory\-enabled application.  
  
Consider the following example: an administrator installs a Structured Query Language \(SQL\) service account ServiceAccount1 and registers a service principal name \(SPN\) in AD DS using the **servicePrincipalName** attribute.  
  
> [!NOTE]  
> An SPN is a name that a client computer uses to uniquely identify an instance of a service. If you install multiple instances of a service on computers throughout a forest, each service instance must have its own SPN.  
  
Later on, an administrator deletes ServiceAccount1 and creates ServiceAccount2. That administrator also assigns ServiceAccount2 the original SPN of ServiceAccount1. Sometime later, an administrator uses Active Directory Recycle Bin to restore ServiceAccount1. At this point, both live objects—ServiceAccount1 and ServiceAccount2—have the same SPN, which creates authentication problems.  
  
The following are examples of attributes from the default Active Directory schema that directory\-enabled applications often use to store data. AD DS does not enforce the uniqueness of these attributes:  
  
-   **userPrincipalName**  
  
-   **servicePrincipalName**  
  
-   **uid**  
  
-   **uidNumber**  
  
-   **employeeID**  
  
-   **employeeNumber**  
  
-   **legacyExchangeDN**  
  
-   **proxyAddresses**  
  
-   **mail**  
  
-   **textencodedORAddress**  
  
