
#import "GostopCommon.h"

//
// CGostopCard
// 
@interface CGostopCard : NSObject
{

	NSMutableArray *m_vCardTypes[CARDTYPE_COUNT];
	
    NSMutableArray *m_vGostopHands[HANDS_COUNT];
	
	
	
    NSMutableArray *m_vPlayerCards[PLAYER_COUNT];
	
    NSMutableArray *m_vObtainedCards[PLAYER_COUNT][CARDTYPE_COUNT];

    int m_nScore[PLAYER_COUNT];


    
}; // class CGostopCard.

- (void) InitCardTypes;

- (void) InitGostopHands;


- (void) Init;


- (void) SortPlayerCards;

   - (void) SortPlayerCards:(int)nPlayer;

- (void) SortObtainCards:(int)nPlayer;

- (void) SortObtainCards:(int)nPlayer nCardType:(int)nCardType;

- (int) ObtainCard:(int)nPlayer nIdxCard:(int)nIdxCard;

- (void) ReceiveCard:(int)nPlayer nIdxCard:(int) nIdxCard;


- (void) RobPee:(int)nPlayer;


- (int) FigureOutScore:(int)nPlayer nInitialScore:(int)nInitialScore; //0



- (int) PopPlayerCard:(int)nPlayer nOffset:(int)nOffset;


- (int) GetCardType:(int) nIdxCard;

- (BOOL) IsSsangPee:(int) nIdxCard;

- (int) GetScore:(int) nPlayer;

- (void) FigureOutGameRuleScore:(int) nPlayer;

- (void) FigureOutGostopHandsScore:(int) nPlayer;


- (BOOL) IsMungDda:(int) nPlayer;

- (int) CheckPresident:(int) nPlayer;



- (int) GetPlayerCardCount:(int) nPlayer;

- (int) GetPlayerCard:(int)nPlayer  nOffset:(int) nOffset;

- (int) GetSameMonthCardsCount:(int) nPlayer  nIdxCard:(int) nIdxCard;


- (int) GetObtainedCardCount:(int) nPlayer  nCardType:(int) nCardType;

- (int) GetObtainedCard:(int) nPlayer nCardType: (int) nCardType  nOffset: (int) nOffset;


- (int) GetObtainedPeeCount:(int) nPlayer;

- (int) numbersort:(id) obj1 second: (id) obj2;

@end