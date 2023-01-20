try {
    $start = Get-Date
    $ip = "4.2.2.2"
    $port = 53
    $data = [Text.Encoding]::ASCII.GetBytes("A" * 10)

    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect($ip, $port)
    $stream = $client.GetStream()
    $stream.Write($data, 0, $data.Length)
    $reader = new-object System.IO.StreamReader($stream)
    $responseText = $reader.ReadToEnd()
    $client.Close()
    
    $end = Get-Date
    $duration = $end - $start
    
   
    $log = "Data sent successfully to IP: $ip and Port: $port, Response: $responseText, Duration p$($duration.TotalMilliseconds)"
    Write-Host $log
    Add-Content -Path "log.txt" -Value $log

} catch {
    $errorMessage = $_.Exception.Message
    $time = Get-Date -Format s
    Write-Host "Error: $errorMessage at $time"
    Add-Content -Path "log.txt" -Value "Error: $errorMessage at $time"
}
