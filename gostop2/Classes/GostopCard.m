
#import "GostopCard.h"

// 초기화 시에 필히 호출 되어야 함   
//    InitCardTypes();
//    InitGostopHands();

@implementation CGostopCard


- (void) InitCardTypes
{
	NSNumber *iCntNum = [[NSNumber alloc] initWithInt:4*(1-1)];
	[m_vCardTypes[KWANG] addObject:iCntNum]; 
    // m_vCardTypes[KWANG].push_back(4*(1-1));
    
	NSNumber *iCntNum2 = [[NSNumber alloc] initWithInt:4*(3-1)];
	[m_vCardTypes[KWANG] addObject:iCntNum2];
    //m_vCardTypes[KWANG].push_back(4*(3-1));
	
	NSNumber *iCntNum3 = [[NSNumber alloc] initWithInt:4*(8-1)];
	[m_vCardTypes[KWANG] addObject:iCntNum3];
    //m_vCardTypes[KWANG].push_back(4*(8-1));
	
	NSNumber *iCntNum4 = [[NSNumber alloc] initWithInt:4*(11-1)];
	[m_vCardTypes[KWANG] addObject:iCntNum4];
    //m_vCardTypes[KWANG].push_back(4*(11-1));
	
	NSNumber *iCntNum5 = [[NSNumber alloc] initWithInt:4*(12-1)];
	[m_vCardTypes[KWANG] addObject:iCntNum5];
    //m_vCardTypes[KWANG].push_back(4*(12-1));

	NSNumber *iCntNum6 = [[NSNumber alloc] initWithInt:4];
	[m_vCardTypes[YEOL] addObject:iCntNum6];
    //m_vCardTypes[YEOL].push_back(4);
	NSNumber *iCntNum7 = [[NSNumber alloc] initWithInt:12];
	[m_vCardTypes[YEOL] addObject:iCntNum7];
    //m_vCardTypes[YEOL].push_back(12);
	NSNumber *iCntNum8 = [[NSNumber alloc] initWithInt:16];
	[m_vCardTypes[YEOL] addObject:iCntNum8];
    //m_vCardTypes[YEOL].push_back(16);
	NSNumber *iCntNum9 = [[NSNumber alloc] initWithInt:20];
	[m_vCardTypes[YEOL] addObject:iCntNum9];
    //m_vCardTypes[YEOL].push_back(20);
	NSNumber *iCntNum10 = [[NSNumber alloc] initWithInt:24];
	[m_vCardTypes[YEOL] addObject:iCntNum10];
    //m_vCardTypes[YEOL].push_back(24);
	NSNumber *iCntNum11 = [[NSNumber alloc] initWithInt:29];
	[m_vCardTypes[YEOL] addObject:iCntNum11];
    //m_vCardTypes[YEOL].push_back(29);
	NSNumber *iCntNum12 = [[NSNumber alloc] initWithInt:KUKJIN];
	[m_vCardTypes[YEOL] addObject:iCntNum12];
    //m_vCardTypes[YEOL].push_back(KUKJIN);
	NSNumber *iCntNum13 = [[NSNumber alloc] initWithInt:36];
	[m_vCardTypes[YEOL] addObject:iCntNum13];
    //m_vCardTypes[YEOL].push_back(36);
	NSNumber *iCntNum14 = [[NSNumber alloc] initWithInt:45];
	[m_vCardTypes[YEOL] addObject:iCntNum14];
    //m_vCardTypes[YEOL].push_back(45);

	NSNumber *iCntNum15 = [[NSNumber alloc] initWithInt:1];
	[m_vCardTypes[YEOL] addObject:iCntNum15];
   // m_vCardTypes[TEE].push_back(1);
	NSNumber *iCntNum16 = [[NSNumber alloc] initWithInt:5];
	[m_vCardTypes[YEOL] addObject:iCntNum16];
   // m_vCardTypes[TEE].push_back(5);
	NSNumber *iCntNum17 = [[NSNumber alloc] initWithInt:9];
	[m_vCardTypes[YEOL] addObject:iCntNum17];
  //  m_vCardTypes[TEE].push_back(9);
	NSNumber *iCntNum18 = [[NSNumber alloc] initWithInt:13];
	[m_vCardTypes[YEOL] addObject:iCntNum18];
   // m_vCardTypes[TEE].push_back(13);
	NSNumber *iCntNum19 = [[NSNumber alloc] initWithInt:17];
	[m_vCardTypes[YEOL] addObject:iCntNum19];
  //  m_vCardTypes[TEE].push_back(17);
	NSNumber *iCntNum20 = [[NSNumber alloc] initWithInt:21];
	[m_vCardTypes[YEOL] addObject:iCntNum20];
    //m_vCardTypes[TEE].push_back(21);
	NSNumber *iCntNum21 = [[NSNumber alloc] initWithInt:25];
	[m_vCardTypes[YEOL] addObject:iCntNum21];
   // m_vCardTypes[TEE].push_back(25);
	NSNumber *iCntNum22 = [[NSNumber alloc] initWithInt:33];
	[m_vCardTypes[YEOL] addObject:iCntNum22];
   // m_vCardTypes[TEE].push_back(33);
	NSNumber *iCntNum23 = [[NSNumber alloc] initWithInt:37];
	[m_vCardTypes[YEOL] addObject:iCntNum23];
   // m_vCardTypes[TEE].push_back(37);
	NSNumber *iCntNum24 = [[NSNumber alloc] initWithInt:46];
	[m_vCardTypes[YEOL] addObject:iCntNum24];
   // m_vCardTypes[TEE].push_back(46);
	NSNumber *iCntNum25 = [[NSNumber alloc] initWithInt:KUKJIN];
	[m_vCardTypes[YEOL] addObject:iCntNum25];
   // m_vCardTypes[PEE].push_back(KUKJIN);
	NSNumber *iCntNum26 = [[NSNumber alloc] initWithInt:41];
	[m_vCardTypes[YEOL] addObject:iCntNum26];
   // m_vCardTypes[PEE].push_back(41);
	NSNumber *iCntNum27 = [[NSNumber alloc] initWithInt:47];
	[m_vCardTypes[YEOL] addObject:iCntNum27];
   // m_vCardTypes[PEE].push_back(47);

} // void InitCardTypes(void).

