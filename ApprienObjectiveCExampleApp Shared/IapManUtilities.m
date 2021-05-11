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

+ (float) distanceBetweenTwoPoints: (CGPoint) firstPoint secondPoint: (CGPoint) secondPoint{
    return sqrt([self distanceBetweenTwoPointsUnsquared: firstPoint secondPoint:secondPoint]);
}

+ (float) distanceBetweenPlayerAndNodesSquared: (SKSpriteNode*) firstNode secondNode: (SKSpriteNode*) secondNode{
    return sqrt([self distanceBetweenTwoPointsUnsquared: firstNode.position secondPoint:secondNode.position]);
}

+ (float) distanceBetweenTwoPointsUnsquared: (CGPoint) firstPoint secondPoint: (CGPoint) secondPoint{
    return ((firstPoint.x - secondPoint.x) * (firstPoint.x - secondPoint.x))
    + ((firstPoint.y -  secondPoint.y) * (firstPoint.y -  secondPoint.y));
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

+ (SKSpriteNode *)ProduceDialogWithSize:(CGSize)dialogSize position:(CGPoint) position{
    
    NSArray<SKTexture*> *dialogAnimFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Dialogs"] prefix: @"Dialogue_0" endFix:@""];
    SKTexture *fullDialogFrameTexture = dialogAnimFrames[[dialogAnimFrames count]-1];
    
    SKSpriteNode *newDialog = [SKSpriteNode spriteNodeWithTexture:fullDialogFrameTexture];
    newDialog.size = dialogSize;
    newDialog.position = position;
    newDialog.zPosition = 0.9;
    SKAction *animAction = [SKAction animateWithTextures:dialogAnimFrames
                                            timePerFrame:0.1
                                                  resize:false
                                                 restore:true];
    [newDialog runAction: animAction];
    return newDialog;
}

+ (SKSpriteNode *)ProducePickupWithSize:(CGSize)iconSize position:(CGPoint) position iconName:(NSString*) iconName{
    
    NSArray<SKTexture*> *iconAnimFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"PickUps"] prefix: iconName endFix:@""];
    SKTexture *firstFrameTexture = iconAnimFrames[0];
    
    SKSpriteNode *newIcon = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];
    newIcon.size = iconSize;
    newIcon.position = position;
    newIcon.zPosition = 0.9;
    SKAction *animAction = [SKAction animateWithTextures:iconAnimFrames
                                            timePerFrame:0.1
                                                  resize:false
                                                 restore:true];
    [newIcon runAction: animAction];
    return newIcon;
}

+ (SKSpriteNode *)ProduceButtonWithSize:(CGSize)iconSize screenPosition:(CGPoint) position rotation: (CGFloat)rotation buttonName:(NSString *) name{
    
    NSArray<SKTexture*> *iconAnimFrames = [self BuildAnimationFrames:[SKTextureAtlas atlasNamed:@"Buttons"] prefix: name endFix:@""];
    SKTexture *firstFrameTexture = iconAnimFrames[0];
    
    SKSpriteNode *newIcon = [SKSpriteNode spriteNodeWithTexture:firstFrameTexture];
    newIcon.size = iconSize;
    newIcon.position = position;
    
    newIcon.zPosition = 1;
    newIcon.zRotation = rotation;
    SKAction *animAction = [SKAction animateWithTextures:iconAnimFrames
                                            timePerFrame:0.1
                                                  resize:false
                                                 restore:true];
    [newIcon runAction: animAction];
    return newIcon;
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

+ (void)ProduceLabel:(NSMutableArray *)dialogueContents fadeIn:(SKAction *)fadeIn offset:(int)offset position:(const CGPoint *)position text:(NSString *)text {
    SKLabelNode * salesText = [self ProduceTextWithSize: 30 position:CGPointMake(position->x, position->y + offset ) text: text];
    salesText.alpha = 0;
    [salesText runAction:fadeIn];
    [dialogueContents addObject:salesText];
}

+ (int)ProduceThreeLinesOfTextForDialog:(NSMutableArray *)dialogueContents position:(const CGPoint *)position textArray:(NSArray<NSString *> *)textArray {
    int offset = 30;
    int additionalTextOffset =-8;
    int textSeparateAmount = 30;
    offset = offset + additionalTextOffset;
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:1];
    [self ProduceLabel:dialogueContents fadeIn:fadeIn offset:offset+ textSeparateAmount position:position text:textArray[0]];
    [self ProduceLabel:dialogueContents fadeIn:fadeIn offset:offset position:position text:textArray[1]];
    [self ProduceLabel:dialogueContents fadeIn:fadeIn offset:offset - textSeparateAmount position:position text:textArray[2]];
    return offset;
}

+ (NSMutableArray*)OpenThreeLineDialogForClosePlayers: (NSMutableArray<NSObject<LivingThing>*> *)foundPlayers position: (CGPoint)position textArray: (NSArray<NSString *>*) textArray{
    
    if([textArray count] != 3){
        NSLog(@"Due to fixed size of the asset this producer function only supports dialog/array with 3 lines/elements");
    }
    
    NSMutableArray *dialogueContents = [[NSMutableArray alloc] init];
    if([foundPlayers count] > 0 ){
        
        int offset = [self ProduceThreeLinesOfTextForDialog:dialogueContents position:&position textArray:textArray];
        
        SKSpriteNode* dialog = [self ProduceDialogWithSize: CGSizeMake(256*1.8, 128*2) position:CGPointMake(position.x, position.y -offset)];
        [dialogueContents addObject:dialog];
    
        return dialogueContents;
    }
    return nil;
}

+ (SKLabelNode *)ProduceTextWithSize:(int) size position:(CGPoint)position text: (NSString *) text{
    SKLabelNode * label = (SKLabelNode *)[SKLabelNode labelNodeWithText:text];
    label.fontName =@"Helvetica Neue UltraLight";
    label.alpha = 1;
    
    label.fontColor = [UIColor blackColor];
    label.fontSize = size;
    label.position = position;
    label.zPosition = 1;
    return label;
}

+ (CGPoint)GetMovementControlOffset: (SKView*) view{
    
    return CGPointMake(- view.bounds.size.width / 4 , - view.bounds.size.height / 4);
}
@end
