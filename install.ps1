# remove telemetry, disable services, and bloat
Start-Process -FilePath powershell.exe -ArgumentList {"-ExecutionPolicy Bypass -File clean_everything.ps1"} -verb RunAs

# https://learn.microsoft.com/en-us/windows/package-manager/winget/
$progressPreference = 'silentlyContinue'
Write-Information "Downloading WinGet and its dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx -OutFile Microsoft.UI.Xaml.2.7.x64.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

# install VS with SDK and WDK
winget install --source winget --exact --id Microsoft.VisualStudio.2022.Community --accept-source-agreements --override "--wait --quiet --includeRecommended --add ProductLang En-us --config $pwd\BuildTools.vsconfig"
winget install --source winget --exact --id Microsoft.WindowsSDK.10.0.22621 --accept-source-agreements
winget install --source winget --exact --id Microsoft.WindowsWDK.10.0.22621 --accept-source-agreements

# install NeoVim
winget install Neovim.Neovim --accept-source-agreements

# install chrome
winget install -e --id Google.Chrome --accept-source-agreements

# install git
winget install -e --id Git.Git --accept-source-agreements

# install make
winget install GnuWin32.Make --accept-source-agreements

# install llvm/clang
winget install -e -i --id LLVM.LLVM --accept-source-agreements

# install ripgrep
winget install BurntSushi.ripgrep.MSVC --accept-source-agreements

# install lazygit
winget install JesseDuffield.lazygit --accept-source-agreements

# install python3
winget install -e --id Python.Python.3.10 --accept-source-agreements

# install 7zip
winget install -e --id 7zip.7zip --accept-source-agreements

# install windbg
winget install --id Microsoft.WinDbg  -e --accept-source-agreements

# install x64dbg 
winget install --id x64dbg.x64dbg  -e --accept-source-agreements

# install rust
curl.exe https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe -o rustup-init.exe
.\rustup-init.exe
Remove-Item rustup-init.exe -Force

# refresh PATH so git, clang, and rust can be used
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# install typical python packages
pip install requests pefile fastapi uvicorn

# install lazyvim
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force

# install cygwin with autoconf, bash, and make
curl.exe https://cygwin.com/setup-x86_64.exe -o cygwin-setup.exe
.\cygwin-setup.exe --quiet-mode --no-desktop --download --local-install --no-verify -s https://mirror.aarnet.edu.au/pub/sourceware/cygwin/ -l $pwd -R C:/cygwin64
.\cygwin-setup.exe -q -d -D -L -X -s https://mirror.aarnet.edu.au/pub/sourceware/cygwin/ -l $pwd -R C:/cygwin64 -P autoconf,make
Remove-Item cygwin-setup.exe -Force

# enable hyper-v and turn UAC back on
Start-Process -FilePath powershell.exe -ArgumentList {"Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart;Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"} -verb RunAs