- (void) InitGostopHands
{
	NSNumber *iCntNum28 = [[NSNumber alloc] initWithInt:1];
	[m_vGostopHands[HONGDAN] addObject:iCntNum28]; 
//    m_vGostopHands[HONGDAN].push_back(1);
	NSNumber *iCntNum29 = [[NSNumber alloc] initWithInt:5];
	[m_vGostopHands[HONGDAN] addObject:iCntNum29]; 
  //  m_vGostopHands[HONGDAN].push_back(5);
	NSNumber *iCntNum30 = [[NSNumber alloc] initWithInt:9];
	[m_vGostopHands[HONGDAN] addObject:iCntNum30]; 
    //m_vGostopHands[HONGDAN].push_back(9);

	NSNumber *iCntNum31 = [[NSNumber alloc] initWithInt:21];
	[m_vGostopHands[CHUNGDAN] addObject:iCntNum31]; 
    //m_vGostopHands[CHUNGDAN].push_back(21);
	NSNumber *iCntNum32 = [[NSNumber alloc] initWithInt:41];
	[m_vGostopHands[CHUNGDAN] addObject:iCntNum32]; 
    //m_vGostopHands[CHUNGDAN].push_back(41);
	NSNumber *iCntNum33 = [[NSNumber alloc] initWithInt:46];
	[m_vGostopHands[CHUNGDAN] addObject:iCntNum33]; 
    //m_vGostopHands[CHUNGDAN].push_back(46);

	NSNumber *iCntNum34 = [[NSNumber alloc] initWithInt:13];
	[m_vGostopHands[CHODAN] addObject:iCntNum34]; 
    //m_vGostopHands[CHODAN].push_back(13);
	NSNumber *iCntNum35 = [[NSNumber alloc] initWithInt:17];
	[m_vGostopHands[CHODAN] addObject:iCntNum35]; 
    //m_vGostopHands[CHODAN].push_back(17);
	NSNumber *iCntNum36 = [[NSNumber alloc] initWithInt:25];
	[m_vGostopHands[CHODAN] addObject:iCntNum36]; 
    //m_vGostopHands[CHODAN].push_back(25);

	NSNumber *iCntNum37 = [[NSNumber alloc] initWithInt:4];
	[m_vGostopHands[GODORI] addObject:iCntNum37]; 
    //m_vGostopHands[GODORI].push_back(4);
	NSNumber *iCntNum38 = [[NSNumber alloc] initWithInt:12];
	[m_vGostopHands[GODORI] addObject:iCntNum38]; 
    //m_vGostopHands[GODORI].push_back(12);
	NSNumber *iCntNum39 = [[NSNumber alloc] initWithInt:29];
	[m_vGostopHands[GODORI] addObject:iCntNum39]; 
    //m_vGostopHands[GODORI].push_back(29);
} // void InitGostopHands(void).


