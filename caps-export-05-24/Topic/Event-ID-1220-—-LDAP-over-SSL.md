---
title: Event ID 1220 — LDAP over SSL
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 73b234a1-0665-4a56-99a9-7d447fed9218
author: Femila
---
# Event ID 1220 — LDAP over SSL
Lightweight Directory Access Protocol \(LDAP\) communications between client computers and server computers can be encrypted with LDAP over Secure Sockets Layer \(SSL\) connections. You can configure Active Directory Domain Services \(AD DS\) and Active Directory Lightweight Directory Services \(AD LDS\) to support LDAP over SSL.  
  
> [!IMPORTANT]  
> More detailed and recently updated information regarding this warning and how to resolve it have been published to the following TechNet Wiki articles:  
>   
> -   [LDAP over SSL \(LDAPS\) Certificate](http://social.technet.microsoft.com/wiki/contents/articles/2980.aspx) \(http:\/\/social.technet.microsoft.com\/wiki\/contents\/articles\/2980.aspx\)  
> -   [Event ID 1220 — LDAP over SSL \(LDAPS\)](http://social.technet.microsoft.com/wiki/contents/articles/2979.aspx) \(http:\/\/social.technet.microsoft.com\/wiki\/contents\/articles\/2979.aspx\)  
  
Event Details  
  
|||  
|-|-|  
|Product|Windows Operating System|  
|ID|1220|  
|Source|Windows Server® 2003 and Windows Server® 2003 R2: Active Directory<br /><br />Windows Server® 2008 and Windows Server® 2008 R2: Microsoft\-Windows\-ActiveDirectory\_DomainService|  
|Version|5.0 and 6.0|  
|Symbolic Name|DIRLOG\_LDAP\_SSL\_NO\_CERT|  
|Message|LDAP over Secure Sockets Layer \(SSL\) will be unavailable at this time because the server was unable to obtain a certificate.|  
  
## Resolve  
Event ID 1220 is logged on a domain controller when client computers attempt to make an LDAP\-over\-SSL connection to the directory when SSL connections are not enabled on the directory. If you want to configure a domain controller or an AD LDS server to support SSL connections, you must provide a certificate for the AD DS or AD LDS directory to use. If you do not want to support LDAP over SSL connections on the directory, identify the client computers that are attempting to make such connections so that you can resolve this issue.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. Perform the following procedure on a domain controller or a computer that has RSAT installed. See Installing Remote Server Administration Tools for AD DS \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=144909\).  
  
If you want to configure your domain controllers to support SSL connections, you can install and configure the Active Directory Certificate Services \(AD CS\) role on a domain controller or you can import a certificate from a trusted certification authority \(CA\).  
  
> [!WARNING]  
> In most cases, you should **not** install a CA on a domain controller. For additional information, see [PKI Design Brief Overview](http://social.technet.microsoft.com/wiki/contents/articles/pki-design-brief-overview.aspx) \(http:\/\/social.technet.microsoft.com\/wiki\/contents\/articles\/pki\-design\-brief\-overview.aspx\).  
  
If you want to configure your domain controllers to support SSL connections, you can install and configure the Active Directory Certificate Services \(AD CS\) role on a domain controller or you can import a certificate from a trusted certification authority \(CA\). If you install the AD CS role and specify the **Setup Type** as **Enterprise** on a domain controller, all domain controllers in the forest will be configured automatically to accept LDAP over SSL. For instructions about installing and configuring a local certificate server using a Windows Server 2008 computer, see the [Active Directory Certificate Services Step\-by\-Step Guide](http://go.microsoft.com/?linkid=9645085) \(http:\/\/go.microsoft.com\/?linkid\=9645085\).  
  
In most cases you should use a certificate from a CA that is not installed on a domain controller. The certificate that you import into the LDAP server \[e.g. domain controller or Active Directory Application Mode, or Active Directory Lightweight Directory Services \(AD LDS\)\] must meet the following specifications:  
  
1.  Certificate must be valid for the purpose of Server Authentication. This means that it must also contains the Server Authentication object identifier \(OID\): 1.3.6.1.5.5.7.3.1  
  
2.  The Subject name or the first name in the Subject Alternative Name \(SAN\) must match the Fully Qualified Domain Name \(FQDN\) of the host machine, such as Subject:CN\=server1.contoso.com. For more information, see [How to add a Subject Alternative Name to a secure LDAP certificate](http://support.microsoft.com/kb/931351) \(http:\/\/support.microsoft.com\/kb\/931351\).  
  
3.  The host machine account must have access to the private key.  
  
If you are preparing a Windows Server 2008 or Windows Server 2008 R2 domain controller to accept LDAP over SSL \(LDAPS\) connections you should import the certificate into the AD DS personal store \(as shown in the following procedure\). If you are working on a Windows Server 2003 or Windows Server 2003 R2 computer, you should import the certificate into as described in [Configure Authentication and Encryption](http://technet.microsoft.com/library/cc757003.aspx) \(http:\/\/technet.microsoft.com\/library\/cc757003.aspx\). If you are working on an AD LDS server, then you should following the instructions in [Appendix A: Configuring LDAP over SSL Requirements for AD LDS.](-http-//go.microsoft.com/-linkid=9645086-) \(\(http:\/\/go.microsoft.com\/?linkid\=9645086\)  
  
#### To import a certificate into the AD DS personal store  
  
1.  Open a command prompt as an administrator. To open a command prompt as an administrator, click **Start**. In **Start Search**, type **Command Prompt**. At the top of the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. [!INCLUDE[uac_appears_7](../Token/uac_appears_7_md.md)]  
  
2.  To open Microsoft Management Console \(MMC\), type **mmc**, and then press ENTER.  
  
3.  Click **File**, click **Add\/Remove Snap\-in**, select **Certificates** from the available snap\-ins, and then click **Add**.  
  
4.  In **Add or Remove Snap\-ins**, click **Service account** to view the certificates that are stored in the service's personal store, and then click **Next**.  
  
5.  In **Add or Remove Snap\-ins**, click **Local computer**, and then click **Next**.  
  
6.  In **Add or Remove Snap\-ins**, click **Active Directory Domain Services**, click **Finish**, and then click **OK**.  
  
7.  In the console tree, expand **Certificates \- Service \(Active Directory Domain Services\)**, expand **Personal**, and then expand **Certificates**.  
  
8.  To import a certificate, right\-click the NTDS\\Personal folder, click All Tasks, and then click Import. When the certificate is imported, client computers should be able to make SSL connections to all domain controllers in the forest.  
  
> [!NOTE]  
> If you are working on a Windows Server 2003 or Windows Server 2003 R2 computer, you should import the certificate into as described in [Configure Authentication and Encryption](http://technet.microsoft.com/library/cc757003.aspx) \(http:\/\/technet.microsoft.com\/library\/cc757003.aspx\). If you are working on an AD LDS server, then you should following the instructions in [Appendix A: Configuring LDAP over SSL Requirements for AD LDS.](-http-//go.microsoft.com/-linkid=9645086-) \(http:\/\/go.microsoft.com\/?linkid\=9645086\)  
  
> [!NOTE]  
> The community version of this topic is on the TechNet Wiki as [Event ID 1220 — LDAP over SSL \(LDAPS\)](http://social.technet.microsoft.com/wiki/contents/articles/2979.aspx) \(http:\/\/social.technet.microsoft.com\/wiki\/contents\/articles\/2979.aspx\)  
  
## Verify  
Membership in Domain Users, or equivalent, is the minimum required to complete this procedure. Learn more about [default group memberships](http://go.microsoft.com/fwlink/?LinkID=150761) online \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=150761\). Perform the following procedure on a domain controller or a computer that has Remote Server Administration Tools \(RSAT\) installed. For more information about RSAT, see Installing Remote Server Administration Tools for AD DS \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=144909\).  
  
#### To confirm that LDAP over SSL is configured successfully  
  
1.  Open the Ldp snap\-in. To open Ldp, click **Start**. In **Start Search**, type **ldp**. Right\-click the **Ldp** icon on the **Start** menu, and then click **Run as administrator**. [!INCLUDE[uac_appears_7](../Token/uac_appears_7_md.md)]  
  
2.  Click the Ldp **Connection** menu, and then click **Connect**. In **Server**, type the host name of the server to which you want to connect. Ensure that Port is set to 636, the Connectionless check box is cleared, and the SSL check box is selected, and then click **OK**. If you receive a message that says “Cannot open connection,” LDAP\-over\-SSL binding is not configured properly.  
  
3.  Click the **Connection** menu, click **Bind**, and then click **OK**.  
  
4.  The command output should display the user name and domain name that you used for binding, if LDAP over SSL is configured properly.  
  
> [!TIP]  
> To install LDP on computers running Windows Server® 2003 or Windows® XP operating systems, install Windows Server 2003 Support Tools from the Windows Server 2003 product CD or from the [Microsoft Download Center](http://go.microsoft.com/fwlink/?LinkId=100114) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=100114\). For more information about how to install Windows Support Tools from the product CD, see Install Windows Support Tools \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=62270\).  
  
## See Also  
[Request a computer certificate for server authentication](http://technet.microsoft.com/library/cc740173.aspx)  
[Article 321051 in the Microsoft Knowledge Base](http://go.microsoft.com/fwlink/?LinkID=15129)  
[Certificates How To](http://go.microsoft.com/fwlink/?LinkId=99765)  
[Certificate Services](http://go.microsoft.com/fwlink/?LinkID=48952)  
[To post technical questions visit the Directory Services forum](http://social.technet.microsoft.com/Forums/winserverDS/threads)  
  
