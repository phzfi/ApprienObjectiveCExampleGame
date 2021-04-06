//
//  InputController.h
//  ApprienObjectiveCExampleApp iOS
//
//  Created by phz on 22.3.2021.
//
#import <Foundation/Foundation.h>
#import "LivingThing.h"
@interface SimplePlayerController : NSObject
+ (void)UpdateInput: (NSObject<LivingThing> *) livingThing;
//- (void)keyDown:(NSEvent *)event;
//- (void)keyUp:(NSEvent *)event;
@end
