try {
    # Code that may throw an exception
    $ip = "35.180.139.74"
    $port = 80
    $data = [Text.Encoding]::ASCII.GetBytes("A" * 5000)

    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect($ip, $port)
    $stream = $client.GetStream()
    $stream.Write($data, 0, $data.Length)
    # Receive the response
    $reader = new-object System.IO.StreamReader($stream)
    $responseText = $reader.ReadToEnd()
    $client.Close()
    # Log the response
    $log = "Data sent successfully to IP: $ip and Port: $port, Response: $responseText"
    Write-Host $log
    Add-Content -Path "log.txt" -Value $log

} catch {
    # Handle the exception
    $errorMessage = $_.Exception.Message
    $time = Get-Date -Format s
    Write-Host "Error: $errorMessage at $time"
    Add-Content -Path "log.txt" -Value "Error: $errorMessage at $time"
}