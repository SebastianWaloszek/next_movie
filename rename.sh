#!/bin/bash

currentApplicationId="com.waloszek.nextmovie"
currentProjectName="next_movie"
currentAppName="Next Movie"

androidManifestLocation="./android/app/src/main/AndroidManifest.xml"
iosPlistLocation="./ios/Runner/Info.plist"

lines="----------------------"
menuOptions="$lines\n1.Rename All\n2.Change bundleId\n3.Change project name\n4.Change app name\n$lines\nChoose option:"
pleaseWait="Setting new strings. Please wait.."

chooseNewBundleId="Please choose a new bundleId:"
chooseNewAppName="Please choose a new application name:"
chooseProjectName="Please choose a new project name:"

main () {
    installDependenciesIfNeeded
    export LC_ALL=C
    echo -e "$menuOptions"

    read choice
    case "$choice" in
      "1") changeAll ;;
      "2") changeBundleId ;;
      "3") changeProjectName ;;
      "4") changeAppName ;;
      *) echo "💩"
    esac
}

installDependenciesIfNeeded() {
    which -s brew
    if [[ $? != 0 ]] ; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    if ! brew ls --versions gnu-sed > /dev/null; then
        brew install gnu-sed
    fi
}

findAndRename () {
    find "$1" \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 gsed -i s/"$2"/"$3"/g
}

changeAll() {
    changeBundleId
    changeProjectName
    changeAppName
}

changeBundleId () {
    echo "$chooseNewBundleId"
    read newApplicationId

    echo "$pleaseWait"
    findAndRename ./ "$currentApplicationId" "$newApplicationId"
}

changeProjectName () {
    echo "$chooseProjectName"
    read newProjectName

    echo "$pleaseWait"
    findAndRename ./ "$currentProjectName" "$newProjectName"
}

changeAppName () {
    echo "$chooseNewAppName"
    IFS= read -r newAppName

    echo "$pleaseWait"
    findAndRename "$androidManifestLocation" "$currentAppName" "$newAppName"
    findAndRename "$iosPlistLocation" "$currentAppName" "$newAppName"
    findAndRename ./rename.sh "$currentAppName" "$newAppName"
}

main