---
title: Walkthrough: Workplace Join with an iOS Device
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 2809e237-5782-4a90-84ff-c9e387f55270
author: Femila
---
# Walkthrough: Workplace Join with an iOS Device
This topic demonstrates Workplace Join on an iOS device. You must complete the steps in the [Set up the lab environment for AD FS in Windows Server 2012 R2](../Topic/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md) section before you can try out this walkthrough. You can use the device to access the same company web application that you accessed in [Walkthrough: Workplace Join with a Windows Device](../Topic/Walkthrough--Workplace-Join-with-a-Windows-Device.md).  
  
## Join an iOS device with Workplace Join  
  
> [!IMPORTANT]  
> When on\-premises DRS is configured, the iOS device must trust the Secure Socket Layer \(SSL\) certificate that was used to configure Active Directory Federation Services \(AD FS\) in [Step 2: Configure the federation server \(ADFS1\) with Device Registration Service](../Topic/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_4), for Workplace Join to succeed.  
>   
> -   If the AD FS SSL certificate was issued from a test certification authority \(CA\), you must install the certification authority certificate on your iOS device.  
> -   If your certification authority certificate is published on a website, you can browse to the website from your iOS device and install the certificate.  
  
In this demonstration, you join the device to the workplace.  
  
#### To join an iOS device to a workplace  
  
1.  -   **When Azure Active Directory Device Registration service is the configured DRS:**  
        Open Apple Safari and navigate to Azure Active Directory Device Registration service Over\-the\-Air Profile endpoint for iOS devices, <`https://enterpriseregisration.windows.net/enrollmentserver/otaprofile/<yourdomainname` >  
        Where <`yourdomainname`> is the domain name that you have configured with Azure Active Directory. For example, if your domain name is contoso.com, the URL would be: `https://enterpriseregisration.windows.net/enrollmentserver/otaprofile/contoso.com`  
  
    -   **When On\-premises DRS is the configured DRS**:   
        Open Apple Safari and navigate to the Device Registration Service \(DRS\) Over\-the\-Air Profile endpoint for iOS devices, `https://adf1s.contoso.com/enrollmentserver/otaprofile`  
  
    There are many ways to communicate this URL to your users. One recommended way is to publish this URL in a custom application access denied message in AD FS. This is covered in the upcoming section: [Create an application access policy and custom access denied message](http://msdn.microsoft.com/library/azure/dn788908.aspx)  
  
2.  Log on to the webpage by using a company domain account:  **roberth@contoso.com** and password: **P@ssword**.  
  
3.  You are prompted to install a profile. On the **Install Profile** screen, click **Install**.  
  
4.  When prompted to confirm installation of the profile, click **Install Now**.  
  
5.  If your device requires a PIN to unlock the device, you are prompted to enter your PIN.  
  
6.  The profile installation is finished when you see the **Profile Installed** screen. Click **Done**.  
  
    Return to Safari. A message informs you that you can close or leave Safari.  
  
> [!TIP]  
> To view or remove the Workplace Join profile, browse to **Settings**, click **General**, and then click **Profiles** on your iOS device.  
  
## See Also  
[Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../Topic/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md)  
[Set up the lab environment for AD FS in Windows Server 2012 R2](../Topic/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)  
[Walkthrough: Workplace Join with a Windows Device](../Topic/Walkthrough--Workplace-Join-with-a-Windows-Device.md)  
  
