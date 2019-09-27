---
title: Health Service faults
ms.prod: windows-server
manager: eldenc
ms.author: cosdar
ms.technology: storage-health-service
ms.topic: article
ms.assetid:
author: cosmosdarwin
ms.date: 10/05/2017
---

# Health Service faults
> Applies to: Windows Server 2019, Windows Server 2016

## What are faults

The Health Service constantly monitors your Storage Spaces Direct cluster to detect problems and generate "faults". One new cmdlet displays any current faults, allowing you to easily verify the health of your deployment without looking at every entity or feature in turn. Faults are designed to be precise, easy to understand, and actionable.  

Each fault contains five important fields:  

-   Severity
-   Description of the problem
-   Recommended next step(s) to address the problem
-   Identifying information for the faulting entity
-   Its physical location (if applicable)

For example, here is a typical fault:  

```
Severity: MINOR                                         
Reason: Connectivity has been lost to the physical disk.                           
Recommendation: Check that the physical disk is working and properly connected.    
Part: Manufacturer Contoso, Model XYZ9000, Serial 123456789                        
Location: Seattle DC, Rack B07, Node 4, Slot 11
```

 >[!NOTE]
 > The physical location is derived from your fault domain configuration. For more information about fault domains, see [Fault Domains in Windows Server 2016](fault-domains.md). If you do not provide this information, the location field will be less helpful - for example, it may only show the slot number.  

## Root cause analysis

The Health Service can assess the potential causality among faulting entities to identify and combine faults which are consequences of the same underlying problem. By recognizing chains of effect, this makes for less chatty reporting. For example, if a server is down, it is expected than any drives within the server will also be without connectivity. Therefore, only one fault will be raised for the root cause - in this case, the server.  

## Usage in PowerShell

To see any current faults in PowerShell, run this cmdlet:

```PowerShell
Get-StorageSubSystem Cluster* | Debug-StorageSubSystem  
```

This returns any faults which affect the overall Storage Spaces Direct cluster. Most often, these faults relate to hardware or configuration. If there are no faults, this cmdlet will return nothing.  

>[!NOTE]
> In a non-production environment, and at your own risk, you can experiment with this feature by triggering faults yourself - for example, by removing one physical disk or shutting down one node. Once the fault has appeared, re-insert the physical disk or restart the node and the fault will disappear again.

You can also view faults that are affecting only specific volumes or file shares with the following cmdlets:  

```PowerShell
Get-Volume -FileSystemLabel <Label> | Debug-Volume  

Get-FileShare -Name <Name> | Debug-FileShare  
```

This returns any faults that affect only the specific volume or file share. Most often, these faults relate to capacity planning, data resiliency, or features like Storage Quality-of-Service or Storage Replica. 

## Usage in .NET and C#

### Connect

In order to query the Health Service, you will need to establish a **CimSession** with the cluster. To do so, you will need some things that are only available in full .NET, meaning you cannot readily do this directly from a web or mobile app. These code samples will use C\#, the most straightforward choice for this data access layer.

``` 
...
using System.Security;
using Microsoft.Management.Infrastructure;

public CimSession Connect(string Domain = "...", string Computer = "...", string Username = "...", string Password = "...")
{
    SecureString PasswordSecureString = new SecureString();
    foreach (char c in Password)
    {
        PasswordSecureString.AppendChar(c);
    }

    CimCredential Credentials = new CimCredential(
        PasswordAuthenticationMechanism.Default, Domain, Username, PasswordSecureString);
    WSManSessionOptions SessionOptions = new WSManSessionOptions();
    SessionOptions.AddDestinationCredentials(Credentials);
    Session = CimSession.Create(Computer, SessionOptions);
    return Session;
}
```

The provided Username should be a local Administrator of the target Computer.

It is recommended that you construct the Password **SecureString** directly from user input in real-time, so their password is never stored in memory in cleartext. This helps mitigate a variety of security concerns. But in practice, constructing it as above is common for prototyping purposes.

