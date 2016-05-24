---
title: Modify Security Policies in Default Domain Controllers Policy
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ab01022e-be44-4d86-ba2c-0c6746549932
author: Femila
---
# Modify Security Policies in Default Domain Controllers Policy
To increase security, domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] require \(by default\) that all client computers attempting to authenticate to them perform Server Message Block \(SMB\) packet signing and secure channel signing. If your production environment includes client computers that run platforms that do not support SMB packet signing \(for example, Microsoft Windows NT® 4.0 with Service Pack 2 \(SP2\)\) or if it includes client computers that run platforms that do not support secure channel signing \(for example, Windows NT 4.0 with Service Pack 3 \(SP3\)\), you might have to modify default security policies to ensure that client computers running older versions of the Windows operating system or non\-Microsoft operating systems will be able to access domain resources in the upgraded domain.  
  
> [!NOTE]  
> By modifying the settings of the default security policies, you are weakening the default security policies in your environment. Therefore, we recommend that you upgrade your Windows–based client computers as soon as possible. After all client computers in your environment are running versions of Windows that support SMB packet signing and secure channel signing, you can re\-enable default security policies to increase security.  
  
To configure a domain controller to not require SMB packet signing or secure channel signing, disable the following settings in the **Default Domain Controllers Policy**:  
  
-   **Microsoft network server: Digitally sign communications \(always\)**  
  
-   **Domain member: Digitally encrypt or sign secure channel data \(always\)**  
  
Back up the **Default Domain Controllers Policy** Group Policy object \(GPO\) before you modify it. Use the Group Policy Management Console \(GPMC\) to back up the GPO so that it can be restored, if necessary.  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To disable SMB packet signing enforcement based domain controllers  
  
1.  To open GPMC, click **Start**, click **Run**, type **gpmc.msc**, and then click **OK**.  
  
2.  In the console tree, right\-click **Default Domain Controllers Policy** in Domains\\*Current Domain Name*\\Group Policy objects\\Default Domain Controllers Policy, and then click **Edit**.  
  
3.  In the **Group Policy Management Editor** window, in the console tree, go to Computer Configuration\/Policies\/Windows Settings\/Security Settings\/Local Policies\/Security Options.  
  
4.  In the details pane, double\-click **Microsoft network server: Digitally sign communications \(always\)**.  
  
5.  Verify that the **Define this policy setting** check box is selected, click **Disabled** to prevent SMB packet signing from being required, and then click **OK**.  
  
    To apply the Group Policy change immediately, either restart the domain controller or open a command prompt, type the following command, and then press ENTER:  
  
    `gpupdate /force`  
  
    > [!NOTE]  
    > Modifying these settings in the **Domain Controllers** container will change the **Default Domain Controllers Policy**. Policy changes that you make here will be replicated to all other domain controllers in the domain. Therefore, you only have to modify these policies one time to affect the **Default Domain Controllers Policy** on all domain controllers.  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To disable secure channel signing enforcement on domain controllers  
  
1.  To open GPMC, click **Start**, click **Run**, type **gpmc.msc**, and then click **OK**.  
  
2.  In the console tree, right\-click **Default Domain Controllers Policy** in Domains\/*Current Domain Name*\/Group Policy objects\/Default Domain Controllers Policy, and then click **Edit**.  
  
3.  In the **Group Policy Management Editor** window, in the console tree, go to Computer Configuration\/Policies\/Windows Settings\/Security Settings\/Local Policies\/Security Options.  
  
4.  In the details pane, double\-click **Domain member: Digitally encrypt or sign secure channel data \(always\)**, click **Disabled** to prevent secure channel signing from being required, and then click **OK**.  
  
    To apply the Group Policy change immediately, either restart the domain controller or open a command prompt, type the following command, and then press ENTER:  
  
    `gpupdate /force`  
  
    > [!NOTE]  
    > Modifying these settings in the Domain Controllers container will change the **Default Domain Controllers Policy**. Policy changes that you make here will be replicated to all other domain controllers in the domain. Therefore, you only have to modify these policies one time to affect the **Default Domain Controllers Policy** on all domain controllers.  
  
For more information about SMB packet signing and secure channel signing, see [Appendix A: Background Information for Upgrading Active Directory Domains](../Topic/Appendix-A--Background-Information-for-Upgrading-Active-Directory-Domains.md).  
  
By default, domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] also prohibit clients running non\-Microsoft operating systems or Windows NT 4.0 operating systems to establish security channels using weak Windows NT 4.0–style cryptography algorithms. Any security\-channel\-dependent operation that is initiated by clients running older versions of the Windows operating system or running non\-Microsoft operating systems that do not support strong cryptographic algorithms will fail against a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] with default settings.  
  
Until you are able to upgrade all of the clients in your infrastructure, you can temporarily relax this requirement by modifying the following Default Domain Controllers Policy setting on domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. However, any operation that requires a secure channel between Windows NT 4 and Windows Server 2003 or later is not tested or supported. In addition, [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] will not create an outbound trust to a Windows NT 4 domain. For more information, see [article 942564](http://go.microsoft.com/fwlink/?LinkId=190578) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=190578\).  
  
-   **Allow cryptography algorithms compatible with Windows NT 4.0**  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To allow cryptography algorithms that are compatible with Windows NT 4.0  
  
1.  To open GPMC, click **Start**, click **Run**, type **gpmc.msc**, and then click **OK**.  
  
2.  In the console tree, right\-click **Default Domain Controllers Policy** in Domains\/*Current Domain Name*\/Group Policy objects\/Default Domain Controllers Policy, and then click **Edit**.  
  
3.  In the **Group Policy Management Editor** window, in the console tree, go to Computer Configuration\/Administrative Templates: Policy definitions \(ADMX files\) retrieved from the local machine\/System\/Net Logon.  
  
4.  In the details pane, double\-click **Allow cryptography algorithms compatible with Windows NT 4.0**, and then click **Enabled**.  
  
    > [!NOTE]  
    > By default, the **Not Configured** option is selected, but, programmatically, after you upgrade a domain controller to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], this policy is set to **Disabled**.  
  
    To apply the Group Policy change immediately, either restart the domain controller or open command line, type the following command, and then press ENTER:  
  
    `gpupdate /force`  
  
    > [!NOTE]  
    > Modifying these settings in the Domain Controllers container will change the **Default Domain Controllers Policy**. Policy changes that are made here will be replicated to all other domain controllers in the domain. Therefore, you only have to modify these policies one time to affect the **Default Domain Controllers Policy** on all domain controllers.  
  
For more information, see Effects of netlogon cryptographic support changes in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=106380](http://go.microsoft.com/fwlink/?LinkId=106380)\). For more information about additional security policy changes in Windows 7 and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Secure default settings in Windows Server 2008 and Windows Server 2008 R2](assetId:///255b83fa-5f20-455a-b6b0-bef198979268#BKMK_SecureDefault).  
  
## Change History  
  
|Date|Revision|  
|--------|------------|  
|August 24, 2010|Changed the statement that said any operation between Windows NT 4 and a DC that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] will not work to say it is not tested or supported.|  
  
