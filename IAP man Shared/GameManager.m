//
//  GameManager.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 31.3.2021.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "LivingThing.h"
#import "IAPPlayer.h"
#import "IAPSalesCreature.h"
#import "IapManUtilities.h"
#import <GameplayKit/GameplayKit.h>
#import "GameScene.h"

@implementation GameManager {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    SKLabelNode *_labelContinue;
    //Use array to avoid adding addittional functions to interface
    NSMutableArray<NSObject <LivingThing>*>*players;
    SKView *view;
    SKScene *scene;
    NSMutableArray<SKSpriteNode *> *sceneItems;
    NSMutableArray<NSObject<LivingThing>*> *shopKeepers;
    
}

CGFloat moveButtonSize = 68;


-(id)init {
     if (self = [super init])  {
       
     }
     return self;
}

-(void)update{
    if(scene == nil){
        scene =view.scene;
    }
    [self HandlePlayers];
    
    [self HandleShopKeepers];
}

- (void)HandleShopKeepers {
    for (NSObject<LivingThing>* shopKeeper in shopKeepers){
        NSMutableArray<NSObject<LivingThing>*> *livingThings = [shopKeeper ScanLivingThingsInRange:shopKeeper.defaultSprite.size.width livingThingsToScan:players];
        
        NSMutableArray<SKSpriteNode*> *foundItems = [shopKeeper scanItemsInRange: (shopKeeper.defaultSprite.size.width) itemsToScan: sceneItems];
        [self clearFoundItems: foundItems];
        
        [self HandleShopKeeperDialog:livingThings shopKeeper:shopKeeper];
    }
}

