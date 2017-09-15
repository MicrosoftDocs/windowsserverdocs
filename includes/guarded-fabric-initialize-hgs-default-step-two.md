Locate your HGS guardian certificates. 
You will need one signing certificate and one encryption certificate to intitialize the HGS cluster.
The easiest way to provide certificates to HGS is to create a password-protected PFX file for each certificate which contains both the public and private keys. 
If you are using HSM-backed keys or other non-exportable certificates, make sure the certificate is installed into the local machine's certificate store before continuing.
For more information about which certificates to use, see [Obtain certificates for HGS](https://docs.microsoft.com/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-obtain-certs).

<!-- Appears in guarded-fabric-initialize-hgs-ad-mode-default.md and guarded-fabric-initialize-hgs-tpm-mode-default.md
-->