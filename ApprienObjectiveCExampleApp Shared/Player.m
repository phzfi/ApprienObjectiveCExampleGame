//
//  Player.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 1.4.2021.
//

#import <Foundation/Foundation.h>
#import "IAPPlayer.h"
#import "IAPManDataTypes.h"
#import <SpriteKit/SpriteKit.h>
@class Player;
@implementation IAPPlayer
NSMutableArray <SKTexture*>*moveFrames;
SKSpriteNode *defSprite;
@synthesize moveSideWaysFrames;
@synthesize defaultSprite;

- (void)moveForward:(CGFloat)speed{
    [self animatePlayer: moveSideWaysFrames];
}

- (void)lookAt: (simd_float4)direction {

}

- (void)throwItem: (ItemType)itemType amount:(int)amount {

}

- (void)receiveItem:( ItemType)itemType amount:(int)amount {

}

- (void)scanItems:(CGFloat)interval range:(CGFloat)range {

}

- (void) animatePlayer: (NSMutableArray <SKTexture*>*)textures  {

    [self.defaultSprite runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:textures
                                        timePerFrame:0.1
                                              resize:false
                                             restore:true]]];
}

- (void)setMoveSideWaysFrames: (NSMutableArray <SKTexture*>*)textures{
    moveFrames = textures;
   moveSideWaysFrames = textures;
}

- (NSMutableArray <SKTexture*>*)getMoveSideWaysFrames{
    return moveSideWaysFrames;
}
- (void)setDefaultSprite: (SKSpriteNode *)spriteNode{
    defaultSprite = spriteNode;
    defSprite = spriteNode;
}

- (SKSpriteNode *)getDefaultSprite{
    return defaultSprite;
}
@end
