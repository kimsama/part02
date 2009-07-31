#import "GostopAgent.h"

@implementation CGostopAgent
// 새 게임 시작
- (void) StartNewGame
{
    [self ChangeState:(int)GS_START_NEWGAME];
} // void StartNewGame(void).


// 게임 초기화
- (void) InitGame
{
    int iCnt, jCnt;
	m_bAnimEvent = false;
	// 뺏어올 피 장수 초기화
    m_nCntRobPee = 0;

    MoveCards = [[NSMutableArray alloc] initWithCapacity:20];
	for(int i = 0; i < 20 ;i++)
	{
		Movepoint[i] = CGPointMake( 0, 0 );
	}
    // 카드 초기화
	m_Card = [[CGostopCard alloc] init];
	[m_Card InitCardTypes];
	[m_Card InitGostopHands];
	[m_Card Init];
	
	
    // 바닥 초기화
	m_Floor = [[CGostopFloor alloc] init];
	[m_Floor Init];
	
    // 플레이어 수 만큼 룹을 돌며 초기화
    for(iCnt=0; iCnt<PLAYER_COUNT; iCnt++)
    {
        // 점수 초기화
        m_nScore[iCnt] = 0;

        // 규칙 수 만큼 룹을 돌며 초기화
        for(jCnt=0; jCnt<RULE_COUNT; jCnt++)
        {
            // 규칙 횟수 카운트 초기화
            m_nCntRule[iCnt][jCnt];
        }
    }

    // 기본선은 플레이어
    //SetTurn(PLAYER);
	[self SetTurn:(int)PLAYER];
	
	
} // void InitGame(void).
// 타이머 함수 실행
- (void) StartTimerfunc
{
	[NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(DoAgency:) userInfo:nil repeats:YES];
	
}
// 게임 상태 변경
- (void) ChangeState:(int) nGameState
{
    // 에이전시 스텝 초기화
    m_nAgencyStep = 0;

    // 상태 변경
    m_nGameState = nGameState;

    // 상태에 따른 이벤트 처리
    switch(nGameState)
    {
    // 새로운 게임 시작
    case GS_START_NEWGAME:
        //InitGame();
		[self InitGame];	
        break;

    // 턴 변경
    case GS_CHANGETURN:
        break;

    // 게임 진행 모드
    case GS_PLAYING:
        m_nShakingMode = NONE;
        m_nIdxPutOutCard = NOCARD;
        m_nAvailableFloorSlot = NONE;
        break;
    }
} // void ChangeState(int nGameState).


// 게임 진행
- (void) DoAgency :(NSTimer*)Timer
{
    switch(m_nGameState)
    {
			// 게임 시작
    case GS_START_NEWGAME:
			
			NSLog(@"new game start");

			[self ChangeState:GS_DISTRIBUTE];
        break;

			// 게임 시작 후 카드 분배
    case GS_DISTRIBUTE:
			// 카드 분배	
//        DealDistributeCards();
			[self DealDistributeCards];
        break;

			// 카드를 바닥에 냄
    case GS_PUTOUT_PLAYERCARD:
			// 카드를 바닥에 내는 것의 단곕ㄹ 처리
//        DealPutOutPlayerCards();
			[self DealPutOutPlayerCards];
        break;

			// 턴 변경
    case GS_CHANGETURN:
			// 턴 변경 단계별 처리
//        DealChangeTurn();
			[self DealChangeTurn];
        break;
    }
} // void DoAgency().


