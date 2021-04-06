//
//  GameViewController.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 18.3.2021.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController
GameScene *scene;

- (void)viewDidLoad {
    [super viewDidLoad];

    scene = [GameScene loadGameSceneByIndex: (int)_nextLevelToLoad];
    
    // Present the scene
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
    
    skView.ignoresSiblingOrder = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    _nextLevelToLoad ++;
}

- (BOOL)shouldAutorotate {
    return YES;
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    for (UITouch *t in touches) {
        //[scene setLevelIndex:1];
        scene = [GameScene loadGameSceneByIndex: (int)1];
        [GameScene setUpScene2:1 scene: scene];
        // Present the scene
        SKView *skView = (SKView *)self.view;
        [skView presentScene:scene];
        
    }
}

- (void) buildPlayer {
    SKTextureAtlas *playerAnimatedAtlas = [[SKTextureAtlas alloc] init];
    NSMutableArray<SKTexture*> *walkFrames = [[NSMutableArray<SKTexture*> alloc] init];

    int numImages = playerAnimatedAtlas.textureNames.count;
    for (int i = 0; i<numImages; i++) {
        NSString *playerTextureName = [@"Player_" stringByAppendingString: @(numImages).stringValue ];
        [walkFrames addObject: [playerAnimatedAtlas textureNamed: playerTextureName]];
    }

  bearWalkingFrames = walkFrames
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
 
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {

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
