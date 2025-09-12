---
title: AD FS Troubleshooting - Users Can't Sign in by Using AD FS from an External Network
description: Learn how to troubleshoot various aspects of Active Directory Federation Services (AD FS) sign-in from an extranet.
ms.date: 10/14/2024
ms.topic: troubleshooting-general
---

# Users can't sign in by using AD FS from an external network

This article helps to resolve sign-in issues with Active Directory Federation Services (AD FS) from an external network. Use this article if users can't authenticate by using AD FS from an outside corporate network.

## Check extranet access

Check to see if you can authenticate to the AD FS servers from Web Application Proxy (WAP).

The `IdpInitiatedSignOn` parameter can quickly verify if AD FS is up and running, and if authentication is working correctly.

If you're running AD FS on Windows Server 2016, you must enable `IdpInitiatedSignOn` manually:

 1. Sign in to the primary AD FS server.
 1. Open PowerShell.
 1. Run `Set-AdfsProperties -EnableIdPInitiatedSignonPage $true`.

To verify that AD FS is using `IdpinitiatedSignOn`, follow these steps:

 1. Sign in to the WAP machine you want to test.
 1. Open a private browser session.
 1. Go to `https://&lt;federation service fqdn&gt;/adfs/ls/idpinitiatedsignon.asp`. An example is `https://fs.contoso.com/adfs/ls/idpinitiatedsignon.aspx`.
 1. Enter the credentials of a valid user on the sign-in page.

## Check network settings

Check Domain Name System (DNS) and any load balancer settings.

### DNS and network checks for external access

If you have WAP servers:

- Ping the federation service name. Confirm that the IP address that it resolves to is one of the WAP servers or the load balancer in front of the WAP servers.
- If the DNS server is hosting the service name externally, check that there's an A record for the federation service pointing to the WAP server or load balancer in front of the WAP servers.

### Load balancer

- Check that the firewall isn't blocking traffic between AD FS and the load balancer, and between the WAP and the load balancer.
- Check if the probe is enabled.
- Check if you're running Windows Server 2012 R2. Confirm that the August 2014 Windows Server 2012 R2 Update rollup (KB.2975719) is installed.
- Check if port 80 is enabled in the firewall on the WAP and AD FS servers.
- Ensure that the probe is set for port 80 and the endpoint `/adfs/probe`.

### Firewall

Both the firewall located between the WAP and the federation server farm and the firewall between the clients and the WAP must have TCP port 443 enabled inbound.

## Check if the endpoint is enabled

AD FS provides various endpoints for different functionalities and scenarios. Not all endpoints are enabled by default. To check if a particular endpoint is enabled or disabled:

 1. Sign in to the AD FS server.
 1. Open **AD FS Management**.
 1. On the left pane, select **Service** > **Endpoints**.
 1. On the right pane, scroll to the endpoint that needs to be checked (usually `/adfs/ls` and `/adfs/oauth2`).
 1. Verify that the endpoint is enabled. For example, if oAuth sign-ins are failing, check if the `/adfs/oauth` endpoint is marked as `Yes` under `ProxyEnabled`.

## Check for WAP trust issues

Go to each WAP server and run the diagnostic PowerShell script that you downloaded from the [AD FS Offline tools](../operations/offline-tools.md).

Sign in to the primary AD FS server to see if there are any issues with bindings or trust certificates. Run the following script on the primary AD FS server:

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
# Check for CA-issued (non-self-signed) certificates in the AdfsTrustedDevices certificate store
Write-Host; Write-Host "2 Checking AdfsTrustedDevices cert store for nonself signed certificates"
$certlist = Get-Childitem cert:\LocalMachine\AdfsTrustedDevices -recurse | Where-Object {$_.Issuer -ne $_.Subject}
if ( $certlist.count -gt 0 )
{
    Write-Warning "The following nonself signed certificates are present in the AdfsTrustedDevices store and should be removed"
    $certlist | Format-List Subject
}
else { Write-Host "Check Passed: No nonself signed certs present in AdfsTrustedDevices cert store" }
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

