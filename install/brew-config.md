
**brew** 是从软件包仓库下载源代码码到本地进行解压，进而执行 `./configure` && `make install` ，将软件编译安装到单独的目录（`/usr/local/Cellar`）下，然后软链（symlink）到 `/usr/local` 目录下，同时会自动检测下载相关依赖库，并自动配置好各种环境变量。  
这个对程序员来说简直是福音，使用简单的指令就能快速安装、升级和卸载本地的各种开发环境。

## brew 版本

安装完 brew，执行 `brew -v(--version)` 命令可查看 Homebrew、Homebrew/homebrew-core 以及 Homebrew/homebrew-cask 的版本信息。

```Shell
➜  ~  brew --version
Homebrew 1.8.2-96-g4021aa8
Homebrew/homebrew-core (git revision 5b16d6; last commit 2018-11-19)
Homebrew/homebrew-cask (git revision e5749; last commit 2018-11-19)
```

## brew 配置

### config

`brew config`（同 `brew --config`）：查看 brew 配置信息。

执行 `brew help config` 查看说明：

```Shell
➜  ~  brew help config
brew config:
    Show Homebrew and system configuration useful for debugging.
```

### --

```Shell
--cache       -- brew cache
--cellar      -- brew cellar
--env         -- brew environment
--prefix      -- where brew lives on this system
--repository(--repo)  -- brew repository
--version     -- version information
```

#### --version

参见上文的 brew 版本（`brew -v`）章节，此处不再赘述。

#### --env

`brew --env`：查看 brew 的编译配置工具链等相关环境变量信息。

执行 `brew help --env` 查看说明：

```
➜  ~  brew help --env
brew --env [--shell=(shell|auto)|--plain]:
    Show a summary of the Homebrew build environment as a plain list.
```

#### --prefix

`brew --prefix`：查看 brew 自身的安装位置。

执行 `brew help --prefix` 查看说明：

```Shell
➜  ~  brew help --prefix
brew --prefix:
    Display Homebrew's install path. Default: /usr/local on macOS and /home/linuxbrew/.linuxbrew on Linux

brew --prefix formula:
    Display the location in the cellar where formula is or would be installed.
```

执行 `brew --prefix` 查看输出：

```Shell
➜  ~  brew --prefix
/usr/local
```

> 输出同 `brew config` 中的 `HOMEBREW_PREFIX`。

安装 brew 后，首次执行 `brew install` 安装软件时，可能提示不能创建 `/usr/local/Cellar` 目录，因为没有 `/usr/local` 的写权限。

```Shell
➜  ~  brew install node
Error: Could not create /usr/local/Cellar
Check you have permission to write to /usr/local
```

**[解决方法](http://segmentfault.com/q/1010000000505091)：**

> 执行 `chown` 命令改变 `/usr/local` 的所有者为 `whoami` ，`-R` 表示递归（Recursive）。

#### --repo

`brew --repo`：查看 brew 自身的 git repository 位置（基于 `brew --prefix`）。

执行 `brew help --repo` 查看说明：

```Shell
➜  ~  brew help --repo
brew --repository:
    Display where Homebrew's .git directory is located.

brew --repository user/repo:
    Display where tap user/repo's directory is located.
```

执行 `brew --repo` 查看输出：

```Shell
➜  ~  brew --repo
/usr/local/Homebrew
```

#### --cache

`brew −−cache`: 查看 brew 下载的软件安装包缓存位置（`HOMEBREW_CACHE`）。

执行 `brew help --cache` 查看说明：

```Shell
➜  ~  brew help --cache
brew --cache:
    Display Homebrew's download cache. See also HOMEBREW_CACHE.

brew --cache [--build-from-source|-s] [--force-bottle] formula:
    Display the file or directory used to cache formula.
```

执行 `brew --cache` 查看输出：

```Shell
➜  ~  brew --cache
/Users/faner/Library/Caches/Homebrew
```

可指定 formula 查看具体包的下载位置：

```Shell
➜  ~  brew --cache node
/Users/faner/Library/Caches/Homebrew/downloads/3e0f0d6d8bd666de66e55041bb00e0c70b5735332052c97d0b84a4015509a58d--node-11.2.0.mojave.bottle.tar.gz
```

#### --cellar

`brew --cellar`：查看通过 brew 安装的软件包的位置（基于 `brew --prefix`）。

执行 `brew help --cellar` 查看说明：

```Shell
➜  ~  brew help --cellar
brew --cellar:
    Display Homebrew's Cellar path. Default: $(brew --prefix)/Cellar, or if
    that directory doesn't exist, $(brew --repository)/Cellar.

brew --cellar formula:
    Display the location in the cellar where formula would be installed,
    without any sort of versioned directory as the last path.
```

执行 `brew --cellar` 查看输出：

```Shell
➜  ~  brew --cellar
/usr/local/Cellar
```

> 其结果等同于 `$(brew --prefix)/Cellar`

可执行 open `brew --cellar` 或 open $(brew --cellar) 打开目录一看究竟。

### doctor

执行 `brew help doctor` 查看说明：

```Shell
➜  ~  brew help doctor
Usage: brew doctor [options]

Check your system for potential problems. Doctor exits with a non-zero status
if any potential problems are found. Please note that these warnings are just
used to help the Homebrew maintainers with debugging if you file an issue. If
everything you use Homebrew for is working fine: please don't worry or file
an issue; just ignore this.

        --list-checks                List all audit methods.
    -D, --audit-debug                Enable debugging and profiling of audit
                                     methods.
    -v, --verbose                    Make some output more verbose.
    -d, --debug                      Display any debugging information.
    -h, --help                       Show this message.
```

## brew 帮助

执行 `brew -h` 或 `brew help` 查看帮助概要（Example usage、Troubleshooting、Brewing）：

> -h / --h / --help / help

输入 `brew` 执行等效于 `brew -h`（`brew help`）。

`man brew`：查看 brew 的帮助手册；  
`brew help [COMMAND]`：查看具体某条子命令的帮助。  

[Homebrew Documentation](https://docs.brew.sh/)  
[FAQ](https://docs.brew.sh/FAQ)  
