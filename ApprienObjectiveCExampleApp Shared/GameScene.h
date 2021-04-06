//
//  GameScene.h
//  ApprienObjectiveCExampleApp Shared
//
//  Created by phz on 18.3.2021.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene
@property(nonatomic, assign, getter = getLevelIndex, setter = setLevelIndex:) int levelIndex;
+(GameScene *)newGameScene;
+ (GameScene *)loadGameScene: (NSString *) sceneName;
+ (GameScene *)loadGameSceneByIndex: (int) sceneIndex;
- (void)setUpScene;
+ (void)setUpScene2: (int) index scene:(GameScene *) scene;
@end
