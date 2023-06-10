import XMonad 
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.DynamicHooks
import XMonad.Util.ClickableWorkspaces
import XMonad.Hooks.EwmhDesktops
import System.IO
import XMonad.Layout.Spacing

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
	, ppOrder = \(ws:l:t:_)   -> [ws]
  } 

myStartupHook = do 
	spawnOnce "nitrogen --restore"
	spawnOnce "nm-applet --no-agent" 
	spawnOnce "udiskie"

myLayout = tiled ||| Mirror tiled ||| Full
	where 
		tiled = Tall nmaster delta ratio
		nmaster = 1
		ratio = 1/2
		delta = 3/100

defaults = def 
	{  
		modMask	= mod4Mask
		,borderWidth = 2
		--,normalBorderColor = "#ab4642"
		--,focusedBorderColor = "#a1b56c"
		,normalBorderColor = "#585858"
		,focusedBorderColor = "#f8f8f8"	
    ,startupHook = myStartupHook
	  ,layoutHook = spacingRaw True (Border 0 2 2 2) True (Border 8 8 8 8) True $ myLayout
		--,layoutHook = myLayout
    ,logHook = return()
		
	}
	`additionalKeysP`
	[
		("M-S-r", restart "xmonad" True)
		,("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume 0 +1%")
		,("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume 0 -1%")
		--("<XF86AudioMute>", spawn "pactl set-sink-mute 0 true"),
		,("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
		,("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
		,("M-q", kill)
		,("M-<Return>", spawn "alacritty")
		,("M-r", spawn "rofi -show run")
		,("M-e", spawn "alacritty -e ranger")
    
    ,("M-<F1>", spawn "alacritty -e btop")
    ,("M-<F2>", spawn "code")  
		,("M-<F3>", spawn "chromium")
    ,("M-<F4>", spawn "xournalpp") 
	]
