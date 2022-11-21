---
title: Configure Network Device Enrollment Service (NDES) role service to use a domain user account for Active Directory Certificate Services
description: Learn how to configure a service account for the Network Device Enrollment Service (NDES) as a role service with certificates based on Simple Certificate Enrollment Protocol (SCEP)
author: gswashington
ms.author: roharwoo
ms.topic: how-to
ms.date: 11/17/2022
---

# Configure Network Device Enrollment Service for Active Directory Certificate Services

Applies To: Windows Server (All supported versions)

In this article, you'll learn how to configure NDES to run as a user account that is specified as a service account.

The Network Device Enrollment Service (NDES) allows software on routers and other network devices running without domain credentials to obtain certificates based on the Simple Certificate Enrollment Protocol (SCEP).

> [!NOTE]
> If you select the built-in application pool identity, there is no additional configuration required.

The recommended configuration is to specify a user account, which requires extra steps.

SCEP was developed to support the secure, scalable issuance of certificates to network devices by using existing certification authorities (CAs). The protocol supports CA and registration authority public key distribution, enrollment, and certificate revocation queries.

See [What is Network Device Enrollment Service for Active Directory Certificate Services?](/network-device-enrollment-service-overview.md) to learn more about NDES and how it works with certificates based on Simple Certificate Enrollment Protocol.

## Specify a user account as a service account in NDES

As stated in the preceding section, the recommended configuration for NDES is to specify a user account, and extra steps are required.

## Prerequisites

After installing the NDES role service for AD CS, verify that the following prerequisites are satisfied:

- Be a domain user account

- Be a member of the local _IIS\_IUSRS_ group

- Have Request permissions on the configured CA

- Have Read and Enroll permissions on the NDES certificate template, which is configured automatically

## Verify whether it's necessary to set a service principal name for NDES

You need to configure a service principal name (SPN) in Active Directory if you're using a load balancer or virtual name. In this section, you'll learn how to  determine whether it's necessary to set an SPN in Active Directory.

If you're using a single NDES server and its actual hostname (most common scenario), the account doesn't need a new SPN registered. Computer accounts by default have a registered SPN for their hostname. If you're using all other defaults (particularly around IIS kernel-mode authentication), you can skip ahead to the next section of this article.

If you're using a custom DNS A record as a hostname, or load balancing with a virtual IP or hostname, an SPN needs to be registered for the NDES service account (_SCEPSvc_).

To register an SPN for the NDES service account:

  1. From an elevated PowerShell session, run the following command `setspn -s HTTP/<computerfqdn> <domainname>\<accountname>` (replacing the placeholders with your own values). For example:

     ```powershell
     setspn -s HTTP/<computerfqdn> <domainname>\<accountname>
     setspn -s HTTP/<netbioscomputer> <domainname>\<accountname>
     ```

  1. Then disable IIS Kernel-mode Authentication for the site.

## Create a domain user account to act as the NDES service account

You next need to create a domain user account as the NDES service account.

1. Sign in to the domain controller or administrative computer with Active Directory Domain Services Remote Server Administration Tools installed. Open **Active Directory Users and Computers** by using an account that has permissions to add users to the domain.

2. In the console tree, expand the structure until you see the container where you want to create the user account. For example, some organizations have a Services OU or similar account. Right-click the container, click **New**, and then click **User**.

3. In the **New Object - User** text boxes, enter appropriate names for all the fields so that it's clear that you're creating a user account. Be sure to follow your organization's policy for creating a service account, if such a policy exists. As an example, you could enter the following, and then click **Next**.

    - **First name**: _Ndes_

    - **Last name**: _Service_

    - **User logon name**: _NdesService_

4. Ensure that you set a complex password for the account and confirm the password. Configure the password options to correspond to your organization's security policies regarding service accounts. If the password is configured to expire, you should have a process in place to ensure that you reset the password at the required intervals.

5. Click **Next**, and then click **Finished**.

> [!TIP]
>
> - You can also use the [New-ADUser](/powershell/module/activedirectory/new-aduser) Windows PowerShell command to add a domain user account.
>
> - Depending upon your Active Directory Domain Service (AD DS) configuration, you may be able to implement a Managed Service Account or Group Managed Service Account for NDES. For more information about Managed Service Accounts, see [Managed Service Accounts](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd378925(v=ws.10)). For more information about Group Managed Service Accounts, see [Group Managed Service Accounts Overview](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview).

## Add the NDES service account to the local _IIS\_IUSRS_ group

After you've successfully created a domain user account as the NDES service account, you must add this NDES service account to the local _IIS\_IUSRS_ group.

1. On the server that is hosting the NDES service, open **Computer Management** (_compmgmt.msc_).

1. In the Computer Management console tree, under **System Tools**, expand **Local User and Groups**. Click **Groups**.

1. In the details pane, double-click _IIS\_IUSRS_.

1. In the **General** tab, click **Add**.

