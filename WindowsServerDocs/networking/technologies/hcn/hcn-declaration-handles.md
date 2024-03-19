---
title: RPC context handles for HCN
description: Information about HCN Network entities, represented using HCN_NETWORK RPC context handles.
ms.topic: article
ms.author: daschott
author: daschott
ms.date: 04/01/2023

---

# RPC context handles for HCN

Applies to: Windows Server 2022, Windows Server 2019

## HCN_Network

An HCN Network is an entity that's used to represent a host compute network and its associated system resources and policies. An HCN network typically can include:

- A set of metadata (ID, name, type)
- A virtual switch
- A host virtual network adapter (acting as a default gateway for the network)
- A NAT instance (if required by the network type)
- A set of subnet and MAC pools
- Any network-wide policies to be applied (for example, ACLs)

HCN Network entities are represented using HCN_NETWORK RPC context handles.

```
/// Handle to an operation
DECLARE_HANDLE(HCN_NETWORK);
/// Return a list of existing Networks
///
/// \param  Query          Optionally specifies a JSON document for a query
///                        containing properties of the specific Networks to
///                        return. By default, all networks are returned.
/// \retval Networks       Receives a JSON document with the list of Networks.
/// \retval ErrorRecord    Optional, receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnEnumerateNetworks(
    _In_ PCWSTR Query,
    _Outptr_ PWSTR* Networks,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Create a Network
///
/// \param  Id             Specifies the unique ID for the new Network.
/// \param  Settings       JSON document specifying the settings of the new Network.
/// \retval Network        Receives a handle to the new network.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnCreateNetwork(
    _In_ REFGUID Id,
    _In_ PCWSTR Settings,
    _Out_ PHCN_NETWORK Network,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Opens a handle to an existing Network.
///
/// \param  Id             Unique ID of the existing network.
/// \retval Network        Receives a handle to the network.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnOpenNetwork(
    _In_ REFGUID Id,
    _Out_ PHCN_NETWORK Network,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Modify the settings of a Network
///
/// \param  Network        Handle to a network.
/// \param  Settings       JSON document specifying the new settings of the network.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnModifyNetwork(
    _In_ HCN_NETWORK Network,
    _In_ PCWSTR Settings,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Query Network properties
///
/// \param  Network        Handle to a network.
/// \param  Query          Optionally specifies a JSON document for a query
///                        containing specific properties of the network
///                        return. By default all properties are returned.
/// \retval Properties     Receives a JSON document with Network properties.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnQueryNetworkProperties(
    _In_ HCN_NETWORK Network,
    _In_ PCWSTR Query,
    _Outptr_ PWSTR* Properties,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Delete a Network
///
/// \param  Id             Unique ID of the existing network.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnDeleteNetwork(
    _In_ REFGUID Id,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Close a handle to a Network
///
/// \param  Network        Handle to a network.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnCloseNetwork(
    _In_ HCN_NETWORK Network
    );
```

## HCN_Endpoint

An HCN Endpoint is an entity that's used to represent an IP endpoint on an HCN network and its associated system resources and policies. An HCN endpoint typically consists of: 

- A set of metadata (ID, name, parent network ID)
- Its network identity (IP address, MAC address)
- Any endpoint specific policies to be applied (ACLs, routes)

HCN Endpoint entities are represented using HCN_ENDPOINT RPC context handles.

