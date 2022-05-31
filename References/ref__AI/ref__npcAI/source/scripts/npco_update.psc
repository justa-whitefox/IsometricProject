Scriptname NPCO_Update extends ReferenceAlias  

GlobalVariable property ModVersion auto

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

GlobalVariable property Gl_AICompanions auto
GlobalVariable property Gl_AIDarkBrotherhood auto
GlobalVariable property Gl_AIDawnguardFaction auto
GlobalVariable property Gl_AIEastmarch auto
GlobalVariable property Gl_AIFalkreathHold auto
GlobalVariable property Gl_AIKhajiitCaravans auto
GlobalVariable property Gl_AIHaafingar auto
GlobalVariable property Gl_AIHjaalmarch auto
GlobalVariable property Gl_AIOrcStrongholds auto
GlobalVariable property Gl_AISkyrimExtraNPCs auto
GlobalVariable property Gl_AISkyrim auto
GlobalVariable property Gl_AISolstheim auto
GlobalVariable property Gl_AISolstheimExtraNPCs auto
GlobalVariable property Gl_AIThePale auto
GlobalVariable property Gl_AITheReach auto
GlobalVariable property Gl_AITheRift auto
GlobalVariable property Gl_AIThievesGuild auto
GlobalVariable property Gl_AIVolkiharClan auto
GlobalVariable property Gl_AIWhiterunHold auto
GlobalVariable property Gl_AIWinterHold auto
GlobalVariable property Gl_AIWinterHoldCollege auto

Quest property QuAI_CompanionsNPCs auto
Quest property QuAI_DarkBrotherhoodNPCs auto
Quest property QuAI_DarkWaterCrossingNPCs auto
Quest property QuAI_DawnGuardNPCs auto
Quest property QuAI_DawnstarNPCs auto
Quest property QuAI_DragonBridgeNPCs auto
Quest property QuAI_DushnikhYalNPCs auto
Quest property QuAI_FalkreathNPCs auto
Quest property QuAI_IvarsteadNPCs auto
Quest property QuAI_KarthwastenNPCs auto
Quest property QuAI_KynesgroveNPCs auto
Quest property QuAI_LargashburNPCs auto
Quest property QuAI_MarkarthNPCs auto
Quest property QuAI_MorKhazgurNPCs auto
Quest property QuAI_MorthalNPCs auto
Quest property QuAI_NarzulburNPCs auto
Quest property QuAI_NightGateInnNPCs auto
Quest property QuAI_OldHroldanNPCs auto
Quest property QuAI_RavenRockNPCs auto
Quest property QuAI_RiftenNPCs auto
Quest property QuAI_RiverwoodNPCs auto
Quest property QuAI_RoriksteadNPCs auto
Quest property QuAI_ShorsStoneNPCs auto
Quest property QuAI_SkaalVillageNPCs auto
Quest property QuAI_SolitudeCityNPCs auto
Quest property QuAI_SolitudeDockNPCs auto
Quest property QuAI_StoneHillsNPCs auto
Quest property QuAI_TelMithrynNPCs auto
Quest property QuAI_ThievesGuildNPCs auto
Quest property QuAI_VolkiharKeepNPCs auto
Quest property QuAI_WhiterunNPCs auto
Quest property QuAI_WindhelmNPCs auto
Quest property QuAI_WinterholdCollegeNPCs auto
Quest property QuAI_WinterholdNPCs auto

Quest property QuAI_DawnstarJ_M auto
Quest property QuAI_FalkreathJ_M auto
Quest property QuAI_MarkarthJ_M auto
Quest property QuAI_MorthalJ_M auto
Quest property QuAI_RiftenJ_M auto
Quest property QuAI_SolitudeJ_M auto
Quest property QuAI_WhiterunJ_M auto
Quest property QuAI_WindhelmJ_M auto
Quest property QuAI_WinterholdJ_M auto
Quest property QuAI_KhajiitCaravansNPCs auto

Quest property QuAI_EastmarchExtraNPCs auto
Quest property QuAI_FalkreathHoldExtraNPCs auto
Quest property QuAI_HaafingarExtraNPCs auto
Quest property QuAI_HjaalmarchExtraNPCs auto
Quest property QuAI_ThePaleExtraNPCs auto
Quest property QuAI_TheReachExtraNPCs auto
Quest property QuAI_TheRiftExtraNPCs auto
Quest property QuAI_WhiterunHoldExtraNPCs auto
Quest property QuAI_WinterHoldExtraNPCs auto

