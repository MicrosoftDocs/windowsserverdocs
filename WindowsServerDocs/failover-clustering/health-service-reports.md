---
title: Health Service reports
ms.prod: windows-server-threshold
manager: eldenc
ms.author: cosdar
ms.technology: storage-health-service
ms.topic: article
ms.assetid:
author: cosmosdarwin
ms.date: 10/05/2017
---
# Health Service reports
> Applies to: Windows Server 2019, Windows Server 2016

## What are reports  

The Health Service reduces the work required to get live performance and capacity information from your Storage Spaces Direct cluster. One new cmdlet provides a curated list of essential metrics, which are collected efficiently and aggregated dynamically across nodes, with built-in logic to detect cluster membership. All values are real-time and point-in-time only.  

## Usage in PowerShell

Use this cmdlet to get metrics for the entire Storage Spaces Direct cluster:

```PowerShell
Get-StorageSubSystem Cluster* | Get-StorageHealthReport
```

The optional **Count** parameter indicates how many sets of values to return, at one second intervals.  

```PowerShell
Get-StorageSubSystem Cluster* | Get-StorageHealthReport -Count <Count>  
```

You can also get metrics for one specific volume or server:  

```PowerShell
Get-Volume -FileSystemLabel <Label> | Get-StorageHealthReport -Count <Count>  

Get-StorageNode -Name <Name> | Get-StorageHealthReport -Count <Count>
```

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

Before you can get faults or metrics, you will need to get instances of several relevant objects. First, the **MSFT\_StorageSubSystem** which represents Storage Spaces Direct on the cluster. Using that, you can get every **MSFT\_StorageNode** in the cluster, and every **MSFT\_Volume**, the data volumes. Finally, you will need the **MSFT\_StorageHealth**, the Health Service itself, too.

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

Invoke **GetReport** to begin streaming samples of an expert-curated list of essential metrics, which are collected efficiently and aggregated dynamically across nodes, with built-in logic to detect cluster membership. Samples will arrive every second thereafter. All values are real-time and point-in-time only.

Metrics can be streamed for three scopes: the cluster, any node, or any volume.

The complete list of metrics available at each scope in Windows Server 2016 is documented below.

### IObserver.OnNext()

