`man brew-cask` 查看 outdated 和 upgrade 命令。

```Shell
       outdated [--greedy] [--verbose|--quiet] [ token ... ]
              Without token arguments, display all the installed Casks that have  newer  versions
              available in the tap; otherwise check only the tokens given in the command line. If
              --greedy is given then also include in the output  the  Casks  having  auto_updates
              true  or  version  :latest. Otherwise they are skipped because there is no reliable
              way to know when updates are available for them.
              --verbose forces the display of the outdated and latest version.
              --quiet suppresses the display of versions.

       upgrade [--force] [--greedy] token [ token ... ]
              Without token arguments, upgrade all the installed Casks that have  newer  versions
              available  in  the  tap;  otherwise update the tokens given in the command line. If
              --greedy is given then also upgrade the Casks having auto_updates true  or  version
              :latest.
```

[**Upgrade all the casks installed via Homebrew Cask**](https://stackoverflow.com/questions/31968664/upgrade-all-the-casks-installed-via-homebrew-cask)

`brew cask upgrade` will not update casks that do not have versioning information (`version :latest`) or applications that have a built-in upgrade mechanism (`auto_updates true`). To reinstall these casks (and consequently upgrade them if upgrades are available), run the upgrade command with the `--greedy` flag.

因为有些 cask 包未提供在线版本校验，故 `brew cask outdated` 无法准确检测更新，可尝试执行 **`brew cask upgrade --greedy`**。

> vscode 默认开启了 `Update: Enable Windows Background Updates` 后台自动更新开关。

```Shell
for app in $(brew cask list); do
    cver="$(brew cask info "${app}" | head -n 1 | cut -d " " -f 2)";
    ivers=$(ls -1 "/opt/homebrew-cask/Caskroom/${app}/.metadata/" | tr '\n' ' ' | sed -e 's/ $//');
    aivers=(${ivers});
    nvers=$(echo ${#aivers[@]});

    echo "[*] Found ${app} in cask list. Latest available version is ${cver}. You have installed version(s): ${overs}";

    if [[ ${nvers} -eq 1 ]]; then
        echo "${ivers}" | grep -q "^${cver}$" && {
            echo "[*] Latest version already installed :) Skipping changes ...";
            continue;
        };
    fi;

    echo "[+] Fixing from ${ivers} to ${cver} ...";
    brew cask uninstall "${app}" --force;
    brew cask install "${app}";

done
```

> 以上检测版本差异不准确，会造成同版本覆盖重装。

## homebrew/livecheck

[homebrew-livecheck](https://github.com/Homebrew/homebrew-livecheck)

```Shell
ifan@FAN-MC1:~|⇒  brew tap homebrew/livecheck
Updating Homebrew...
==> Tapping homebrew/livecheck
Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-livecheck'...
remote: Counting objects: 888, done.
remote: Compressing objects: 100% (866/866), done.
remote: Total 888 (delta 20), reused 805 (delta 19), pack-reused 0
Receiving objects: 100% (888/888), 135.98 KiB | 255.00 KiB/s, done.
Resolving deltas: 100% (20/20), done.
Tapped 1 command (905 files, 424.5KB).

ifan@FAN-MC1:~|⇒  brew livecheck
Error: No such file or directory @ rb_sysopen - /Users/ifan/.brew_livecheck_watchlist
```

## brew cask upgrade --greedy

```
ifan@FAN-MC1:~|⇒  brew cask outdated
```

```Shell
ifan@FAN-MC1:~|⇒  brew cask upgrade --greedy
Updating Homebrew...
==> Casks with `auto_updates` or `version :latest` will not be upgraded
==> Upgrading 6 outdated packages, with result:
enolsoft-chm-view latest, firefox 62.0, font-input latest, font-noto-sans-mono latest, iterm2 3.2.0, visual-studio-code 1.27.0,7b9afc4196bda60b0facdf62cfc02815509b23d6
==> Satisfying dependencies
==> Downloading http://www.enolsoft.com/download/enolsoft-chm-view.dmg
==> Downloading from https://www.enolsoft.com/download/enolsoft-chm-view.dmg
######################################################################## 100.0%
==> No SHA-256 checksum defined for Cask 'enolsoft-chm-view', skipping verification.
==> Starting upgrade for Cask enolsoft-chm-view
==> Purging files for version latest of Cask enolsoft-chm-view
Error: It seems the App source '/Applications/Enolsoft CHM View.app' is not there.
```

## homebrew-cask-upgrade

I think this is by far the best solution to upgrade the casks. 
source: https://github.com/buo/homebrew-cask-upgrade

Installation & usage

```Shell
brew tap buo/cask-upgrade
brew update
brew cu
```

(Optional) Force upgrade outdated apps including the ones marked as latest:

```Shell
brew cu --all
```

```Shell
ifan@FAN-MC1:~|⇒  brew cu
==> Options
Include auto-update (-a): false
Include latest (-f): false
==> Updating Homebrew
Already up-to-date.
==> Finding outdated apps
       Cask                    Current                         Latest                          A/U    Result
 1/12  android-platform-tools  28.0.1                          28.0.1                               [   OK   ]
 2/12  enolsoft-chm-view                                       latest                               [   OK   ]
 3/12  firefox                 61.0.1                          62.0                             Y   [  PASS  ]
 4/12  font-fira-code          1.205                           1.205                                [   OK   ]
 5/12  font-hack               3.003                           3.003                                [   OK   ]
 6/12  font-input              latest                          latest                               [   OK   ]
 7/12  font-m-plus             063                             063                                  [   OK   ]
 8/12  font-noto-sans-mono     latest                          latest                               [   OK   ]
 9/12  font-source-code-pro    2.030R-ro-1.050R-it             2.030R-ro-1.050R-it                  [   OK   ]
10/12  iterm2                  3.1.7                           3.2.0                            Y   [  PASS  ]
11/12  visual-studio-code      1.23.0,7c7da59c2333a1306c41...  1.27.0,7b9afc4196bda60b0fac...   Y   [  PASS  ]
12/12  wireshark               2.6.3                           2.6.3                                [   OK   ]
```


```Shell
ifan@FAN-MC1:~|⇒  brew cu --all
==> Options
Include auto-update (-a): true
Include latest (-f): false
==> Updating Homebrew
Already up-to-date.
==> Finding outdated apps
       Cask                    Current                         Latest                          A/U    Result
 1/12  android-platform-tools  28.0.1                          28.0.1                               [   OK   ]
 2/12  enolsoft-chm-view                                       latest                               [   OK   ]
 3/12  firefox                 61.0.1                          62.0                             Y   [ FORCED ]
 4/12  font-fira-code          1.205                           1.205                                [   OK   ]
 5/12  font-hack               3.003                           3.003                                [   OK   ]
 6/12  font-input              latest                          latest                               [   OK   ]
 7/12  font-m-plus             063                             063                                  [   OK   ]
 8/12  font-noto-sans-mono     latest                          latest                               [   OK   ]
 9/12  font-source-code-pro    2.030R-ro-1.050R-it             2.030R-ro-1.050R-it                  [   OK   ]
10/12  iterm2                  3.1.7                           3.2.0                            Y   [ FORCED ]
11/12  visual-studio-code      1.23.0,7c7da59c2333a1306c41...  1.27.0,7b9afc4196bda60b0fac...   Y   [ FORCED ]
12/12  wireshark               2.6.3                           2.6.3                                [   OK   ]
==> Found outdated apps
     Cask                Current                                Latest                                 A/U    Result
1/3  firefox             61.0.1                                 62.0                                    Y   [ FORCED ]
2/3  iterm2              3.1.7                                  3.2.0                                   Y   [ FORCED ]
3/3  visual-studio-code  1.23.0,7c7da59c2333a1306c41e6e7b68...  1.27.0,7b9afc4196bda60b0facdf62cfc...   Y   [ FORCED ]

Do you want to upgrade 3 apps [y/N]? y
```

## others

已经有 **`upgrade`** 命令了，所以不用再调 **`reinstall`**：

brew cask reinstall `brew cask outdated`

It is possible to list the installed casks with:

`brew cask list`

And force the re-installation of a cask with:

`brew cask install --force CASK_NAME`

So piping the output of the first command into the second, we update all the casks:

`brew cask list | xargs brew cask install --force`
