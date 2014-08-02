//
//  Gameplay.m
//  Upwind
//
//  Created by Scotty Shaw on 8/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Player.h"
#import "Wall.h"

@implementation Gameplay {
    Player *_player;
    Wall *_wall;
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_instructionLabel;
    CCLabelTTF *_levelLabel;
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_marginLabel;
    BOOL touching;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    //    NSLog(@"distance: %f", (float) _wall.position.x * 1000000000000000000000000000.00000000000000000000000000 - (float) _player.position.x * 1000000000000000000000000000.00000000000000000000000000);
//    NSLog(@"error margin: %ld", (long)_errorMargin);
//    NSLog(@"score: %ld", _score);
//    NSLog(@"level: %ld", _level);
}

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touching = true;
    _instructionLabel.string = [NSString stringWithFormat:@"Release to stop"];
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    touching = false;
    //    NSLog(@"distance: %f", (float) _wall.position.x * 1000000000000000000000000000.00000000000000000000000000 - (float) _player.position.x * 1000000000000000000000000000.00000000000000000000000000);
    int distance = (_wall.position.x - _player.position.x) / 4;
    NSLog(@"distance: %d", distance);
    _errorMargin += distance;
    if (_errorMargin < 100 && distance >= 0) {
        _level++;
        _score += (100 -_errorMargin) * _level;
        NSLog(@"level: %ld", (long)_level);
        NSLog(@"score: %ld", (long)_score);
        NSLog(@"margin: %ld", (long)(100 - _errorMargin));
        _levelLabel.string = [NSString stringWithFormat:@"%d", _level];
        _scoreLabel.string = [NSString stringWithFormat:@"%d", _score];
        _marginLabel.string = [NSString stringWithFormat:@"%d", (100 - _errorMargin)];
        _player.position = ccp(50, 20);
    }
    else {
        _errorMargin -= distance;
        NSLog(@"LOST");
        NSLog(@"you finished on level %ld", (long)_level);
        NSLog(@"your previous margin was %ld", (long)_errorMargin);
        NSLog(@"your score is %ld", (long)_score);
        CCScene *recapScene = [CCBReader loadAsScene:@"Recap"];
        [[CCDirector sharedDirector] presentScene:recapScene];
    }
}

-(void)update:(CCTime)delta {
    if (touching) {
        _player.position = ccp(_player.position.x + 4, _player.position.y);
        //randomize anti-wind effect
        //calculate errorMargin = distancePlayerToWall
        //score += 1000 - errorMargin (score multipliers, streak bonuses)
        //if errorMargin > 0 play another round
        //else go to recap for stats
    }
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player wallCollision:(CCNode *)wall {
    [player removeFromParent];
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/Explosion.caf"];
    CCScene *recapScene = [CCBReader loadAsScene:@"Recap"];
    [[CCDirector sharedDirector] presentScene:recapScene];
    return YES;
}

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
