-- Base
import XMonad
import qualified XMonad.StackSet as W
import System.IO

-- Actions
-- The following resize windows with the mouse
import XMonad.Actions.MouseResize
-- import XMonad.Actions.SpawnOn (spawnAndDo)
-- import XMonad.Layout.WindowArranger
import XMonad.Actions.GridSelect
import XMonad.Actions.FloatKeys
import XMonad.Actions.CycleRecentWS (toggleRecentNonEmptyWS)

-- Data
import Data.Maybe (fromJust, maybeToList)
import Control.Monad (when, join, liftM, (<=<))
import Data.IORef
import Data.List
import qualified Data.Set as S

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, PP(..), xmobarPP, xmobarColor, wrap, shorten)
---- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.EwmhDesktops
---- for fullscreen events: allow overlap with xmobar
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks (avoidStruts, docks, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.OnPropertyChange (onTitleChange) -- for Zoom
import XMonad.Hooks.DynamicIcons
import XMonad.Hooks.WindowSwallowing
-- To overcome java issues
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.StatusBar.PP (filterOutWsPP)

-- Utilities
import XMonad.Util.Run (spawnPipe, runInTerm)
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP)
import XMonad.Util.SpawnOnce
import qualified XMonad.Util.Hacks as Hacks -- Dynamically resize xmobar padding for trayer
import XMonad.Util.NamedScratchpad

-- Layouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.Accordion
import XMonad.Layout.Tabbed
import XMonad.Layout.SimplestFloat
-- import XMonad.Layout.GridVariants (Grid(Grid))
-- import XMonad.Layout.Spiral
-- import XMonad.Layout.ThreeColumns
-- import XMonad.Layout.AvoidFloats

-- Layout modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
-- import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

--Appearance
import XMonad.Hooks.FadeInactive

--Gaps around screen (e.g. xmobar)
import XMonad.Layout.Gaps
    ( Direction2D(D, L, R, U),
      gaps,
      setGaps,
      GapMessage(DecGap, ToggleGaps, IncGap) )

import qualified Data.Map as M

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

-- Sets border width for windows
myBorderWidth :: Dimension
myBorderWidth = 2

--- spacing is deprecated, use the code below the following when things are updated
-- mySpacing :: Int -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
-- mySpacing = spacing
-- mySpacing' = spacing

myTerminal = "alacritty"

-- The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

------------------------------------------------------------------------
--                              Layouts                               --
------------------------------------------------------------------------

----------------------
--  Define Layouts  --
----------------------
-- Note: limitWindows n sets maximum number of windows displayed for layout.
--       mySpacing n sets the gap size around the windows.
tall           = renamed [Replace "tall"]
                 $ smartBorders
                 $ addTabs shrinkText myTabTheme
                 $ subLayout [] (smartBorders Simplest)
                 $ limitWindows 12
                 $ mySpacing 2
                 $ ResizableTall 1 (3/100) (1/2) []
magnify        = renamed [Replace "magnify"]
                 $ smartBorders
                 $ addTabs shrinkText myTabTheme
                 $ subLayout [] (smartBorders Simplest)
                 $ magnifier
                 $ limitWindows 12
                 $ mySpacing 1
                 $ ResizableTall 1 (3/100) (1/2) []
monocle        = renamed [Replace "monocle"]
                 $ smartBorders
                 $ addTabs shrinkText myTabTheme
                 $ subLayout [] (smartBorders Simplest)
                 $ limitWindows 20 Full
floats         = renamed [Replace "floats"]
                 $ smartBorders
                 $ limitWindows 20 simplestFloat
tabs           = renamed [Replace "tabs"]
                 $ tabbed shrinkText myTabTheme
wideAccordion  = renamed [Replace "wideAccordion"]
                 $ Mirror Accordion

----------------------
--  Layout Options  --
----------------------
-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

-------------------
--  Layout Hook  --
-------------------
myLayoutHook = gaps defaultGaps $ avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     smartBorders $ withBorder myBorderWidth tall
                                 ||| Main.magnify
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs
                                 ||| wideAccordion

