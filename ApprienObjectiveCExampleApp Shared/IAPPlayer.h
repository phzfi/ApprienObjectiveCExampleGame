//
//  IAPPlayer.h
//  ApprienObjectiveCExampleApp
//
//  Created by phz on 1.4.2021.
//

#ifndef IAPPlayer_h
#define IAPPlayer_h
#import "LivingThing.h"
@interface IAPPlayer : NSObject<LivingThing>
@property(nonatomic, assign, getter = getPosition)  simd_float4 position;
@property(nonatomic, assign, getter = getDirection)  simd_float4 direction;
@property(nonatomic, assign, getter = getRotation) CGFloat rotation;
@property(nonatomic, assign, getter = getSpeed) CGFloat speed;
@property(nonatomic, assign, getter = getHp) int hp;
@property(nonatomic, assign, getter = getGold) int gold;
@property(nonatomic, assign, getter = getDefaultSprite, setter=setDefaultSprite:) SKSpriteNode *defaultSprite;
@property(nonatomic, assign, getter = getMoveSideWaysFrames, setter=setMoveSideWaysFrames:) NSMutableArray<SKTexture*> *moveSideWaysFrames;
@property(nonatomic, assign, getter = getMoveUpWaysFrames, setter=setMoveUpWaysFrames:) NSMutableArray<SKTexture*> *MoveUpWaysFrames;
@property(nonatomic, assign, getter = getMoveDownWaysFrames, setter=setMoveDownWaysFrames:) NSMutableArray<SKTexture*> *MoveDownWaysFrames;
@property(nonatomic, assign, getter = getIdleFrames, setter=setIdleFrames:) NSMutableArray<SKTexture*> *IdleFrames;

- (void)moveForward:(CGFloat)speed;
- (void)lookAt: (simd_float4) direction;
- (void)throwItem: (ItemType) itemType amount: (int) amount;
- (void)receiveItem: (ItemType)itemType amount: (int) amount;
- (void)scanItems: (CGFloat) interval range:(CGFloat) range;

@end

#endif /* IAPPlayer_h */
