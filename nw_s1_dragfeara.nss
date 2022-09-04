//::///////////////////////////////////////////////
//:: Aura of Fear On Enter
//:: NW_S1_DragFearA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Upon entering the aura of the creature the player
    must make a will save or be struck with fear because
    of the creatures presence.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 25, 2001
//:: LastUpdated: 24, Oct 2003, GeorgZ
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    object oTarget = GetEnteringObject();
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eFear = EffectFrightened();
    effect eLink = EffectLinkEffects(eFear, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    int nHD = GetHitDice(GetAreaOfEffectCreator());

    int nDC =     GetDragonFearDC(GetHitDice(GetAreaOfEffectCreator()));//10 + GetHitDice(GetAreaOfEffectCreator())/3;

    int nDuration = GetScaledDuration(nHD, oTarget);
    //--------------------------------------------------------------------------
    // Capping at 20
    //--------------------------------------------------------------------------
    if (nDuration > 20)
    {
        nDuration = 20;
    }
    //--------------------------------------------------------------------------
    // Yaron does not like the stunning beauty of a very specific dragon to
    // last more than 10 rounds ....
    //--------------------------------------------------------------------------
    if (GetTag(GetAreaOfEffectCreator()) == "q3_vixthra")
    {
        nDuration = 3+d6();
    }

    if(GetIsEnemy(oTarget, GetAreaOfEffectCreator()))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELLABILITY_AURA_FEAR));
        //Make a saving throw check
        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