- (void) Init
{
    int iCnt;

    for(iCnt=0; iCnt<PLAYER_COUNT; iCnt++)
    {
        m_nScore[iCnt] = 0;

		m_vPlayerCards[iCnt] = [[NSMutableArray alloc] init];

        m_vObtainedCards[iCnt][KWANG] = [[NSMutableArray alloc] init];
        //m_vObtainedCards[iCnt][KWANG].clear();
		m_vObtainedCards[iCnt][YEOL] = [[NSMutableArray alloc] init];
        //m_vObtainedCards[iCnt][YEOL].clear();
		m_vObtainedCards[iCnt][TEE] = [[NSMutableArray alloc] init];
        //m_vObtainedCards[iCnt][TEE].clear();
		m_vObtainedCards[iCnt][PEE] = [[NSMutableArray alloc] init];
        //m_vObtainedCards[iCnt][PEE].clear();
    }
} // void Init(void).


- (void) SortPlayerCards
{
    [self SortPlayerCards:PLAYER];
    [self SortPlayerCards:OPPONENT];
} // void SortPlayerCards(void).


static int numbersort (id obj1, id obj2, void *context)
{
	NSNumber *int1 = [obj1 lastObject];
	NSNumber *int2 = [obj2 lastObject];
	
	int int3 = [int1 intValue];
	int int4 = [int2 intValue]; 
	if(int3 < int4)
		return NSOrderedAscending;
	else if(int3 == int4)
		return NSOrderedSame;
	else
		return NSOrderedDescending;
	
}// numbersort

- (void) SortPlayerCards:(int)nPlayer
{
    //sort(m_vPlayerCards[nPlayer].begin(), m_vPlayerCards[nPlayer].end());
	[m_vPlayerCards[nPlayer] sortUsingFunction:numbersort context:nil];
} // void SortPlayerCards(int nPlayer).

- (void) SortObtainCards:(int)nPlayer
{
    [self SortObtainCards:(int)nPlayer nCardType:KWANG];
    [self SortObtainCards:(int)nPlayer nCardType:YEOL];
    [self SortObtainCards:(int)nPlayer nCardType:TEE];
    [self SortObtainCards:(int)nPlayer nCardType:PEE];
} // void SortObtainCards(int nPlayer).

- (void) SortObtainCards:(int)nPlayer  nCardType:(int) nCardType
{
//    sort(m_vObtainedCards[nPlayer][nCardType].begin(), m_vObtainedCards[nPlayer][nCardType].end());
	[m_vObtainedCards[nPlayer][nCardType] sortUsingFunction:numbersort context:nil];
	
} // void SortObtainCards(int nPlayer, int nCardType).


- (int) ObtainCard:(int) nPlayer  nIdxCard:(int) nIdxCard
{
    int nCardType = [self GetCardType:nIdxCard];

    if( ISNOCARD(nCardType) )
    {
        return NOCARD;
    }

    //m_vObtainedCards[nPlayer][nCardType].push_back(nIdxCard);
	NSNumber *cardnum = [[NSNumber alloc] initWithInt:nIdxCard];
	[m_vObtainedCards[nPlayer][nCardType] addObject:cardnum];

    return nIdxCard;
} // void ObtainCard(int nPlayer, int nIdxCard).

-(void) ReceiveCard:(int)nPlayer  nIdxCard:(int) nIdxCard
{
    //m_vPlayerCards[nPlayer].push_back( nIdxCard );
	NSNumber *cardnum = [[NSNumber alloc] initWithInt:nIdxCard];
	[m_vPlayerCards[nPlayer] addObject:cardnum];

} // void ReceiveCard(int nPlayer, int nIdxCard).


