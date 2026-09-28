---
title: Local AI Inference for Windows Server
description: Distributed AI inference on Windows Server lets remote clients share a model endpoint that your organization operates centrally. Compare inference approaches and plan infrastructure.
author: robinharwood
ms.author: roharwoo
ms.topic: concept-article
ms.service: windows-server
ms.date: 09/25/2026
ai-usage: ai-assisted

#customer intent: As a Windows Server administrator or developer, I want to understand distributed, embedded, and on-device inference so that I can choose how applications and tools consume models in my environment.
---

# AI inference on Windows Server

**Local AI inference** is the process of running a trained AI model on infrastructure that you or your organization controls. The primary Windows Server scenario is distributed inference: an OpenAI-compatible model server runs on Windows Server, and remote clients send requests to its endpoint over the network. For example, Visual Studio Code on a Windows 11 workstation can send prompts to the server and receive generated output.

Organizations use distributed inference to give multiple clients access to shared model compute while controlling where requests and outputs travel. That control depends on the endpoint location, network path, client configuration, model acquisition, diagnostics, and other services in the solution.

This article helps Windows Server administrators and developers decide when to use local inference and identify the infrastructure considerations for that choice.

## How AI inference works on Windows Server

Using local AI inference on Windows Server, remote applications and tools connect to the model server's network address, send requests, and receive responses. The clients don't load or run the model locally.

This topology gives Windows Server a distinct role. The server centralizes compute and GPU capacity, model storage and hosting, network access, service operations, and capacity management for multiple clients. Administrators operate the shared service and its infrastructure, while developers configure clients for the endpoint's base URL, model identifier, supported API, and authentication method.

The solution contains these elements:

- **Remote client**: An application, development tool, or administrative tool that sends prompts or other model input over the network. Clients can run on Windows 11, Windows Server, or another supported platform.
- **Interface**: An SDK or HTTP API that defines request and response formats. Many shared runtimes expose OpenAI-compatible APIs for example.
- **Model server and model**: The server-oriented runtime that loads a trained model, schedules inference requests, and returns output through the endpoint.
- **Windows Server infrastructure**: The physical host or virtual machine, processor, memory, storage, GPU resources, network, and management tools that support and expose the shared workload.

An endpoint implements one or more API formats that clients use, but compatibility doesn't mean that every endpoint supports every capability. Clients might require specific routes, model identifiers, streaming behavior, tool or function calling, authentication methods, or request fields. Confirm both the client requirements and endpoint capabilities before you connect them.

Embedded inference has a different boundary. The application loads and runs the model on the same device, often in the application process, instead of calling a model server. Windows ML provides this application inference framework for ONNX models. Foundry Local also targets on-device workflows. The Foundry Local SDK embeds the runtime in an application, and its command-line interface manages models and a local service on one device. These options can run on Windows Server hardware, but they don't by themselves provide a distributed inference service that administrators operate centrally for multiple clients.

## Choose your inference approach

Choose an approach based on where inference runs, how many clients need the model, and who operates the runtime. Use Windows Server as a shared endpoint to centralize models and compute for remote clients. This approach adds network, security, capacity, and availability requirements. Alternatively, use embedded or on-device inference in Windows Server when one application or device should own the runtime and model lifecycle.

| Approach | Best fit | Operational model | Important boundaries |
| --- | --- | --- | --- |
| Windows Server endpoint | Multiple remote applications or tools that consume a model service that a central operations team manages | A model server on Windows Server owns model loading, request scheduling, concurrency, and the API. Remote clients use the endpoint base URL, model identifier, and authentication settings that their organization approves. | The product that you select determines runtime installation, endpoint deployment, API support, and scale characteristics. This article assumes that the endpoint exists and clients can reach it. |
| [Windows ML](/windows/ai/new-windows-ml/overview) | Windows applications that run ONNX models on the same device | The application uses the ONNX Runtime that Windows supports, either as a shared system component or self-contained with the application. Optional execution providers use available CPU, GPU, or NPU resources. | Windows ML is an application inference framework, not an OpenAI-compatible model-serving endpoint. Execution-provider, driver, hardware, and model requirements vary. |
| [Foundry Local](/azure/foundry-local/get-started) | Applications and development workflows that need single-device, on-device inference and a curated model catalog | The application typically runs inference in-process through the SDK. The Foundry Local CLI can manage models and a local service on the device. | Foundry Local can run on server hardware, but its design doesn't target multi-user server inference. It doesn't provide concurrent request queuing, continuous batching, or efficient GPU sharing for many simultaneous clients. |

