# GetCryptoPrice_az_function
An Azure Powershell function that calls the free public CoinGecko API to pull data back vi an http trigger.
At the moment, this code will only run locally using Azure Development tools.

# Pre-requisites For Local Development Setup
* [PowerShell 7+](https://learn.microsoft.com/powershell/scripting/install/installing-powershell)
* [Azure Functions Core Tools v4](https://learn.microsoft.com/azure/azure-functions/functions-run-local)
* [.NET SDK 6 or higher](https://dotnet.microsoft.com/en-us/download/dotnet)


# Running this function locally

Clone this repo

From the root of the repo run:
```
func start
```
Call this function using curl or in a browser by going to:
``` 
http://localhost:7071/api/GetCryptoPrice
```
The default crypto currency is bitcoin, but other coins can be requested using the coin attribute like:
```
http://localhost:7071/api/GetCryptoPrice?coin=tether?coin=ethereum
```
