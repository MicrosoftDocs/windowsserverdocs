---
title: Manually Configure a Service Account for a Federation Server Farm
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47fae752-5306-4614-a74c-c40555cf4bab
author: billmath
---
# Manually Configure a Service Account for a Federation Server Farm
If you intend to configure a federation server farm environment in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you must create and configure a dedicated service account in Active Directory Domain Services \(AD DS\) where the farm will reside. You then configure each federation server in the farm to use this account. You must complete the following tasks in your organization when you want to allow client computers on the corporate network to authenticate to any of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s in an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] farm using Windows Integrated Authentication.  
  
> [!NOTE]  
> You have to perform the tasks in this procedure only one time for the entire [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] farm. Later, when you create a federation server by using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Federation Server Configuration Wizard, you must specify this same account on the **Service Account** wizard page on each [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the farm.  
  
#### Create a dedicated service account  
  
1.  Create a dedicated user\/service account in the Active Directory forest that is located in the identity provider organization. This account is necessary for the Kerberos authentication protocol to work in a farm scenario and to allow pass\-through authentication on each of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s. Use this account only for the purposes of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] farm.  
  
2.  Edit the user account properties, and select the **Password never expires** check box. This action ensures that this service account's function is not interrupted as a result of domain password change requirements.  
  
    > [!NOTE]  
    > Using the Network Service account for this dedicated account will result in random failures when access is attempted through Windows Integrated Authentication, as a result of Kerberos tickets not validating from one server to another.  
  
#### To set the SPN of the service account  
  
1.  Because the application pool identity for the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] AppPool is running as a domain user\/service account, you must configure the Service Principal Name \(SPN\) for that account in the domain with the Setspn.exe command\-line tool. Setspn.exe is installed by default on computers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Run the following command on a computer that is joined to the same domain where the user\/service account resides:  
  
    ```  
    setspn -a host/<server name> <service account>  
    ```  
  
    For example, in a scenario in which all [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s are clustered under the Domain Name System \(DNS\) host name fs.fabrikam.com and the service account name that is assigned to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] AppPool is named adfs2farm, type the command as follows, and then press ENTER:  
  
    ```  
    setspn -a host/fs.fabrikam.com adfs2farm  
    ```  
  
    It is necessary to complete this task only once for this account.  
  
2.  After the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] AppPool identity is changed to the service account, set the access control lists \(ACLs\) on the SQL Server database to allow Read access to this new account so that the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] AppPool can read the policy data.  
  
