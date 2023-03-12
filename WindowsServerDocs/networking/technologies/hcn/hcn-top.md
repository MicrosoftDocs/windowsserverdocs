---
title: Host Compute Network (HCN) service API for VMs and containers
description: Host Compute Network (HCN) service API is a public-facing Win32 API that provides platform-level access to manage the virtual networks, virtual network endpoints, and associated policies. Together this provides connectivity and security for virtual machines (VMs) and containers running on a Windows host. 
ms.author: jmesser
author: jmesser81
ms.date: 11/05/2018
---

# Host Compute Network (HCN) service API for VMs and containers

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Host Compute Network (HCN) service API is a public-facing Win32 API that provides platform-level access to manage the virtual networks, virtual network endpoints, and associated policies. Together this provides connectivity and security for virtual machines (VMs) and containers running on a Windows host. 

Developers use the HCN service API to manage networking for VMs and containers in their application workflows. The HCN API has been designed to provide the best experience for developers. End-users do not interact with these APIs directly.  

## Features of the HCN Service API
-	Implemented as C API hosted by the Host Network Service (HNS) on the OnCore/VM.

-	Provides the ability to create, modify, delete, and enumerate HCN objects such as networks, endpoints, namespaces, and policies. Operations perform on handles to the objects (e.g., a network handle), and internally these handles are implemented using RPC context handles.

-	Schema-based. Most functions of the API define input and output parameters as strings containing the arguments of the function call as JSON documents. The JSON documents are based on strongly typed and versioned schemas, these schemas are part of the public documentation. 

-	A subscription/callback API is provided to enable clients to register for notifications of service-wide events such as network creations and deletions.

-	HCN API works in Desktop Bridge (a.k.a. Centennial) apps running in system services. The API checks the ACL by retrieving the user token from the caller.

>[!TIP]
>The HCN service API is supported in background tasks and non-foreground windows. 

## Terminology: Host vs. Compute
The host compute service allows callers to create and manage both virtual machines and containers on a single physical computer. It is named to follow industry terminology. 

- **Host** is widely used in the virtualization industry to refer to the operating system that provides virtualized resources.

- **Compute** is used to refer to virtualization methods that are broader than just virtual machines. Host Compute Network Service allows callers to create and manage networking for both virtual machines and container on a single physical computer.

