## brew 命令

### commands

`brew commands [--quiet [--include-aliases]]`: Show a list of built-in and external commands.

- If `--quiet` is passed, list only the names of commands without the header.  
- With `--include-aliases`, the aliases of internal commands will be included.  

`brew commands` 默认携带 `--include-aliases` 选项列举所有 brew 命令。

### command

`brew command cmd`: Display the path to the file which is used when invoking brew cmd.

查看具体命令的工具包路径：

```Shell
$ brew command search
/usr/local/Homebrew/Library/Homebrew/cmd/search.rb
```

执行 `brew help command`（例如 `brew help doctor`） 可查看具体某条子命令的帮助说明。

### synopsis

brew 具体某条命令 command 的执行语法如下：

```Shell
brew command [--verbose|-v] [options] [formula] ...
```

## brew 搜索软件

### search

`brew search`（`brew -S`）：

## brew 查看信息

### desc

`brew desc`

### info

`brew info`

## brew 查看依赖

### deps

`brew deps`

### uses

`brew uses`

## brew 安装软件

### install

If `−−force` (or `−f`) is passed, install without checking for previously installed keg−only or non−migrated versions If `−−verbose` (or `−v`) is passed, print the veriﬁcation and postinstall steps.  
If `−−display−times` is passed, install times for each formula are printed at the end of the run. Installation options speciﬁc to formula may be appended to the command, and can be listed with `brew options <formula>`.

#### options

`options [−−compact] (−−all|−−installed|formulae)`: Display install options speciﬁc to formulae.

If `−−compact` is passed, show all options on a single line separated by spaces.  
If `−−all` is passed, show options for all formulae.  
If `−−installed` is passed, show options for all installed formulae.  

#### postinstall

-v(--verbose)：

`brew postinstall formula`: Rerun the post−install steps for formula.

### link

### unlink

### uninstall

brew uninstall

## brew 列举已安装

### brew list

```
    -1                               Force output to be one entry per line. This
                                     is the default when output is not to a
                                     terminal.
    -l                               List in long format. If the output is to a
                                     terminal, a total sum for all the file
                                     sizes is printed before the long listing.
    -r                               Reverse the order of the sort to list the
                                     oldest entries first.
    -t                               Sort by time modified, listing most
                                     recently modified first.
```

## brew 更新已安装

### update

brew update

### outdated

brew outdated

### upgrade

brew upgrade

## brew 版本管理

### switch

更新 node 版本到 11.0.0，由于存在 [clearTimeout blocks the process](https://github.com/nodejs/node/issues/23860) 的 bug 会引起 100% CPU usage 导致 whistle 假死，可执行 **`brew switch node 10.12.0`** 切回 node10 稳定版本。

执行 `tree -L 1 /usr/local/Cellar/node` 可查看 `/usr/local/Cellar/node` 下尚未删除的 node 缓存历史版本。

```Shell
~ tree -L 1 /usr/local/Cellar/node
/usr/local/Cellar/node
├── 10.10.0
├── 10.11.0
├── 10.12.0
└── 11.0.0

4 directories, 0 files
```

执行 `brew switch node 10.12.0` 切换到 node 10 最后一个版本。

```Shell
~ brew switch node 10.12.0
Cleaning /usr/local/Cellar/node/10.11.0
Cleaning /usr/local/Cellar/node/10.12.0
Cleaning /usr/local/Cellar/node/11.0.0
Cleaning /usr/local/Cellar/node/10.10.0
7 links created for /usr/local/Cellar/node/10.12.0
```

### pin

`brew pin <formulae>`: 固定某个软件包的当前（稳定）版本，防止执行 upgrade 更新。

```Shell
➜  ~  brew help pin
brew pin formulae:
    Pin the specified formulae, preventing them from being upgraded when
    issuing the brew upgrade formulae command. See also unpin.
```

### unpin

`brew unpin <formulae>`: Unpin formulae, allowing them to be upgraded by `brew upgrade <formulae>`. See also pin.

## brew 清理

### cleanup

`brew cleanup`：清除残留的历史版本安装包。

执行 `brew help cleanup` 查看帮助：

```Shell
➜  ~  brew help cleanup
brew cleanup [--prune=days] [--dry-run] [-s] [formulae|casks]:
```

**`--prune=days`**：删除指定日期之前的缓存。`brew cleanup --prune=15` 删除15天之前的旧缓存。  
**`-n`**（`--dry-run`）：测试查看指令输出，并不真正执行。  
**`-s`**：清除缓存，包括已下载最新的安装包。但是已安装的软件对应的下载不会删除。可执行 `rm -rf "$(brew --cache)"` 删除所有缓存。

更新 node 版本到 11.0.0，如果立即执行 `brew cleanup` 或 `brew cleanup node` 将移除 node 10 旧版本：

```Shell
Removing: /usr/local/Cellar/git/2.18.0... (1,488 files, 36.9MB)
Removing: /usr/local/Cellar/git/2.19.0_1... (1,512 files, 41.8MB)

Removing: /usr/local/Cellar/go/1.11... (9,273 files, 403.9MB)
Removing: /usr/local/Cellar/go/1.11.1... (9,279 files, 404MB)

Removing: /usr/local/Cellar/node/10.10.0... (3,940 files, 49.3MB)
Removing: /usr/local/Cellar/node/10.11.0... (3,940 files, 46.3MB)
Removing: /usr/local/Cellar/node/10.12.0... (3,939 files, 46.6MB)

Removing: /usr/local/Cellar/sqlite/3.24.0... (11 files, 3.5MB)
Removing: /usr/local/Cellar/sqlite/3.25.1... (11 files, 3.7MB)
Removing: /usr/local/Cellar/sqlite/3.25.2... (11 files, 3.7MB)
```

某些软件在稳定版出来之前，建议暂时保留历史版本，以便 `brew switch` 切回旧版本。  
故不要轻易执行 `brew cleanup`，建议先执行 `brew cleanup -n` 预览删除输出，以便取舍。  

### prune

`brew prune`：清除僵尸软链。

执行 `brew help prune` 查看帮助：

```Shell
➜  ~  brew help prune
Usage: brew prune [options]

Remove dead symlinks from the Homebrew prefix. This is generally not
needed, but can be useful when doing DIY installations.

    -n, --dry-run                    Show what would be removed, but do not
                                     actually remove anything.
    -v, --verbose                    Make some output more verbose.
    -d, --debug                      Display any debugging information.
    -h, --help                       Show this message.
```

可先执行 `brew prune -n` 测试查看指令输出，再决定是否真的需要执行该命令。  
执行命令时，可选择携带 `-v` 选项，查看更详细的 verbose 信息输出。  
