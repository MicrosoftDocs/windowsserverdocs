---
title: AD FS Troubleshooting - Users can't log in using AD FS from an external network
description: Learn how to troubleshoot various aspects of AD FS log in from an extranet.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 10/14/2024
ms.topic: article
---

# Users can't log in using AD FS from an external network
This document helps to resolve sign-in issues with Active Directory Federation Services (AD FS) from an external network. Use this document if users aren't able to authenticate using AD FS from outside corpnet. This would usually include authentications occurring via the Web Application Proxy (WAP).

## Check extranet access
We'll now check extranet access. Let's first make sure that we're able to authenticate to the AD FS servers from WAP

IdpInitiatedSignOn can quickly verify if the AD FS service is up and running, and authentication is working correctly.

If your running AD FS on Windows Server 2016, you must enable IdpInitiatedSignOn manually:

 1. Log into the primary AD FS server
 2. Open PowerShell
 3. Run Set-AdfsProperties -EnableIdPInitiatedSignonPage $true

In order to verify AD FS service using IdpinitiatedSignOn follow these steps:

 1. Log into the WAP machine you want to test
 2. Open a private browser session
 3. Go to https://&lt;federation service fqdn&gt;/adfs/ls/idpinitiatedsignon.asp For example, https://fs.contoso.com/adfs/ls/idpinitiatedsignon.aspx
 4. Enter the credentials of a valid user on the log in page

A successful sign-in is indicated by the message "Your signed in".

## Check Network Settings
Check DNS and any load balancer settings.

### DNS and network checks for external access

If you have Web Application Proxy (WAP) servers

- Ping the federation service name e.g. fs.contoso.com and confirm if the IP address that it resolves to is one of the WAP servers or the load balancer in front of the WAP servers.
- In the DNS server hosting the service name externally, check that there's an A record for the federation service (e.g. fs.contoso.com) pointing to the WAP server or load balancer in front of the WAP servers

### Load Balancer

- Check that the firewall isn't blocking traffic between AD FS and the load balancer, and between WAP and the load balancer
- If probe is enabled
- If your running Windows Server 2012 R2, confirm that the August 2014 Windows Server 2012 R2 Update rollup (KB.2975719) is installed
- Check if port 80 is enabled in the firewall on the WAP and AD FS servers
- Ensure that probe is set for port 80 and endpoint /adfs/probe

### Firewall

Both the firewall located between the Web Application Proxy and the federation server farm and the firewall between the clients and the Web Application Proxy must have TCP port 443 enabled inbound.

In addition, if client user certificate authentication (clientTLS authentication using X509 user certificates) is required, AD FS in Windows Server 2012 R2 requires that TCP port 49443 be enabled inbound on the firewall between the clients and the Web Application Proxy. This isn't required on the firewall between the Web Application Proxy and the federation servers.

## Check if endpoint is enabled
AD FS provides various endpoints for different functionalities and scenarios. Not all endpoints are enabled by default. To check if a particular endpoint is enabled or disabled:

 1. Log into the AD FS server
 2. Open AD FS Management
 3. In the left navigation pane, select Service > Endpoints
 4. In the right pane, scroll to the endpoint that needs to be checked (usually /adfs/ls and /adfs/oauth2)
 5. Verify that the endpoint is enabled. For example, if oAuth log ins are failing, check if /adfs/oauth endpoint is marked as "Yes" under ProxyEnabled

## Check for WAP trust issues
Go to each WAP server and run the diagnostic PowerShell script that you downloaded from AD FS Help Downloadable Tools. Fix any errors reported.

Then log into the primary AD FS server to see if there are any issues with bindings or trust certificates. Run the script given below on the primary AD FS server.