- (void) RobPee:(int) nPlayer
{
    int iCnt;
    int nOffsetCard = NOCARD;
    int nOpponent = !nPlayer;
    if(0 >= [self GetObtainedCardCount:(int)nOpponent nCardType:(int)PEE])
    {
        return;
    }

    //SortObtainCards(nPlayer);
	[self SortObtainCards:(int)nPlayer];
    //SortObtainCards(!nPlayer);
	[self SortObtainCards:(int)!nPlayer];

    iCnt = 0;
    while( ! ISNOCARD(nOffsetCard=[self GetObtainedCard:(int)nOpponent nCardType:(int)PEE nOffset:(int)iCnt]) )
    {
       if( NORMALPEE < [self IsSsangPee:(int)nOffsetCard] )
        {
            nOffsetCard = NONE;
            iCnt++;
            continue;
        }

        nOffsetCard = iCnt;
        break;
    }
    
    // ¿œπ› ««∏¶ πﬂ∞ﬂ«œ¡ˆ ∏¯«ﬂ¥Ÿ∏È,
    if( ISNOCARD(nOffsetCard) )
    {
        nOffsetCard = 0;
    }

    //ObtainCard(nPlayer, GetObtainedCard(nOpponent, PEE, nOffsetCard));
	//-(int) GetObtainedCard:(int) nPlayer nCardType:(int)nCardType nOffset:(int) nOffset
	[self ObtainCard:(int)nPlayer nIdxCard:(int)[self GetObtainedCard:(int)nOpponent nCardType:PEE nOffset:(int)nOffsetCard]];
	

    //m_vObtainedCards[nOpponent][PEE].erase(m_vObtainedCards[nOpponent][PEE].begin()+nOffsetCard);
	[m_vObtainedCards[nOpponent][PEE] removeObjectAtIndex:(int)[m_vObtainedCards[nOpponent][PEE] objectAtIndex:(int)nOffsetCard]];
	
} // void RobPee(int nPlayer).


- (int) FigureOutScore:(int)nPlayer nInitialScore:(int)nInitialScore
{
    //SortObtainCards(nPlayer);
	[self SortObtainCards:(int)nPlayer];

    m_nScore[nPlayer] = nInitialScore;

    //FigureOutGameRuleScore(nPlayer);
	[self FigureOutGameRuleScore:(int)nPlayer];
    //FigureOutGostopHandsScore(nPlayer);
	[self FigureOutGostopHandsScore:(int)nPlayer];

    if(3 <= (int)[self GetObtainedCardCount:(int)nPlayer nCardType:KWANG])    
	{
        if(0 ==(int)[self GetObtainedCardCount:(int)!nPlayer nCardType:KWANG])
        {
            m_nScore[nPlayer] *= 2;
        }
    }

    if(10 <= (int)[self GetObtainedCardCount:(int)nPlayer  nCardType:PEE])
    {
        if(6 > (int)[self GetObtainedCardCount:(int)!nPlayer nCardType:PEE])
        {
            m_nScore[nPlayer] *= 2;
        }
    }

    if( TRUE == [self IsMungDda:(int)nPlayer] )
    {
        m_nScore[nPlayer] *= 2;

        if(0 == [self GetObtainedCardCount:(int)!nPlayer nCardType:YEOL])
        {
            m_nScore[nPlayer] *= 2;
        }
    } // if( TRUE == IsMungDda(nPlayer) ).

    return m_nScore[nPlayer];
} // int FigureOutScore(int nPlayer, int nInitialScore).

- (void) FigureOutGameRuleScore:(int)nPlayer
{
    int iCnt;
    int nCntCards;
	NSNumber *iCntNum = [[NSNumber alloc] initWithInt:BIKWANG];
	
    //
    switch( nCntCards=[self GetObtainedCardCount:(int)nPlayer nCardType:KWANG] )
    {
    case 3:
        	
			
        //if(TRUE == binary_search(m_vObtainedCards[nPlayer][KWANG].begin(), 
         //                        m_vObtainedCards[nPlayer][KWANG].end(), BIKWANG) )
		if(TRUE == [m_vObtainedCards[nPlayer][KWANG] containsObject:iCntNum])
        {
            m_nScore[nPlayer] += 2;
            break;
        }

    case 4:
        m_nScore[nPlayer] += nCntCards;
        break;

    case 5:
        m_nScore[nPlayer] += 15;
        break;
    } // switch( nCntCards=GetObtainedCardCount(nPlayer, KWANG) ).

    //
    for(iCnt=YEOL; iCnt<=TEE; iCnt++)
    {
        if( 5 <= (nCntCards=[self GetObtainedCardCount:(int)nPlayer nCardType:(int)iCnt]) )
        {
            m_nScore[nPlayer] += 1+nCntCards-5;
        }
    } // for(jCnt=YEOL; jCnt<=TEE; jCnt++).

    if( 10 <= (nCntCards=[self GetObtainedPeeCount:(int)nPlayer]) )
    {
        m_nScore[nPlayer] += 1+nCntCards-10;
    }
} // void FigureOutGameRuleScore(int nPlayer).

