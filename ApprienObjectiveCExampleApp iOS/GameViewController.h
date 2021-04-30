//
//  GameViewController.h
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 18.3.2021.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "LivingThing.h"
#import "IAPPlayer.h"
@class GameViewController;
@class GameScene;
@interface GameViewController : UIViewController
@property(nonatomic, assign, getter = getNextLevelToLoad) int nextLevelToLoad;
@end
