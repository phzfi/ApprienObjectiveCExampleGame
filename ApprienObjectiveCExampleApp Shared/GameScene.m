//
//  GameScene.m
//  ApprienObjectiveCExampleApp Shared
//
//  Created by phz on 18.3.2021.
//

#import "GameScene.h"
#import "GameViewController.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    GameManager *_gameManager;
}

- (void)SetGameManager: (GameManager*)gameManager{
    _gameManager = gameManager;
}

+ (GameScene *)newGameScene {
    // Load 'GameScene.sks' as an GameScene.
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    if (!scene) {
        NSLog(@"Failed to load GameScene.sks");
        abort();
    }

    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;

    return scene;
}

-(void)update:(NSTimeInterval)currentTime{
    NSLog(@"Failed to load ");
    [_gameManager update];
}

+ (GameScene *)loadGameScene: (NSString *) sceneName{
    // Load 'GameScene.sks' as an GameScene.
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:sceneName];
    
    if (!scene) {
        NSLog(@"Failed to load %@", sceneName);
        abort();
    }
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;

    return scene;
}

#if TARGET_OS_WATCH
- (void)sceneDidLoad {
    
}
#else
- (void)didMoveToView:(SKView *)view {
    
}
#endif

- (void)makeSpinnyAtPoint:(CGPoint)pos color:(SKColor *)color {
    SKShapeNode *spinny = [_spinnyNode copy];
    spinny.position = pos;
    spinny.strokeColor = color;
    [self addChild:spinny];
}



#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];

    for (UITouch *t in touches) {
 //       [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor greenColor]];
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
    //    [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor blueColor]];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
   //     [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor redColor]];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
   //     [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor redColor]];
    }
}
#endif

#if TARGET_OS_OSX
// Mouse-based event handling

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

#endif

@end
