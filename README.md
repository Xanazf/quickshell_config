# Quickshell config by XNZF

## Requirements

>[!IMPORTANT] Keep in mind
> This config has been **built for Arch Linux**.
> If you wish to expand the config to other distros, please don't hesitate to PR.

```sh
hyprland
qt6 # all
quickshell
gpustat
weather-Cli # the one written in Go
pipewire
mpris
checkupdates
aurutils
```

## TODO

sooner:

- [ ] finish the state machine
- [ ] finish the drawer
- [ ] create a collection of each:
  - [ ] containers (frames, items)
  - [ ] decorations (borders, separators)
  - [ ] templates (layouts, buttons)
  - [ ] animations (passive, click, slide, fade, scroll)
- [ ] fix the main menu
- [ ] fix and finish the clipboard
- [ ] organize existing widgets
- [ ] finish organizing the file system

- [ ] add a refresh button
- [ ] add the code mode
- [ ] add the `checkupdate` widget
- [ ] implement notifications
  - right side
  - app/profile icon top-left
  - system notifications use profile pic
  - countdown 12s
  - pause on hover
  - dismiss on click
- [ ] make a notifications widget:
  - in the drawer
  - list of `[app icon] notification` containers
- [ ] make it possible to change main menu layout
- [ ] modify the `mpris` widget
  - [ ] make it possible to put Picture-in-Picture inside the drawer

later:

- [ ] implement notification message customizations
- [ ] implement theme switching
- [ ] make it possible to change the anchor of the main bar
- [ ] make a collection of widget elements
- [ ] create a widget maker (connect an stdout to a ui element)
- [ ] make it possible to pin widgets
