//
//  Gameplay.h
//  Upwind
//
//  Created by Scotty Shaw on 8/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Gameplay : CCNode <CCPhysicsCollisionDelegate>

@property (nonatomic, assign) NSInteger errorMargin; // = 100
//@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, assign) NSInteger score; // = 0
@property (nonatomic, assign) NSInteger level; // = 0

@end
