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
    CCButton *_playButton;
}

- (void)play {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/Explosion.caf"];
    self.userInteractionEnabled = false; // needed?
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
//    playerExplosion.position = ccp(_playButton.position.x, _playButton.position.y); //?
//    [_playButton.parent addChild:playerExplosion];
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
