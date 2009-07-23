#import "GostopAgent.h"

@implementation CGostopAgent

- (void) StartNewGame
{
    [self ChangeState:(int)GS_START_NEWGAME];
} // void StartNewGame(void).



- (void) InitGame
{
    int iCnt, jCnt;


    m_nCntRobPee = 0;

    
    
	m_Card = [[CGostopCard alloc] init];
	[m_Card InitCardTypes];
	[m_Card InitGostopHands];
	[m_Card Init];
	
	
    
    //m_Floor.Init();
	m_Floor = [[CGostopFloor alloc] init];
	[m_Floor Init];
	
    
    for(iCnt=0; iCnt<PLAYER_COUNT; iCnt++)
    {
        
        m_nScore[iCnt] = 0;

        
        for(jCnt=0; jCnt<RULE_COUNT; jCnt++)
        {
            
            m_nCntRule[iCnt][jCnt];
        }
    }

    
    //SetTurn(PLAYER);
	[self SetTurn:(int)PLAYER];
	
	
} // void InitGame(void).

- (void) StartTimerfunc
{
	[NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(DoAgency:) userInfo:nil repeats:YES];
	
}

- (void) ChangeState:(int) nGameState
{
    
    m_nAgencyStep = 0;

    
    m_nGameState = nGameState;

    
    switch(nGameState)
    {
    
    case GS_START_NEWGAME:
        //InitGame();
		[self InitGame];	
        break;

    
    case GS_CHANGETURN:
        break;

    
    case GS_PLAYING:
        m_nShakingMode = NONE;
        m_nIdxPutOutCard = NOCARD;
        m_nAvailableFloorSlot = NONE;
        break;
    }
} // void ChangeState(int nGameState).



- (void) DoAgency :(NSTimer*)Timer
{
    switch(m_nGameState)
    {

    case GS_START_NEWGAME:


			[self ChangeState:GS_DISTRIBUTE];
        break;


    case GS_DISTRIBUTE:

//        DealDistributeCards();
			[self DealDistributeCards];
        break;


    case GS_PUTOUT_PLAYERCARD:

//        DealPutOutPlayerCards();
			[self DealPutOutPlayerCards];
        break;


    case GS_CHANGETURN:

//        DealChangeTurn();
			[self DealChangeTurn];
        break;
    }
} // void DoAgency().



- (void) DealDistributeCards
{
    int iCnt;

    switch(m_nAgencyStep)
    {

    case DC_READY:
        break;


    case DC_FLOORCARDS_FIRST:

        for(iCnt=0; iCnt<DISTRIBUTE_FLOOR_CARDS/2; iCnt++)
        {

            //m_Floor.AddToFloor( PopCenterCard() );
			[m_Floor AddToFloor:[self PopCenterCard]];
        }        
        break;

    case DC_FLOORCARDS_SECOND:

        for(iCnt=0; iCnt<DISTRIBUTE_FLOOR_CARDS/2+DISTRIBUTE_FLOOR_CARDS%2; iCnt++)
        {

//            m_Floor.AddToFloor( PopCenterCard() );
			[m_Floor AddToFloor:[self PopCenterCard]];
        }
        break;


    case DC_PLAYERCARDS_FIRST:

        for(iCnt=0; iCnt<DISTRIBUTE_PLAYER_CARDS/2; iCnt++)
        {
            //m_Card.ReceiveCard( PLAYER, PopCenterCard() );
			[m_Card ReceiveCard:PLAYER nIdxCard:[self PopCenterCard]];
        }
        break;


    case DC_OPPONENTCARDS_FIRST:

        for(iCnt=0; iCnt<DISTRIBUTE_PLAYER_CARDS/2; iCnt++)
        {
//            m_Card.ReceiveCard( OPPONENT, PopCenterCard() );
			[m_Card ReceiveCard:OPPONENT nIdxCard:[self PopCenterCard]];
        }
        break;


    case DC_PLAYERCARDS_SECOND:

        for(iCnt=0; iCnt<DISTRIBUTE_PLAYER_CARDS/2+DISTRIBUTE_PLAYER_CARDS%2; iCnt++)
        {
//            m_Card.ReceiveCard( PLAYER, PopCenterCard() );
			[m_Card  ReceiveCard:PLAYER nIdxCard:[self PopCenterCard]];

        }
        break;


    case DC_OPPONENTCARDS_SECOND:

        for(iCnt=0; iCnt<DISTRIBUTE_PLAYER_CARDS/2+DISTRIBUTE_PLAYER_CARDS%2; iCnt++)
        {
            //m_Card.ReceiveCard( OPPONENT, PopCenterCard() );
			[m_Card  ReceiveCard:OPPONENT nIdxCard:[self PopCenterCard]];

        }
        break;


    case DC_SORT_CARDS:

        //m_Card.SortPlayerCards();
			[m_Card SortPlayerCards];


        for(iCnt=0; iCnt<12; iCnt++)
        {
            //m_Floor.SortFloor(iCnt);
			[m_Floor SortFloor:iCnt];
        }
        break;


    case DC_PICKUP_BONUSCARDS:

//        DealPickUpBonusCards();
			[self DealPickUpBonusCards];
        break;


    case DC_CHECK_PRESIDENT:

        if(TRUE == [self DealCheckPresident])
        {

            
			sleep(3000);

            
            [self StartNewGame];
        }
        break;

    case DC_FINISH:
        
			[self ChangeState:GS_PLAYING];

        
        return;
    }

    
    m_nAgencyStep++;
} // void DealDistributeCards().


