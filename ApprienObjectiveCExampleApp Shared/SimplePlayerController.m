//
//  SimplePlayerController.m
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 22.3.2021.
//
#import "SimplePlayerController.h"
#import <Foundation/Foundation.h>
@implementation SimplePlayerController : NSObject
    
#if TARGET_OS_OSX
// Mouse-based event handling
#import <curl/curl.h>
+ (void)UpdateInput: (LivingThing*) livingThing{

}

- (void)mouseDown:(NSEvent *)event {
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];

    [self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor greenColor]];
}

- (void)mouseDragged:(NSEvent *)event {
    [self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor blueColor]];
}

- (void)mouseUp:(NSEvent *)event {
    [self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor redColor]];
}
- (void)keyDown:(NSEvent *)event {
    [self handleKeyEvent:event keyDown:YES];
}

- (void)keyUp:(NSEvent *)event {
    [self handleKeyEvent:event keyDown:NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];

    for (UITouch *t in touches) {
        let touch = t
        let touchLocation = touch.locationInNode(self)
        let targetNode = nodeAtPoint(touchLocation) as! SKSpriteNode
        if(targetNode.name == @""){
            
        }
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


- (void)handleKeyEvent:(NSEvent *)event keyDown:(BOOL)downOrUp {
    // First check the arrow keys since they are on the numeric keypad.
    if ([event modifierFlags] & NSNumericPadKeyMask) { // arrow keys have this mask
        NSString *theArrow = [event charactersIgnoringModifiers];
        unichar keyChar = 0;
        if ([theArrow length] == 1) {
            keyChar = [theArrow characterAtIndex:0];
            switch (keyChar) {
                case NSUpArrowFunctionKey:
                    self.defaultPlayer.moveForward = downOrUp;
                    break;
                case NSLeftArrowFunctionKey:
                    self.defaultPlayer.moveLeft = downOrUp;
                    break;
                case NSRightArrowFunctionKey:
                    self.defaultPlayer.moveRight = downOrUp;
                    break;
                case NSDownArrowFunctionKey:
                    self.defaultPlayer.moveBack = downOrUp;
                    break;
            }
        }
    }

    // Now check the rest of the keyboard
    NSString *characters = [event characters];
    for (int s = 0; s<[characters length]; s++) {
        unichar character = [characters characterAtIndex:s];
        switch (character) {
            case 'w':
                self.defaultPlayer.moveForward = downOrUp;
                break;
            case 'a':
                self.defaultPlayer.moveLeft = downOrUp;
                break;
            case 'd':
                self.defaultPlayer.moveRight = downOrUp;
                break;
            case 's':
                self.defaultPlayer.moveBack = downOrUp;
                break;
            case ' ':
                self.defaultPlayer.fireAction = downOrUp;
                break;
        }
    }
}
#endif
   

@end

