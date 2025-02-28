#!/usr/bin/env nu

# 定義配置文件夾的路徑
let dotfile_dir = if ($nu.os-info.name == "windows") { 
    $env.USERPROFILE | path join "dotfile" 
} else { 
    $env.HOME | path join "dotfile" 
}

# 定義需要軟連接的目標目錄
let configs = if ($nu.os-info.name == "windows") { 
    { 
        # "nushell": "~/AppData/Roaming/nushell", 
        "yazi": "~/.config/yazi", 
        "nvim": "~/AppData/Local/nvim", 
        "starship.toml": "~/.config/starship.toml", 
        "lazysql": "~/.config/lazysql",
        "wezterm": "~/.config/wezterm" 
    } 
} else { 
    { 
        # "nushell": "~/.config/nushell", 
        "yazi": "~/.config/yazi", 
        "nvim": "~/.config/nvim", 
        "wezterm": "~/.config/wezterm", 
        "starship.toml": "~/.config/starship.toml", 
        "lazysql": "~/.config/lazysql" 
    } 
}

# Linux 創建軟連結的函數
def create_symlink [source: path, target: path] {

    let target_parent = ($target | path dirname)
    if not ($target_parent | path exists) {
        mkdir $target_parent
    }
    print $"Creating symlink: ($source) -> ($target)"

    if ($target | path exists) {
        rm -rf $target
    }

    ln -s $source $target
}

# Windows 創建軟連結的函數
def create_symlink_win [source: path, target: path] {
    let target_parent = ($target | path dirname)

    # 这里确保路径是 Windows 格式
    let source_win = ($source | path expand | str replace "/" "\\")
    let target_win = ($target | path expand | str replace "/" "\\")
	print $"source file :($source_win) & target file :($target_win)"

    if not ($target_parent | path exists) {
        mkdir $target_parent
    }

    if ($target | path exists) {
        rm -rf $target
    }


    # # Windows 使用 mklink 命令
    ^cmd /c mklink /D $target_win $source_win
}

# 遍歷配置並創建軟連結
$configs | transpose key value | each {|item|
    let source_path = ($dotfile_dir | path join $item.key)
    let expanded_target_path = ($item.value | path expand)
    
    if ($nu.os-info.name == "windows") {
        create_symlink_win $source_path $expanded_target_path
    } else {
        create_symlink $source_path $expanded_target_path
    }
}

print "Symlink creation completed!"