The approaches aren't mutually exclusive across an organization. One application might embed an ONNX model through Windows ML, a developer might use Foundry Local on one workstation, and remote development tools and business applications might use a shared endpoint on Windows Server. Treat each path as a separate workload with its own model, hardware, security, and support requirements.

## Plan Windows Server infrastructure for AI inference

Model architecture, parameter count, quantization, context length, request concurrency, and latency targets determine the required compute and memory. Some models run on a CPU, while other workloads benefit from GPU acceleration. A GPU isn't a prerequisite for every inference solution.

For a workload on a physical Windows Server host, the runtime can use hardware and APIs that Windows Server and the hardware vendor support. For a workload in a Hyper-V virtual machine, select an appropriate GPU virtualization option. [Plan for GPU acceleration in Windows Server](../virtualization/hyper-v/plan/plan-for-gpu-acceleration-in-windows-server.md) compares direct host access, Discrete Device Assignment (DDA), GPU partitioning, and Windows container scenarios. GPU partitioning is available in Windows Server 2025 or later and is an optional infrastructure choice.

Also plan for these resources:

- **Memory and GPU memory**: Account for the loaded model, context and cache requirements, concurrent requests, and other processes on the host.
- **Storage**: Provide capacity and access controls for model files, runtime packages, logs, and temporary data. Model acquisition can require an external network connection even when inference runs locally.
- **Network**: For a shared endpoint, estimate bandwidth and latency between clients and the endpoint. Define which networks and hosts can reach the service.
- **Availability and capacity**: Decide how clients behave when the endpoint is unavailable or operating at capacity. Validate concurrency and throughput with representative models and requests before production use.

## Secure and operate AI inference on Windows Server

Local placement doesn't provide a security boundary by itself. Define the boundary that prompts, retrieved data, model files, outputs, logs, and diagnostics must remain within, and then verify every component against that boundary.

Protect network traffic with approved TLS settings, authenticate and authorize clients, restrict endpoint access with network controls, and store credentials in an approved secret store. Don't put credentials in source files or tool configuration that other users can read. Review model licenses and acquisition sources before you deploy model files.

Validate model output before you rely on it. Maintain appropriate human oversight for consequential actions or decisions.

Manage the Windows Server infrastructure through your established administration tools, including Windows Admin Center when it supports the required operations. Follow the runtime documentation for model lifecycle and endpoint-specific operations. At minimum, plan to observe endpoint health, request latency, throughput, failures, CPU and memory use, GPU utilization and memory use when applicable, and storage capacity. Available metrics and management operations vary by runtime, so this article doesn't prescribe a single observability implementation.

## Common local AI inference scenarios

Local inference can support developer, administrator, and application workloads while keeping the inference path within an organization's selected boundary.

- **Coding assistance**: Connect a supported development tool, such as Visual Studio Code on Windows 11, to an existing endpoint on Windows Server for code explanation, generation, review, or troubleshooting. Source code and prompts travel over the network to that endpoint, so include the network path, endpoint, and its operators in the data boundary.
- **Administrative assistance**: Connect an administrative tool to a model that can explain or propose commands. Review generated commands and understand their effects before you run them, especially when they change system state.
- **Document processing**: Use an application to summarize, classify, extract, or index documents with a local model. The application remains responsible for authorization to source documents and generated output.
- **Conversational applications**: Add chat or question-answering experiences to an existing application. The application can combine a model endpoint with authorized enterprise data, but it must enforce access controls independently of the model.

## Next steps for local AI inference on Windows Server

- [Configure GitHub Copilot CLI for local inference](configure-github-copilot-cli-local-inference.md)
- [Configure Visual Studio Code to use a local model endpoint](configure-visual-studio-code-local-models.md)
- [Connect Intelligent Terminal Preview to a local model endpoint](configure-intelligent-terminal-local-language-model.md)
- [Connect to OpenAI-compatible endpoints with Microsoft Agent Framework](/agent-framework/hosting/self-hosting/openai-endpoints)
- [Run ONNX models by using Windows ML](/windows/ai/new-windows-ml/run-onnx-models)
- [Integrate inference SDKs with Foundry Local](/azure/foundry-local/how-to/how-to-integrate-with-inference-sdks)