- (void) DealPickUpBonusCards
{
    int iCnt;
    int nCntPickedUp;
    int nIdxCard;

    do
    {
        nCntPickedUp = 0;


        for(iCnt=0; iCnt<12; iCnt++)
        {

            while( !(0 > (nIdxCard=[m_Floor PopBonusCard:iCnt])) )
            {


                [self ObtainCard:nIdxCard];


                nCntPickedUp++;
            }
        }


        for(iCnt=0; iCnt<nCntPickedUp; iCnt++)
        {

            [m_Floor  AddToFloor:[self PopCenterCard]];
        }
    } while(nCntPickedUp > 0);
} // void DealPickUpBonusCards().


- (BOOL) DealCheckPresident
{
    int iCnt;
    int nResult;

    //

    //
    for(iCnt=0; iCnt<12; iCnt++)
    {

        if(4 <= [m_Floor GetNormalFloorCardCount:iCnt])
        {




            return TRUE;
        }
    } // for(iCnt=0; iCnt<12; iCnt++).

    //

    //
    for(iCnt=0; iCnt<PLAYER_COUNT; iCnt++)
    {

        nResult = [m_Card CheckPresident:iCnt ];


        if( NONE != nResult )
        {





            return TRUE;
        }
    }


    return FALSE;
} // BOOL DealCheckPresident(void).



