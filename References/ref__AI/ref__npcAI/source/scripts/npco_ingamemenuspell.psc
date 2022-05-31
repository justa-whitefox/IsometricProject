Scriptname NPCO_InGameMenuSpell extends activemagiceffect  

Message Property ActivationMenu Auto
Message Property ControlMenu Auto
Message Property MenuDisableWeather Auto
Message Property MenuEnableWeather Auto
Message Property MenuNPCsTracking Auto

Actor Property PlayerREF Auto

GlobalVariable property Gl_WeatherFactorDawnstar auto
GlobalVariable property Gl_WeatherFactorFalkreath auto
GlobalVariable property Gl_WeatherFactorMarkarth auto
GlobalVariable property Gl_WeatherFactorMorthal auto
GlobalVariable property Gl_WeatherFactorRiften auto
GlobalVariable property Gl_WeatherFactorSolstheim auto
GlobalVariable property Gl_WeatherFactorSolitude auto
GlobalVariable property Gl_WeatherFactorWhiterun auto
GlobalVariable property Gl_WeatherFactorWindhelm auto
GlobalVariable property Gl_WeatherFactorWinterhold auto
GlobalVariable property Gl_WeatherFactorAllArea auto

GlobalVariable property Gl_AISkyrim auto

Quest property Qu_Trackingsytem auto

NPCO_Update property Immersive_Citizens Auto

event OnEffectStart(Actor akTarget, Actor akCaster)

	If akCaster == PlayerREF
		If Gl_AISkyrim.GetValueInt() == 1 
		Int iButton = ControlMenu.Show()
			If iButton == 0  ; Reboot button
				Debug.Notification("Updating...")
				Immersive_Citizens.DisableAI()
				Immersive_Citizens.ActivateAI()
				Debug.Notification("Immersive Citizens has been updated")
			ElseIf iButton == 1 ; Disable button
				Debug.Notification("Disabling...")
				Immersive_Citizens.DisableAI()
				Debug.Notification("Immersive Citizens has been disabled")
			ElseIf iButton == 2 ; Weather button
				If Gl_WeatherFactorAllArea.GetValueInt() == 1
					Int iButtonSub = MenuDisableWeather.Show()
					if iButtonSub == 0 ; Disable Weather Influence
						DisableWeatherInfluence()
						Debug.Notification("Weather Influence disabled")
					endif
				ElseIf Gl_WeatherFactorAllArea.GetValueInt() == 0
					Int iButtonSub = MenuEnableWeather.Show()
					if iButtonSub == 0 ; Enable Weather Influence
						EnableWeatherInfluence()
						Debug.Notification("Weather Influence activated")
					endif
				Endif
			ElseIf iButton == 3 ; NPCs tracking button
				Int iButtonSub2 = MenuNPCsTracking.Show()
				if iButtonSub2 == 0
					if Qu_Trackingsytem.IsRunning() == 0
						Qu_Trackingsytem.Start()
					EndIf
				Qu_Trackingsytem.SetObjectiveDisplayed(0)
				EndIf
				if iButtonSub2 == 1
					if Qu_Trackingsytem.IsRunning() == 0
						Qu_Trackingsytem.Start()
					EndIf
				Qu_Trackingsytem.SetObjectiveDisplayed(1)
				EndIf
				if iButtonSub2 == 2
					if Qu_Trackingsytem.IsRunning() == 0
						Qu_Trackingsytem.Start()
					EndIf
				Qu_Trackingsytem.SetObjectiveDisplayed(2)
				EndIf
				if iButtonSub2 == 3
					if Qu_Trackingsytem.IsRunning() == 0
						Qu_Trackingsytem.Start()
					EndIf
				Qu_Trackingsytem.SetObjectiveDisplayed(3)
				EndIf
				if iButtonSub2 == 4
					if Qu_Trackingsytem.IsRunning() == 0
						Qu_Trackingsytem.Start()
					EndIf
				Qu_Trackingsytem.SetObjectiveDisplayed(4)
				EndIf
				if iButtonSub2 == 5
					if Qu_Trackingsytem.IsRunning() == 0
						Qu_Trackingsytem.Start()
					EndIf
				Qu_Trackingsytem.SetObjectiveDisplayed(5)
				EndIf
				if iButtonSub2 == 6
					if Qu_Trackingsytem.IsRunning() == 0
						Qu_Trackingsytem.Start()
					EndIf
				Qu_Trackingsytem.SetObjectiveDisplayed(6)
				EndIf
				if iButtonSub2 == 7
					if Qu_Trackingsytem.IsRunning() == 0
						Qu_Trackingsytem.Start()
					EndIf
				Qu_Trackingsytem.SetObjectiveDisplayed(7)
				EndIf
				if iButtonSub2 == 8
					if Qu_Trackingsytem.IsRunning() == 1
						Qu_Trackingsytem.CompleteAllObjectives()
						Qu_Trackingsytem.Stop()
					EndIf
				EndIf
			EndIf 
		ElseIf Gl_AISkyrim.GetValueInt() == 0
		Int iButton = ActivationMenu.Show()
			If iButton == 0  ; Activation button
				Debug.Notification("Activating...")
				Immersive_Citizens.ActivateAI()
				Debug.Notification("Immersive Citizens has been activated")
			EndIf 
		EndIf
	EndIf
EndEvent

Function DisableWeatherInfluence ()
	Gl_WeatherFactorDawnstar.setValue(0)
	Gl_WeatherFactorFalkreath.setValue(0)
	Gl_WeatherFactorMarkarth.setValue(0)
	Gl_WeatherFactorMorthal.setValue(0)
	Gl_WeatherFactorRiften.setValue(0)
	Gl_WeatherFactorSolstheim.setValue(0)
	Gl_WeatherFactorSolitude.setValue(0)
	Gl_WeatherFactorWhiterun.setValue(0)
	Gl_WeatherFactorWindhelm.setValue(0)
	Gl_WeatherFactorWinterhold.setValue(0)
	Gl_WeatherFactorAllArea.setValue(0)
EndFunction

Function EnableWeatherInfluence ()
	Gl_WeatherFactorDawnstar.setValue(1)
	Gl_WeatherFactorFalkreath.setValue(1)
	Gl_WeatherFactorMarkarth.setValue(1)
	Gl_WeatherFactorMorthal.setValue(1)
	Gl_WeatherFactorRiften.setValue(1)
	Gl_WeatherFactorSolstheim.setValue(1)
	Gl_WeatherFactorSolitude.setValue(1)
	Gl_WeatherFactorWhiterun.setValue(1)
	Gl_WeatherFactorWindhelm.setValue(1)
	Gl_WeatherFactorWinterhold.setValue(1)
	Gl_WeatherFactorAllArea.setValue(1)
EndFunction