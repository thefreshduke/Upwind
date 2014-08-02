//
//  Recap.m
//  Upwind
//
//  Created by Scotty Shaw on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Recap.h"
#import "Wall.h"
#import "Gameplay.h"

@implementation Recap {
    Wall *_wall;
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_instructionLabel;
}

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)menu {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
