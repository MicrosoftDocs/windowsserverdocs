---
title: Manage certificates for Software Defined Networking
description: You can use this topic to learn how to manage certificates for Network Controller Northbound and Southbound communications when you deploy Software Defined Networking (SDN) in Windows Server 2016 Datacenter.
manager: dougkim
ms.prod: windows-server
ms.technology: networking-sdn
ms.topic: article
ms.assetid: c4e2f6c7-0364-4bf8-bb66-9af59c0bbd74
ms.author: lizross
author: eross-msft
ms.date: 08/22/2018
---

# Manage certificates for Software Defined Networking

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to manage certificates for Network Controller Northbound and Southbound communications when you deploy Software Defined Networking \(SDN\) in Windows Server 2016 Datacenter and you are using System Center Virtual Machine Manager \(SCVMM\) as your SDN management client.

>[!NOTE]
>For overview information about Network Controller, see [Network Controller](../technologies/network-controller/Network-Controller.md).

If you are not using Kerberos for securing the Network Controller communication, you can use X.509 certificates for authentication, authorization, and encryption.

SDN in Windows Server 2016 Datacenter supports both self\-signed and Certification Authority \(CA\)-signed X.509 certificates. This topic provides step-by-step instructions for creating these certificates and applying them to secure Network Controller Northbound communication channels with management clients and Southbound communications with network devices, such as the Software Load Balancer \(SLB\).
.
When you are using certificate\-based authentication, you must enroll one certificate on Network Controller nodes that is used in the following ways.

1. Encrypting Northbound Communication with Secure Sockets Layer \(SSL\) between Network Controller nodes and management clients, such as System Center Virtual Machine Manager.
2. Authentication between Network Controller nodes and Southbound devices and services, such as Hyper-V hosts and Software Load Balancers \(SLBs\).

## Creating and Enrolling an X.509 Certificate

You can create and enroll either a self\-signed certificate or a certificate that is issued by a CA.

>[!NOTE]
>When you are using SCVMM to deploy Network Controller, you must specify the X.509 certificate that is used to encrypt Northbound communications during the configuration of the Network Controller Service Template.

The certificate configuration must include the following values.

- The value for the **RestEndPoint** text box must either be the Network Controller Fully Qualified Domain Name \(FQDN\) or IP address. 
- The **RestEndPoint** value must match the subject name \(Common Name, CN\) of the X.509 certificate.

### Creating a Self\-Signed X.509 Certificate

You can create a self-signed X.509 certificate and export it with the private key \(protected with a password\) by following these steps for single\-node and multiple\-node deployments of Network Controller.

When you create self\-signed certificates, you can use the following guidelines.

- You can use the IP address of the Network Controller REST Endpoint for the DnsName parameter - but this is not recommended because it requires that the Network Controller nodes are all located within a single management subnet \(e.g. on a single rack\)
- For multiple node NC deployments, the DNS name that you specify will become the FQDN of the Network Controller Cluster \(DNS Host A records are automatically created.\) 
- For single node Network Controller deployments, the DNS name can be the Network Controller's host name followed by the full domain name.

#### Multiple node

