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
#import "Recap.h"

@implementation Gameplay {
    Recap *_recap;
    Player *_player;
    Wall *_wall;
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_instructionLabel;
    CCLabelTTF *_levelLabel;
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_marginLabel;
    BOOL touching;
    BOOL rulesExplained;
    BOOL collision;
    BOOL oscillatingWall;
    BOOL headWind; // blowing on and off
    BOOL tailWind; // blowing on and off // currently unused?
    BOOL closingWall;
    BOOL jumpingWall; // currently unused
    BOOL secondWall; // a second wall appears behind and chases the player // currently unused
    BOOL backwardsConveyerBelt; // constant movement
    BOOL forwardsConveyerBelt; // constant movement // currently unused?
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    //    NSLog(@"distance: %f", (float) _wall.position.x * 1000000000000000000000000000.00000000000000000000000000 - (float) _player.position.x * 1000000000000000000000000000.00000000000000000000000000);
    //    NSLog(@"error margin: %ld", (long)_errorMargin);
    //    NSLog(@"score: %ld", _score);
    //    NSLog(@"level: %ld", _level);
    
    [self addObserver:self forKeyPath:@"score" options:0 context:NULL];
    [[NSUserDefaults standardUserDefaults] addObserver:self
                                            forKeyPath:@"highScore"
                                               options:0
                                               context:NULL];
    // load high score
    [_recap updateHighScore];
    
    _level = 1;
    _score = 0;
    _errorMargin = 100;
    _playerSpeed = 4;
    _oscillatingWallSpeed = -2;
    rulesExplained = false;
    collision = false;
    oscillatingWall = false;
    headWind = false;
    closingWall = false;
    backwardsConveyerBelt = false;
    _levelLabel.string = [NSString stringWithFormat:@"%ld", (long)_level];
    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)_score];
    _marginLabel.string = [NSString stringWithFormat:@"%ld", (long)_errorMargin];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"score"]) {
        _scoreLabel.string = [NSString stringWithFormat:@"%d", _score];
    } else if ([keyPath isEqualToString:@"highScore"]) {
        [_recap updateHighScore];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"score"];
}

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touching = true;
    if (!rulesExplained) {
        _instructionLabel.string = [NSString stringWithFormat:@"Release to stop"];
        rulesExplained = true;
    }
    else {
        _instructionLabel.string = [NSString stringWithFormat:@" "];
    }
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!collision) {
        touching = false;
        //    NSLog(@"distance: %f", (float) _wall.position.x * 1000000000000000000000000000.00000000000000000000000000 - (float) _player.position.x * 1000000000000000000000000000.00000000000000000000000000);
        
        _instructionLabel.string = [NSString stringWithFormat:@" "];
        
        int distance = (_wall.position.x - _player.position.x) / 4;
        //    NSLog(@"distance: %d", distance);
        _errorMargin -= distance;
        if (_errorMargin > 0 && distance >= 0) {
            _score += _errorMargin * _level;
            _level++;
            //        NSLog(@"level: %ld", (long)_level);
            //        NSLog(@"score: %ld", (long)_score);
            //        NSLog(@"margin: %ld", (long)_errorMargin);
            _levelLabel.string = [NSString stringWithFormat:@"%d", _level];
            _scoreLabel.string = [NSString stringWithFormat:@"%d", _score];
            _marginLabel.string = [NSString stringWithFormat:@"%d", _errorMargin];
            _player.position = ccp(50, 20);
            if (headWind) {
                _playerSpeed = 4;
            }
            if (closingWall) {
                _wall.position = ccp(450, 20);
            }
        }
        else {
            _errorMargin += distance;
            _level--;
            //        NSLog(@"LOST");
            //        NSLog(@"you completed %ld levels", (long)_level);
            //        NSLog(@"your previous margin was %ld", (long)_errorMargin);
            //        NSLog(@"your score is %ld", (long)_score);
            //        CCScene *recapScene = [CCBReader loadAsScene:@"Recap"];
            //        [[CCDirector sharedDirector] presentScene:recapScene];
            //        int pause = 2.0;
            //        [self schedule:@selector(goToRecap:) interval:pause];
//            [self goToRecap];
            [self marginRecap];
        }
    }
}