- (void) DealPutOutPlayerCards
{
    int iCnt;
    int nPutOutMonth = [m_Floor GetPutOutMonth];
    int nTurnUpMonth = [m_Floor GetTurnUpMonth];

    switch(m_nAgencyStep)
    {
    case PO_PICKUP:
			if( 0 > (m_nIdxPutOutCard = [m_Card PopPlayerCard:[self GetTurn]  nOffset:m_nGSParam1]))
        {
//            ChangeState(GS_PLAYING);
			[self ChangeState:GS_PLAYING];
            return;
        } // if( ISNOCARD(m_nIdxPutOutCard = m_Card.PopPlayerCard(GetTurn(), m_nGSParam1)) ).

        if( (BOMBCARD) ==(m_nIdxPutOutCard) )
        {
            [m_Floor PutToFloor:[self GetTurn] nIdxCard:NOCARD];

            m_nAgencyStep = PO_TURNUP;
            return;
        } // if( ISBOMBCARD(m_nIdxPutOutCard) ).

        //if( ISBONUSCARD(m_nIdxPutOutCard) )
		if((BONUSCARD2 == (m_nIdxPutOutCard)) || (BONUSCARD3 == (m_nIdxPutOutCard)))
        {
            [self ObtainCard:m_nIdxPutOutCard];

            [m_Card ReceiveCard:[self GetTurn]  nIdxCard:[m_Floor PopCenterCard]];
            [m_Card SortPlayerCards:[self GetTurn]];

            [self ChangeState:GS_PLAYING];
            return;
        } // if( ISBONUSCARD(m_nIdxPutOutCard) ).

			m_nAvailableFloorSlot = [m_Floor GetAvailableFloorSlot:m_nIdxPutOutCard];
        break;

    case PO_CHECKSHAKE:
        m_nShakingMode = PM_NORMAL;

		if( 2 <= [m_Card GetSameMonthCardsCount:(int)[self GetTurn]  nIdxCard:m_nIdxPutOutCard] )
        {
            m_nShakingMode = PM_SHAKE;

            for(iCnt=0; iCnt<[self GetFloorCardCount:m_nAvailableFloorSlot]; iCnt++)
            {
				Byte offset = iCnt /4 ;
				if([m_Floor GetFloorCard:m_nAvailableFloorSlot byOffset:offset] == m_nIdxPutOutCard/4)
					//why??
                //if([self GetFloorCardInAgent:m_nAvailableFloorSlot :(Byte)offset] == m_nIdxPutOutCard/4)
                {
                    m_nShakingMode = PM_BOMB;
                    break;
                }
            }
        }
        break;

    case PO_PUTOUT:
		switch( [m_Floor PutToFloor:[self GetTurn] nIdxCard:m_nIdxPutOutCard nMonth:m_nAvailableFloorSlot] )
        {
        case RES_EATPPUCK:
            m_nCntRobPee += 1;
            break;

        case RES_EATJAPPUCK:
            m_nCntRobPee += 2;
            break;
        } // switch( m_Floor.PutToFloor(GetTurn(), m_nIdxPutOutCard, m_nAvailableFloorSlot) ).

        switch(m_nShakingMode)
        {
        case PM_SHAKE:
            break;

        case PM_BOMB:
            for(iCnt=0; iCnt<[self GetPlayerCardCount]; iCnt++)
            {
                if([self GetPlayerCard:(iCnt)/4] == m_nIdxPutOutCard/4)
                {
                    break;
                }
            }

			while([self GetPlayerCard:(iCnt)/4] == m_nIdxPutOutCard/4)
            {
                [m_Floor AddToFloor:[m_Card PopPlayerCard:[self GetTurn] nOffset:iCnt] nMonth:m_nAvailableFloorSlot ];
            }

			[m_Card ReceiveCard:[self GetTurn] nIdxCard:BOMBCARD];
            [m_Card ReceiveCard:[self GetTurn] nIdxCard:BOMBCARD];

            m_nCntRobPee++;
            break;
        } // switch(m_nShakingMode).
        break;

    case PO_TURNUP:
			m_nGSParam2 = [m_Floor TurnUpCard:[self GetTurn] ];
        break;
        
    case PO_CHECKRULE:
        switch( m_nGSParam2 )
        {
        case BONUSCARD2:
        case BONUSCARD3:
            m_nAgencyStep = PO_TURNUP;
            return;

        case RES_PPUCK:
            m_nCntRule[[self GetTurn]][PPUCK]++;
            break;

        case RES_EATJAPPUCK:
            m_nCntRobPee++;
        case RES_EATPPUCK:
				[self ObtainFloorCard: nPutOutMonth ];
        case RES_JJOCK:
        case RES_DDADDAK:
				while( ! (0 > ( [self ObtainCard:[m_Floor PopFloorCard:nTurnUpMonth]])) );
				if(0 == [m_Card GetPlayerCardCount:PLAYER] 
				   && 0 == [m_Card  GetPlayerCardCount:OPPONENT])
            {
                break;
            }

            m_nCntRobPee++;
            break;

        default:
				[self ObtainFloorCard: nPutOutMonth];
				[self ObtainFloorCard: nTurnUpMonth ];
            break;
        } // switch( m_nGSParam2 ).
        break;

    case PO_CHANGETURN:
			[self ChangeState:GS_CHANGETURN];
        return;
    } // switch(m_nAgencyStep).

    m_nAgencyStep++;
} // void DealPutOutPlayerCards(void).


- (void) DealChangeTurn
{
    switch(m_nAgencyStep)
    {
    case CT_ROBPEE:
        while(m_nCntRobPee-- > 0)
        {
            [m_Card RobPee:[self GetTurn]];
        }
        break;

    case CT_CHECKENDOFGAME:
        m_nCntRobPee = 0;

		if(0 == [m_Card  GetPlayerCardCount:[self GetTurn]] && 0 == [m_Card GetPlayerCardCount:![self GetTurn]])
		{
            while( !( 0 > ( [self ObtainCard:[m_Floor PopCenterCard]] )) );
            [self ChangeState:GS_PLAYING];
            return;
        }
        break;

    case CT_CHANGETURN:
        
			[self SetTurn:(![self GetTurn])];

			[self ChangeState:GS_PLAYING];
        return;
    }

    m_nAgencyStep++;
} // void DealChangeTurn(void).


- (void) PutOutPlayerCard:(int) nOffsetPlayerCard
{
    [self ChangeState:GS_PUTOUT_PLAYERCARD];

    m_nGSParam1 = nOffsetPlayerCard;
} // void PutOutPlayerCard(int nOffsetPlayerCard).


