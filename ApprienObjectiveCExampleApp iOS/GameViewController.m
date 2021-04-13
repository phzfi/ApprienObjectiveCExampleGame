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

NSObject <LivingThing> *player;
NSMutableArray<SKTexture *> *playerWalkSideWaysFrames;
int currentLevel = 0;

- (void)viewDidLoad {

    [super viewDidLoad];
    scene = [GameScene loadGameSceneByIndex:(int) _nextLevelToLoad];

    // Present the scene
    SKView *skView = (SKView *) self.view;
    [skView presentScene:scene];

    skView.ignoresSiblingOrder = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    _nextLevelToLoad++;
}

- (BOOL)shouldAutorotate {
    return YES;
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    for (UITouch *t in touches) {
        if (currentLevel == 0) {
            scene = [GameScene loadGameSceneByIndex:(int) 1];
            currentLevel = 1;
            [GameScene setUpScene2:1 scene:scene];

            // Present the scene
            SKView *skView = (SKView *) self.view;
            [skView presentScene:scene];
        }
        if (player == nil) {
            player = [self buildPlayer:scene];
            [scene addChild:[player getDefaultSprite]];
        }
    }
}

- (NSMutableArray<SKTexture *> *)BuildAnimationFrames:(SKTextureAtlas *)playerAnimatedAtlas endFix:(NSString *)endFix {

    NSMutableArray<SKTexture *> *walkFrames = [[NSMutableArray<SKTexture *> alloc] init];
    int numImages = (int) playerAnimatedAtlas.textureNames.count;

    for (int i = 1; i <= numImages; i++) {
        NSString *playerTextureName = [@"Player_" stringByAppendingString:endFix];
        playerTextureName = [playerTextureName stringByAppendingString:@(i).stringValue];
        [walkFrames addObject:[playerAnimatedAtlas textureNamed:playerTextureName]];
    }
    return walkFrames;
}

- (NSObject <LivingThing> *)buildPlayer:(GameScene *)sceneIn {
    NSObject <LivingThing> *livingThing = [[IAPPlayer alloc] init];

    [livingThing setMoveUpWaysFrames:[self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Up"] endFix:@"Up_0"]];

    [livingThing setMoveDownWaysFrames:[self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Down"] endFix:@"Down_0"]];

    NSMutableArray<SKTexture *> *walkFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Sideways"] endFix:@"right_0"];
    [livingThing setMoveSideWaysFrames:walkFrames];

    SKTexture *firstFrameTexture = walkFrames[0];
    SKSpriteNode *newPlayer = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];

    newPlayer.size = CGSizeMake(newPlayer.size.width * 3, newPlayer.size.height * 3);
    newPlayer.position = CGPointMake(20, 20);
    [livingThing setDefaultSprite:newPlayer];

    return livingThing;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {

    }
}

- (void)movePlayer:(simd_float4)direction speed:(CGFloat)speed {
    [player lookAt:direction];
    [player moveForward:speed];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGFloat selfHeight = self.view.bounds.size.height;
    CGFloat selfWidth = self.view.bounds.size.width;
    int middlePointX = selfWidth / 2;
    int middlePointY = selfHeight / 2;

    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:self.view];;

        float yFromCenter = location.y - middlePointY;
        float xFromCenter = location.x - middlePointX;
        [player.defaultSprite removeAllActions];

        [self HandlePlayerMovement:&location middlePointX:middlePointX middlePointY:middlePointY yFromCenter:yFromCenter xFromCenter:xFromCenter];
    }
}

- (void)HandlePlayerMovement:(const CGPoint *)location middlePointX:(int)middlePointX middlePointY:(int)middlePointY yFromCenter:(float)yFromCenter
                 xFromCenter:(float)xFromCenter
{
    //up
    if (fabs(yFromCenter) > fabs(xFromCenter) && yFromCenter > 0) {
        [self movePlayer:(simd_float4) {0, 1, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
        //down
    else if (fabs(yFromCenter) > fabs(xFromCenter) && yFromCenter < 0) {
        [self movePlayer:(simd_float4) {0, -1, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
        //left
    else if (fabs(xFromCenter) > fabs(yFromCenter) && xFromCenter < 0) {
        [self movePlayer:(simd_float4) {-1, 0, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
    else if (fabs(xFromCenter) > fabs(yFromCenter) && xFromCenter > 0) {
        [self movePlayer:(simd_float4) {1, 0, 0.0f, 0.0f} speed:(CGFloat) 1];
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
