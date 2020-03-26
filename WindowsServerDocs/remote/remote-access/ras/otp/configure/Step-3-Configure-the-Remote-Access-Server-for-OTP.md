---
title: Step 3 Configure the Remote Access Server for OTP
description: This topic is part of the guide Deploy Remote Access with OTP Authentication in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df1e87f2-6a0f-433b-8e42-816ae75395f9
ms.author: lizross
author: eross-msft
---
# Step 3 Configure the Remote Access Server for OTP

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Once the RADIUS server has been configured with software distribution tokens, communication ports are open, a shared secret has been created, user accounts corresponding to Active Directory have been created on the RADIUS server, and the Remote Access server has been configured as a RADIUS authentication agent, then the Remote Access server needs to be configured to support OTP.  
  
|Task|Description|  
|----|--------|  
|[3.1 Exempt users from OTP authentication (optional)](#BKMK_Exempt)|If specific users will be exempted from DirectAccess with OTP authentication, then follow these preliminary steps.|  
|[3.2 Configure the Remote Access server to support OTP](#BKMK_Config)|On the Remote Access server update the Remote Access configuration to support OTP two-factor authentication.|  
|[3.3 Smart cards for additional authorization](#BKMK_Smartcard)|Additional information regarding the use of smart cards.|  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="BKMK_Exempt"></a>3.1 Exempt users from OTP authentication (optional)  
If specific users are to be exempted from OTP authentication, then these steps must be taken prior to the Remote Access configuration:  
  
> [!NOTE]  
> You must wait for replication between domains to complete when configuring the OTP exemption group.  
  
#### Create user exemption security group  
  
1.  Create a security group in Active Directory for the purpose OTP exemption.  
  
2.  Add all users to be exempted from OTP authentication to the security group.  
  
    > [!NOTE]  
    > Make sure to include only user accounts, and not computer accounts, in the OTP exemption security group.  
  
## <a name="BKMK_Config"></a>3.2 Configure the Remote Access server to support OTP  
To configure Remote Access to use two-factor authentication and OTP with the RADIUS server and certificate deployment from the previous sections, use the following steps:  
  
#### Configure Remote Access for OTP  
  
1.  Open **Remote Access Management** and click **Configuration**.  
  
2.  In the **DirectAccess Setup** window, under **Step 2 - Remote Access Server**, click **Edit**.  
  
3.  Click **Next** three times, and in the **Authentication** section select both **Two factor authentication** and **Use OTP**, and ensure that **Use computer certificates** is checked.  
  
    > [!NOTE]  
    > After OTP has been enabled on the Remote Access server, if you disable OTP by deselecting **Use OTP**, the ISAPI and CGI extensions will be uninstalled on the server.  
  
4.  If Windows 7 support is required, select the **Enable Windows 7 client computers to connect via DirectAccess** check box. Note: As discussed in the planning section, Windows 7 clients must have DCA 2.0 installed to support DirectAccess with OTP.  
  
5.  Click **Next**.  
  
6.  In the **OTP RADIUS Server** section, double-click the blank **Server Name** field.  
  
7.  In the **Add a RADIUS Server** dialog, type the name of the RADIUS server in the **Server name** field. Click **Change** next to the **Shared secret** field, and type the same password that you used when configuring the RADIUS server in the **New secret** and **Confirm new secret** fields. Click **OK** twice, and click **Next**.  
  
    > [!NOTE]  
    > If the RADIUS server is in a domain that is different than the Remote Access server, then the **Server Name** field must specify the FQDN of the RADIUS server.  
  
8.  In the **OTP CA Servers** section select the CA servers to be used for the enrollment of OTP client authentication certificates, and click **Add**. Click **Next**.  
  
9. In the **OTP Certificate Templates** section click **Browse** to select the certificate template used for the enrollment of certificates that are issued for OTP authentication.  
  
    > [!NOTE]  
    > The certificate template for OTP certificates issued by the corporate CA must be configured without the "Do not include revocation information in issued certificates" option. If this option is selected during the certificate template creation, then OTP client computers will fail to logon properly.  
  
    Click **Browse** to select a certificate template used to enroll the certificate used by the Remote Access server to sign OTP certificate enrollment requests. Click **OK**. Click **Next**.  
  
10. If exempting specific users from DirectAccess with OTP is required, then in the **OTP Exemptions** section select **Do not require users in the specified security group to authenticate using two-factor authentication**. Click **Security Group** and select the security group that was created for OTP exemptions.  
  
11. On the **Remote Access Server Setup** page click **Finish**.  
  
12. In the **DirectAccess Setup** window, under **Step 3 - Infrastructure Servers**, click **Edit**.  
  
13. Click **Next** two times, and in the **Management** section double-click the **Management Servers** field.  
  
14. Enter the **Computer name** or **Address** of the CA server that is configured to issue OTP certificates, and click **OK**.  
  
15. In the **Remote Access Setup** windows click **Finish**.  
  
16. Click **Finish** on the **DirectAccess Expert Wizard**.  
  
17. On the **Remote Access Review** dialog box click **Apply**, wait for the DirectAccess policy to be updated, and click **Close**.  
  
18. On the **Start** screen, type**powershell.exe**, right-click **powershell**, click **Advanced**, and click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
19. In the Windows PowerShell window, type **gpupdate /force** and press ENTER.  
  
To configure Remote Access for OTP using PowerShell commands:  
  
![Windows PowerShell](../../../../media/Step-3-Configure-the-Remote-Access-Server-for-OTP/PowerShellLogoSmall.gif)**Windows PowerShell equivalent commands**  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
To configure Remote Access to use two-factor authentication on a deployment that currently uses computer certificate authentication:  
  
```  
Set-DAServer -UserAuthentication TwoFactor  
```  
  
To configure Remote Access to use OTP authentication using the following settings:  
  
-   An OTP server named OTP.corp.contoso.com.  
  
-   A CA server named APP1.corp.contoso.com\corp-APP1-CA1.  
  
-   A certificate template named DAOTPLogon used for the enrollment of certificates that are issued for OTP authentication.  
  
-   A certificate template named DAOTPRA used to enroll the Registration Authority certificate used by the Remote Access server to sign OTP certificate enrollment requests.  
  
```  
Enable-DAOtpAuthentication -CertificateTemplateName 'DAOTPLogon' -SigningCertificateTemplateName 'DAOTPRA' -CAServer @('APP1.corp.contoso.com\corp-APP1-CA1') -RadiusServer OTP.corp.contoso.com -SharedSecret Abcd123$  
```  
  
After executing the PowerShell commands complete steps 12-19 from the previous procedure to configure the Remote Access server to support OTP.  
  
> [!NOTE]  
> Make sure to verify that you have applied the OTP settings on the Remote Access server before you add an entry point.  
  
## <a name="BKMK_Smartcard"></a>3.3 Smart cards for additional authorization  
On the Authentication page of Step 2 in the Remote Access Setup Wizard, you can require the use of smart cards for access to the internal network. When this option is selected, the Remote Access Setup Wizard configures the IPsec connection security rule for the intranet tunnel on the DirectAccess server to require tunnel mode authorization with smart cards. Tunnel mode authorization allows you to specify that only authorized computers or users can establish an inbound tunnel.  
  
To use smart cards with IPsec tunnel mode authorization for the intranet tunnel, you must deploy a public key infrastructure (PKI) with smart cards infrastructure.  
  
Because your DirectAccess clients are using smart cards for access to the intranet, you can also use authentication mechanism assurance, a feature of Windows Server 2008 R2, to control access to resources, such as files, folders, and printers, based on whether the user logged on with a smart card-based certificate. Authentication mechanism assurance requires a domain functional level of Windows Server 2008 R2.  
  
### Allowing access for users with unusable smart cards  
To allow temporary access for users with smart cards that are unusable, do the following:  
  
1.  Create an Active Directory security group to contain the user accounts of users who temporarily cannot use their smart cards.  
  
2.  For the DirectAccess server Group Policy Object, configure global IPsec settings for IPsec tunnel authorization and add the Active Directory security group to the list of authorized users.  
  
To grant access to a user that cannot use their smart card, temporarily add their user account to the Active Directory security group. Remove the user account from the group when the smart card is usable.  
  
### Under the covers: Smart card authorization  
Smart card authorization works by enabling tunnel mode authorization on the intranet tunnel connection security rule of the DirectAccess server for a specific Kerberos-based security identifier (SID). For smart card authorization, this is the well-known SID (S-1-5-65-1), which maps to smart card-based logons. This SID is present in a DirectAccess client's Kerberos token and is referred to as "This Organization Certificate" when configured in the global IPsec tunnel mode authorization settings.  
  
When you enable smart card authorization in Step 2 of the DirectAccess Setup Wizard, the DirectAccess Setup Wizard configures the global IPsec tunnel mode authorization setting with this SID for the DirectAccess server Group Policy Object. To view this configuration in the Windows Firewall with Advanced Security snap-in for the DirectAccess server Group Policy Object, do the following:  
  
1.  Right click Windows Firewall with Advanced Security, and then click Properties.  
  
2.  On the IPsec Settings tab, in IPsec tunnel authorization, click Customize.  
  
3.  Click the Users tab. You should see the "NT AUTHORITY\This Organization Certificate" as an authorized user.  
  