1. In the **Select Users, Computers, Service Accounts, or Groups** text box, type the user sign-in name for the account that you configured to be the service account.

1. Click **Check Names**, click **OK** twice, and then close **Computer Management**.

> [!TIP]
> You can also use `net localgroup IIS_IUSRS <domain>\<username> /Add` to add the NDES service account to the local _IIS\_IUSRS_ group. The command prompt or Windows PowerShell must be run as Administrator. For more information, see the[Add-LocalGroupMember](/powershell/module'/microsoft.powershell.localaccounts/add-localgroupmember)] PowerShell command.

## Set up request permission on the CA

NDES service accounts need to request permission on the Certification Authority that is to be used by NDES.

1. On the CA that is to be used by NDES, open the Certification Authority console with an account that has Manage CA permissions.

1. Open the Certification Authority console. Right-click the certification authority, and then click **Properties**.

1. On the **Security** tab, you can see the accounts that have Request Certificates permissions. By default the group **Authenticated Users** has this permission. The service account that you created will be a member of **Authenticated Users** when it's in use. You don't need to grant more permissions, if **Authenticated Users** has the Request Certificates permission. However, if that isn't the case, you should grant the NDES service account Request Certificates permission on the CA. To do so:

      - Click **Add**.

      - In the **Select Users, Computers, Service Accounts, or Groups** text box, type the name of the NDES service account, and click **Check Names**, and then click **OK**.

      - Ensure that NDES service account is selected. Ensure that the **Allow** check box that corresponds to **Request Certificates** is selected. Click **OK**.

## Set a service principal name for the NDES service account

Now that you've established request permissions, you must set a service principal name for the NDES service account.

1. Ensure that you're using an account that is a member of the Domain Admins group. Open Windows PowerShell or a command prompt as an administrator.

1. Use the following command syntax to register the server principal name (SPN) for the NDES service account: `setspn -s http/<computername> <domainname>\<accountname>`. For example, to register a service account with the sign-in name _NdesService_ in the _cpandl.com_ domain that is running on a computer named _CA1_, you would run the following command: `setspn -s http/CA1.cpandl.com cpandl\NdesService`

## Set up the NDES role service

After installation completes, you need to do a few steps to finish configuring the NDES computer.

If NDES is installed on a Certificate Authority (CA), you don't have the opportunity to select a CA because the local CA is used.

When you install NDES on a computer that isn't a CA, you must select the target CA. You can select the CA using the CA name or by the computer name.

To select the CA:

1. Open AD CS Configuration.

1. Click on **CA for NDES**

1. Click **CA name** or **Computer name**, and then click **Select**.

1. The option you choose will determine the type of dialog box that is presented next:

    - If you clicked **CA name**, you'll be presented with the **Select Certification Authority** dialog box, which has a list of CAs from which you can choose.

      or

    - If you clicked **Computer name**, you see the **Select Computer** dialog box where you can set the **Locations** and enter the computer name that you want to specify as the CA.

You're now ready to complete setup of the NDES role service. The remaining steps are verifying the Registration Authority information and setting up cryptography.

1. Registration Authority (RA) information that you provide will be used to construct the signing certificate that is issued to the service. In Server Manager. click RA information.

1. Check all fields and confirm that the RA information is correct (or is set to the defaults).

NDES uses two certificates and their keys to enable device enrollment. Organizations can use different Cryptographic Service Providers (CSPs) to store these keys, or change the length of the keys that is used by the service. Only Cryptographic Application Programming Interface (CryptoAPI) Service Providers are supported for the RA keys—Cryptography API; Next Generation (CNG) providers aren't supported.

1. To configure the cryptography, in Server Manager, click Cryptography for NDES.

1. Enter the values for Signature Key Provider and/or Encryption Key Provider and decide on key length values.

1. Continue through the wizard to complete the installation of NDES.

Now that you've cofigured the role service, you can learn detailed information about NDES configuration and operation see [Network Device Enrollment Service (NDES) in Active Directory Certificate Services (AD CS)](https://social.technet.microsoft.com/wiki/contents/articles/9063.network-device-enrollment-service-ndes-in-active-directory-certificate-services-ad-cs.aspx).

## Next steps

- [You cannot download CA certificate from web enrollment pages](https://social.technet.microsoft.com/wiki/contents/articles/you-cannot-download-ca-certificate-from-web-enrollment-pages.aspx)

- [TechNet Wiki: Active Directory Certificate Services (AD CS): Network Device Enrollment Service (NDES)](https://social.technet.microsoft.com/wiki/contents/articles/9063.active-directory-certificate-services-ad-cs-network-device-enrollment-service-ndes.aspx#Understanding_Network_Device_Enrollment_Service_Components)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Using a Policy Module with the Network Device Enrollment Service](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473016(v=ws.11))

- [Windows Server Security Forum](https://aka.ms/adcsforum)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)
