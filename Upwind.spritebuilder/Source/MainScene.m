//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Gameplay.h"
#import "Player.h"
#import "Wall.h"

@implementation MainScene {
    Gameplay *_game;
    Player *_player;
    Wall *_wall;
    CCPhysicsNode *_physicsNode;
}

- (void)didLoadFromCCB {
//    [_game addObserver:self forKeyPath:@"score" options:0 context:NULL];
//    [[NSUserDefaults standardUserDefaults] addObserver:self
//                                            forKeyPath:@"highScore"
//                                               options:0
//                                               context:NULL];
//    // load high score
//    [self updateHighScore];
}

//- (void)updateHighScore {
//    NSNumber *newHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"];
//    if (newHighScore) {
//        _highScoreLabel.string = [NSString stringWithFormat:@"%d", [newHighScore intValue]];
//    }
//}

- (void)play {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/Explosion.caf"];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

// how to make play button explode properly?

//- (void)play {
//    [self explode];
//}
//
//- (void)explode {
//    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/Explosion.caf"];
//    CCSprite *playerExplosion = (CCSprite *)[CCBReader load:@"Explosion"];
//    playerExplosion.position = ccp(_player.position.x - 20, _player.position.y + 20);
//    [_player.parent addChild:playerExplosion];
//    float pause = 0.5;
//    [self scheduleOnce:@selector(goToGame) delay:pause];
//}
//
//- (void)goToGame {
//    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
//    [[CCDirector sharedDirector] replaceScene:gameplayScene];
//}

- (void)moreGames {
    [MGWU displayCrossPromo];
}

- (void)aboutMe {
    [MGWU displayAboutPage];
}

@end