The proxy trust relationship between a WAP server and the AD FS 2012 R2 server is based on client certificates. When you run the WAP post-install wizard, a self-signed client certificate is generated and inserted into the AD FS configuration store by using the credentials specified in the wizard. AD FS also propagates this certificate to the `AdfsTrustedDevices` certificate store on the AD FS server.

During any Transport Layer Security/Secure Sockets Layer (TLS/SSL) communication, `HTTP.sys` uses the following priority order for its TLS/SSL bindings:

 - **IP Port binding**: Exact IP and port match.
 - **SNI**: Exact hostname match.
 - **CCS**: Invoke Central Certificate Store.
 - **IPV6 wildcard**: IPv6 wildcard match connection must be IPv6.
 - **IP wildcard match**: Connection can be IPv4 or IPv6.

### Is there a specific IPAddress:Port mapping?

The `IP:Port mapping` is of the highest precedence. If an `IP:Port` binding exists, that's the certificate that's used by `HTTP.sys` all the time for TLS/SSL communication.

#### Remove the specific IP:port binding

Check that the binding doesn't come back. If an application is configured with such a binding, it might re-create this issue automatically or on the next service start-up.

#### Use an added IP address for AD FS traffic

If the `IP:Port` binding is expected and required, then using a second IP such as 1.2.3.5 for AD FS and resolving the AD FS service FQDN to this IP address means that the `Hostname:port` bindings are used.

#### Configure the AdfsTrustedDevices store as the CTL store for the specific IP:port binding

This step has some dependence on why the specific `IP:port` binding is there and if this step relies on the default Certificate Trust List (CTL) store for client certificate authentication. An option is to set the CTL store on the `IP:port` binding to be the `AdfsTrustedDevices` store.

How to check current TLS/SSL certificate bindings:

1. Sign in to the AD FS server.
1. Open PowerShell.
1. Run `netsh http show sslcert`. See `C:\Users\administrator.CONTOSO> netsh http show sslcert`.

```  
 SSL Certificate bindings:


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
```  

#### Is the CTL store name AdfsTrustedDevices?

If the user has Microsoft Entra Connect Sync installed, use the Microsoft Entra Connect Sync server to update the TLS/SSL certificate bindings on all servers. If no Microsoft Entra Connect Sync server is in the environment, use the following PowerShell cmdlet to regenerate the AD FS certificate bindings on the AD FS server:

`Set-AdfsSslCertificate -Thumbprint &lt;thumbprint&gt;`

#### Is a CA-issued certificate in the AdfsTrustedDevices store?

The `AdfsTrustedDevices` store should contain only the MS-Organization-Access certificate, which is the self-signed certificate used for issuing Workplace Join certificates, and the Proxy Trust certificates for each of the WAP servers. Having a certificate issued by a Certificate Authority (CA) in a store where only self-signed certificates normally exist affects the CTL generated from this store. The CTL then contains only the CA-issued certificate.

Delete the non-self-signed TLS/SSL server certificate from the `AdfsTrustedDevices` store.

#### Is there a time skew between the AD FS and WAP servers?

Ensure that there's no time skew between the AD FS and WAP servers.

#### Is there a TLS/SSL termination between the AD FS and WAP servers?

If TLS/SSL termination is happening on a network device between AD FS servers and WAP, the communication between AD FS and WAP breaks because the WAP and AD FS communication is based on client certificates.

Disable TLS/SSL termination on the network device in between the AD FS and WAP servers.

#### Manually sync proxy trust certificates from config to AdfsTrustedDevices

Use the script at the end of the section to manually sync the WAP certificates from AD FS configuration to the `AdfsTrustedDevices` store.

## Related content

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)
- [AD FS offline tools](../operations/offline-tools.md)
