---
ms.assetid: c17d143b-86b4-47c0-b76e-1862dda8f0bd
title: Walkthrough - Workplace Join with a Windows Device
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Walkthrough: Workplace Join with a Windows Device

This topic demonstrates how to use Workplace Join to connect your Windows device with your workplace and how to access a web application by using Single Sign-On. You must complete the steps in the [Set up the lab environment for AD FS in Windows Server 2012 R2](../deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md) section before you can try out this walkthrough.

## Access the web application before device registration
In this walkthrough, you access a company web application before you join your device to the workplace. The webpage displays the claims that were included in your security token. Notice that the list of claims does not include any information about your device. You might also observe that you do not have Single Sign-On.

#### To access the web application before you use Workplace Join on your device

1. Log on to Client1 with your Microsoft account.

2. Open Internet Explorer and browse to your generic claims app, **https://webserv1.contoso.com/claimapp**.

3. Log on to the webpage by using a company domain account: <strong>roberth@contoso.com</strong>, password: <strong>P@ssword</strong>.

4. The webpage lists all the claims in your security token. Only user claims are present in your security token.

5. Close Internet Explorer.

6. Open Internet Explorer and navigate to the same claims app, **https://webserv1.contoso.com/claimapp**.

7. Notice that you are prompted to enter your credentials again. You are not connected to the workplace from a device with Workplace Join and therefore do not have Single Sign-On.

## Join your device with Workplace Join

> [!IMPORTANT]
> For Workplace Join to succeed, the client computer (Client1) must trust the SSL certificate that was used to configure Active Directory Federation Services (AD FS) in [Step 2: Configure the Federation Server with Device Registration Service (ADFS1)](../deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_4). It must also be able to validate revocation information for the certificate. If you have any issues with Workplace Join, you can view the event log on Client1.
> 
> To see the event log, open Event Viewer, expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, and then click **Workplace Join**.

#### To join your device with Workplace Join

1. Log on to Client1 with your Microsoft account.

2. On the **Start** screen, open the **Charms** bar, and then select the **Settings** charm. Select **Change PC Settings**.

3. On the **PC Settings** page, select **Network**, and then click **Workplace**.

4. In the **Enter your UserID to get workplace access or turn on device management** box, type <strong>roberth@contoso.com</strong>, and then click **Join**.

5. When you are prompted for credentials, type <strong>roberth@contoso.com</strong>, and password: <strong>P@ssword</strong>. Click **OK**.

6. You should now see the message: "This device has joined your workplace network."

### Access the web application after joining the workplace
In this part of the demonstration, you access a company web application from your device that is connected with Workplace Join. The webpage displays the claims that were included in your security token. Notice that the list of claims includes both device and user information. You might also observe that you now have Single Sign-On.

##### To access the web application after joining the workplace

1. Log on to **Client1** with your Microsoft account.

2. Open Internet Explorer and browse to your generic claims app, **https://webserv1.contoso.com/claimapp**.

3. Log on to the webpage by using a company domain account: <strong>roberth@contoso.com</strong>, password: <strong>P@ssword</strong>.

4. The webpage lists claims in your security token. Your token contains both user and device claims.

5. Close Internet Explorer.

6. Open Internet Explorer and navigate to the same claims app, **https://webserv1.contoso.com/claimapp**.

7. Notice that you are **not** prompted to enter your credentials again. You are connected from a device with Workplace Join and therefore have Single Sign-On.

## See Also
[Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md)
[Set up the lab environment for AD FS in Windows Server 2012 R2](../deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)
[Walkthrough: Workplace Join with an iOS Device](Walkthrough--Workplace-Join-with-an-iOS-Device.md)



