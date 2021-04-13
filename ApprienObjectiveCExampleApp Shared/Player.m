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
NSMutableArray <SKTexture*>*moveUpFrames;
NSMutableArray <SKTexture*>*moveDownFrames;
SKSpriteNode *defSprite;
@synthesize moveSideWaysFrames;
@synthesize moveUpWaysFrames;
@synthesize moveDownWaysFrames;
@synthesize defaultSprite;
simd_float4 lookDirection;

- (void)moveForward:(CGFloat)speed{
    
    simd_float4 direction =  (simd_float4){ -lookDirection[0],     lookDirection[1],   0.0f,  0.0f };
    
    SKAction *animAction = [self animatePlayer];
    SKAction *moveAction = [SKAction moveBy:CGVectorMake(-speed*10*direction[0], -speed*10*direction[1]) duration:0.1];
    moveAction = [SKAction repeatActionForever:moveAction];
    
    [defSprite runAction: animAction];
    [defSprite runAction: moveAction];
}


- (void)lookAt: (simd_float4)direction {
    lookDirection = direction;
    //TODO: Implement default sprite for direction if needed
}

- (void)throwItem: (ItemType)itemType amount:(int)amount {
    
}

- (void)receiveItem:( ItemType)itemType amount:(int)amount {
    
}

- (void)scanItems:(CGFloat)interval range:(CGFloat)range {
    
}

- (SKAction *) animatePlayer  {
    
    if(lookDirection[1] == 1){
        return [SKAction repeatActionForever:
                [SKAction animateWithTextures:moveUpFrames
                                 timePerFrame:0.1
                                       resize:false
                                      restore:true]];
    }
    else if(lookDirection[1] == -1){
        return [SKAction repeatActionForever:
                [SKAction animateWithTextures:moveDownFrames
                                 timePerFrame:0.1
                                       resize:false
                                      restore:true]];
    }
    
    else if(lookDirection[0] == 1){
        defSprite.xScale = fabs(defSprite.xScale) * 1;
        return [SKAction repeatActionForever:
                [SKAction animateWithTextures:moveSideWaysFrames
                                 timePerFrame:0.1
                                       resize:false
                                      restore:true]];
    }
    else if(lookDirection[0] == -1){
        defSprite.xScale = fabs(defSprite.xScale) * -1;
        
        return [SKAction repeatActionForever:
                [SKAction animateWithTextures:moveSideWaysFrames
                                 timePerFrame:0.1
                                       resize:false
                                      restore:true]];
    }
    return [SKAction repeatActionForever:
            [SKAction animateWithTextures:moveSideWaysFrames
                             timePerFrame:0.1
                                   resize:false
                                  restore:true]];
}

- (void)setMoveSideWaysFrames: (NSMutableArray <SKTexture*>*)textures{
    moveFrames = textures;
    moveSideWaysFrames = textures;
}

- (NSMutableArray <SKTexture*>*)getMoveSideWaysFrames{
    return moveSideWaysFrames;
}

- (void)setMoveUpWaysFrames: (NSMutableArray <SKTexture*>*)textures{
    moveUpFrames = textures;
    moveUpWaysFrames = textures;
}

- (NSMutableArray <SKTexture*>*)getMoveUpWaysFrames{
    return moveUpWaysFrames;
}

- (void)setMoveDownWaysFrames: (NSMutableArray <SKTexture*>*)textures{
    moveDownFrames = textures;
    moveDownWaysFrames = textures;
}

- (NSMutableArray <SKTexture*>*)getMoveDownWaysFrames{
    return moveDownFrames;
}

- (void)setDefaultSprite: (SKSpriteNode *)spriteNode{
    defaultSprite = spriteNode;
    defSprite = spriteNode;
}

- (SKSpriteNode *)getDefaultSprite{
    return defaultSprite;
}

@end
