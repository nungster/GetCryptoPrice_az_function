using namespace System.Net

param($Request, $TriggerMetadata)

# ---------------------------------------------------------------------------------
# STEP 1: Parse input from query string
# Example call: GET http://localhost:7071/api/GetCryptoPrice?coin=bitcoin
# If no coin specified, use bitcoin as a default
# ---------------------------------------------------------------------------------
$coin = $Request.Query.coin
if (-not $coin) { $coin = "bitcoin" }

# ---------------------------------------------------------------------------------
# STEP 2: Build API URL
# We'll use CoinGecko’s free public API
# For a list of supported currncies call: GET https://api.coingecko.com/api/v3/coins/list
# ---------------------------------------------------------------------------------
$apiUrl = "https://api.coingecko.com/api/v3/simple/price?ids=$coin&vs_currencies=usd"

# ---------------------------------------------------------------------------------
# STEP 3: Call public API
# Invoke-RestMethod gets JSON back from the service
# ---------------------------------------------------------------------------------
try {
    $apiResponse = Invoke-RestMethod -Uri $apiUrl -Method Get
}
catch {
    $Response = @{
        statusCode = [HttpStatusCode]::BadRequest
        body       = "API request failed: $_"
    }
    return $Response
}

# ---------------------------------------------------------------------------------
# STEP 4: Format result
# ---------------------------------------------------------------------------------
if ($apiResponse.$coin) {
    $result = @{
        Coin      = $coin
        PriceUSD  = $apiResponse.$coin.usd
        Retrieved = (Get-Date).ToString("u")
    }
}
else {
    $result = @{
        Error = "Coin '$coin' not found"
    }
}

# ---------------------------------------------------------------------------------
# STEP 5: Return result
# Associate values to output bindings by calling 'Push-OutputBinding'.
# ---------------------------------------------------------------------------------

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $result | ConvertTo-Json -Depth 3
})