Quest property Qu_Trackingsytem auto

; #Supported Mods===============================================================
bool property isCoTLoaded auto hidden			 			; Climates of Tamriel
 
Event OnPlayerLoadGame()
	Maintenance()
	Compatibility()
EndEvent
 
Function Maintenance()
	If ModVersion.GetValue() < 0.39 ; <--- Edit this value when updating
		If QuAI_CompanionsNPCs.IsRunning() == 1
			QuAI_CompanionsNPCs.Stop()
			Utility.Wait(2.0)
			QuAI_CompanionsNPCs.Start()
		EndIf
		
		If QuAI_WinterholdNPCs.IsRunning() == 1
			QuAI_WinterholdNPCs.Stop()
			Utility.Wait(2.0)
			QuAI_WinterholdNPCs.Start()
		EndIf
		ModVersion.setvalue(0.39) ; and this
		Debug.NotIfication("Immersive Citizens has been updated.")

	EndIf

EndFunction

Function Compatibility ()
	debug.trace("[Immersive Citizens]======================================================================================================")
	debug.trace("[Immersive Citizens]     Immersive Citizens is now performing compatibility checks. Papyrus warnings about missing or	   ")
	debug.trace("[Immersive Citizens]             unloaded files may follow. This is NORMAL and can be ignored.							   ")
	debug.trace("[Immersive Citizens]======================================================================================================")
	If isCoTLoaded
		isCoTLoaded = IsPluginLoaded(0x00419D5, "ClimatesOfTamriel.esm")
		If !isCoTLoaded
			;Climates of Tamriel was removed since the last save.
			debug.trace("[Immersive Citizens]: Climates of Tamriel has been removed.")
			If Gl_WeatherFactorAllArea.GetValueInt() == 1
				Gl_WeatherFactorSolstheim.setValue(1)
			endIf
		endIf
	else
		isCoTLoaded = IsPluginLoaded(0x00419D5, "ClimatesOfTamriel.esm")
		If isCoTLoaded
			;Climates of Tamriel was just added.
			debug.trace("[Immersive Citizens]: Climates of Tamriel has been detected.")
			If Gl_WeatherFactorAllArea.GetValueInt() == 1
				Gl_WeatherFactorSolstheim.setValue(0)
			endIf
		endIf
	endIf
	debug.trace("[Immersive Citizens]======================================================================================================")
	debug.trace("[Immersive Citizens]                            Immersive Citizens compatibility check complete.						   ")
	debug.trace("[Immersive Citizens]======================================================================================================")
EndFunction

bool function IsPluginLoaded(int iFormID, string sPluginName)
		bool i = Game.GetFormFromFile(iFormID, sPluginName)
		if i
			return true
		else
			return false
		endif

EndFunction

