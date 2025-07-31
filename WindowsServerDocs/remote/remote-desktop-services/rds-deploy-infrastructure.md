---
title: Deploy your Remote Desktop environment
description: Learn how to deploy a Remote Desktop environment with step-by-step instructions. Set up your servers quickly and efficiently.
ms.author: mosagie
ms.date: 06/16/2025
ms.topic: install-set-up-deploy
author: meaghanlewis
---
# Deploy your Remote Desktop environment

Use the following steps to deploy the Remote Desktop servers in your environment. You can install the server roles on physical machines or virtual machines, depending on whether you're creating an on-premises, cloud-based, or hybrid environment.

If you're using virtual machines for any of the Remote Desktop Services servers, make sure you [prepared those virtual machines](rds-prepare-vms.md).

1. Add all the servers you're going to use for Remote Desktop Services to Server Manager:
   1. In Server Manager, click **Manage** > **Add Servers**.
   2. Click **Find Now**.
   3. Click each server in the deployment (for example, Contoso-Cb1, Contoso-WebGw1, and Contoso-Sh1) and click **OK**.
2. Create a session-based deployment to deploy the Remote Desktop Services components:
   1. In Server Manager, click **Manage** > **Add Roles and Features**.
   2. Click **Remote Desktop Services installation**, **Standard Deployment**, and **Session-based desktop deployment**.
   3. Select the appropriate servers for the RD Connection Broker server, RD Web Access server, and RD Session Host server (for example, Contoso-Cb1, Contoso-WebGw1, and Contoso-SH1, respectively).
   4. Select **Restart the destination server automatically if required**, and then click **Deploy**.
   5. Wait for the deployment to complete successfully.
3. Add RD License Server:
   1. In Server Manager, click **Remote Desktop Services > Overview > +RD Licensing**.
   2. Select the virtual machine on which you want to install the RD license server. For example, Contoso-Cb1.
   3. Click **Next**, and then click **Add**.
4. Activate the RD License Server and add it to the License Servers group:
   1. In Server Manager, click **Remote Desktop Services > Servers**. Right-click the server with the Remote Desktop Licensing role installed and select **RD Licensing Manager**.
   2. In RD Licensing Manager, select the server, and then click **Action > Activate Server**.
   3. Accept the default values in the Activate Server Wizard. Continue accepting default values until you reach the **Company information** page. Then, enter your company information.
   4. Accept the defaults for the remaining pages until the final page. Clear **Start Install Licenses Wizard now**, and then click **Finish**.
   5. Select **Action** > **Review Configuration** > **Add to Group** > **OK**. Enter credentials for a user in the AAD DC Administrators group, and register as SCP. This step might not work if you're using Microsoft Entra Domain Services, but you can ignore any warnings or errors.
5. Add the RD Gateway server and certificate name:
   1. In Server Manager, click **Remote Desktop Services > Overview > + RD Gateway**.
   2. In the Add RD Gateway Servers wizard, select the virtual machine where you want to install the RD Gateway server (for example, Contoso-WebGw1).
   3. Enter the SSL certificate name for the RD Gateway server using the external fully qualified DNS Name (FQDN) of the RD Gateway server. In Azure, this is the **DNS name** label and uses the format servicename.location.cloudapp.azure.com. For example, contoso.westus.cloudapp.azure.com.
   4. Click **Next**, and then click **Add**.
6. Create and install self-signed certificates for the RD Gateway and RD Connection Broker servers.

    > [!NOTE]
    > If you're providing and installing certificates from a trusted certificate authority, perform the procedures from step h to step k for each role. You need to have the .pfx file available for each of these certificates.

   1. In Server Manager, click **Remote Desktop Services > Overview > Tasks > Edit Deployment Properties**.
   2. Expand **Certificates**, and then scroll down to the table. Click **RD Gateway > Create new certificate**.
   3. Enter the certificate name, using the external FQDN of the RD Gateway server (for example, contoso.westus.cloudapp.azure.com) and then enter the password.
   4. Select **Store this certificate** and then browse to the shared folder you created for certificates in a previous step. (For example,\Contoso-Cb1\Certificates.)
   5. Enter a file name for the certificate (for example, ContosoRdGwCert), and then click **Save**.
   6. Select **Allow the certificate to be added to the Trusted Root Certificate Authorities certificate store on the destination computers**, and then click **OK**.
   7. Click **Apply**, and then wait for the certificate to be successfully applied to the RD Gateway server.
   8. Click **RD Web Access > Select existing certificate**.
   9. Browse to the certificate created for the RD Gateway server (for example, ContosoRdGwCert), and then click **Open**.
   10. Enter the password for the certificate, select **Allow the certificate to be added to the Trusted Root Certificate store on the destination computers**, and then click **OK**.
   11. Click **Apply**, and then wait for the certificate to be successfully applied to the RD Web Access server.
   12. Repeat substeps 1-11 for the **RD Connection Broker - Enable Single Sign On** and **RD Connection Broker - Publishing services**, using the internal FQDN of the RD Connection Broker server for the new certificate's name (for example, Contoso-Cb1.Contoso.com).
7. Export self-signed public certificates and copy them to a client computer. If you're using certificates from a trusted certificate authority, you can skip this step.
   1. Launch certlm.msc.
   2. Expand **Personal**, and then click **Certificates**.
   3. In the right-hand pane right-click the RD Connection Broker certificate intended for client authentication, for example **Contoso-Cb1.Contoso.com**.
   4. Click **All Tasks > Export**.
   5. Accept the default options in the Certificate Export Wizard accept defaults until you reach the **File to Export** page.
   6. Browse to the shared folder you created for certificates, for example \Contoso-Cb1\Certificates.
   7. Enter a File name, for example ContosoCbClientCert, and then click **Save**.
   8. Click **Next**, and then click **Finish**.
   9. Repeat substeps 1-8 for the RD Gateway and Web certificate, (for example contoso.westus.cloudapp.azure.com), giving the exported certificate an appropriate file name, for example **ContosoWebGwClientCert**.
   10. In File Explorer, navigate to the folder where the certificates are stored, for example \Contoso-Cb1\Certificates.
   11. Select the two exported client certificates, then right-click them, and click **Copy**.
   12. Paste the certificates on the local client computer.
8. Configure the RD Gateway and RD Licensing deployment properties:
   1. In Server Manager, click **Remote Desktop Services > Overview > Tasks > Edit Deployment Properties**.
   2. Expand **RD Gateway** and clear the **Bypass RD Gateway server for local addresses** option.
   3. Expand **RD licensing** and select **Per User**.
   4. Click **OK**.
9. Create a session collection. These steps create a basic collection. Check out [Create a Remote Desktop Services collection for desktops and apps to run](rds-create-collection.md) for more information about collections.

   1. In Server Manager, click **Remote Desktop Services > Collections > Tasks > Create Session Collection**.
   2. Enter a collection Name (for example, ContosoDesktop).
   3. Select an RD Session Host Server (Contoso-Sh1), accept the default user groups (Contoso\Domain Users), and enter the Universal Naming Convention (UNC) Path to the user profile disks created previously (\Contoso-Cb1\UserDisks).
   4. Set a Maximum size, and then click **Create**.

You now created a basic Remote Desktop Services infrastructure. If you need to create a highly available deployment, you can add a [connection broker cluster](rds-connection-broker-cluster.md) or a [second RD Session Host server](rds-scale-rdsh-farm.md).
