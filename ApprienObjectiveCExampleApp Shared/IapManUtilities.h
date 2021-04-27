//
//  IapManUtilities.h
//  ApprienObjectiveCExampleApp
//
//  Created by phz on 27.4.2021.
//

#ifndef IapManUtilities_h
#define IapManUtilities_h

@interface IapManUtilities: NSObject
+ (float) distanceBetweenPlayerAndNodesSquared: (SKSpriteNode*) firstNode secondNode: (SKSpriteNode*) secondNode;

+ (float) distanceBetweenPlayerAndNodesUnSquared: (SKSpriteNode*) firstNode secondNode: (SKSpriteNode*) secondNode;

+ (SKSpriteNode *)ProduceCoinWithSize:(int)coinSize position:(CGPoint) position;
+ (NSMutableArray<SKTexture *> *)BuildAnimationFrames:(SKTextureAtlas *)playerAnimatedAtlas prefix: (NSString *)preFix endFix:(NSString *)endFix;
#endif /* IapManUtilities_h */
@end
