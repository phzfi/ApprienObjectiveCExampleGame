//
//  IapManUtilities.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 27.4.2021.
//


#import <Foundation/Foundation.h>
#import "IAPPlayer.h"
#import "IAPManDataTypes.h"
#import <SpriteKit/SpriteKit.h>
#import "IapManUtilities.h"

@implementation IapManUtilities : NSObject

+ (float) distanceBetweenPlayerAndNodesSquared: (SKSpriteNode*) firstNode secondNode: (SKSpriteNode*) secondNode{
    return sqrt([self distanceBetweenPlayerAndNodesUnSquared: firstNode secondNode:secondNode]);
}

+ (float) distanceBetweenPlayerAndNodesUnSquared: (SKSpriteNode*) firstNode secondNode: (SKSpriteNode*) secondNode{
    return ((firstNode.position.x - secondNode.position.x) * (firstNode.position.x - secondNode.position.x))
    + ((firstNode.position.y -  secondNode.position.y) * (firstNode.position.y -  secondNode.position.y));
}

+ (SKSpriteNode *)ProduceCoinWithSize:(int)coinSize position:(CGPoint) position {
    
    NSArray<SKTexture*> *coinAnimFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Coin"] prefix: @"coin_0" endFix:@""];
    SKTexture *firstFrameTexture = coinAnimFrames[0];
    
    SKSpriteNode *newCoin = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];
    newCoin.size = CGSizeMake(coinSize, coinSize);
    newCoin.position = position;
    SKAction *animAction = [SKAction repeatActionForever:
                            [SKAction animateWithTextures:coinAnimFrames
                                             timePerFrame:0.1
                                                   resize:false
                                                  restore:true]];
    [newCoin runAction: animAction];
    return newCoin;
}

+ (NSMutableArray<SKTexture *> *)BuildAnimationFrames:(SKTextureAtlas *)playerAnimatedAtlas prefix: (NSString *)preFix endFix:(NSString *)endFix {

    NSMutableArray<SKTexture *> *animFrames = [[NSMutableArray<SKTexture *> alloc] init];
    int numImages = (int) playerAnimatedAtlas.textureNames.count;
    int j = 1;
    for (int i = 1;  i <= numImages; i++) {
        NSString *playerTextureName = [preFix stringByAppendingString:endFix];
        
        if([self ContainsTextureName: i textureAtlas: playerAnimatedAtlas textureName: playerTextureName]){
            playerTextureName = [playerTextureName stringByAppendingString:@(j).stringValue];
            [animFrames addObject:[playerAnimatedAtlas textureNamed:playerTextureName]];
            j+=1;
        }
    }
    return animFrames;
}

+ (bool) ContainsTextureName:(int) i textureAtlas: (SKTextureAtlas *)playerAnimatedAtlas textureName:(NSString *) playerTextureName {
    return [playerAnimatedAtlas.textureNames[i-1] rangeOfString: playerTextureName].location != NSNotFound;
}
@end
