int StartingConditional()
{
    int iResult = GetLocalInt(OBJECT_SELF,"Generic_Surrender");
    if (iResult == 2)
    {
        return TRUE;
    }
    return FALSE;
}
