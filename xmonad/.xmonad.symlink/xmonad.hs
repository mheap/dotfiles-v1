import XMonad
import XMonad.Actions.WorkspaceNames -- workspaceNamesPP
import XMonad.Actions.Promote
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.Circle
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Mosaic

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Exit

ctrlMask = controlMask
altMask = mod1Mask

--
-- Set up how things look
--

-- Fonts
monospaceFontFace  = "Ubuntu Mono"
monospaceFontSize = 13
monospaceFont = monospaceFontFace ++ "-" ++ show monospaceFontSize
normalFontFace = "Ubuntu Sans"
normalFontSize = 12
normalFont = normalFontFace ++ "-" ++ show normalFontSize

-- Common Colors
orange = "#dd4814"      -- Ubuntu orange
darkgrey = "#3c3b37"   -- Ambiance background grey

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



--
-- Custom layouts
--

-- For now, just avoidStruts (Show top + Bottom bars)
-- myLayout = avoidStruts $ layoutHook defaultConfig
myLayout = avoidStruts(smartBorders(Tall 1 (3/100) (1/2) ||| ThreeCol 1 (3/100) (1/2) ||| Full ||| Grid ||| mosaic 2 [3,2]))

--
-- Set up any custom config
--
myConfig = defaultConfig
    {
        -- Use Windows key, not Alt as mod key
        modMask = mod4Mask

        -- Use gnome-terminal
        , terminal = "gnome-terminal" 
    }



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
        manageHook = manageDocks <+> manageHook myConfig
	, layoutHook = myLayout
        -- Set up xmobar
        , logHook = workspaceNamesPP wsPP >>= -- Display workspace names
                        dynamicLogWithPP >>
                        dynamicLogWithPP ttlPP >>
                        dynamicLogWithPP lytPP >>
                        logHook myConfig

        -- Set up additional bindings
        } `additionalKeys`
        [ 
          ((mod4Mask                 , xK_Return)     , spawn "gnome-terminal")
        , ((mod4Mask .|. shiftMask   , xK_Return)     , spawn "google-chrome")
        , ((mod4Mask .|. shiftMask   , xK_space)      , promote)
        , ((mod4Mask .|. shiftMask   , xK_q)          , kill)
        , ((ctrlMask .|. altMask     , xK_q)          , io (exitWith ExitSuccess)) -- Ctrl + Alt + q = Quit xmonad
        , ((ctrlMask .|. shiftMask     , xK_l)          , spawn "i3lock -c 111111") -- Ctrl + Alt + L = Lock screen
        , ((0                        , xK_Print)      , spawn "scrot") -- PrintScreen = Take screenshot
        , ((mod4Mask                 , xK_p)          , spawn "dmenu_run")
        ]


