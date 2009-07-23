#pragma once



#define GAME_TOTAL_BONUS2           1
#define GAME_TOTAL_BONUS3           1
#define GAME_TOTAL_BONUSCARD       (GAME_TOTAL_BONUS2 + GAME_TOTAL_BONUS3)
#define GAME_TOTAL_CARD             (48 + GAME_TOTAL_BONUSCARD)

#define BONUSCARD                   48
#define BONUSCARD2                  48
#define BONUSCARD3                  49
#define BOMBCARD                    50

#define BACK_CARD                   GAME_TOTAL_CARD + 1


#define DISTRIBUTE_FLOOR_CARDS      8
#define DISTRIBUTE_PLAYER_CARDS     10

#define KUKJIN                      32
#define BIKWANG                     44

#define NONE        -1
#define NOCARD      -1
//#define ISNOCARD(_CRESULT_)         ((_CRESULT_) < 0)
//#define ISBOMBCARD(_CARDINDEX_)     ((BOMBCARD) == (_CARDINDEX_))
//s#define ISBONUSCARD(_CARDINDEX_)    ((BONUSCARD2 == (_CARDINDEX_)) || (BONUSCARD3 == (_CARDINDEX_)))


enum EPlayer
{
    PLAYER,
    OPPONENT,
    PLAYER_COUNT
};

enum ECardType
{
    KWANG,
    YEOL,
    TEE,
    PEE,
    CARDTYPE_COUNT
};

enum EPeeType
{
    NORMALPEE,
    SSANGPEE,
    BONUSPEE2,
    BONUSPEE3,
    PEETYPE_COUNT
};

enum ERule
{
    GO,
    SHAKE,
    PPUCK,
    RULE_COUNT
};

enum EPutOutMode
{
    PM_NORMAL,
    PM_SHAKE,
    PM_BOMB
};

enum EHands
{    
    HONGDAN,
    CHUNGDAN,
    CHODAN,
    GODORI,
    HANDS_COUNT
};

enum EResultRule
{
    RES_JJOCK,
    RES_DDADDAK,
    RES_PPUCK,
    RES_EATPPUCK,
    RES_EATJAPPUCK,
    RESULTRULE_COUNT
};