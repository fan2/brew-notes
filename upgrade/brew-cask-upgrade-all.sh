
# [How to remove outdated casks from Homebrew?](https://apple.stackexchange.com/questions/135700/how-to-remove-outdated-casks-from-homebrew)

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

# [The default Caskroom location has moved to /usr/local/Caskroom](https://stackoverflow.com/questions/39430625/the-default-caskroom-location-has-moved-to-usr-local-caskroom)

#for f in ~/Applications/*.app; do 
#   oldloc="$(readlink "$f")";
#   [[ -e $oldloc ]] || ln -sf "/usr/local${oldloc#/opt/homebrew-cask}" "$f";
#done
