//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Player.h"
#import "Wall.h"

@implementation MainScene {
    Player *_player;
    Wall *_wall;
    CCPhysicsNode *_physicsNode;
}

//- (void)didLoadFromCCB {
//    [_grid addObserver:self forKeyPath:@"score" options:0 context:NULL];
//    [[NSUserDefaults standardUserDefaults] addObserver:self
//                                            forKeyPath:@"highScore"
//                                               options:0
//                                               context:NULL];
//    // load high score
//    [self updateHighScore];
//}
//
//- (void)updateHighScore {
//    NSNumber *newHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"];
//    if (newHighScore) {
//        _highScoreLabel.string = [NSString stringWithFormat:@"%d", [newHighScore intValue]];
//    }
//}

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
