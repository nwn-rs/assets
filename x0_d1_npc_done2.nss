//:://////////////////////////////////////////////////
//:: X0_D1_NPC_DONE2
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
/*
Mark the player as having finished quest 2.
 */
//:://////////////////////////////////////////////////
//:: Created By: Naomi Novik
//:: Created On: 09/26/2002
//:://////////////////////////////////////////////////

#include "x0_i0_plotgiver"

void main()
{
    SetQuestDone(GetPCSpeaker(), 2);
}
