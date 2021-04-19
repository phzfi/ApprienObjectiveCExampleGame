//
//  GameManager.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 31.3.2021.
//
#import "GameScene.h"
#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "LivingThing.h"
#import "IAPPlayer.h"
#import <GameplayKit/GameplayKit.h>

@implementation GameManager {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    SKLabelNode *_labelContinue;
    NSObject <LivingThing> *player;
    SKView *view;
    NSMutableArray<SKSpriteNode *> *newCoin;
}

-(void)setView:(SKView *) skView{
    view = skView;

}

-(void)update{
    NSLog(@"7777");
}


- (GameScene *)loadGameScene{
    return  [GameScene newGameScene];
}

- (void)cleanUpScene: (SKScene*) scene
{
    [scene removeAllChildren];
    [scene removeAllActions];
}

- (void)setUpTitleScreen:(GameScene *) scene {
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[SKLabelNode labelNodeWithText:@"IAP man"];
    _label.fontName =@"Helvetica Neue UltraLight";
    _label.fontSize = 144;
    _label.alpha = 1;
    _label.position = CGPointMake(20, 100);
   // [_label runAction:[SKAction fadeInWithDuration:2.0]];
    [scene addChild: _label];
    _labelContinue = (SKLabelNode *)[SKLabelNode labelNodeWithText:@"Press to continue"];
    _labelContinue.fontName =@"Helvetica Neue UltraLight";
    _labelContinue.alpha = 1;
    _labelContinue.position = CGPointMake(20, 0);
    [scene addChild: _labelContinue];
   // [_labelContinue runAction:[SKAction fadeInWithDuration:2.0]];
    
    SKSpriteNode *player = [SKSpriteNode spriteNodeWithImageNamed:@"Player"];

    player.size = CGSizeMake(player.size.width*6, player.size.height*6);
    player.position = CGPointMake(20,20);
    [scene addChild: player];
}

- (void)setUpScene: (int) index scene:(GameScene *) scene viewSize:(CGSize) viewSize{
    SKTileSet *enviro = [SKTileSet tileSetNamed:@"Environment"];
    
    NSArray<SKTileGroup*> *levelTiles = enviro.tileGroups;
    CGSize tileSice;
    tileSice.width =128;
    tileSice.height = 128;
    SKTileMapNode *tileNode =[SKTileMapNode tileMapNodeWithTileSet:enviro columns:viewSize.width/128 rows:viewSize.height tileSize:tileSice fillWithTileGroup:levelTiles[0]];
    
    [scene addChild:tileNode];
    
    SKTileMapNode *tileNodeStones =[SKTileMapNode tileMapNodeWithTileSet:enviro columns:1 rows:viewSize.height tileSize:tileSice fillWithTileGroup:levelTiles[2]];
    
    [scene addChild:tileNodeStones];
    
    player = [self buildPlayer:scene];
    
    [scene addChild:[player getDefaultSprite]];
    [self generatePickableMoney:scene];
    
}

- (void)generatePickableMoney:(GameScene *)sceneIn {
    int coinSize = 64;
    NSArray<SKTexture*> *coinAnimFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Coin"] prefix: @"coin_0" endFix:@""];
    SKTexture *firstFrameTexture = coinAnimFrames[0];
    
    for(int i = 0; i < 10; i++){
        SKSpriteNode *newCoin = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];
        newCoin.size = CGSizeMake(coinSize, coinSize);
        newCoin.position = CGPointMake(0, 1 * -180 +180*i);
        SKAction *animAction = [SKAction repeatActionForever:
                [SKAction animateWithTextures:coinAnimFrames
                                 timePerFrame:0.1
                                       resize:false
                                      restore:true]];
        [newCoin runAction: animAction];
        [sceneIn addChild:newCoin];
    }
}

- (NSMutableArray<SKTexture *> *)BuildAnimationFrames:(SKTextureAtlas *)playerAnimatedAtlas prefix: (NSString *)preFix endFix:(NSString *)endFix {

    NSMutableArray<SKTexture *> *animFrames = [[NSMutableArray<SKTexture *> alloc] init];
    int numImages = (int) playerAnimatedAtlas.textureNames.count;

    for (int i = 1; i <= numImages; i++) {
        NSString *playerTextureName = [preFix stringByAppendingString:endFix];
        playerTextureName = [playerTextureName stringByAppendingString:@(i).stringValue];
        [animFrames addObject:[playerAnimatedAtlas textureNamed:playerTextureName]];
    }
    return animFrames;
}

- (NSObject <LivingThing> *)buildPlayer:(GameScene *)sceneIn {
    NSObject <LivingThing> *livingThing = [[IAPPlayer alloc] init];

    [livingThing setMoveUpWaysFrames:[self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Up"] prefix: @"Player_" endFix:@"Up_0"]];

    [livingThing setMoveDownWaysFrames:[self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Down"] prefix: @"Player_" endFix:@"Down_0"]];

    NSMutableArray<SKTexture *> *walkFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Sideways"] prefix: @"Player_" endFix:@"right_0"];
    [livingThing setMoveSideWaysFrames:walkFrames];

    SKTexture *firstFrameTexture = walkFrames[0];
    SKSpriteNode *newPlayer = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];

    newPlayer.size = CGSizeMake(newPlayer.size.width * 3, newPlayer.size.height * 3);
    newPlayer.position = CGPointMake(20, 20);
    [livingThing setDefaultSprite:newPlayer];

    return livingThing;
}

- (void)updatePlayerPosition: (CGPoint) touchLocation {
    CGFloat selfHeight = view.bounds.size.height;
    CGFloat selfWidth = view.bounds.size.width;
    int middlePointX = selfWidth / 2;
    int middlePointY = selfHeight / 2;

    float yFromCenter = touchLocation.y - middlePointY;
    float xFromCenter = touchLocation.x - middlePointX;
    [player.defaultSprite removeAllActions];

    [self HandlePlayerMovement:&touchLocation middlePointX:middlePointX middlePointY:middlePointY yFromCenter:yFromCenter xFromCenter:xFromCenter];
}

- (void)HandlePlayerMovement:(const CGPoint *)location middlePointX:(int)middlePointX middlePointY:(int)middlePointY yFromCenter:(float)yFromCenter
                 xFromCenter:(float)xFromCenter
{
    //up
    if (fabs(yFromCenter) > fabs(xFromCenter) && yFromCenter > 0) {
        [self movePlayer:(simd_float4) {0.0f, 1.0f, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
    //down
    else if (fabs(yFromCenter) > fabs(xFromCenter) && yFromCenter < 0) {
        [self movePlayer:(simd_float4) {0.0f, -1.0, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
    //left
    else if (fabs(xFromCenter) > fabs(yFromCenter) && xFromCenter < 0) {
        [self movePlayer:(simd_float4) {-1.0f, 0.0f, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
    //right
    else if (fabs(xFromCenter) > fabs(yFromCenter) && xFromCenter > 0) {
        [self movePlayer:(simd_float4) {1.0f, 0.0f, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
}

- (void)movePlayer:(simd_float4)direction speed:(CGFloat)speed {
    [player lookAt:direction];
    [player moveForward:speed];
}


@end