- (void)HandlePlayers {
    for (NSObject<LivingThing>* player in players){
        NSMutableArray<SKSpriteNode*> *foundItems =[player scanItemsInRange: (player.defaultSprite.size.width) itemsToScan: sceneItems];
        [self clearFoundItems: foundItems];
    }
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

- (void)HandleShopKeeperDialog:(NSMutableArray<NSObject<LivingThing> *> *)livingThings shopKeeper:(NSObject<LivingThing> *)shopKeeper {
    CGPoint position =CGPointMake(shopKeeper.defaultSprite.position.x, shopKeeper.defaultSprite.position.y + shopKeeper.defaultSprite.size.height);
    NSArray* iapManIapProductIds = [[NSArray alloc] init];
    
    
    iapManIapProductIds = @[@"IAPman_coin_bag_50_sku",
                   @"IAPman_coin_bag_10_sku",
                   @"IAPman_health_potion_sku",
                   @"IAPman_strenght_potion_sku",
                   @"IAPman_speed_potion_sku",];
    

    
    
    NSString *firstLine =[NSString stringWithFormat:@"You will need more strength to "];
    NSString *secondLine =[NSString stringWithFormat:@"climb the hill behind me."];
    NSString *priceText = [NSString stringWithFormat:@"Buy strength potion? Coins:%@", @"23.3"];
    NSArray<NSString*> *dialogueTextContent = [[NSArray alloc]initWithObjects:firstLine, secondLine, priceText, nil];
    NSMutableArray *dialogs = [IapManUtilities OpenThreeLineDialogForClosePlayers:livingThings position: position textArray:dialogueTextContent];
    
    [self HandleDialogVisibility:dialogs shopKeeper:shopKeeper];
}

- (void)HandleDialogVisibility:(NSMutableArray *)dialogs shopKeeper:(NSObject<LivingThing> *)shopKeeper {
    if(dialogs){
        if([shopKeeper getCurrentDialog] == nil){
            [shopKeeper setCurrentDialog:dialogs];
            for(int i = 0; i< [dialogs count]; i++){
                [scene addChild:[shopKeeper getCurrentDialog][i]];
            }
        }
    }
    else if (dialogs == nil && [shopKeeper getCurrentDialog] != nil){
        [scene removeChildrenInArray:[shopKeeper getCurrentDialog]];
        [shopKeeper setCurrentDialog:nil];
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
    [scene addChild: _label];
    _labelContinue = (SKLabelNode *)[SKLabelNode labelNodeWithText:@"Press to continue"];
    _labelContinue.fontName =@"Helvetica Neue UltraLight";
    _labelContinue.alpha = 1;
    _labelContinue.position = CGPointMake(20, -100);
    [scene addChild: _labelContinue];

    SKSpriteNode *titleImage = [SKSpriteNode spriteNodeWithImageNamed:@"Player"];

    titleImage.size = CGSizeMake(titleImage.size.width*6, titleImage.size.height*6);
    titleImage.position = CGPointMake(20,20);
    [scene addChild: titleImage];
}

- (void)setUpScene: (int) index scene:(GameScene *) scene viewSize:(CGSize) viewSize{
    players = [[NSMutableArray<NSObject<LivingThing>*> alloc]init];
    sceneItems = [[NSMutableArray<SKSpriteNode *> alloc]init];
    shopKeepers = [[NSMutableArray<NSObject<LivingThing>*> alloc]init];
    [self SetUpEnvironment:scene viewSize:&viewSize];
    
    [players addObject:[self buildPlayer:scene]];
    [scene addChild:[players[0] getDefaultSprite]];
    [self generateShopKeepers:scene];
    [self generatePickableMoney:scene];
    [self SetUpControlsUI: scene];
}


- (void)SetUpEnvironment:(GameScene *)scene viewSize:(const CGSize *)viewSize {
    SKTileSet *enviro = [SKTileSet tileSetNamed:@"Environment"];
    
    NSArray<SKTileGroup*> *levelTiles = enviro.tileGroups;
    CGSize tileSize;
    tileSize.width =128;
    tileSize.height = 128;
    SKTileMapNode *tileNode =[SKTileMapNode tileMapNodeWithTileSet:enviro columns:viewSize->width/128 rows:viewSize->height tileSize:tileSize fillWithTileGroup:levelTiles[0]];
    
    [scene addChild:tileNode];
    
    SKTileMapNode *tileNodeStones =[SKTileMapNode tileMapNodeWithTileSet:enviro columns:1 rows:viewSize->height tileSize:tileSize fillWithTileGroup:levelTiles[2]];
    
    [scene addChild:tileNodeStones];
}

- (void)generateShopKeepers:(GameScene *)sceneIn {
    int shopKeeperSize = 128;
    NSObject<LivingThing> *newShopKeeper = [self buildShopKeeper:sceneIn shopKeeperName:@"Demon_0" size:shopKeeperSize position:CGPointMake(0,  view.bounds.size.height /4)];
    [shopKeepers addObject:newShopKeeper];
}

- (NSObject <LivingThing> *)buildShopKeeper:(SKScene *)sceneIn shopKeeperName: (NSString*) shopKeeperName size: (float) shopKeeperSize position:(CGPoint) position{
    
    NSArray<SKTexture*> *shopKeeperAnimFrames = [IapManUtilities BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"ShopKeeper"] prefix: @"IAP_Shop_Keeper_" endFix:shopKeeperName];
    
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
  
    [newShopKeeper getDefaultSprite].position = position;
    [sceneIn addChild:newShopKeeper.defaultSprite];
    [newShopKeeper setManager:self];
    return newShopKeeper;
}

- (void)generatePickableMoney:(GameScene *)sceneIn {
    int coinSize = 64;
    NSArray<SKTexture*> *coinAnimFrames = [IapManUtilities BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Coin"] prefix: @"coin_0" endFix:@""];
    SKTexture *firstFrameTexture = coinAnimFrames[0];
    
    for(int i = 0; i < 10; i++){
        SKSpriteNode * newCoin = [IapManUtilities ProduceCoinWithSize: coinSize position:CGPointMake(0, 1 * -180 +180*i)];
        [sceneItems addObject:newCoin];
       
        [sceneIn addChild:newCoin];
    }
}

- (NSObject <LivingThing> *)buildPlayer:(GameScene *)sceneIn {
    
    NSObject <LivingThing> *livingThing = [[IAPPlayer alloc] init];
    [livingThing setMoveUpWaysFrames:[IapManUtilities BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Up"] prefix: @"Player_" endFix:@"Up_0"]];

    [livingThing setMoveDownWaysFrames:[IapManUtilities BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Down"] prefix: @"Player_" endFix:@"Down_0"]];

    NSMutableArray<SKTexture *> *walkFrames = [IapManUtilities BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Player_Walk_Sideways"] prefix: @"Player_" endFix:@"right_0"];
    [livingThing setMoveSideWaysFrames:walkFrames];

    SKTexture *firstFrameTexture = walkFrames[0];
    SKSpriteNode *newPlayerDefaultSprite = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];

    newPlayerDefaultSprite.size = CGSizeMake(newPlayerDefaultSprite.size.width * 3, newPlayerDefaultSprite.size.height * 3);
    newPlayerDefaultSprite.position = CGPointMake(20, 20);
    [livingThing setDefaultSprite:newPlayerDefaultSprite];
    [livingThing setManager:self];
    return livingThing;
}

- (CGPoint)getTouchLocationRelativeToScreenCenter:(CGPoint) middlePointScreenOffset touchLocation:(CGPoint)touchLocation {

    float yTouchFromCenter = touchLocation.y - middlePointScreenOffset.y;
    float xTouchFromCenter = touchLocation.x - middlePointScreenOffset.x;
    return CGPointMake(xTouchFromCenter, yTouchFromCenter);
}

- (void)updatePlayer: (NSString *) clickedButtonName {
    CGPoint offset =[IapManUtilities GetMovementControlOffset:view];
   
    [players[0].defaultSprite removeAllActions];

    [self HandlePlayerMovement:clickedButtonName];
    [self HandlePlayerCoinThrow:clickedButtonName];
}

- (void)SetUpControlsUI:(GameScene *)sceneIn {
    CGFloat xOffset = [IapManUtilities GetMovementControlOffset:view].x  + moveButtonSize;
    CGFloat yOffset = [IapManUtilities GetMovementControlOffset:view].y;
    
    CGPoint newPos  = CGPointMake(  xOffset - moveButtonSize ,  0 + yOffset);
    SKSpriteNode *buttonLeft =[IapManUtilities ProduceButtonWithSize: CGSizeMake(64, 64) screenPosition: newPos rotation:M_PI / 2 buttonName: @"GoldButtonMove_0"];
    buttonLeft.name = @"button_left";
    [scene addChild:buttonLeft];
    
     newPos = CGPointMake( xOffset ,  0 + moveButtonSize + yOffset);
    SKSpriteNode *buttonUp =[IapManUtilities ProduceButtonWithSize: CGSizeMake(64, 64) screenPosition: newPos rotation:0 buttonName: @"GoldButtonMove_0"];
    buttonUp.name = @"button_up";
    [scene addChild:buttonUp];
    
    newPos = CGPointMake( xOffset +moveButtonSize ,  0  + yOffset);
    SKSpriteNode *buttonRight =[IapManUtilities ProduceButtonWithSize: CGSizeMake(64, 64) screenPosition: newPos rotation:-M_PI / 2 buttonName: @"GoldButtonMove_0"];
    buttonRight.name = @"button_right";
    [scene addChild:buttonRight];
    
    newPos = CGPointMake( xOffset ,  0 - moveButtonSize + yOffset);
    SKSpriteNode *buttonDown =[IapManUtilities ProduceButtonWithSize: CGSizeMake(64, 64) screenPosition: newPos rotation:-M_PI buttonName: @"GoldButtonMove_0"];
    buttonDown.name = @"button_down";
    [scene addChild:buttonDown];
    
    newPos = CGPointMake( -xOffset ,  0 - moveButtonSize + yOffset);
    SKSpriteNode *coinThrow =[IapManUtilities ProduceButtonWithSize: CGSizeMake(64, 64) screenPosition: newPos rotation:-M_PI buttonName: @"GoldButtonShootGoldCoin_0"];
    coinThrow.name = @"coin_throw";
    [scene addChild:coinThrow];
}


- (bool)InSideMaxRange:(CGPoint)middlePoint range:(float)range touchLocation:(CGPoint)touchLocation {
    return [IapManUtilities distanceBetweenTwoPoints:middlePoint secondPoint:touchLocation] < range;
}

- (void)HandlePlayerMovement:(NSString*) clickedButtonName
{
    if ([clickedButtonName isEqual:@"button_down"]) {
        [self movePlayer:(simd_float4) {0.0f, 1.0f, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
    else if ([clickedButtonName isEqual:@"button_up"]) {
        [self movePlayer:(simd_float4) {0.0f, -1.0, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
    else if ([clickedButtonName isEqual:@"button_left"]) {
        [self movePlayer:(simd_float4) {-1.0f, 0.0f, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
    else if ([clickedButtonName isEqual:@"button_right"]) {
        [self movePlayer:(simd_float4) {1.0f, 0.0f, 0.0f, 0.0f} speed:(CGFloat) 1];
    }
}

- (void)HandlePlayerCoinThrow:(NSString*) clickedButtonName
{
    if (clickedButtonName == @"coin_throw") {
        SKSpriteNode *thrownItem = [players[0] throwItem:Gold amount:1];
      //TODO: clean up it wont pick up it instantly after thrown
      //[sceneItems addObject:thrownItem];
    }
}

- (void)movePlayer:(simd_float4)direction speed:(CGFloat)speed {
    [players[0] lookAt:direction];
    [players[0] moveForward:speed];
}

-(void)setView:(SKView *) skView{
    view = skView;
}

- (SKScene *)getScene
{
    return view.scene;
}

@end
