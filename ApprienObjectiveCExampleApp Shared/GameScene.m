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
}
@synthesize levelIndex;
int levelIndexTemp;
- (void)setlevelIndex: (int )levelIndexIn{
    levelIndexTemp = levelIndexIn;
    levelIndex = levelIndexIn;
}

- (int)getlevelIndex{
    return levelIndex;
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

- (void)setUpScene: (int) index{
    if(index == 0){
        // Get label node from scene and store it for use later
        _label = (SKLabelNode *)[self childNodeWithName:@"//IAPManText"];
        _label.alpha = 0.0;
        [_label runAction:[SKAction fadeInWithDuration:2.0]];

        // Create shape node to use during mouse interaction
        CGFloat w = (self.size.width + self.size.height) * 0.05;
        _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];

        _spinnyNode.lineWidth = 4.0;
        [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
        [_spinnyNode runAction:[SKAction sequence:@[
            [SKAction waitForDuration:0.5],
            [SKAction fadeOutWithDuration:0.5],
            [SKAction removeFromParent],
        ]]];
        SKSpriteNode *player = [SKSpriteNode spriteNodeWithImageNamed:@"Player"];

        player.size = CGSizeMake(player.size.width*6, player.size.height*6);
        player.position = CGPointMake(20,20);
        [self addChild: player];
        
        #if TARGET_OS_WATCH
            // For watch we just periodically create one of these and let it spin
            // For other platforms we let user touch/mouse events create these
            _spinnyNode.position = CGPointMake(0.0, 0.0);
            _spinnyNode.strokeColor = [SKColor redColor];
            [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[
                [SKAction waitForDuration:2.0],
                [SKAction runBlock:^{
                    [self addChild:[self->_spinnyNode copy]];
                }]
            ]]]];
        #endif
    }
    else{
        SKSpriteNode *player = [SKSpriteNode spriteNodeWithImageNamed:@"Player"];
        player.size = CGSizeMake(player.size.width*6, player.size.height*6);
        player.position = CGPointMake(20,20);
        [self addChild: player];
    }
}


- (void)setUpLevel {

    // Create shape node to use during mouse interaction
    CGFloat w = (self.size.width + self.size.height) * 0.05;
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];

    _spinnyNode.lineWidth = 4.0;
    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
        [SKAction waitForDuration:0.5],
        [SKAction fadeOutWithDuration:0.5],
        [SKAction removeFromParent],
    ]]];
    SKSpriteNode *player = [SKSpriteNode spriteNodeWithImageNamed:@"Player"];

    player.size = CGSizeMake(player.size.width*6, player.size.height*6);
    player.position = CGPointMake(10,10);
    [self addChild: player];
    
    
#if TARGET_OS_WATCH
    // For watch we just periodically create one of these and let it spin
    // For other platforms we let user touch/mouse events create these
    _spinnyNode.position = CGPointMake(0.0, 0.0);
    _spinnyNode.strokeColor = [SKColor redColor];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[
        [SKAction waitForDuration:2.0],
        [SKAction runBlock:^{
            [self addChild:[self->_spinnyNode copy]];
        }]
    ]]]];
#endif
}

#if TARGET_OS_WATCH
- (void)sceneDidLoad {
    [self setUpScene];
}
#else
- (void)didMoveToView:(SKView *)view {
    [self setUpScene: levelIndex];
}
#endif

- (void)makeSpinnyAtPoint:(CGPoint)pos color:(SKColor *)color {
    SKShapeNode *spinny = [_spinnyNode copy];
    spinny.position = pos;
    spinny.strokeColor = color;
    [self addChild:spinny];
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];

    for (UITouch *t in touches) {
        [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor greenColor]];
        
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor blueColor]];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor redColor]];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor redColor]];
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
