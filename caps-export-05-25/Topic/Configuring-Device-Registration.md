---
title: Configuring Device Registration
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 30517394-edcf-42a8-a706-d54b461e2f4a
author: Femila
---
# Configuring Device Registration
The following section describes the available administrative settings for Device Registration.  You can view the current Device Registration settings using the following Windows PowerShell command:  
  
```  
Get-AdfsDeviceRegistration  
```  
  
> [!NOTE]  
> Any domain user can view the Device Registration configuration.  You must be logged on with enterprise administrator permissions in order to set Device Registration settings  
  
## Configure Device Registration Service Discovery  
The following sections describe how to configure Device Registration so that it can be discovered by Workplace Join client devices.  
  
### Discover Device Registration using a well\-known DNS CNAME \(alias\)  
Workplace Join client devices will attempt to discover the Device Registration Server by combining the user account name with a well\-known Device Registration server name.  
  
You must create a DNS CNAME record that points to the A record associated with your AD FS farm.  The CNAME record must use the well\-known prefix **EnterpriseRegistration** followed by the UPN suffix used by the user accounts at your organization.  If your organization uses multiple UPN suffixes, multiple CNAME records must be created in DNS.  
  
For Example, if the name of your AD FS farm is **adfs.contoso.com** and you use two UPN suffixes at your organization named **@contoso.com** and **@region.contoso.com**, you will create the following DNS records.  
  
|DNS Record|Record Type|Value|  
|--------------|---------------|---------|  
|adfs.contoso.com|A|< IP Address>|  
|enterpriseregistration.contoso.com|CNAME|adfs.contoso.com|  
|enterpriseregistration.region.contoso.com|CNAME|adfs.conotso.com|  
  
### Configure Device Registration Discovery Server SSL certificate  
for the Workplace Join client to discover the Device Registration server using a well\-known DNS CNAME record, AD FS must be configured with a server SSL certificate that includes the well\-known Device Registration server names.  You must include one server name for every userPrincipalName \(UPN\) suffix in use at your company in the format of:  
  
```  
enterpriseregistration.<upnsuffix>  
```  
  
For example, if your company’s UPN suffix is @contoso.com, then your AD FS server SSL certificate must contain enterpriseregistration.contoso.com  
  
If your company uses multiple UPN suffixes, then your AD FS server SSL certificate must contain an entry for each UPN suffix.  
  
You can satisfy this requirement in two ways.  You can use a wildcard certificate that covers all of the possible names used at your company or you can add the additional names as subject alternative names.  
  
**Example: Using a wildcard certificate**  
  
Subject \= \*.contoso.com  
  
**Example: Using subject alternative names**  
  
Subject \= adfs.contoso.com \(This is your AD FS farm name\)  
  
Subject Alternative Name \(DNS\) \= adfs.contoso.com  
  
Subject Alternative Name \(DNS\) \= enterpriseregistration.contoso.com  
  
Subject Alternative Name \(DNS\) \= enterpriseregistration.region.contoso.com  
  
##### To configure device registration service to allow DRS discovery  
  
1.  You have to obtain a new server SSL certificate that meets the requirements outlined in the previous section.  
  
    1.  Obtain a server SSL certificate that meets the requirements as outlined in the previous section.  
  
    2.  On your federation server, import the certificate to the local machine **Personal store**.  
  
    3.  On your federation server, issue the following Windows PowerShell command:  
  
        ```  
        Set-AdfsSslCertificate -Thumbprint thumbprint  
        ```  
  
        Where **thumbprint** is the thumbprint of the certificate that was installed in the previous step.  
  
2.  Next, you must update the UPN suffix list supported by the Device Registration Service \(DRS\) using the following command.  This command will detect the UPNs associated with Active Directory forests and domains and configure AD FS to listen  
  
    ```  
    Set-AdfsDeviceRegistrationUpnSuffix  
    ```  
  
    You can view the UPNs that were detected using the following command:  
  
    ```  
    Get-AdfsDeviceRegistrationUpnSuffix  
    ```  
  
3.  You must repeat steps 1 and 2 on each federation server in you AD FS farm.  
  
4.  If you are using the Web Application Proxy, you must update the configuration.  
  
    1.  On your Web Application Proxy server, open a Windows PowerShell command window and type:  
  
        ```  
        Update-WebApplicationProxyDeviceRegistration  
        ```  
  
    2.  When prompted for credentials, enter the credentials of an account that has administrative rights to your federation servers.  
  
## Configure unused device cleanup  
Unused devices will be automatically removed from Active Directory.  By default, devices that are not used for 90 days are removed.  You can configure the number of days using the following Windows PowerShell command:  
  
```  
Set-AdfsDeviceRegistration -MaximumInactiveDays days  
```  
  
Where *days* is the number of days that a device can be inactive before removing it from Active Directory.  
  
The valid range for the number of days is 0\-1000.  
  
Setting the number of days to zero will disable the unused device clean up task.  That is, unused devices will not be automatically removed from Active Directory.  
  
## Configure device quota  
Administrators can limit the number of devices that a given user is allowed to workplace join.  Once a user reaches their device quota, they will not be allowed to join new devices until one or more of their existing devices is removed.  
  
The default policy is 10 devices per user.  This policy can be managed using Windows PowerShell:  
  
```  
Set-AdfsDeviceRegistration -DevicesPerUser numberOfDevices  
```  
  
Where *numberOfDevices* is the number of devices allowed, per user.  
  
By default, Domain Admins are exempt from this policy.  This includes Domain Admins from any domain or trusted domain.  
  
## Adding an additional AD FS\/DRS farm to an existing Active Directory forest  
Device Registration and device object storage is maintained at the Active Directory forest level.  All AD FS\/DRS farms in a given Active Directory forest will use the same Device Registration configuration and device object container.  
  
To add an additional AD FS\/DRS farm to an existing Active Directory forest you must grant the proper rights to the service account that will be used with the new AD FS farm. You can use the following Windows PowerShell command to grant the needed rights to the service account.  
  
> [!NOTE]  
> You must be logged on with enterprise administrator permissions in order to set Device Registration settings.  
>   
> **Set\-AdfsDeviceRegistration \-ServiceAccountIdentifier serviceAccount**  
>   
> Where **serviceAccount** is the service account name used by AD FS.  If it is a gMSA account, enter the account in the **domain\\accountname$** format. For a domain account, use the format **domain\\accountname**.  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
  
