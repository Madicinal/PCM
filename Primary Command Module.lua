setDefaultTab("Main")

local commandModuleName = "commandModule"
if type(storage[commandModuleName]) ~= "table" then
    storage[commandModuleName] = {}
end

local commandModuleConfig = storage[commandModuleName]

local commandModuleUI = setupUI([[
Panel
  height: 35
  type: anchor

  Label
    text-align: center
    text: Command Module
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    font: verdana-11px-rounded

  Button
    id: editCommandList
    anchors.top: prev.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    text-align: center
    width: 130
    margin-top: 2
    margin-bottom: 2
    text: Pick a Command
    font: verdana-11px-rounded
]])

commandModuleUI:setId(commandModuleName)

local favoriteModuleName = "favoriteModule"
if type(storage[favoriteModuleName]) ~= "table" then
    storage[favoriteModuleName] = {}
end

local favoriteModuleUI = setupUI([[
Panel
  margin-top: 5
  layout:
    type: verticalBox
    fit-children: true
]])

favoriteModuleUI:setId(favoriteModuleName)

g_ui.loadUIFromString([[
CommandListsWindow < MainWindow
  size: 850 320
  id: parent
  !text: tr('Select a Command Below')
  @onEscape: self:hide()

  Panel
    id: firstPanel
    image-source: /images/ui/menubox
    padding: 7
    width: 138
    height: 210
    anchors.top: parent.top
    anchors.left: parent.left
    margin-top: 11
    layout:
      type: anchor
      fit-children: true

    Label
      id: toolsLabel
      text-align: center
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      width: 100
      margin-top: -20
      text: "Tools"
      color: #FFFFFF
      font: verdana-11px-rounded
      layout:
        type: anchor

    Button
      id: broadcastButton
      !tooltip: tr('Broadcast a message server wide for 20 Peanuts.')
      anchors.left: parent.left
      anchors.top: parent.top
      margin-top: 4
      margin-left: -1
      text: Broadcast
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: broadcastFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: refreshbonusesButton
      !tooltip: tr('Reload your EQ Bonus Stats.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Refresh Bonuses
      font: cipsoftFont

    CheckBox
      size: 18 18
      id: refreshbonusesFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: teleportButton
      !tooltip: tr('Teleports you to a chosen location.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 4
      margin-left: -1
      text: Teleport
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: teleportFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: jumpButton
      !tooltip: tr('Jump over walls in puzzle rooms.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Jump
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: jumpFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: meltButton
      !tooltip: tr('Melts Frozen Walls.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Melt
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: meltFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

  Label
    id: broadcastmessageLabel
    anchors.top: firstPanel.bottom
    anchors.left: firstPanel.left
    text-offset: 4 3
    image-source: /images/ui/button
    imagecolor: #2de0d7
    image-border: 1
    width: 125
    height: 18
    margin-top: 4
    margin-left: 5
    text: "Broadcast Message:"
    color: #FF0000
    font: verdana-11px-rounded

  UITextEdit
    id: broadcastText
    color: #FF0000
    text-offset: 0 4
    padding: 2
    size: 682 18
    anchors.top: firstPanel.bottom
    anchors.left: broadcastmessageLabel.right 
    margin-top: 4
    margin-left: 3
    image-source: /images/ui/textedit
    image-border: 8
    selection-color: #272727
    selection-background-color: #cccccc
    change-cursor-image: true
    $disabled:
      color: #27272788
      opacity: 0.5
      change-cursor-image: false

  Label
    id: deathlistLabel
    anchors.top: broadcastmessageLabel.bottom
    anchors.left: firstPanel.left
    text-offset: 4 3
    image-source: /images/ui/button
    imagecolor: #2de0d7
    image-border: 1
    width: 90
    height: 18
    margin-top: 4
    margin-left: 5
    text: "Death List of:"
    color: #FF0000
    font: verdana-11px-rounded

  UITextEdit
    id: deathlistText
    color: #FF0000
    text-offset: 0 4
    padding: 2
    size: 215 18
    anchors.top: broadcastText.bottom
    anchors.left: deathlistLabel.right
    margin-top: 4
    margin-left: 3
    image-source: /images/ui/textedit
    image-border: 8
    selection-color: #272727
    selection-background-color: #cccccc
    change-cursor-image: true
    $disabled:
      color: #27272788
      opacity: 0.5
      change-cursor-image: false

  Label
    id: dishonorplayerLabel
    anchors.top: deathlistLabel.bottom
    anchors.left: firstPanel.left
    text-offset: 4 3
    image-source: /images/ui/button
    imagecolor: #2de0d7
    image-border: 1
    width: 105
    height: 18
    margin-top: 4
    margin-left: 5
    text: "Pay to Dishonor:"
    color: #FF0000
    font: verdana-11px-rounded

  UITextEdit
    id: dishonorplayerText
    color: #FF0000
    text-offset: 0 4
    padding: 2
    size: 200 18
    anchors.top: deathlistText.bottom
    anchors.left: dishonorplayerLabel.right
    margin-top: 4
    margin-left: 3
    image-source: /images/ui/textedit
    image-border: 8
    selection-color: #272727
    selection-background-color: #cccccc
    change-cursor-image: true
    $disabled:
      color: #27272788
      opacity: 0.5
      change-cursor-image: false

  Panel
    id: secondPanel
    image-source: /images/ui/menubox
    padding: 7
    width: 138
    height: 210
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: firstPanel.right
    margin-left: -1
    margin-top: -24
    layout:
      type: anchor
      fit-children: true

    Label
      id: informationLabel
      text-align: center
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      width: 115
      margin-top: -20
      margin-left: 2
      text: "Information"
      color: #FFFFFF
      font: verdana-11px-rounded
      layout:
        type: anchor

    Button
      id: pvpmodeButton
      !tooltip: tr('Shows you the state of the World PvP mode.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 11
      margin-left: -1
      text: Show PvP Mode
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: pvpmodeFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: taskinfoButton
      !tooltip: tr('Opens a list of all the available tasks information.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Task Info
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: taskinfoFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: cosmeticsinfoButton
      !tooltip: tr('Opens a list of all the available cosmetics information.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Cosmetics Info
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: cosmeticsinfoFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: maxhealthmanaButton
      !tooltip: tr('Shows your current and max health.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Show Health & Mana
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: maxhealthmanaFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: showfragsButton
      !tooltip: tr('Shows how many frags you unjustified.') 
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Show Frags
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: showfragsFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: showbosskillsButton
      !tooltip: tr('Shows a list of all killed bosses with how many of them has been killed.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Show Boss Kills
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: showbosskillsFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: showdoublehitButton
      !tooltip: tr('Shows the players chance to double hit with spells.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Show Double Hit
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: showdoublehitFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

  Panel
    id: thirdPanel
    image-source: /images/ui/menubox
    padding: 7
    width: 138
    height: 210
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: secondPanel.right
    margin-left: -1
    margin-top: -24
    layout:
      type: anchor
      fit-children: true

    Label
      id: purchasingLabel
      text-align: center
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      width: 115
      margin-top: -20
      margin-left: 2
      text: "Purchasing"
      color: #FFFFFF
      font: verdana-11px-rounded
      layout:
        type: anchor

    Button
      id: buyfirstpromotionButton
      !tooltip: tr('Buys a promotion for the cost of 2 Peanuts.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 11
      margin-left: -1
      text: Buy First Promotion
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: buyfirstpromotionFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: buysecondpromotionButton
      !tooltip: tr('Buys the second promotion for the cost of 1 Walnut.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Buy Second Promotion
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: buysecondpromotionFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: buyhotapieceButton
      !tooltip: tr('Buys a random piece of the Helmet of The Ancients. Costs 3500 Walnuts each. The helmet used in Titans quest.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Buy HoTA Piece
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: buyhotapieceFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: buypowergemButton
      !tooltip: tr('Buys a Power Gem for 1 Walnut. Used for charging the Helmet of The Ancients.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Buy Power Gem
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: buypowergemFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: buyoutfitsButton
      !tooltip: tr('Shows a window with outfits that can be purchased with full addons for a different price.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Buy Outfits
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: buyoutfitsFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: buymountsButton
      !tooltip: tr('Shows a window with mounts that can be purchased for a different price.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Buy Mounts
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: buymountsFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: setenforcedButton
      !tooltip: tr('Changes server to PvP-Enforced (with skulls but no frags) for a price of 10 Great Madness Tokens and doubles each use and for a duration of two hours.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Set PvP-Enforced
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: setenforcedFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: dishonorplayerButton
      !tooltip: tr('Adds a dishonor point to a player for the cost of 4 Great Madness Tokens. When the player reaches 25 points, everyone can kill him without getting a frag.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Dishonor Player
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: dishonorplayerFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

  Panel
    id: fourthPanel
    image-source: /images/ui/menubox
    padding: 7
    width: 138
    height: 210
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: thirdPanel.right
    margin-left: -1
    margin-top: -24
    layout:
      type: anchor
      fit-children: true

    Label
      id: serverdetailsLabel
      text-align: center
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      width: 115
      margin-top: -20
      margin-left: 2
      text: "Server Details"
      color: #FFFFFF
      font: verdana-11px-rounded
      layout:
        type: anchor

    Button
      id: deathlistButton
      !tooltip: tr('Tells you of a players death history.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 11
      margin-left: -1
      text: Death List
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: deathlistFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: onlineButton
      !tooltip: tr('Shows a list of the current online players.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Online
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: onlineFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: serverinfoButton
      !tooltip: tr('Shows server information.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Server Info
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: serverinfoFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: serveruptimeButton
      !tooltip: tr('Shows how long the server has been running.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Server Uptime
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: serveruptimeFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

  Panel
    id: sixthPanel
    image-source: /images/ui/menubox
    padding: 7
    width: 138
    height: 210
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: fourthPanel.right
    margin-left: -1
    margin-top: -24
    layout:
      type: anchor
      fit-children: true

    Label
      id: globalbonusesLabel
      text-align: center
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      width: 115
      margin-top: -20
      margin-left: 2
      text: "Global Bonuses"
      color: #FFFFFF
      font: verdana-11px-rounded
      layout:
        type: anchor

    Button
      id: globalbonusButton
      !tooltip: tr('Check the time left for each global bonus.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 11
      margin-left: -1
      text: "Check Bonus Timers"
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: globalbonusFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: freeglobalbonusexpButton
      !tooltip: tr('Sets global server loot to double for the price of 10000 Walnuts and for duration of one hour.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: "2x EXP (Gold)"
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: freeglobalbonusexpFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: freeglobalbonuslootButton
      !tooltip: tr('Sets global server loot to double for the price of 10000 Walnuts and for duration of one hour.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: "2x Loot (Gold)"
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: freeglobalbonuslootFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: freeglobalbonuschancesButton
      !tooltip: tr('Sets global server upgrading and dusts chances to double for the price of 10000 Walnuts and for duration of one hour.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: "2x Upgrade (Gold)"
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: freeglobalbonuschancesFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

  Panel
    id: seventhPanel
    image-source: /images/ui/menubox
    padding: 7
    width: 138
    height: 210
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: sixthPanel.right
    margin-left: -1
    margin-top: -24
    layout:
      type: anchor
      fit-children: true

    Label
      id: donationcoinsLabel
      text-align: center
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      width: 115
      margin-top: -20
      margin-left: 2
      text: "Donation Coin Shop"
      color: #FFFFFF
      font: verdana-11px-rounded
      layout:
        type: anchor

    Button
      id: changegenderButton
      !tooltip: tr('Changes your gender for a cost of 3 PREMIUM DAYS (Beware: It also hides all your previously obtained gender outfits until you return to your previous gender again).')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 11
      margin-left: -1
      text: "Change Gender (PD)"
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: changegenderFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: vipglobalbonusexpButton
      !tooltip: tr('Sets global server experience to double for the price of 10 DONATION COINS and for the duration of three hours.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: "2x EXP (DC)"
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: vipglobalbonusexpFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: vipglobalbonuslootButton
      !tooltip: tr('Sets global server loot to double for the price of 10 DONATION COINS and for duration of three hours.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: "2x Loot (DC)"
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: vipglobalbonuslootFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: vipglobalbonuschancesButton
      !tooltip: tr('Sets global server upgrading and dusts chances to double for the price of 10 DONATION COINS and for duration of three hours.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: "2x Upgrade (DC)"
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: vipglobalbonuschancesFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

    Button
      id: buydonatekeyButton
      !tooltip: tr('Buys a donate key with 3 charges that let you turn certain donate items back to donation coins for 1 Walnut.')
      anchors.left: parent.left
      anchors.top: prev.bottom
      margin-top: 2
      margin-left: -1
      text: Buy Donate Key
      font: cipsoftFont

    CheckBox
      size: 20 20
      id: buydonatekeyFavorite
      !tooltip: tr('Add to Favorites')
      anchors.left: prev.right
      anchors.top: prev.top
      margin-left: 4
      margin-top: 3
      text-align: left
      text-offset: 18 -1
      color: #dfdfdf
      image-color: #dfdfdfff
      image-rect: 0 0 18 18
      image-source: /images/ui/checkbox
      change-cursor-image: true
      cursor: pointer

  Button
    id: closeButton
    !text: tr('Close')
    font: verdana-11px-rounded
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-top: 15

  ResizeBorder
    id: bottomResizeBorder
    anchors.fill: separator
    height: 3
    minimum: 170
    maximum: 245
    margin-left: 3
    margin-right: 3
    background: #ffffff88
]])

local rootWidget = g_ui.getRootWidget()
if rootWidget then
    commandModuleWindow = UI.createWindow('CommandListsWindow', rootWidget)
    commandModuleWindow:hide()

    commandModuleUI.editCommandList.onClick = function(widget)
        commandModuleWindow:show()
        commandModuleWindow:raise()
        commandModuleWindow:focus()
    end

    commandModuleWindow.closeButton.onClick = function(widget)
	    storage[commandModuleName] = commandModuleConfig
        commandModuleWindow:hide()
    end
end

local duplicatedButtons = {} -- Store references to duplicated buttons

function duplicateButton(originalButton, parentPanel, checkbox)
    local newButton = g_ui.createWidget('Button', parentPanel)

    local originalHeight = originalButton:getHeight()

    newButton:setFont(originalButton:getFont())
    newButton:setText(originalButton:getText())
	newButton:setHeight(18)

    -- Set anchors for the new button
    newButton:setMarginTop(1)
    newButton:setMarginBottom(1)
    newButton:setMarginLeft(15)  -- Adjust the left margin if needed
    newButton:setMarginRight(15) -- Adjust the right margin if needed

    -- Update the height of the parent panel only if the checkbox is checked
    if checkbox and checkbox:isChecked() then
        parentPanel:setHeight(parentPanel:getHeight() + originalHeight + 15)
    end

    -- Store reference to the duplicated button
    duplicatedButtons[newButton:getText()] = newButton
    return newButton
end

function removeDuplicateButton(originalButton, parentPanel, checkbox)
    local buttonToRemove = duplicatedButtons[originalButton:getText()]
    if buttonToRemove then
        print("Removing button with Text:", buttonToRemove:getText())
        print("Parent panel children:", parentPanel:getChildCount())
        buttonToRemove:destroy()
        parentPanel:setHeight(parentPanel:getHeight() - buttonToRemove:getHeight() - 15)

        -- Remove the reference to the duplicated button
        duplicatedButtons[originalButton:getText()] = nil
    else
        print("Button not found:", originalButton:getText())
    end
end

-- Function to create a button and set up event handling
function createButtonAndSetupEvents(originalButton, parentPanel, checkbox, moduleName)
    checkbox.onCheckChange = function(_, checked)
        if checked then
            local newButton = duplicateButton(originalButton, parentPanel, checkbox)

            -- Store information about the favorite in the storage table
            if not commandModuleConfig[moduleName] then
                commandModuleConfig[moduleName] = {}
            end
            table.insert(commandModuleConfig[moduleName], originalButton:getText())

            -- Save the favorites to the storage table immediately
            storage[commandModuleName] = commandModuleConfig
            print("Saved:", commandModuleName, storage[commandModuleName])

        else
            removeDuplicateButton(originalButton, parentPanel, checkbox)

            -- Remove information about the favorite
            local favorites = commandModuleConfig[moduleName]
            if favorites then
                for i, favorite in ipairs(favorites) do
                    if favorite == originalButton:getText() then
                        table.remove(favorites, i)
                        break
                    end
                end
            end

            -- Save the updated favorites to the storage table immediately
            storage[commandModuleName] = commandModuleConfig
        end
    end
end


-- Function to load stored favorites
function loadFavorites(moduleName, parentPanel)
    local favoritesModule = commandModuleConfig[moduleName]
    if favoritesModule then
        for _, favoriteText in ipairs(favoritesModule) do
            local originalButton = parentPanel:recursiveGetChildById(favoriteText .. "Button")
            local checkbox = parentPanel:recursiveGetChildById(favoriteText .. "Favorite")

            if originalButton and checkbox then
                checkbox:setChecked(true)
                duplicateButton(originalButton, parentPanel, checkbox)
            end
        end
    end
end


-- Iterate over your button-checkbox pairs and set up event handling
local buttonCheckboxPairs = {
    -- First Panel Section
    {originalButton = commandModuleWindow.firstPanel.broadcastButton, checkbox = commandModuleWindow.firstPanel.broadcastFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.firstPanel.refreshbonusesButton, checkbox = commandModuleWindow.firstPanel.refreshbonusesFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.firstPanel.teleportButton, checkbox = commandModuleWindow.firstPanel.teleportFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.firstPanel.jumpButton, checkbox = commandModuleWindow.firstPanel.jumpFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.firstPanel.meltButton, checkbox = commandModuleWindow.firstPanel.meltFavorite, moduleName = commandModuleName},

    -- Second Panel Section
    {originalButton = commandModuleWindow.secondPanel.pvpmodeButton, checkbox = commandModuleWindow.secondPanel.pvpmodeFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.secondPanel.taskinfoButton, checkbox = commandModuleWindow.secondPanel.taskinfoFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.secondPanel.cosmeticsinfoButton, checkbox = commandModuleWindow.secondPanel.cosmeticsinfoFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.secondPanel.maxhealthmanaButton, checkbox = commandModuleWindow.secondPanel.maxhealthmanaFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.secondPanel.showfragsButton, checkbox = commandModuleWindow.secondPanel.showfragsFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.secondPanel.showbosskillsButton, checkbox = commandModuleWindow.secondPanel.showbosskillsFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.secondPanel.showdoublehitButton, checkbox = commandModuleWindow.secondPanel.showdoublehitFavorite, moduleName = commandModuleName},

    -- Third Panel Section
    {originalButton = commandModuleWindow.thirdPanel.buyfirstpromotionButton, checkbox = commandModuleWindow.thirdPanel.buyfirstpromotionFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.thirdPanel.buysecondpromotionButton, checkbox = commandModuleWindow.thirdPanel.buysecondpromotionFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.thirdPanel.buyhotapieceButton, checkbox = commandModuleWindow.thirdPanel.buyhotapieceFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.thirdPanel.buypowergemButton, checkbox = commandModuleWindow.thirdPanel.buypowergemFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.thirdPanel.buyoutfitsButton, checkbox = commandModuleWindow.thirdPanel.buyoutfitsFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.thirdPanel.buymountsButton, checkbox = commandModuleWindow.thirdPanel.buymountsFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.thirdPanel.setenforcedButton, checkbox = commandModuleWindow.thirdPanel.setenforcedFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.thirdPanel.dishonorplayerButton, checkbox = commandModuleWindow.thirdPanel.dishonorplayerFavorite, moduleName = commandModuleName},

    -- Fourth Panel Section
    {originalButton = commandModuleWindow.fourthPanel.deathlistButton, checkbox = commandModuleWindow.fourthPanel.deathlistFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.fourthPanel.onlineButton, checkbox = commandModuleWindow.fourthPanel.onlineFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.fourthPanel.serverinfoButton, checkbox = commandModuleWindow.fourthPanel.serverinfoFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.fourthPanel.serveruptimeButton, checkbox = commandModuleWindow.fourthPanel.serveruptimeFavorite, moduleName = commandModuleName},

    -- Fifth Panel Section
    --Snipped 4th, f those damn houses menu is getting too large

    -- Sixth Panel Section
    {originalButton = commandModuleWindow.sixthPanel.freeglobalbonusexpButton, checkbox = commandModuleWindow.sixthPanel.freeglobalbonusexpFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.sixthPanel.freeglobalbonuslootButton, checkbox = commandModuleWindow.sixthPanel.freeglobalbonuslootFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.sixthPanel.freeglobalbonuschancesButton, checkbox = commandModuleWindow.sixthPanel.freeglobalbonuschancesFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.sixthPanel.freeglobalbonusexpButton, checkbox = commandModuleWindow.sixthPanel.freeglobalbonusexpFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.sixthPanel.globalbonusButton, checkbox = commandModuleWindow.sixthPanel.globalbonusFavorite, moduleName = commandModuleName},

    -- Seventh Panel Section	
	{originalButton = commandModuleWindow.seventhPanel.changegenderButton, checkbox = commandModuleWindow.seventhPanel.changegenderFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.seventhPanel.vipglobalbonusexpButton, checkbox = commandModuleWindow.seventhPanel.vipglobalbonusexpFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.seventhPanel.vipglobalbonuslootButton, checkbox = commandModuleWindow.seventhPanel.vipglobalbonuslootFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.seventhPanel.vipglobalbonuschancesButton, checkbox = commandModuleWindow.seventhPanel.vipglobalbonuschancesFavorite, moduleName = commandModuleName},
    {originalButton = commandModuleWindow.seventhPanel.buydonatekeyButton, checkbox = commandModuleWindow.seventhPanel.buydonatekeyFavorite, moduleName = commandModuleName},
}

for _, pair in ipairs(buttonCheckboxPairs) do
    local originalButton = pair.originalButton
    local checkbox = pair.checkbox
    local moduleName = pair.moduleName

    createButtonAndSetupEvents(originalButton, favoriteModuleUI, checkbox, moduleName)
    loadFavorites(moduleName, favoriteModuleUI)
end

-- First Panel Section
function onBroadcastButtonClick()
    say("!broadcast ")
end

function onRefreshBonusesButtonClick()
    warn("!refreshbonuses")
end

function onTeleportButtonClick()
    warn("!tp")
end

function onJumpButtonClick()
    warn("jump")
end

function onMeltButtonClick()
    warn("melt")
end

-- Second Panel Section
function onPvpModeButtonClick()
    say("!pvpmode")
end

function onTaskInfoButtonClick()
    say("!tasksinfo")
end

function onCosmeticsInfoButtonClick()
    say("!cosmeticsinfo")
end

function onMaxHealthManaButtonClick()
    say("!health")
    say("!mana")
end

function onShowFragsButtonClick()
    say("!kills")
end

function onShowBossKillsButtonClick()
    say("!madnesskills")
end

function onShowDoubleHitButtonClick()
    say("!doublechance")
end

-- Third Panel Section
function onBuyFirstPromotionButtonClick()
    say("!buypromotion")
end

function onBuySecondPromotionButtonClick()
    say("!buysecondpromotion")
end

function onBuyHotaPieceButtonClick()
    say("!buyhotapiece")
end

function onBuyPowerGemButtonClick()
    say("!buypowergem")
end

function onBuyOutfitsButtonClick()
    say("!buyoutfit")
end

function onBuyMountsButtonClick()
    say("!buymount")
end

function onSetEnforcedButtonClick()
    say("!setenforced")
end

function onDishonorPlayerButtonClick()
    say("!dishonor ")
end

-- Fourth Panel Section
function onDeathlistButtonClick()
    say("!deathlist ")
end

function onOnlineButtonClick()
    say("!online")
end

function onServerInfoButtonClick()
    say("!serverinfo")
end

function onServerUptimeButtonClick()
    say("!uptime")
end

-- Fifth Panel Section

-- Sixth Panel Section
function onFreeGlobalBonusExpButtonClick()
    say("!freeglobalbonus exp")
end

function onFreeGlobalBonusLootButtonClick()
    say("!freeglobalbonus loot")
end

function onFreeGlobalBonusChancesButtonClick()
    say("!freeglobalbonus chances")
end

function onGlobalBonusButtonClick()
    say("!globalbonus")
end

-- Seventh Panel Section
function onChangeGenderButtonClick()
    say("!changesex")
end

function onVipGlobalBonusExpButtonClick()
    say("!vipglobalbonus exp")
end

function onVipGlobalBonusLootButtonClick()
    say("!vipglobalbonus loot")
end

function onVipGlobalBonusChancesButtonClick()
    say("!vipglobalbonus chances")
end

function onBuyDonateKeyButtonClick()
    say("!!buydonatekey")
end

-- Connect the buttons to the functions above

-- First Panel Section
local broadcastButton = commandModuleUI:getChildById("broadcastButton")
local refreshBonusesButton = commandModuleUI:getChildById("refreshBonusesButton")
local teleportButton = commandModuleUI:getChildById("teleportButton")
local jumpButton = commandModuleUI:getChildById("jumpButton")
local meltButton = commandModuleUI:getChildById("meltButton")

broadcastButton = broadcastButtonClick
refreshBonuses = onRefreshBonusesButtonClick
teleport = onTeleportButtonClick
jump = onJumpButtonClick
melt = onMeltButtonClick

-- Second Panel Section
local pvpModeButton = commandModuleUI:getChildById("pvpModeButton")
local taskInfoButton = commandModuleUI:getChildById("taskInfoButton")
local cosmeticsInfoButton = commandModuleUI:getChildById("cosmeticsInfoButton")
local maxHealthManaButton = commandModuleUI:getChildById("maxHealthManaButton")
local showFragsButton = commandModuleUI:getChildById("showFragsButton")
local showBossKillsButton = commandModuleUI:getChildById("showBossKillsButton")
local showDoubleHitButton = commandModuleUI:getChildById("showDoubleHitButton")

pvpMode = onPvpModeButtonClick
taskInfo = onTaskInfoButtonClick
cosmeticsInfo = onCosmeticsInfoButtonClick
maxHealthMana = onMaxHealthManaButtonClick
showFrags = onShowFragsButtonClick
showBossKills = onShowBossKillsButtonClick
showDoubleHit = onShowDoubleHitButtonClick

-- Third Panel Section
local buyFirstPromotionButton = commandModuleUI:getChildById("buyFirstPromotionButton")
local buySecondPromotionButton = commandModuleUI:getChildById("buySecondPromotionButton")
local buyHotaPieceButton = commandModuleUI:getChildById("buyHotaPieceButton")
local buyPowerGemButton = commandModuleUI:getChildById("buyPowerGemButton")
local buyOutfitsButton = commandModuleUI:getChildById("buyOutfitsButton")
local buyMountsButton = commandModuleUI:getChildById("buyMountsButton")
local setEnforcedButton = commandModuleUI:getChildById("setEnforcedButton")
local dishonorPlayerButton = commandModuleUI:getChildById("dishonorPlayerButton")

buyFirstPromotion = onBuyFirstPromotionButtonClick
buySecondPromotion = onBuySecondPromotionButtonClick
buyHotaPiece = onBuyHotaPieceButtonClick
buyPowerGem = onBuyPowerGemButtonClick
buyOutfits = onBuyOutfitsButtonClick
buyMounts = onBuyMountsButtonClick
setEnforced = onSetEnforcedButtonClick
dishonorPlayer = onDishonorPlayerButtonClick

-- Fourth Panel Section
local deathlistButton = commandModuleUI:getChildById("deathlistButton")
local onlineButton = commandModuleUI:getChildById("onlineButton")
local serverInfoButton = commandModuleUI:getChildById("serverInfoButton")
local serverUptimeButton = commandModuleUI:getChildById("serverUptimeButton")

deathlist = onDeathlistButtonClick
online = onOnlineButtonClick
serverInfo = onServerInfoButtonClick
serverUptime = onServerUptimeButtonClick

-- Sixth Panel Section
local freeGlobalBonusExpButton = commandModuleUI:getChildById("freeGlobalBonusExpButton")
local freeGlobalBonusLootButton = commandModuleUI:getChildById("freeGlobalBonusLootButton")
local freeGlobalBonusChancesButton = commandModuleUI:getChildById("freeGlobalBonusChancesButton")
local globalBonusButton = commandModuleUI:getChildById("globalBonusButton")

freeGlobalBonusExp = onFreeGlobalBonusExpButtonClick
freeGlobalBonusLoot = onFreeGlobalBonusLootButtonClick
freeGlobalBonusChances = onFreeGlobalBonusChancesButtonClick
globalBonus = onGlobalBonusButtonClick

-- Seventh Panel Section
local changeGenderButton = commandModuleUI:getChildById("changeGenderButton")
local vipGlobalBonusExpButton = commandModuleUI:getChildById("vipGlobalBonusExpButton")
local vipGlobalBonusLootButton = commandModuleUI:getChildById("vipGlobalBonusLootButton")
local vipGlobalBonusChancesButton = commandModuleUI:getChildById("vipGlobalBonusChancesButton")
local buyDonateKeyButton = commandModuleUI:getChildById("buyDonateKeyButton")

changeGender = onChangeGenderButtonClick
vipGlobalBonusExp = onVipGlobalBonusExpButtonClick
vipGlobalBonusLoot = onVipGlobalBonusLootButtonClick
vipGlobalBonusChances = onVipGlobalBonusChancesButtonClick
buyDonateKey = onBuyDonateKeyButtonClick