---
title: Configure Encryption for a Virtual Network
description: Virtual network encryption allows encryption of virtual network traffic between virtual machines that communicate with each other within subnets marked as ‘Encryption Enabled.’
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking-hv-switch
ms.topic: get-started-article
ms.assetid: 378213f5-2d59-4c9b-9607-1fc83f8072f1
ms.author: pashort
author: shortpatti
ms.date: 08/08/2018
---
# Configure Encryption for a Virtual Subnet

>Applies to: Windows Server

Virtual network encryption allows for encryption of virtual network traffic between VMs that communicate with each other within subnets marked as ‘Encryption Enabled.’ It also utilizes Datagram Transport Layer Security (DTLS) on the virtual subnet to encrypt packets. DTLS protects against eavesdropping, tampering, and forgery by anyone with access to the physical network.

Virtual network encryption requires:
- Encryption certificates installed on each of the SDN-enabled Hyper-V hosts.
- A credential object in the Network Controller referencing the thumbprint of that certificate.
- Configuration on each of the Virtual Networks contain subnets that require encryption.

Once you enable encryption on a subnet, all network traffic within that subnet is encrypted automatically, in addition to any application-level encryption that may also take place.  Traffic that crosses between subnets, even if marked as encrypted, is sent unencrypted automatically. Any traffic that crosses the virtual network boundary also gets sent unencrypted.

>[!NOTE]
>When communicating with another VM on the same subnet, whether its currently connected or connected at a later time, the traffic gets encrypted automatically.

