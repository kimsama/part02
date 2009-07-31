//
//  cocos2d_appAppDelegate.h
//  cocos2d app
//
//  Created by 주세영 on 09. 07. 12.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//


#import "cocos2d.h"
#import "GostopAgent.h"
#import <UIKit/UIKit.h>




@class Sprite;
@class CGostopAgent;

//CLASS INTERFACE
@interface cocos2d_appAppDelegate : NSObject <UIAccelerometerDelegate, UIAlertViewDelegate, UITextFieldDelegate, UIApplicationDelegate>
{
	UIWindow	*window;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@end

@interface SpriteDemo : Layer
{
	Sprite * grossini;
	Sprite *tamara;
}
-(void) centerSprites;
-(NSString*) title;

-(void) backCallback:(id) sender;
-(void) nextCallback:(id) sender;
-(void) restartCallback:(id) sender;
@end


@interface MainGame : Layer
{
	CGostopAgent *m_Agent;
//	CGPoint m_coFloorCards[13];
//	CGPoint m_coPlayerCards[2][10];
//	CGPoint m_coObtainedCards[2][CARDTYPE_COUNT];
//	CGPoint m_coScore[2];
//	CGPoint m_coRule[2][RULE_COUNT];
	
	//TextureAtlas *texCard;
	AtlasSprite *m_sprBack[10];
	AtlasSprite *m_sprCard[GAME_TOTAL_CARD];
	AtlasSprite *m_sprOppCardBack[DISTRIBUTE_PLAYER_CARDS];
	AtlasSprite *m_sprBombCard;
	
	
}

//- (void) Update:(NSTimer*)timer;
- (void) LoadSprites;
- (void) UnloadSprites;
//- (void) SetDefaultCoordination;
//- (void) SetDisplayCoordination;
- (void) DrawCenterCards;
- (void) DrawFloorCards;
- (void) DrawObtainedCards;
- (void) DrawPlayerCards;
- (void) DisplayGameProgress;

@end
