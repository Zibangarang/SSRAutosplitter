state("Super Sami Roll")
{
    uint currentLevel: "mono-2.0-bdwgc.dll", 0x3A1C54, 0x80, 0xF74; //Holds value of current level
    bool stageCleared: "mono-2.0-bdwgc.dll", 0x3A1C68, 0x34, 0xF2C, 0x24; //Holds value of stage clearance (resets when entering level)
    float levelTime: "mono-2.0-bdwgc.dll", 0x3AAFC0, 0x440, 0xE98, 0x90, 0x94; //IGT in current level
    int gameStart: "mono-2.0-bdwgc.dll", 0x3A1C54, 0x80, 0xF28; //Game is going on
    bool cutscenePlaying: "UnityPlayer.dll", 0x12A5CE8, 0xA10; //Cutscene is playing
    int finalBossHp: "mono-2.0-bdwgc.dll", 0x3A1C40, 0x34, 0xA3C, 0x10, 0xAC; //Final boss hp
}

init
{
    vars.allowSplit = false;
}

start
{
    if(current.gameStart == 1 && old.gameStart == 0)
    {
        return true;
    }
}

reset
{
    if(current.gameStart == 0)
    {
        vars.allowSplit = false;
        return true;
    }
}

split
{
    if(current.stageCleared && vars.allowSplit)
    {
        vars.allowSplit = false;
        // print("SPLITTED!!!! StageCleared = " + current.stageCleared);
        return true;
    }

    if(current.cutscenePlaying && vars.allowSplit)
    {
        vars.allowSplit = false;
        return true;
    }

    if(current.currentLevel == 79 && current.finalBossHp == 0 && vars.allowSplit && current.levelTime > 10)
    {
        vars.allowSplit = false;
        return true;
    }

    
}

//Only allow a new split after a level has been loaded in AND the timer has been verified to be reset
update
{
    if(current.gameStart == 0)
    {
        vars.allowSplit = false;
    }

    if(!current.stageCleared && current.currentLevel < 500 && current.levelTime < 0.6 && current.levelTime > 0.2)
    {
        vars.allowSplit = true;
    }
}