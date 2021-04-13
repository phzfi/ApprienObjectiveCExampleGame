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
- (void)setUpScene;
@end