-- https://www.reddit.com/r/xmonad/comments/hm2tg0/how_to_toggle_floating_state_on_a_window/
toggleFloat :: Window -> X ()
toggleFloat w = windows (\s -> if M.member w (W.floating s)
                                  then W.sink w s
                                  else W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s)

-- -- Float a window in the centre
-- centreFloat w = windows $ W.float w centreRect

defaultGaps = [(L,20), (R, 20), (U, 30), (D, 15)]

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9:hell"]


-- Number of windows in current workspace wrapped in appropriate monads
-- for use in xmobar
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..]


-- https://gitlab.com/dwt1/dotfiles/-/blob/master/.xmonad/xmonad.hs
myStartupHook :: X ()
myStartupHook = do
    spawn "picom"
    -- spawn "picom" >> addEWMHFullscreen
    spawn "xsetroot -cursor_name left_ptr" -- gumby
    spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request --tint 0x282c34  --height 25 --iconspacing 8 --transparent true --alpha 0"
    spawn "dunst"
    spawn "udiskie"

------------------------
--  Hacks to Revisit  --
------------------------

--docks necessary, otherwise xmobar hides behind windows
-- https://bbs.archlinux.org/viewtopic.php?id=223120-

-- Fix firefox non-fullscreen https://github.com/xmonad/xmonad-contrib/issues/183#issuecomment-307407822, chrome works fine

-- addEWMHFullscreen :: X ()
-- addEWMHFullscreen   = do
--     wms <- getAtom "_NET_WM_STATE"
--     wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
--     mapM_ addNETSupported [wms, wfs]

-- addNETSupported :: Atom -> X ()
-- addNETSupported x   = withDisplay $ \dpy -> do
--     r               <- asks theRoot
--     a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
--     a               <- getAtom "ATOM"
--     liftIO $ do
--         sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
--         when (fromIntegral x `notElem` sup) $
--             changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

----------------------------
--  End Hacks to revisit  --
----------------------------

-------------------
--  Scratchpads  --
-------------------
myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "nix packages" spawnNixPkgs findNixPkgs manageNixPkgs
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnNixPkgs  = "firefox https://search.nixos.org/packages?channel=unstable&"
    findNixPkgs   = title =? "nix packages"
    manageNixPkgs = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

myManageHook = composeAll
   [ (className =? "KeePassXC")                         --> doShift "8"
   , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
   , (className =? "Gimp")                              --> doFloat
   , (className =? "Mathematica")                       --> doFloat
   , (className =? "lf-files")                          --> doFloat
   , (className =? "Pavucontrol")                       --> doCenterFloat
   , (className =? "Blueman-manager")                   --> doCenterFloat
   , (className =? "Xmessage")                          --> doCenterFloat
   , isFullscreen                                       --> doFullFloat
   , manageDocks
   , manageZoomHook
   ] 
   <+> namedScratchpadManageHook myScratchPads

-- https://www.peterstuart.org/posts/2021-09-06-xmonad-zoom/
manageZoomHook =
    composeAll $
        [ (className =? zoomClassName)                            --> doShift "5"
        , (className =? zoomClassName) <&&> shouldFloat <$> title --> doFloat
        , (className =? zoomClassName) <&&> shouldSink <$> title  --> doSink
        ]
    where
      zoomClassName = "zoom"
      tileTitles =
        [ "Zoom - Free Account"      --  main window
        , "Zoom - Licensed Account"  --  main window
        , "Zoom"                     --  meeting window on creation
        , "Zoom Meeting"             --  meeting window shortly after creation
        ]
      shouldFloat title = title `notElem` tileTitles
      shouldSink title = title `elem` tileTitles
      doSink = (ask >>= doF . W.sink) <+> doF W.swapDown

myHandleEventHook = onTitleChange manageZoomHook
                    <> Hacks.trayerAboveXmobarEventHook
                    <> Hacks.trayerPaddingXmobarEventHook
                    <> swallowEventHook (className =? "Alacritty" <||> className =? "Gnome-terminal") (return True)

