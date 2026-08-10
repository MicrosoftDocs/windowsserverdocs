---
title: Configure the Certificate Enrollment Policy Web Service in Windows Server
description: Learn how to configure the Certificate Enrollment Policy Web Service so that users and computers can get certificate enrollment policy information.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.date: 03/27/2025
#customer intent: As an IT administrator, I want to configure the Certificate Enrollment Policy Web Service so that users and computers can obtain certificate enrollment policy information.
---

# Configure the Certificate Enrollment Policy Web Service

The Certificate Enrollment Policy Web Service lets users and computers obtain certificate enrollment policy information even when the computer isn't a member of a domain or if a domain-joined computer is temporarily outside the security boundary of the corporate network. The Certificate Enrollment Policy Web Service works with the Certificate Enrollment Web Service to provide policy-based automatic certificate enrollment for these users and computers. This article provides information on how to configure the Certificate Enrollment Policy Web Service.

## Prerequisites

- The Certificate Enrollment Policy Web Service server role is installed.

## Configure the Certificate Enrollment Policy Web Service

After you install the Certificate Enrollment Policy Web Service, you need to **configure a friendly name value for the service**, and **create a Group Policy setting to enable using the service.** The following sections describe how to complete configuration.

### Configure a friendly name value

To configure a friendly name value for the Certificate Enrollment Policy Web Service:

1. Open the Internet Information Services (IIS) Manager console.

1. In the **Connections** pane, expand the web server that's hosting the Certificate Enrollment Policy Web Service.

    > [!NOTE]
    > If you see a prompt that asks you to get started with the Microsoft Web Platform, select **No**.

1. Go to **Sites** > **Default Web Site**. Select the appropriate installation virtual application name. The name of the virtual application name changes based on how you installed the service, but should follow the basic syntax of **KeyBasedRenewal** **\_ADPolicyProvider\_CEP\_** **AuthenticationType**.

      - If you enabled key-based renewal and configured client certificate authentication, the virtual application name should is **KeyBasedRenewal\_ADPolicyProvider\_CEP\_Certificate**.

      - If you didn't enable key-based renewal and configured username and password authentication, the virtual application name is **ADPolicyProvider\_CEP\_UsernamePassword**.

      - If you didn't enable key-based renuwal but configured Windows integrated authentication, the virtual application name is **ADPolicyProvider\_CEP\_Kerberos**.

1. In the **virtual application name** Home pane, open **Application Settings**, then open **FriendlyName**.

1. In the **Edit Application Setting** dialog box, under **Value**, enter the name that you want to use as the friendly name for the service.

1. Select **OK**.

1. In the **Application Settings** pane, open **URI**. Record this value somewhere you can access later, as the Group Policy requires the URI to let clients connect to the service.

1. Select **Cancel**.

1. Close the IIS Manager console.

You can use the URI you got from following the previous directions to give domain client users or their computers the ability to obtain certificates using Certificate Enrollment Policy Web Services. Domain clients can request certificates by using the Certificates console, without the clients having to know the URI to the Certificate Enrollment Policy Web Services virtual application name.

> [!NOTE]
> Domain users can enter the URI by configuring a custom certificate request, but this is typically not a practical solution because the URI is long and the procedure is complex. However, administrators can perform custom certificate requests to validate the configuration of the Certificate Enrollment Policy Web Service. For more information, see [Certificate Enrollment Web Services](https://go.microsoft.com/fwlink/?linkid=258862).

### Configure Group Policy to enable using the Certificate Enrollment Policy Web Service

To configure Group Policy to enable using the Certificate Enrollment Policy Web Service:

1. Go to **Server Manager** > **Tools** > **Group Policy Management** to open the Group Policy Management console.

    > [!NOTE]
    > You can only configure Group Policy settings if you've signed in using an account that's a member of the Domain Admins or Enterprise Admins groups.

1. Navigate to the forest you want to target for the new Group Policy, then go to **Domains**.

1. Right-select the domain, then select **Create a GPO in this domain and link it here**.

1. In the **New GPO** dialog box, under **Name**, enter an appropriate name for the new Group Policy Object (GPO), such as **Certificate Enrollment Policy Web Service Certificates**. Select **OK**.

1. Select the linked GPO that you just created. If you see a warning message about Group Policy Management Console, review the message, then select **OK**.

1. Right-click the linked GPO that you just created and select **Edit**.

1. There are two types of certificates that you can distribute by using a GPO: computer certificates or user certificates. The following instructions describe setting the URI for both the **Computer Configuration** and **User Configuration** parts of the GPO. You can either set them separately or set both at the same time.

To distribute certificates for computers:

1. In the console pane, under **Computer Configuration**, select **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

1. In the **Details** pane, open **Certificate Services Client - Certificate Enrollment Policy**.

1. Set **Configuration Model** to **Enabled**, then select **Add**.

1. In the **Certificate Enrollment Policy Server** dialog box, under **Enter enrollment policy server URI**, enter the URI that you copied in the previous procedure.

1. In **Authentication type**, set the authentication type that you configured for the Certificate Enrollment Web Policy Service. For more information, see [Certificate Enrollment Policy Web Service overview](/windows-server/identity/ad-cs/certificate-enrollment-policy-web-service-overview) on choosing an authentication type.

1. Select **Validate Server**, and when the server is validated, select **Add**. Select **OK**.

    > [!NOTE]
    > You can only validate the server if you have the appropriate credentials. This could be an issue if you have selected client certificate validation and you don't already have a certificate for the computer. If this is the case, you'll first have to obtain a certificate for the computer. You will need a computer certificate with the following characteristics: Enhanced Key Usage Client Authentication 1.3.6.1.5.5.7.3.2.

1. To distribute certificates for users, in the **Console** pane, under **User Configuration**, select **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

    1. In the **Details** pane, open **Certificate Services Client - Certificate Enrollment Policy**.

    1. Set **Configuration Model** to **Enabled**, then select **Add**.

    1. In the **Certificate Enrollment Policy Server** dialog box, under **Enter enrollment policy server URI**, enter the URI that you copied in the previous procedure.

    1. In **Authentication type**, set the authentication type that you configured for the Certificate Enrollment Web Policy Service.

    1. Select **Validate Server**, then wait for the validation process to finish. After validation is done, select **Add**, then select **OK**.

        > [!NOTE]
        > You can only validate the server if you have the appropriate credentials. If you installed the service with client certificate validation and you don't already have a certificate for the computer, then before you can validate the server, you must get a certificate for the computer. You need a computer certificate with Enhanced Key Usage Client Authentication 1.3.6.1.5.5.7.3.2.

1. Close the Group Policy Management Editor and the Group Policy Management Console.

## Related content

- [Certificate Enrollment Policy Web Service overview](/windows-server/identity/ad-cs/certificate-enrollment-policy-web-service-overview)

- [Configure Certificate Enrollment Web Service for certificate key-based renewal on a custom port](/windows-server/identity/ad-cs/certificate-enrollment-certificate-key-based-renewal)

- [PKI design considerations](/windows-server/identity/ad-cs/pki-design-considerations)


