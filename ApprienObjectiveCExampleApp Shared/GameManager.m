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
#import "IAPSalesCreature.h"
#import <GameplayKit/GameplayKit.h>

@implementation GameManager {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    SKLabelNode *_labelContinue;
    NSObject <LivingThing> *player;
    SKView *view;
    SKScene *scene;
    NSMutableArray<SKSpriteNode *> *sceneItems;
    NSMutableArray<NSObject<LivingThing>*> *shopKeepers;
}

-(void)setView:(SKView *) skView{
    view = skView;

}

-(void)update{
    NSMutableArray<SKSpriteNode*> *foundItems =[player scanItemsInRange: (player.defaultSprite.size.width) itemsToScan: sceneItems];
    [self clearFoundItems: foundItems];

}
- (void)clearFoundItems: (NSMutableArray<SKSpriteNode*> *)foundItems{
    if([foundItems count] > 0 ){
        [scene removeChildrenInArray:foundItems];
        for(SKSpriteNode *item in foundItems){
            [item removeAllActions];
            [item removeFromParent];
        }
    }
}

- (GameScene *)loadGameScene{
    return  [GameScene newGameScene];
}

- (void)cleanUpScene: (SKScene*) scene
{
    @autoreleasepool {
        [scene removeAllChildren];
        [scene removeAllActions];
        sceneItems = nil;
    }
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
    _labelContinue.position = CGPointMake(20, -100);
    [scene addChild: _labelContinue];
   // [_labelContinue runAction:[SKAction fadeInWithDuration:2.0]];
    
    SKSpriteNode *titleImage = [SKSpriteNode spriteNodeWithImageNamed:@"Player"];

    titleImage.size = CGSizeMake(titleImage.size.width*6, titleImage.size.height*6);
    titleImage.position = CGPointMake(20,20);
    [scene addChild: titleImage];
}

- (void)setUpScene: (int) index scene:(GameScene *) scene viewSize:(CGSize) viewSize{
    sceneItems = [[NSMutableArray<SKSpriteNode *> alloc]init];
    shopKeepers = [[NSMutableArray<NSObject<LivingThing>*> alloc]init];
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
    [self generateShopKeepers:scene];
    [self generatePickableMoney:scene];
}

- (void)generateShopKeepers:(GameScene *)sceneIn {
    int shopKeeperSize = 64;
    NSObject<LivingThing> *newShopKeeper = [self buildShopKeeper:sceneIn shopKeeperName:@"Demon_0" size:shopKeeperSize];
    [shopKeepers addObject:newShopKeeper];
}

- (NSObject <LivingThing> *)buildShopKeeper:(SKScene *)sceneIn shopKeeperName: (NSString*) shopKeeperName size: (float) shopKeeperSize {
    
    NSArray<SKTexture*> *shopKeeperAnimFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"ShopKeeper"] prefix: @"IAP_Shop_Keeper_" endFix:shopKeeperName];
    
    NSObject <LivingThing> *newShopKeeper = [[IAPSalesCreature alloc] init];
    SKTexture *firstFrameTexture = shopKeeperAnimFrames[0];
    SKSpriteNode *newShopKeeperTexture = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];


    [newShopKeeper setDefaultSprite:newShopKeeperTexture];
    SKAction *animAction = [SKAction repeatActionForever:
            [SKAction animateWithTextures:shopKeeperAnimFrames
                             timePerFrame:0.1
                                   resize:false
                                  restore:true]];
    [newShopKeeperTexture runAction: animAction];
    newShopKeeper.defaultSprite.size= CGSizeMake(shopKeeperSize, shopKeeperSize);
  
    [newShopKeeper getDefaultSprite].position = CGPointMake(0, view.bounds.size.height - shopKeeperSize*2);
    
     
     [sceneIn addChild:newShopKeeper.defaultSprite];
    
    return newShopKeeper;
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
        [sceneItems addObject:newCoin];
       
        [sceneIn addChild:newCoin];

    }
}

static bool ContainsTextureName(int i, SKTextureAtlas *playerAnimatedAtlas, NSString *playerTextureName) {
    return [playerAnimatedAtlas.textureNames[i-1] rangeOfString: playerTextureName].location != NSNotFound;
}

- (NSMutableArray<SKTexture *> *)BuildAnimationFrames:(SKTextureAtlas *)playerAnimatedAtlas prefix: (NSString *)preFix endFix:(NSString *)endFix {

    NSMutableArray<SKTexture *> *animFrames = [[NSMutableArray<SKTexture *> alloc] init];
    int numImages = (int) playerAnimatedAtlas.textureNames.count;
    int j = 1;
    for (int i = 1;  i <= numImages; i++) {
        NSString *playerTextureName = [preFix stringByAppendingString:endFix];
        
        if(ContainsTextureName(i, playerAnimatedAtlas, playerTextureName) ){
            playerTextureName = [playerTextureName stringByAppendingString:@(j).stringValue];
            [animFrames addObject:[playerAnimatedAtlas textureNamed:playerTextureName]];
            j+=1;
        }
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
