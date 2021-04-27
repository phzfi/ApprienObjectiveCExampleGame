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
    IapManUtilities *iapUtilities;
}

@synthesize defaultSprite;
SKSpriteNode *defSprite2;



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

- (void)throwItem:(ItemType)itemType amount:(int)amount { 
    if(itemType == Gold){
       // [IapManUtilities ProduceCoinWithSize: 64 position:defaultSprite.position];
        
    }
}

- (void)setDefaultSprite: (SKSpriteNode *)spriteNode{
    defaultSprite = spriteNode;
    defSprite2 = spriteNode;
}

- (SKSpriteNode *)getDefaultSprite{
    return defaultSprite;
}

- (NSMutableArray<NSObject<LivingThing>*> *)scanLivingThingsInRange: (CGFloat)range livingThingsToScan: (NSMutableArray<NSObject<LivingThing>*>*) livingThingsToScan{
    
    NSMutableArray<NSObject<LivingThing>*> *foundThings = [[NSMutableArray<NSObject<LivingThing>*> alloc]init];

    for (NSObject<LivingThing> *thing in livingThingsToScan){
        //if([IapManUtilities distanceBetweenPlayerAndNodesSquared: thing.defaultSprite secondNode: defaultSprite] < range){
            [self setGold:[self getGold] +1];
            [foundThings addObject:thing];
        //}
    }
    return foundThings;
}

@end
