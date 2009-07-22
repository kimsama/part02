//
//  cocos2d_appAppDelegate.m
//  cocos2d app
//
//  Created by 주세영 on 09. 07. 12.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

// local import
#import "cocos2d.h"
#import "cocos2d_appAppDelegate.h"

enum {
	kTagAnimationDance = 1,
	kTagSpriteManager = 1,
	KtagTileMap = 1,
};

enum {
	kTagSprite1,
	kTagSprite2,
	kTagSprite3,
	
};

static int sceneIdx=-1;
static NSString *transitions[] = {
@"MainGame",
 };

Class nextAction()
{
	
	sceneIdx++;
	sceneIdx = sceneIdx % ( sizeof(transitions) / sizeof(transitions[0]) );
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}

Class backAction()
{
	sceneIdx--;
	if( sceneIdx < 0 )
		sceneIdx = sizeof(transitions) / sizeof(transitions[0]) -1;	
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}

Class restartAction()
{
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}





@implementation SpriteDemo
-(id) init
{
	[super init];
	
	// Example:
	// You can create a sprite using a Texture2D
	Texture2D *tex = [ [Texture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"1_1.jpg" ofType:nil] ] ];
	grossini = [[Sprite spriteWithTexture:tex] retain];
	[tex release];
	
	
	// Example:
	// Or you can create an sprite using a filename. PNG, JPEG and BMP files are supported. Probably TIFF too
	tamara = [[Sprite spriteWithFile:@"2_2.jpg"] retain];
	
	[self addChild: grossini z:1];
	[self addChild: tamara z:2];
	
	CGSize s = [[Director sharedDirector] winSize];
	
	[grossini setPosition: ccp(60, s.height/3)];
	[tamara setPosition: ccp(60, 2*s.height/3)];
	
	Label* label = [Label labelWithString:[self title] fontName:@"Arial" fontSize:20];
	[self addChild: label];
	[label setPosition: ccp(s.width/2, s.height-50)];
/*	
	MenuItemImage *item1 = [MenuItemImage itemFromNormalImage:@"b1.png" selectedImage:@"b2.png" target:self selector:@selector(backCallback:)];
	MenuItemImage *item2 = [MenuItemImage itemFromNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(restartCallback:)];
	MenuItemImage *item3 = [MenuItemImage itemFromNormalImage:@"f1.png" selectedImage:@"f2.png" target:self selector:@selector(nextCallback:)];
	
	Menu *menu = [Menu menuWithItems:item1, item2, item3, nil];
	menu.position = CGPointZero;
	item1.position = ccp(480/2-100,30);
	item2.position = ccp(480/2, 30);
	item3.position = ccp(480/2+100,30);
	[self addChild: menu z:1];
*/	
	return self;
}

-(void) dealloc
{
	[grossini release];
	[tamara release];
	[super dealloc];
}


-(void) restartCallback: (id) sender
{
	Scene *s = [Scene node];
	[s addChild: [restartAction() node]];
	[[Director sharedDirector] replaceScene: s];
}

-(void) nextCallback: (id) sender
{
	Scene *s = [Scene node];
	[s addChild: [nextAction() node]];
	[[Director sharedDirector] replaceScene: s];
}

-(void) backCallback: (id) sender
{
	Scene *s = [Scene node];
	[s addChild: [backAction() node]];
	[[Director sharedDirector] replaceScene: s];
}


-(void) centerSprites
{
	CGSize s = [[Director sharedDirector] winSize];
	
	[grossini setPosition: ccp(s.width/3, s.height/2)];
	[tamara setPosition: ccp(2*s.width/3, s.height/2)];
}
-(NSString*) title
{
	return @"No title";
}
@end

@implementation MainGame

