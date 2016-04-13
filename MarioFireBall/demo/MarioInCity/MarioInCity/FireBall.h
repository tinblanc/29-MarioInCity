//
//  FireBall.h
//  MarioInCity
//
//  Created by Tin Blanc on 4/12/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "Sprite.h"

@interface FireBall : Sprite
@property (nonatomic, assign) BOOL isFlying;
@property (nonatomic,assign) CGFloat speed;
@property (nonatomic, weak) Sprite* fromSprite;

-(void) startFly: (CGFloat) speed;
@end
