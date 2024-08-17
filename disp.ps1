# Load the System.Speech assembly
Add-Type -AssemblyName System.Speech

# Detect the number of connected monitors
$monitorCount = (Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams).Count

if ($monitorCount -eq 0) {
    # If no monitor is connected, read out the prompt
    $displayOutputText = "No monitor is connected."
} else {
    # If a monitor is connected, read out the prompt
    $displayOutputText = "$monitorCount monitor is connected."
}

# Get the Wi-Fi name
$wifiName = (Get-NetConnectionProfile -InterfaceAlias "Wi-Fi").Name

# Get the IP address
$ipAddress = (Get-NetIPAddress -InterfaceAlias "Wi-Fi" | Where-Object {$_.AddressFamily -eq 'IPv4'}).IPAddress

# Combine the output text
$networkOutputText = "You are connected to Wi-Fi: $wifiName. Your IP address is $ipAddress."

# Use TTS to read out the text
$synthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
$synthesizer.Speak($displayOutputText)
$synthesizer.Speak($networkOutputText)
