param(
    [Parameter(Mandatory = $true)]
    [string]$data,
    [Parameter(Mandatory = $true)]
    [string]$key
)

$enc = [System.Text.Encoding]::UTF8

function xor {
    param(
        [byte[]]$dataBytes,
        [byte[]]$keyBytes
    )

    for ($i = 0; $i -lt $dataBytes.Length; $i++) {
        $dataBytes[$i] -bxor $keyBytes[$i % $keyBytes.Length]
    }

    return $dataBytes
}

$keyBytes = $enc.GetBytes($key)

try {
    $dataBytes = [Convert]::FromBase64String($data)
    $isEncoded = $true
}
catch {
    $dataBytes = $enc.GetBytes($data)
    $isEncoded = $false
}

$xordData = xor -dataBytes $dataBytes -keyBytes $keyBytes

if ($isEncoded) {
    $enc.GetString($xordData)
} else {
    [Convert]::ToBase64String($xordData)
}
