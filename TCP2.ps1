$ip = "smtp.gmail.com" 
$port = 465
$data = [Text.Encoding]::ASCII.GetBytes("A" * 10)

try {
    $startTime = Get-Date
    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect($ip, $port)
    $stream = $client.GetStream()
    $stream.Write($data, 0, $data.Length)
    $response = New-Object byte[] 1024
    $stream.Read($response, 0, 1024)
    $endTime = Get-Date
    $responseText = [Text.Encoding]::ASCII.GetString($response)
    Write-Host "Response received: $responseText"
    $duration = $endTime.Subtract($startTime)
    Write-Host "Request duration: $($duration.TotalMilliseconds)ms"

}
catch {
    Write-Host "Error: $_"
}

if ($client.Connected) {
    Out-File -FilePath 'response.txt' -InputObject $responseText
    Write-Host "Response saved to response.txt"
}

