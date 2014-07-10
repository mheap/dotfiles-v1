import XMonad
import XMonad.Actions.WorkspaceNames -- workspaceNamesPP
import XMonad.Actions.Promote



import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout.Accordion
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.Circle
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Mosaic
import XMonad.Layout.Drawer -- ClassName Selector
import XMonad.Layout.Renamed

import qualified XMonad.StackSet as W
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO
import System.Exit

ctrlMask = controlMask
altMask = mod1Mask

--
-- Set up how things look
--

-- Fonts
monospaceFontFace  = "Ubuntu Mono"
monospaceFontSize = 12
monospaceFont = monospaceFontFace ++ "-" ++ show monospaceFontSize
normalFontFace = "Ubuntu Sans"
normalFontSize = 11
normalFont = normalFontFace ++ "-" ++ show normalFontSize

-- Common Colors
orange   = "#dd4814"   -- Ubuntu orange
darkgrey = "#3c3b37"   -- Ambiance background grey

--
-- Window Selectors
--

-- Window Selectors (Generic)
selectBuddyList, selectMusic, selectTerminal :: Property
selectBuddyList = Role "buddy_list"
selectMusic     = selectSpotify
selectTerminal  = ClassName "gnome-terminal"

-- Window Selectors (Specific) 
selectSpotify, selectXTerm, selectSteamFriends :: Property
selectSpotify      = ClassName "Spotify" `Or` ClassName "spotify"
selectXTerm        = ClassName "xterm" `Or` ClassName "XTerm"
selectSteamFriends = ClassName "Steam" `And` Title "Friends"
selectIrssi        = selectTerminal `And` Title "irssi"

--
-- Define printers for xmobar
--

-- Printer for statusbar (xmobar) windowing information
titlePP = xmobarPP
    { ppTitle = shorten 100
    , ppOrder = \(_:_:t:_) -> [t]
    , ppSep = ""
    }

-- Printer for statusbar (xmobar) windowing information
workspacePP = xmobarPP
    { -- Highlight current workspace in orange
      ppCurrent = xmobarColor orange "" . wrap "" "" 
    , ppUrgent = xmobarColor "white" orange . xmobarStrip
    , ppOrder = \(ws:_:_:_) -> [ws]
    , ppSep = ""
    , ppWsSep = "   "
    }

-- Printer for statusbar (xmobar) windowing information
layoutPP = xmobarPP
    { ppOrder = \(_:lt:_:_) -> [lt]
    , ppSep = ""
    }


--
-- Custom workspaces
--
-- [xK_2 .. xK_9] ++ [xK_0]


myManageHook = manageDocks <+> manageHook myConfig

--
-- Custom layouts
--

defaultLayouts    = layoutHook defaultConfig

-- "Tall" with a half width master
standardLayout    = renamed [Replace "Standard"] $ Tall 1 (3/100) (1/2)

-- Fullscreen
fullLayout        = renamed [Replace "Fullscreen"] $ Full

-- Vertical accordion of windows
vAccordionLayout  = renamed [Replace "Vertical Accordion"] $ Accordion
hAccordionLayout  = renamed [Replace "Horizontal Accordion"] $ Mirror Accordion

-- Grid
gridLayout = Grid

-- Drawer with windows stacked vertically
myDrawer prop = drawer 0.01 0.4 prop $ vAccordionLayout
drawerLayout prop layout = renamed [CutWordsLeft 2] $ myDrawer prop `onRight` layout

-- For now, just avoidStruts (Show top + Bottom bars)
-- myLayout = avoidStruts $ layoutHook defaultConfig
myLayout = standardLayout ||| ThreeCol 1 (3/100) (1/2) ||| fullLayout ||| gridLayout ||| mosaic 2 [3,2] ||| vAccordionLayout ||| hAccordionLayout

--
-- Set up any custom config
--
myConfig = defaultConfig
    {
        -- Use Windows key, not Alt as mod key
        modMask = mod4Mask

        -- Use gnome-terminal
        , terminal = "gnome-terminal" 
        , layoutHook = smartBorders $ myLayout
    }

myWorkspaces = map show [1..12]

myBindings =
    [ ("M-<Return>"     , spawn "gnome-terminal")
    , ("M-S-<Return>"   , spawn "google-chrome")
    , ("M-S-q"          , kill)
    , ("M-S-<Space>"    , promote)
    , ("C-M1-q"         , io (exitWith ExitSuccess)) -- Ctrl + Alt + q = Quit xmonad
    , ("C-S-l"          , spawn "i3lock -c 111111") -- Ctrl + Alt + L = Lock screen
    , ("<Print>"        , spawn "scrot") -- PrintScreen = Take screenshot
    , ("M-p"            , spawn "dmenu_run")
    , ("M-,"            , sendMessage (IncMasterN 1))
    , ("M-."            , sendMessage (IncMasterN (-1)))
    ]
    ++
    [ (otherModMasks ++ "M-" ++ key, action tag)
        | (tag, key)  <- zip myWorkspaces (map (\x -> "<F" ++ x ++ ">") myWorkspaces)
        , (otherModMasks, action) <- [ ("", windows . W.view) -- or W.greedyView
                                     , ("S-", windows . W.shift)]
    ]


--
-- Actually run xmonad
--
main = do

    -- Run xmobar and set printers
    titleBar <- spawnPipe "xmobar ~/.xmonad/xmobar/top.xmobarrc"
    let ttlPP = titlePP { ppOutput = hPutStrLn titleBar }
    workspaceBar <- spawnPipe "xmobar ~/.xmonad/xmobar/bottom-right.xmobarrc"
    let wsPP = workspacePP { ppOutput = hPutStrLn workspaceBar }
    layoutBar <- spawnPipe "xmobar ~/.xmonad/xmobar/bottom-left.xmobarrc"
    let lytPP = layoutPP { ppOutput = hPutStrLn layoutBar }

    xmonad $ myConfig
        {
        -- Allow top and bottom bars 
        manageHook = myManageHook
        , workspaces = myWorkspaces
        , layoutHook = avoidStruts $ layoutHook myConfig
        -- Set up xmobar
        , logHook = workspaceNamesPP wsPP >>= -- Display workspace names
                        dynamicLogWithPP >>
                        dynamicLogWithPP ttlPP >>
                        dynamicLogWithPP lytPP >>
                        logHook myConfig

        -- Set up additional bindings
        } `additionalKeysP` myBindings