// 카드 분배 처리
- (void) DealDistributeCards
{
    int iCnt;

    switch(m_nAgencyStep)
    {
			// 처음엔 잠시 대기
    case DC_READY:
        break;

			// 바닥에 카드 분배
    case DC_FLOORCARDS_FIRST:
			
		
		// 바닥에 까는 카드중 반을 낸다.
        for(iCnt=0; iCnt<DISTRIBUTE_FLOOR_CARDS/2; iCnt++)
        {
			// 바닥에 카드 추가
			[m_Floor AddToFloor:[self PopCenterCard]];
			
        }        
        break;

    case DC_FLOORCARDS_SECOND:
			// 바닥에 까는 카드중 나머지 반을 낸다.
        for(iCnt=0; iCnt<DISTRIBUTE_FLOOR_CARDS/2+DISTRIBUTE_FLOOR_CARDS%2; iCnt++)
        {
			// 바닥에 카드 추가.
			[m_Floor AddToFloor:[self PopCenterCard]];
        }
        break;

			
    case DC_PLAYERCARDS_FIRST:
			// 나눠주야할 카드중 반을 준다.
        for(iCnt=0; iCnt<DISTRIBUTE_PLAYER_CARDS/2; iCnt++)
        {	// 줘야할 카드중 반을 준다.
            //m_Card.ReceiveCard( PLAYER, PopCenterCard() );
			[m_Card ReceiveCard:PLAYER nIdxCard:[self PopCenterCard]];
        }
        break;


    case DC_OPPONENTCARDS_FIRST:
			// 상대방에게 카드중 반을 준다.
        for(iCnt=0; iCnt<DISTRIBUTE_PLAYER_CARDS/2; iCnt++)
        {	// 줘야할 카드중 반을 준다.
//            m_Card.ReceiveCard( OPPONENT, PopCenterCard() );
			[m_Card ReceiveCard:OPPONENT nIdxCard:[self PopCenterCard]];
        }
        break;


    case DC_PLAYERCARDS_SECOND:
			// 플레이어에게 나머지 반을 준다.
        for(iCnt=0; iCnt<DISTRIBUTE_PLAYER_CARDS/2+DISTRIBUTE_PLAYER_CARDS%2; iCnt++)
        {	// 플레이어에게 카드를 추가
//            m_Card.ReceiveCard( PLAYER, PopCenterCard() );
			[m_Card  ReceiveCard:PLAYER nIdxCard:[self PopCenterCard]];

        }
        break;


    case DC_OPPONENTCARDS_SECOND:
			// 상대방에게 카드중 반을 준다.
        for(iCnt=0; iCnt<DISTRIBUTE_PLAYER_CARDS/2+DISTRIBUTE_PLAYER_CARDS%2; iCnt++)
        {	// 상대방에게 카드를 추가
            //m_Card.ReceiveCard( OPPONENT, PopCenterCard() );
			[m_Card  ReceiveCard:OPPONENT nIdxCard:[self PopCenterCard]];

        }
        break;


    case DC_SORT_CARDS:
			// 플레이어들의 카드를 정렬한다.
        //m_Card.SortPlayerCards();
			[m_Card SortPlayerCards];

			// 바닥에 카드를 정렬
        for(iCnt=0; iCnt<12; iCnt++)
        {
            //m_Floor.SortFloor(iCnt);
			[m_Floor SortFloor:iCnt];
        }
        break;


    case DC_PICKUP_BONUSCARDS:
			// 바닥에서 보너스 피를 추출
//        DealPickUpBonusCards();
			[self DealPickUpBonusCards];
        break;


    case DC_CHECK_PRESIDENT:
			// 총통 검사
        if(TRUE == [self DealCheckPresident])
        {
			NSLog(@"총통입니다.~!");
            // 3초 대기
			sleep(3000);

			// 새게임 시작	
            [self StartNewGame];
        }
        break;

    case DC_FINISH:
        // 플레이 상태로 변경
			[self ChangeState:GS_PLAYING];

        
        return;
    }

//   if(!m_bAnimEvent)
	{
		m_nAgencyStep++;
	}
} // void DealDistributeCards().

// 보너스 카드 픽업
- (void) DealPickUpBonusCards
{
    int iCnt;
    int nCntPickedUp;
    int nIdxCard;

    do
    {
        nCntPickedUp = 0;

		// 바닥에서 보너스 카드를 추출
        for(iCnt=0; iCnt<12; iCnt++)
        {
			// 보너스 카드가 있는 월을 찾았다면
            while( !(0 > (nIdxCard=[m_Floor PopBonusCard:iCnt])) )
            {
				NSLog(@"첫턴 보너스 카드 가져감 %d",nIdxCard);
				// 첫턴이 보너스 카드를 가져감	
                [self ObtainCard:nIdxCard];

				// 픽업 카운트
                nCntPickedUp++;
            }
        }

		// 픽업 카드를 먹은 만큼 루프를 돌며
        for(iCnt=0; iCnt<nCntPickedUp; iCnt++)
        {
			// 바닥에 새 카드를 붙여 넣는다.
            [m_Floor  AddToFloor:[self PopCenterCard]];
        }
    } while(nCntPickedUp > 0);
} // void DealPickUpBonusCards().

