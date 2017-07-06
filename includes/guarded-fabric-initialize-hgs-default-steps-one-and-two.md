1.  Determine a suitable distributed network name (DNN) for the HGS cluster. 
    This name will be registered in the HGS DNS service to make it easy for Hyper-V hosts to contact any node in the HGS cluster. 
    As an example, if you have 3 HGS nodes with hostnames HGS01, HGS02, and HGS03, you might decide to choose "HGS" or "HgsCluster" for the DNN. 
    Do not provide a fully qualified domain name to the `Initialize-HgsServer` cmdlet (use "hgs" not "hgs.relecloud.com").

2.  Locate your HGS guardian certificates. 
    You will need one signing certificate and one encryption certificate to intitialize the HGS cluster. 
    The easiest way to provide certificates to HGS is to create a password-protected PFX file for each certificate which contains both the public and private keys. 
    If you are using HSM-backed keys or other non-exportable certificates,  make sure the certificate is installed into the local machine's certificate store before continuing.

    <!-- Appears in guarded-fabric-initialize-hgs-ad-mode-default.md and guarded-fabric-initialize-hgs-tpm-mode-default.md>
