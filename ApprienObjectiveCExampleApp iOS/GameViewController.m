//
//  GameViewController.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 18.3.2021.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "LivingThing.h"
#import "IAPPlayer.h"
#import "GameManager.h"
//#import <Apprien.h>
#import <string.h>
@implementation GameViewController
GameScene *scene;

NSObject <LivingThing> *player;

int currentLevel = 0;
GameManager *gameManager;

- (void)viewDidLoad {
    if(gameManager == nil){
        gameManager = [[GameManager alloc]init];
    }

    scene = (GameScene *)[gameManager loadGameScene];
    [scene SetGameManager:gameManager];
    // Present the scene
    SKView *skView = (SKView *) self.view;
    [skView presentScene:scene];
    [gameManager setUpTitleScreen:scene];
    skView.ignoresSiblingOrder = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    [gameManager setView:skView];
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    for (UITouch *t in touches) {

    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {

    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    for (UITouch *touch in touches) {
        if (currentLevel == 0) {
            [gameManager cleanUpScene: scene];
            [gameManager setUpScene:1 scene:scene viewSize: self.view.bounds.size];
            // Present the scene
            SKView *skView = (SKView *) self.view;
            [skView presentScene:scene];
            currentLevel = 1;
        }
        
        UITouch *touch2 = touches.anyObject;
   
        CGPoint positionInScene = [touch locationInNode: scene];
        SKNode *touchedNode = [scene nodeAtPoint: positionInScene];

           if (touchedNode.name)
           {
               [gameManager updatePlayer:touchedNode.name];
           }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {

    }
}

#endif

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
