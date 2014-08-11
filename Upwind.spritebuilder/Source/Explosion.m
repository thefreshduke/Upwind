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
    CCAnimationManager* animationManager = self.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Explosion"];
}

@end
