;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname NPCO_QF_NPCO_Initialisation_05A2DF2A Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

; PROPERTIES -------------------------------------------------------------------------------

GlobalVariable property ModVersion auto
GlobalVariable property Gl_AISkyrim auto

Actor property NPC_Alfarinn auto
Actor property NPC_Bjorlam auto
Actor property NPC_Gort auto
Actor property NPC_Harlaug auto
Actor property NPC_Jolf auto
Actor property NPC_Kibell auto
Actor property NPC_Sigaar auto
Actor property NPC_Thaer auto


Faction property Faction_Agent auto
Faction property Faction_Citizens auto
Faction property Faction_CreatureFriend auto
Faction property Faction_Dragon auto
Faction property Faction_Mage auto
Faction property Faction_Thieves auto

NPCO_Update property ImmersiveCitizens Auto

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
	ImmersiveCitizens.ActivateAI ()
	ImmersiveCitizens.Compatibility()

; Faction removal
	NPC_Alfarinn.RemoveFromFaction (Faction_CreatureFriend)
	NPC_Bjorlam.RemoveFromFaction (Faction_CreatureFriend)
	NPC_Gort.RemoveFromFaction (Faction_CreatureFriend)
	NPC_Harlaug.RemoveFromFaction (Faction_CreatureFriend)
	NPC_Jolf.RemoveFromFaction (Faction_CreatureFriend)
	NPC_Kibell.RemoveFromFaction (Faction_CreatureFriend)
	NPC_Sigaar.RemoveFromFaction (Faction_CreatureFriend)
	NPC_Thaer.RemoveFromFaction (Faction_CreatureFriend)
; Faction Relationship
	Faction_Dragon.SetEnemy (Faction_Agent)
	Faction_Dragon.SetEnemy (Faction_Citizens)
	Faction_Dragon.SetEnemy (Faction_Mage)
	Faction_Dragon.SetEnemy (Faction_Thieves)

	If Gl_AISkyrim.GetValue()==1
		ModVersion.setvalue(0.39)
		Debug.Notification("Immersive Citizens has been activated.")
	Else
		Debug.MessageBox("Failed to initialize Immersive Citizens. Missing Files.")
	EndIf
	Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment