//---------------------------------------------------------------------------------------
//  FILE:    X2StrategyElement_XpackFacilityUpgrades.uc
//  AUTHOR:  Joe Weinhoffer
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2017 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2StrategyElement_XpackFacilityUpgrades extends X2StrategyElement_DefaultFacilityUpgrades;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Upgrades;

	// Infirmary
	Upgrades.AddItem(CreateInfirmary_RecoveryChamberTemplate());

	// Resistance Ring
	Upgrades.AddItem(CreateResistanceRing_UpgradeITemplate());
	Upgrades.AddItem(CreateResistanceRing_UpgradeIITemplate());
	Upgrades.AddItem(CreateResistanceRing_ReaperPlaqueTemplate());
	Upgrades.AddItem(CreateResistanceRing_TemplarPlaqueTemplate());
	Upgrades.AddItem(CreateResistanceRing_SkirmisherPlaqueTemplate());

	return Upgrades;
}

//---------------------------------------------------------------------------------------
// INFIRMARY UPGRADES
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateInfirmary_RecoveryChamberTemplate()
{
	local X2FacilityUpgradeTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'Infirmary_RecoveryChamber');
	Template.PointsToComplete = 0;
	Template.MaxBuild = 1;
//BEGIN AUTOGENERATED CODE: Template Overrides 'Infirmary_RecoveryChamber'
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.ChooseFacility_Infirmary_Hypervital_Module";
//END AUTOGENERATED CODE: Template Overrides 'Infirmary_RecoveryChamber'

	// Stats
	Template.iPower = -2;
	Template.UpkeepCost = 25;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 80;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

//---------------------------------------------------------------------------------------
// RESISTANCE RING UPGRADES
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateResistanceRing_UpgradeITemplate()
{
	local X2FacilityUpgradeTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'ResistanceRing_UpgradeI');
	Template.PointsToComplete = 0;
	Template.MaxBuild = 1;
//BEGIN AUTOGENERATED CODE: Template Overrides 'ResistanceRing_UpgradeI'
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.ChooseFacility_The_Ring_Upgrade1";
//END AUTOGENERATED CODE: Template Overrides 'ResistanceRing_UpgradeI'
	Template.OnUpgradeAddedFn = ResistanceRing_UpgradeAdded;

	// Stats
	Template.iPower = -2;
	Template.UpkeepCost = 30;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 100;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateResistanceRing_UpgradeIITemplate()
{
	local X2FacilityUpgradeTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'ResistanceRing_UpgradeII');
	Template.PointsToComplete = 0;
	Template.MaxBuild = 1;
//BEGIN AUTOGENERATED CODE: Template Overrides 'ResistanceRing_UpgradeII'
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.ChooseFacility_The_Ring_Upgrade2";
//END AUTOGENERATED CODE: Template Overrides 'ResistanceRing_UpgradeII'
	Template.OnUpgradeAddedFn = ResistanceRing_UpgradeAdded;
	Template.PreviousMapName = "ResistanceRing_UpgradeI";

	// Stats
	Template.iPower = -2;
	Template.UpkeepCost = 40;

	// Requirements
	Template.Requirements.RequiredUpgrades.AddItem('ResistanceRing_UpgradeI');
	Template.Requirements.SpecialRequirementsFn = AreAllResistanceFactionsMet;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 125;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

function bool AreAllResistanceFactionsMet()
{
	local XComGameStateHistory History;
	local XComGameState_ResistanceFaction FactionState;

	History = `XCOMHISTORY;
		foreach History.IterateByClassType(class'XComGameState_ResistanceFaction', FactionState)
	{
		if (!FactionState.bMetXCom)
		{
			return false;
		}
	}

	return true;
}

static function ResistanceRing_UpgradeAdded(XComGameState NewGameState, XComGameState_FacilityUpgrade Upgrade, XComGameState_FacilityXCom Facility)
{
	local XComGameState_HeadquartersResistance ResHQ;

	ResHQ = XComGameState_HeadquartersResistance(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	ResHQ = XComGameState_HeadquartersResistance(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersResistance', ResHQ.ObjectID));
	ResHQ.AddWildCardSlot();
}

static function X2DataTemplate CreateResistanceRing_ReaperPlaqueTemplate()
{
	local X2FacilityUpgradeTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'ResistanceRing_ReaperPlaque');
	Template.PointsToComplete = 0;
	Template.MaxBuild = 1;
	Template.iPower = 0;
	Template.UpkeepCost = 0;
	Template.bHidden = true;

	return Template;
}

static function X2DataTemplate CreateResistanceRing_TemplarPlaqueTemplate()
{
	local X2FacilityUpgradeTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'ResistanceRing_TemplarPlaque');
	Template.PointsToComplete = 0;
	Template.MaxBuild = 1;
	Template.iPower = 0;
	Template.UpkeepCost = 0;
	Template.bHidden = true;

	return Template;
}

static function X2DataTemplate CreateResistanceRing_SkirmisherPlaqueTemplate()
{
	local X2FacilityUpgradeTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'ResistanceRing_SkirmisherPlaque');
	Template.PointsToComplete = 0;
	Template.MaxBuild = 1;
	Template.iPower = 0;
	Template.UpkeepCost = 0;
	Template.bHidden = true;

	return Template;
}