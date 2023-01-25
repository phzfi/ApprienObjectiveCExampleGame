//
//  IAPSalesCreature.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 1.4.2021.
//

#import <Foundation/Foundation.h>
#import "LivingThing.h"
#import "IAPSalesCreature.h"
#import "IapManUtilities.h"
#import "IAPManDataTypes.h"


@class IAPSalesCreature;
@implementation IAPSalesCreature{
    
}

@synthesize defaultSprite;
SKSpriteNode *defSprite2;
@synthesize gameManager;
GameManager *gameManagerRef;
@synthesize currentDialog;
SKSpriteNode *_currentDialog;

-(void)setCurrentDialog:(SKSpriteNode *)currentDialog{
    currentDialog = currentDialog;
    _currentDialog = currentDialog;
}
-(SKSpriteNode *)getCurrentDialog{
    return _currentDialog;
}

-(void)setManager: (GameManager *) newGameManager{
    gameManagerRef = newGameManager;
    gameManager = newGameManager;
}

- (void)moveForward:(CGFloat)speed {

}

- (void)lookAt:(simd_float4)direction {

}

- (void)throw:( ItemType)itemType amount:(int)amount {

}

- (void)receiveItem:( ItemType)itemType amount:(int)amount {

}

- (NSMutableArray<SKSpriteNode *>*)scanItemsInRange: (CGFloat)range itemsToScan: (NSMutableArray<SKSpriteNode *>*) items {    NSMutableArray<SKSpriteNode *>* newItems = [[NSMutableArray<SKSpriteNode *> alloc] init];
    for (SKSpriteNode *item in items){
        if([IapManUtilities distanceBetweenPlayerAndNodesSquared: item secondNode: defaultSprite] < range){
            [self setGold:[self getGold] +1];
            [newItems addObject:item];
        }
    }
    return newItems;
}

- (SKSpriteNode *)throwItem:(ItemType)itemType amount:(int)amount {
    return nil;
}

- (void)setDefaultSprite: (SKSpriteNode *)spriteNode{
    defaultSprite = spriteNode;
    defSprite2 = spriteNode;
}

- (SKSpriteNode *)getDefaultSprite{
    return defaultSprite;
}

- (NSMutableArray<NSObject<LivingThing>*> *)ScanLivingThingsInRange: (CGFloat)range livingThingsToScan: (NSMutableArray<NSObject<LivingThing>*>*) livingThingsToScan{
    
    NSMutableArray<NSObject<LivingThing>*> *foundThings = [[NSMutableArray<NSObject<LivingThing>*> alloc]init];

    for (NSObject<LivingThing> *scannedThing in livingThingsToScan){
        if([IapManUtilities distanceBetweenPlayerAndNodesSquared: scannedThing.defaultSprite secondNode: defaultSprite] < range){
            [foundThings addObject:scannedThing];
        }
    }
    return foundThings;
}
@end
