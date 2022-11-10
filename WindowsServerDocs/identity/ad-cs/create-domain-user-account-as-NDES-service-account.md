---
title: How to configure Network Device Enrollment Service for Active Directory Certificate Services
description: Learn how to configure a service account for the Network Device Enrollment Service (NDES) and how it works with certificates based on Simple Certificate Enrollment Protocol (SCEP)
author: gswashington
ms.author: robinharwood
ms.topic: overview
ms.date: 11/09/2022
=======
# How to configure Network Device Enrollment Service for Active Directory Certificate Services

Applies To: Windows Server (All supported versions)

The Network Device Enrollment Service (NDES) allows software on routers and other network devices running without domain credentials to obtain certificates based on the Simple Certificate Enrollment Protocol (SCEP).

> [!NOTE]
> SCEP was developed to support the secure, scalable issuance of certificates to network devices by using existing certification authorities (CAs). The protocol supports CA and registration authority public key distribution, certificate enrollment, certificate revocation, certificate queries, and certificate revocation queries.

The Network Device Enrollment Service performs the following functions:

1. Generates and provides one-time enrollment passwords to administrators

2. Submits enrollment requests to the CA

3. Retrieves enrolled certificates from the CA and forwards them to the network device

## NDES configuration settings

The following sections describe the configuration options that you can select after installing the NDES binary installation files.

### Configure a service account for NDES

NDES can be configured to run as either of the following:

- A user account that is specified as a service account

- The built-in application pool identity of the Internet Information Services (IIS) computer

If you select the built-in application pool identity, there is no additional configuration required. However, the recommended configuration is to specify a user account, which requires additional configuration. The user account that is specified as the NDES service account must meet the following requirements:

- Be a domain user account

- Be a member of the local IIS\_IUSRS group

   Have Request permissions on the configured CA

- Have Read and Enroll permissions on the NDES certificate template, which is configured automatically

In addition to these requirements, it may be necessary to have a service principal name (SPN) set in Active Directory. The following guidance is intended to help you determine whether it is necessary to set an SPN in Active Directory.

- If you are using a single NDES server and its actual hostname (most common scenario), the account does not need an SPN registered. The computer account's default SPNs for HOST/computerfqdn cover this case. If you are using all other defaults (particularly around IIS kernel-mode authentication), you can skip ahead to the next section of this article.

- If you are using a custom A record as a hostname, or load balancing with a Virtual IP, an SPN needs to be registered against the NDES service account (SCEPSvc). To register an SPN against the NDES service account: 
  - Use the Setspn command syntax of: **Setspn -s HTTP/computerfqdn** domainname\accountname when entering your commands. For example:

    - **Setspn -s HTTP/NDESFARM.fabrikam.com fabrikam\SCEPSvc**
    - **Setspn -s HTTP/NDESFARM fabrikam\SCEPSvc**

  - Then disable IIS Kernel-mode Authentication for the site.

#### To create a domain user account to act as the NDES service account

1. Sign in to the domain controller or administrative computer with Active Directory Domain Services Remote Server Administration Tools installed. Open **Active Directory Users and Computers** by using an account that has permissions to add users to the domain.

2. In the console tree, expand the structure until you see the container where you want to create the user account. For example, some organizations have a Services OU or similar account. Right-click the container, click **New**, and then click **User**.

3. In the **New Object - User** text boxes, enter appropriate names for all the fields so that it is clear that you are creating a user account. Be sure to follow your organization's policy for creating a service account, if such a policy exists. As an example, you could enter the following, and then click **Next**.

    - **First name**: **Ndes**

    - **Last name**: **Service**

    - **User logon name**: **NdesService**

4. Ensure that you set a complex password for the account and confirm the password. Configure the password options to correspond to your organization's security policies regarding service accounts. If the password is configured to expire, you should have a process in place to ensure that you reset the password at the required intervals.

5. Click **Next**, and then click **Finished**.

> [!TIP]

- You can also use the [New-ADUser](/powershell/module/activedirectory/new-aduser) Windows PowerShell command to add a domain user account.
- Depending upon your Active Directory Domain Service (AD DS) configuration, you may be able to implement a Managed Service Account or Group Managed Service Account for NDES. For more information about Managed Service Accounts, see [Managed Service Accounts]/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd378925(v=ws.10)). For more information about Group Managed Service Accounts, see [Group Managed Service Accounts Overview](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview).

