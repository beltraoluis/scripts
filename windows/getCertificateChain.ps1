param (
    [Parameter(Mandatory=$true, HelpMessage="URL")]
    [string]$url
)

function Get-Certificate-Chain {
    # Extrai o nome do arquivo do URL
    $filename = $url -replace "[:/]", "_"
    $filename += ".chain.pem"

    # Faz o download dos certificados
    $certs = (openssl s_client -showcerts -connect $url </dev/null 2>/dev/null | Select-String -Pattern "-----BEGIN CERTIFICATE-----", "-----END CERTIFICATE-----").Line
    $certs | Out-File -FilePath $filename

    # Verifica se o download foi bem-sucedido
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Os certificados foram baixados com sucesso. Arquivo: $filename"
    } else {
        Write-Host "Ocorreu um erro ao baixar o certificado."
    }
}

function Help {
    Write-Host "Este script faz o download da cadeia de certificados de um URL."
    Write-Host "Uso: $PSCommandPath -url <URL>"
    Write-Host "Exemplo: $PSCommandPath -url www.example.com"
}

# Verifica se o parâmetro foi fornecido
if (-not $url -or $url -eq "--help" -or $url -eq "-h") {
    Help
    exit 0
} else {
    # Chama a função com a URL desejada
    Get-Certificate-Chain
}