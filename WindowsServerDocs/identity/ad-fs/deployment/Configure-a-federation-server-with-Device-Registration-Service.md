---
ms.assetid: fdd1c1fd-55aa-4eb8-ae84-53f811de042c
title: Configure a federation server with Device Registration Service
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Configure a federation server with Device Registration Service

You can enable Device Registration Service \(DRS\) on your federation server after you complete the procedures in [Step 4: Configure a Federation Server](https://technet.microsoft.com/library/dn303424.aspx). The Device Registration Service provides an onboarding mechanism for seamless second factor authentication, persistent single sign\-on \(SSO\), and conditional access to consumers that require access to company resources. For more information about DRS, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../../ad-fs/operations/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md)  
  
## Prepare your Active Directory forest to support devices  
  
> [!NOTE]  
> This is a one\-time operation that you must run to prepare your Active Directory forest to support devices. You must be logged on with enterprise administrator permissions and your Active Directory forest must have the Windows Server 2012 R2 schema to complete this procedure.  
>   
> Additionally, DRS requires that you have at least one global catalog server in your forest root domain. The global catalog server is required in order to run Initialize\-ADDeviceRegistration and during AD FS authentication. AD FS initializes an in\-memory representation of the DRS config object on each authentication request and if the DRS config object cannot be found on a DC in the current domain, the request is attempted against the GC on which the DRS objects were provisioned during Initialize\-ADDeviceRegistration.  
  
#### To prepare the Active Directory forest  
  
1.  On your federation server, open a Windows PowerShell command window and type:  
  
    ```  
    Initialize-ADDeviceRegistration  
    ```  
  
2.  When prompted for ServiceAccountName, enter the name of the service account you selected as the service account for AD FS.  If it is a gMSA account, enter the account in the **domain\\accountname$** format. For a domain account, use the format **domain\\accountname**.  
  
## Enable Device Registration Service on a federation server farm node  
  
> [!NOTE]  
> You must be logged on with domain administrator permissions to complete this procedure.  
  
#### To enable Device Registration Service  
  
1.  On your federation server, open a Windows PowerShell command window and type:  
  
    ```  
    Enable-AdfsDeviceRegistration  
    ```  
  
2.  Repeat this step on each federation farm node in your AD FS farm..  
  
## Enable seamless second factor authentication  
Seamless second factor authentication is an enhancement in AD FS that provides an added level of access protection to corporate resources and applications from external devices that are trying to access them. When a personal device is Workplace Joined, it becomes a ‘known' device and administrators can use this information to drive conditional access and gate access to resources.  
  
#### To enable seamless second factor authentication, persistent single sign\-on \(SSO\) and conditional access for Workplace Joined devices  
  
1.  In the AD FS Management console, navigate to Authentication Policies. Select Edit Global Primary Authentication. Select the check box next to Enable Device Authentication, and then click OK.  
  
## Update the Web Application Proxy configuration  
  
> [!IMPORTANT]  
> You do not need to publish the Device Registration Service to the Web Application Proxy.  The Device Registration Service will be available through the Web Application Proxy once it is enabled on a federation server.  You may need to complete this procedure to update the Web Application Proxy configuration if it was deployed prior to enabling the Device Registration Service.  
  
#### To update the Web Application Proxy Configuration  
  
1.  On your Web Application Proxy server, open a Windows PowerShell command window and type  
  
    ```  
    Update-WebApplicationProxyDeviceRegistration  
    ```  
  
2.  When prompted for credentials, enter the credentials of an account that has administrative rights to your federation servers.  
  
## See Also 

[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)  

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
 
[Deploying a Federation Server Farm](../../ad-fs/deployment/Deploying-a-Federation-Server-Farm.md)  
  