// 플레이어 카드와 바닥에서 총통 체크
- (BOOL) DealCheckPresident
{
    int iCnt;
    int nResult;

    //
	// 먼저 바닥에서 총통을 체크
    //
    for(iCnt=0; iCnt<12; iCnt++)
    {
		// 바닥에 4장 이상의 같은 월의 카드가 있다면
        if(4 <= [m_Floor GetNormalFloorCardCount:iCnt])
        {
			NSLog(@"바닥 %d번 슬롯 총통!",iCnt);


			// 총통이다
            return TRUE;
        }
    } // for(iCnt=0; iCnt<12; iCnt++).

    //
	// 플레이어 카드에서 총통을 체크
    //
    for(iCnt=0; iCnt<PLAYER_COUNT; iCnt++)
    {
		// 총통을 체크
        nResult = [m_Card CheckPresident:iCnt ];

		// 총통을 발견했다면
        if( NONE != nResult )
        {
			NSLog(@"%d번 플레이어 %d월의 총통입니다.~!",iCnt, [m_Card GetPlayerCard:iCnt nOffset:nResult]/4);



			// 총통
            return TRUE;
        }
    }

	// 총통 패를 발견 못함
    return FALSE;
} // BOOL DealCheckPresident(void).


// 플레이어 카드를 바닥에 내는 것 처리
- (void) DealPutOutPlayerCards
{
    int iCnt;
    int nPutOutMonth = [m_Floor GetPutOutMonth];
    int nTurnUpMonth = [m_Floor GetTurnUpMonth];

    switch(m_nAgencyStep)
    {
    case PO_PICKUP:
			// 낼 카드를 고름
			// 플레이어 슬롯에서 해당 카드를 빼고,
			if( 0 > (m_nIdxPutOutCard = [m_Card PopPlayerCard:[self GetTurn]  nOffset:m_nGSParam1]))
        {
			//해당 슬롯에 카드가 없다면
			//아무것도 하지 않음
//            ChangeState(GS_PLAYING);
			[self ChangeState:GS_PLAYING];
            return;
        } // if( ISNOCARD(m_nIdxPutOutCard = m_Card.PopPlayerCard(GetTurn(), m_nGSParam1)) ).

			if([self GetTurn] == PLAYER)
			{
				NSLog(@"플레이어가 바닥에 카드를 냄 (%d)",m_nIdxPutOutCard);
			}else
			{
				NSLog(@"상대가 바닥에 카드를 냄 (%d)",m_nIdxPutOutCard);
			}
			
			// 폭탄 카드라면
        if( (BOMBCARD) ==(m_nIdxPutOutCard) )
        {
			// 폭탄 카드는 바닥에 내는 카드가 아니므로,
			// 빈 카드를 바닥에 붙여 초기화 시킨 후,
            [m_Floor PutToFloor:[self GetTurn] nIdxCard:NOCARD];
			// 그냥 바로 중앙 카드 뒤집기로 간다.	
            m_nAgencyStep = PO_TURNUP;	
            return;
        } // if( ISBOMBCARD(m_nIdxPutOutCard) ).
			// 보너스 카드라면
        //if( ISBONUSCARD(m_nIdxPutOutCard) )
		if((BONUSCARD2 == (m_nIdxPutOutCard)) || (BONUSCARD3 == (m_nIdxPutOutCard)))
        {	// 그냥 플레이어가 획득
            [self ObtainCard:m_nIdxPutOutCard];
			// 중앙의 카드를 뒤집어서 플레이어가 가져감
            [m_Card ReceiveCard:[self GetTurn]  nIdxCard:[m_Floor PopCenterCard]];
			// 해당 플레이어 카드 정렬
            [m_Card SortPlayerCards:[self GetTurn]];
			// 그냥 플레이 상태로 돌아감
            [self ChangeState:GS_PLAYING];
            return;
        } // if( ISBONUSCARD(m_nIdxPutOutCard) ).
			// 몇월에 붙일 수 있는 지 체크
			m_nAvailableFloorSlot = [m_Floor GetAvailableFloorSlot:m_nIdxPutOutCard];
        break;
			
    case PO_CHECKSHAKE:
        m_nShakingMode = PM_NORMAL; // 기본 값 - 일반 모드
			// 흔들 수 있는 상태 인지 체크 후,
		if( 2 <= [m_Card GetSameMonthCardsCount:(int)[self GetTurn]  nIdxCard:m_nIdxPutOutCard] )
        {
			// 원래는 바로 흔드는 것이 아니라 
			// 흔들 것인지 물어보아야 한다.
			// 아직 미구현이므로 일단 무조건 흔들자
            m_nShakingMode = PM_SHAKE;
			// 내려는 슬롯에 같은 월의 카드가 존재하는 지 체크
            for(iCnt=0; iCnt<[self GetFloorCardCount:m_nAvailableFloorSlot]; iCnt++)
            {
				//같은 월의 카드를 발견했다면,
				Byte offset = iCnt /4 ;
				if([m_Floor GetFloorCard:m_nAvailableFloorSlot byOffset:offset] == m_nIdxPutOutCard/4)
					//why??
                //if([self GetFloorCardInAgent:m_nAvailableFloorSlot :(Byte)offset] == m_nIdxPutOutCard/4)
                {//폭탄
                    m_nShakingMode = PM_BOMB;
                    break;
                }
            }
        }
        break;

    case PO_PUTOUT:
			// 픽업한 카드를 바닥에 낸다.
		switch( [m_Floor PutToFloor:[self GetTurn] nIdxCard:m_nIdxPutOutCard nMonth:m_nAvailableFloorSlot] )
        {
				// 뻑을 먹었다면
        case RES_EATPPUCK:
				NSLog(@"뻑먹음 1장");
            m_nCntRobPee += 1;
            break;
				// 자기가 싼 뻑을 먺었다면
        case RES_EATJAPPUCK:
				NSLog(@"자뻑먹음");
            m_nCntRobPee += 2;
            break;
        } // switch( m_Floor.PutToFloor(GetTurn(), m_nIdxPutOutCard, m_nAvailableFloorSlot) ).
			// 흔듬/ 폭탄 처리
        switch(m_nShakingMode)
        {
        case PM_SHAKE:
            break;

        case PM_BOMB:
				// 루프를 돌며 같은 월이 있는 첫번째 인덱스를 검색
            for(iCnt=0; iCnt<[self GetPlayerCardCount]; iCnt++)
            {	// 같은 월을 찾았다면
                if([self GetPlayerCard:(iCnt)/4] == m_nIdxPutOutCard/4)
                {	// 루프를 벗어남
                    break;
                }
            }
				// 같은 월의 카드를 모두 냄
			while([self GetPlayerCard:(iCnt)/4] == m_nIdxPutOutCard/4)
            {	// 바닥의 방금 낸 슬롯에 해당 카드를 한번 더 냄
				// 특별히 처리할 것이 없으므로, 한번 더 낸다.
                [m_Floor AddToFloor:[m_Card PopPlayerCard:[self GetTurn] nOffset:iCnt] nMonth:m_nAvailableFloorSlot ];
            }
				// 폭탄 카드 두장을 추가로 획득
			[m_Card ReceiveCard:[self GetTurn] nIdxCard:BOMBCARD];
            [m_Card ReceiveCard:[self GetTurn] nIdxCard:BOMBCARD];
				NSLog(@"폭탄 1장 + 1장");
				// 빼앗아 올 피 장수 증가
            m_nCntRobPee++;
            break;
        } // switch(m_nShakingMode).
        break;

    case PO_TURNUP:
			// 중앙의 카드를 뒤집어 바닥에 붙이고 , 몇월에 붙었는지 기억
			m_nGSParam2 = [m_Floor TurnUpCard:[self GetTurn] ];
        break;
        
    case PO_CHECKRULE:
			// 바닥에 붙인 결과에 따라서
        switch( m_nGSParam2 )
        {
				// 뒤집엇는데 보너스 카드가 나온 경우
        case BONUSCARD2:
        case BONUSCARD3:
				// 한 스텝 뒤로 돌아가 다시 카드를 뒤집는다.
            m_nAgencyStep = PO_TURNUP;
            return;

        case RES_PPUCK:
				// 뻑인 경우
				// 아무것도 먹지 못함
				// 그냥 뻑 횟수만 카운트
            m_nCntRule[[self GetTurn]][PPUCK]++;
            break;
				// 자뻑인 경우,
        case RES_EATJAPPUCK:
				// 턴 변경시 뺏어와야할 피가 총 2장
				// 따라서, 카드 획득 처리 전 , 피 1장 증가
            m_nCntRobPee++;
				// 자뻑인 경우도 ㅣ 쪽/따닥 등과 마찬가지로 
				// 아래 문장을 공통적으로 처리해야하므로,
				// 여기서  브레이크를 하면 안된다.
				NSLog(@"자뻑 먹음! 피1장 (%d)월", nPutOutMonth);
				// 뻑을 먹은 경우
        case RES_EATPPUCK:
				// 처음 낸 카드는 먹을 수 있다면 획득
				[self ObtainFloorCard: nPutOutMonth ];
				NSLog(@"뻑 먹음! (%d)월",nPutOutMonth);
				//쪽인 경우
        case RES_JJOCK:
				// 따닥인 경우
        case RES_DDADDAK:
				NSLog(@"쪽/ 따닥/자뻑! 모든 패를 먹기 시작 (%d)",m_nGSParam2);
				NSLog(@"해당 슬롯(%d)의 카드수:  (%d)",nTurnUpMonth,[m_Floor GetFloorCardCount:nTurnUpMonth]);
			while( ! (0 > ( [self ObtainCard:[m_Floor PopFloorCard:nTurnUpMonth]])) );
				NSLog(@"해당 슬롯(%d)의 카드수: (%d)",nTurnUpMonth, [m_Floor GetFloorCardCount:nTurnUpMonth]);
				NSLog(@"쪽/따닥/자뻑 모든패를 먹기 끝.");
				// 마지막 턴인 경우, 플레이어, 상대방의 카드가 0장인 경우
			if(0 == [m_Card GetPlayerCardCount:PLAYER] && 0 == [m_Card  GetPlayerCardCount:OPPONENT])
            {
				NSLog(@"막턴 이므로 쪽따닥뻑 무효");
                break;
            }
				NSLog(@"쪽/따닥 먹음!");
				// 턴 변경시 뺏어와야할 피 1장 증가
            m_nCntRobPee++;
            break;

        default:
				// 특별한 사항이 없다면
				
				// 낸카드와
				[self ObtainFloorCard: nPutOutMonth];
				// 뒤집은 카드를 먹음.
				[self ObtainFloorCard: nTurnUpMonth ];
            break;
        } // switch( m_nGSParam2 ).
        break;

    case PO_CHANGETURN:
			NSLog(@"턴 변경");
			[self ChangeState:GS_CHANGETURN];
        return;
    } // switch(m_nAgencyStep).
	// 스텝 증가
    m_nAgencyStep++;
} // void DealPutOutPlayerCards(void).