You can use the [New-SelfSignedCertificate](https://technet.microsoft.com/itpro/powershell/windows/pkiclient/new-selfsignedcertificate) Windows PowerShell command to create a self\-signed certificate.

**Syntax**

    New-SelfSignedCertificate -KeyUsageProperty All -Provider "Microsoft Strong Cryptographic Provider" -FriendlyName "<YourNCComputerName>" -DnsName @("<NCRESTName>")

**Example usage**

    New-SelfSignedCertificate -KeyUsageProperty All -Provider "Microsoft Strong Cryptographic Provider" -FriendlyName "MultiNodeNC" -DnsName @("NCCluster.Contoso.com")

#### Single node

You can use the [New-SelfSignedCertificate](https://technet.microsoft.com/itpro/powershell/windows/pkiclient/new-selfsignedcertificate) Windows PowerShell command to create a self\-signed certificate.

**Syntax**

    New-SelfSignedCertificate -KeyUsageProperty All -Provider "Microsoft Strong Cryptographic Provider" -FriendlyName "<YourNCComputerName>" -DnsName @("<NCFQDN>")

**Example usage**

    New-SelfSignedCertificate -KeyUsageProperty All -Provider "Microsoft Strong Cryptographic Provider" -FriendlyName "SingleNodeNC" -DnsName @("SingleNodeNC.Contoso.com")

### Creating a CA\-Signed X.509 Certificate

To create a certificate by using a CA, you must have already deployed a Public Key Infrastructure \(PKI\) with Active Directory Certificate Services \(AD CS\). 

>[!NOTE]
>You can use third party CAs or tools, such as openssl, to create a certificate for use with Network Controller, however the instructions in this topic are specific to AD CS. To learn how to use a third party CA or tool, see the documentation for the software you are using.

Creating a certificate with a CA includes the following steps.

1. You or your organization's Domain or Security Administrator configures the certificate template
2. You or your organization's Network Controller Administrator or SCVMM Administrator requests a new certificate from the CA.

#### Certificate configuration requirements

While you are configuring a certificate template in the next step, ensure that the template you configure includes the following required elements.

1. The certificate subject name must be the FQDN of the Hyper-V host
2. The certificate must be placed in the local machine personal store (My – cert:\localmachine\my)
3. The certificate must have both Server Authentication (EKU: 1.3.6.1.5.5.7.3.1) and Client Authentication (EKU: 1.3.6.1.5.5.7.3.2) Application policies.

>[!NOTE]
>If the Personal \(My – cert:\localmachine\my\) certificate store on the Hyper\-V host has more than one X.509 certificate with Subject Name (CN) as the host Fully Qualified Domain Name \(FQDN\), ensure that the certificate that will be used by SDN has an additional custom Enhanced Key Usage property with the OID 1.3.6.1.4.1.311.95.1.1.1. Otherwise, the communication between Network Controller and the host might not work.

#### To configure the certificate template
  
>[!NOTE]
>Before you perform this procedure, you should review the certificate requirements and the available certificate templates in the Certificate Templates console. You can either modify an existing template or create a duplicate of an existing template and then modify your copy of the template. Creating a copy of an existing template is recommended.

1. On the server where AD CS is installed, in Server Manager, click **Tools**, and then click **Certification Authority**. The Certification Authority Microsoft Management Console \(MMC\) opens. 
2. In the MMC, double-click the CA name, right-click **Certificate Templates**, and then click **Manage**.
3. The Certificate Templates console opens. All of the certificate templates are displayed in the details pane.
4. In the details pane, click the template that you want to duplicate.
5.  Click the **Action** menu, and then click **Duplicate Template**. The template **Properties** dialog box opens.
6.  In the template **Properties** dialog box, on the **Subject Name** tab, click **Supply in the request**. \(This setting is required for Network Controller SSL certificates.\)
7.  In the template **Properties** dialog box, on the **Request Handling** tab, ensure that **Allow private key to be exported** is selected. Also ensure that the **Signature and encryption** purpose is selected.
8.  In the template **Properties** dialog box, on the **Extensions** tab, select **Key Usage**, and then click **Edit**.
9.  In **Signature**, ensure that **Digital Signature** is selected.
10.  In the template **Properties** dialog box, on the **Extensions** tab, select **Application Policies**, and then click **Edit**.
11.  In **Application Policies**, ensure that **Client Authentication** and **Server Authentication** are listed.
12.  Save the copy of the certificate template with a unique name, such as **Network Controller template**.

#### To request a certificate from the CA

You can use the Certificates snap-in to request certificates. You can request any type of certificate that has been preconfigured and made available by an administrator of the CA that processes the certificate request.

**Users** or local **Administrators** is the minimum group membership required to complete this procedure.

1. Open the Certificates snap-in for a computer.
2. In the console tree, click **Certificates \(Local Computer\)**. Select the **Personal** certificate store.
3. On the **Action** menu, point to** All Tasks<strong>, and then click **Request New Certificate</strong> to start the Certificate Enrollment wizard. Click **Next**.
4. Select the **Configured by your administrator** Certificate Enrollment Policy and click **Next**.
5. Select the **Active Directory Enrollment Policy** \(based on the CA template that you configured in the previous section\).
6. Expand the **Details** section and configure the following items.
   1. Ensure that **Key usage** includes both <strong>Digital Signature **and **Key encipherment</strong>.
   2. Ensure that **Application policies** includes both **Server Authentication** \(1.3.6.1.5.5.7.3.1\) and **Client Authentication** \(1.3.6.1.5.5.7.3.2\).
7. Click **Properties**.
8. On the **Subject** tab, in **Subject name**, in **Type**, select **Common name**. In Value, specify **Network Controller REST Endpoint**.
9. Click **Apply**, and then click **OK**.
10. Click **Enroll**.

In the Certificates MMC, click on the Personal store to view the certificate you have enrolled from the CA.

## Exporting and Copying the Certificate to the SCVMM Library

After creating either a self\-signed or CA\-signed certificate, you must export the certificate with the private key \(in .pfx format\) and without the private key \(in Base-64 .cer format\) from the Certificates snap-in. 

You must then copy the two exported files to the **ServerCertificate.cr** and **NCCertificate.cr** folders that you specified at the time when you imported the NC Service Template.

1. Open the Certificates snap-in (certlm.msc) and locate the certificate in the Personal certificate store for the local computer.
2. Right\-click the certificate, click **All Tasks**, and then click **Export**. The Certificate Export Wizard opens. Click **Next**.
3. Select **Yes**, export the private key option, click **Next**.
4. Choose **Personal Information Exchange - PKCS #12 (.PFX)** and accept the default to **Include all certificates in the certification path** if possible.
5. Assign the Users/Groups and a password for the certificate you are exporting, click **Next**.
6. On the File to export page, browse the location where you want to place the exported file, and give it a name.
7. Similarly, export the certificate in .CER format. Note: To export to .CER format, uncheck the Yes, export the private key option.
8. Copy the .PFX to the ServerCertificate.cr folder.
9. Copy the .CER file to the NCCertificate.cr folder.

When you are done, refresh these folders in the SCVMM Library and ensure that you have these certificates copied. Continue with the Network Controller Service Template Configuration and Deployment.

## Authenticating Southbound devices and services 

Network Controller communication with hosts and SLB MUX devices uses certificates for authentication. Communication with the hosts is over OVSDB protocol while communication with the SLB MUX devices is over the WCF protocol.

### Hyper-V Host Communication with Network Controller

For communication with the Hyper-V hosts over OVSDB, Network Controller needs to present a certificate to the host machines. By default, SCVMM picks up the SSL certificate configured on the Network Controller and uses it for southbound communication with the hosts.

That is the reason why the SSL certificate must have the Client Authentication EKU configured. This certificate is configured on the “Servers” REST resource \(Hyper-V hosts are represented in Network Controller as a Server resource\), and can be viewed by running the Windows PowerShell command **Get-NetworkControllerServer**.

Following is a partial example of the server REST resource.

      "resourceId": "host31.fabrikam.com",
      "properties": {
        "connections": [
          {
            "managementAddresses": [
               "host31.fabrikam.com"
            ],
            "credential": {
              "resourceRef": "/credentials/a738762f-f727-43b5-9c50-cf82a70221fa"
            },
            "credentialType": "X509Certificate"
          }
        ],

For mutual authentication, the Hyper-V host must also have a certificate to communicate with Network Controller. 

You can enroll the certificate from a Certification Authority \(CA\). If a CA based certificate is not found on the host machine, SCVMM creates a self-signed certificate and provisions it on the host machine.

Network Controller and the Hyper-V host certificates must be trusted by each other. The Hyper-V host certificate's root certificate must be present in the Network Controller Trusted Root Certification Authorities store for the Local Computer, and vice versa. 

When you're using self\-signed certificates, SCVMM ensures that the required certificates are present in the Trusted Root Certification Authorities store for the Local Computer. 

If you are using CA based certificates for the Hyper-V hosts, you need to ensure that the CA root certificate is present on the Network Controller's Trusted Root Certification Authorities store for the Local Computer.

### Software Load Balancer MUX Communication with Network Controller

The Software Load Balancer Multiplexor \(MUX\) and Network Controller communicate over the WCF protocol, using certificates for authentication.

By default, SCVMM picks up the SSL certificate configured on the Network Controller and uses it for southbound communication with the Mux devices. This certificate is configured on the “NetworkControllerLoadBalancerMux” REST resource and can be viewed by executing the Powershell cmdlet **Get-NetworkControllerLoadBalancerMux**.

Example of MUX REST resource \(partial\):

      "resourceId": "slbmux1.fabrikam.com",
      "properties": {
        "connections": [
          {
            "managementAddresses": [
               "slbmux1.fabrikam.com"
            ],
            "credential": {
              "resourceRef": "/credentials/a738762f-f727-43b5-9c50-cf82a70221fa"
            },
            "credentialType": "X509Certificate"
          }
        ],

For mutual authentication, you must also have a certificate on the SLB MUX devices. This certificate is automatically configured by SCVMM when you deploy software load balancer using SCVMM.

>[!IMPORTANT]
>On the host and SLB nodes, it is critical that the Trusted Root Certification Authorities certificate store does not include any certificate where “Issued to” is not the same as “Issued by”. If this occurs, communication between Network Controller and the southbound device fails.

Network Controller and the SLB MUX certificates must be trusted by each other \(the SLB MUX certificate's root certificate must be present in the Network Controller machine Trusted Root Certification Authorities store and vice versa\). When you're using self\-signed certificates, SCVMM ensures that the required certificates are present in the in the Trusted Root Certification Authorities store for the Local Computer.



