---
title: Using Anycast DNS for performance and redundancy
description: This topic is part of the DNS Policy Scenario Guide for Windows Server 2016
manager: brianlic
ms.prod: windows-server
ms.technology: networking-dns
ms.topic: article
ms.assetid: f9c313ac-bb86-4e48-b9b9-de5004393e06
ms.author: lizross
author: eross-msft
---
# Using Anycast DNS for performance and redundancy

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2019

This topic provides information about how DNS Anycast works and how to configure it.

## What is DNS Anycast?

DNS Anycast is a method that enables a specified DNS server, or one of a group of servers, to respond to a DNS query based on the geographical location of a DNS client. By using DNS Anycast, you can enhance DNS response time and greatly simplify DNS client settings. DNS Anycast also provides an extra layer of redundancy and can help protect against DNS denial of service attacks. 

## How Anycast DNS works

DNS Anycast works by using routing protocols such as Border Gateway Protocol (BGP) or Open Shortest Path First (OSPF) for WAN or LAN routing, respectively. DNS servers that exist in multiple locations all advertise the same IP address from their local gateway (router). When a query is initiated from a client, the client gateway evaluates which of the routes to the destination is the shortest, and sends the DNS query to that location.

## Example of Anycast DNS

Following is an example of how you can use Anycast DNS.

Something

The following illustration depicts this scenario.

![graphic](../../media/graphic.jpg)




### How to Configure Anycast DNS

The following sections show you how to configure Anycast DNS.

#### One