// 턴 변경
- (void) DealChangeTurn
{
    switch(m_nAgencyStep)
    {
    case CT_ROBPEE:
			NSLog(@"빼앗아 와야할 피 : (%d)",m_nCntRobPee);
			//빼앗아 와야할 피의 장수 만큼
        while(m_nCntRobPee-- > 0)
        {
			NSLog(@"피 1장 가져옴 (%d) -> (%d)",!m_nTurn, m_nTurn);
			// 피를 빼앗아 온다.
            [m_Card RobPee:[self GetTurn]];
        }
        break;

    case CT_CHECKENDOFGAME:
			//빼어올 피 장수 초기화
        m_nCntRobPee = 0;
			// 턴을 바꾸기 전에 게임이 끝났는지 확인한다.
		if(0 == [m_Card  GetPlayerCardCount:[self GetTurn]] && 0 == [m_Card GetPlayerCardCount:![self GetTurn]])
		{
			// 모든 플레이어의 카드 갯수가 0이라면,
			// 게임이 끝났다고 볼수 있다.
			// 게임이 끝났을때, 바닥에 패가 남아있다면
			// 이는 분명히 서비스 패일 것이다.
			// 따라서 뒤집어서 플레이어가 가져간다.
			
			NSLog(@"바닥에 남은 보너스 피 가져감 시작");
			// 바닥에 남은 카드를 모두 가져감
            while( !( 0 > ( [self ObtainCard:[m_Floor PopCenterCard]] )) );
			// 게임이 끝났다면, 턴을 바꾸지 않는다.
			
            [self ChangeState:GS_PLAYING];
            return;
        }
        break;

    case CT_CHANGETURN:
			NSLog(@"턴 변경 (%d) ->(%d)",m_nTurn , !m_nTurn);
			// 최종적으로 턴 변경
			[self SetTurn:(![self GetTurn])];
			// 플레이 상태로 복귀
			[self ChangeState:GS_PLAYING];
        return;
    }
	// 에이젼시 스텝 증가+
    m_nAgencyStep++;
} // void DealChangeTurn(void).