Function ActivateAI ()
	; Eastmarch
	if QuAI_WindhelmNPCs.IsRunning() == 0
		QuAI_WindhelmNPCs.start()
		QuAI_DarkWaterCrossingNPCs.start()
		QuAI_KynesgroveNPCs.start()
		QuAI_WindhelmJ_M.start()
		Gl_AIEastmarch.setValue(1)
	endif
	; Falkreath Hold
	if QuAI_FalkreathNPCs.IsRunning() == 0
		QuAI_FalkreathNPCs.start()
		QuAI_FalkreathJ_M.start()
		Gl_AIFalkreathHold.setValue(1)
	endif
	; Haafingar
	if QuAI_SolitudeCityNPCs.IsRunning() == 0
		QuAI_SolitudeCityNPCs.start()
		QuAI_SolitudeDockNPCs.start()
		QuAI_SolitudeJ_M.start()
		QuAI_DragonBridgeNPCs.start()
		Gl_AIHaafingar.setValue(1)
	endif
	; Hjaalmarch
	if QuAI_MorthalNPCs.IsRunning() == 0
		QuAI_MorthalNPCs.start()
		QuAI_MorthalJ_M.start()
		QuAI_StoneHillsNPCs.start()
		Gl_AIHjaalmarch.setValue(1)
	endif
	; Solstheim
	if QuAI_RavenRockNPCs.IsRunning() == 0
		QuAI_RavenRockNPCs.start()
		QuAI_TelMithrynNPCs.start()
		QuAI_SkaalVillageNPCs.start()
		Gl_AISolstheim.setValue(1)
	endif
	; The Pale
	if QuAI_DawnstarNPCs.IsRunning() == 0
		QuAI_DawnstarNPCs.start()
		QuAI_DawnstarJ_M.start()
		QuAI_NightGateInnNPCs.start()
		Gl_AIThePale.setValue(1)
	endif
	; TheReach
	if QuAI_MarkarthNPCs.IsRunning() == 0
		QuAI_MarkarthNPCs.start()
		QuAI_MarkarthJ_M.start()
		QuAI_OldHroldanNPCs.start()
		QuAI_KarthwastenNPCs.start()
		Gl_AITheReach.setValue(1)
	endif
	; The Rift
	if QuAI_RiftenNPCs.IsRunning() == 0
		QuAI_RiftenNPCs.start()
		QuAI_RiftenJ_M.start()
		QuAI_IvarsteadNPCs.start()
		QuAI_ShorsStoneNPCs.start()
		Gl_AITheRift.setValue(1)
	endif
	; Whiterun Hold
	if QuAI_WhiterunNPCs.IsRunning() == 0
		QuAI_WhiterunNPCs.start()
		QuAI_WhiterunJ_M.start()
		QuAI_RiverwoodNPCs.start()
		QuAI_RoriksteadNPCs.start()
		Gl_AIWhiterunHold.setValue(1)
	endif
	; WinterHold
	if QuAI_WinterHoldNPCs.IsRunning() == 0
		QuAI_WinterHoldNPCs.start()
		QuAI_WinterholdJ_M.start()
		Gl_AIWinterHold.setValue(1)
	endif
	; Companions
	if QuAI_CompanionsNPCs.IsRunning() == 0
		QuAI_CompanionsNPCs.start()
		Gl_AICompanions.setValue(1)
	endif
	; College of Winterhold
	if QuAI_WinterholdCollegeNPCs.IsRunning() == 0
		QuAI_WinterholdCollegeNPCs.start()
		Gl_AIWinterholdCollege.setValue(1)
	endif
	; Khajiit Caravan
	if QuAI_KhajiitCaravansNPCs.IsRunning() == 0
		QuAI_KhajiitCaravansNPCs.start()
		Gl_AIKhajiitCaravans.setValue(1)
	endif
	; Thieves Guild
	if QuAI_ThievesGuildNPCs.IsRunning() == 0
		QuAI_ThievesGuildNPCs.start()
		Gl_AIThievesGuild.setValue(1)
	endif
	; Skyrim extraNPCs
	if QuAI_WhiterunHoldExtraNPCs.IsRunning() == 0
		QuAI_EastmarchExtraNPCs.start()
		QuAI_FalkreathHoldExtraNPCs.start()
		QuAI_HaafingarExtraNPCs.start()
		QuAI_HjaalmarchExtraNPCs.start()
		QuAI_ThePaleExtraNPCs.start()
		QuAI_TheReachExtraNPCs.start()
		QuAI_TheRiftExtraNPCs.start()
		QuAI_WhiterunHoldExtraNPCs.start()
		QuAI_WinterHoldExtraNPCs.start()
		Gl_AISkyrimExtraNPCs.setValue(1)
	endif
	
	Gl_AISkyrim.setValue(1)

EndFunction

