<#########################################################################################################

File: Set-AadApp.ps1

Copyright (c) Microsoft Corp 2017.

.SYNOPSIS
Creates a web app in AAD. If the script is run on the Honolulu gateway, the script will also register the web app to the Honolulu gateway.

.DESCRIPTION
Create a web application in Azure AD with the name "ASR-Honolulu-<gateway>" (if one does not already exist) and add the application settings to Project 'Honolulu' to enable Azure Site Recovery.

This script requires internet connectivity and depends on Azure RM and Azure AD powershell modules.

If the Honolulu gateway server is internet connected: 
    Run this script **without any parameters** from the Honolulu gateway server. 

If the Honolulu gateway server does not have internet connectivity: 
    Run this script on any internet connected client with the required Azure modules (installation cmdlets below).
    Provide the Honolulu gateway server in the parameter -GatewayEndpoint 

Upon completion, the script will return the tenant ID where the app was created as well as the web app client ID.

This script depends on 2 powershell modules: Azure RM and Azure AD, to get them execute 2 following commands

PS C:\>Install-Module AzureRM
PS C:\>Install-Module AzureAD

.PARAMETER GatewayEndpoint
Optional
If not running locally on the Honolulu gateway server, provide the gateway endpoint name

.EXAMPLE
.\AsrHonoluluSetup.ps1                                                   #running on internet-connected Honolulu gateway
.\AsrHonoluluSetup.ps1 -GatewayEndpoint "https://gateway.contoso.com"    #not running on Honolulu gateway
#>

#Requires -Version 4.0
#Requires -Modules @{ModuleName="AzureRM.Resources";ModuleVersion="3.5.0.0"}
#Requires -Modules @{ModuleName="AzureRM.Storage";ModuleVersion="2.5.0.0"}
#Requires -Modules @{ModuleName="AzureAD";ModuleVersion="2.0.0.115"}

#########################################################################################################> 

param (
    [Parameter(Mandatory = $false)]
    [String]
    $GatewayEndpoint
)

# return access token with the resource ID pointing to AAD Graph endpoint
function Get-AadGraphApiToken
{
    param
    (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $TenantName
    )
    $PowerShellClientId = "1950a258-227b-4e31-a9cf-717495945fc2"
    $PowerShellRedirectUri = "urn:ietf:wg:oauth:2.0:oob"
    $ResourceAppIdURI = "https://graph.windows.net"
    $Authority = "https://login.windows.net/$TenantName"

    # Microsoft.IdentityModel.Clients should be already loaded
    $authContext = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext" -ArgumentList $Authority
    $authResult = $authContext.AcquireToken($ResourceAppIdURI, $PowerShellClientId, $PowerShellRedirectUri, "Auto")

    return $authResult.AccessToken
}

###################
# Setup & Module verification
###################

# Validate the AzureRM.profile module can be found.
$profileModule = Get-Module -Name AzureRM.profile -ListAvailable | Select-Object -First 1
if (!$profileModule) {
    throw "AzureRMProfile Module NotFound"
}
# Import and then store the AzureRM.profile module.
Write-Output "##[command]Import-Module -Name $($profileModule.Path) -Global"
$script:azureRMProfileModule = Import-Module -Name $profileModule.Path -Global -PassThru
Write-Verbose "Imported module version: $($script:azureRMProfileModule.Version)"

