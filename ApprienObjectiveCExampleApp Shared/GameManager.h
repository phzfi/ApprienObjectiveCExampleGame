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


- (GameScene *)loadGameSceneByIndex: (int) sceneIndex;
- (void)setUpScene2: (int) index scene:(GameScene *) scene viewSize:(CGSize) viewSize;
-(void)setView:(SKView *) skView;
-(void)update:(CGPoint) locationInView;
#endif /* GameManager_h */

@end

