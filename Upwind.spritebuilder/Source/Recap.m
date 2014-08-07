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
    CCLabelTTF *_deathLabel;
    CCLabelTTF *_highScoreLabel;
    CCLabelTTF *_levelLabel;
    CCLabelTTF *_scoreLabel;
}

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)setMessage:(NSString *)message level:(NSInteger)level score:(NSInteger)score {
    _deathLabel.string = message;
    _levelLabel.string = [NSString stringWithFormat:@"%d", level];
    _scoreLabel.string = [NSString stringWithFormat:@"%d", score];
}

- (void)didLoadFromCCB {
    _highScoreLabel.string = [NSString stringWithFormat:@"High Score: 250209"];
}

@end
