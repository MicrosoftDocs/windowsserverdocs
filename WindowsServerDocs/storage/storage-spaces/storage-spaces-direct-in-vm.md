Deploying Storage Spaces Direct in a Virtual Machine
====================================================

Storage Spaces Direct is a powerful and flexible technology that can enable a
breath of scenarios. In addition to deploying on bare-metal to create
hyper-converged or Scale-out File Server solutions, Storage Spaces Direct can
also be deployed in a virtual machine. This delivers virtual shared storage
across a set of VMs on top of a private or public cloud so that application high
availability solutions can be deployed to increase the SLA’s of applications.

![](media/7df3e97e0a6c0d988cc74ca4f7cd2e37.png)

Deploying in Azure Iaas VMs
---------------------------

[Azure
templates](https://github.com/robotechredmond/301-storage-spaces-direct-md) have
been published decrease the complexity, configure best practices, and speed of
your Storage Spaces Direct deployments in an Azure Iaas VM. This is the
recommended solution for deploying in Azure.

\<[embed video
link](https://channel9.msdn.com/Series/Microsoft-Hybrid-Cloud-Best-Practices-for-IT-Pros/Step-by-Step-Deploy-Windows-Server-2016-Storage-Spaces-Direct-S2D-Cluster-in-Microsoft-Azure?ocid=player)\>

\<iframe
src="https://channel9.msdn.com/Series/Microsoft-Hybrid-Cloud-Best-Practices-for-IT-Pros/Step-by-Step-Deploy-Windows-Server-2016-Storage-Spaces-Direct-S2D-Cluster-in-Microsoft-Azure/player"
width="960" height="540" allowFullScreen frameBorder="0"\>\</iframe\>

Considerations when Deploying Storage Spaces Direct in a VM
-----------------------------------------------------------

The following considerations apply when deploying Storage Spaces Direct in a
virtualized environment.  
Note: Azure templates will automatically configure the below considerations for
you and are the recommended solution when deploying in Azure IaaS VMs.

-   Minimum of 2 nodes and maximum of 3 nodes

-   2-node deployments must configure a witness (Cloud Witness or File Share
    Witness)

-   Configure the virtual machines to be deployed across fault domains

    -   Azure – Configure Availability Set

    -   Hyper-V – Configure AntiAffinityClassNames on the VMs to separate the
        VMs across nodes

    -   VMware – Configure VM-VM Anti-Affinity rule by Creating a DRS Rule of
        type ‘Separate Virtual Machines” to separate the VMs across ESX hosts

-   Leverage low latency / high performance storage

    -   Azure Premium Storage managed disks are required

-   Deploy a flat storage design with no Caching Devices configured

-   Minimum of 2 virtual data disks presented to each VM (VHD / VHDX / VMDK)

    -   This number is different than bare-metal deployments because the virtual
        "drives" are files which are not susceptible to physical failures

-   Disable the automatic drive replacement capabilities in the Health Service
    by running the following PowerShell cmdlet:

    -   Get-storagesubsystem clus\* \| set-storagehealthsetting -name
        “System.Storage.PhysicalDisk.AutoReplace.Enabled” -value “False”

-   Not Supported: Host level Virtual Disk snapshot/restore

    -   Leverage traditional guest level backup solutions to backup and restore
        the data on the Storage Spaces Direct volumes

-   To give greater resiliency to possible VHD storage latency, increase the
    spaces I/O timeout value:

>   HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\spaceport\\Parameters\\HwTimeout

dword:00002710

Additional Information:
-----------------------

Additional Azure Iaas VM templates for deploying Storage Spaces Direct, video’s,
and step-by-step guides can be found at [this
link](https://blogs.msdn.microsoft.com/clustering/2017/02/14/deploying-an-iaas-vm-guest-clusters-in-microsoft-azure/).
