---
ms.assetid: 5a1ae56b-adcb-447e-9e34-c0629d7cb241
title: Manually Configure a Service Account for a Federation Server Farm
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Manually Configure a Service Account for a Federation Server Farm

If you intend to configure a federation server farm environment in Active Directory Federation Services \(AD FS\), you must create and configure a dedicated service account in Active Directory Domain Services \(AD DS\) where the farm will reside. You then configure each federation server in the farm to use this account. You must complete the following tasks in your organization when you want to allow client computers on the corporate network to authenticate to any of the federation servers in an AD FS farm using Windows Integrated Authentication.  

> [!IMPORTANT]
> As of AD FS 3.0 (Windows Server 2012 R2), AD FS supports the use of a [Group Managed Service Account](https://docs.microsoft.com/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview) \(gMSA\) as the service account.  This is the recommended option, as it removes the need for managing the service account password over time.  This document covers the alternate case of using a traditional service account, such as in domains still running a Windows Server 2008 R2 or earlier domain functional level \(DFL\).

> [!NOTE]  
> You have to perform the tasks in this procedure only one time for the entire federation server farm. Later, when you create a federation server by using the AD FS Federation Server Configuration Wizard, you must specify this same account on the **Service Account** wizard page on each federation server in the farm.  
  
#### Create a dedicated service account  
  
1.  Create a dedicated user\/service account in the Active Directory forest that is located in the identity provider organization. This account is necessary for the Kerberos authentication protocol to work in a farm scenario and to allow pass\-through authentication on each of the federation servers. Use this account only for the purposes of the federation server farm.  
  
2.  Edit the user account properties, and select the **Password never expires** check box. This action ensures that this service account's function is not interrupted as a result of domain password change requirements.  
  
    > [!NOTE]  
    > Using the Network Service account for this dedicated account will result in random failures when access is attempted through Windows Integrated Authentication, as a result of Kerberos tickets not validating from one server to another.  
  
#### To set the SPN of the service account  
  
1.  Because the application pool identity for the AD FS AppPool is running as a domain user\/service account, you must configure the Service Principal Name \(SPN\) for that account in the domain with the Setspn.exe command\-line tool. Setspn.exe is installed by default on computers running  Windows Server 2008 . Run the following command on a computer that is joined to the same domain where the user\/service account resides:  
  
    ```  
    setspn -a host/<server name> <service account>  
    ```  
  
    For example, in a scenario in which all federation servers are clustered under the Domain Name System \(DNS\) host name fs.fabrikam.com and the service account name that is assigned to the AD FS AppPool is named adfs2farm, type the command as follows, and then press ENTER:  
  
    ```  
    setspn -a host/fs.fabrikam.com adfs2farm  
    ```  
  
    It is necessary to complete this task only once for this account.  
  
2.  After the AD FS AppPool identity is changed to the service account, set the access control lists \(ACLs\) on the SQL Server database to allow Read access to this new account so that the AD FS AppPool can read the policy data.  
  

