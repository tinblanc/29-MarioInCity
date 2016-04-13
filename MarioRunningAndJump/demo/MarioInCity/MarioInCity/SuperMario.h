//
//  SuperMario.h
//  MarioInCity
//
//  Created by Tin Blanc on 4/11/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "Sprite.h"

@interface SuperMario : Sprite
@property(nonatomic,assign) BOOL alive;
@property(nonatomic,assign) CGFloat y0;
@property(nonatomic,assign) int fireBallCanUse;

-(void) getKilled;
@end
