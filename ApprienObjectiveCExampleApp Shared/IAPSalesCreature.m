//
//  IAPSalesCreature.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 1.4.2021.
//

#import <Foundation/Foundation.h>
#import "LivingThing.h"
#import "IAPSalesCreature.h"
#import "IAPManDataTypes.h"
@class IAPSalesCreature;
@implementation IAPSalesCreature

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

- (NSMutableArray<SKSpriteNode *>*)scanItemsInRange: (CGFloat)range itemsToScan: (NSMutableArray<SKSpriteNode *>*) items  {
    return nil;
}

- (void)throwItem:(ItemType)itemType amount:(int)amount { 
    
}

- (void)setDefaultSprite: (SKSpriteNode *)spriteNode{
    defaultSprite = spriteNode;
    defSprite2 = spriteNode;
}

- (SKSpriteNode *)getDefaultSprite{
    return defaultSprite;
}

@end