- (id) init
{
	if(![super init])
		return nil;
	
	isTouchEnabled = YES;
	
	AtlasSpriteManager *mgr = [AtlasSpriteManager spriteManagerWithFile:@"Card.png" ];	
	[self addChild:mgr z:0 tag:kTagSpriteManager ];
	
	[self LoadSprites];
	[self SetDefaultCoordination];
	[self SetDisplayCoordination];
	
	m_Agent = [CGostopAgent alloc];
	[m_Agent InitGame];
	[m_Agent StartNewGame];
//	[m_Agent StartTimerfunc];
	
	
//	[NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(Update) userInfo:nil repeats:YES];
	
	return self;
}
- (void) dealloc
{
	[self UnloadSprites];
	[super dealloc];
}
- (void) Update:(NSTimer*)timer
{
	[self DrawFloorCards];
	[self DrawObtainedCards];
	[self DrawPlayerCards];
	[self DisplayGameProgress];
}

-(void) onEnter
{
	[super onEnter];
	
}

- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[Director sharedDirector] convertCoordinate: location];
		if(GS_PLAYING == [m_Agent GetState])
		{
			for(int  i =0; i < [m_Agent GetPlayerCardCount];i++ )
			{
				int whoturn = [m_Agent GetTurn];
				if(location.x > m_coPlayerCards[whoturn][i].x && location.x < m_coPlayerCards[whoturn][i].x + CARD_WIDTH)
				{
					if(location.y > m_coPlayerCards[whoturn][i].y && location.y < m_coPlayerCards[whoturn][i].y + CARD_HEIGHT)
					{
						[m_Agent PutOutPlayerCard:i];
						break;
					}
				}
			}
		}
		
	}
	return kEventHandled;
}

