//
//  Wall.m
//  Upwind
//
//  Created by Scotty Shaw on 8/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Wall.h"

@implementation Wall

- (void)didLoadFromCCB
{
    self.position = ccp(530, 20);
    self.physicsBody.collisionType = @"wallCollision";
}

@end