- (void) ObtainFloorCard:(int) nMonth
{
    if(NONE == nMonth)
    {
        return;
    }

    while( !( 0 > ( [self ObtainCard:[m_Floor PopBonusCard:nMonth]] )) );
    

    switch( [m_Floor GetNormalFloorCardCount:nMonth] )
    {
    case 1:
        break;

    case 3:
			[self ObtainCard:[m_Floor PopFloorCard:nMonth] ];
			[self ObtainCard:[m_Floor PopFloorCard:nMonth] ];
        break;

    default:
			while( !( 0 > ( [self ObtainCard:[m_Floor PopFloorCard:nMonth]] )) );
    }
} // void CGotopAgent::ObtainFloorCard(int nMonth).

- (int) ObtainCard:(int) nIdxCard
{
    int nResult;


    nResult = [m_Card ObtainCard:[self GetTurn]  nIdxCard:nIdxCard];

    [self FigureOutScore];

    return nResult;
} // int ObtainCard(int nIdxCard).


- (void) FigureOutScore
{
    int iPlayer;

    for(iPlayer=0; iPlayer<PLAYER_COUNT; iPlayer++)
    {
        m_nScore[iPlayer] = [m_Card FigureOutScore:iPlayer  nInitialScore:m_nCntRule[iPlayer][GO]];

        m_nScore[iPlayer] *= pow(2, m_nCntRule[iPlayer][SHAKE]);

        if(m_nCntRule[iPlayer][GO] >= 3)
        {
            m_nScore[iPlayer] *= pow(2, m_nCntRule[iPlayer][GO]-2);
        }

        if(0 < m_nCntRule[!iPlayer][GO])
        {
            m_nScore[iPlayer] *= 2;
        }
    } // for(iPlayer=0; iPlayer<PLAYER_COUNT; iPlayer++).
} // void FigureOutScore(void).


- (int) PopCenterCard
{
    return [m_Floor PopCenterCard];
} // int PopCenterCard(void).


- (int) PopFloorCard:(int) nMonth
{
    return [m_Floor PopFloorCard:nMonth];
} // int PopFloorCard(int nMonth).

- (int) PopFloorCard:(int) nMonth  byOffset:(Byte)byOffset
{
    return [m_Floor PopFloorCard:nMonth  byOffset:byOffset];
} // int PopFloorCard(int nMonth, BYTE byOffset).


- (int) GetState
{
    return m_nGameState;
} // int GetState(void).

- (void) SetTurn:(int) nPlayer
{
    m_nTurn = nPlayer;
} // void SetTurn(int nPlayer).

- (int) GetTurn
{
    return m_nTurn;
} // int GetTurn(void).


- (int) GetCardType:(int) nIdxCard
{
    return [m_Card GetCardType:nIdxCard];
} // int GetCardType(int nIdxCard).


- (int) GetScore:(int) nPlayer
{
    return m_nScore[nPlayer];
} // int GetScore(int nPlayer).

- (int) GetRuleCount:(int) nPlayer nRuleType:(int) nRuleType
{
    return m_nCntRule[nPlayer][nRuleType];
} // int GetRuleCount(int nPlayer, int nRuleType).


- (int) GetCenterCardCount
{
    return [m_Floor GetCenterCardCount];
} // int GetCenterCardCount(void).


- (int) GetFloorCardCount:(int) nMonth
{
    return [m_Floor GetFloorCardCount:nMonth];
} // int GetFloorCardCount(int nMonth).


- (int) GetFloorCard:(int)nMonth boffset:(Byte)boffset
{
	return [m_Floor GetFloorCard:nMonth byOffset:boffset];
}

- (int) GetPlayerCardCount
{
    return [m_Card GetPlayerCardCount:[self GetTurn]];
} // int GetPlayerCardCount(void).

- (int) GetPlayerCardCount:(int) nPlayer
{
    return [m_Card GetPlayerCardCount:nPlayer];
} // int GetPlayerCardCount(int nPlayer).

- (int) GetPlayerCard:(int) nOffset
{
    return [m_Card GetPlayerCard:[self GetTurn] nOffset:nOffset];
} // int GetPlayerCard(int nOffset).

- (int) GetPlayerCard:(int) nPlayer nOffset:(int) nOffset
{
    return [m_Card GetPlayerCard:nPlayer  nOffset:nOffset];
} // int GetPlayerCard(int nPlayer, int nOffset).


- (int) GetObtainedCardCount:(int) nPlayer nCardType:(int) nCardType
{
    return [m_Card GetObtainedCardCount:nPlayer nCardType:nCardType];
} // int GetObtainedCardCount(int nPlayer, int nCardType).

- (int) GetObtainedCard:(int) nPlayer nCardType:(int) nCardType nOffset:(int) nOffset
{
    return [m_Card GetObtainedCard:nPlayer nCardType:nCardType nOffset:nOffset];
} // int GetObtainedCard(int nPlayer, int nCardType, int nOffset).


@end