// 플레이어 보유 카드 중 하나를 바닥에 낸다.
- (void) PutOutPlayerCard:(int) nOffsetPlayerCard
{
	// 현재 턴인 플레이어의 카드를 한장 바닥에 낸다.
    [self ChangeState:GS_PUTOUT_PLAYERCARD];
	// 1번 파라미터 : 오프셋.
    m_nGSParam1 = nOffsetPlayerCard;
} // void PutOutPlayerCard(int nOffsetPlayerCard).

// 바닥ㅇ ㅔ있는 카드 획득
- (void) ObtainFloorCard:(int) nMonth
{
	// 음수 값이 들어왔으면
    if(NONE == nMonth)
    {	// 검사 하지 않고 리턴
        return;
    }
	// 일단 보너스 카드를 모두 먹고,
	if([m_Floor PopBonusCard:nMonth] > 0)
	{
		while(  0 < ( [self ObtainCard:[m_Floor PopBonusCard:nMonth]] ) );
	}
    
    
	// 먹을수 있는지 체크하고 패를 획득
    switch( [m_Floor GetNormalFloorCardCount:nMonth] )
    {
			// 1장 있다면, 아무것도 안함
    case 1:
        break;
			// 3장 있다면 둘중에 하나를 선택해서 먹어야 한다.
			// 아직 미구현 상태 그냥 뒤의 두장을 먹는다.
    case 3:
			// 맨뒤의 두장의 카드를 먹는다.
			[self ObtainCard:[m_Floor PopFloorCard:nMonth] ];
			[self ObtainCard:[m_Floor PopFloorCard:nMonth] ];
        break;

    default:
			NSLog(@"바닥(%d)에 있는 패 총 %d장 모두 획득",nMonth, [m_Floor GetFloorCardCount:nMonth]);
			// 2장 , 4장이 있다면
			// 그냥 다 먹어버림
			// 해당 월의 카드를 모두 먹고,
			while( !( 0 > ( [self ObtainCard:[m_Floor PopFloorCard:nMonth]] )) );
			NSLog(@"바닥(%d)에 있는 패 총 %d장 모두 획득",nMonth, [m_Floor GetFloorCardCount:nMonth]);

    }
} // void CGotopAgent::ObtainFloorCard(int nMonth).
// 현재 턴 플레이어가 카드 획득
- (int) ObtainCard:(int) nIdxCard
{
    int nResult;

	if([self GetTurn]== PLAYER && nIdxCard > 0)
	{
		NSLog(@"카드 획득 (%d)",nIdxCard);
	}else if([self GetTurn] == OPPONENT)
	{
		NSLog(@"카드 획득 (%d)",nIdxCard);
	}
	
	// 카드 획득
    nResult = [m_Card ObtainCard:[self GetTurn]  nIdxCard:nIdxCard];
	// 점수 계산
    [self FigureOutScore];
	
    return nResult;
} // int ObtainCard(int nIdxCard).

