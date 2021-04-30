//
//  GameManager.h
//  ApprienObjectiveCExampleApp
//
//  Created by phz on 31.3.2021.
//

#ifndef GameManager_h
#define GameManager_h
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@class GameScene;
@class LivingThing;
@class GameViewController;

@interface GameManager : NSObject

- (SKScene *)loadGameScene;
- (void)setUpScene: (int) index scene:(SKScene *) scene viewSize:(CGSize) viewSize;
- (SKScene *)getScene;
- (void)setUpTitleScreen:(SKScene *)scene;
- (void)setView:(SKView *) skView;
- (void)updatePlayer:(CGPoint) touchLocation;
- (void)update;
- (void)cleanUpScene: (SKScene*) scene;
#endif 

@end