- (void) draw
{
	[m_Agent DoAgency:nil];
	
//	glEnableClientState(GL_VERTEX_ARRAY);
//	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
//	glEnable( GL_TEXTURE_2D);
	
	//배경 그리고
	
	//카드 그리고
	[self DrawFloorCards];
	[self DrawObtainedCards];
	[self DrawPlayerCards];
	//게임 상황 그리고
	[self DisplayGameProgress];
	
	
//	glDisable(GL_TEXTURE_2D);
	
//	glDisableClientState(GL_VERTEX_ARRAY);
//	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
}
- (void) LoadSprites
{
	AtlasSpriteManager *mgr = (AtlasSpriteManager*)[self getChildByTag:kTagSpriteManager];
//	test code
//	AtlasSprite *Card = [AtlasSprite spriteWithRect:CGRectMake(0.0f, 0.0f, CARD_WIDTH, CARD_HEIGHT) spriteManager:mgr];
//	Card.position = ccp (100,100);
//	[mgr addChild:Card];
	
	
	int cnt;
	float x = 0.0f; 
	float y = 0.0f;
	for( cnt = 0; cnt < GAME_TOTAL_CARD; cnt++)
	{
		m_sprCard[cnt] = [AtlasSprite spriteWithRect:CGRectMake(x,y,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
		//[mgr setPosition:CGPointMake( x, y )];
		//[mgr addChild:m_sprCard[cnt]];
		x += CARD_WIDTH;
	}
	m_sprBombCard = [AtlasSprite spriteWithRect:CGRectMake(x,y,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
	//[mgr setPosition:CGPointMake( x, y+ 56 )];
	//[mgr addChild:m_sprBombCard];
	x += CARD_WIDTH;
	m_sprOppCardBack = [AtlasSprite spriteWithRect:CGRectMake(x,y,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
	//[mgr setPosition:CGPointMake( x, y+ 112 )];
	//[mgr addChild:m_sprOppCardBack];
	
}
- (void) UnloadSprites
{
	[m_sprBombCard release];
	[m_sprOppCardBack release];
	
	for(int i = 0 ; i < GAME_TOTAL_CARD; i++)
	{
		[m_sprCard[i] release];
	}
	
}
- (void) SetDefaultCoordination
{
	m_coFloorCards[0] = ccp( 215, 268 );
	m_coFloorCards[5] = ccp( 277, 336 );
	m_coFloorCards[1] = ccp( 141, 336 );
	m_coFloorCards[6] = ccp( 141, 268 );
	m_coFloorCards[2] = ccp( 178, 336 );
	m_coFloorCards[3] = ccp( 215, 336 );
	m_coFloorCards[7] = ccp( 277, 268 );
	m_coFloorCards[4] = ccp( 246, 336 );
	m_coFloorCards[8] = ccp( 141, 186 );
	m_coFloorCards[9] = ccp( 178, 186 );
	m_coFloorCards[11] = ccp( 246, 186 );
	m_coFloorCards[12] = ccp( 277, 186 );
	m_coFloorCards[10] = ccp( 215, 186 );
	
	m_coPlayerCards[PLAYER][0] = ccp( 140, 112 );
	m_coPlayerCards[PLAYER][1] = ccp( 177, 112 );
	m_coPlayerCards[PLAYER][2] = ccp( 214, 112 );
	m_coPlayerCards[PLAYER][3] = ccp( 251, 112 );
	m_coPlayerCards[PLAYER][4] = ccp( 288, 112 );
	m_coPlayerCards[PLAYER][5] = ccp( 140, 56 );
	m_coPlayerCards[PLAYER][6] = ccp( 177, 56 );
	m_coPlayerCards[PLAYER][7] = ccp( 214, 56 );
	m_coPlayerCards[PLAYER][8] = ccp( 251, 56 );
	m_coPlayerCards[PLAYER][9] = ccp( 288, 56 );
	
	for(int i = 0 ; i < 10 ; i++)
	{
		m_coPlayerCards[OPPONENT][i] = ccp (m_coPlayerCards[PLAYER][i].x , m_coPlayerCards[PLAYER][i].y + 339);
	}
	m_coObtainedCards[PLAYER][KWANG] = ccp ( 0, 225 );
	m_coObtainedCards[PLAYER][YEOL] = ccp ( 0, 187.5 );
	m_coObtainedCards[PLAYER][TEE] = ccp ( 0, 150 );
	m_coObtainedCards[PLAYER][PEE] = ccp ( 0, 112.5 );
	
	for(int j =0; j < CARDTYPE_COUNT; j++)
	{
		m_coObtainedCards[OPPONENT][j] = ccp ( 0, m_coObtainedCards[PLAYER][j].y + 235);
		
	}
		

}
- (void) SetDisplayCoordination
{
	m_coScore[PLAYER] = ccp( 178 , 121 );
	m_coScore[OPPONENT] = ccp ( 178, 335 );
	m_coRule[PLAYER][GO] = ccp ( 215, 121 );
	m_coRule[OPPONENT][GO] = ccp ( 215, 335 );
	m_coRule[PLAYER][SHAKE] = ccp ( 246, 121 );
	m_coRule[OPPONENT][SHAKE] = ccp ( 246, 335 );
	m_coRule[PLAYER][PPUCK] = ccp ( 277, 121 );
	m_coRule[OPPONENT][PPUCK] = ccp (277, 335 );
}
//중앙 카드 그려줌
- (void) DrawCenterCards
{
	int iCnt;
	int nCntCenterCard;
	AtlasSpriteManager *mgr = (AtlasSpriteManager*)[self getChildByTag:kTagSpriteManager];
	
	nCntCenterCard = [m_Agent GetCenterCardCount];
	
	if(nCntCenterCard <= 5)
	{
		for(iCnt = 0; iCnt < nCntCenterCard; iCnt++)
		{
			AtlasSprite *OppCardBack = [AtlasSprite spriteWithRect:CGRectMake(CARD_WIDTH*BACK_CARD,0,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
			[OppCardBack setPosition:CGPointMake(m_coFloorCards[0].x -iCnt, m_coFloorCards[0].y-iCnt)];
			[mgr addChild:OppCardBack z:0];
			//OppCardBack.position = ccp (m_coFloorCards[0].x -iCnt, m_coFloorCards[0].y-iCnt);
			//[OppCardBack release];
		}
	}
	else
	{
		for(iCnt = 0 ; iCnt <5+(nCntCenterCard-5)/6;iCnt++)
		{
			AtlasSprite *OppCardBack = [AtlasSprite spriteWithRect:CGRectMake( CARD_WIDTH*BACK_CARD , 0.0f, CARD_WIDTH, CARD_HEIGHT) spriteManager:mgr];
			[OppCardBack setPosition:CGPointMake(m_coFloorCards[0].x -iCnt, m_coFloorCards[0].y-iCnt)];
			[mgr addChild:OppCardBack z:0];
			//[mgr addChild:OppCardBack];
			//OppCardBack.position = ccp (m_coFloorCards[0].x -iCnt, m_coFloorCards[0].y-iCnt);	
			//[OppCardBack release];
			
		}
	}
	
	
}
- (void) DrawFloorCards
{
	int iCnt;
	int iMonth;
	int nidxCard;
	[self DrawCenterCards];
	AtlasSpriteManager *mgr = (AtlasSpriteManager*)[self getChildByTag:kTagSpriteManager];
	for(iMonth=0; iMonth <12; iMonth++)
	{
		if(0 < [m_Agent GetFloorCardCount:iMonth])
		{
			iCnt = -1;
			
			int count = [m_Agent GetFloorCardCount:iMonth];
			for(int i =0; i < count; i++)
			{
				++iCnt;
				//nidxCard = [m_Agent GetFloorCardInAgent:iMonth byteoffset:iCnt];
				nidxCard = [m_Agent GetFloorCard:iMonth boffset:iCnt];
				if(!ISNOCARD(nidxCard))
				{
					break;
				}
				[mgr addChild:m_sprCard[nidxCard]];
				[m_sprCard[nidxCard] setPosition:CGPointMake( m_coFloorCards[1+ iMonth].x , m_coFloorCards[1+ iMonth].y)];
				
			}
//			while(!ISNOCARD(nidxCard = ))
//			{
//				[mgr addChild:m_sprCard[nidxCard]];
//				[m_sprCard[nidxCard] setPosition:CGPointMake( m_coFloorCards[1+ iMonth].x , m_coFloorCards[1+ iMonth].y)];
//			}
		}
	}
	
}
- (void) DrawObtainedCards
{
	int iCnt;
	int iPlayer;
	int iCardType;
	int nCntObtainedCard;
	int nGapObtainedCard;
	int nIdxObtainedCard;
	AtlasSpriteManager *mgr = (AtlasSpriteManager*)[self getChildByTag:kTagSpriteManager];
	
	for(iPlayer=0; iPlayer<PLAYER_COUNT; iPlayer++)
	{
		for(iCardType=0; iCardType<CARDTYPE_COUNT; iCardType++)
		{
			nCntObtainedCard = [m_Agent GetObtainedCardCount:iPlayer nCardType:iCardType];
			nGapObtainedCard = OBTAINED_CARD_GAP;
			
			switch (iCardType)
			{
				case KWANG:
					if(nCntObtainedCard>=5)
					{
						nGapObtainedCard = -10;
					}else if( nCntObtainedCard > 2)
					{
						nGapObtainedCard -= (nCntObtainedCard-1)*6.5;
					}
					break;
				case YEOL:
				case TEE:
					if(nCntObtainedCard >= 10)
					{
						nGapObtainedCard -= 12;
						
					}else if(nCntObtainedCard > 6)
					{
						nGapObtainedCard -= (nCntObtainedCard-6)*2+16;
					}else if(nCntObtainedCard > 4)
					{
						nGapObtainedCard -= (nCntObtainedCard-3)*5;
						
					}else if(nCntObtainedCard >2)
					{
						nGapObtainedCard -= (nCntObtainedCard-2)*2;
					}
					break;
				case PEE:
					if(nCntObtainedCard >=10)
					{
						nGapObtainedCard -= 19;
						
					}
					else if(nCntObtainedCard >=8)
					{
						nGapObtainedCard -= (nCntObtainedCard -8)*2+15;
					}else if(nCntObtainedCard >5)
					{
						nGapObtainedCard -= (nCntObtainedCard -4)*4;
					}
					break;
			}
			
			iCnt = -1;
			
			while(! ISNOCARD(nIdxObtainedCard = [m_Agent GetObtainedCard:iPlayer nCardType:iCardType nOffset:++iCnt]))
			{
				[m_sprCard[nIdxObtainedCard] setPosition:CGPointMake(m_coObtainedCards[iPlayer][iCardType].x + (CARD_WIDTH+nGapObtainedCard)*(iCnt%10) , m_coObtainedCards[iPlayer][iCardType].y +(CARD_HEIGHT/2)*(iCnt/10))];
				//[m_sprCard[nIdxObtainedCard] setScale:0.67];
				//m_sprCard[nIdxObtainedCard].scale = 0.67;
				//m_sprCard[nIdxObtainedCard].position = ccp ( m_coObtainedCards[iPlayer][iCardType].x + (24.59+nGapObtainedCard)*(iCnt%10) , m_coObtainedCards[iPlayer][iCardType].y +(37.52/2)*(iCnt/10) );
				[mgr addChild:m_sprCard[nIdxObtainedCard]];
				
				//[m_sprCard[nIdxObtainedCard] release];
			}
			
		}
	}
}
- (void) DrawPlayerCards
{
	int iCnt;
	int nIdxPlayerCard;
	int nCntPlayerCardCount;
	AtlasSpriteManager *mgr = (AtlasSpriteManager*)[self getChildByTag:kTagSpriteManager];

	iCnt = -1;
	
	nCntPlayerCardCount = [m_Agent GetPlayerCardCount:PLAYER];
	for(int i = 0 ; i < nCntPlayerCardCount; i++)
	{
		++iCnt;
		
		nIdxPlayerCard = [m_Agent GetPlayerCard:PLAYER nOffset:iCnt];	
		
		if(ISNOCARD(nIdxPlayerCard))
			break;
		
		m_sprCard[nIdxPlayerCard].position = ccp ( m_coPlayerCards[PLAYER][iCnt].x , m_coPlayerCards[PLAYER][iCnt].y);
//		[m_sprCard[nIdxPlayerCard] setPosition:CGPointMake( m_coPlayerCards[PLAYER][iCnt].x , m_coPlayerCards[PLAYER][iCnt].y)];
		[mgr addChild:m_sprCard[nIdxPlayerCard]];
		
	}
//	while (! ISNOCARD(nIdxPlayerCard = [m_Agent GetPlayerCard:PLAYER nOffset:++iCnt]))
//	{
//		[m_sprCard[nIdxPlayerCard] setPosition:CGPointMake( m_coPlayerCards[PLAYER][iCnt].x , m_coPlayerCards[PLAYER][iCnt].y)];
//		[mgr addChild:m_sprCard[nIdxPlayerCard]];
		
		//[m_sprCard[nIdxPlayerCard] release];
//	}
	
	for(iCnt =0; iCnt< [m_Agent GetPlayerCardCount:OPPONENT]; iCnt++)
	{
		AtlasSprite *OppCardBack = [AtlasSprite spriteWithRect:CGRectMake(18.5*BACK_CARD,0,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
		[OppCardBack setPosition:CGPointMake(m_coPlayerCards[OPPONENT][iCnt].x , m_coPlayerCards[OPPONENT][iCnt].y)];
		//OppCardBack.position = ccp (m_coPlayerCards[OPPONENT][iCnt].x , m_coPlayerCards[OPPONENT][iCnt].y);
		[mgr addChild:OppCardBack];
	
		//[OppCardBack release];
	}
}
- (void) DisplayGameProgress
{
	NSString *pscore = [[NSString alloc] initWithFormat:@"%d",[m_Agent GetScore:PLAYER]];
	NSString *oscore = [[NSString alloc] initWithFormat:@"%d",[m_Agent GetScore:OPPONENT]];
	
	NSString *pgonotice = [[NSString alloc] initWithFormat:@"%d",[m_Agent GetRuleCount:PLAYER nRuleType:GO]];
	NSString *ogonotice = [[NSString alloc] initWithFormat:@"%d",[m_Agent GetRuleCount:OPPONENT nRuleType:GO]];
	
	NSString *pshakenotice = [[NSString alloc] initWithFormat:@"%d",[m_Agent GetRuleCount:PLAYER nRuleType:SHAKE]];
	NSString *oshakenotice = [[NSString alloc] initWithFormat:@"%d",[m_Agent GetRuleCount:OPPONENT nRuleType:SHAKE]];
	
	NSString *pppnotice = [[NSString alloc] initWithFormat:@"%d",[m_Agent GetRuleCount:PLAYER nRuleType:PPUCK]];
	NSString *oppnotice = [[NSString alloc] initWithFormat:@"%d",[m_Agent GetRuleCount:OPPONENT nRuleType:PPUCK]];
	
	Label* pslabel = [Label labelWithString:pscore fontName:@"Arial" fontSize:10];
	Label* oslabel = [Label labelWithString:oscore fontName:@"Arial" fontSize:10];
	Label* pglabel = [Label labelWithString:pgonotice fontName:@"Arial" fontSize:10];
	Label* oglabel = [Label labelWithString:ogonotice fontName:@"Arial" fontSize:10];
	Label* pshlabel = [Label labelWithString:pshakenotice fontName:@"Arial" fontSize:10];
	Label* oshlabel = [Label labelWithString:oshakenotice fontName:@"Arial" fontSize:10];
	Label* pplabel = [Label labelWithString:pppnotice fontName:@"Arial" fontSize:10];
	Label* oplabel = [Label labelWithString:oppnotice fontName:@"Arial" fontSize:10];
	
	[self addChild: pslabel];
	[pslabel setPosition: ccp(m_coScore[PLAYER].x, m_coScore[PLAYER].y)];
	[self addChild: oslabel];
	[oslabel setPosition: ccp(m_coScore[OPPONENT].x, m_coScore[OPPONENT].y)];
	
	[self addChild: pglabel];
	[pglabel setPosition: ccp(m_coRule[PLAYER][GO].x, m_coRule[PLAYER][GO].y)];
	[self addChild: oglabel];
	[oglabel setPosition: ccp(m_coRule[OPPONENT][GO].x, m_coRule[OPPONENT][GO].y)];
	
	[self addChild: pshlabel];
	[pshlabel setPosition: ccp(m_coRule[PLAYER][SHAKE].x, m_coRule[PLAYER][SHAKE].y)];
	[self addChild: oshlabel];
	[oshlabel setPosition: ccp(m_coRule[OPPONENT][SHAKE].x, m_coRule[OPPONENT][SHAKE].y)];
	
	[self addChild: pplabel];
	[pplabel setPosition: ccp(m_coRule[PLAYER][PPUCK].x, m_coRule[PLAYER][PPUCK].y)];
	[self addChild: oplabel];
	[oplabel setPosition: ccp(m_coRule[OPPONENT][PPUCK].x, m_coRule[OPPONENT][PPUCK].y)];
	
//	[pscore release];
//	[oscore release];
//	[pgonotice release];
//	[ogonotice release];
//	[pshakenotice release];
//	[oshakenotice release];
//	[pppnotice release];
//	[oppnotice release];
//	[pslabel release];
//	[oslabel release];
//	[pglabel release];
//	[oglabel release];
//	[pshlabel release];
//	[oshlabel release];
//	[pplabel release];
//	[oplabel release];
}


@end


// CLASS IMPLEMENTATIONS
//@implementation AppController

@implementation cocos2d_appAppDelegate

@synthesize window;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window setUserInteractionEnabled:YES];
	[window setMultipleTouchEnabled:YES];
	
	// must be called before any othe call to the director
	//	[Director useFastDirector];
	
	// Attach cocos2d to the window
	[[Director sharedDirector] attachInWindow:window];
	
	// 일단 종으로 보자..
	[[Director sharedDirector] setLandscape: NO];
	
	// display FPS (useful when debugging)
	[[Director sharedDirector] setDisplayFPS:YES];
	
	// frames per second
	[[Director sharedDirector] setAnimationInterval:1.0/60];
	
	// Make the window visible
	[window makeKeyAndVisible];
	
	Scene *scene = [Scene node];
	[scene addChild: [nextAction() node]];
	
	[[Director sharedDirector] runWithScene: scene];
	
}

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	[[Director sharedDirector] pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	[[Director sharedDirector] resume];
}

// purge memroy
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[TextureMgr sharedTextureMgr] removeAllTextures];
}

- (void) dealloc
{
	[window release];
	[super dealloc];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[Director sharedDirector] setNextDeltaTimeZero:YES];
}

@end
