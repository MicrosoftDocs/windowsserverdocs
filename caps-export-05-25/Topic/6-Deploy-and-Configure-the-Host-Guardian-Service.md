---
title: 6 Deploy and Configure the Host Guardian Service
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f9fcfa81-2bbf-4e6d-a71c-e2eb8677cd91
robots: noindex,nofollow
---
# 6 Deploy and Configure the Host Guardian Service
This section contains information on setting up the HGS server role and infrastructure.  
  
>*You must first run Windows Update on all servers (physical and virtual) used in this scenario validation, install all available updates, and then restart the servers.*  
  
***Note: Use Windows PowerShell® running in an elevated Windows PowerShell console to perform the installation steps for all PowerShell commands.***  
  
> Use the following procedure to enable the Host Guardian Service on your server running Windows Server Technical Preview 2016.  
  
### 6.1 Add the Host Guardian Service role  
1.  To add the Host Guardian Service Role, run the following cmdlet:    
      `Install-WindowsFeature –Name HostGuardianServiceRole –IncludeManagementTools`  
  
### 6.2 Install the Host Guardian Service  
The Host Guardian Service includes two components that needs to be initialized:    
1.  Attestation server — you initially set the attestation to use administrator-trusted configuration so that you can test the end-to-end scenario without requiring TPM 2.0.    
2.  Key Protection server – This role supports interface required to decrypt vTPM.  
  
To install the Host Guardian Service role:    
1.  Run the following cmdlet to install the Host Guardian Service as well as the domain controller role which the Host Guardian Service requires:  
`$adminPassword = ConvertTo-SecureString -AsPlainText '!!123abc' –Force`    
  
 `Install-HgsServer -HgsDomainName ‘Relecloud.com’ -SafeModeAdministratorPassword $adminPassword -restart`  
  
 >**Note:** The `–SafeModeAdministratorPassword` argument specifies the Directory Services Restore Mode (DSRM) password on a domain controller for the Host Guardian Service’s Active Directory domain, which is installed as part of the Host Guardian Service.  
  
1.  Restart the server, and then log in with the administrator credentials that you previously used as the local administrator.  
  
  
### 6.3 Create self-signed certificates for HGS using PowerShell  
>*Creating self-signed certificates is not recommended outside of test deployment environments. Use certificates that are issued by a trusted authority if you are deploying in a production environment.*  
  
For evaluation purposes, we will be generating self-signed certificates. In a production deployment, you should leverage the existing PKI infrastructure.  
  
1.  Open an elevated PowerShell command window on the Host Guardian Server to create a self-signed certificate:    
2.  Create a Certificate Export Password    
  
 ` $certificatePassword = ConvertTo-SecureString -AsPlainText '!!123abc' –Force`    
1.  Create the HGS Service Name     
  
   `$HgsServiceName = 'ADHgs'`                                     
1.  Create and export the HGS HTTPS certificate    
  
 `$HttpsCertificate = New-SelfSignedCertificate -DnsName "$HgsServiceName.$env:userdnsdomain" –CertStoreLocation Cert:\\LocalMachine\\My`  
                                                                     
 `Export-PfxCertificate -Cert $HttpsCertificate -Password $certificatePassword -FilePath 'c:\\HttpsCertificate.pfx'`    
                 
 `Export-Certificate -Cert $HttpsCertificate -FilePath 'c:\\HttpsCertificate.cer'`                    
  
1.  Create and export the HGS signing certificate                          `$signingCert = New-SelfSignedCertificate -DnsName "Signing-$HgsServiceName.$env:userdnsdomain" -CertStoreLocation Cert:\\LocalMachine\\My`    
   
 `Export-PfxCertificate -Cert $signingCert -Password $certificatePassword -FilePath 'c:\\signingCert.pfx'`    
   
 `Export-Certificate -Cert $signingCert -FilePath 'c:\\signingCert.cer'`  
                                                                            
1.  Create and export the HGS encryption certificate                        
   
 `$encryptionCert = New-SelfSignedCertificate -DnsName "Encryption-$HgsServiceName.$env:userdnsdomain" -CertStoreLocation Cert:\\LocalMachine\\My`    
   
 `Export-PfxCertificate -Cert $encryptionCert -Password $certificatePassword -FilePath 'c:\\encryptionCert.pfx'`  
   
 `Export-Certificate -Cert $encryptionCert -FilePath 'c:\\encryptionCert.cer'`    
   