```
/// Handle to an operation
DECLARE_HANDLE(HCN_ENDPOINT);
/// Return a list of existing endpoints
///
/// \param  Query          Optionally specifies a JSON document for a query
///                        containing properties of the specific endpoints to
///                        return. By default all Endpoints are returned.
/// \retval Endpoints      Receives a JSON document with the list of endpoints.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnEnumerateEndpoints(
    _In_ PCWSTR Query,
    _Outptr_ PWSTR* Endpoints,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Create an Endpoint
///
/// \param  Id             Specifies the unique ID for the new endpoint.
/// \param  Network        Handle to the network on which endpoint is to be created.
/// \param  Settings       JSON document specifying the settings of the new endpoint.
/// \retval Endpoint       Receives a handle to the new endpoint.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnCreateEndpoint(
    _In_ HCN_NETWORK Network,
    _In_ REFGUID Id,
    _In_ PCWSTR Settings,
    _Out_ PHCN_ENDPOINT Endpoint,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Opens a handle to an existing Endpoint.
///
/// \param  Id             Unique ID of the existing endpoint.
/// \retval Endpoint       Receives a handle to the endpoint.
/// \retval ErrorRecord    Optional, receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnOpenEndpoint(
    _In_ REFGUID Id,
    _Out_ PHCN_ENDPOINT Endpoint,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Modify the settings of an Endpoint
///
/// \param  Endpoint       Handle to an endpoint.
/// \param  Settings       JSON document specifying the new settings of the endpoint.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnModifyEndpoint(
    _In_ HCN_ENDPOINT Endpoint,
    _In_ PCWSTR Settings,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Query Endpoint properties
///
/// \param  Endpoint       Handle to an endpoint.
/// \param  Query          Optionally specifies a JSON document for a query
///                        containing specific properties of the endpoint
///                        return. By default all properties are returned.
/// \retval Properties     Receives a JSON document with endpoint properties.
/// \retval ErrorRecord    Optional, receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnQueryEndpointProperties(
    _In_ HCN_ENDPOINT Endpoint,
    _In_ PCWSTR Query,
    _Outptr_ PWSTR* Properties,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Delete an Endpoint
///
/// \param  Id             Unique ID of the existing endpoint.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnDeleteEndpoint(
    _In_ REFGUID Id,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Close a handle to an endpoint
///
/// \param  Endpoint       Handle to an endpoint.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnCloseEndpoint(
    _In_ HCN_ENDPOINT Endpoint
    );
```

## HCN_Namespace

An HCN namespace is an entity that's used to represent a host compute network namespace. Namespaces allow you to have isolated network environments on a single host, where each namespace has its own network interfaces and routing table, separated from other namespaces.

HCN Namespace entities are represented using HCN_NAMESPACE RPC context handles.

```
/// Handle to an operation
DECLARE_HANDLE(HCN_NAMESPACE);
/// Return a list of existing namespaces
///
/// \param  Query          Optionally specifies a JSON document for a query
///                        containing properties of the specific namespaces to
///                        return. By default all Namespaces are returned.
/// \retval Namespaces     Receives a JSON document with the list of namespaces.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnEnumerateNamespaces(
    _In_ PCWSTR Query,
    _Outptr_ PWSTR* Namespaces,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Create a Namespace
///
/// \param  Id             Specifies the unique ID for the new namespace.
/// \param  Settings       JSON document specifying the settings of the new namespace.
/// \retval Namespace      Receives a handle to the new namespace.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnCreateNamespace(
    _In_ REFGUID Id,
    _In_ PCWSTR Settings,
    _Out_ PHCN_NAMESPACE Namespace,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Opens a handle to an existing namespace.
///
/// \param  Id             Unique ID of the existing namespace.
/// \retval Namespace      Receives a handle to the namespace.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnOpenNamespace(
    _In_ REFGUID Id,
    _Out_ PHCN_NAMESPACE Namespace,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Modify the settings of a namespace
///
/// \param  Namespace      Handle to a namespace.
/// \param  Settings       JSON document specifying the new settings of the namespace.
/// \retval ErrorRecord    Optional, receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnModifyNamespace(
    _In_ HCN_NAMESPACE Namespace,
    _In_ PCWSTR Settings,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Query Namespace properties
///
/// \param  Namespace      Handle to a namespace.
/// \param  Query          Optionally specifies a JSON document for a query
///                        containing specific properties of the namespace
///                        return. By default all properties are returned.
/// \retval Properties     Receives a JSON document with Namespace properties.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnQueryNamespaceProperties(
    _In_ HCN_NAMESPACE Namespace,
    _In_ PCWSTR Query,
    _Outptr_ PWSTR* Properties,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Delete a Namespace
///
/// \param  Id             Unique ID of the existing namespace.
/// \retval ErrorRecord    Optional. Receives a JSON document on failure with extended result
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnDeleteNamespace(
    _In_ REFGUID Id,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Close a handle to a Namespace
///
/// \param  Namespace      Handle to a namespace.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnCloseNamespace(
    _In_ HCN_NAMESPACE Namespace
    );
```

## HCN_LoadBalancer

