//:://////////////////////////////////////////////////
//:: X0_D1_NPC_TAKE3
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
/*
Mark the player as having taken quest 3.
 */
//:://////////////////////////////////////////////////
//:: Created By: Naomi Novik
//:: Created On: 09/26/2002
//:://////////////////////////////////////////////////

#include "x0_i0_plotgiver"

void main()
{
    SetOnQuest(GetPCSpeaker(), 3);
}
