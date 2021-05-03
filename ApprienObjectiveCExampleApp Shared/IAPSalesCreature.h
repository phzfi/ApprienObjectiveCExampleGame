//
//  IAPSalesCreature.h
//  ApprienObjectiveCExampleApp
//
//  Created by phz on 23.4.2021.
//

#ifndef IAPSalesCreature_h
#define IAPSalesCreature_h
#import "LivingThing.h"
@interface IAPSalesCreature : NSObject<LivingThing>
@property(nonatomic, assign, getter = getPosition)  simd_float4 position;
@property(nonatomic, assign, getter = getDirection)  simd_float4 direction;
@property(nonatomic, assign, getter = getRotation) CGFloat rotation;
@property(nonatomic, assign, getter = getSpeed) CGFloat speed;
@property(nonatomic, assign, getter = getHp) int hp;
@property(nonatomic, assign, getter = getGold) int gold;
@property(nonatomic, assign, getter = getDefaultSprite, setter=setDefaultSprite:) SKSpriteNode *defaultSprite;
@property(nonatomic, assign, getter = getMoveSideWaysFrames, setter=setMoveSideWaysFrames:) NSMutableArray<SKTexture*> *moveSideWaysFrames;
@property(nonatomic, assign, getter = getMoveUpWaysFrames, setter=setMoveUpWaysFrames:) NSMutableArray<SKTexture*> *moveUpWaysFrames;
@property(nonatomic, assign, getter = getMoveDownWaysFrames, setter=setMoveDownWaysFrames:) NSMutableArray<SKTexture*> *moveDownWaysFrames;
@property(nonatomic, assign, getter = getIdleFrames, setter=setIdleFrames:) NSMutableArray<SKTexture*> *idleFrames;
@property(nonatomic, assign, setter=setManager:) GameManager *gameManager;
@property(nonatomic, assign, getter=getCurrentDialog, setter=setCurrentDialog:) SKSpriteNode *currentDialog;
- (void)moveForward:(CGFloat)speed;
- (void)lookAt: (simd_float4) direction;
- (SKSpriteNode *)throwItem: (ItemType) itemType amount: (int) amount;
- (void)receiveItem: (ItemType)itemType amount: (int) amount;
- (NSMutableArray<SKSpriteNode *>*)scanItemsInRange: (CGFloat)range itemsToScan: (NSMutableArray<SKSpriteNode *>*) items;
- (NSMutableArray<NSObject<LivingThing>*> *)ScanLivingThingsInRange: (CGFloat)range livingThingsToScan: (NSMutableArray<NSObject<LivingThing>*>*) livingThingsToScan;
@end

#endif /* IAPSalesCreature_h */
