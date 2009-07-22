
#import "GostopCommon.h"
#import <Foundation/Foundation.h>

//
// CGostopFloor
//
@interface CGostopFloor : NSObject
{

	NSMutableArray *m_vCenterCards;
	NSMutableArray *m_vFloorCards[12];
    //vector<int> m_vCenterCards;
    //vector<int> m_vFloorCards[12];
	

    int m_nLastMonth;
	
    int m_nPutOutMonth;
    int m_nTurnUpMonth;
	

    int m_nPpuckConvict[12];
	
}

- (void) Init;

- (void) ShuffleCenterCards;


- (int) HasBonusCard:(int)nMonth;


- (int) AddToFloor:(int)nIdxCard;
- (int) AddToFloor:(int)nIdxCard nMonth:(int)nMonth;

- (int) PutToFloor:(int)nPlayer nIdxCard:(int)nIdxCard;
- (int) PutToFloor:(int)nPlayer nIdxCard:(int)nIdxCard nMonth:(int)nMonth;

- (int) TurnUpCard:(int) nPlayer;
- (void) SortFloor:(int) nMonth;


- (int) PopCenterCard;


- (int) PopFloorCard:(int) nMonth;
- (int) PopFloorCard:(int) nMonth byOffset:(Byte) byOffset;
- (int) PopBonusCard:(int) nMonth;



- (int) GetCenterCardCount;


- (int) GetFloorCardCount:(int) nMonth;
- (int) GetNormalFloorCardCount:(int) nMonth;
- (int) GetFloorCard:(int) nMonth byOffset:(Byte) byOffset;


- (int) GetBonusCardCount:(int)nMonth;


- (int) GetAvailableFloorSlot:(int)nCardIdx;


- (int) GetPutOutMonth;
- (int) GetTurnUpMonth;
- (int) numbersort:(id) obj1 second: (id) obj2;

@end