-(void)update:(CCTime)delta {
    if (_level > 2) {
        oscillatingWall = true;
        headWind = false;
        closingWall = false;
        backwardsConveyerBelt = false;
    }
    if (_level > 4) {
        oscillatingWall = false;
        headWind = true;
        closingWall = false;
        backwardsConveyerBelt = false;
    }
    if (_level > 6) {
        oscillatingWall = false;
        headWind = false;
        closingWall = true;
        backwardsConveyerBelt = false;
    }
    if (_level > 8) {
        oscillatingWall = false;
        headWind = false;
        closingWall = false;
        backwardsConveyerBelt = true;
    }
    if (_level > 10) {
        oscillatingWall = true;
        headWind = false;
        closingWall = false;
        backwardsConveyerBelt = true;
    }
    if (_level > 12) {
        oscillatingWall = false;
        headWind = false;
        closingWall = true;
        backwardsConveyerBelt = true;
    }
    if (_level > 14) {
        oscillatingWall = true;
        headWind = true;
        closingWall = false;
        backwardsConveyerBelt = false;
    }
    if (oscillatingWall) {
        if (_wall.position.x >= 470) {
            _oscillatingWallSpeed = -2;
        }
        if (_wall.position.x <= 430) {
            _oscillatingWallSpeed = 2;
        }
        _wall.position = ccp(_wall.position.x + _oscillatingWallSpeed, _wall.position.y);
    }
    if (headWind) {
        long i = arc4random_uniform(20);
        if (i < 15) {
            _playerSpeed = 1;
        }
        if (i == 19) {
            //            NSLog(@"i: %ld and player.position: %f", (long) i, _player.position.x);
            _playerSpeed = 4;
        }
    }
    if (closingWall) {
        _wall.position = ccp(_wall.position.x - 2, _wall.position.y);
    }
    if (backwardsConveyerBelt) {
        _player.position = ccp(_player.position.x - 2, _player.position.y);
    }
    if (touching) {
        _player.position = ccp(_player.position.x + _playerSpeed, _player.position.y);
        //randomize anti-wind effect
    }
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player wallCollision:(CCNode *)wall {
    collision = true;
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/Explosion.caf"];
    CCSprite *playerExplosion = (CCSprite *)[CCBReader load:@"Explosion"];
    playerExplosion.position = ccp(player.position.x - 20, player.position.y + 20);
    [player.parent addChild:playerExplosion];
    [player removeFromParent];
    //    touching = false;
    int pause = 1.0;
    //    [self schedule:@selector(explosionRecap:) interval:pause];
    [self scheduleOnce:@selector(explosionRecap) delay:pause];
    //no crash... needs to cancel touch
    //doesn't transition to recap until player releases?
    return YES;
}

//- (void)goToRecap {
//    CCScene *recapScene = [CCBReader loadAsScene:@"Recap"];
//    CCTransition *transition = [CCTransition transitionFadeWithDuration:1.0f];
//    //    [recapScene setMessage:message score:self.score];
//    [[CCDirector sharedDirector] presentScene:recapScene withTransition:transition];
//}

- (void)goToRecap:(NSString*)message {
    Recap *recapScene = (Recap*)[CCBReader load:@"Recap"];
    [recapScene setMessage:message level:_level score:_score];
    CCScene *newScene = [CCScene node];
    [newScene addChild:recapScene];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:1.0f];
    [[CCDirector sharedDirector] presentScene:newScene withTransition:transition];
}

- (void)explosionRecap {
    [self goToRecap:@"You blew up!"];
}

- (void)marginRecap {
    [self goToRecap:@"Out of margin!"];
}

//- (void)endGameWithMessage:(NSString*)message {
//    CCLOG(@"%@",message);
//    NSNumber *highScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"];
//    if (self.score > [highScore intValue]) {
//        // new high score!
//        highScore = [NSNumber numberWithInt:self.score];
//        [[NSUserDefaults standardUserDefaults] setObject:highScore forKey:@"highScore"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//    GameEnd *gameEndPopover = (GameEnd *)[CCBReader load:@"GameEnd"];
//    gameEndPopover.positionType = CCPositionTypeNormalized;
//    gameEndPopover.position = ccp(0.5, 0.5);
//    gameEndPopover.zOrder = INT_MAX;
//    [gameEndPopover setMessage:message score:self.score];
//    [self addChild:gameEndPopover];
//}

@end
