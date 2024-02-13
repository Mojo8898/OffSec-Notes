param(
    [string]$encryptedPayloadBase64,
    [string]$xorKey,
    [string]$method
)

$enc = [System.Text.Encoding]::UTF8

function xor {
    param(
        [string]$data,
        [string]$key,
        [string]$method
    )
    $keyBytes = $enc.GetBytes($key)

    if ($method -eq "decrypt"){
        $data = $enc.GetString([System.Convert]::FromBase64String($data))
    }

    $dataBytes = $enc.GetBytes($data)

    $xordData = $(for ($i = 0; $i -lt $dataBytes.length; ) {
        for ($j = 0; $j -lt $keyBytes.length; $j++) {
            if ($i -ge $dataBytes.Length) {
                break
            }
            $dataBytes[$i] -bxor $keyBytes[$j]
            $i++
        }
    })

    if ($method -eq "encrypt") {
        $xordData = [System.Convert]::ToBase64String($xordData)
    } else {
        $xordData = $enc.GetString($xordData)
    }

    return $xordData
}

$output = xor -data $encryptedPayloadBase64 -key $xorKey -method $method
Write-Host $output
