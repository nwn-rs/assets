//::///////////////////////////////////////////////
//:: Rogue Class
//:: TEMPL_FTR_CHRH
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does a check to see if the PC talking to
    the character is a rogue or bard
*/
//:://////////////////////////////////////////////
//:: Created By: David Gaider
//:: Created On: November 19, 2001
//:://////////////////////////////////////////////
int StartingConditional()
{
    int nClass;
    nClass = GetLevelByClass(CLASS_TYPE_ROGUE, GetPCSpeaker());
    nClass += GetLevelByClass(CLASS_TYPE_BARD, GetPCSpeaker());
    if (nClass>0)
    {
        return TRUE;
    }
    return FALSE;
}

