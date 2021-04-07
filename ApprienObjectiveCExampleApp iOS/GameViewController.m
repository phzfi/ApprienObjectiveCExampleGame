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
@implementation GameViewController
GameScene *scene;

NSMutableArray<SKTexture*> *playerWalkSideWaysFrames;
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
        
        NSObject<LivingThing> *player =[self buildPlayer:scene];
        [player moveForward:1];
        // Present the scene
        SKView *skView = (SKView *)self.view;
        [skView presentScene:scene];
        [scene addChild: [player getDefaultSprite]];
        
    }
}

- (NSObject<LivingThing> *) buildPlayer:(GameScene *) sceneIn {
    NSObject<LivingThing> *livingThing = [[IAPPlayer alloc] init];
    
    SKTextureAtlas *playerAnimatedAtlas = [[SKTextureAtlas alloc] init];
    playerAnimatedAtlas = [SKTextureAtlas atlasNamed:@"Player_Walk_Sideways"];
    NSMutableArray<SKTexture*> *walkFrames = [[NSMutableArray<SKTexture*> alloc] init];

    int numImages = (int)playerAnimatedAtlas.textureNames.count;
    
    for (int i = 1; i<=numImages; i++) {
        NSString *playerTextureName = [@"Player_right_0" stringByAppendingString: @(i).stringValue ];
        [walkFrames addObject: [playerAnimatedAtlas textureNamed: playerTextureName]];
    }


    [livingThing setMoveSideWaysFrames:walkFrames];
  
    SKTexture *firstFrameTexture = walkFrames[0];
    SKSpriteNode *player = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];

    player.size = CGSizeMake(player.size.width*2, player.size.height*2);
    player.position = CGPointMake(20,20);
    [livingThing setDefaultSprite:player];

    return livingThing;
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
