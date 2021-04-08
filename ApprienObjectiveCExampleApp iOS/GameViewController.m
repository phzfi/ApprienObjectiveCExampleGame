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
NSObject<LivingThing> *player;
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

        
        
        // Present the scene
        SKView *skView = (SKView *)self.view;
        [skView presentScene:scene];
        
        if(player == nil){
            
            player =[self buildPlayer:scene];
        }
      
        [scene addChild: [player getDefaultSprite]];
    }
}

- (NSMutableArray<SKTexture *> *)BuildAnimationFrames:(SKTextureAtlas *)playerAnimatedAtlas endFix: (NSString*) endFix {

    
    NSMutableArray<SKTexture*> *walkFrames = [[NSMutableArray<SKTexture*> alloc] init];
    
    int numImages = (int)playerAnimatedAtlas.textureNames.count;
    
    for (int i = 1; i<=numImages; i++) {
        NSString *playerTextureName = [@"Player_" stringByAppendingString: endFix ];
        playerTextureName = [playerTextureName stringByAppendingString: @(i).stringValue ];
        [walkFrames addObject: [playerAnimatedAtlas textureNamed: playerTextureName]];
    }
    return walkFrames;
}

- (NSObject<LivingThing> *) buildPlayer:(GameScene *) sceneIn {
    NSObject<LivingThing> *livingThing = [[IAPPlayer alloc] init];
    
    SKTextureAtlas *playerAnimatedAtlasUpWalk = [SKTextureAtlas atlasNamed:@"Player_Walk_Up"];
    NSMutableArray<SKTexture *> * walkFramesUp = [self BuildAnimationFrames:playerAnimatedAtlasUpWalk endFix:@"Up_0"];
    [livingThing setMoveUpWaysFrames:walkFramesUp];
    
    [livingThing setMoveDownWaysFrames:[self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Down"] endFix:@"Down_0"]];
    
    SKTextureAtlas *playerAnimatedAtlasSideWalk = [SKTextureAtlas atlasNamed:@"Player_Walk_Sideways"];
    NSMutableArray<SKTexture *> * walkFrames = [self BuildAnimationFrames:playerAnimatedAtlasSideWalk endFix:@"right_0"];
    [livingThing setMoveSideWaysFrames:walkFrames];
  
    SKTexture *firstFrameTexture = walkFrames[0];
    SKSpriteNode *newPlayer = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];

    newPlayer.size = CGSizeMake(newPlayer.size.width*3, newPlayer.size.height*3);
    newPlayer.position = CGPointMake(20,20);
    [livingThing setDefaultSprite:newPlayer];

    return livingThing;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
 
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGFloat selfHeight=self.view.bounds.size.height;
    CGFloat selfWidth=self.view.bounds.size.width;
    int middlePointX =selfWidth/2;
    int middlePointY =selfHeight/2;
    
    for (UITouch *touch in touches) {
      
        CGPoint location = [touch locationInView: self.view];;
        
        float moveSpeedMultiplierX;
        float moveSpeedMultiplierY;
        
        if (location.x < middlePointX) {
            moveSpeedMultiplierX = 1.0f;
        }
        if (location.x > middlePointX){
            moveSpeedMultiplierX = -1.0f;
        }
        if (location.y < middlePointY) {
            moveSpeedMultiplierY = 1.0f;
        }
        if (location.y > middlePointY){
            moveSpeedMultiplierY = -1.0f;
        }
        float yPivoted =location.y-middlePointY;
        //up
        if(fabs(yPivoted) >  fabs(location.x-middlePointX) && yPivoted > 0 ){
            [player lookAt:(simd_float4) { 0,     1,   0.0f,   0.0f }];
            [player moveForward: 1];
        }
        //down
        else if(fabs(yPivoted) > fabs(location.x-middlePointX) && yPivoted < 0 ){
            [player lookAt:(simd_float4) { 0,     -1,   0.0f,   0.0f }];
            [player moveForward: 1];
        }
        //left
        else if(fabs(location.x-middlePointX) > fabs(location.y-middlePointY)&& location.x-middlePointX < middlePointX ){
            [player lookAt:(simd_float4) { -1,     0,   0.0f,   0.0f }];
            [player moveForward: moveSpeedMultiplierX];
        
        }
        else if(fabs(location.x-middlePointX) > fabs(location.y-middlePointY)&& location.x-middlePointX > middlePointX ){
            [player lookAt:(simd_float4) { 1,     0,   0.0f,   0.0f }];
            [player moveForward: moveSpeedMultiplierX];
          
        }
        
        
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
