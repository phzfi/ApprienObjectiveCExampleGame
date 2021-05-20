//
//  IapManUtilities.h
//  ApprienObjectiveCExampleApp
//
//  Created by phz on 27.4.2021.
//

#ifndef IapManUtilities_h
#define IapManUtilities_h

@interface IapManUtilities: NSObject

+ (float) distanceBetweenTwoPoints: (CGPoint) firstPoint secondPoint: (CGPoint) secondPoint;

+ (float) distanceBetweenPlayerAndNodesSquared: (SKSpriteNode*) firstNode secondNode: (SKSpriteNode*) secondNode;

+ (float) distanceBetweenTwoPointsUnsquared: (CGPoint) firstPoint secondPoint: (CGPoint) secondPoint;

+ (SKSpriteNode *)ProduceCoinWithSize:(int)coinSize position:(CGPoint) position;

+ (NSMutableArray<SKTexture *> *)BuildAnimationFrames:(SKTextureAtlas *)playerAnimatedAtlas prefix: (NSString *)preFix endFix:(NSString *)endFix;

+ (SKSpriteNode *)ProduceDialogWithSize:(CGSize)dialogSize position:(CGPoint) position text: (NSString *) text;

+ (SKSpriteNode *)ProducePickupWithSize:(CGSize)iconSize position:(CGPoint) position iconName:(NSString*) iconName;

+ (SKSpriteNode *)ProduceButtonWithSize:(CGSize)iconSize screenPosition:(CGPoint) position rotation: (CGFloat)rotation buttonName:(NSString *) name;

+ (NSMutableArray*)OpenThreeLineDialogForClosePlayers: (NSMutableArray<NSObject<LivingThing>*> *)foundPlayers position: (CGPoint)position textArray: (NSArray<NSString *>*) text;
+ (CGPoint)GetMovementControlOffset: (SKView*) view;
#endif /* IapManUtilities_h */
@end
