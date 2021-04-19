//
//  GameManager.h
//  ApprienObjectiveCExampleApp
//
//  Created by phz on 31.3.2021.
//

#ifndef GameManager_h
#define GameManager_h
#import "GameScene.h"
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
@interface GameManager : NSObject

- (SKScene *)loadGameScene;
- (void)setUpScene: (int) index scene:(SKScene *) scene viewSize:(CGSize) viewSize;
- (void)setUpTitleScreen:(SKScene *)scene;
- (void)setView:(SKView *) skView;
- (void)updatePlayerPosition:(CGPoint) touchLocation;
- (void)update;
- (void)cleanUpScene: (SKScene*) scene;
#endif 

@end