// 점수 계산
- (void) FigureOutScore
{
    int iPlayer;
	// 플레이어들의 점수를 계산해준다.
    for(iPlayer=0; iPlayer<PLAYER_COUNT; iPlayer++)
    {
		// 고 한 횟수만큼 기본 점수 획득.
        m_nScore[iPlayer] = [m_Card FigureOutScore:iPlayer  nInitialScore:m_nCntRule[iPlayer][GO]];
		// 계산된 점수에 게임 룰을 적용
		// 흔든 횟수 만큼 점수에 제곱승.
		
        m_nScore[iPlayer] *= pow(2, m_nCntRule[iPlayer][SHAKE]);
		// 3고 이상이라면
        if(m_nCntRule[iPlayer][GO] >= 3)
        {
			// 3고 부터는 2의 고 횟수의 2승 배로 
            m_nScore[iPlayer] *= pow(2, m_nCntRule[iPlayer][GO]-2);
        }
		// 상대방이 고를 한적이 있따면, 독박
        if(0 < m_nCntRule[!iPlayer][GO])
        {	// 독박이면 두배,
            m_nScore[iPlayer] *= 2;
        }
    } // for(iPlayer=0; iPlayer<PLAYER_COUNT; iPlayer++).
} // void FigureOutScore(void).

// 센터 카드 추출
- (int) PopCenterCard
{
    return [m_Floor PopCenterCard];
} // int PopCenterCard(void).

