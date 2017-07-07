Determine a suitable distributed network name (DNN) for the HGS cluster. 
This name will be registered in the HGS DNS service to make it easy for Hyper-V hosts to contact any node in the HGS cluster. 
As an example, if you have 3 HGS nodes with hostnames HGS01, HGS02, and HGS03, you might decide to choose "HGS" or "HgsCluster" for the DNN. 
Do not provide a fully qualified domain name to the `Initialize-HgsServer` cmdlet (use "hgs" not "hgs.relecloud.com").



<!-- Appears in guarded-fabric-initialize-hgs-ad-mode-default.md and guarded-fabric-initialize-hgs-tpm-mode-default.md
-->