## Schema-based configuration documents
Configuration documents based on well-defined schemas is an established industry standard in the virtualization space. Most virtualization solutions, such as Docker and Kubernetes, provide APIs based on configuration documents. Several industry initiatives, with the participation of Microsoft, drive an ecosystem for defining and validating these schemas, such as [OpenAPI](https://www.openapis.org/).  These initiatives also drive the standardization of specific schema definitions for the schemas used for containers, such as [Open Container Initiative (OCI)](https://www.opencontainers.org/).

The language used for authoring configuration documents is [JSON](https://tools.ietf.org/html/rfc8259), which you use in combination with:
-	Schema definitions that define an object model for the document
-	Validation of whether a JSON document conforms to a schema
-	Automated conversion of JSON documents to and from native representations of these schemas in the programming languages used by the callers of the APIs 

Frequently used schema definitions are [OpenAPI](https://www.openapis.org/) and [JSON Schema](http://json-schema.org/), which lets you specify the detailed definitions of the properties in a document, for example:
-	The valid set of values for a property, such as 0-100 for a property representing a percentage.
-	The definition of enumerations, which are represented as a set of valid strings for a property.
-	A regular expression for the expected format of a string. 

As part of documenting the HCN APIs, we are planning to publish the schema of our JSON documents as an OpenAPI Specification. Based on this specification, language-specific representations of the schema can allow for type-safe use of the schema objects in the programming language used by the client. 

### Example 

The following is an example of this workflow for the object representing an SCSI controller in the configuration document of a VM. 

In the Windows source code, we define schemas using .mars files:
onecore/vm/dv/net/hns/schema/mars/Schema/HCN.Schema.Network.mars

```
enum IpamType
{
    [NewIn("2.0")] Static,
    [NewIn("2.0")] Dhcp,
};

class Ipam
{
    // Type : dhcp
    [NewIn("2.0"),OmitEmpty] IpamType   Type;
    [NewIn("2.0"),OmitEmpty] Subnet     Subnets[];
};

class Subnet : HCN.Schema.Common.Base
{
    [NewIn("2.0"),OmitEmpty] string         IpAddressPrefix;
    [NewIn("2.0"),OmitEmpty] SubnetPolicy   Policies[];
    [NewIn("2.0"),OmitEmpty] Route          Routes[];
};


enum SubnetPolicyType
{
    [NewIn("2.0")] VLAN
};

class SubnetPolicy
{
    [NewIn("2.0"),OmitEmpty] SubnetPolicyType                 Type;
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Common.PolicySettings Data;
};

class PolicySettings
{
    [NewIn("2.0"),OmitEmpty]  string      Name;
};

class VlanPolicy : HCN.Schema.Common.PolicySettings 
{
    [NewIn("2.0")] uint32 IsolationId;
};

class Route 
{
    [NewIn("2.0"),OmitEmpty] string NextHop;
    [NewIn("2.0"),OmitEmpty] string DestinationPrefix;
    [NewIn("2.0"),OmitEmpty] uint16 Metric;
};

```

>[!TIP]
>The [NewIn(“2.0”) annotations are part of the versioning support for the schema definitions.

From this internal definition, we generate the OpenAPI specifications for the schema:

```
{ 
    "swagger" : "2.0", 
    "info" : { 
       "version" : "2.1", 
       "title" : "HCN API" 
    },
    "definitions": {        
        "Ipam": {
            "type": "object",
            "properties": {
                "Type": {
                    "type": "string",
                    "enum": [
                        "Static",
                        "Dhcp"
                    ],
                    "description": " Type : dhcp"
                },
                "Subnets": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/Subnet"
                    }
                }
            }
        },
        "Subnet": {
            "type": "object",
            "properties": {
                "ID": {
                    "type": "string",
                    "pattern": "^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$"
                },                
                "IpAddressPrefix": {
                    "type": "string"
                },
                "Policies": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/SubnetPolicy"
                    }
                },
                "Routes": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/Route"
                    }
                }
            }
        },
        "SubnetPolicy": {
            "type": "object",
            "properties": {
                "Type": {
                    "type": "string",
                    "enum": [
                        "VLAN",
                        "VSID"
                    ]
                },
                "Data": {
                    "$ref": "#/definitions/PolicySettings"
                }
            }
        },
        "PolicySettings": {
            "type": "object",
            "properties": {
                "Name": {
                    "type": "string"
                }
            }
        },                      
        "VlanPolicy": {
            "type": "object",
            "properties": {
                "Name": {
                    "type": "string"
                },
                "IsolationId": {
                    "type": "integer",
                    "format": "uint32"
                }
            }
        },
        "Route": {
            "type": "object",
            "properties": {
                "NextHop": {
                    "type": "string"
                },
                "DestinationPrefix": {
                    "type": "string"
                },
                "Metric": {
                    "type": "integer",
                    "format": "uint16"
                }
            }
        }        
    }
} 
```

You can use tools, such as [Swagger](https://swagger.io/), to generate language-specific representations of the schema programming language used by a client. Swagger supports a variety of languages such as C#, Go, Javascript, and Python).

- [Example of generated C# code](example-c-sharp.md) for the top level IPAM & Subnet object.

- [Example of generated Go code](example-go.md) for the top level IPAM & Subnet object. Go is used by Docker and Kubernetes which are two of the consumers of the Host Compute Network Service APIs. Go has built-in support for marshaling Go types to and from JSON documents.

In addition to code generation and validation, you can use tools to simplify the work with JSON documents—that is, [Visual Studio Code](https://code.visualstudio.com/Docs/languages/json).

### Top-level objects defined in the HCN.Schemas.mars file
As mentioned above, you can find the document schema for documents used by the HCN APIs in a set of .mars files under:
onecore/vm/dv/net/hns/schema/mars/Schema

The top-level objects are:
- [HostComputeNetwork](hcn-scenarios.md#scenario-hcn)
- [HostComputeEndpoint](hcn-scenarios.md#scenario-hcn-endpoint)
- [HostComputeNamespace](hcn-scenarios.md#scenario-hcn-namespace)
- [HostComputeLoadBalancer](hcn-scenarios.md#scenario-hcn-load-balancer)

```
class HostComputeNetwork : HCN.Schema.Common.Base
{
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.NetworkMode          Type;
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.NetworkPolicy        Policies[];
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.MacPool              MacPool;
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.DNS                  Dns;
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.Ipam                 Ipams[];
};

class HostComputeEndpoint : HCN.Schema.Common.Base
{
    [NewIn("2.0"),OmitEmpty] string                                     HostComputeNetwork;
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.Endpoint.EndpointPolicy Policies[];
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.Endpoint.IpConfig       IpConfigurations[];
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.DNS                     Dns;
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Network.Route                   Routes[];
    [NewIn("2.0"),OmitEmpty] string                                     MacAddress;
};

class HostComputeNamespace : HCN.Schema.Common.Base
{
    [NewIn("2.0"),OmitEmpty] uint32                                    NamespaceId;
    [NewIn("2.0"),OmitEmpty] Guid                                      NamespaceGuid;
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Namespace.NamespaceType        Type;
    [NewIn("2.0"),OmitEmpty] HCN.Schema.Namespace.NamespaceResource    Resources[];
};

class HostComputeLoadBalancer : HCN.Schema.Common.Base
{
    [NewIn("2.0"), OmitEmpty] string                                               HostComputeEndpoints[]; 
    [NewIn("2.0"), OmitEmpty] string                                               VirtualIPs[]; 
    [NewIn("2.0"), OmitEmpty] HCN.Schema.Network.Endpoint.Policy.PortMappingPolicy PortMappings[]; 
    [NewIn("2.0"), OmitEmpty] HCN.Schema.LoadBalancer.LoadBalancerPolicy           Policies[];
};
```

## Next steps

- Learn more about the [common HCN scenarios](hcn-scenarios.md).

- Learn more about the [RPC context handles for HCN](hcn-declaration-handles.md).

- Learn more about the [HCN JSON document schemas](hcn-json-document-schemas.md).