### Discover objects

With the **CimSession** established, you can query Windows Management Instrumentation (WMI) on the cluster.

Before you can get Faults or Metrics, you will need to get instances of several relevant objects. First, the **MSFT\_StorageSubSystem** which represents Storage Spaces Direct on the cluster. Using that, you can get every **MSFT\_StorageNode** in the cluster, and every **MSFT\_Volume**, the data volumes. Finally, you will need the **MSFT\_StorageHealth**, the Health Service itself, too.

```
CimInstance Cluster;
List<CimInstance> Nodes;
List<CimInstance> Volumes;
CimInstance HealthService;

public void DiscoverObjects(CimSession Session)
{
    // Get MSFT_StorageSubSystem for Storage Spaces Direct
    Cluster = Session.QueryInstances(@"root\microsoft\windows\storage", "WQL", "SELECT * FROM MSFT_StorageSubSystem")
        .First(Instance => (Instance.CimInstanceProperties["FriendlyName"].Value.ToString()).Contains("Cluster"));

    // Get MSFT_StorageNode for each cluster node
    Nodes = Session.EnumerateAssociatedInstances(Cluster.CimSystemProperties.Namespace,
        Cluster, "MSFT_StorageSubSystemToStorageNode", null, "StorageSubSystem", "StorageNode").ToList();

    // Get MSFT_Volumes for each data volume
    Volumes = Session.EnumerateAssociatedInstances(Cluster.CimSystemProperties.Namespace,
        Cluster, "MSFT_StorageSubSystemToVolume", null, "StorageSubSystem", "Volume").ToList();

    // Get MSFT_StorageHealth itself
    HealthService = Session.EnumerateAssociatedInstances(Cluster.CimSystemProperties.Namespace,
        Cluster, "MSFT_StorageSubSystemToStorageHealth", null, "StorageSubSystem", "StorageHealth").First();
}
```

These are the same objects you get in PowerShell using cmdlets like **Get-StorageSubSystem**, **Get-StorageNode**, and **Get-Volume**.

