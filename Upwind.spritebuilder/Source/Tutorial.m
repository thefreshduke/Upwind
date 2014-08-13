//
//  Tutorial.m
//  Upwind
//
//  Created by Scotty Shaw on 8/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tutorial.h"
#import "Gameplay.h"
#import "Player.h"
#import "Wall.h"

@implementation Tutorial {
    Player *_player;
    Wall *_wall;
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_instructionLabel;
    CCLabelTTF *_deathLabel;
    CCLabelTTF *_performanceLabel;
    BOOL touching;
    BOOL collision;
    BOOL waiting;
    //    BOOL highScore;
    //    BOOL perfect;
    //    BOOL oscillatingWall;
    //    BOOL headWind; // blowing on and off
    //    BOOL tailWind; // blowing on and off // currently unused?
    //    BOOL closingWall;
    //    BOOL jumpingWall; // currently unused
    //    BOOL secondWall; // a second wall appears behind and chases the player // currently unused
    //    BOOL backwardsConveyerBelt; // constant movement
    //    BOOL forwardsConveyerBelt; // constant movement // currently unused?
    //    int perfectStreak;
}

- (void)didLoadFromCCB {
    
    self.userInteractionEnabled = true;
    _physicsNode.collisionDelegate = self;
    
    _playerSpeed = 4;
    collision = false;
    
    waiting = false;
    
    _instructionLabel.string = [NSString stringWithFormat:@"Hold to move"];
}

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touching = true;
    waiting = false;
    _instructionLabel.string = [NSString stringWithFormat:@"Release to stop"];
    [self scheduleBlock:^(CCTimer *timer) {
        [_instructionLabel removeFromParent];
    } delay:1.f];
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialCompleted"]) {
    if (!collision) {
        
        touching = false;
        int distance = (_wall.position.x - _player.position.x) / 4;
        if (distance <= 10) {
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"tutorialCompleted"];
        }
        
        if (distance == 0) {
            _performanceLabel.string = [NSString stringWithFormat:@"PERFECT"];
        }
        else if (distance > 0 && distance <= 2) {
            _performanceLabel.string = [NSString stringWithFormat:@"AWESOME"];
        }
        else if (distance > 2 && distance <= 5) {
            _performanceLabel.string = [NSString stringWithFormat:@"GREAT"];
        }
        else if (distance > 5 && distance <= 10) {
            _performanceLabel.string = [NSString stringWithFormat:@"GOOD"];
        }
        else if (distance > 10 && distance <= 20) {
            _performanceLabel.string = [NSString stringWithFormat:@"OKAY"];
        }
        else {
            _performanceLabel.string = [NSString stringWithFormat:@"GO TO THE WALL"];
            //play X buzzer wrong on game show sound effect?
        }
        
        [[self animationManager] runAnimationsForSequenceNamed:@"Default Timeline"];
        
        //            NSNumber* margin = [NSNumber numberWithInt: self.errorMargin];
        //            NSNumber* ifPerfect = [NSNumber numberWithBool: perfect];
        //            NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: margin, @"errorMargin", ifPerfect, @"perfect", nil];
        //            [MGWU logEvent:@"levelComplete" withParams:params];
        // syntax correct?
        
        _player.position = ccp(0, 17);
    }
}

-(void)update:(CCTime)delta {
    if (touching) {
        _player.position = ccp(_player.position.x + _playerSpeed, _player.position.y);
    }
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player wallCollision:(CCNode *)wall {
    collision = true;
    self.userInteractionEnabled = false;
    //    [_instructionLabel removeFromParent];
//    [_obstacleLabel removeFromParent];
//    [_infoLabel1 removeFromParent];
//    [_infoLabel2 removeFromParent];
//    [_infoLabel3 removeFromParent];
//    [_scoreLabel removeFromParent];
//    [_marginLabel removeFromParent];
//    [_performanceLabel removeFromParent];
    _deathLabel.string = [NSString stringWithFormat:@"You ran into the wall!"];
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/Explosion.caf"];
    CCSprite *playerExplosion = (CCSprite *)[CCBReader load:@"Explosion"];
    playerExplosion.position = ccp(player.position.x - 20, player.position.y + 20);
    [player.parent addChild:playerExplosion];
//    [player removeFromParent];
//    [wall removeFromParent];
    _player.position = ccp(0, 17);
    [self scheduleBlock:^(CCTimer *timer) {
        [playerExplosion removeFromParent];
    } delay:0.3];
//    float pause = 0.5;
    //    [playerExplosion removeFromParent];
//    [self scheduleOnce:@selector(goToRecap) delay:pause];
    return YES;
}

@end
