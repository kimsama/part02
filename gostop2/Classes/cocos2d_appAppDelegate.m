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
	
	AtlasSpriteManager *mgr = [AtlasSpriteManager spriteManagerWithFile:@"editcard.png" ];	
	[self addChild:mgr z:0 tag:kTagSpriteManager ];
	
	[self LoadSprites];
	
	m_Agent = [CGostopAgent alloc];
	[m_Agent InitGame];
	[m_Agent SetDefaultCoordination];
	[m_Agent SetDisplayCoordination];
	[m_Agent StartNewGame];
	

	
	return self;
}
- (void) dealloc
{
	[self UnloadSprites];
	[super dealloc];
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
				if(location.x > [m_Agent Getm_coPlayerCards:whoturn index2:i].x && location.x < [m_Agent Getm_coPlayerCards:whoturn index2:i].x + CARD_WIDTH)
				{
					if(location.y < [m_Agent Getm_coPlayerCards:whoturn index2:i].y && location.y > [m_Agent Getm_coPlayerCards:whoturn index2:i].y - CARD_HEIGHT)
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
//	if(GS_PLAYING == [m_Agent GetState])
	{
		
		//카드 그리고
		[self DrawFloorCards];
		[self DrawObtainedCards];
		[self DrawPlayerCards];
		//게임 상황 그리고
		[self DisplayGameProgress];
	}
	
//	AtlasSpriteManager *mgr = (AtlasSpriteManager*)[self getChildByTag:kTagSpriteManager];
//	[mgr draw];
	
//	glDisable(GL_TEXTURE_2D);
//	glDisableClientState(GL_VERTEX_ARRAY);
//	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
}
- (void) LoadSprites
{
	AtlasSpriteManager *mgr = (AtlasSpriteManager*)[self getChildByTag:kTagSpriteManager];

	int cnt;
	float x = 0.0f; 
	float y = 0.0f;
	for( cnt = 0; cnt < GAME_TOTAL_CARD; cnt++)
	{
		
		x =(cnt%10)*CARD_WIDTH;
		y =((cnt)/10)*CARD_HEIGHT;
		
		m_sprCard[cnt] = [AtlasSprite spriteWithRect:CGRectMake(x,y,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
		[mgr setPosition:CGPointMake( 0, 0 )];
		[mgr addChild:m_sprCard[cnt] z:0 tag:cnt];
		
	}
	x =(50%10)*CARD_WIDTH;
	y =((50)/10)*CARD_HEIGHT;
	
	m_sprBombCard = [AtlasSprite spriteWithRect:CGRectMake(x,y,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
	[mgr setPosition:CGPointMake( 0, 0 )];
	[mgr addChild:m_sprBombCard z:0 tag:50];
	
	x =(51%10)*CARD_WIDTH;
	y =((51)/10)*CARD_HEIGHT;
	
//	m_sprOppCardBack = [AtlasSprite spriteWithRect:CGRectMake(x,y,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
//	[mgr setPosition:CGPointMake( 0, 0 )];
//	[mgr addChild:m_sprOppCardBack z:0 tag:51];
	
	for(cnt = 0  ; cnt < DISTRIBUTE_PLAYER_CARDS ; cnt++)
	{
		m_sprBack[cnt] = [AtlasSprite spriteWithRect:CGRectMake(x, y, CARD_WIDTH, CARD_HEIGHT) spriteManager:mgr];
		[mgr setPosition:CGPointMake(0,0)];
		[mgr addChild:m_sprBack[cnt] z:0 tag:51+cnt];
		
		m_sprOppCardBack[cnt] = [AtlasSprite spriteWithRect:CGRectMake(x, y, CARD_WIDTH, CARD_HEIGHT) spriteManager:mgr];
		[mgr setPosition:CGPointMake(0,0)];
		[mgr addChild:m_sprOppCardBack[cnt] z:0 tag:61+cnt];
	}
	
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
	
	[self addChild: pslabel z:0 tag:0];
	[pslabel setPosition: ccp([m_Agent Getm_coScore:PLAYER].x, [m_Agent Getm_coScore:PLAYER].y)];
	[self addChild: oslabel z:0 tag:1];
	[oslabel setPosition: ccp([m_Agent Getm_coScore:OPPONENT].x, [m_Agent Getm_coScore:OPPONENT].y)];
	
	[self addChild: pglabel z:0 tag:2];
	[pglabel setPosition: ccp([m_Agent Getm_coRule:PLAYER index2:GO].x, [m_Agent Getm_coRule:PLAYER index2:GO].y)];
	[self addChild: oglabel z:0 tag:3];
	[oglabel setPosition: ccp([m_Agent Getm_coRule:OPPONENT index2:GO].x,[m_Agent Getm_coRule:OPPONENT index2:GO].y)];
	
	[self addChild: pshlabel z:0 tag:4];
	[pshlabel setPosition: ccp([m_Agent Getm_coRule:PLAYER index2:SHAKE].x,[m_Agent Getm_coRule:PLAYER index2:SHAKE].y)];
	[self addChild: oshlabel z:0 tag:5];
	[oshlabel setPosition: ccp([m_Agent Getm_coRule:OPPONENT index2:SHAKE].x,[m_Agent Getm_coRule:OPPONENT index2:SHAKE].y)];
	
	[self addChild: pplabel z:0 tag:6];
	[pplabel setPosition: ccp([m_Agent Getm_coRule:PLAYER index2:PPUCK].x,[m_Agent Getm_coRule:PLAYER index2:PPUCK].y)];
	[self addChild: oplabel z:0 tag:7];
	[oplabel setPosition: ccp([m_Agent Getm_coRule:OPPONENT index2:PPUCK].x,[m_Agent Getm_coRule:OPPONENT index2:PPUCK].y)];
	
	
}
- (void) UnloadSprites
{
	[m_sprBombCard release];
	
//	[m_sprOppCardBack release];
	
	for(int i = 0 ; i < GAME_TOTAL_CARD; i++)
	{
		[m_sprCard[i] release];
	}
	
	for(int i = 0; i < DISTRIBUTE_PLAYER_CARDS; i++)
	{
		[m_sprOppCardBack[i] release];
		[m_sprBack[i] release];
	}
	
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
			AtlasSprite *OppCardBack = (AtlasSprite*)[mgr getChildByTag:51+iCnt];
			[OppCardBack setPosition:CGPointMake([m_Agent Getm_coFloorCards:0].x -iCnt,[m_Agent Getm_coFloorCards:0].y-iCnt)];
		}
	}
	else
	{
		for(iCnt = 0 ; iCnt <5+(nCntCenterCard)/6;iCnt++)
		{
			AtlasSprite *OppCardBack = (AtlasSprite*)[mgr getChildByTag:51+iCnt];
			[OppCardBack setPosition:CGPointMake([m_Agent Getm_coFloorCards:0].x -iCnt,[m_Agent Getm_coFloorCards:0].y-iCnt)];
					
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
				
				nidxCard = [m_Agent GetFloorCard:iMonth boffset:iCnt];
				if(0 > (nidxCard))
				{
					continue;
				}
				
				AtlasSprite* card =(AtlasSprite*)[mgr getChildByTag:nidxCard];
				[card setPosition:CGPointMake([m_Agent Getm_coFloorCards:(1+ iMonth)].x ,[m_Agent Getm_coFloorCards:(1+ iMonth)].y)];
				
				
			}

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
						nGapObtainedCard = 0;
					}else if( nCntObtainedCard > 2)
					{
						nGapObtainedCard -= -1;
					}
					break;
				case YEOL:
				case TEE:
					if(nCntObtainedCard >= 10)
					{
						nGapObtainedCard -= 0;
						
					}else if(nCntObtainedCard > 6)
					{
						nGapObtainedCard -= -3;
					}else if(nCntObtainedCard > 4)
					{
						nGapObtainedCard -= -2;
						
					}else if(nCntObtainedCard >2)
					{
						nGapObtainedCard -= -1;
					}
					break;
				case PEE:
					if(nCntObtainedCard >=10)
					{
						nGapObtainedCard = -22;
						
					}
					else if(nCntObtainedCard >=8)
					{
						nGapObtainedCard = -22;
					}else if(nCntObtainedCard >5)
					{
						nGapObtainedCard = -21;
					}
					break;
			}
			
			iCnt = -1;
			
			while(!( 0 > (nIdxObtainedCard = [m_Agent GetObtainedCard:iPlayer nCardType:iCardType nOffset:++iCnt])))
			{
				AtlasSprite* card =(AtlasSprite*)[mgr getChildByTag:nIdxObtainedCard];
				[card setScale:0.67];
				[card setPosition:CGPointMake([m_Agent Getm_coObtainedCards:iPlayer index2:iCardType].x + (CARD_WIDTH+nGapObtainedCard)*(iCnt%10) ,[m_Agent Getm_coObtainedCards:iPlayer index2:iCardType].y-(CARD_HEIGHT/2)*(iCnt/10) )];
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
		
		if(0 > (nIdxPlayerCard))
			break;
		
		//m_sprCard[nIdxPlayerCard].position = ccp ( m_coPlayerCards[PLAYER][iCnt].x , m_coPlayerCards[PLAYER][iCnt].y);
//		[m_sprCard[nIdxPlayerCard] setPosition:CGPointMake( m_coPlayerCards[PLAYER][iCnt].x , m_coPlayerCards[PLAYER][iCnt].y)];
		//[mgr addChild:m_sprCard[nIdxPlayerCard]];
		
		AtlasSprite* card =(AtlasSprite*)[mgr getChildByTag:nIdxPlayerCard];
		[card setPosition:CGPointMake([m_Agent Getm_coPlayerCards:PLAYER index2:iCnt].x ,[m_Agent Getm_coPlayerCards:PLAYER index2:iCnt].y )];
		
		
	}
//	while (! ISNOCARD(nIdxPlayerCard = [m_Agent GetPlayerCard:PLAYER nOffset:++iCnt]))
//	{
//		[m_sprCard[nIdxPlayerCard] setPosition:CGPointMake( m_coPlayerCards[PLAYER][iCnt].x , m_coPlayerCards[PLAYER][iCnt].y)];
//		[mgr addChild:m_sprCard[nIdxPlayerCard]];
		
		//[m_sprCard[nIdxPlayerCard] release];
//	}
	
	for(iCnt =0; iCnt< [m_Agent GetPlayerCardCount:OPPONENT]; iCnt++)
	{
		//AtlasSprite *OppCardBack = [AtlasSprite spriteWithRect:CGRectMake(18.5*BACK_CARD,0,CARD_WIDTH,CARD_HEIGHT) spriteManager:mgr];
		//[OppCardBack setPosition:CGPointMake(m_coPlayerCards[OPPONENT][iCnt].x , m_coPlayerCards[OPPONENT][iCnt].y)];
		//OppCardBack.position = ccp (m_coPlayerCards[OPPONENT][iCnt].x , m_coPlayerCards[OPPONENT][iCnt].y);
		//[mgr addChild:OppCardBack];
		
		AtlasSprite* card =(AtlasSprite*)[mgr getChildByTag:61+iCnt];
		[card setPosition:CGPointMake([m_Agent Getm_coPlayerCards:OPPONENT index2:iCnt].x ,[m_Agent Getm_coPlayerCards:OPPONENT index2:iCnt].y )];
	
		//[OppCardBack release];
	}
}
- (void) DisplayGameProgress
{
	
	
/*
	Label* pslabel = (Label*)[self getChildByTag:0];
	Label* oslabel = (Label*)[self getChildByTag:1];
	Label* pglabel = (Label*)[self getChildByTag:2];
	Label* oglabel = (Label*)[self getChildByTag:3];
	Label* pshlabel = (Label*)[self getChildByTag:4];
	Label* oshlabel = (Label*)[self getChildByTag:5];
	Label* pplabel = (Label*)[self getChildByTag:6];
	Label* oplabel = (Label*)[self getChildByTag:7];
*/	

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
	//window.backgroundColor = [UIColor greenColor];
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
