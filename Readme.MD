# Bicep

## Setup

Setup you environment

## Git {.tabset .tabset-fade}

Setup Git   

### Windows
```windows
winget install --id=Git.Git
```
### Linux
```bash
sudo apt install git
```

## Azure CLI {.tabset .tabset-fade}

Setup Azure CLI

### Azure CLI for Windows
```windows
winget install --id=Microsoft.AzureCLI
```

### Azure CLI for Linux
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```


## What is Bicep?

Bicep is a Domain Specific Language (DSL) for deploying Azure resources declaratively. It aims to drastically simplify the authoring experience with a cleaner syntax, improved type safety, and better support for modularity and code re-use.

## Why Bicep?

Bicep is a **new** language that is: 

* **concise**: You can now deploy resources with fewer lines of code.
* **structured**: You are no longer required to build JSON strings. You can now use indentation and comments to structure your code.
* **strongly typed**: You no longer need to remember property names. Intellisense is available to show available properties.
* **self-describing**: You no longer need to reference documentation to understand what a property does.
* **composable**: You can now reference and parameterize templates and modules.
* **secure**: You no longer need to handle escaping quotes and other special characters. Bicep will take care of that for you.


## How do I get started?

You can get started by installing the Bicep CLI and VS Code extension. 
You can install the Bicep CLI by running the following command:

**Bash:**
```bash 
npm install -g @azure/bicep
```

**Powershell**
```Powershell
Install-Module -Name Bicep -Scope CurrentUser
```

You can install the Bicep VS Code extension by searching for "Bicep" in the VS Code Extensions Marketplace.

You can also try Bicep in the [Bicep Playground](https://aka.ms/bicepdemo).


## Documentation

You can find the full documentation for Bicep [here](https://aka.ms/bicepdocs).
