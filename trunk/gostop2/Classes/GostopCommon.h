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

// 플레이어 구분 상수
enum EPlayer
{
    PLAYER = 0,
    OPPONENT = 1,
    PLAYER_COUNT= 2,
};
// 카드타입 상수
enum ECardType
{
    KWANG = 0, // 광
    YEOL = 1, // 열
    TEE = 2, // 띠 
    PEE = 3, //피
    CARDTYPE_COUNT = 4,// 카드 타입 갯수
};
// 피타입
enum EPeeType
{
	// 일반 피
    NORMALPEE = 0,
	// 쌍피
    SSANGPEE = 1,
	// 2장 보너스
    BONUSPEE2 = 2,
	// 3장 보너스
    BONUSPEE3 = 3,
	// 피 타입 갯수
    PEETYPE_COUNT = 4,
};
// 게임내 규칙 상수
enum ERule
{
    GO = 0,
    SHAKE = 1,
    PPUCK = 2,
    RULE_COUNT = 3
};
// 바닥에 카드 내는 모드
enum EPutOutMode
{
    PM_NORMAL = 0, // 일반
    PM_SHAKE = 1, // 흔들기
    PM_BOMB = 2 // 폭탄
};
// 족보상수
enum EHands
{    
    HONGDAN = 0, 
    CHUNGDAN = 1,
    CHODAN = 2,
    GODORI = 3,
    HANDS_COUNT = 4
};
// 결과 룰 타입 상수
enum EResultRule
{
    RES_JJOCK = 0,
    RES_DDADDAK = 1,
    RES_PPUCK = 2,
    RES_EATPPUCK = 3,
    RES_EATJAPPUCK = 4,
    RESULTRULE_COUNT = 5
};