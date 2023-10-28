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
winget install --source winget --exact --id Microsoft.VisualStudio.2022.Community --override "--wait --quiet --includeRecommended --add ProductLang En-us --config $pwd\BuildTools.vsconfig"
winget install --source winget --exact --id Microsoft.WindowsSDK.10.0.22621
winget install --source winget --exact --id Microsoft.WindowsWDK.10.0.22621

# install NeoVim
winget install Neovim.Neovim --accept-source-agreements

# install chrome
winget install -e --id Google.Chrome

# install git
winget install -e --id Git.Git

# install make
winget install GnuWin32.Make

# install llvm/clang
winget install -e --id LLVM.LLVM

# install ripgrep
winget install BurntSushi.ripgrep.MSVC

# install lazygit
winget install JesseDuffield.lazygit

# install python3
winget install -e --id Python.Python.3.10

# install rust
curl.exe https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe -o rustup-init.exe
.\rustup-init.exe
Remove-Item rustup-init.exe -Force

# refresh PATH so git, clang, and rust can be used
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

# install lazyvim
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force

# install cygwin with autoconf, bash, and make
curl.exe https://cygwin.com/setup-x86_64.exe -o cygwin-setup.exe
.\cygwin-setup.exe --quiet-mode --no-desktop --download --local-install --no-verify -s https://mirror.aarnet.edu.au/pub/sourceware/cygwin/ -l $pwd -R C:/cygwin64
.\cygwin-setup.exe -q -d -D -L -X -s https://mirror.aarnet.edu.au/pub/sourceware/cygwin/ -l $pwd -R C:/cygwin64 -P autoconf,make
Remove-Item cygwin-setup.exe -Force

# enable hyper-v
Start-Process -FilePath powershell.exe -ArgumentList {"Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart"} -verb RunAs

# init lazyvim and download all plugins
nvim
