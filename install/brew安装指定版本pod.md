
最近Xcode编译项目突然报错 [Multiple commands produce error with XCFramework](https://github.com/CocoaPods/CocoaPods/issues/10106)，经查应该是最近某次brew升级，将 cocoapods 自动升级到了最新的 1.10 导致的配置兼容问题。

```
From the CocoaPods perspective you have 2 different pods that produce the same xcframework. Xcode New Build System is much stricter and does not allow that.
```

据相关了解，cocoapods 1.10 开始对 [xcframework](https://blog.csdn.net/olsQ93038o99S/article/details/107804423) 的处理有点不一样，项目组建议暂时还是用回 1.9。

## brew

执行 `pod --version` 查看当前 pod 版本：

```
$ pod --version
1.10.0
```

执行 `which pod` 命令查看 `pod` 命令所在位置：

```
$ which pod
/usr/local/bin/pod
```

### unlink latest

执行 `readlink` 命令读取 pod 软链在 `brew --cellar` 中的真实安装位置：

```
$ readlink `which pod`
../Cellar/cocoapods/1.10.0/bin/pod
```

执行 `brew unlink cocoapods` 解除 cocoapods 1.10.0 到 `/usr/local/bin/pod` 的软链。

### find old formula

[用Homebrew安装指定版本软件](https://www.jianshu.com/p/84d79beb469c)

从 https://github.com/Homebrew/homebrew-core/tree/master/Formula 中查找 cocoapods：

```
https://github.com/Homebrew/homebrew-core/blob/master/Formula/cocoapods.rb
```

在 History 中查找 1.10.0 升级之前的 `d12f92b2` 版本：

![cocoapods.rb-History](images/cocoapods.rb-History.png)

点击打开 [d12f92b2](https://github.com/Homebrew/homebrew-core/blob/d12f92b2810958515b7cc975857f22efa2588cdb/Formula/cocoapods.rb) 版本：

![cocoapods.rb-1.9.3](images/cocoapods.rb-1.9.3.png)

点击 `Raw` 查看其原始链接，尝试执行 `brew install` 安装该版本： 

```
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/d12f92b2810958515b7cc975857f22efa2588cdb/Formula/cocoapods.rb
```

Raw 链接如果无法访问或安装报错，可以将 Raw 文件保存下载到本地，再执行 `brew install` 从本地 rb 安装：

```
brew install ~/Downloads/cocoapods.rb
```

重新执行 `pod --version` 确认已装回旧版 pod：

```
$ pod --version
1.9.3
```

### pin old formula

执行 `brew pin cocoapods` 固定当前 pod 版本（1.9.3），防止后续执行 `brew upgrade` 时自动升级！！！

> 后面想升级时，再执行 `brew unpin cocoapods` 解锁，再执行 `brew switch cocoapods 1.9.3` 或 `brew upgrade cocoapods`。

## gem

[Ruby Gem 命令详解](https://www.jianshu.com/p/728184da1699)  

[How to Install a Specific Version of a Ruby Gem](https://howchoo.com/ruby/gem-install-specific-version)  
[How to install a specific version of a ruby gem?](https://stackoverflow.com/questions/17026441/how-to-install-a-specific-version-of-a-ruby-gem)  

[安装指定版本的CocoaPods](https://blog.z6z8.cn/2019/10/31/%E5%AE%89%E8%A3%85%E6%8C%87%E5%AE%9A%E7%89%88%E6%9C%AC%E7%9A%84cocoapods/)  
[CocoaPods安装指定版本](https://www.cnblogs.com/shenhongbang/p/4409360.html)  
[iOS：安装指定版本cocoapods](https://www.jianshu.com/p/3c1f439ba1ca)  

执行 `gem search cocoapods` 查看 gem 版本库，其中 cocoapods 版本已是最新：

```
$ gem search cocoapods

*** REMOTE GEMS ***

cocoapods (1.10.0)
```

执行 `gem install -v` 命令安装指定版本：

```
$ sudo gem install -n /usr/local/bin cocoapods -v 1.9.3
```

没有实测。