- (void) FigureOutGostopHandsScore:(int)nPlayer
{
    int iCnt;
	bool hasscorecard = TRUE;
    for(iCnt=0; iCnt<=CHODAN; iCnt++)
    {
        //if( includes(m_vObtainedCards[nPlayer][TEE].begin(), 
        //             m_vObtainedCards[nPlayer][TEE].end(),
        //             m_vGostopHands[iCnt].begin(), m_vGostopHands[iCnt].end()) )
		// 이게 맞는지 모르겠지만 가지고 있는 카드중에 초단 카드가 있는지 검사..
		if(NSNotFound == [m_vObtainedCards[nPlayer][TEE] indexOfObject:(id)[m_vGostopHands[iCnt] objectAtIndex:0] ])
        {
			hasscorecard = FALSE;
            
        }
    }
	if(hasscorecard == TRUE)
	{
		m_nScore[nPlayer] += 3;
	}

//    if( includes(m_vObtainedCards[nPlayer][YEOL].begin(), 
//                 m_vObtainedCards[nPlayer][YEOL].end(),
//                 m_vGostopHands[GODORI].begin(), m_vGostopHands[GODORI].end()) )
	//이거 역시 맞는지 모르겠지만 가지고 있는 카드중에 고도리 카드가 있으면 5점 가산
	if(NSNotFound != [m_vObtainedCards[nPlayer][YEOL] indexOfObject:(id)[m_vGostopHands[GODORI] objectAtIndex:0] ] )
    {

        m_nScore[nPlayer] += 5;
    }
} // void FigureOutGostopHandsScore(int nPlayer).


-(int) PopPlayerCard:(int) nPlayer  nOffset:(int) nOffset
{
    int nIdxCard;

    if([self GetPlayerCardCount:(int)nPlayer] <= nOffset)
    {
        return NOCARD;
    }

    //nIdxCard = m_vPlayerCards[nPlayer].at(nOffset);
	nIdxCard = (int) [m_vPlayerCards[nPlayer] objectAtIndex:nOffset];
	
    //m_vPlayerCards[nPlayer].erase( m_vPlayerCards[nPlayer].begin() + nOffset );
	[m_vPlayerCards[nPlayer] removeObjectAtIndex:nOffset];

    return nIdxCard;
} // int PopPlayerCard(int nPlayer, int nOffset).


-(int) GetCardType:(int)nIdxCard
{
    int iCardType;

    if( ISNOCARD(nIdxCard) )
    {
        return NOCARD;
    }
    
    for(iCardType=0; iCardType<CARDTYPE_COUNT-1; iCardType++)
    {
        //if(TRUE == binary_search(m_vCardTypes[iCardType].begin(), m_vCardTypes[iCardType].end(), nIdxCard))
		NSNumber *idxcard = [[NSNumber alloc] initWithInt:nIdxCard];
		if(TRUE == [m_vCardTypes[iCardType] containsObject:idxcard])
        {
           
            return iCardType;
        }
    }

    return PEE;
} // int GetCardType(int nIdxCard).

-(BOOL) IsSsangPee:(int)nIdxCard
{
   // int iCardType;

    if(BONUSCARD2 == nIdxCard)
    {
        // BONUSCARD2
        return BONUSPEE2;
    }

    if(BONUSCARD3 == nIdxCard)
    {
        // BONUSPEE3 
        return BONUSPEE3;
    }

	NSNumber *idxcard = [[NSNumber alloc] initWithInt:nIdxCard];

    //if(TRUE == binary_search(m_vCardTypes[PEE].begin(), m_vCardTypes[PEE].end(), nIdxCard))
	if(TRUE == [m_vCardTypes[PEE] containsObject:idxcard])
    {
        return SSANGPEE;
    }

    return NORMALPEE;
} // BOOL IsSsangPee(int nIdxCard).