-- https://wiki.haskell.org/Xmonad/General_xmonad.hs_config_tips
-- myManageHook = composeAll . concat $
--    [ [manageDocks]
--    , [manageHook defaultConfig]
--    -- , [(isFullsceen -> doFullFloat)]
--    -- , [ className =? "Firefox-bin" --> doShift "web" ]
--    -- , [ className =? "Gajim.py"    --> doShift "jabber" ]
--    , [(className =? "Firefox" <&&> resource =? "Dialog") --> doFloat]
--    ]

--------------
--  Fading  --
--------------
fadeAmount = 0.9

myFadeHook toggleFadeSet = fadeOutLogHook $ fadeIf (testCondition toggleFadeSet) fadeAmount

doNotFadeOutWindows = title =? "Call with " <||> className =? "VLC" <||> className =? "MPlayer"

testCondition :: IORef (S.Set Window) -> Query Bool
testCondition floats =
    liftM not doNotFadeOutWindows <&&> isUnfocused
    <&&> (join . asks $ \w -> liftX . io $ S.notMember w `fmap` readIORef floats)

toggleFadeOut :: Window -> S.Set Window -> S.Set Window
toggleFadeOut w s | w `S.member` s = S.delete w s
                  | otherwise = S.insert w s

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount

isSuffixOfQ = fmap . isSuffixOf
pName = stringProperty "WM_NAME"

myIcons :: Query [String]
myIcons = composeAll
  [ className =? "Mathematica"                                                             --> appIcon "<fn=1>\xf666</fn>"
  , className =? "Emacs"                                                                   --> appIcon "<fn=2>\xe632</fn>"
  , className =? "KeePassXC"                                                               --> appIcon "<fn=1>\xf084</fn>"
  , className =? "zoom"                                                                    --> appIcon "<fn=1>\xf03d</fn>"
  , "NVIM" `isSuffixOfQ` pName                                                             --> appIcon "<fn=2>\xf36f</fn>"
  , className =? "firefox" <&&> ("Mozilla Firefox Private Browsing" `isSuffixOfQ` pName)   --> appIcon "<fc=#63666A><fn=1>\xf269</fn></fc>"
  , className =? "firefox" <&&> ("Mozilla Firefox" `isSuffixOfQ` pName)                    --> appIcon "<fn=1>\xf269</fn>"
  , className =? "firefox" <&&> ("Gmail — Mozilla Firefox" `isSuffixOfQ` title)            --> appIcon "<fn=1>\xf0e0</fn>"
  , className =? "Google-chrome"                                                           --> appIcon "<fn=1>\xf268</fn>"
  , className =? "VSCodium"                                                                --> appIcon "<fn=2>\xf372</fn>"
  ]

myIconConfig :: IconConfig
myIconConfig = def{ iconConfigIcons = myIcons, iconConfigFmt = iconsFmtAppend $ wrapUnwords "{" "}"}

dynamicLogIconsWithPPCustom :: IconConfig -> PP -> X () -- ^ The resulting 'X' action
dynamicLogIconsWithPPCustom c = dynamicLogWithPP <=< dynamicIconsPP c

-- cyan color: #03a9f4
-- Reference: https://gitlab.com/dwt1/dotfiles/-/blob/13c6509f52c94bdff436012440c952a47122b439/.config/xmonad/xmonad.hs
-- eventLogHookForXmobar proc = dynamicLogWithPP xmobarPP {....} without Icons
eventLogHookForXmobar proc = dynamicLogIconsWithPPCustom myIconConfig xmobarPP
                        { ppOutput = hPutStrLn proc
                        , ppCurrent = xmobarColor "#05fcd7" "" . wrap
                        ("<box type=Bottom width=2 mb=2 color=" ++ "#05fcd7"  ++ ">") "</box>" -- Current workspace
                        , ppVisible = xmobarColor "#03a9f4" ""                              -- Visible but not current workspace
                        , ppTitle = xmobarColor "#b3afc2" "" . shorten 60                   -- Title of active window
                        , ppSep =  "<fc=#666666> | </fc>"                                   -- Separator character
                        , ppUrgent = xmobarColor "#adc400" "" . wrap "!" "!"                -- Urgent workspace
                        , ppExtras  = [windowCount]                                         -- # of windows current workspace
                        }

