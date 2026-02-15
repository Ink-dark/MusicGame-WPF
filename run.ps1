<#
.SYNOPSIS
MusicGame-WPF 项目创建和构建脚本

.DESCRIPTION
此脚本用于创建、配置和构建 MusicGame-WPF 项目。

.NOTES
作者: MusicGame 开发团队
版本: 1.0
#>

# 设置错误处理
$ErrorActionPreference = "Stop"

Write-Host "========================================"
Write-Host "MusicGame-WPF 项目创建和构建脚本"
Write-Host "========================================"
Write-Host ""

# 检查 .NET SDK 是否安装
Write-Host "[1/5] 检查 .NET SDK 安装情况..."
$dotnetInstalled = $false
try {
    $dotnetVersion = dotnet --version
    Write-Host "✓ .NET SDK 已安装: $dotnetVersion"
    $dotnetInstalled = $true
} catch {
    Write-Host "✗ .NET SDK 未安装，请先安装 .NET 8 SDK:"
    Write-Host "  下载地址: https://dotnet.microsoft.com/download/dotnet/8.0"
    exit 1
}

# 创建 WPF 项目
Write-Host ""
Write-Host "[2/5] 创建 WPF 项目..."
try {
    dotnet new wpf -n MusicGame -o . --force
    Write-Host "✓ WPF 项目创建成功"
} catch {
    Write-Host "✗ 创建 WPF 项目失败: $_"
    exit 1
}

# 添加项目依赖
Write-Host ""
Write-Host "[3/5] 添加项目依赖..."
try {
    dotnet add package NAudio --version 2.2.1
    dotnet add package MvvmLightLibs --version 5.4.1.1
    Write-Host "✓ 依赖添加成功"
} catch {
    Write-Host "✗ 添加依赖失败: $_"
    exit 1
}

# 创建项目目录结构
Write-Host ""
Write-Host "[4/5] 创建项目目录结构..."
try {
    # 创建目录
    $directories = @(
        "Models",
        "ViewModels",
        "Views",
        "Services",
        "Utilities"
    )
    
    foreach ($dir in $directories) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  ✓ 创建目录: $dir"
    }
    
    # 创建 Models
    New-Item -ItemType File -Path "Models\MusicFile.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Models\Note.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Models\Score.cs" -Force | Out-Null
    
    # 创建 ViewModels
    New-Item -ItemType File -Path "ViewModels\MainViewModel.cs" -Force | Out-Null
    New-Item -ItemType File -Path "ViewModels\PlayerViewModel.cs" -Force | Out-Null
    New-Item -ItemType File -Path "ViewModels\EditorViewModel.cs" -Force | Out-Null
    
    # 创建 Views
    New-Item -ItemType File -Path "Views\PlayerView.xaml" -Force | Out-Null
    New-Item -ItemType File -Path "Views\PlayerView.xaml.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Views\EditorView.xaml" -Force | Out-Null
    New-Item -ItemType File -Path "Views\EditorView.xaml.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Views\Styles.xaml" -Force | Out-Null
    
    # 创建 Services
    New-Item -ItemType File -Path "Services\AudioPlayer.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Services\ScoreManager.cs" -Force | Out-Null
    
    # 创建 Utilities
    New-Item -ItemType File -Path "Utilities\Helper.cs" -Force | Out-Null
    
    Write-Host "✓ 项目目录结构创建完成"
} catch {
    Write-Host "✗ 创建目录结构失败: $_"
    exit 1
}

# 构建项目
Write-Host ""
Write-Host "[5/5] 构建项目..."
try {
    dotnet build -c Release
    Write-Host "✓ 项目构建成功"
} catch {
    Write-Host "✗ 项目构建失败: $_"
    exit 1
}

Write-Host ""
Write-Host "========================================"
Write-Host "✓ 项目创建和构建完成！"
Write-Host "========================================"
Write-Host ""
Write-Host "使用以下命令运行项目:"
Write-Host "  dotnet run"
Write-Host ""
Write-Host "或直接运行生成的可执行文件:"
Write-Host "  .\bin\Release\net8.0-windows\MusicGame.exe"
Write-Host ""
