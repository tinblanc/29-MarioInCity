//
//  Scene.m
//  MarioInCity
//
//  Created by Tin Blanc on 4/9/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "Scene.h"

@implementation Scene

-(void) loadView {
    [super loadView];
    self.sprites = [NSMutableDictionary new];
}

-(void) viewDidLoad {
    [super viewDidLoad];
}

-(void) addSprites:(Sprite *)sprite {
    [self.sprites setObject:sprite
                     forKey: sprite.name];
    [self.view addSubview:sprite.view];
}

-(void) removeSprite:(Sprite *)sprite {
    [self.sprites removeObjectForKey:sprite.name];
    [sprite.view removeFromSuperview];
}

-(void) removeSpriteByName:(NSString *)spriteName {
    UIView* removeView = self.sprites[spriteName];
    [removeView removeFromSuperview];
    [self.sprites removeObjectForKey:spriteName];
}

@end