// 해당 월의 마지막 카드 획득
- (int) PopFloorCard:(int) nMonth
{
    return [m_Floor PopFloorCard:nMonth];
} // int PopFloorCard(int nMonth).
// 바닥 카드 획득
- (int) PopFloorCard:(int) nMonth  byOffset:(Byte)byOffset
{
    return [m_Floor PopFloorCard:nMonth  byOffset:byOffset];
} // int PopFloorCard(int nMonth, BYTE byOffset).

// 상태 리턴
- (int) GetState
{
    return m_nGameState;
} // int GetState(void).
// 턴 설정
- (void) SetTurn:(int) nPlayer
{
    m_nTurn = nPlayer;
} // void SetTurn(int nPlayer).
// 턴 리턴
- (int) GetTurn
{
    return m_nTurn;
} // int GetTurn(void).

//카드 타입 리턴
- (int) GetCardType:(int) nIdxCard
{
    return [m_Card GetCardType:nIdxCard];
} // int GetCardType(int nIdxCard).

// 해당  플레이어 점수 리턴
- (int) GetScore:(int) nPlayer
{
    return m_nScore[nPlayer];
} // int GetScore(int nPlayer).
// 해당 플레이어의 규칙 횟수 리턴
- (int) GetRuleCount:(int) nPlayer nRuleType:(int) nRuleType
{
    return m_nCntRule[nPlayer][nRuleType];
} // int GetRuleCount(int nPlayer, int nRuleType).

// 센터 카드 갯수 리턴
- (int) GetCenterCardCount
{
    return [m_Floor GetCenterCardCount];
} // int GetCenterCardCount(void).

// 바닥 카드 갯수 리턴
- (int) GetFloorCardCount:(int) nMonth
{
    return [m_Floor GetFloorCardCount:nMonth];
} // int GetFloorCardCount(int nMonth).

// 바닥 카드 리턴
- (int) GetFloorCard:(int)nMonth boffset:(Byte)boffset
{
	return [m_Floor GetFloorCard:nMonth byOffset:boffset];
}
// 플레이어 카드 갯수
- (int) GetPlayerCardCount
{
    return [m_Card GetPlayerCardCount:[self GetTurn]];
} // int GetPlayerCardCount(void).
// 플레이어 카드 갯수
- (int) GetPlayerCardCount:(int) nPlayer
{
    return [m_Card GetPlayerCardCount:nPlayer];
} // int GetPlayerCardCount(int nPlayer).
// 플레이어 카드 리턴
- (int) GetPlayerCard:(int) nOffset
{
    return [m_Card GetPlayerCard:[self GetTurn] nOffset:nOffset];
} // int GetPlayerCard(int nOffset).
// 플레이어 카드 리턴
- (int) GetPlayerCard:(int) nPlayer nOffset:(int) nOffset
{
    return [m_Card GetPlayerCard:nPlayer  nOffset:nOffset];
} // int GetPlayerCard(int nPlayer, int nOffset).

// 먹은 카드 갯수 리턴
- (int) GetObtainedCardCount:(int) nPlayer nCardType:(int) nCardType
{
    return [m_Card GetObtainedCardCount:nPlayer nCardType:nCardType];
} // int GetObtainedCardCount(int nPlayer, int nCardType).
// 획득 카드  리턴
- (int) GetObtainedCard:(int) nPlayer nCardType:(int) nCardType nOffset:(int) nOffset
{
    return [m_Card GetObtainedCard:nPlayer nCardType:nCardType nOffset:nOffset];
} // int GetObtainedCard(int nPlayer, int nCardType, int nOffset).