In order to register and deploy the server, you need to obtain the certificate thumbprints for the certificates that you’ll create, and also for the health attestation server signing certificate. The health attestation server signing certificate was created when the health attestation server was deployed. You will also need to create an SSL binding for the KPS server website.  
  
### 6.4  Initialize HGS server for Active Directory-based attestation   
```Initialize-HgsServer –HgsServiceName $HgsServiceName -EncryptionCertificateThumbprint $encryptionCert.Thumbprint -SigningCertificateThumbprint $signingCert.Thumbprint -CommunicationsCertificateThumbprint $signingCert.Thumbprint -TrustActiveDirectory -Force```  
  
>*Note: In the above command, you will reuse “signingCert” as a communication certificate, too. In a future build, we plan to remove the communication certificate parameter.*    
  
&nbsp;  
>*Note: If you want to use HTTPS encryption between the HGS and Hyper-V hosts, see Appendix B.*    
  
&nbsp;  
>**Note:** When you run the `Initialize-HgsServer` command to configure HgsServer, you will see following message: “There were issues while creating the clustered role that may prevent it from starting. For more information, view the report file below.”    
  
>When you view the report file, you will see the following warning message: “An appropriate disk was not fund for configuring disk witness. The cluster is not configured with quorum witness. As a best practice, configure a quorum witness to help achieve the high availability of the cluster.”    
  
>Open Failover Cluster manager and verify that the HgsClusterGroup role service is started and is running. If it is, you can ignore this warning message.  
  
#### 6.4.1  Configure name resolution between HGS domain and fabric domain  
  
In order to integrate the Host Guardian Service with your existing fabric Active Directory environment, you must verify that DNS name resolution is configured correctly. The requirements and steps needed for configuration will vary according to the type of attestation you’re using and the specifics of the fabric DNS implementation. To configure name resolution between the Host Guardian Service and the existing fabric:  
  
1.  Verify that the existing fabric environment where the Host Guardian Service is being installed is able to resolve the DNS name of the Host Guardian Service Active Directory domain. You can use any **one** of the following techniques. (This list is not intended to be exhaustive.)  
    1.  Create a stub zone of the Host Guardian Service domain’s zone.    
    2.  Create a secondary copy of the Host Guardian Service domain’s zone - If you choose to use a secondary zone, use the DNS Management Console on the Host Guardian Service server to enable the Host Guardian Service DNS zone for zone transfer.    
    3.  Create a conditional forwarder to the Host Guardian Service domain’s zone.    
      
  >*If you are planning to run HGS in a high availability configuration, you must specify more than one DNS server (for example, if you are running AD integrated DNS for an HGS domain, specify all of the DC IP addresses hosting DNS zone).*    
  
1.  Verify that the Host Guardian Service servers can resolve the Active Directory domain of the fabric environment where the Host Guardian Service is being installed.  
  
>**Note:** This final step is not necessary if you’re using TPM-based attestation.  
  
* Each Host Guardian Service server runs a local DNS Server instance. You need to configure each DNS server with at least two forwarders targeting the DNS servers in the existing environment.    
* Using a PowerShell command prompt on each of the Host Guardian Servers, type the following.  
  
`Add-DnsServerForwarder –IPAddress <Fabric DNS server 1>, <Fabric DNS server 2>`  
  
#### 6.4.2  Configure trust between the Host Guardian Service domain and fabric domain  
  
The Host Guardian Service Active Directory domain must trust the fabric Active Directory domain: one-way, cross-forest trust is all that is required. A cross-forest trust can be created using the Active Directory Domains and Trusts management console which you can run on any of the Host Guardian Service servers.  
  
`netdom trust <HostGuardianService domain> /domain:<fabric domain> /userD:<fabric domain>\Administrator /passwordD:<fabric domain administrator password> /add`  
  
e.g. ```netdom trust relecloud.com /domain:contoso.com /userD:contoso\\Administrator /passwordD:Pa\`$\`$w0rd /add```  
  
>**Note:** Cross-forest trusts are strongly recommended since they help verify that the authentication protocol used between the Host Guardian Service domain and the fabric domain is Kerberos. For test environments and simplicity, external trusts will also work.  
  
#### 6.4.3  Configure the Hyper-V host and fabric Active Directory for administrative-based attestation  
  
To complete the configuration of administrator-trusted fabric, add the trusted hosts (those that are trusted to run shielded VMs) into an Active Directory security group and configure the Host Guardian Service to accept all hosts that are members of that security group.  
  
1.  Use the following PowerShell cmdlet on any **fabric host or fabric domain controller** to install management tools:    
  ```Install-WindowsFeature RSAT-AD-PowerShell –IncludeManagementTools```    
