---
title: STEP 2: Configure APP1_
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c1bb590f-91d4-4ed5-bceb-b0e36eabd4ff
author: vhorne
---
# STEP 2: Configure APP1_
Use the following steps to prepare APP1 for OTP support:  
  
1.  [To create and deploy a certificate template used to sign OTP certificate requests](../Topic/STEP-2--Configure-APP1_.md#DAOTPRA)—Configure a certificate template used to sign OTP certificate requests.  
  
2.  [To create and deploy a certificate template for OTP certificates issued by the corporate CA](../Topic/STEP-2--Configure-APP1_.md#DAOTPLogon)—Configure a certificate template for OTP certificates issued by the corporate CA.  
  
> [!WARNING]  
> The design of this test lab guide includes infrastructure servers, such as a domain controller and a certification authority \(CA\) that are running either [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] or [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. Using this test lab guide to configure infrastructure servers that are running other operating systems has not been tested, and instructions for configuring other operating systems are not included in this guide.  
  
## <a name="DAOTPRA"></a>To create and deploy a certificate template used to sign OTP certificate requests  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**certtmpl.msc**, and then press ENTER.  
  
2.  In the Certificate Templates Console, in the details pane, right\-click the **Computer** template, and click **Duplicate Template**.  
  
3.  On the **Properties of New Template** dialog box, on the **Compatibility** tab, in the **Certification Authority** list, click **Windows Server 2012**, and in the **Resulting changes** dialog box click **OK**. In the **Certificate recipient** list click **Windows 8\/ Windows Server 2012**, and in the **Resulting changes** dialog box click **OK**.  
  
4.  On the **Properties of New Template** dialog box, click the **General** tab.  
  
5.  On the **General** tab, in **Template display name**, type **DAOTPRA**. Set the **Validity period** to 2 days, and set the **Renewal Period** to 1 day. If the **Certificate Templates** warning is displayed, click **OK**.  
  
6.  Click the **Security** tab, and then click **Add**.  
  
7.  On the **Select Users, Computers, Service Accounts, or Groups** dialog box, click **Object Types**. On the **Object Types** dialog box, select **Computers**, and then click **OK**. In the **Enter the object names to select** box, type **EDGE1**, click **OK**, and in the **Allow** column, select the **Read**, **Enroll**, and **Autoenroll** check boxes. Click **Authenticated Users**, select the **Read** check box under the **Allow** column, and clear all other check boxes. Click **Domain Computers**, and uncheck **Enroll** under the **Allow** column. Click **Domain Admins** and **Enterprise Admins** and click **Full Control** under the **Allow** column for both. Click **Apply**.  
  
8.  Click the **Subject Name** tab, and then click **Build from this Active Directory information**. In the **Subject name format:** list select **DNS name**, make sure that the **DNS name** box is checked, and click **Apply**.  
  
9. Click the **Extensions** tab, select **Application Policies** and then click **Edit**. Remove all existing application policies. Click **Add**, and on the **Add Application Policy** dialog box, click **New**, enter **DA OTP RA** in the **Name:** field and **1.3.6.1.4.1.311.81.1.1** in the **Object identifier:** field, and click **OK**. On the **Add Application Policy** dialog box, click **OK**. On the **Edit Application Policies Extension**, click **OK**. On the **Properties of New Template** dialog box, click **OK**.  
  
## <a name="DAOTPLogon"></a>To create and deploy a certificate template for OTP certificates issued by the corporate CA  
  
1.  In the Certificate Templates Console, in the details pane, right\-click the **Smartcard Logon** template, and click **Duplicate Template**.  
  
2.  On the **Properties of New Template** dialog box, on the **Compatibility** tab in the **Certification Authority** list, click **Windows Server 2012**, and in the **Resulting changes** dialog box, click **OK**. In the **Certificate recipient** list click **Windows 8\/ Windows Server 2012**, and in the **Resulting changes** dialog box click **OK**.  
  
3.  On the **Properties of New Template** dialog box, click the **General** tab.  
  
4.  On the **General** tab, in **Template display name**, type **DAOTPLogon**. In **Validity period**, in the drop\-down list, click **hours**, on the **Certificate Templates** dialog box, click **OK**, and make sure that the number of hours is set to 1. In **Renewal period**, type **0**.  
  
    > [!IMPORTANT]  
    > **Windows Server 2003 CA**. In situations where the certification authority \(CA\) is on a computer that is running Windows Server 2003, then the certificate template must be configured on a different computer. This is required because setting the **Validity period** in hours is not possible when running Windows versions prior to [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] and [!INCLUDE[firstref_vista](../Token/firstref_vista_md.md)]. If the computer that you use to configure the template does not have the Active Directory Certificate Services server role installed, or if it is a client computer, then you may need to install the Certificate Templates snap\-in. For more information, see [Install the Certificate Templates Snap\-In](http://technet.microsoft.com/library/cc732445.aspx).  
    >   
    > **Windows Server 2008 R2 CA**. If you have already deployed a certification authority \(CA\) that is running [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], you must configure the certificate template **Renewal Period** to 1 or 2 hours, and the **Validity Period** to be longer than the **Renewal Period**, but not more than 4 hours. If you configure a certificate template **Validity Period** of longer than 4 hours with a CA that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the DirectAccess installation wizard cannot detect the certificate template, and DirectAccess installation fails.  
  
5.  Click the **Security** tab, select **Authenticated Users**, in the **Allow** column, and select the **Read** and **Enroll** check boxes. Click **OK**. Click **Domain Admins** and **Enterprise Admins**, and click **Full Control** under the **Allow** column for both. Click **Apply**.  
  
6.  Click the **Subject Name** tab, and then click **Build from this Active Directory information**. In the **Subject name format:** list select **Fully distinguished name**, make sure that the **User principal name \(UPN\)** box is checked, and click **Apply**.  
  
7.  Click the **Server** tab, select the **Do not store certificates and requests in the CA database** check box, clear the **Do not include revocation information in issued certificates** check box, and then on the **Properties of New Template** dialog box,  click **Apply**.  
  
8.  Click the **Issuance Requirements** tab, select the **This number of authorized signatures:** check box, set the value to 1. In the **Policy type required in signature:** list select **Application policy**, and in the **Application policy** list select **DA OTP RA**. On the **Properties of New Template** dialog box, click **OK**.  
  
9. Click the **Extensions** tab, and on **Application Policies** click **Edit**. Delete **Client Authentication**, keep **SmartCardLogon**, and click **OK** twice.  
  
10. Close the Certificate Templates Console.  
  
11. [!INCLUDE[clickstart](../Token/clickstart_md.md)]**certsrv.msc**, and then press ENTER.  
  
12. In the Certification Authority console tree, expand **corp\-APP1\-CA\-1**, click **Certificate Templates**, right\-click **Certificate Templates**, point to **New**, and click **Certificate Template to Issue**.  
  
13. In the list of certificate templates, click **DAOTPRA** and **DAOTPLogon**, and click **OK**.  
  
14. In the details pane of the console you should see the **DAOTPRA** certificate template with an **Intended purpose** of **DA OTP RA** and the **DAOTPLogon** certificate template with an **Intended Purpose** of **Smart Card Logon**.  
  
15. Restart the services.  
  
16. Close the Certification Authority console.  
  
17. Open an elevated command prompt. Type **CertUtil.exe –SetReg DBFlags \+DBFLAGS\_ENABLEVOLATILEREQUESTS**, and press ENTER.  
  
18. Leave the Command Prompt window open for the next step.  
  