- (void) SetDefaultCoordination
{
	m_coFloorCards[0] = CGPointMake( 215+(CARD_WIDTH/2) , 268 );
	
	m_coFloorCards[1] = CGPointMake( 141+(CARD_WIDTH/2) , 336 );
	m_coFloorCards[2] = CGPointMake( 178+(CARD_WIDTH/2) , 336 );
	m_coFloorCards[3] = CGPointMake( 215+(CARD_WIDTH/2) , 336 );
	m_coFloorCards[4] = CGPointMake( 246+(CARD_WIDTH/2) , 336 );
	m_coFloorCards[5] = CGPointMake( 277+(CARD_WIDTH/2) , 336 );
	m_coFloorCards[6] = CGPointMake( 141+(CARD_WIDTH/2) , 268 );
	m_coFloorCards[7] = CGPointMake( 277+(CARD_WIDTH/2) , 268 );
	m_coFloorCards[8] = CGPointMake( 141+(CARD_WIDTH/2) , 186 );
	m_coFloorCards[9] = CGPointMake( 178+(CARD_WIDTH/2) , 186 );
	m_coFloorCards[10] = CGPointMake( 215+(CARD_WIDTH/2) , 186 );
	m_coFloorCards[11] = CGPointMake( 246+(CARD_WIDTH/2) , 186 );
	m_coFloorCards[12] = CGPointMake( 277+(CARD_WIDTH/2) , 186 );
	
	m_coPlayerCards[PLAYER][0] = CGPointMake( 135+(CARD_WIDTH/2) , 112 );
	m_coPlayerCards[PLAYER][1] = CGPointMake( 172+(CARD_WIDTH/2) , 112 );
	m_coPlayerCards[PLAYER][2] = CGPointMake( 209+(CARD_WIDTH/2) , 112 );
	m_coPlayerCards[PLAYER][3] = CGPointMake( 246+(CARD_WIDTH/2) , 112 );
	m_coPlayerCards[PLAYER][4] = CGPointMake( 283+(CARD_WIDTH/2) , 112 );
	m_coPlayerCards[PLAYER][5] = CGPointMake( 135+(CARD_WIDTH/2) , 56 );
	m_coPlayerCards[PLAYER][6] = CGPointMake( 172+(CARD_WIDTH/2) , 56 );
	m_coPlayerCards[PLAYER][7] = CGPointMake( 209+(CARD_WIDTH/2) , 56 );
	m_coPlayerCards[PLAYER][8] = CGPointMake( 246+(CARD_WIDTH/2) , 56 );
	m_coPlayerCards[PLAYER][9] = CGPointMake( 283+(CARD_WIDTH/2) , 56 );
	
	for(int i = 0 ; i < 10 ; i++)
	{
		m_coPlayerCards[OPPONENT][i] = CGPointMake (m_coPlayerCards[PLAYER][i].x , m_coPlayerCards[PLAYER][i].y + 336);
	}
	m_coObtainedCards[PLAYER][KWANG] = CGPointMake ( 0+(CARD_WIDTH/2) , 225 );
	m_coObtainedCards[PLAYER][YEOL] = CGPointMake ( 0+(CARD_WIDTH/2) , 187.5 );
	m_coObtainedCards[PLAYER][TEE] = CGPointMake ( 0+(CARD_WIDTH/2) , 150 );
	m_coObtainedCards[PLAYER][PEE] = CGPointMake ( 0+(CARD_WIDTH/2) , 112.5 );
	
	for(int j =0; j < CARDTYPE_COUNT; j++)
	{
		m_coObtainedCards[OPPONENT][j] = CGPointMake ( 0+(CARD_WIDTH/2) , m_coObtainedCards[PLAYER][j].y + 179);
		
	}
	
	
}
- (void) SetDisplayCoordination
{
	m_coScore[PLAYER] = CGPointMake( 178 +(CARD_WIDTH/2) , 121 );
	m_coScore[OPPONENT] = CGPointMake ( 178+(CARD_WIDTH/2) , 335 );
	m_coRule[PLAYER][GO] = CGPointMake ( 215+(CARD_WIDTH/2) , 121 );
	m_coRule[OPPONENT][GO] = CGPointMake ( 215+(CARD_WIDTH/2) , 335 );
	m_coRule[PLAYER][SHAKE] = CGPointMake ( 246+(CARD_WIDTH/2) , 121 );
	m_coRule[OPPONENT][SHAKE] = CGPointMake ( 246+(CARD_WIDTH/2) , 335 );
	m_coRule[PLAYER][PPUCK] = CGPointMake ( 277+(CARD_WIDTH/2) , 121 );
	m_coRule[OPPONENT][PPUCK] = CGPointMake (277+(CARD_WIDTH/2) , 335 );
}


- (CGPoint) Getm_coFloorCards:(int)index
{
	return m_coFloorCards[index];
}
- (CGPoint) Getm_coPlayerCards:(int)index1 index2:(int)index2
{
	return m_coPlayerCards[index1][index2];
}
- (CGPoint) Getm_coObtainedCards:(int)index1 index2:(int)index2
{
	return m_coObtainedCards[index1][index2];
}
- (CGPoint) Getm_coScore:(int)index1
{
	return m_coScore[index1];
}
- (CGPoint) Getm_coRule:(int)index1 index2:(int)index2
{
	return m_coRule[index1][index2];
}

@end