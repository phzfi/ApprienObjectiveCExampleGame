//
//  GameScene.h
//  ApprienObjectiveCExampleApp Shared
//
//  Created by phz on 18.3.2021.
//

#import <SpriteKit/SpriteKit.h>
#import "GameManager.h"
@interface GameScene : SKScene
+ (GameScene *)newGameScene;
+ (GameScene *)loadGameScene: (NSString *) sceneName;
- (void)SetGameManager: (GameManager*)gameManager;
@end
