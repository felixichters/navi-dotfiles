import XMonad 
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicHooks
import XMonad.Util.ClickableWorkspaces
import XMonad.Hooks.EwmhDesktops
import System.IO
import XMonad.Layout.Spacing
import XMonad.Layout.MultiColumns
import qualified XMonad.StackSet as W

main :: IO()
main = do 
	h <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc" 
	xmonad $ xmobarProp $ ewmh $ defaults {logHook = myLogHook h}

myTerminal = "alacritty"
myModmask = mod4Mask

myLogHook :: Handle -> X()
myLogHook h = dynamicLogWithPP $ def {
	ppOutput = hPutStrLn h
	, ppExtras = []
	, ppOrder = \(ws:l:t:_)   -> [ws,l]
  } 

myStartupHook = do 
	spawnOnce "nitrogen --restore"
	spawnOnce "nm-applet --no-agent" 
	spawnOnce "udiskie"

myLayout = {-spacingRaw True (Border 3 3 3 3) True (Border 10 10 10 10) True $-} multiCol [1] 1 0.01 (-0.5) ||| tiled ||| Mirror tiled ||| Full
	where 
		tiled = Tall nmaster delta ratio
		nmaster = 1
		ratio = 1/2
		delta = 3/100

defaults = def 
	{  
		modMask	= mod4Mask
		,borderWidth = 1
		--,normalBorderColor = "#ab4642"
		--,focusedBorderColor = "#a1b56c"
		,normalBorderColor = "#282828"
		,focusedBorderColor = "#7c6f64"
    ,startupHook = myStartupHook
	  ,layoutHook =  myLayout
		--,layoutHook = myLayout
    ,logHook = return()
		
	}
	`additionalKeysP` [
		("M-<Tab>", windows W.focusDown),
		("M-S-<Tab>", windows W.swapDown),
		("M-S-r", restart "xmonad" True),
		("M-q", kill),
		--("M-b", sendMessage ToggleStructs),
		
		("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume 0 +1%"),
		("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume 0 -1%"),
		("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10"),
		("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10"),

		("M-<Return>", spawn "alacritty"),
		("M-v", spawn "alacritty -e nvim -c 'Files'"),
		--("M-v", spawn "alacritty -e nvim -c 'Telescope find_files hidden=true no_ignore=true'"),
		("M-r", spawn "rofi -show run"),
		("M-e", spawn "alacritty -e ranger"),

    ("M-<F1>", spawn "alacritty -e btop"),
    ("M-<F2>", spawn "code"),
		("M-<F3>", spawn "chromium"),
    ("M-<F4>", spawn "xournalpp") 
	]