```powershell
param
(
  [switch]$syncproxytrustcerts = $TRUE
)
function checkhttpsyscertbindings()
{
Write-Host; Write-Host("1 Checking http.sys certificate bindings for potential issues")
$httpsslcertoutput = netsh http show sslcert
$adfsservicefqdn = (Get-AdfsProperties).HostName
$i = 1
$certbindingissuedetected = $FALSE
while($i -lt $httpsslcertoutput.count)
{
        $ipport = $FALSE
        $hostnameport = $FALSE
        if ( ( $httpsslcertoutput[$i] -match "IP:port" ) ) { $ipport = $TRUE }
        elseif ( ( $httpsslcertoutput[$i] -match "Hostname:port" ) ) { $hostnameport = $TRUE }
        # Check for IP specific certificate bindings
        if ( ( $ipport -eq $TRUE ) )
        {
            $httpsslcertoutput[$i]
            $ipbindingparsed = $httpsslcertoutput[$i].split(":")
            if ( ( $ipbindingparsed[2].trim() -ne "0.0.0.0" ) -and ( $ipbindingparsed[3].trim() -eq "443") )
            {
                $warning = "There's an IP specific binding on IP " + $ipbindingparsed[2].trim() + " which may conflict with the AD FS port 443 cert binding." | Write-Warning
                $certbindingissuedetected = $TRUE
            }
           
            $i = $i + 14
            continue
        }
        # check that CTL Store is set for ADFS service binding
        elseif ( $hostnameport -eq $TRUE )
        {
            $httpsslcertoutput[$i]
            $ipbindingparsed = $httpsslcertoutput[$i].split(":")
            if ( ( $ipbindingparsed[2].trim() -eq $adfsservicefqdn ) -and ( $ipbindingparsed[3].trim() -eq "443") -and ( $httpsslcertoutput[$i+10].split(":")[1].trim() -ne "AdfsTrustedDevices" ) )
            {
                Write-Warning "ADFS Service binding doesn't have CTL Store Name set to AdfsTrustedDevices"
                $certbindingissuedetected = $TRUE
            }
        $i = $i + 14
        continue
        }
    $i++
}
if ( $certbindingissuedetected -eq $FALSE ) { Write-Host "Check Passed: No certificate binding issues detected" }
}

function checkadfstrusteddevicesstore()
{
# check for CA issued (non-self signed) certs in the AdfsTrustedDevices cert store
Write-Host; Write-Host "2 Checking AdfsTrustedDevices cert store for non-self signed certificates"
$certlist = Get-Childitem cert:\LocalMachine\AdfsTrustedDevices -recurse | Where-Object {$_.Issuer -ne $_.Subject}
if ( $certlist.count -gt 0 )
{
    Write-Warning "The following non-self signed certificates are present in the AdfsTrustedDevices store and should be removed"
    $certlist | Format-List Subject
}
else { Write-Host "Check Passed: No non-self signed certs present in AdfsTrustedDevices cert store" }
}

function checkproxytrustcerts
{
    param ([bool]$repair=$FALSE)
    Write-Host; Write-Host("3 Checking AdfsTrustedDevices cert store is in sync with ADFS Proxy Trust config")
    $doc = new-object Xml
    $doc.Load("$env:windir\ADFS\Microsoft.IdentityServer.Servicehost.exe.config")
    $connString = $doc.configuration.'microsoft.identityServer.service'.policystore.connectionString
    $command = "Select ServiceSettingsData from [IdentityServerPolicy].[ServiceSettings]"
    $cli = new-object System.Data.SqlClient.SqlConnection
    $cli.ConnectionString = $connString
    $cmd = new-object System.Data.SqlClient.SqlCommand
    $cmd.CommandText = $command
    $cmd.Connection = $cli
    $cli.Open()
    $configString = $cmd.ExecuteScalar()
    $configXml = new-object XML
    $configXml.LoadXml($configString)
    $rawCerts = $configXml.ServiceSettingsData.SecurityTokenService.ProxyTrustConfiguration._subjectNameIndex.KeyValueOfstringArrayOfX509Certificate29zVOn6VQ.Value.X509Certificate2
    #$ctl = dir cert:\LocalMachine\ADFSTrustedDevices
    $store = new-object System.Security.Cryptography.X509Certificates.X509Store("ADFSTrustedDevices","LocalMachine")
    $store.open("MaxAllowed")
    $atLeastOneMismatch = $FALSE
    $badCerts = @()
    foreach($rawCert in $rawCerts)
    {   
        $rawCertBytes = [System.Convert]::FromBase64String($rawCert.RawData.'#text')
        $cert=New-Object System.Security.Cryptography.X509Certificates.X509Certificate2(,$rawCertBytes)
        $now = Get-Date
        if ( ($cert.NotBefore -lt $now) -and ($cert.NotAfter -gt $now))
        {
            $certThumbprint = $cert.Thumbprint
         $certSubject = $cert.Subject
         $ctlMatch = dir cert:\localmachine\ADFSTrustedDevices\$certThumbprint -ErrorAction SilentlyContinue
         if ($ctlMatch -eq $null)
         {
       $atLeastOneMismatch = $TRUE
          Write-Warning "This cert isn't in the CTL: $certThumbprint – $certSubject"
   
       if ($repair -eq $TRUE)
       {
        write-Warning "Attempting to repair"
        $store.Add($cert)
        Write-Warning "Repair successful"
       }
                else
                {
                    Write-Warning ("Please install KB.2964735 or re-run script with -syncproxytrustcerts switch to add missing Proxy Trust certs to AdfsTrustedDevices cert store")
                }
   
         }
        }
    }
    $store.Close()
 
    if ($atLeastOneMismatch -eq $FALSE)
    {
     Write-Host("Check Passed: No mismatched certs found. CTL is in sync with DB content")
    }
}
checkhttpsyscertbindings
checkadfstrusteddevicesstore
checkproxytrustcerts($syncproxytrustcerts)
Write-Host; Write-Host("All checks completed.")
```   