main = do
    xmproc <- spawnPipe "xmobar $HOME/noscon/dotfiles/xmobar/.xmobarrc"
    toggleFadeSet <- newIORef S.empty

    xmonad . docks . ewmhFullscreen . ewmh $ def
        { manageHook         = myManageHook
        , layoutHook         = myLayoutHook
        , handleEventHook    = myHandleEventHook
        , logHook            = myLogHook >> myFadeHook toggleFadeSet >> eventLogHookForXmobar xmproc >> setWMName "LG3D"
        , modMask            = mod4Mask    -- Rebind Mod to the super key
        , startupHook        = myStartupHook
        , workspaces         = myWorkspaces
        , terminal           = myTerminal
        , borderWidth        = 2
        , normalBorderColor  = "#000000"
        , focusedBorderColor = "#7a0000"
        }
        `additionalKeysP`
        [ ("M-f",                     withFocused toggleFloat)
        , ("M-o",                     withFocused $ io . modifyIORef toggleFadeSet . toggleFadeOut)
        , ("M-<Up>",                  sendMessage MirrorExpand)
        , ("M-<Down>",                sendMessage MirrorShrink)
        , ("M-<Tab>", toggleRecentNonEmptyWS)

        --Laptop Media Keys
        , ("<XF86MonBrightnessUp>"   , spawn "brightnessctl set +5%")
        , ("<XF86MonBrightnessDown>" , spawn "brightnessctl set 5%-")
        , ("<XF86AudioMute>",         spawn "pactl set-sink-mute 0 toggle")
        , ("<XF86AudioLowerVolume>",  spawn "amixer -c 0 -q set Master 2dB-" >> spawn "bash $HOME/scripts/get-volume.sh | dzen2 -p 1 -w '200' -h '30' -x 1650 -y 30" )
        , ("<XF86AudioRaiseVolume>",  spawn "amixer -c 0 -q set Master 2dB+" >> spawn "bash $HOME/scripts/get-volume.sh | dzen2 -p 1 -w '200' -h '30' -x 1650 -y 30")

        -- Spawn programs
        , ("M-S-l", spawn "xscreensaver-command -lock; xset dpms force off")
        , ("M-x",   spawn "keepassxc")
        , ("M-w",   spawn "rofi -show window -icon-theme 'Papirus' -show-icons")
        , ("M-b",   spawn "firefox")
        , ("M-S-b", spawn "firefox -private-window")
        , ("M-S-f", runInTerm "--class \"Alacritty\",\"lf-files\" --title \"lf\"" "lf")
        , ("M-s t", namedScratchpadAction myScratchPads "terminal")
        , ("M-s s", namedScratchpadAction myScratchPads "nix packages")

        -- Move windows
        , ("M-C-l", withFocused (keysMoveWindow (15, 0)))
        , ("M-C-h", withFocused (keysMoveWindow (-15, 0)))
        , ("M-C-k", withFocused (keysMoveWindow (0, -15)))
        , ("M-C-j", withFocused (keysMoveWindow (0, 15)))

        -- Gap modifications
        , ("M-S-g t",   sendMessage $ ToggleGaps)            -- toggle all gaps
        , ("M-S-g d",   sendMessage $ setGaps defaultGaps)   -- reset the GapSpec
        , ("M-S-g S-l", sendMessage $ IncGap 10 L)         -- increment the left-hand gap
        , ("M-S-g l",   sendMessage $ DecGap 10 L)         -- decrement the left-hand gap

        , ("M-S-g S-k", sendMessage $ IncGap 10 U)         -- increment the top gap
        , ("M-S-g k",   sendMessage $ DecGap 10 U)         -- decrement the top gap

        , ("M-S-g S-j", sendMessage $ IncGap 10 D)         -- increment the bottom gap
        , ("M-S-g j",   sendMessage $ DecGap 10 D)         -- decrement the bottom gap

        , ("M-S-g S-h", sendMessage $ IncGap 10 R)         -- increment the right-hand gap
        , ("M-S-g h",   sendMessage $ DecGap 10 R)         -- decrement the right-hand gap
        ]

-- modalmap :: M.Map (KeyMask, KeySym) (X ()) -> X ()
-- modalmap s = submap $ M.map (>> modalmap s) s
