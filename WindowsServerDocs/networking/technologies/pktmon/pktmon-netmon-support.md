---
title: Pktmon support for Microsoft Network Monitor (Netmon)
description: Describes how to install and configure Microsoft Network Monitor (Netmon) to read Pktmon-generated ETL files.
ms.topic: how-to
author: khdownie
ms.author: wscontent
ms.date: 10/27/2021
---

# Pktmon support for Microsoft Network Monitor (Netmon)

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack Hub, Azure, Azure Stack HCI, versions 21H2 and 20H2

Packet Monitor (Pktmon) generates logs in ETL format. These logs can be analyzed using Microsoft Network Monitor (Netmon) by using special parsers. This topic explains how to analyze Packet Monitor-generated ETL files within Netmon.

## Network Monitor setup and configuration

Follow these steps to install and configure Netmon to parse Packet Monitor-generated ETL files:

   1. [Install Network Monitor 3.4](https://www.microsoft.com/download/details.aspx?id=4865).
   1. Start Network Monitor elevated and set Windows as Active parser profile at (Tools / Options / Parser Profiles).
   1. Copy etl_Microsoft-Windows-PktMon-Events.npl from [here](https://github.com/microsoft/NetMon_Parsers_for_PacketMon/blob/main/etl_Microsoft-Windows-PktMon-Events.npl) to "%PROGRAMDATA%\Microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Windows"
   1. Copy stub_etl_Microsoft-Windows-PktMon-Events.npl from [here](https://github.com/microsoft/NetMon_Parsers_for_PacketMon/blob/main/stub_etl_Microsoft-Windows-PktMon-Events.npl) to "%PROGRAMDATA%\Microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Windows\Stubs"
   1. Rename stub_etl_Microsoft-Windows-PktMon-Events.npl to etl_Microsoft-Windows-PktMon-Events.npl
   1. Include etl_Microsoft-Windows-PktMon-Events.npl into NetworkMonitor_Parsers_sparser.npl at "%PROGRAMDATA%\Microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers"
   1. Restart Network Monitor elevated for rebuilding the parsers.

