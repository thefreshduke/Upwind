//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene {
    CCLabelTTF *_instructionLabel;
    CCPhysicsNode *_physicsNode;
    NSTimer * timer;
    BOOL touching;
    float timeSinceTouch;
    float playerSpeed;
    CCNode *_player;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    touching = false;
    timeSinceTouch = 0;
    playerSpeed = 3.5;
}

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    #define screenWidth [[CCDirector sharedDirector] viewSize].width
    
    touching = true;
    
//    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    gesture.minimumPressDuration = 0.1;
//    gesture.allowableMovement = screenWidth * 2;
//    [self addGestureRecognizer:gesture];

    _instructionLabel.string = [NSString stringWithFormat:@"Release to stop as close to the wall as you can"];
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    touching = false;
}

-(void)update:(CCTime)delta {
    if (touching) {
        timeSinceTouch += delta;
    } else {
        timeSinceTouch=0;
    }
    if (timeSinceTouch>0.1) {
        _player.position = ccp(_player.position.x+3, _player.position.y);
    }
}             
             
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player wallCollision:(CCNode *)wall {
    return YES;
}
             
@end
