//
//  Explosion.m
//  Upwind
//
//  Created by Scotty Shaw on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Explosion.h"

@implementation Explosion

- (void)didLoadFromCCB
{
    // generate a random number between 0.0 and 2.0
//    float delay = (arc4random() % 2000) / 1000.f;
    // call method to start animation after random delay
//    [self performSelector:@selector(startBlinkAndJump) withObject:nil afterDelay:delay];
//    [self performSelector:@selector(explode) withObject:nil];
}

- (void)explode
{
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = self.animationManager;
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:@"Explosion"];
}

@end
