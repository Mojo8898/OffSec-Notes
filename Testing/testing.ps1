param(
    [string]$a,
    [string]$b
)

$enc = [System.Text.Encoding]::UTF8

function xor {
    param(
        [string]$data,
        [string]$key
    )
    $keyBytes = $enc.GetBytes($key)
    $dataBytes = $enc.GetBytes($enc.GetString([System.Convert]::FromBase64String($data)))

    $xordData = $(for ($i = 0; $i -lt $dataBytes.length; ) {
        for ($j = 0; $j -lt $keyBytes.length; $j++) {
            if ($i -ge $dataBytes.Length) {
                break
            }
            $dataBytes[$i] -bxor $keyBytes[$j]
            $i++
        }
    })

    return $enc.GetString($xordData)
}

$hehe = xor -data $a -key $b
Write-Host $hehe
# Invoke-Expression $hehe
