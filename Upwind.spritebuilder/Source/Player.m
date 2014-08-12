//
//  Player.m
//  Upwind
//
//  Created by Scotty Shaw on 8/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Player.h"

@implementation Player

- (void)didLoadFromCCB
{
    self.position = ccp(0, 17);
    self.physicsBody.collisionType = @"playerCollision";
}

@end