Function DisableAI ()
	; Eastmarch
	if QuAI_WindhelmNPCs.IsRunning() == 1
		QuAI_WindhelmNPCs.stop()
		QuAI_DarkWaterCrossingNPCs.stop()
		QuAI_KynesgroveNPCs.stop()
		QuAI_WindhelmJ_M.stop()
		Gl_AIEastmarch.setValue(0)
	endif
	; Falkreath Hold
	if QuAI_FalkreathNPCs.IsRunning() == 1
		QuAI_FalkreathNPCs.stop()
		QuAI_FalkreathJ_M.stop()
		Gl_AIFalkreathHold.setValue(0)
	endif
	; Haafingar
	if QuAI_SolitudeCityNPCs.IsRunning() == 1
		QuAI_SolitudeCityNPCs.stop()
		QuAI_SolitudeDockNPCs.stop()
		QuAI_SolitudeJ_M.stop()
		QuAI_DragonBridgeNPCs.stop()
		Gl_AIHaafingar.setValue(0)
	endif
	; Hjaalmarch
	if QuAI_MorthalNPCs.IsRunning() == 1
		QuAI_MorthalNPCs.stop()
		QuAI_MorthalJ_M.stop()
		QuAI_StoneHillsNPCs.stop()
		Gl_AIHjaalmarch.setValue(0)
	endif
	; Solstheim
	if QuAI_RavenRockNPCs.IsRunning() == 1
		QuAI_RavenRockNPCs.stop()
		QuAI_TelMithrynNPCs.stop()
		QuAI_SkaalVillageNPCs.stop()
		Gl_AISolstheim.setValue(0)
	endif
	; The Pale
	if QuAI_DawnstarNPCs.IsRunning() == 1
		QuAI_DawnstarNPCs.stop()
		QuAI_DawnstarJ_M.stop()
		QuAI_NightGateInnNPCs.stop()
		Gl_AIThePale.setValue(0)
	endif
	; TheReach
	if QuAI_MarkarthNPCs.IsRunning() == 1
		QuAI_MarkarthNPCs.stop()
		QuAI_MarkarthJ_M.stop()
		QuAI_OldHroldanNPCs.stop()
		QuAI_KarthwastenNPCs.stop()
		Gl_AITheReach.setValue(0)
	endif
	; The Rift
	if QuAI_RiftenNPCs.IsRunning() == 1
		QuAI_RiftenNPCs.stop()
		QuAI_RiftenJ_M.stop()
		QuAI_IvarsteadNPCs.stop()
		QuAI_ShorsStoneNPCs.stop()
		Gl_AITheRift.setValue(0)
	endif
	; Whiterun Hold
	if QuAI_WhiterunNPCs.IsRunning() == 1
		QuAI_WhiterunNPCs.stop()
		QuAI_WhiterunJ_M.stop()
		QuAI_RiverwoodNPCs.stop()
		QuAI_RoriksteadNPCs.stop()
		Gl_AIWhiterunHold.setValue(0)
	endif
	; WinterHold
	if QuAI_WinterHoldNPCs.IsRunning() == 1
		QuAI_WinterHoldNPCs.stop()
		QuAI_WinterholdJ_M.stop()
		Gl_AIWinterHold.setValue(0)
	endif
	; Companions
	if QuAI_CompanionsNPCs.IsRunning() == 1
		QuAI_CompanionsNPCs.stop()
		Gl_AICompanions.setValue(0)
	endif
	; College of Winterhold
	if QuAI_WinterholdCollegeNPCs.IsRunning() == 1
		QuAI_WinterholdCollegeNPCs.stop()
		Gl_AIWinterholdCollege.setValue(0)
	endif
	; Khajiit Caravan
	if QuAI_KhajiitCaravansNPCs.IsRunning() == 1
		QuAI_KhajiitCaravansNPCs.stop()
		Gl_AIKhajiitCaravans.setValue(0)
	endif
	; Thieves Guild
	if QuAI_ThievesGuildNPCs.IsRunning() == 1
		QuAI_ThievesGuildNPCs.stop()
		Gl_AIThievesGuild.setValue(0)
	endif
	; Skyrim extraNPCs
	if QuAI_WhiterunHoldExtraNPCs.IsRunning() == 1
		QuAI_EastmarchExtraNPCs.stop()
		QuAI_FalkreathHoldExtraNPCs.stop()
		QuAI_HaafingarExtraNPCs.stop()
		QuAI_HjaalmarchExtraNPCs.stop()
		QuAI_ThePaleExtraNPCs.stop()
		QuAI_TheReachExtraNPCs.stop()
		QuAI_TheRiftExtraNPCs.stop()
		QuAI_WhiterunHoldExtraNPCs.stop()
		QuAI_WinterHoldExtraNPCs.stop()
		Gl_AISkyrimExtraNPCs.setValue(0)
	endif
	Gl_AISkyrim.setValue(0)

EndFunction