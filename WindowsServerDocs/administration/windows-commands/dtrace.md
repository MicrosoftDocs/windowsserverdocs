---
title: DTrace
description: DTrace is a dynamic tracing framework that allows users to monitor and debug system performance for Windows and other operating systems.
ms.topic: reference
author: xelu86
ms.author: wscontent
ms.date: 03/28/2024
---

# DTrace

Beginning with Windows Server 2025, `dtrace` is included as a built-in tool. DTrace is a command-line utility that allows users to monitor and debug their system performance in real-time. With `dtrace`, users can dynamically instrument the kernel and user-space code without modifying the code itself. This powerful tool supports various data collection and analysis techniques, including aggregations, histograms, and tracing of user-level events.

Probes can be specified in `dtrace` scripts where the script defines the probes to be monitored and the actions to be taken when the probes fire. Actions can include printing output, recording data, or other operations, such as sending a signal or modifying a variable. A probe is a specific point in the code where data can be collected to perform these actions.

## Syntax

```
dtrace [-BCeFhlqSvVwYZ] [-b bufsz] [-c cmd] [-D name[=def]] [-I path]
[-L path] [-o output] [-p pid] [-s script] [-U name] [-x opt[=val]] [-X a|c|s|t]
[-y symbol path]

[-P provider [[ predicate ] action ]] [-m [ provider: ]
module [[ predicate ] action ]] [-f [[ provider: ] module: ]
func [[ predicate ] action ]] [-n [[[ provider: ] module: ] func: ]
name [[ predicate ] action ]] [-i probe-id [[ predicate ] action ]] [ args ... ]
```

> [!NOTE]
> The parameters for dtrace.exe are _case-sensitive_. Make sure to use the correct casing when specifying parameters to avoid any unexpected behavior.

| Parameter | Description |
|-|-|
| -b `<bufsz>` | Sets the size of the buffer used to store trace data, where _bufsz_ is the desired size of the buffer in bytes, kilobytes (**k**), megabytes (**m**), or gigabytes (**g**). |
| -c `<cmd>` | Runs the specified command and exits once it completes, where _cmd_ is the command that you want to run before starting the trace. |
| -C | Runs the **ucpp** preprocessor on script files before running dtrace. |
| -D `<name>` =`<def>` | Defines a symbol when invoking the preprocessor, where _name_ is the name of the symbol to define, and _def_ is an optional value to assign to the symbol. |
| -e | Exits after compiling a request but before enabling probes. |
| -f | Enables or lists probes that match the specified function name. |
| -F | Combines the trace output by function, making it easier to analyze. |
| -h | Generates a header file with definitions for static probes. |
| -i `<probe-id>` | Enables or lists probes that match the specified probe ID, where _probe-id_ is the identifier for the probe to be traced. |
| -I `<path>` | Adds the specified directory to the preprocessor search path, where _path_ is the directory that you want to add. |
| -l | Lists probes that match specified criteria. |
| -L `<path>` | Adds the specified directory to the library search path, where _path_ is the directory that you want to add. |
| -m | Enables or lists probes that match the specified module name. |
| -n | Enables or lists probes that match the specified probe name. |
| -o `<output>` | Sets the output file for the trace data, where _output_ is the name of the file that you want to use for the trace data. |
| -p `<pid>` | Grabs the specified process ID and caches its symbol tables, which can be used to analyze the program's behavior, where _pid_ is the process ID. |
| -P `<provider>` | Enables or lists probes that match the specified provider name, where _provider_ is the name of the provider. |
| -q | Sets quiet mode, which only outputs explicitly traced data. |
| -s `<script>` | Enables or lists probes according to the specified D-language script, where _script_ is the name of the script that you want to run. |
| -S | Prints the D-language compiler intermediate code for debugging. |
| -U `<name>` | Undefines a symbol when invoking the preprocessor, where _name_ is the name of the symbol that you want to undefine. |
| -v | Sets verbose mode, which reports stability attributes and arguments. |
| -V | Displays the version of the dtrace API. |
| -w | Permits destructive actions, such as modifying system state. |
| -x `<opt>` =`<val>` | Enables or modifies the compiler and tracing options, where _opt_ is the name of the option that you want to enable or modify, and _val_ is an optional value. |
| -X `<a\|c\|s\|t>` | Sets the stability level of a dtrace feature. The stability level is an important consideration when used in production environments as depending on which level is used can produce different results. <br> <ul><li> `a`: Sets the stability level to `alpha`, which means that the feature is still under development and is subject to change. It may not be fully functional or may have bugs. Features with an alpha stability level aren't recommended for production use. <li> `c`: Sets the stability level to `current`, which means that the feature is stable and isn't expected to change in future releases. Features with a current stability level are safe to use in production environments. <li> `s`: Sets the stability level to `stable`, which means that the feature is stable and won't change in future releases, but may be removed in a future release. Features with a stable stability level are safe to use in production environments, but may require changes if they're removed in a future release. <li> `t`: Sets the stability level to `testing`, which means that the feature is available for testing but isn't yet stable. Features with a testing stability level aren't recommended for production use.</ul></li> |
| -y `<symbol path>` | Sets the symbol search path for the dtrace script to resolve, where _symbol path_ is the path to the shared library or directory that contains the symbols. |
| -Y | Uses the default symbol search path for the dtrace script. |
| -Z | Permits probe descriptions that match zero probes for debugging. |

The following list describes the remaining descriptions:

- **Predicate**: A D-language expression that is evaluated each time a probe fires. If the predicate evaluates to true, the associated action is executed. Predicates can be used to filter the output of `dtrace` based on certain conditions, such as the value of a variable or the occurrence of an event.

- **Action**: A D-language expression that is executed when a probe fires and its associated predicate, if any, evaluates to true. Actions can be used to print output, record data, or perform other operations, such as sending a signal or modifying a variable.

- **Module**: A component of a provider that contains a set of related probes. For example, the `syscall` provider has modules for different types of system calls, such as `read` and `write`. Modules can be specified in `dtrace` scripts to limit the scope of the script to a specific module or set of modules.

- **Func**: A function name that is associated with a probe. For example, the `syscall::read` probe is associated with the `read` function. Functions can be specified in `dtrace` scripts to limit the scope of the script to a specific function or set of functions.

- **Args**: The arguments that are passed to the action expression when a probe fires and its associated predicate, if any, evaluates to true. Args can be used to capture data from the probe context, such as the values of function arguments or system call return values. Args can also be used to pass data between probes or to modify the behavior of the script.

## Examples

## See also

- [DTrace on Windows](/windows-hardware/drivers/devtest/dtrace)
- [DTrace Programming](/windows-hardware/drivers/devtest/dtrace-programming)
- [DTrace Code Samples](/windows-hardware/drivers/devtest/dtrace-code-samples)
- [DTrace Event Tracing for Windows](/windows-hardware/drivers/devtest/dtrace-etw)
- [DTrace Live Dump](/windows-hardware/drivers/devtest/dtrace-live-dump)
