//
//  Scene.h
//  MarioInCity
//
//  Created by Tin Blanc on 4/9/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sprite.h"

@class Sprite;

@interface Scene : UIViewController
@property(nonatomic,strong) NSMutableDictionary *sprites;
@property(nonatomic,assign) CGSize size;

-(void) addSprites: (Sprite*) sprite;

-(void) removeSprite: (Sprite*) sprite;

-(void) removeSpriteByName: (NSString*) spriteName;

@end