1.  Use the following cmdlet to create a new security group in fabric domain:    
  ```New-ADGroup -Name ‘GuardedHosts’ -SamAccountName GuardedHosts -GroupCategory Security -GroupScope Global```    
1.  Type the following cmdlet to add hosts to the group:    
  ```Add-ADGroupMember -Identity GuardedHosts -Members GuardedHost1$, GuardedHost2$```    
1.  Type the following to display the group SID and note the value displayed for the next step:    
  ```$ADGroup = Get-ADGroup -Identity GuardedHosts```  
  
  ```$ADGroup.SID.Value```    
1.  Restart each host to refresh its group membership.  
  
>***Attestation of the Hyper-V host will not work until the servers are restarted.***  
  
#### 6.4.4  Configure the HGS attestation policy  
1.  On the server running the **Host Guardian Service**, open PowerShell and type the following to add the security group to the attestation policy:    
  ```Add-HgsAttestationHostGroup -Name ”GuardedHosts” -Identifier “<SID Value From Previous Step>”```  
  
  e.g. `Add-HgsAttestationHostGroup -Name ”GuardedHosts” -Identifier "S-1-5-21-595264435-4130452834-1504274847-1286”`  
    
### 6.5  Verify that the HGS server is configured correctly  
1.  Open one of the following URLs. If you are logged on locally, you can use localhost. If you are connecting remotely, you can use the fully qualified domain name. You should see an XML document.  
    
  [http://localhost/KeyProtection/service/metadata/2014-07/metadata.xml](http://localhost/KeyProtection/service/metadata/2014-07/metadata.xml)  
    
  [http://relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml](http://relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml)  
  
### 6.6  Configure the HGS for high availability  
To add an additional server in the HGS Server farm for high availability, install Windows Server 2016 Technical Preview 3.    
  
This server does not have to be joined to the newly installed HGS domain because as a part of the setup, it is joined to domain, promoted as an additional domain controller, and the HGS service role is installed and joined to existing HGS cluster.  
  
>*Verify that node you are going to add to the HGS farm can resolve a domain name query for the HGS domain to the first (or any existing) node that you previously installed.*  
  
1.  To add the Host Guardian Service role, use the following command:  
  
  ```Install-WindowsFeature –Name HostGuardianServiceRole –IncludeManagementTools```  
  
1.  To install the HGS, use the following command:  
  
  ```$adminPassword = ConvertTo-SecureString -AsPlainText '!!123abc' –Force```    
  
  ```$cred = get-credential 'relecloud\\administrator'```    
  ```[please input the password in windows credential prompt]```  
  
  ```$firstHgsServerIP = '192.168.51.30'```  
  
  ```$HgsdomainName = 'relecloud.com'```  
  
  ```$HgsServiceName = 'ADHgs'```  
  
  ```Install-HgsServer -HgsDomainName $HgsdomainName -HgsServerIPAddress $firstHgsServerIP -HgsDomainCredential $cred -SafeModeAdministratorPassword $adminPassword –restart –confirm:$false```  
  
  >*If you set up the initial node in the farm with HTTPS endpoints, be sure to include the HTTPS flags and certificate here, as outlined in Appendix B.*  
  
1.  Wait for the server to restart, and then sign in using the domain admin credentials.  
  
2.  Import the HGS certificates on each node from the first HGS server:  
  
  ```$certificatePassword = ConvertTo-SecureString -AsPlainText '!!123abc' –Force```  
  
  ```$HttpsCertificate = Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath '\\hgs01\c$\HttpsCertificate.pfx' -Password $certificatePassword```  
  
  ```$signing = Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath '\\hgs01\c$\signingCert.pfx' -Password $certificatePassword```  
  
  ```$encryption = Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath '\\hgs01\c$\encryptionCert.pfx' -Password $certificatePassword```  
  
1.  To Initialize the HGS server, use the following command:  
  
  ```$cred = get-credential 'relecloud\\administrator'```    
  ```[please input the password in windows credentail prompt]```  
  
  ```$firstHgsServerIP = '192.168.51.30'```  
  
  ```Initialize-HgsServer -HgsServerIPAddress $firstHgsServerIP -HgsDomainCredential $cred -TrustActiveDirectory -Confirm:$FALSE –Force```  
  
  ```Add-HgsKeyProtectionCertificate –Thumbprint $signing.Thumbprint```  
  
1.  Repeat the steps in this section for each additional HGS server node.