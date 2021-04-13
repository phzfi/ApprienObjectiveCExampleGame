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
@implementation GameViewController
GameScene *scene;

NSObject <LivingThing> *player;
NSMutableArray<SKTexture *> *playerWalkSideWaysFrames;
int currentLevel = 0;
GameManager *gameManager;

- (void)viewDidLoad {
    if(gameManager == nil){
        gameManager = [[GameManager alloc]init];
    }
    [super viewDidLoad];
    scene = [gameManager loadGameSceneByIndex:(int) _nextLevelToLoad];

    // Present the scene
    SKView *skView = (SKView *) self.view;
    [skView presentScene:scene];

    skView.ignoresSiblingOrder = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    [gameManager setView:skView];
    _nextLevelToLoad++;
}

- (BOOL)shouldAutorotate {
    return YES;
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
            scene = [gameManager loadGameSceneByIndex:(int) 1];
            currentLevel = 1;
            [gameManager setUpScene2:1 scene:scene viewSize: self.view.bounds.size];

            // Present the scene
            SKView *skView = (SKView *) self.view;
            [skView presentScene:scene];
        }
        [gameManager update:[touch locationInView:self.view]];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {

    }
}

#endif

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
