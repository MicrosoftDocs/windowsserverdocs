# Configure the fabric DNS for guarded hosts

>Applies To: Windows Server 2016

A fabric administrator needs to configure the fabric DNS takes to allow guarded hosts to resolve the HGS cluster. 
The HGS cluster must already be [set up by the HGS administrator](/WindowsServerDocs/virtualization/guarded-fabric-shielded-vm/guarded-fabric-setting-up-the-host-guardian-service-hgs.md).

There are many ways to configure name resolution for the fabric domain. 
One simple way is to set up a conditional forwarder zone in DNS for the fabric. 
To set up this zone, run the following commands in an elevated Windows PowerShell console on a fabric DNS server. 
Substitute the names and addresses in the Windows PowerShell syntax below as needed for your environment. 
Add master servers for the additional HGS nodes.

    Add-DnsServerConditionalForwarderZone -Name <HGS domain name> -ReplicationScope "Forest" -MasterServers <IP addresses of HGS server>

<!-- Appears in guarded-fabric-setting-up-the-host-guardian-service-hgs.md and guarded-fabric-troubleshoot-diagnostics.md
-->    