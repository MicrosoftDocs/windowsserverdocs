---
title: Troubleshooting Using the Guarded Fabric Diagnostic Tool
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 07691d5b-046c-45ea-8570-a0a85c3f2d22
manager: dongill
author: huu
ms.technology: security-guarded-fabric
---

# Troubleshooting Using the Guarded Fabric Diagnostic Tool

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the use of the Guarded Fabric Diagnostic Tool to identify and remediate common failures in the deployment, configuration, and on-going operation of guarded fabric infrastructure. This includes the Host Guardian Service (HGS), all guarded hosts, and supporting services such as DNS and Active Directory. The diagnostic tool can be used to perform a first-pass at triaging a failing guarded fabric, providing administrators with a starting point for resolving outages and identifying misconfigured assets. The tool is not a replacement for a sound grasp of operating a guarded fabric and only serves to rapidly verify the most common issues encountered during day-to-day operations.

Documentation of the cmdlets used in this topic can be found on [TechNet](https://technet.microsoft.com/library/mt718834.aspx).

[!INCLUDE [Guarded fabric diagnostics tool](../../../includes/guarded-fabric-diagnostics-tool.md)] 

# Quick Start

You can diagnose either a guarded host or an HGS node by calling the following from a Windows PowerShell session with local administrator privileges:
```PowerShell
Get-HgsTrace -RunDiagnostics -Detailed
```
This will automatically detect the role of the current host and diagnose any relevant issues that can be automatically detected.  All of the results generated during this process are displayed due to the presence of the `-Detailed` switch.

The remainder of this topic will provide a detailed walkthrough on the advanced usage of `Get-HgsTrace` for doing things like diagnosing multiple hosts at once and detecting complex cross-node misconfiguration.

## Diagnostics Overview
Guarded fabric diagnostics are available on any host with shielded virtual machine related tools and features installed, including hosts running Server Core.  Presently, diagnostics are included with the following features/packages:

1. Host Guardian Service Role
2. Host Guardian Hyper-V Support
3. VM Shielding Tools for Fabric Management
4. Remote Server Administration Tools (RSAT)

This means that diagnostic tools will be available on all guarded hosts, HGS nodes, certain fabric management servers, and any Windows 10 workstations with [RSAT](https://www.microsoft.com/download/details.aspx?id=45520) installed.  Diagnostics can be invoked from any of the above machines with the intent of diagnosing any guarded host or HGS node in a guarded fabric; using remote trace targets, diagnostics can locate and connect to hosts other than the machine running diagnostics.

Every host targeted by diagnostics is referred to as a "trace target."  Trace targets are identified by their hostnames and roles.  Roles describe the function a given trace target performs in a guarded fabric.  Presently, trace targets support `HostGuardianService` and `GuardedHost` roles.  Note it is possible for a host to occupy multiple roles at once and this is also supported by diagnostics, however this should not be done in production environments.  The HGS and Hyper-V hosts should be kept separate and distinct at all times.

Administrators can begin any diagnostic tasks by running `Get-HgsTrace`.  This command performs two distinct functions based on the switches provided at runtime: trace collection and diagnosis.  These two combined make up the entirety of the Guarded Fabric Diagnostic Tool.  Though not explicitly required, most useful diagnostics require traces that can only be collected with administrator credentials on the trace target.  If insufficient privileges are held by the user executing trace collection, traces requiring elevation will fail while all others will pass.  This allows partial diagnosis in the event an under-privileged operator is performing triage. 

### Trace collection
By default, `Get-HgsTrace` will only collect traces and save them to a temporary folder.  Traces take the form of a folder, named after the targeted host, filled with specially formatted files that describe how the host is configured.  The traces also contain metadata that describe how the diagnostics were invoked to collect the traces.  This data is used by diagnostics to rehydrate information about the host when performing manual diagnosis.

If necessary, traces can be manually reviewed.  All formats are either human-readable (XML) or may be readily inspected using standard tools (e.g. X509 certificates and the Windows Crypto Shell Extensions).  Note however that traces are not designed for manual diagnosis and it is always more effective to process the traces with the diagnosis facilities of `Get-HgsTrace`.

The results of running trace collection do not make any indication as to the health of a given host.  They simply indicate that traces were collected successfully.  It is necessary to use the diagnosis facilities of `Get-HgsTrace` to determine if the traces indicate a failing environment.

Using the `-Diagnostic` parameter, you can restrict trace collection to only those traces required to operate the specified diagnostics.  This reduces the amount of data collected as well as the permissions required to invoke diagnostics.

### Diagnosis
Collected traces can be diagnosed by provided `Get-HgsTrace` the location of the traces via the `-Path` parameter and specifying the `-RunDiagnostics` switch.  Additionally, `Get-HgsTrace` can perform collection and diagnosis in a single pass by providing the `-RunDiagnostics` switch and a list of trace targets.  If no trace targets are provided, the current machine is used as an implicit target, with its role inferred by inspecting the installed Windows PowerShell modules.

Diagnosis will provide results in a hierarchical format showing which trace targets, diagnostic sets, and individual diagnostics are responsible for a particular failure.  Failures include remediation and resolution recommendations if a determination can be made as to what action should be taken next.  By default, passing and irrelevant results are hidden.  To see everything tested by diagnostics, specify the `-Detailed` switch.  This will cause all results to appear regardless of their status.

It is possible to restrict the set of diagnostics that are run using the `-Diagnostic` parameter.  This allows you to specify which classes of diagnostic should be run against the trace targets, and suppressing all others.  Examples of available diagnostic classes include networking, best practices, and client hardware.  Consult the [cmdlet documentation](https://technet.microsoft.com/library/mt718831.aspx) to find an up-to-date list of available diagnostics.

> [!WARNING]
> Diagnostics are not a replacement for a strong monitoring and incident response pipeline.  There is a System Center Operations Manager package available for monitoring guarded fabrics, as well as various event log channels that can be monitored to detect issues early.  Diagnostics can then be used to quickly triage these failures and establish a course of action.

## Targeting Diagnostics

`Get-HgsTrace` operates against trace targets.  A trace target is an object that corresponds to an HGS node or a guarded host inside a guarded fabric.  It can be thought of as an extension to a `PSSession` which includes information required only by diagnostics such as the role of the host in the fabric.  Targets can be generated implicitly (e.g. local or manual diagnosis) or explicitly with the `New-HgsTraceTarget` command.

### Local Diagnosis

By default, `Get-HgsTrace` will target the localhost (i.e. where the cmdlet is being invoked).  This is referred as the implicit local target.  The implicit local target is only used when no targets are provided in the `-Target` parameter and no pre-existing traces are found in the `-Path`.

The implicit local target uses role inference to determine what role the current host plays in the guarded fabric.  This is based on the installed Windows PowerShell modules which roughly correspond to what features have been installed on the system.  The presence of the `HgsServer` module will cause the trace target to take the role `HostGuardianService` and the presence of the `HgsClient` module will cause the trace target to take the role `GuardedHost`.  It is possible for a given host to have both modules present in which case it will be treated as both a `HostGuardianService` and a `GuardedHost`.

Therefore, the default invocation of diagnostics for collecting traces locally:
```PowerShell
Get-HgsTrace
```
...is equivalent to the following:
```PowerShell
New-HgsTraceTarget -Local | Get-HgsTrace
```
> [!TIP]
> `Get-HgsTrace` can accept targets via the pipeline or directly via the `-Target` parameter.  There is no difference between the two operationally.

### Remote Diagnosis Using Trace Targets

It is possible to remotely diagnose a host by generating trace targets with remote connection information.  All that is required is the hostname and a set of credentials capable of connecting using Windows PowerShell remoting.
```PowerShell
$server = New-HgsTraceTarget -HostName "hgs-01.secure.contoso.com" -Role HostGuardianService -Credential (Enter-Credential)
Get-HgsTrace -RunDiagnostics -Target $server
```
This example will generate a prompt to collect the remote user credentials, and then diagnostics will run using the remote host at `hgs-01.secure.contoso.com` to complete trace collection.  The resulting traces are downloaded to the localhost and then diagnosed.  The results of diagnosis are presented the same as when performing [local diagnosis](#local-diagnosis).  Similarly, it is not necessary to specify a role as it can be inferred based on the Windows PowerShell modules installed on the remote system.

Remote diagnosis utilizes Windows PowerShell remoting for all accesses to the remote host.  Therefore it is a prerequisite that the trace target have Windows PowerShell remoting enabled (see [Enable PSRemoting](https://technet.microsoft.com/library/hh849694.aspx)) and that the localhost is properly configured for launching connections to the target.

> [!NOTE]
> In most cases, it is only necessary that the localhost be a part of the same Active Directory forest and that a valid DNS hostname is used.  If your environment utilizes a more complicated federation model or you wish to use direct IP addresses for connectivity, you may need to perform additional configuration such as setting the WinRM [trusted hosts](https://technet.microsoft.com/library/ff700227.aspx).

You can verify that a trace target is properly instantiated and configured for accepting connections by using the `Test-HgsTraceTarget` cmdlet:
```PowerShell
$server = New-HgsTraceTarget -HostName "hgs-01.secure.contoso.com" -Role HostGuardianService -Credential (Enter-Credential)
$server | Test-HgsTraceTarget
```
This command will return `$True` if and only if `Get-HgsTrace` would be able to establish a remote diagnostic session with the trace target.  Upon failure, this cmdlet will return relevant status information for further troubleshooting of the Windows PowerShell remoting connection.

#### Implicit Credentials

When performing remote diagnosis from a user with sufficient privileges to connect remotely to the trace target, it is not necessary to supply credentials to `New-HgsTraceTarget`.  The `Get-HgsTrace` cmdlet will automatically reuse the credentials of the user that invoked the cmdlet when opening a connection.

> [!WARNING]
> Some restrictions apply to reusing credentials, particularly when performing what is known as a "second hop."  This occurs when attempting to reuse credentials from inside a remote session to another machine.  It is necessary to [setup CredSSP](https://technet.microsoft.com/library/hh849872.aspx) to support this scenario, but this is outside of the scope of guarded fabric management and troubleshooting.

#### Using Windows PowerShell Just Enough Administration (JEA) and Diagnostics

Remote diagnosis supports the use of JEA-constrained Windows PowerShell endpoints. By default, remote trace targets will connect using the default `microsoft.powershell` endpoint.  If the trace target has the `HostGuardianService` role, it will also attempt to use the `microsoft.windows.hgs` endpoint which is configured when HGS is installed.

If you want to use a custom endpoint, you must specify the session configuration name while constructing the trace target using the `-PSSessionConfigurationName` parameter, such as below:

```PowerShell
New-HgsTraceTarget -HostName "hgs-01.secure.contoso.com" -Role HostGuardianService -Credential (Enter-Credential) -PSSessionConfigurationName "microsoft.windows.hgs"
```

#### Diagnosing Multiple Hosts

You can pass multiple trace targets to `Get-HgsTrace` at once.  This includes a mix of local and remote targets.  Each target will be traced in turn and then traces from every target will be diagnosed simultaneously.  The diagnostic tool can use the increased knowledge of your deployment to identify complex cross-node misconfigurations that would not otherwise be detectable.  Using this feature only requires providing traces from multiple hosts simultaneously (in the case of manual diagnosis) or by targeting multiple hosts when calling `Get-HgsTrace` (in the case of remote diagnosis).

Here is an example of using remote diagnosis to triage a fabric composed of two HGS nodes and two guarded hosts, where one of the guarded hosts is being used to launch `Get-HgsTrace`.

```PowerShell
$hgs01 = New-HgsTraceTarget -HostName "hgs-01.secure.contoso.com" -Credential (Enter-Credential)
$hgs02 = New-HgsTraceTarget -HostName "hgs-02.secure.contoso.com" -Credential (Enter-Credential)
$gh01 = New-HgsTraceTarget -Local
$gh02 = New-HgsTraceTarget -HostName "guardedhost-02.contoso.com"
Get-HgsTrace -Target $hgs01,$hgs02,$gh01,$gh02 -RunDiagnostics
```

> [!NOTE]
> You do not need to diagnose your entire guarded fabric when diagnosing multiple nodes.  In many cases it is sufficient to include all nodes that may be involved in a given failure condition.  This is usually a subset of the guarded hosts, and some number of nodes from the HGS cluster.

## Manual Diagnosis Using Saved Traces

Sometimes you may want to re-run diagnostics without collecting traces again, or you may not have the necessary credentials to remotely diagnose all of the hosts in your fabric simultaneously.  Manual diagnosis is a mechanism by which you can still perform a whole-fabric triage using `Get-HgsTrace`, but without using remote trace collection.

Before performing manual diagnosis, you will need to ensure the administrators of each host in the fabric that will be triaged are ready and willing to execute commands on your behalf.  Diagnostic trace output does not expose any information that is generally viewed as sensitive, however it is incumbent on the user to determine if it is safe to expose this information to others.

> [!NOTE]
> Traces are not anonymized and reveal network configuration, PKI settings, and other configuration that is sometimes considered private information.  Therefore, traces should only be transmitted to trusted entities within an organization and never posted publicly.

Steps to performing a manual diagnosis are as follows:

1. Request that each host administrator run `Get-HgsTrace` specifying a known `-Path` and the list of diagnostics you intend to run against the resulting traces.  For example:

   ```PowerShell
   Get-HgsTrace -Path C:\Traces -Diagnostic Networking,BestPractices
   ```
2. Request that each host administrator package the resulting traces folder and send it to you.  This process can be driven over e-mail, via file shares, or any other mechanism based on the operating policies and procedures established by your organization.

3. Merge all received traces into a single folder, with no other contents or folders.

    * For example, assume you had your administrators send you traces collected from four machines named HGS-01, HGS-02, RR1N2608-12, and RR1N2608-13.  Each administrator would have sent you a folder by the same name.  You would assemble a directory structure that appears as follows:

      ```
      FabricTraces
      |- HGS-01
      |  |- TargetMetadata.xml
      |  |- Metadata.xml
      |  |- [any other trace files for this host]
      |- HGS-02
      |  |- [...]
      |- RR1N2608-12
      |  |- [...]
      |- RR1N2608-13
         |- [..]
      ```

4. Execute diagnostics, providing the path to the assembled trace folder on the `-Path` parameter and specifying the `-RunDiagnostics` switch as well as those diagnostics for which you asked your administrators to collect traces.  Diagnostics will assume it cannot access the hosts found inside the path and will therefore attempt to use only the pre-collected traces.  If any traces are missing or damaged, diagnostics will fail only the affected tests and proceed normally.  For example:

   ```PowerShell
   Get-HgsTrace -RunDiagnostics -Diagnostic Networking,BestPractices -Path ".\FabricTraces"
   ```

### Mixing Saved Traces with Additional Targets

In some cases, you may have a set of pre-collected traces that you wish to augment with additional host traces.  It is possible to mix pre-collected traces with additional targets that will be traced and diagnosed in a single call of diagnostics.

Following the instructions to collect and assemble a trace folder specified above, call `Get-HgsTrace` with additional trace targets not found in the pre-collected trace folder:

```PowerShell
$hgs03 = New-HgsTraceTarget -HostName "hgs-03.secure.contoso.com" -Credential (Enter-Credential)
Get-HgsTrace -RunDiagnostics -Target $hgs03 -Path .\FabricTraces
``` 

The diagnostic cmdlet will identify all pre-collected hosts, and the one additional host that still needs to be traced and will perform the necessary tracing.  The sum of all pre-collected and freshly gathered traces will then be diagnosed.  The resulting trace folder will contain both the old and new traces.
