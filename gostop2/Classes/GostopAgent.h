
#import "GostopCommon.h"
#import "GostopFloor.h"
#import "GostopCard.h"

@class CGostopCard;
@class CGostopFloor;
enum EGameState
{
	GS_NULL,
	GS_START_NEWGAME,
	GS_DISTRIBUTE,
	GS_PLAYING,
	GS_CHANGETURN,
	GS_PUTOUT_PLAYERCARD,
	GS_COUNT
};

enum EDistributeCardState
{
	DC_READY,
	DC_FLOORCARDS_FIRST,
	DC_FLOORCARDS_SECOND,
	DC_PLAYERCARDS_FIRST,
	DC_OPPONENTCARDS_FIRST,
	DC_PLAYERCARDS_SECOND,
	DC_OPPONENTCARDS_SECOND,
	DC_SORT_CARDS,
	DC_PICKUP_BONUSCARDS,
	DC_CHECK_PRESIDENT,
	DC_FINISH,
	DC_COUNT
};


enum EPutOutState
{
	PO_PICKUP,
	PO_CHECKSHAKE,
	PO_PUTOUT,
	PO_TURNUP,
	PO_CHECKRULE,
	PO_CHANGETURN,
	PO_COUNT
};

enum EChangeTurnState
{
	CT_ROBPEE,
	CT_CHECKENDOFGAME,
	CT_CHANGETURN,
	CT_COUNT
};
//
@interface CGostopAgent : NSObject
{
    int m_nGameState;
    int m_nAgencyStep;
	
    int m_nGSParam1;
    int m_nGSParam2;
    int m_nIdxPutOutCard;
    int m_nShakingMode;
    int m_nAvailableFloorSlot;
	CGostopFloor *m_Floor;
	CGostopCard *m_Card;
    int m_nTurn;
    int m_nCntRobPee;
    int m_nScore[PLAYER_COUNT];
    int m_nCntRule[PLAYER_COUNT][RULE_COUNT];
}
- (void) StartNewGame;

- (void) InitGame;

- (void) ChangeState:(int)nGameState;

- (void) DoAgency:(NSTimer*)Timer;

- (void) StartTimerfunc;
- (void) DealDistributeCards;
- (void) DealPickUpBonusCards;
- (BOOL) DealCheckPresident;

- (void) DealPutOutPlayerCards;
- (void) DealChangeTurn;


- (void) PutOutPlayerCard:(int)nOffsetPlayerCard;

- (void) ObtainFloorCard:(int)nMonth;
- (int) ObtainCard:(int)nIdxCard;

- (void) FigureOutScore;


- (int) PopCenterCard;

- (int) PopFloorCard:(int) nMonth;
- (int) PopFloorCard:(int) nMonth byOffset:(Byte) byOffset;


- (int) GetState;

- (void) SetTurn:(int) nPlayer;
- (int) GetTurn;

- (int) GetCardType:(int) nIdxCard;

- (int) GetScore:(int) nPlayer;
- (int) GetRuleCount:(int) nPlayer nRuleType:(int) nRuleType;


- (int) GetCenterCardCount;

- (int) GetFloorCardCount:(int) nMonth;


- (int) GetPlayerCardCount;
- (int) GetPlayerCardCount:(int) nPlayer;
- (int) GetPlayerCard:(int) nOffset;
- (int) GetPlayerCard:(int) nPlayer nOffset:(int) nOffset;

- (int) GetObtainedCardCount:(int) nPlayer nCardType:(int) nCardType;
- (int) GetObtainedCard:(int) nPlayer  nCardType:(int)nCardType nOffset:(int) nOffset;


- (int) GetFloorCard:(int)nMonth boffset:(Byte)boffset;

@end