>[!TIP]
>If you must restrict applications to only communicate on the encrypted subnet, you can use Access Control Lists (ACLs) only to allow communication within the current subnet. For more information, see [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](https://docs.microsoft.com/windows-server/networking/sdn/manage/use-acls-for-traffic-flow).


## Step 1. Create the Encryption Certificate
Each host must have an encryption certificate installed. You can use the same certificate for all tenants or generate a unique one for each tenant. 

1.  Generate the certificate  

```
    $subjectName = "EncryptedVirtualNetworks"
    $cryptographicProviderName = "Microsoft Base Cryptographic Provider v1.0";
    [int] $privateKeyLength = 1024;
    $sslServerOidString = "1.3.6.1.5.5.7.3.1";
    $sslClientOidString = "1.3.6.1.5.5.7.3.2";
    [int] $validityPeriodInYear = 5;

    $name = new-object -com "X509Enrollment.CX500DistinguishedName.1"
    $name.Encode("CN=" + $SubjectName, 0)

    #Generate Key
    $key = new-object -com "X509Enrollment.CX509PrivateKey.1"
    $key.ProviderName = $cryptographicProviderName
    $key.KeySpec = 1 #X509KeySpec.XCN_AT_KEYEXCHANGE
    $key.Length = $privateKeyLength
    $key.MachineContext = 1
    $key.ExportPolicy = 0x2 #X509PrivateKeyExportFlags.XCN_NCRYPT_ALLOW_EXPORT_FLAG 
    $key.Create()

    #Configure Eku
    $serverauthoid = new-object -com "X509Enrollment.CObjectId.1"
    $serverauthoid.InitializeFromValue($sslServerOidString)
    $clientauthoid = new-object -com "X509Enrollment.CObjectId.1"
    $clientauthoid.InitializeFromValue($sslClientOidString)
    $ekuoids = new-object -com "X509Enrollment.CObjectIds.1"
    $ekuoids.add($serverauthoid)
    $ekuoids.add($clientauthoid)
    $ekuext = new-object -com "X509Enrollment.CX509ExtensionEnhancedKeyUsage.1"
    $ekuext.InitializeEncode($ekuoids)

    # Set the hash algorithm to sha512 instead of the default sha1
    $hashAlgorithmObject = New-Object -ComObject X509Enrollment.CObjectId
    $hashAlgorithmObject.InitializeFromAlgorithmName( $ObjectIdGroupId.XCN_CRYPT_HASH_ALG_OID_GROUP_ID, $ObjectIdPublicKeyFlags.XCN_CRYPT_OID_INFO_PUBKEY_ANY, $AlgorithmFlags.AlgorithmFlagsNone, "SHA512")


    #Request Certificate
    $cert = new-object -com "X509Enrollment.CX509CertificateRequestCertificate.1"

    $cert.InitializeFromPrivateKey(2, $key, "")
    $cert.Subject = $name
    $cert.Issuer = $cert.Subject
    $cert.NotBefore = (get-date).ToUniversalTime()
    $cert.NotAfter = $cert.NotBefore.AddYears($validityPeriodInYear);
    $cert.X509Extensions.Add($ekuext)
    $cert.HashAlgorithm = $hashAlgorithmObject
    $cert.Encode()

    $enrollment = new-object -com "X509Enrollment.CX509Enrollment.1"
    $enrollment.InitializeFromRequest($cert)
    $certdata = $enrollment.CreateRequest(0)
    $enrollment.InstallResponse(2, $certdata, 0, "")
```

After running the script, a new certificate appears in the My store:

    PS D:\> dir cert:\\localmachine\my


    PSParentPath: Microsoft.PowerShell.Security\Certificate::localmachine\my

    Thumbprint                                Subject
    ----------                                -------
    84857CBBE7A1C851A80AE22391EB2C39BF820CE7  CN=MyNetwork
    5EFF2CE51EACA82408572A56AE1A9BCC7E0843C6  CN=EncryptedVirtualNetworks

2. Export the certificate to a file.<p>You need two copies of the certificate, one with the private key and one without.

```
   $subjectName = "EncryptedVirtualNetworks"
   $cert = Get-ChildItem cert:\localmachine\my | ? {$_.Subject -eq "CN=$subjectName"}
   [System.io.file]::WriteAllBytes("c:\$subjectName.pfx", $cert.Export("PFX", "secret"))
   Export-Certificate -Type CERT -FilePath "c:\$subjectName.cer" -cert $cert
```

3. Install the certificates on each of your hyper-v hosts 

   PS C:\> dir c:\$subjectname.*


~~~
    Directory: C:\


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        9/22/2017   4:54 PM            543 EncryptedVirtualNetworks.cer
-a----        9/22/2017   4:54 PM           1706 EncryptedVirtualNetworks.pfx
~~~

4. Installing on a Hyper-V host

```
   $server = "Server01"

   $subjectname = "EncryptedVirtualNetworks"
   copy c:\$SubjectName.* \\$server\c$
   invoke-command -computername $server -ArgumentList $subjectname,"secret" {
       param (
           [string] $SubjectName,
           [string] $Secret
       )
       $certFullPath = "c:\$SubjectName.cer"

       # create a representation of the certificate file
       $certificate = new-object System.Security.Cryptography.X509Certificates.X509Certificate2
       $certificate.import($certFullPath)

       # import into the store
       $store = new-object System.Security.Cryptography.X509Certificates.X509Store("Root", "LocalMachine")
       $store.open("MaxAllowed")
       $store.add($certificate)
       $store.close()

       $certFullPath = "c:\$SubjectName.pfx"
       $certificate = new-object System.Security.Cryptography.X509Certificates.X509Certificate2
       $certificate.import($certFullPath, $Secret, "MachineKeySet,PersistKeySet")

       # import into the store
       $store = new-object System.Security.Cryptography.X509Certificates.X509Store("My", "LocalMachine")
       $store.open("MaxAllowed")
       $store.add($certificate)
       $store.close()

       # Important: Remove the certificate files when finished
       remove-item C:\$SubjectName.cer
       remove-item C:\$SubjectName.pfx
   }
```

5. Repeat for each server in your environment.<p>After repeating for each server, you should have a certificate installed in the root and my store of each Hyper-V host. 

6. Verify the installation of the certificate.<p>Verify the certificates by checking the contents of the My and Root certificate stores:

   PS C:\> enter-pssession Server1

~~~
[Server1]: PS C:\> get-childitem cert://localmachine/my,cert://localmachine/root | ? {$_.Subject -eq "CN=EncryptedVirtualNetworks"}

PSParentPath: Microsoft.PowerShell.Security\Certificate::localmachine\my

Thumbprint                                Subject
----------                                -------
5EFF2CE51EACA82408572A56AE1A9BCC7E0843C6  CN=EncryptedVirtualNetworks


PSParentPath: Microsoft.PowerShell.Security\Certificate::localmachine\root

Thumbprint                                Subject
----------                                -------
5EFF2CE51EACA82408572A56AE1A9BCC7E0843C6  CN=EncryptedVirtualNetworks
~~~

7. Make note of the Thumbprint.<p>You must make a note of the thumbprint because you need it to create the certificate credential object in the network controller.

## Step 2. Create the Certificate Credential

After you install the certificate on each of the Hyper-V hosts connected to the network controller, you must now configure the network controller to use it.  To do this, you must create a credential object containing the certificate thumbprint from the machine with the Network Controller PowerShell modules installed. 


    # Replace with thumbprint from your certificate
    $thumbprint = "5EFF2CE51EACA82408572A56AE1A9BCC7E0843C6"  

    # Replace with your Network Controller URI
    $uri = "https://nc.contoso.com"

    Import-module networkcontroller

    $credproperties = new-object Microsoft.Windows.NetworkController.CredentialProperties
    $credproperties.Type = "X509Certificate"
    $credproperties.Value = $thumbprint
    New-networkcontrollercredential -connectionuri $uri -resourceid "EncryptedNetworkCertificate" -properties $credproperties -force

>[!TIP]
>You can reuse this credential for each encrypted virtual network, or you can deploy and use a unique certificate for each tenant.


## Step 3. Configuring a Virtual Network for Encryption

This step assumes you have already created a virtual network name "My Network" and it contains at least one virtual subnet.  For information on creating virtual networks, see [Create, Delete, or Update Tenant Virtual Networks](../Manage/Create,-Delete,-or-Update-Tenant-Virtual-Networks.md).

>[!NOTE]
>When communicating with another VM on the same subnet, whether its currently connected or connected at a later time, the traffic gets encrypted automatically.

1.  Retrieve the Virtual Network and Credential objects from the network controller

    $vnet = Get-NetworkControllerVirtualNetwork -ConnectionUri $uri -ResourceId "MyNetwork"
    $certcred = Get-NetworkControllerCredential -ConnectionUri $uri -ResourceId "EncryptedNetworkCertificate"

2.  Add a reference to the certificate credential and enable encryption on individual subnets

    $vnet.properties.EncryptionCredential = $certcred

    # Replace the Subnets index with the value corresponding to the subnet you want encrypted.  
    # Repeat for each subnet where encryption is needed
    $vnet.properties.Subnets[0].properties.EncryptionEnabled = $true

3.  Put the updated Virtual Network object into the network controller

    New-NetworkControllerVirtualNetwork -ConnectionUri $uri -ResourceId $vnet.ResourceId -Properties $vnet.Properties -force


_**Congratulations!**_ You’re done once you complete these steps. 


## Next steps