You can access all the same properties, documented at [Storage Management API Classes](https://msdn.microsoft.com/library/windows/desktop/hh830612(v=vs.85).aspx).

```
...
using System.Diagnostics;

foreach (CimInstance Node in Nodes)
{
    // For illustration, write each node's Name to the console. You could also write State (up/down), or anything else!
    Debug.WriteLine("Discovered Node " + Node.CimInstanceProperties["Name"].Value.ToString());
}
```

### Query faults

Invoke **Diagnose** to get any current faults scoped to the target **CimInstance**, which be the cluster or any volume.

The complete list of faults available at each scope in Windows Server 2016 is documented below.

```       
public void GetFaults(CimSession Session, CimInstance Target)
{
    // Set Parameters (None)
    CimMethodParametersCollection FaultsParams = new CimMethodParametersCollection();
    // Invoke API
    CimMethodResult Result = Session.InvokeMethod(Target, "Diagnose", FaultsParams);
    IEnumerable<CimInstance> DiagnoseResults = (IEnumerable<CimInstance>)Result.OutParameters["DiagnoseResults"].Value;
    // Unpack
    if (DiagnoseResults != null)
    {
        foreach (CimInstance DiagnoseResult in DiagnoseResults)
        {
            // TODO: Whatever you want!
        }
    }
}
```

### Optional: MyFault class

It may make sense for you to construct and persist your own representation of faults. For example, this **MyFault** class stores several key properties of faults, including the **FaultId**, which can be used later to associate update or remove notifications, or to deduplicate in the event that the same fault is detected multiple times, for whatever reason.

```       
public class MyFault {
    public String FaultId { get; set; }
    public String Reason { get; set; }
    public String Severity { get; set; }
    public String Description { get; set; }
    public String Location { get; set; }

    // Constructor
    public MyFault(CimInstance DiagnoseResult)
    {
        CimKeyedCollection<CimProperty> Properties = DiagnoseResult.CimInstanceProperties;
        FaultId     = Properties["FaultId"                  ].Value.ToString();
        Reason      = Properties["Reason"                   ].Value.ToString();
        Severity    = Properties["PerceivedSeverity"        ].Value.ToString();
        Description = Properties["FaultingObjectDescription"].Value.ToString();
        Location    = Properties["FaultingObjectLocation"   ].Value.ToString();
    }
}
```

```
List<MyFault> Faults = new List<MyFault>;

foreach (CimInstance DiagnoseResult in DiagnoseResults)
{
    Faults.Add(new Fault(DiagnoseResult));
}
```

The complete list of properties in each fault (**DiagnoseResult**) is documented below.

### Fault events

When Faults are created, removed, or updated, the Health Service generates WMI events. These are essential to keeping your application state in sync without frequent polling, and can help with things like determining when to send email alerts, for example. To subscribe to these events, this sample code uses the Observer Design Pattern again.

First, subscribe to **MSFT\_StorageFaultEvent** events.

```      
public void ListenForFaultEvents()
{
    IObservable<CimSubscriptionResult> Events = Session.SubscribeAsync(
        @"root\microsoft\windows\storage", "WQL", "SELECT * FROM MSFT_StorageFaultEvent");
    // Subscribe the Observer
    FaultsObserver<CimSubscriptionResult> Observer = new FaultsObserver<CimSubscriptionResult>(this);
    IDisposable Disposeable = Events.Subscribe(Observer);
}   
```

Next, implement an Observer whose **OnNext()** method will be invoked whenever a new event is generated.

Each event contains **ChangeType** indicating whether a fault is being created, removed, or updated, and the relevant **FaultId**.

In addition, they contain all the properties of the fault itself.

```
class FaultsObserver : IObserver
{
    public void OnNext(T Event)
    {
        // Cast
        CimSubscriptionResult SubscriptionResult = Event as CimSubscriptionResult;

        if (SubscriptionResult != null)
        {
            // Unpack            
            CimKeyedCollection<CimProperty> Properties = SubscriptionResult.Instance.CimInstanceProperties;
            String ChangeType = Properties["ChangeType"].Value.ToString();
            String FaultId = Properties["FaultId"].Value.ToString();

            // Create
            if (ChangeType == "0")
            {
                Fault MyNewFault = new MyFault(SubscriptionResult.Instance);
                // TODO: Whatever you want!
            }
            // Remove
            if (ChangeType == "1")
            {
                // TODO: Use FaultId to find and delete whatever representation you have...
            }
            // Update
            if (ChangeType == "2")
            {
                // TODO: Use FaultId to find and modify whatever representation you have...
            }
        }
    }
    public void OnError(Exception e)
    {
        // Handle Exceptions
    }
    public void OnCompleted()
    {
        // Nothing
    }
}
```

### Understand fault lifecycle

Faults are not intended to be marked "seen" or resolved by the user. They are created when the Health Service observes a problem, and they are removed automatically and only when the Health Service can no longer observe the problem. In general, this reflects that the problem has been fixed.

However, in some cases, faults may be rediscovered by the Health Service (e.g. after failover, or due to intermittent connectivity, etc.). For this reason, it may makes sense to persist your own representation of faults, so you can easily deduplicate. This is especially important if you send email alerts or equivalent.

### Properties of faults

This table presents several key properties of the fault object. For the full schema, inspect the **MSFT\_StorageDiagnoseResult** class in *storagewmi.mof*.

| **Property**              | **Example**                                                     |
|---------------------------|-----------------------------------------------------------------|
| FaultId                   | {12345-12345-12345-12345-12345}                                 |
| FaultType                 | Microsoft.Health.FaultType.Volume.Capacity                      |
| Reason                    | "The volume is running out of available space."                 |
| PerceivedSeverity         | 5                                                               |
| FaultingObjectDescription | Contoso XYZ9000 S.N. 123456789                                  |
| FaultingObjectLocation    | Rack A06, RU 25, Slot 11                                        |
| RecommendedActions        | {"Expand the volume.", "Migrate workloads to other volumes."}   |

**FaultId**
Unique within the scope of one cluster.

**PerceivedSeverity**
PerceivedSeverity = { 4, 5, 6 } = { "Informational", "Warning", and "Error" }, or equivalent colors such as blue, yellow, and red.

**FaultingObjectDescription**
Part information for hardware, typically blank for software objects.

**FaultingObjectLocation**
Location information for hardware, typically blank for software objects.

**RecommendedActions**
List of recommended actions, which are independent and in no particular order. Today, this list is often of length 1.

## Properties of fault events

This table presents several key properties of the fault event. For the full schema, inspect the **MSFT\_StorageFaultEvent** class in *storagewmi.mof*.

Note the **ChangeType**, which indicates whether a fault is being created, removed, or updated, and the **FaultId**. An event also contains all the properties of the affected fault.

| **Property**              | **Example**                                                     |
|---------------------------|-----------------------------------------------------------------|
| ChangeType                | 0                                                               |
| FaultId                   | {12345-12345-12345-12345-12345}                                 |
| FaultType                 | Microsoft.Health.FaultType.Volume.Capacity                      |
| Reason                    | "The volume is running out of available space."                 |
| PerceivedSeverity         | 5                                                               |
| FaultingObjectDescription | Contoso XYZ9000 S.N. 123456789                                  |
| FaultingObjectLocation    | Rack A06, RU 25, Slot 11                                        |
| RecommendedActions        | {"Expand the volume.", "Migrate workloads to other volumes."}   |

**ChangeType**
ChangeType = { 0, 1, 2 } = { "Create", "Remove", "Update" }.

## Coverage

In Windows Server 2016, the Health Service provides the following fault coverage:  

### **PhysicalDisk (8)**

#### FaultType: Microsoft.Health.FaultType.PhysicalDisk.FailedMedia
* Severity: Warning
* Reason: *"The physical disk has failed."*
* RecommendedAction: *"Replace the physical disk."*

#### FaultType: Microsoft.Health.FaultType.PhysicalDisk.LostCommunication
* Severity: Warning
* Reason: *"Connectivity has been lost to the physical disk."*
* RecommendedAction: *"Check that the physical disk is working and properly connected."*

#### FaultType: Microsoft.Health.FaultType.PhysicalDisk.Unresponsive
* Severity: Warning
* Reason: *"The physical disk is exhibiting recurring unresponsiveness."*
* RecommendedAction: *"Replace the physical disk."*

#### FaultType: Microsoft.Health.FaultType.PhysicalDisk.PredictiveFailure
* Severity: Warning
* Reason: *"A failure of the physical disk is predicted to occur soon."*
* RecommendedAction: *"Replace the physical disk."*

#### FaultType: Microsoft.Health.FaultType.PhysicalDisk.UnsupportedHardware
* Severity: Warning
* Reason: *"The physical disk is quarantined because it is not supported by your solution vendor."*
* RecommendedAction: *"Replace the physical disk with supported hardware."*

#### FaultType: Microsoft.Health.FaultType.PhysicalDisk.UnsupportedFirmware
* Severity: Warning
* Reason: *"The physical disk is in quarantine because its firmware version is not supported by your solution vendor."*
* RecommendedAction: *"Update the firmware on the physical disk to the target version."*

#### FaultType: Microsoft.Health.FaultType.PhysicalDisk.UnrecognizedMetadata
* Severity: Warning
* Reason: *"The physical disk has unrecognised meta data."*
* RecommendedAction: *"This disk may contain data from an unknown storage pool. First make sure there is no useful data on this disk, then reset the disk."*

#### FaultType: Microsoft.Health.FaultType.PhysicalDisk.FailedFirmwareUpdate
* Severity: Warning
* Reason: *"Failed attempt to update firmware on the physical disk."*
* RecommendedAction: *"Try using a different firmware binary."*

### **Virtual Disk (2)**

#### FaultType: Microsoft.Health.FaultType.VirtualDisks.NeedsRepair
* Severity: Informational
* Reason: *"Some data on this volume is not fully resilient. It remains accessible."*
* RecommendedAction: *"Restoring resiliency of the data."*

#### FaultType: Microsoft.Health.FaultType.VirtualDisks.Detached
* Severity: Critical
* Reason: *"The volume is inaccessible. Some data may be lost."*
* RecommendedAction: *"Check the physical and/or network connectivity of all storage devices. You may need to restore from backup."*

### **Pool Capacity (1)**

#### FaultType: Microsoft.Health.FaultType.StoragePool.InsufficientReserveCapacityFault
* Severity: Warning
* Reason: *"The storage pool does not have the minimum recommended reserve capacity. This may limit your ability to restore data resiliency in the event of drive failure(s)."*
* RecommendedAction: *"Add additional capacity to the storage pool, or free up capacity. The minimum recommended reserve varies by deployment, but is approximately 2 drives' worth of capacity."*

### **Volume Capacity (2)**<sup>1</sup>

#### FaultType: Microsoft.Health.FaultType.Volume.Capacity
* Severity: Warning
* Reason: *"The volume is running out of available space."*
* RecommendedAction: *"Expand the volume or migrate workloads to other volumes."*

#### FaultType: Microsoft.Health.FaultType.Volume.Capacity
* Severity: Critical
* Reason: *"The volume is running out of available space."*
* RecommendedAction: *"Expand the volume or migrate workloads to other volumes."*

### **Server (3)**

#### FaultType: Microsoft.Health.FaultType.Server.Down
* Severity: Critical
* Reason: *"The server cannot be reached."*
* RecommendedAction: *"Start or replace server."*

#### FaultType: Microsoft.Health.FaultType.Server.Isolated
* Severity: Critical
* Reason: *"The server is isolated from the cluster due to connectivity issues."*
* RecommendedAction: *"If isolation persists, check the network(s) or migrate workloads to other nodes."*

#### FaultType: Microsoft.Health.FaultType.Server.Quarantined
* Severity: Critical
* Reason: *"The server is quarantined by the cluster due to recurring failures."*
* RecommendedAction: *"Replace the server or fix the network."*

### **Cluster (1)**

#### FaultType: Microsoft.Health.FaultType.ClusterQuorumWitness.Error
* Severity: Critical
* Reason: *"The cluster is one server failure away from going down."*
* RecommendedAction: *"Check the witness resource, and restart as needed. Start or replace failed servers."*

### **Network Adapter/Interface (4)**

#### FaultType: Microsoft.Health.FaultType.NetworkAdapter.Disconnected
* Severity: Warning
* Reason: *"The network interface has become disconnected."*
* RecommendedAction: *"Reconnect the network cable."*

#### FaultType: Microsoft.Health.FaultType.NetworkInterface.Missing
* Severity: Warning
* Reason: *"The server {server} has missing network adapter(s) connected to cluster network {cluster network}."*
* RecommendedAction: *"Connect the server to the missing cluster network."*

#### FaultType: Microsoft.Health.FaultType.NetworkAdapter.Hardware
* Severity: Warning
* Reason: *"The network interface has had a hardware failure."*
* RecommendedAction: *"Replace the network interface adapter."*

#### FaultType: Microsoft.Health.FaultType.NetworkAdapter.Disabled
* Severity: Warning
* Reason: *"The network interface {network interface} is not enabled and is not being used."*
* RecommendedAction: *"Enable the network interface."*

### **Enclosure (6)**

#### FaultType: Microsoft.Health.FaultType.StorageEnclosure.LostCommunication
* Severity: Warning
* Reason: *"Communication has been lost to the storage enclosure."*
* RecommendedAction: *"Start or replace the storage enclosure."*

#### FaultType: Microsoft.Health.FaultType.StorageEnclosure.FanError
* Severity: Warning
* Reason: *"The fan at position {position} of the storage enclosure has failed."*
* RecommendedAction: *"Replace the fan in the storage enclosure."*

#### FaultType: Microsoft.Health.FaultType.StorageEnclosure.CurrentSensorError
* Severity: Warning
* Reason: *"The current sensor at position {position} of the storage enclosure has failed."*
* RecommendedAction: *"Replace a current sensor in the storage enclosure."*

#### FaultType: Microsoft.Health.FaultType.StorageEnclosure.VoltageSensorError
* Severity: Warning
* Reason: *"The voltage sensor at position {position} of the storage enclosure has failed."*
* RecommendedAction: *"Replace a voltage sensor in the storage enclosure."*

#### FaultType: Microsoft.Health.FaultType.StorageEnclosure.IoControllerError
* Severity: Warning
* Reason: *"The IO controller at position {position} of the storage enclosure has failed."*
* RecommendedAction: *"Replace an IO controller in the storage enclosure."*

#### FaultType: Microsoft.Health.FaultType.StorageEnclosure.TemperatureSensorError
* Severity: Warning
* Reason: *"The temperature sensor at position {position} of the storage enclosure has failed."*
* RecommendedAction: *"Replace a temperature sensor in the storage enclosure."*

### **Firmware Rollout (3)**

#### FaultType: Microsoft.Health.FaultType.FaultDomain.FailedMaintenanceMode
* Severity: Warning
* Reason: *"Currently unable to make progress while performing firmware roll out."*
* RecommendedAction: *"Verify all storage spaces are healthy, and that no fault domain is currently in maintenance mode."*

#### FaultType: Microsoft.Health.FaultType.FaultDomain.FirmwareVerifyVersionFaile
* Severity: Warning
* Reason: *"Firmware roll out was cancelled due to unreadable or unexpected firmware version information after applying a firmware update."*
* RecommendedAction: *"Restart firmware roll out once the firmware issue has been resolved."*

#### FaultType: Microsoft.Health.FaultType.FaultDomain.TooManyFailedUpdates
* Severity: Warning
* Reason: *"Firmware roll out was cancelled due to too many physical disks failing a firmware update attempt."*
* RecommendedAction: *"Restart firmware roll out once the firmware issue has been resolved."*

### **Storage QoS (3)**<sup>2</sup>

#### FaultType: Microsoft.Health.FaultType.StorQos.InsufficientThroughput
* Severity: Warning
* Reason: *"Storage throughput is insufficient to satisfy reserves."*
* RecommendedAction: *"Reconfigure Storage QoS policies."*

#### FaultType: Microsoft.Health.FaultType.StorQos.LostCommunication
* Severity: Warning
* Reason: *"The Storage QoS policy manager has lost communication with the volume."*
* RecommendedAction: *"Please reboot nodes {nodes}"*

#### FaultType: Microsoft.Health.FaultType.StorQos.MisconfiguredFlow
* Severity: Warning
* Reason: *"One or more storage consumers (usually Virtual Machines) are using a non-existent policy with id {id}."*
* RecommendedAction: *"Recreate any missing Storage QoS policies."*

<sup>1</sup>  Indicates the volume has reached 80% full (minor severity) or 90% full (major severity).  
<sup>2</sup> Indicates some .vhd(s) on the volume have not met their Minimum IOPS for over 10% (minor), 30% (major), or 50% (critical) of rolling 24-hour window.  

>[!NOTE]
> The health of storage enclosure components such as fans, power supplies, and sensors is derived from SCSI Enclosure Services (SES). If your vendor does not provide this information, the Health Service cannot display it.  

## See also

- [Health Service in Windows Server 2016](health-service-overview.md)
