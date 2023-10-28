# https://raw.githubusercontent.com/hugsy/modern.ie-vagrant/master/scripts/DisableWin10Telemetry.ps1
Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Globalization;
using System.Text.RegularExpressions;
using Microsoft.Win32;
namespace PsRegistry
{
    public class Global
    {
        public static void SetStringValue(string KeyName, string ValueName, string Value)
        {
            using (RegistryKey key = Registry.LocalMachine.OpenSubKey(KeyName, true))
            {
                key.SetValue(ValueName, Value);
            }
        }
        public static void SetDwordValue(string KeyName, string ValueName, int Value)
        {
            using (RegistryKey key = Registry.LocalMachine.CreateSubKey(KeyName))
            {
                key.SetValue(ValueName, Value);
            }
        }
        public static void DeleteSubKey(string KeyName)
        {
            Registry.LocalMachine.DeleteSubKey(KeyName, false);
        }
    }
    public class Local
    {
        public static void SetStringValue(string KeyName, string ValueName, string Value)
        {
            using (RegistryKey key = Registry.CurrentUser.CreateSubKey(KeyName))
            {
                key.SetValue(ValueName, Value) ;
            }
        }
        public static void SetDwordValue(string KeyName, string ValueName, int Value)
        {
            using (RegistryKey key = Registry.CurrentUser.CreateSubKey(KeyName))
            {
                key.SetValue(ValueName, Value) ;
            }
        }
        public static void DeleteSubKey(string KeyName)
        {
            Registry.CurrentUser.DeleteSubKey(KeyName, false);
        }
   }
}
"@

# Disable Windows Error Reporting
Disable-WindowsErrorReporting

# Disable sample submit and lower CPU usage such that i can only use 5%
Set-MpPreference -SubmitSamplesConsent $false -ScanAvgCPULoadFactor 5

# Basic telemetry disabling script
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "## BEGIN Windows 10 privacy settings"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 vortex.data.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 vortex-win.data.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 telecommand.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 telecommand.telemetry.microsoft.com.nsatc.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 oca.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 oca.telemetry.microsoft.com.nsatc.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 sqm.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 sqm.telemetry.microsoft.com.nsatc.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 watson.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 watson.telemetry.microsoft.com.nsatc.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 redir.metaservices.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 choice.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 choice.microsoft.com.nsatc.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 df.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 reports.wes.df.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 wes.df.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 services.wes.df.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 sqm.df.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 watson.ppe.telemetry.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 telemetry.appex.bing.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 telemetry.urs.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 telemetry.appex.bing.net:443"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 settings-sandbox.data.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 vortex-sandbox.data.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 survey.watson.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 watson.live.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 watson.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 statsfe2.ws.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 corpext.msitadfs.glbdns2.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 compatexchange.cloudapp.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 cs1.wpc.v0cdn.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 a-0001.a-msedge.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 statsfe2.update.microsoft.com.akadns.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 diagnostics.support.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 corp.sts.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 statsfe1.ws.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 pre.footprintpredict.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 i1.services.social.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 i1.services.social.microsoft.com.nsatc.net"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 bingads.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "127.0.0.1 www.bingads.microsoft.com"
Add-Content $ENV:WinDir\System32\Drivers\etc\hosts "## END Windows 10 privacy settings"

# settings -> privacy -> general -> let apps use my ID
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo", "Enabled", 0)
[PsRegistry.Local]::DeleteSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo\Id")
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo", "Enabled", 0)

# settings -> privacy -> general -> let websites provide locally
[PsRegistry.Local]::SetDwordValue("Control Panel\International\User Profile", "HttpAcceptLanguageOptOut", 1)

# settings -> privacy -> general -> speech, inking, & typing
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\InputPersonalization", "RestrictImplicitTextCollection", 1)
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\InputPersonalization", "RestrictImplicitInkCollection", 1)
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore", "HarvestContacts", 0)
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\Personalization\Settings", "AcceptedPrivacyPolicy", 0)

# Disables web search in the search box
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\Windows\CurrentVersion\Search", "BingSearchEnabled", 0)

# Block telemetry
[PsRegistry.Global]::SetDwordValue("SOFTWARE\Policies\Microsoft\Windows\DataCollection", "AllowTelemetry", 0)

# Disable UserAssist
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Start_TrackProgs", 0)
[PsRegistry.Local]::SetDwordValue("SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Start_TrackEnabled", 0)

$services = @(
    "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service
    "DiagTrack"                                # Diagnostics Tracking Service
    "dmwappushservice"                         # WAP Push Message Routing Service (see known issues)
    "lfsvc"                                    # Geolocation Service
    "MapsBroker"                               # Downloaded Maps Manager
    "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service
    "RemoteAccess"                             # Routing and Remote Access
    "RemoteRegistry"                           # Remote Registry
    "SharedAccess"                             # Internet Connection Sharing (ICS)
    "TrkWks"                                   # Distributed Link Tracking Client
    "WbioSrvc"                                 # Windows Biometric Service (required for Fingerprint reader / facial detection)
    "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service
    "XblAuthManager"                           # Xbox Live Auth Manager
    "XblGameSave"                              # Xbox Live Game Save Service
    "XboxNetApiSvc"                            # Xbox Live Networking Service
)

foreach ($service in $services) {
    Write-Output "Trying to disable $service"
    Get-Service -Name $service | Set-Service -StartupType Disabled
}
