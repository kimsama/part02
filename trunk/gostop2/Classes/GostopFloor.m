

#import "GostopFloor.h"



@implementation CGostopFloor



- (void) Init
{
    int iCnt;
	
    m_nLastMonth = NONE;
    m_nPutOutMonth = NONE;
    m_nTurnUpMonth = NONE;
		
	m_vCenterCards = [[NSMutableArray alloc] init];
    for(iCnt=0; iCnt<12; iCnt++)
    {
       
		m_vFloorCards[iCnt] = [[NSMutableArray alloc] init];
        m_nPpuckConvict[iCnt] = NONE;
    }
	
    for(iCnt=0; iCnt<GAME_TOTAL_CARD; iCnt++)
    {
		NSNumber *iCntNum = [[NSNumber alloc] initWithInt:iCnt];
		[m_vCenterCards addObject:iCntNum];
    }
	
	

	[self ShuffleCenterCards];
} // void CGostopFloor::Init(void).

- (void) ShuffleCenterCards
{
    
	for(int i = 0 ; i < 400; i++)
	{
		NSUInteger idx1 = random() % 47;
		NSUInteger idx2 = random() % 47;
		
		[m_vCenterCards exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2];
	}

} // void CGostopFloor::ShuffleCenterCards(void).


- (int) HasBonusCard:(int)nMonth
{
    int iCnt;
	int iFloorCardCount = [self GetFloorCardCount:nMonth];
    for(iCnt=0; iCnt < iFloorCardCount; iCnt++)
    {
        NSNumber *numbercard = [m_vFloorCards[nMonth] objectAtIndex:iCnt]; 
		if( ISBONUSCARD((int)[numbercard intValue]) )
        {
            break;
        }
    }
	
    if(iCnt == iFloorCardCount)
    {
        return NOCARD;
    }
	
    return iCnt;
} // INT CGostopFloor::HasBonusCard(INT nMonth).


- (int) AddToFloor:(int)nIdxCard
{
	return [self AddToFloor:nIdxCard nMonth:[self GetAvailableFloorSlot:nIdxCard]];
} // INT CGostopFloor::AddToFloor(INT nIdxCard).

- (int) AddToFloor:(int)nIdxCard nMonth:(int)nMonth
{
    if( ISNOCARD(nIdxCard) )
    {
        return NOCARD;
    }
	
	NSNumber *iCntNum = [[NSNumber alloc] initWithInt:nIdxCard];
	[m_vFloorCards[nMonth] addObject:iCntNum];
	m_nLastMonth = nMonth;
	
    return m_nLastMonth;
} // INT CGostopFloor::AddToFloor(INT nIdxCard, INT nMonth).


-(int) PutToFloor:(int)nPlayer nIdxCard:(int)nIdxCard
{
    return [self PutToFloor:nPlayer nIdxCard:nIdxCard];
} // INT CGostopFloor::PutToFloor(INT nPlayer, INT nIdxCard).

-(int) PutToFloor:(int)nPlayer nIdxCard:(int)nIdxCard nMonth:(int)nMonth
{
    m_nLastMonth = NONE;
    m_nTurnUpMonth = NONE;
   
	m_nPutOutMonth = [self AddToFloor:nIdxCard nMonth:nMonth];
	
    if( 4 <= [self GetNormalFloorCardCount:m_nPutOutMonth] )
    {
        
        if(nPlayer == m_nPpuckConvict[m_nPutOutMonth]) 
        {
            m_nPpuckConvict[m_nPutOutMonth] = NONE;
			
            return RES_EATJAPPUCK;
        }
        else
        {
            m_nPpuckConvict[m_nPutOutMonth] = NONE;
			
          
            return RES_EATPPUCK;
        }
    }
	
    return NONE;
} // INT CGostopFloor::PutToFloor(INT nPlayer, INT nIdxCard, INT nMonth).

- (int) numbersort:(id)obj1  second:(id)obj2 
{
	NSNumber *int1 = (NSNumber*)obj1;
	NSNumber *int2 = (NSNumber*)obj2;
	
	int int3 = [int1 intValue];
	int int4 = [int2 intValue]; 
	if(int3 < int4)
		return NSOrderedAscending;
	else if(int3 == int4)
		return NSOrderedSame;
	else
		return NSOrderedDescending;
	
}// numbersort


