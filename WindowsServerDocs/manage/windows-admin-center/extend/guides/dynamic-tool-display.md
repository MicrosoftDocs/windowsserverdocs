---
title: Control your tool's visibility in a solution
description: Control your tool's visibility in a solution Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 09/18/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Control your tool's visibility in a solution #

>Applies To: Windows Admin Center, Windows Admin Center Preview

There might be times when you want to exclude (or hide) your extension or tool from the available tools list. For example, if your tool targets only Windows Server 2016 (not older versions), you might not want a user who connects to a Windows Server 2012 R2 server to see your tool at all. (Imagine the user experience - they click on it, wait for the tool to load, only to get a message that its features aren't available for their connection.) You can define when to show (or hide) your feature in the tool's manifest.json file.

## Options for deciding when to show a tool ##

There are three different options you can use to determine whether your tool should be displayed and available for a specific server or cluster connection.

* localhost
* inventory (an array of properties)
* script

### LocalHost ###

The localHost property of the Conditions object contains a boolean value that can be evaluated to infer if the connecting node is localHost (the same computer that Windows Admin Center is installed on) or not. By passing a value to the property, you indicate when (the condition) to display the tool. For example if you only want the tool to display if the user is in fact connecting to the local host, set it up like this:

``` json
"conditions": [
{
    "localhost": true
}]
```

Alternatively, if you only want your tool to display when the connecting node *is not* localhost:

``` json
"conditions": [
{
    "localhost": false
}]
```

Here's what the configuration settings look like to only show a tool when the connecting node is not localhost:

``` json
"entryPoints": [
{
    "entryPointType": "tool",
    "name": "main",
    "urlName": "processes",
    "displayName": "resources:strings:displayName",
    "description": "resources:strings:description",
    "icon": "sme-icon:icon-win-serverProcesses",
    "path": "",
    "requirements": [
    {
        "solutionIds": [
        "msft.sme.server-manager!windowsClients"
        ],
        "connectionTypes": [
        "msft.sme.connection-type.windows-client"
        ],
        "conditions": [
        {
            "localhost": true
        }
        ]
    }
    ]
}
```

### Inventory properties ###

The SDK includes a pre-curated set of inventory properties that you can use to build conditions to determine when your tool should be available or not. There are nine different properties in the 'inventory' array:

| Property Name | Expected Value Type |
| ------------- | ------------------- |
| computerManufacturer | string |
| operatingSystemSKU | number |
| operatingSystemVersion | version_string (eg: "10.1.*") |
| productType | number |
| clusterFqdn | string |
| isHyperVRoleInstalled | boolean |
| isHyperVPowershellInstalled | boolean |
| isManagementToolsAvailable | boolean |
| isWmfInstalled | boolean |

Every object in the inventory array must conform to the following json structure:

``` json
"<property name>": {
    "type": "<expected type>",
    "operator": "<defined operator to use>",
    "value": "<expected value to evaluate using the operator>"
}
```

#### Operator values ####

| Operator | Description |
| -------- | ----------- |
| gt | greater than |
| ge | greater than or equal to |
| lt | less than |
| le | less than or equal to |
| eq | equal to |
| ne | not equal to |
| is | checking if a value is true |
| not | checking if a value is false |
| contains | item exists in a string |
| notContains | item does not exist in a string |

#### Data types ####

Available options for the 'type' property:

| Type | Description |
| ---- | ----------- |
| version | a version number (eg: 10.1.*) |
| number | a numeric value |
| string | a string value |
| boolean | true or false |

#### Value types ####

The 'value' property accepts these types:

* string
* number
* boolean

A properly-formed inventory condition set looks like this:

``` json
"entryPoints": [
{
    "entryPointType": "tool",
    "name": "main",
    "urlName": "processes",
    "displayName": "resources:strings:displayName",
    "description": "resources:strings:description",
    "icon": "sme-icon:icon-win-serverProcesses",
    "path": "",
    "requirements": [
    {
        "solutionIds": [
        "msft.sme.server-manager!servers"
        ],
        "connectionTypes": [
        "msft.sme.connection-type.server"
        ],
        "conditions": [
        {
            "inventory": {
            "operatingSystemVersion": {
                "type": "version",
                "operator": "gt",
                "value": "6.3"
            },
            "operatingSystemSKU": {
                "type": "number",
                "operator": "eq",
                "value": "8"
            }
            }
        }
        ]
    }
    ]
}
```

### Script ###

Finally, you can run a custom PowerShell script to identify the availability and state of the node. All scripts must return an object with the following structure:

``` ps
@{
    State = 'Available' | 'NotSupported' | 'NotConfigured';
    Message = '<Message to explain the reason of state such as not supported and not configured.>';
    Properties =
        @{ Name = 'Prop1'; Value = 'prop1 data'; Type = 'string' },
        @{Name='Prop2'; Value = 12345678; Type='number'; };
}
```
The State property is the important value that will control the decision to show or hide your extension in the tools list.  The allowed values are:

| Value | Description |
| ---- | ----------- |
| Available | The extension should be displayed in the tools list. |
| NotSupported | The extension should not be displayed in the tools list. |
| NotConfigured | This is a placeholder value for future work that will prompt the user for additional configuration before the tool is made available.  Currently this value will result in the tool being displayed and is the functional equivalent to 'Available'. |

For example, if we want a tool to load only if the remote server has BitLocker installed, the script looks like this:

``` ps
$response = @{
    State = 'NotSupported';
    Message = 'Not executed';
    Properties = @{ Name = 'Prop1'; Value = 'prop1 data'; Type = 'string' },
        @{Name='Prop2'; Value = 12345678; Type='number'; };
}

if (Get-Module -ListAvailable -Name servermanager) {
    Import-module servermanager; 
    $isInstalled = (Get-WindowsFeature -name bitlocker).Installed;
    $isGood = $isInstalled;
}

if($isGood) {
    $response.State = 'Available';
    $response.Message = 'Everything should work.';
}

$response
```

An entry point configuration using the script option looks like this:

``` json
"entryPoints": [
{
    "entryPointType": "tool",
    "name": "main",
    "urlName": "processes",
    "displayName": "resources:strings:displayName",
    "description": "resources:strings:description",
    "icon": "sme-icon:icon-win-serverProcesses",
    "path": "",
    "requirements": [
    {
        "solutionIds": [
        "msft.sme.server-manager!windowsClients"
        ],
        "connectionTypes": [
        "msft.sme.connection-type.windows-client"
        ],
        "conditions": [
        {
            "localhost": true,
            "inventory": {
            "operatingSystemVersion": {
                "type": "version",
                "operator": "eq",
                "value": "10.0.*"
            },
            "operatingSystemSKU": {
                "type": "number",
                "operator": "eq",
                "value": "4"
            }
            },
            "script": "$response = @{ State = 'NotSupported'; Message = 'Not executed'; Properties = @{ Name = 'Prop1'; Value = 'prop1 data'; Type = 'string' }, @{Name='Prop2'; Value = 12345678; Type='number'; }; }; if (Get-Module -ListAvailable -Name servermanager) { Import-module servermanager; $isInstalled = (Get-WindowsFeature -name bitlocker).Installed; $isGood = $isInstalled; }; if($isGood) { $response.State = 'Available'; $response.Message = 'Everything should work.'; }; $response"
        }
        ]
    }
    ]
}
```

## Supporting multiple requirement sets ##

You can use more than one set of requirements to determine when to display your tool by defining multiple "requirements" blocks.

For example, to display your tool if "scenario A" OR "scenario B" is true, define two requirements blocks; if either is true (that is, all conditions within a requirements block are met), the tool is displayed.

``` json
"entryPoints": [
{
    "requirements": [
    {
        "solutionIds": [
            …"scenario A"…
        ],
        "connectionTypes": [
            …"scenario A"…
        ],
        "conditions": [
            …"scenario A"…
        ]
    },
    {
        "solutionIds": [
            …"scenario B"…
        ],
        "connectionTypes": [
            …"scenario B"…
        ],
        "conditions": [
            …"scenario B"…
        ]
    }
    ]
}

```

## Supporting condition ranges ##

You can also define a range of conditions by defining multiple "conditions" blocks with the same property, but with different operators.

When the same property is defined with different operators, the tool is displayed as long as the value is between the two conditions.

For example, this tool is displayed as long as the operating system is a version between 6.3.0 and 10.0.0:

``` json
"entryPoints": [
{
    "entryPointType": "tool",
    "name": "main",
    "urlName": "processes",
    "displayName": "resources:strings:displayName",
    "description": "resources:strings:description",
    "icon": "sme-icon:icon-win-serverProcesses",
    "path": "",
    "requirements": [
    {
        "solutionIds": [
             "msft.sme.server-manager!servers"
        ],
        "connectionTypes": [
             "msft.sme.connection-type.server"
        ],
        "conditions": [
        {
            "inventory": {
                "operatingSystemVersion": {
                    "type": "version",
                    "operator": "gt",
                    "value": "6.3.0"
                },
            }
        },
        {
            "inventory": {
                "operatingSystemVersion": {
                    "type": "version",
                    "operator": "lt",
                    "value": "10.0.0"
                }
            }
        }
        ]
    }
    ]
}

```
