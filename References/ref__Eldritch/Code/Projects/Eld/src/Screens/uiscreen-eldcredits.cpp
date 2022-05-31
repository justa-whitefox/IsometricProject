#include "core.h"
#include "uiscreen-eldcredits.h"
#include "Widgets/uiwidget-text.h"
#include "configmanager.h"
#include "mesh.h"

UIScreenEldCredits::UIScreenEldCredits()
:	m_Repeat( false )
,	m_TextWidget()
{
}

UIScreenEldCredits::~UIScreenEldCredits()
{
}

/*virtual*/ void UIScreenEldCredits::InitializeFromDefinition( const SimpleString& DefinitionName )
{
	UIScreen::InitializeFromDefinition( DefinitionName );

	MAKEHASH( DefinitionName );

	STATICHASH( Repeat );
	m_Repeat = ConfigManager::GetInheritedBool( sRepeat, false, sDefinitionName );

	STATICHASH( TextWidget );
	m_TextWidget = ConfigManager::GetInheritedHash( sTextWidget, HashedString::NullString, sDefinitionName );
}

/*virtual*/ UIScreen::ETickReturn UIScreenEldCredits::Tick( const float DeltaTime, bool HasFocus )
{
	XTRACE_FUNCTION;

	UIWidgetText* const pCreditsText = GetWidget<UIWidgetText>( m_TextWidget );
	DEVASSERT( pCreditsText );

	const float Bottom = pCreditsText->m_Location.y + pCreditsText->m_Mesh->m_AABB.m_Max.z - pCreditsText->m_Mesh->m_AABB.m_Min.z;
	if( Bottom < 0.0f )
	{
		if( m_Repeat )
		{
			STATICHASH( DisplayHeight );
			const float DisplayHeight	= ConfigManager::GetFloat( sDisplayHeight );
			const float ParentHeight	= pCreditsText->m_ParentWidget ? pCreditsText->m_ParentWidget->GetHeight() : DisplayHeight;
			pCreditsText->m_Location.y	= ParentHeight;

			pCreditsText->UpdateRenderPosition();
		}
		else
		{
			return ETR_Close;
		}
	}

	return UIScreen::Tick( DeltaTime, HasFocus );
}

/*virtual*/ void UIScreenEldCredits::Pushed()
{
	UIScreen::Pushed();

	UIWidgetText* const pCreditsText = GetWidget<UIWidgetText>( m_TextWidget );
	DEVASSERT( pCreditsText );

	STATICHASH( DisplayHeight );
	const float DisplayHeight	= ConfigManager::GetFloat( sDisplayHeight );
	const float ParentHeight	= pCreditsText->m_ParentWidget ? pCreditsText->m_ParentWidget->GetHeight() : DisplayHeight;
	pCreditsText->m_Location.y	= ParentHeight;

	pCreditsText->UpdateRenderPosition();
}