- (void) SortFloor:(int)nMonth
{
	//[m_vFloorCards[nMonth] sortUsingFunction:numbersort context:nil];
	int count = [m_vFloorCards[nMonth] count];
	
    for(int i = 0; i < count ; i++)
	{
		for(int j = count; j > 0 ; j--)
		{
			j--;
			NSNumber *first = [m_vFloorCards[nMonth] objectAtIndex:i];
			NSNumber *second = [m_vFloorCards[nMonth] objectAtIndex:j];
			
			if(first == nil && second == nil) 
				continue;
			
			if(first == nil)
			{
				//[m_vFloorCards[nMonth] insertObject:second atIndex:i];
			}else if(second == nil)
			{				
				//[m_vFloorCards[nMonth] insertObject:first atIndex:j];
			}else
			{
				int result = [self numbersort:first second:second ];
				if(result == NSOrderedDescending)
				{
					[m_vFloorCards[nMonth] exchangeObjectAtIndex:(NSUInteger)i withObjectAtIndex:(NSUInteger)j];
				}
			}
		}
	}
	
} // void CGostopFloor::SortFloor(INT nMonth).


- (int) TurnUpCard:(int)nPlayer
{
    int nIdxCard;
    int nResult = NONE;
    int nCntTurnUpMonth;
	
    if( ISNOCARD(nIdxCard = [self PopCenterCard]) )
    {
        return NOCARD;
    }
	
    m_nTurnUpMonth = [self AddToFloor:nIdxCard];
	
    if( ISBONUSCARD(nIdxCard) )
    {
        return nIdxCard;
    }
	
    nCntTurnUpMonth = [self GetNormalFloorCardCount:m_nTurnUpMonth];
	
    if(m_nTurnUpMonth == m_nPutOutMonth)
    {
        switch( nCntTurnUpMonth )
        {
			case 2:
				nResult = RES_JJOCK;
				break;
				
			case 4:
				nResult = RES_DDADDAK;
				break;
				
			case 3:
				nResult = RES_PPUCK;
				m_nPpuckConvict[m_nPutOutMonth] = nPlayer;
				break;
        }
    } // if(m_nTurnUpMonth == m_nPutOutMonth).
    else if( nCntTurnUpMonth >= 4 )
    {
        
        if(nPlayer == m_nPpuckConvict[m_nPutOutMonth]) 
        {
            m_nPpuckConvict[m_nPutOutMonth] = NONE;
			
            nResult = RES_EATJAPPUCK;
        }
        else
        {
            m_nPpuckConvict[m_nPutOutMonth] = NONE;
			
           
            nResult = RES_EATPPUCK;
        }
    } // else if( nCntTurnUpMonth >= 4 ).
	
    return nResult;
} // INT CGostopFloor::TurnUpCard(INT nPlayer).


- (int) PopCenterCard
{
    int nIdxCard;
	
    if([self GetCenterCardCount] <= 0)
    {
        return NOCARD;
    }
	NSNumber *lastcard = [m_vCenterCards lastObject];
	nIdxCard = (int)[lastcard intValue];
		
    //m_vCenterCards.pop_back();
	[m_vCenterCards removeLastObject];
	
    return nIdxCard;
} // INT CGostopFloor::PopCenterCard(void).

- (int) PopFloorCard:(int)nMonth
{
    int nIdxCard;
	
    if(0 >= [self GetFloorCardCount:nMonth])
    {
        return NOCARD;
    }
	NSNumber *card = [m_vFloorCards[nMonth] lastObject];
    nIdxCard = (int)[card intValue];
    //m_vFloorCards[nMonth].pop_back();
	[m_vFloorCards[nMonth] removeLastObject];
    return nIdxCard;
} // INT CGostopFloor::PopFloorCard(INT nMonth).

- (int) PopFloorCard:(int)nMonth byOffset:(Byte)byOffset
{
    int nIdxCard;
	
    if(byOffset >= [self GetFloorCardCount:nMonth])
    {
        return NOCARD;
    }
	NSNumber *card = [m_vFloorCards[nMonth] objectAtIndex:byOffset];
    nIdxCard = (int)[card intValue];
    //m_vFloorCards[nMonth].erase(m_vFloorCards[nMonth].begin()+byOffset);
	[m_vFloorCards[nMonth] removeObjectAtIndex:byOffset];
	
    return nIdxCard;
} // INT CGostopFloor::PopFloorCard(INT nMonth, BYTE byOffset).


