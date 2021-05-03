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
typedef float __attribute__((ext_vector_type(4))) simd_float4;

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

+ (SKSpriteNode *)ProduceDialogWithSize:(CGSize)dialogSize position:(CGPoint) position text: (NSString *) text {
    
    NSArray<SKTexture*> *dialogAnimFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Dialogs"] prefix: @"Dialogue_0" endFix:@""];
    SKTexture *firstFrameTexture = dialogAnimFrames[0];
    
    SKSpriteNode *newDialog = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];
    newDialog.size = dialogSize;
    newDialog.position = position;
    SKAction *animAction = [SKAction animateWithTextures:dialogAnimFrames
                                            timePerFrame:0.1
                                                  resize:false
                                                 restore:true];
    [newDialog runAction: animAction];
    return newDialog;
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

+ (NSMutableArray<SKSpriteNode*> *)OpenDialogForClosePlayers: (NSMutableArray<NSObject<LivingThing>*> *)foundPlayers position: (CGPoint)position{
    NSMutableArray<SKSpriteNode*> *dialogueContents;
    if([foundPlayers count] > 0 ){
        SKSpriteNode* dialog = [IapManUtilities ProduceDialogWithSize: CGSizeMake(256*1.5, 64*1.5) position:CGPointMake(position.x, position.y) text:@"heart"];
        
        SKLabelNode * _text = (SKLabelNode *)[SKLabelNode labelNodeWithText:@"Press to continue"];
        _text.fontName =@"Helvetica Neue UltraLight";
        _text.alpha = 1;
        _text.position = CGPointMake(position.x, position.y);
        [dialogueContents addObject:_text];
        [dialogueContents addObject:dialog];
    
        return dialog;
    }
    return nil;
}
@end