# Load "System.Web" assembly in PowerShell console
[Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null

$script:azureADModule = Import-Module -Name AzureAD -Global -PassThru
Write-Verbose "Imported module version: $($script:azureADModule.Version)"

###################
# Azure login and subscription selection
###################

Login-AzureRmAccount

# re-check that we actually logged in
$current_context = Get-AzureRmContext
if (!$current_context -or !(Get-Member -inputobject $current_context -name "Subscription" -Membertype Properties) -or !$current_context.Subscription)
{
    $err = "Please login using 'Login-AzureRmAccount'"
    throw $err
}

#Select Azure Subscription
$selectedSub = Get-AzureRmSubscription | Out-GridView -Title "Select an Azure Subscription ..." -PassThru
if($selectedSub.SubscriptionId) 
{
    $subscriptionId = $selectedSub.SubscriptionId
}
else {
     $subscriptionId = $selectedSub.Id
}  
if (!$selectedSub) 
{
    $err = "Cannot find selected subscription in Azure AD"
    throw $err
}


# get the context again, since we selected specific subscription
$current_context = Get-AzureRmContext
if ($script:azureRMProfileModule.Version -lt ([version]'3.0.0'))
{
    # get the unique subscription ID used to generate instance names or other metadata if it is not provided by enduser
    $subscription_id = $current_context.Subscription.SubscriptionId
    $tenant_id = $current_context.Tenant.TenantId
} else 
{
    # get the unique subscription ID used to generate instance names or other metadata if it is not provided by enduser
    $subscription_id = $current_context.Subscription.Id
    $tenant_id = $current_context.Tenant.Id
}

# now we need to login into AzureAD since it is using different token audience
$ad_tenant_info = $null
try {
    # check if we can get the tenant info, if we can then AzureAD has cached credentials
    # just continue to use them
    $ad_tenant_info = Get-AzureADTenantDetail -ErrorAction Continue
} catch
{
}

if (!$ad_tenant_info)
{
    #if no credentials were found then get the token from ADAL, usually it uses the cookie and will not prompt for credentials twice
    # since we already entered our credentials for Azure RM
    $ad_graph_api_token = Get-AadGraphApiToken $tenant_id

    #now pass this token to AzureAD powershell
    Connect-AzureAD -AadAccessToken $ad_graph_api_token -AccountId "1950a258-227b-4e31-a9cf-717495945fc2" -TenantId $tenant_id | Out-Null
}

#check if providers enabled in Azure subscription
$rm_provider_namespace_web = "Microsoft.Web"
$rm_provider = Get-AzureRmResourceProvider -ProviderNamespace $rm_provider_namespace_web -ErrorAction SilentlyContinue
if (($rm_provider -eq $null) -or ($rm_provider[0].RegistrationState -eq "NotRegistered")) {
    Register-AzureRmResourceProvider -ProviderNamespace  Microsoft.Web | Out-Null
}

$rm_provider_namespace_cert = "Microsoft.CertificateRegistration"
$rm_provider = Get-AzureRmResourceProvider -ProviderNamespace $rm_provider_namespace_cert -ErrorAction SilentlyContinue
if (($rm_provider -eq $null) -or ($rm_provider[0].RegistrationState -eq "NotRegistered")) {
    Register-AzureRmResourceProvider -ProviderNamespace  Microsoft.CertificateRegistration | Out-Null
}

#wait until resource providers are registered
$timeout = New-TimeSpan -Minutes 5
$sw = [diagnostics.stopwatch]::StartNew()
do {
$rm_provider_web = Get-AzureRmResourceProvider -ProviderNamespace $rm_provider_namespace_web 
$rm_provider_cert = Get-AzureRmResourceProvider -ProviderNamespace $rm_provider_namespace_cert
$registered = ($rm_provider_web[0].RegistrationState -eq "Registered") -and ($rm_provider_cert[0].RegistrationState -eq "Registered")
}
until ($registered -or ($sw.elapsed -gt $timeout))
if (!$registered){
    $err = "Couldn't register Azure RM Resource Providers"
    throw $err
}

###################
# Create AAD App
###################

# if script is running on the gateway, get port number from gateway reg key
if (!$GatewayEndpoint) {
    # Get port number
    $Port = (Get-ItemProperty -path HKLM:\SOFTWARE\Microsoft\ServerManagementGateway -Name "SmePort").SmePort
    if (!$Port) {
        Write-Warning "Configuration registry key not found.`nis Honolulu installed?"
        Exit
    }
    $GatewayEndpoint = "http://localhost:$Port"
} 

# generate the display names for web app in AAD
$app_display_name = "ASR-Honolulu-$GatewayEndpoint"

# build redirect and reply URLs for AAD Application
$redirect_url = "$GatewayEndpoint/"
$reply_urls = "$GatewayEndpoint/*"

$web_aad_app = Get-AzureRmADApplication -DisplayNameStartWith $app_display_name -Verbose

if (!$web_aad_app)
{
    Write-Output "Creating AAD Application $app_display_name ..."
    # get required resource access for the following Azure service principals
    $MsftWebApiSP = Get-AzureRmADServicePrincipal -ServicePrincipalName "Windows Azure Service Management API"
    $AadSP = Get-AzureRmADServicePrincipal -ServicePrincipalName "Microsoft.Azure.ActiveDirectory"
    
    $req1 = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
    ResourceAppId= $MsftWebApiSP.ApplicationId.Guid ;
    ResourceAccess=[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "41094075-9dad-400e-a0bd-54e686782033"; #access scope: Delegated permission to Access Azure Service Management as organization users 
    Type = "Scope"}} ;
    
    $req2 = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
    ResourceAppId= $AadSP.ApplicationId.Guid ;
    ResourceAccess=[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "311a71cc-e848-46a1-bdf8-97ff7156d8e6"; #access scope: Delegated permission to sign in and read user profile
    Type = "Scope"}}
    
    $web_aad_app = New-AzureADApplication -DisplayName $app_display_name -IdentifierUris $redirect_url -ReplyUrls $reply_urls -Oauth2AllowImplicitFlow $true -RequiredResourceAccess $req1, $req2

    # re-fetch the client app after creation
    $web_aad_app = Get-AzureRmADApplication -DisplayNameStartWith $app_display_name -Verbose

    if (!$web_aad_app)
    {
        $err = "Cannot create application '$app_display_name' in Azure AD"
        write-warning $err
        throw $err
    } else {
        Write-Output "Successfully created AAD Application $app_display_name"
    }

    # we need to sleep for a while to make sure AAD is update
    Sleep 20
} else {
    Write-Output "AAD Application already exists for $app_display_name. Application not created"
}


#############################
# Register AAD App with Honolulu Gateway if script is running on the gateway
# Else output Set-AadApp.ps1 parameters.
#############################
$client_id = $web_aad_app.ApplicationId.Guid.ToString()

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

$url = "$GatewayEndpoint/api/siterecovery/aadappConfig";
$body=@"
{'properties':{
            'tenant': '$tenant_id',
            'clientId': '$client_id'
        }
}
"@;

$response = Invoke-WebRequest -Uri $url -Body $body -Method Put -UseDefaultCredentials -UseBasicParsing
if ($response.StatusCode -eq 200 ) 
{
    Write-Output 'AAD Application successfully registered with Honolulu Gateway'
}


Write-Output "ASR Honolulu Setup Complete `nTenant ID: $tenant_id `nClient ID: $client_id"