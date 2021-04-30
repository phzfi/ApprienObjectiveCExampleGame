//
//  InputController.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 31.3.2021.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "InputController.h"
@implementation InputController {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}
#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];

    for (UITouch *t in touches) {
        
   }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        
 }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        
   }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        
   }
}


#endif
@end