- (int) PopBonusCard:(int)nMonth
{
    int nOffset;
    int nIdxCard;
	
    nOffset = [self HasBonusCard:nMonth];
	
    if( ISNOCARD(nOffset) )
    {
        return NOCARD;
    }
	
    //nIdxCard = m_vFloorCards[nMonth].at(nOffset);
    //m_vFloorCards[nMonth].erase(m_vFloorCards[nMonth].begin() + nOffset);
	NSNumber *card = [m_vFloorCards[nMonth] objectAtIndex:nOffset];
    nIdxCard = (int)[card intValue];
	[m_vFloorCards[nMonth] removeObjectAtIndex:nOffset];
	
	
    return nIdxCard;
} // INT CGostopFloor::PopBonusCard(INT nMonth).


- (int) GetCenterCardCount
{
    return [m_vCenterCards count];
} // INT CGostopFloor::GetCenterCardCount(void).


- (int) GetFloorCardCount:(int)nMonth
{
    return [m_vFloorCards[nMonth] count];
} // INT CGostopFloor::GetFloorCardCount(INT nMonth).

- (int) GetFloorCard:(int)nMonth byOffset:(Byte) byOffset
{
    if(byOffset >= [self GetFloorCardCount:nMonth])
    {
        return NOCARD;
    }
	
    return (int)[[m_vFloorCards[nMonth] objectAtIndex:byOffset] intValue] ;
} // INT CGostopFloor::GetFloorCard(INT nMonth, BYTE byOffset).

- (int) GetNormalFloorCardCount:(int)nMonth
{
    return [self GetFloorCardCount:nMonth] - [self GetBonusCardCount:nMonth];
} // INT CGostopFloor::GetNormalFloorCardCount(INT nMonth).


- (int) GetBonusCardCount:(int)nMonth
{
    int iCnt;
    int nCntBonusCard = 0;
	
    for(iCnt=0; iCnt<[self GetFloorCardCount:nMonth]; iCnt++)
    {
        if( ISBONUSCARD((int)[[m_vFloorCards[nMonth] objectAtIndex:iCnt] intValue]) )
        {
            nCntBonusCard++;
        }
    }
	
    return nCntBonusCard;
} // INT CGostopFloor::GetBonusCardCount(INT nMonth).


- (int) GetAvailableFloorSlot:(int)nIdxCard
{
    int iCnt;
    int nTargetMonth = NONE;
    BOOL bBonusCard = ISBONUSCARD( nIdxCard );
	
    if( TRUE == bBonusCard && NONE != m_nLastMonth )
    {
        nTargetMonth = m_nLastMonth;
    }
    else
    {
        for(iCnt=0; iCnt< 12; iCnt++)
        {
            if([self GetFloorCardCount:iCnt] > 0)
            {
                if(((int)[[m_vFloorCards[iCnt] objectAtIndex:0] intValue])/4 == nIdxCard/4)
                {
                    nTargetMonth = iCnt;
                    break;
                }
				
                if(NONE == nTargetMonth)
                {
                    if( ISBONUSCARD((int)[[m_vFloorCards[iCnt] objectAtIndex:0] intValue]) && (0==(int)[self GetNormalFloorCardCount:iCnt]) )
                    {
                        nTargetMonth = iCnt;
                        continue;
                    }
                }
            }
            else if(NONE == nTargetMonth)
            {
                nTargetMonth = iCnt;
            }
        } // for(iCnt=0; iCnt<12; iCnt++).
    }
	
    if( ISNOCARD(nTargetMonth) )
    {
    
        nTargetMonth = 0;
    }
	
    return nTargetMonth;
} // INT CGostopFloor::GetAvailableFloorSlot(INT nIdxCard).


- (int) GetPutOutMonth
{
    return m_nPutOutMonth;
} // INT CGostopFloor::GetPutOutMonth(void).

- (int) GetTurnUpMonth
{
    return m_nTurnUpMonth;
} // INT CGostopFloor::GetTurnUpMonth(void).

@end