## Perform a detailed WAP check
We'll need to do some detailed checks. We'll now check if the trust between WAP and AD FS is working as expected.

The proxy trust relationship between a Web Application Proxy server and the AD FS 2012 R2 server is client certificate based. When the Web Application Proxy post-install wizard is run, a self-signed Client Certificate is generated and inserted into the AD FS configuration store using the credentials specified in the wizard. AD FS also propagates this to the AdfsTrustedDevices certificate store on the AD FS server.

During any SSL communication, HTTP.sys uses the following priority order for its SSL bindings

 1. IP, Port binding (Exact IP and port match)
 2. SNI (Exact hostname match)
 3. CCS (Invoke Central Certificate Store)
 4. IPV6 Wildcard (IPv6 wildcard match connection must be IPv6
 5. IP Wildcard IP wildcard match (connection can be IPv4 or IPv6)

### Is there a specific IPAddress:Port mapping?

As mentioned above, the IP:Port mapping is of the highest precedence. Therefore, if there exists an IP:Port binding, then that is the certificate that will be used by HTTP.sys all the time for SSL communication.

#### Remove the specific IP:port binding

Be sure to check that the binding doesn't come back. If there's an application configured with such a binding, it may re-create this automatically or on next service start-up.

#### Use an additional IP address for AD FS traffic

If the IP:Port binding is expected and required, then using a 2nd IP such as 1.2.3.5 for ADFS and resolving the ADFS service FQDN to this IP address would mean that the Hostname:port bindings would then be used.

#### Configure the AdfsTrustedDevices store as the Ctl Store for the specific IP:port binding

This will again have some dependence on why the specific IP:port binding is there and if this relies on the default CTL Store for client certificate authentication. But an option would be to set the Ctl Store on the IP:port binding to be the AdfsTrustedDevices store.

How to check current SSL certificate bindings

Log into AD FS server
Open PowerShell
Run netsh http show sslcert
C:\Users\administrator.CONTOSO> netsh http show sslcert

SSL Certificate bindings:

————————-

Hostname:port: adfs.contoso.com:443

Certificate Hash: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Application ID: {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}

Certificate Store Name: MY

Verify Client Certificate Revocation: Enabled

Verify Revocation Using Cached Client Certificate Only: Disabled

Usage Check: Enabled

Revocation Freshness Time: 0

URL Retrieval Timeout: 0

Ctl Identifier: (null)

Ctl Store Name: AdfsTrustedDevices

DS Mapper Usage: Disabled

Negotiate Client Certificate: Disabled

#### Is CTL store name AdfsTrustedDevices?

If the user has Microsoft Entra Connect Sync installed, use AAD Connect to update the SSL certificate bindings on all servers. If there's no Microsoft Entra Connect Sync server in the environment, use the following PowerShell cmdlet to regenerate the ADFS Certificate bindings on the AD FS server:

Set-AdfsSslCertificate -Thumbprint &lt;thumbprint&gt;

#### Is CA issued certificate in ADFSTrustedDevices store?

The AdfsTrustedDevices store should only contain the MS-Organization-Access certificate which is the self-signed cert used for issuing Workplace Join certificates, and the Proxy Trust certificates for each of the Web Application Proxy servers. Having a CA Issued certificate in a store where only Self-Signed certs would normally exist affects the CTL generated from this store and the CTL will then only contain the CA Issued certificate.

Delete the non-self signed SSL server certificate from the AdfsTrustedDevices store

#### Is there a time skew between AD FS and WAP servers?

Ensure that there's no time skew between the AD FS and WAP Servers

#### SSL Termination between AD FS and WAP?

If SSL termination is happening on a network device between AD FS servers and WAP, then the communication between AD FS and WAP will break because the WAP and AD FS communication is based on client certificates.

Disable SSL termination on the network device in between the AD FS and WAP servers

#### Manually sync proxy trust certificates from config to ADFSTrustedDevices

Use the script at the end of the section to manually sync the WAP certificates from AD FS configuration to ADFSTrustedDevices store. Execute the following








## Related links

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)