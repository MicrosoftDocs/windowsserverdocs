---
title: Pktmon support for Microsoft Network Monitor (Netmon)
description: Use this page to analyze Packet Monitor-generated ETL files within Netmon.
ms.topic: how-to
author: khdownie
ms.author: v-kedow
ms.date: 11/3/2020
---

# Pktmon support for Microsoft Network Monitor (Netmon)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Packet Monitor (Pktmon) generates logs in ETL format. These logs can be analyzed using Microsoft Network Monitor (Netmon) by using special parsers. This topic explains how to analyze Packet Monitor-generated ETL files within Netmon.

## Network Monitor setup and configuration

Follow these steps to install and configure Netmon to parse Packet Monitor-generated ETL files:

   1. [Install Network Monitor 3.4](/download/4865).
   1. Start Network Monitor elevated and set Windows as Active parser profile at (Tools / Options / Parser Profiles).
   1. Copy etl_Microsoft-Windows-PktMon-Events.npl from [here](https://github.com/microsoft/NetMon_Parsers_for_PacketMon/blob/main/etl_Microsoft-Windows-PktMon-Events.npl) to "%PROGRAMDATA%\Microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Windows"
   1. Copy stub_etl_Microsoft-Windows-PktMon-Events.npl from [here](https://github.com/microsoft/NetMon_Parsers_for_PacketMon/blob/main/stub_etl_Microsoft-Windows-PktMon-Events.npl) to "%PROGRAMDATA%\Microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Windows\Stubs"
   1. Rename stub_etl_Microsoft-Windows-PktMon-Events.npl to etl_Microsoft-Windows-PktMon-Events.npl
   1. Include etl_Microsoft-Windows-PktMon-Events.npl into NetworkMonitor_Parsers_sparser.npl at "%PROGRAMDATA%\Microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers"
   1. Restart Network Monitor elevated for rebuilding the parsers.

## Generate Network Monitor parser from ETW manifest

   1. Use ETLConvertor.exe from here on your ETW manifest file.
   1. Follow instructions in README.md
   1. Replace BLOB data types in generated NPL file. Use [DataFieldByteOrder = BigEndian] field specification where necessary.
   1. Copy generated NPLs to "%PROGRAMDATA%\Microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Windows"
   1. Restart Network Monitor elevated for rebuilding the parsers.
