//
//  GameManager.h
//  ApprienObjectiveCExampleApp
//
//  Created by phz on 31.3.2021.
//
/*!
 @abstract Main game manager class for the game.
 Class is meant to be the director for the game with responsibility to
 Controls the game flow, disassembly and setup.
 @discussion GameView controller in IOS folder handles IOS based controls
 and these control player actions. Each folder has their own platform, but currently only IOS is supported.
 Players and shop keepers extend living thing wich is a protocol(a.ka interface) to acces these elements.
*/

#ifndef GameManager_h
#define GameManager_h
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

//Forward declarations needed to prevent circular references.
@class GameScene;
@class LivingThing;
@class GameViewController;

@interface GameManager : NSObject

- (SKScene *)loadGameScene;

- (void)setUpScene: (int) index scene:(SKScene *) scene viewSize:(CGSize) viewSize;

- (SKScene *)getScene;

/*!
 @abstract Builds up the splash screen for the player when she/he starts the game.
 @param scene Scene to have the splash screen.
*/
- (void)setUpTitleScreen:(SKScene *)scene;

/*!
 @abstract Set the SKView object so it can be referenced inside the manager. This is usefull in case you need to access the currently presented scene
 @param skView  Spreitekits view object
*/
- (void)setView:(SKView *) skView;
- (void)updatePlayer:(NSString *) clickedButtonName;

/*!
 @abstract Updates game spevific elemets such as players and shop keepers
 @discussion Does not update input. Input updating is handled by GameViewController
*/
- (void)update;

/*!
 @abstract Cleans up all the created elements from the giveng scene. Removes children nodes. If the scene is presented the expected result is black screen.
 @discussion Used before scene loading in case same scene is reused.
 @param scene SKScene object to be cleared
*/
- (void)cleanUpScene: (SKScene*) scene;
#endif 

@end

