//::///////////////////////////////////////////////
//:: Evards Black Tentacles: Heartbeat
//:: NW_S0_EvardsB
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Upon remaining within the mass of rubbery tentacles the
    target is struck by 1d4 + 1/lvl tentacles.  Each
    makes a grapple check. If it succeeds then
    it does 1d6+4 damage and the target must make
    a Fortitude Save versus paralysis or be paralyzed
    for 1 round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////
//:: GZ: Removed SR, its not there by the book


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    object oTarget;
    effect eParal = EffectParalyze();
    effect eDur = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eLink = EffectLinkEffects(eDur, eParal);
    effect eDam;
    effect eFail = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nDieDam;
    float fDelay;
    int nNumberTargets = 0;
    int nTargetSize;
    int nTentacleGrappleCheck;
    int nOpposedGrappleCheck;
    int nOppossedGrappleCheckModifiers;
    int nHits;
    int nMinimumTargets = 2;
    int nTentaclesPerTarget;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);

    if ( nCasterLevel > 20 )
    {
        nCasterLevel = 20;
    }

    nTentaclesPerTarget = d4();
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nTentaclesPerTarget = 4;
    }
    nTentaclesPerTarget = nTentaclesPerTarget + nCasterLevel;
    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nTentaclesPerTarget = nTentaclesPerTarget + (nTentaclesPerTarget/2); //Number of variable tentacles is +50%
    }

    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if ( GetCreatureSize(oTarget) >= CREATURE_SIZE_MEDIUM )
        {
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
            {
                nNumberTargets++;
            }
        }
        else
        {
            // Some visual feedback that the spell doesn't affect creatures of this type.
            fDelay = GetRandomDelay(0.75, 1.5);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFail, oTarget,fDelay);
        }
        oTarget = GetNextInPersistentObject();
    }

    if ( nNumberTargets > 0 )
    {
        // Distribute the tentacle between all valid targets.
        if ( nNumberTargets < nMinimumTargets )
        {
           // If there is only one target in the area, then only a portion of the tentacles should be able to reach them.
            nTentaclesPerTarget = nTentaclesPerTarget/nMinimumTargets;
        }
        else
        {
            nTentaclesPerTarget = nTentaclesPerTarget/nNumberTargets;
        }

        oTarget = GetFirstInPersistentObject();
        while(GetIsObjectValid(oTarget))
        {
            nDamage = 0;
            nTargetSize = GetCreatureSize(oTarget);
            if ( nTargetSize >= CREATURE_SIZE_MEDIUM )
            {
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
                {
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EVARDS_BLACK_TENTACLES));

                    nOppossedGrappleCheckModifiers = GetBaseAttackBonus(oTarget) + GetAbilityModifier(ABILITY_STRENGTH,oTarget);
                    if (nTargetSize == CREATURE_SIZE_LARGE )
                    {
                        nOppossedGrappleCheckModifiers = nOppossedGrappleCheckModifiers + 4;
                    }
                    else if ( nTargetSize = CREATURE_SIZE_HUGE )
                    {
                        nOppossedGrappleCheckModifiers = nOppossedGrappleCheckModifiers + 8;
                    }

                    for (nHits = nTentaclesPerTarget; nHits > 0; nHits--)
                    {
                        // Grapple Check.
                        nTentacleGrappleCheck = d20() + nCasterLevel + 8; // Str(4) + Large Tentacle(4)
                        nOpposedGrappleCheck = d20() + nOppossedGrappleCheckModifiers;

                        if(nTentacleGrappleCheck >= nOpposedGrappleCheck)
                        {
                            nDieDam = d6() + 4;
                            //Enter Metamagic conditions
                            if (nMetaMagic == METAMAGIC_MAXIMIZE)
                            {
                                nDieDam = 10;//Damage is at max 6+4=10
                            }

                            if (nMetaMagic == METAMAGIC_EMPOWER)
                            {
                                nDieDam = nDieDam + (nDieDam/2); //Damage/Healing is +50%
                            }
                            nDamage = nDamage + nDieDam;

                            eDam = EffectDamage(nDieDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWO);
                            fDelay = GetRandomDelay(0.75, 1.5);
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        }
                    }
                }
            }

            if(nDamage > 0)
            {
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                {
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1)));
                }
            }

            oTarget = GetNextInPersistentObject();
        }
    }
}