An HCN load balancer is an entity that's used to represent a host compute network load balancer. Load balancers allow you to have load balanced host compute network endpoints.
HCN LoadBalancer entities are represented using HCN_LOADBALANCER RPC context handles.

```
/// Handle to an operation
DECLARE_HANDLE(HCN_LOADBALANCER);
//////
/// LoadBalancer methods
/// Return a list of existing load balancers
///
/// \param  Query          Optionally specifies a JSON document for a query
///                        containing properties of the specific load balancers to
///                        return. By default all load balancers are returned.
/// \retval LoadBalancers    Receives a JSON document with the list of load balancers.
/// \retval ErrorRecord    Optional. Receives a JSON document with extended errorCode
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnEnumerateLoadBalancers(
    _In_ PCWSTR Query,
    _Outptr_ PWSTR* LoadBalancer,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Create a load balancer
///
/// \param  Id             Specifies the unique ID for the new load balancer.
/// \param  Settings       JSON document specifying the settings of the new load balancer.
/// \retval LoadBalancer     Receives a handle to the new LoadBalancer.
/// \retval ErrorRecord    Optional. Receives a JSON document with extended errorCode
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnCreateLoadBalancer(
    _In_ REFGUID Id,
    _In_ PCWSTR Settings,
    _Out_ PHCN_LOADBALANCER LoadBalancer,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Opens a handle to an existing LoadBalancer.
///
/// \param  Id             Unique ID of the existing load balancer.
/// \retval LoadBalancer     Receives a handle to the load balancer.
/// \retval ErrorRecord    Optional. Receives a JSON document with extended errorCode
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnOpenLoadBalancer(
    _In_ REFGUID Id,
    _Out_ PHCN_LOADBALANCER LoadBalancer,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Modify the settings of a PolcyList
///
/// \param  PolcyList      Handle to a PolcyList.
/// \param  Settings       JSON document specifying the new settings of the PolcyList.
/// \retval ErrorRecord    Optional, receives a JSON document with extended errorCode
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnModifyLoadBalancer(
    _In_ HCN_LOADBALANCER LoadBalancer,
    _In_ PCWSTR Settings,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Query LoadBalancer properties
///
/// \param  LoadBalancer     Handle to a load balancer.
/// \param  Query          Optionally specifies a JSON document for a query
///                        containing specific properties of the load balancer
///                        return. By default all properties are returned.
/// \retval Properties     Receives a JSON document with LoadBalancer properties.
/// \retval ErrorRecord    Optional, receives a JSON document with extended errorCode
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnQueryLoadBalancerProperties(
    _In_ HCN_LOADBALANCER LoadBalancer,
    _In_ PCWSTR Query,
    _Outptr_ PWSTR* Properties,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Delete a LoadBalancer
///
/// \param  Id             Unique ID of the existing load balancer.
/// \retval ErrorRecord    Optional. Receives a JSON document with extended errorCode
///                        information. The caller must release the buffer using
///                        CoTaskMemFree.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnDeleteLoadBalancer(
    _In_ REFGUID Id,
    _Outptr_opt_ PWSTR* ErrorRecord
    );
/// Close a handle to a LoadBalancer
///
/// \param  LoadBalancer     Handle to a load balancer.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT
WINAPI
HcnCloseLoadBalancer(
    _In_ HCN_LOADBALANCER LoadBalancer
```

## HCN_Notification_Callback

These functions provide access to service-wide operations such as notifications (for example, receiving notifications of a new network creation).

```
/// Registers a callback function to receive notifications of service-wide events such as network
/// creations/deletions.
///
/// \param  Callback           Function pointer to notification callback.
/// \param  Context            Context pointer.
/// \retval CallbackHandle     Receives a handle to a callback registered on a service.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT WINAPI
HcnRegisterServiceCallback(
    _In_ HCN_NOTIFICATION_CALLBACK Callback,
    _In_ void* Context,
    _Out_ HCN_CALLBACK* CallbackHandle
    );
/// Unregisters from service-wide notifications
///
/// \retval CallbackHandle     Handle to a callback registered on a service.
///
/// \returns S_OK if successful; HResult error code on failures.
///
HRESULT WINAPI
HcnUnregisterServiceCallback(
    _In_ HCN_CALLBACK CallbackHandle
    );
```