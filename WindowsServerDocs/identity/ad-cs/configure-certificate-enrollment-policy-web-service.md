---
title: Configure the Certificate Enrollment Policy Web Service
description: Learn how to set up the Certificate Enrollment Policy Web Service
author: robinharwood
ms.topic: how-to
ms.author: gswashington
ms.date: 10/16/2023
---

# Certificate Enrollment Policy Web Service guidance

Applies To: Windows Server 2012 R2, Windows Server 2012

The Certificate Enrollment Policy Web Service enables users and computers to obtain certificate enrollment policy information even when the computer is not a member of a domain or if a domain-joined computer is temporarily outside the security boundary of the corporate network. The Certificate Enrollment Policy Web Service works with the Certificate Enrollment Web Service to provide policy-based automatic certificate enrollment for these users and computers. See [Certificate Enrollment Policy Web Service Guidance](/certificate-enrollment-policy-web-service-conceptual.md) for more information on how the Certificate Enrollment Policy Web Service service works, including installation requirements as well as information for the Server Manager configuration pages.

## Certificate Enrollment Policy Web Service Configuration

After you install the Certificate Enrollment Policy Web Service, there are two additional configuration steps to complete.

1. Configure a friendly name value for the Certificate Enrollment Policy Web Service.

1. Configure Group Policy to enable use of the Certificate Enrollment Policy Web Service.

### To configure a friendly name value for the Certificate Enrollment Policy Web Service

1. Open the Internet Information Services (IIS) Manager console.

1. In the **Connections** pane, expand the web server that's hosting the Certificate Enrollment Policy Web Service.

    > [!NOTE]
    > If you are asked to get started with the Microsoft Web Platform, select **No**.


1. Expand **Sites**, expand **Default Web Site**, and then select the appropriate installation virtual application name. The name of the virtual application name varies with the type of installation that you performed. The variation is as follows:

    *KeyBasedRenewal* **\_ADPolicyProvider\_CEP\_** *AuthenticationType*

    For example:

      - **KeyBasedRenewal\_ADPolicyProvider\_CEP\_Certificate** is the virtual application name if you enabled key-based renewal and configured client certificate authentication.

      - **ADPolicyProvider\_CEP\_UsernamePassword** is the virtual application name if you didn't enable key-based renewal and you configured user name and password authentication.

      - **ADPolicyProvider\_CEP\_Kerberos** is the virtual application name if you didn't enable key-based renewal and you configured Windows integrated authentication.

1. In the *virtual application name* Home pane, double-select **Application Settings**, and then double-select **FriendlyName**.

1. In the **Edit Application Setting** dialog box, under **Value**, type the name that you want to configure as a friendly name for the service. For example, you might type **Client Certificate Enrollment** as the friendly name for the service. Select **OK**.

1. In the **Application Settings** pane, double-select **URI**. The value that's shown for URI is significant because that's the path that clients will use to connect to the service. Copy this value, because you'll use it when you configure Group Policy. Select **Cancel**.

1. Close the Internet Information Services (IIS) Manager console.

To provide domain client users or their computers with the ability to obtain certificates using Certificate Enrollment Policy Web Services, you can set the URI that you obtained by using the previous procedure. This will allow domain clients to request certificates by using the Certificates console, without the clients having to know the URI to the Certificate Enrollment Policy Web Services virtual application name.

> [!NOTE]
> Domain users could input the URI by configuring a custom certificate request, but this is typically not a practical solution because the URI is long and the procedure is complex. However, administrators can perform custom certificate requests to validate the configuration of the Certificate Enrollment Policy Web Service. For more information, see [Certificate Enrollment Web Services](https://go.microsoft.com/fwlink/?linkid=258862).

### To configure Group Policy to enable use of the Certificate Enrollment Policy Web Service

1. Open the Group Policy Management console. To do so, from Server Manager, select **Tools**, and then select **Group Policy Management**.

    > [!NOTE]
    > Ensure that you sign in by using an account with membership in Domain Admins or Enterprise Admins so that you can configure Group Policy settings. You can configure a Group Policy setting for the entire domain, an OU, or (if the account you are using is a member of Enterprise Admins), an entire site. The following instructions assume that you want to set a new Group Policy for the domain.

1. Expand the forest that you want to target for the new Group Policy. Expand **Domains**. Right-select the domain, and then select **Create a GPO in this domain, and link it here**.

1. In the **New GPO** dialog box, under **Name**, type a name that is appropriate for the new Group Policy Object (GPO), for example, **Certificate Enrollment Policy Web Service Certificates**. Select **OK**.

1. Select the linked GPO that you just created. If you see a warning message about Group Policy Management Console, review the message, and then select **OK**.

1. Right-select the linked GPO that you just created, and then select **Edit**.

1. There are two types of certificates that you can distribute by using a GPO: computer certificates or user certificates. The following instructions describe setting the URI for both the **Computer Configuration** and **User Configuration** parts of the GPO. You can set either separately or set them both.

1. To distribute certificates for computers, in the console pane, under **Computer Configuration**, select **Policies**, select **Windows Settings**, select **Security Settings**, and then select **Public Key Policies**.

    1. In the details pane, double-select **Certificate Services Client - Certificate Enrollment Policy**.

    1. Set **Configuration Model** to **Enabled**, and then select **Add**.

    1. In the **Certificate Enrollment Policy Server** dialog box, under **Enter enrollment policy server URI**, enter the URI that you copied in the previous procedure.

    1. In **Authentication type**, set the authentication type that you configured for the Certificate Enrollment Web Policy Service. See [Certificate Enrollment Policy Web Service Guidance](/certificate-enrollment-policy-web-service-conceptual.md) for information on choosing an authentication type.

    1. Select **Validate Server**, and when the server is validated, select **Add**. Select **OK**.

        > [!NOTE]
        > You can only validate the server if you have the appropriate credentials. This could be an issue if you have selected client certificate validation and you don't already have a certificate for the computer. If this is the case, you'll first have to obtain a certificate for the computer. You will need a computer certificate with the following characteristics: Enhanced Key Usage Client Authentication 1.3.6.1.5.5.7.3.2.

1. To distribute certificates for users, in the console pane, under **User Configuration**, select **Policies**, select **Windows Settings**, select **Security Settings**, and then select **Public Key Policies**.

    1. In the details pane, double-select **Certificate Services Client - Certificate Enrollment Policy**.

    1. Set **Configuration Model** to **Enabled**, and then select **Add**.

    1. In the **Certificate Enrollment Policy Server** dialog box, under **Enter enrollment policy server URI**, enter the URI that you copied in the previous procedure.

    1. In **Authentication type**, set the authentication type that you configured for the Certificate Enrollment Web Policy Service.

    1. Select **Validate Server**, and when the server is validated, select **Add**. Select **OK**.

        > [!NOTE]
        > You can only validate the server if you have the appropriate credentials. This could be an issue if you have selected client certificate validation and you do not already have a certificate for the user. If this is the case, you will first have to obtain a certificate for the user. You will need a user certificate that includes an enhanced key usage (EKU) of Client Authentication with object ID (OID) 1.3.6.1.5.5.7.3.2.

1. Close the Group Policy Management Editor and the Group Policy Management Console.

## Related content

- [Certificate Enrollment Policy Web Service Guidance](/certificate-enrollment-policy-web-service-conceptual.md)

- [Certificate Enrollment Web Services in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx)

- [Windows Server Security Forum](https://aka.ms/adcsforum)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)