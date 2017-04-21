---
title: wecutil
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0c82a6cb-d652-429c-9c3d-0f568c78d54b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# wecutil

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables you to create and manage subscriptions to events that are forwarded from remote computers, which support WS-Management protocol. For examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
wecutil  [{es | enum-subscription}] 
[{gs | get-subscription} <Subid> [/f:<format>] [/uni:<Unicode>]] 
[{gr | get-subscriptionruntimestatus} <Subid> [<Eventsource>  ]] 
[{ss | set-subscription} [<Subid> [/e:[<Subenabled>]] [/esa:<address>] [/ese:[<Srcenabled>]] [/aes] [/res] [/un:<Username>] [/up:<Password>] [/d:<Desc>] [/uri:<Uri>] [/cm:<Configmode>] [/ex:<Expires>] [/q:<query>] [/dia:<Dialect>] [/tn:<Transportname>] [/tp:<Transportport>] [/dm:<deliverymode>] [/dmi:<deliverymax>] [/dmlt:<deliverytime>] [/hi:<Heartbeat>] [/cf:<Content>] [/l:<Locale>] [/ree:[<Readexist>]] [/lf:<Logfile>] [/pn:<Publishername>] [/essp:<Enableport>] [/hn:<hostname>] [/ct:<type>]] [/c:<Configfile> [/cun:<Username> /cup:<Password>]]] 
[{cs | create-subscription} <Configfile> [/cun:<Username> /cup:<Password>]] 
[{ds | delete-subscription} <Subid>] 
[{rs | retry-subscription} <Subid> [<Eventsource> ]] 
[{qc | quick-config} [/q:[<Quiet>]]].
```
## Parameters
|Parameter|Description|
|-------|--------|
|{es &#124; enum-subscription}|Displays the names of all remote event subscriptions that exist.|
|{gs &#124; get-subscription} <Subid> [/f:<format>] [/uni:<Unicode>]|Displays remote subscription configuration information. <Subid> is a string that uniquely identifies a subscription. <Subid> is the same as the string that was specified in the <SubscriptionId> tag of the XML configuration file, which was used to create the subscription.|
|{gr &#124; get-subscriptionruntimestatus} <Subid> [<Eventsource>  ]|Displays the runtime status of a subscription. <Subid> is a string that uniquely identifies a subscription. <Subid> is the same as the string that was specified in the <SubscriptionId> tag of the XML configuration file, which was used to create the subscription. <Eventsource> is a string that identifies a computer that serves as a source of events. <Eventsource> should be a fully qualified domain name, a NetBIOS name, or an IP address.|
|{ss &#124; set-subscription} <Subid> [/e:[<Subenabled>]] [/esa:<address>] [/ese:[<Srcenabled>]] [/aes] [/res] [/un:<Username>] [/up:<Password>] [/d:<Desc>] [/uri:<Uri>] [/cm:<Configmode>] [/ex:<Expires>] [/q:<query>] [/dia:<Dialect>] [/tn:<Transportname>] [/tp:<Transportport>]  [/dm:<deliverymode>] [/dmi:<deliverymax>] [/dmlt:<deliverytime>] [/hi:<Heartbeat>] [/cf:<Content>] [/l:<Locale>] [/ree:[<Readexist>]] [/lf:<Logfile>] [/pn:<Publishername>] [/essp:<Enableport>] [/hn:<hostname>] [/ct:<type>]<br /><br />or<br /><br />{ss &#124; set-subscription /c:<Configfile> [/cun:<Comusername> /cup:<compassword>]|changes the subscription configuration. You can specify the subscription ID and the appropriate options to change subscription parameters, or you can specify an XML configuration file to change subscription parameters.|
|{cs &#124; create-subscription} <Configfile> [/cun:<Username> /cup:<Password>]|creates a remote subscription. <Configfile> specifies the path to the XML file that contains the subscription configuration. The path can be absolute or relative to the current directory.|
|{ds &#124; delete-subscription} <Subid>|deletes a subscription and unsubscribes from all event sources that deliver events into the event log for the subscription. Any events already received and logged are not deleted. <Subid> is a string that uniquely identifies a subscription. <Subid> is the same as the string that was specified in the <SubscriptionId> tag of the XML configuration file, which was used to create the subscription.|
|{rs &#124; retry-subscription} <Subid> [<Eventsource> ]|Retries to establish a connection and send a remote subscription request to an inactive subscription. attempts to reactivate all event sources or specified event sources. Disabled sources are not retried. <Subid> is a string that uniquely identifies a subscription. <Subid> is the same as the string that was specified in the <SubscriptionId> tag of the XML configuration file, which was used to create the subscription. <Eventsource> is a string that identifies a computer that serves as a source of events. <Eventsource> should be a fully qualified domain name, a NetBIOS name, or an IP address.|
|{qc &#124; quick-config} [/q:[<Quiet>]]|Configures the Windows Event Collector service to ensure a subscription can be created and sustained through reboots. This includes the following steps:<br /><br />1.  Enable the forwardedEvents channel if it is disabled.<br />2.  Set the Windows Event Collector service to delay start.<br />3.  start the Windows Event Collector service if it is not running.|
## Options
|Option|Description|
|-----|--------|
|/f:<format>|Specifies the format of the information that is displayed. <format> can be XML or Terse. If <format> is XML, the output is displayed in XML format. If <format> is Terse, the output is displayed in name-value pairs. The default is Terse.|
|/c:<Configfile>|Specifies the path to the XML file that contains a subscription configuration. The path can be absolute or relative to the current directory. This option can only be used with the **/cun** and **/cup** options and is mutually exclusive with all other options.|
|/e:[<Subenabled>]|Enables or disables a subscription. <Subenabled> can be true or false. The default value of this option is true.|
|/esa:<address>|Specifies the address of an event source. <address> is a string that contains a fully qualified domain name, a NetBIOS name, or an IP address, which identifies a computer that serves as a source of events. This option should be used with the **/ese**, **/aes**, **/res**, or **/un** and **/up** options.|
|/ese:[<Srcenabled>]|Enables or disables an event source. <Srcenabled> can be true or false. This option is allowed only if the **/esa** option is specified. The default value of this option is true.|
|/aes|adds the event source that is specified by the **/esa** option if it is not already a part of the subscription. If the address specified by the **/esa** option is already a part of the subscription, an error is reported. This option is only allowed if the **/esa** option is specified.|
|/res|removes the event source that is specified by the **/esa** option if it is already a part of the subscription. If the address specified by the **/esa** option is not a part of the subscription, an error is reported. This option is only allowed if **/esa** option is specified.|
|/un:<Username>|Specifies the user credential to use with the event source specified by the **/esa** option. This option is only allowed if the **/esa** option is specified.|
|/up:<Password>|Specifies the password that corresponds to the user credential. This option is only allowed if the **/un** option is specified.|
|/d:<Desc>|Provides a description for the subscription.|
|/uri:<Uri>|Specifies the type of the events that are consumed by the subscription. <Uri> contains a URI string that is combined with the address of the event source computer to uniquely identify the source of the events. The URI string is used for all event source addresses in the subscription.|
|/cm:<Configmode>|Sets the configuration mode. <Configmode> can be one of the following strings: Normal, Custom, MinLatency or MinBandwidth. The Normal, MinLatency, and MinBandwidth modes set delivery mode, delivery max items, heartbeat interval, and delivery max latency time. The **/dm**, **/dmi**, **/hi** or **/dmlt** options may only be specified if the configuration mode is set to Custom.|
|/ex:<Expires>|Sets the time when the subscription expires. <Expires> should be defined in standard XML or ISO8601 date-time format: yyyy-MM-ddThh:mm:ss[.sss][Z], where T is the time separator and Z indicates UTC time.|
|/q:<query>|Specifies the query string for the subscription. The format of <query> may be different for different URI values and applies to all sources in the subscription.|
|/dia:<Dialect>|Defines the dialect that the query string will use.|
|/tn:<Transportname>|Specifies the name of the transport that is used to connect to a remote event source.|
|/tp:<Transportport>|Sets the port number that is used by the transport when connecting to a remote event source.|
|/dm:<deliverymode>|Specifies the delivery mode. <deliverymode> can be either pull or push. This option is only valid if the **/cm** option is set to Custom.|
|/dmi:<deliverymax>|Sets the maximum number of items for batched delivery. This option is only valid if **/cm** is set to Custom.|
|/dmlt:<deliverytime>|Sets the maximum latency in delivering a batch of events. <deliverytime> is the number of milliseconds. This option is only valid if **/cm** is set to Custom.|
|/hi:<Heartbeat>|Defines the heartbeat interval. <Heartbeat> is the number of milliseconds. This option is only valid if **/cm** is set to Custom.|
|/cf:<Content>|Specifies the format of the events that are returned. <Content> can be Events or renderedText. When the value is renderedText, the events are returned with the localized strings (such as event description) attached to the event. The default value is renderedText.|
|/l:<Locale>|Specifies the locale for delivery of the localized strings in renderedText format. <Locale> is a language and country/region identifier, for example, "EN-us". This option is only valid if the **/cf** option is set to renderedText.|
|/ree:[<Readexist>]|Identifies the events that will be delivered for the subscription. <Readexist> can true or false. When the <Readexist> is true, all existing events are read from the subscription event sources. When the <Readexist> is false, only future (arriving) events are delivered. The default value is true for a **/ree** option without a value. If no **/ree** option is specified, the default value is false.|
|/lf:<Logfile>|Specifies the local event log that is used to store events received from the event sources.|
|/pn:<Publishername>|Specifies the publisher name. It must be a publisher that owns or imports the log specified by the **/lf** option.|
|/essp:<Enableport>|Specifies that the port number must be appended to the service principal name of the remote service. <Enableport> can be true or false. The port number is appended when <Enableport> is true. When the port number is appended, some configuration may be required to prevent the access to event sources from being denied.|
|/hn:<hostname>|Specifies the DNS name of the local computer. This name is used by remote event source to push back events and must be used only for a push subscription.|
|/ct:<type>|Sets the credential type for the remote source access. <type> should be one of the following values: default, negotiate, digest, basic or localmachine. The default value is default.|
|/cun:<Comusername>|Sets the shared user credential to be used for event sources that do not have their own user credentials. If this option is specified with the **/c** option, UserName and UserPassword settings for individual event sources from the configuration file are ignored. If you want to use a different credential for a specific event source, you should override this value by specifying the **/un** and **/up** options for a specific event source on the command line of another **ss** command.|
|/cup:<compassword>|Sets the user password for the shared user credential. When <compassword> is set to \* (asterisk), the password is read from the console. This option is only valid when the **/cun** option is specified.|
|/q:[<Quiet>]|Specifies whether the configuration procedure will prompt for confirmation. <Quiet> can be true or false. If <Quiet> is true, the configuration procedure will not prompt for confirmation. The default value of this option is false.|
## remarks
> [!IMPORTANT]
> if you receive the message,  The RPC server is unavailable  when you try to run wecutil, you need to start the Windows Event Collector service (wecsvc). To start wecsvc, at an elevated command prompt type net start wecsvc.
-   The following example shows the contents of a configuration file:
    ```
    <Subscription xmlns="http://schemas.microsoft.com/2006/03/windows/events/subscription">
    <Uri>http://schemas.microsoft.com/wbem/wsman/1/windows/EventLog</Uri>
    <!- Use Normal (default), Custom, MinLatency, MinBandwidth ->
    <Configurationmode>Normal</Configurationmode>
    <Description>forward Sample Subscription</Description>
    <SubscriptionId>SampleSubscription</SubscriptionId>
    <query><![cdatA[
    <querylist>
    <query path="Application">
    <select>*</select>
    </query>
    </querylist>
    ]]></query>
    <EventSources>
    <EventSource Enabled="true">
    <address>mySource.myDomain.com</address>
    <UserName>myUserName</UserName>
    <Password>*</Password>
    </EventSource>
    </EventSources>
    <Credentialstype>Default</Credentialstype>
    <Locale Language="EN-US"></Locale>
    </Subscription>
    ```
## <a name="BKMK_examples"></a>Examples
Output configuration information for a subscription named sub1:
```
wecutil gs sub1
```
Example output:
```
EventSource[0]:
address: localhost
Enabled: true
Description: Subscription 1
Uri: wsman:microsoft/logrecord/sel
deliverymode: pull
deliveryMaxSize: 16000
deliveryMaxItems: 15
deliveryMaxLatencytime: 1000
HeartbeatInterval: 10000
Locale:
Contentformat: renderedtext
LogFile: HardwareEvents
```
Display the runtime status of a subscription named sub1:
```
wecutil gr sub1
```
Update the subscription configuration named sub1 from a new XML file called WsSelRg2.xml:
```
wecutil ss sub1 /c:%Windir%\system32\WsSelRg2.xml
```
Update the subscription configuration named sub2 with multiple parameters:
```
wecutil ss sub2 /esa:mycomputer /ese /un:uname /up:* /cm:Normal
```
create a subscription to forward events from a Windows Vista Application event log of a remote computer at mySource.myDomain.com to the forwardedEvents log (see remarks for an example of a configuration file):
```
wecutil cs subscription.xml
```
delete a subscription named sub1:
```
wecutil ds sub1
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