#### To add the NDES service account to the local IIS\_IUSERS group

1. On the server that is hosting the NDES service, open **Computer Management** (compmgmt.msc).

2. In the Computer Management console tree, under **System Tools**, expand **Local User and Groups**. Click **Groups**.

3. In the details pane, double-click **IIS\_IUSRS**.

4. In the **General** tab, click **Add**.

5. In the **Select Users, Computers, Service Accounts, or Groups** text box, type the user sign-in name for the account that you configured to be the service account.

6. Click **Check Names**, click **OK** twice, and then close **Computer Management**.

> [!TIP]
> You can also use `net localgroup IIS_IUSRS <domain>\<username> /Add` to add the NDES service account to the local IIS_IUSRS group. The command prompt or Windows PowerShell must be run as Administrator. For more information, see the[Add-LocalGroupMember](/powershell/module'/microsoft.powershell.localaccounts/add-localgroupmember)] PowerShell command.

#### To configure the NDES service account with request permission on the CA

1. On the CA that is to be used by NDES, open the Certification Authority console with an account that has Manage CA permissions.

2. Open the Certification Authority console. Right-click the certification authority, and then click **Properties**.

3. On the **Security** tab, you can see the accounts that have Request Certificates permissions. By default the group **Authenticated Users** has this permission. The service account that you created will be a member of **Authenticated Users** when it is in use. You do not need to grant additional permissions, if **Authenticated Users** has the Request Certificates permission. However, if that is not the case, you should grant the NDES service account Request Certificates permission on the CA. To do so:

      - Click **Add**.

      - In the **Select Users, Computers, Service Accounts, or Groups** text box, type the name of the NDES service account, and click **Check Names**, and then click **OK**.

      - Ensure that NDES service account is selected. Ensure that the **Allow** check box that corresponds to **Request Certificates** is selected. Click **OK**.

##### To set a service principal name for the NDES service account

1. Ensure that you are using an account that is a member of the Domain Admins group. Open Windows PowerShell or a command prompt as an administrator.

2. Use the following command syntax to register the server principal name (SPN) for the NDES service account: `setspn -s http/<computername> <domainname>\<accountname>`. For example, to register a service account with the sign-in name NdesService in the cpandl.com domain that is running on a computer named CA1, you would run the following command: `setspn -s http/CA1.cpandl.com cpandl\NdesService`

### Select a CA for NDES

You must select a CA for the NDES service to use when issuing certificates to clients. If NDES is installed on a CA, you do not have the opportunity to select a CA because the local CA is used. When you install NDES on a computer that is not a CA, you must select the target CA. You can select the CA by the CA name or by the computer name. Click **CA name** or **Computer name**, and then click **Select**. The option you choose will determine the type of dialog box that is presented next.

- If you clicked **CA name**, you will be presented with the **Select Certification Authority** dialog box, which has a list of CAs from which you can choose.

- If you clicked **Computer name**, you see the **Select Computer** dialog box where you can set the **Locations** and enter the computer name that you want to specify as the CA.

For detailed information about NDES configuration and operation see [Network Device Enrollment Service (NDES) in Active Directory Certificate Services (AD CS)](https://social.technet.microsoft.com/wiki/contents/articles/9063.network-device-enrollment-service-ndes-in-active-directory-certificate-services-ad-cs.aspx).

## Related content

- [You cannot download CA certificate from web enrollment pages](https://social.technet.microsoft.com/wiki/contents/articles/you-cannot-download-ca-certificate-from-web-enrollment-pages.aspx)

- [TechNet Wiki: Active Directory Certificate Services (AD CS): Network Device Enrollment Service (NDES)](https://social.technet.microsoft.com/wiki/contents/articles/9063.active-directory-certificate-services-ad-cs-network-device-enrollment-service-ndes.aspx#Understanding_Network_Device_Enrollment_Service_Components)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Using a Policy Module with the Network Device Enrollment Service](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473016(v=ws.11))

- [Windows Server Security Forum](https://aka.ms/adcsforum)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)