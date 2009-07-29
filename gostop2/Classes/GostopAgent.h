
#import "GostopCommon.h"
#import "GostopFloor.h"
#import "GostopCard.h"

@class CGostopCard;
@class CGostopFloor;
// 게임 상태 상수
enum EGameState
{
	GS_NULL,
	// 게임 시작
	GS_START_NEWGAME,
	// 바닥 카드 분배
	GS_DISTRIBUTE,
	// 일반 플레이 상태 상수
	GS_PLAYING,
	// 턴 변경.
	GS_CHANGETURN,
	// 바닥에 카드 냄
	GS_PUTOUT_PLAYERCARD,
	// 상태 갯수
	GS_COUNT
};
// 카드 분배 상태 상수
enum EDistributeCardState
{
	// 대기 상태
	DC_READY,
	// 첫번째 바닥 카드 분배.
	DC_FLOORCARDS_FIRST,
	// 두번째 바닥 카드 분배
	DC_FLOORCARDS_SECOND,
	// 플레이어 카드 분배
	DC_PLAYERCARDS_FIRST,
	// 상대방 카드 분배
	DC_OPPONENTCARDS_FIRST,
	// 플레이어 나머지 카드 분배
	DC_PLAYERCARDS_SECOND,
	// 상대방 나머지 카드 분배
	DC_OPPONENTCARDS_SECOND,
	// 사용자 카드 정렬
	DC_SORT_CARDS,
	// 바닥에서 보너스 카드를 빼냄
	DC_PICKUP_BONUSCARDS,
	// 총통 검사
	DC_CHECK_PRESIDENT,
	// 마무리
	DC_FINISH,
    // 상태갯수
	DC_COUNT
};

// 카드를 바닥에 내는 상태 상수.
enum EPutOutState
{
	// 낼카드를 고름
	PO_PICKUP,
	// 흔들수 있는지 체크
	PO_CHECKSHAKE,
	// 카드를 바닥에 냄
	PO_PUTOUT,
	// 뒤집음
	PO_TURNUP,
	// 벌칙 룰 적용 체크
	PO_CHECKRULE,
	// 턴 변경
	PO_CHANGETURN,
	// 상태 갯수
	PO_COUNT
};

enum EChangeTurnState
{
	// 피를 뺏어옴
	CT_ROBPEE,
	// 게임이 끝났는지 확인
	CT_CHECKENDOFGAME,
	// 턴 변경
	CT_CHANGETURN,
	// 상태 갯수
	CT_COUNT
};
//
@interface CGostopAgent : NSObject
{
	// 게임 상태
    int m_nGameState;
	// 에이젼시 상태 관리 스텝
    int m_nAgencyStep;
	// 게임 상태 변수
    int m_nGSParam1;
    int m_nGSParam2;
	// 바닥에 낼 플레이어 카드
    int m_nIdxPutOutCard;
	// 흔듦 여부
    int m_nShakingMode;
	// 바닥에 낼 슬롯
    int m_nAvailableFloorSlot;
	//바닥 카드 관리 클래스
	CGostopFloor *m_Floor;
	// 플레이어 카드 관리 클래스
	CGostopCard *m_Card;
	// 현재 턴
    int m_nTurn;
	// 턴 변경시 , 뺏어와야할 피 카운트
    int m_nCntRobPee;
	// 플레이어 점수 기억 변수
    int m_nScore[PLAYER_COUNT];
	// 게임 규칙 카운트 변수
    int m_nCntRule[PLAYER_COUNT][RULE_COUNT];
}
// 새 게임 시작
- (void) StartNewGame;
// 게임 초기화
- (void) InitGame;
// 게임 상태 변경
- (void) ChangeState:(int)nGameState;
// 게임 진행
- (void) DoAgency:(NSTimer*)Timer;
// 타이머 함수 실행
- (void) StartTimerfunc;
// 카드 분배
- (void) DealDistributeCards;
// 보너스 카드 픽업.
- (void) DealPickUpBonusCards;
// 총통 체크
- (BOOL) DealCheckPresident;
// 플레이어 카드를 바닥에 내는 것 처리
- (void) DealPutOutPlayerCards;
// 턴 변경
- (void) DealChangeTurn;

// 특정 이벤트 처리 함수
// 플레이어 보유  카드중 하나를 바닥에 낸다.
- (void) PutOutPlayerCard:(int)nOffsetPlayerCard;
// 바닥에 있는 카드 획득
- (void) ObtainFloorCard:(int)nMonth;
// 현재 턴 플레이어가 카드 획득
- (int) ObtainCard:(int)nIdxCard;
// 플레이어의 점수 계산
- (void) FigureOutScore;
// 카드 추출 함수
// 센터 카드 한장 추출
- (int) PopCenterCard;
// 해당 월의 맨 마지막 카드 획득
- (int) PopFloorCard:(int) nMonth;
// 바닥 카드 획득
- (int) PopFloorCard:(int) nMonth byOffset:(Byte) byOffset;
// 정보획득 함수
// 현재 상태 리턴
- (int) GetState;
// 현재 턴 설정
- (void) SetTurn:(int) nPlayer;
// 현재 턴 리턴
- (int) GetTurn;
// 카드 타입 리턴
- (int) GetCardType:(int) nIdxCard;
// 해당 플레이어 점수 리턴
- (int) GetScore:(int) nPlayer;
// 해당 플레이어의 규칙 횟수 리턴
- (int) GetRuleCount:(int) nPlayer nRuleType:(int) nRuleType;
// 센터 카드 갯수 리턴

- (int) GetCenterCardCount;
// 바닥 카드 갯수 리턴
- (int) GetFloorCardCount:(int) nMonth;

// 현재 플레이어 보유 카드 갯수 리턴
- (int) GetPlayerCardCount;
// 플레이어 보유 카드 갯수 리턴
- (int) GetPlayerCardCount:(int) nPlayer;
// 플레이어 보유 카드 리턴
- (int) GetPlayerCard:(int) nOffset;
- (int) GetPlayerCard:(int) nPlayer nOffset:(int) nOffset;
// 획득 카드 갯수 리턴
- (int) GetObtainedCardCount:(int) nPlayer nCardType:(int) nCardType;
// 획득 카드 리턴
- (int) GetObtainedCard:(int) nPlayer  nCardType:(int)nCardType nOffset:(int) nOffset;

// 바닥 카드 리턴
- (int) GetFloorCard:(int)nMonth boffset:(Byte)boffset;

@end