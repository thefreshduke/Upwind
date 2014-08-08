//
//  Explosion.m
//  Upwind
//
//  Created by Scotty Shaw on 8/8/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Explosion.h"

@implementation Explosion

- (void)explode
{
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = self.animationManager;
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:@"Explosion"];
}

@end