-(int) GetScore:(int) nPlayer
{
    return m_nScore[nPlayer];
} // int GetScore(int nPlayer).

-(BOOL) IsMungDda:(int) nPlayer
{
    return ([self GetObtainedCardCount:(int)nPlayer nCardType:YEOL] >= 7);
} // BOOL IsMungDda(int nPlayer).

-(int) CheckPresident:(int)nPlayer
{
    int iCnt;
    int nCurMonth;
    int nBeginMonth;
    int nLastMonth = NONE;
    int nCntSameMonth = 0;

    [self SortPlayerCards:(int)nPlayer];

    for(iCnt=0; iCnt<[self GetPlayerCardCount:(int)nPlayer]; iCnt++)
    {
        nCurMonth = [self GetPlayerCard:nPlayer nOffset:(int)iCnt]/4;

        if(nLastMonth == nCurMonth)
        {
            nCntSameMonth++;
        }
        else
        {
            nCntSameMonth = 1;
            nBeginMonth = iCnt;
            nLastMonth = nCurMonth;
        }

        if(4 <= nCntSameMonth)
        {
            return nBeginMonth;
        }
    } // for(iCnt=0; iCnt<GetPlayerCardCount(nPlayer); iCnt++).

    return NONE;
} // int CheckPresident(int nPlayer).


- (int) GetPlayerCardCount:(int)nPlayer
{
    return (int)[m_vPlayerCards[nPlayer] count];
} // int GetPlayerCardCount(int nPlayer).

-(int) GetPlayerCard:(int)nPlayer nOffset:(int)nOffset
{
    if([self GetPlayerCardCount:(int)nPlayer] <= nOffset)
    {
        return NOCARD;
    }

    return (int)[m_vPlayerCards[nPlayer] objectAtIndex:(int)nOffset];
} // int GetPlayerCard(int nPlayer, int nOffset).

- (int) GetSameMonthCardsCount:(int)nPlayer nIdxCard:(int) nIdxCard
{
    int iCnt;
    int nCntCards = 0;
    BOOL bFind = FALSE;
    int nMonth = nIdxCard/4;

    for(iCnt=0; iCnt<(int)[m_vPlayerCards[nPlayer] count]; iCnt++)
    {
        if((int)[m_vPlayerCards[nPlayer] objectAtIndex:((iCnt)/4)] == nMonth)
        {
            if(FALSE == bFind)
            {
                bFind = TRUE;
            }
            
            nCntCards++;
        }
        else if(TRUE == bFind)
        {
            break;
        }
    }

    return nCntCards;
} // int GetSameMonthCardsCount(int nPlayer, int nMonth).


-(int) GetObtainedCardCount:(int)nPlayer nCardType:(int)nCardType
{
    return (int)[m_vObtainedCards[nPlayer][nCardType] count];
} // int GetObtainedCardCount(int nPlayer, int nCardType).

-(int) GetObtainedCard:(int) nPlayer nCardType:(int)nCardType nOffset:(int) nOffset
{
    if([self GetObtainedCardCount:(int)nPlayer nCardType:(int)nCardType] <= nOffset)
    {
        // ƒ´µÂ æ¯¿Ω ∏Æ≈œ.
        return NOCARD;
    }

    return (int)[m_vObtainedCards[nPlayer][nCardType] objectAtIndex:nOffset];
} // int GetObtainedCard(int nPlayer, int nCardType, int nOffset).

-(int) GetObtainedPeeCount:(int) nPlayer
{
    int iCnt;

    int nCntCards = (int)[m_vObtainedCards[nPlayer][PEE] count];
    
    for(iCnt=0; iCnt< (int)[m_vObtainedCards[nPlayer][PEE] count]; iCnt++)
    {
        switch( [self IsSsangPee:(int)[m_vObtainedCards[nPlayer][PEE] objectAtIndex:iCnt]] )
        {
        case SSANGPEE:
        case BONUSPEE2:
            nCntCards += 1;
            break;

        case BONUSPEE3:
            nCntCards += 2;
            break;
        }
    }

    return nCntCards;
} // int GetObtainedPeeCount(int nPlayer).

@end