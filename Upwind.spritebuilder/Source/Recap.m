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
    BOOL highScore;
}

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)setMessage:(NSString *)message level:(NSInteger)level score:(NSInteger)score {
    _deathLabel.string = message;
    _levelLabel.string = [NSString stringWithFormat:@"%ld", (long)level];
//    if (!highScore) {
        _scoreLabel.string = [NSString stringWithFormat:@"Your score: %ld", (long)score];
//    } //how to shift between standard "your score/best score" and "YOU GOT A HIGH SCORE"?
}

- (void)didLoadFromCCB {
    highScore = false;
    [self updateHighScore];
}

- (void)updateHighScore {
    NSInteger *newHighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    _highScoreLabel.string = [NSString stringWithFormat:@"BEST SCORE: %d", (int)newHighScore];
}

- (void)moreGames {
    [MGWU displayCrossPromo];
}

- (void)aboutMe {
    [MGWU displayAboutPage];
}

@end