This sample code uses the [Observer Design Pattern](https://msdn.microsoft.com/library/ee850490(v=vs.110).aspx) to implement an Observer whose **OnNext()** method will be invoked when each new sample of metrics arrives. Its **OnCompleted()** method will be called if/when streaming ends. For example, you might use it to reinitiate streaming, so it continues indefinitely.

```
class MetricsObserver<T> : IObserver<T>
{
    public void OnNext(T Result)
    {
        // Cast
        CimMethodStreamedResult StreamedResult = Result as CimMethodStreamedResult;

        if (StreamedResult != null)
        {
            // For illustration, you could store the metrics in this dictionary
            Dictionary<string, string> Metrics = new Dictionary<string, string>();

            // Unpack
            CimInstance Report = (CimInstance)StreamedResult.ItemValue;
            IEnumerable<CimInstance> Records = (IEnumerable<CimInstance>)Report.CimInstanceProperties["Records"].Value;
            foreach (CimInstance Record in Records)
            {
                /// Each Record has "Name", "Value", and "Units"
                Metrics.Add(
                    Record.CimInstanceProperties["Name"].Value.ToString(),
                    Record.CimInstanceProperties["Value"].Value.ToString()
                    );
            }

            // TODO: Whatever you want!
        }
    }
    public void OnError(Exception e)
    {
        // Handle Exceptions
    }
    public void OnCompleted()
    {
        // Reinvoke BeginStreamingMetrics(), defined in the next section
    }
}
```

### Begin streaming

With the Observer defined, you can begin streaming.

Specify the target **CimInstance** to which you want the metrics scoped. It can be the cluster, any node, or any volume.

The count parameter is the number of samples before streaming ends.

```
CimInstance Target = Cluster; // From among the objects discovered in DiscoverObjects()

public void BeginStreamingMetrics(CimSession Session, CimInstance HealthService, CimInstance Target)
{
    // Set Parameters
    CimMethodParametersCollection MetricsParams = new CimMethodParametersCollection();
    MetricsParams.Add(CimMethodParameter.Create("TargetObject", Target, CimType.Instance, CimFlags.In));
    MetricsParams.Add(CimMethodParameter.Create("Count", 999, CimType.UInt32, CimFlags.In));
    // Enable WMI Streaming
    CimOperationOptions Options = new CimOperationOptions();
    Options.EnableMethodResultStreaming = true;
    // Invoke API
    CimAsyncMultipleResults<CimMethodResultBase> InvokeHandler;
    InvokeHandler = Session.InvokeMethodAsync(
        HealthService.CimSystemProperties.Namespace, HealthService, "GetReport", MetricsParams, Options
        );
    // Subscribe the Observer
    MetricsObserver<CimMethodResultBase> Observer = new MetricsObserver<CimMethodResultBase>(this);
    IDisposable Disposeable = InvokeHandler.Subscribe(Observer);
}
```

Needless to say, these metrics can be visualized, stored in a database, or used in whatever way you see fit.

### Properties of reports

Every sample of metrics is one "report" which contains many "records" corresponding to individual metrics.

For the full schema, inspect the **MSFT\_StorageHealthReport** and **MSFT\_HealthRecord** classes in *storagewmi.mof*.

Each metric has just three properties, per this table.

| **Property** | **Example**       |
| -------------|-------------------|
| Name         | IOLatencyAverage  |
| Value        | 0.00021           |
| Units        | 3                 |

Units = { 0, 1, 2, 3, 4 }, where 0 = "Bytes", 1 = "BytesPerSecond", 2 = "CountPerSecond", 3 = "Seconds", or 4 = "Percentage".

## Coverage

Below are the metrics available for each scope in Windows Server 2016.

### MSFT_StorageSubSystem

| **Name**                        | **Units** |
|---------------------------------|-----------|
| CPUUsage                        | 4         |
| CapacityPhysicalPooledAvailable | 0         |
| CapacityPhysicalPooledTotal     | 0         |
| CapacityPhysicalTotal           | 0         |
| CapacityPhysicalUnpooled        | 0         |
| CapacityVolumesAvailable        | 0         |
| CapacityVolumesTotal            | 0         |
| IOLatencyAverage                | 3         |
| IOLatencyRead                   | 3         |
| IOLatencyWrite                  | 3         |
| IOPSRead                        | 2         |
| IOPSTotal                       | 2         |
| IOPSWrite                       | 2         |
| IOThroughputRead                | 1         |
| IOThroughputTotal               | 1         |
| IOThroughputWrite               | 1         |
| MemoryAvailable                 | 0         |
| MemoryTotal                     | 0         |


### MSFT_StorageNode

| **Name**            | **Units** |
|---------------------|-----------|
| CPUUsage            | 4         |
| IOLatencyAverage    | 3         |
| IOLatencyRead       | 3         |
| IOLatencyWrite      | 3         |
| IOPSRead            | 2         |
| IOPSTotal           | 2         |
| IOPSWrite           | 2         |
| IOThroughputRead    | 1         |
| IOThroughputTotal   | 1         |
| IOThroughputWrite   | 1         |
| MemoryAvailable     | 0         |
| MemoryTotal         | 0         |

### MSFT_Volume

| **Name**            | **Units** |
|---------------------|-----------|
| CapacityAvailable   | 0         |
| CapacityTotal       | 0         |
| IOLatencyAverage    | 3         |
| IOLatencyRead       | 3         |
| IOLatencyWrite      | 3         |
| IOPSRead            | 2         |
| IOPSTotal           | 2         |
| IOPSWrite           | 2         |
| IOThroughputRead    | 1         |
| IOThroughputTotal   | 1         |
| IOThroughputWrite   | 1         |

## See also

- [Health Service in Windows Server 2016](health-service-overview.md)
