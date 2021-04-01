//
//  LivingThing.h
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 31.3.2021.
//

#ifndef LivingThing_h
#define LivingThing_h


#import <SpriteKit/SpriteKit.h>
#import "IAPManDataTypes.h"
@protocol LivingThing
typedef float __attribute__((ext_vector_type(4))) simd_float4;
@property(nonatomic, assign, getter = getPosition)  simd_float4 position;
@property(nonatomic, assign, getter = getDirection)  simd_float4 direction;
@property(nonatomic, assign, getter = getRotation) CGFloat rotation;
@property(nonatomic, assign, getter = getSpeed) CGFloat speed;
@property(nonatomic, assign, getter = getHp) int hp;
@property(nonatomic, assign, getter = getGol) int gold;
@property(nonatomic, assign, getter = getModel) SKSpriteNode *model;
    
+ (void)moveForward: (CGFloat)speed;
+ (void)lookAt: (simd_float4) direction;
+ (void)throw: (ItemType) itemType amount: (int) amount;
+ (void)receiveItem: (ItemType)itemType amount: (int) amount;
+ (void)scanItems: (CGFloat) interval range:(CGFloat) range;

@end

#endif /* LivingThing_h */
