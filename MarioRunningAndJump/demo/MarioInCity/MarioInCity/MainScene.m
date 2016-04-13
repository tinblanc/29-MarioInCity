//
//  MainScene.m
//  MarioInCity
//
//  Created by Tin Blanc on 4/9/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "MainScene.h"
#import "Sprite.h"
#import "City.h"
#import "Cloud.h"
#import "Block.h"
#import "LampPost.h"
#import "SuperMario.h"
#import "FireBall.h"
#define city_background_width 1070

@implementation MainScene
{
    SuperMario *mario;
    City *city1, *city2;
    CGSize citySize;
    NSTimer *timer;
    Cloud *cloud1, *cloud2, *cloud3;
    NSMutableArray *blocks;
    
    CGFloat marioRunSpeed;
    
    LampPost *lamppost1;
    
    BOOL alreadyAddBlocks;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    blocks = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat statusNavigationBarheight = [UIApplication sharedApplication].statusBarFrame.size.height +self.navigationController.navigationBar.bounds.size.height;
    
    self.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - statusNavigationBarheight);
    
    [self addCity];
    [self addClouds];
    [self addLamppost];
    [self addMario];
    [self addCountFireBall];
    
    
    marioRunSpeed = 3.0;
    alreadyAddBlocks = false;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(gameloop)
                                           userInfo:nil
                                            repeats:true];
}

#pragma mark - Add

-(void) addMario {
    mario = [[SuperMario alloc] initWithName:@"mario"
                                     inScene:self];
    
    mario.y0 = self.size.height - mario.view.bounds.size.height * 0.5 - 60; // chiều cao
    mario.view.center = CGPointMake(self.size.width * 0.25, mario.y0);
    [self addSprites:mario];
}

-(void) addCity {
    citySize = CGSizeMake(city_background_width, 400);
    UIImage* cityBackground = [UIImage imageNamed:@"city"];
    
    city1 = [[City alloc] initWithName:@"city1"
                               ownView:[[UIImageView alloc] initWithImage:cityBackground]
                               inScene:self];

    city1.view.frame = CGRectMake(0, self.size.height - citySize.height, citySize.width, citySize.height); // Định vị trí nằm ở đâu trong màn hình
    
    
    // Màn hình City 2 
    city2 = [[City alloc] initWithName:@"city2"
                               ownView:[[UIImageView alloc] initWithImage:cityBackground]
                               inScene:self];
    
    city2.view.frame = CGRectMake(citySize.width, self.size.height - citySize.height, citySize.width, citySize.height);
    

    city1.alreadyHaveBlock = false;
    city2.alreadyHaveBlock = false;
    
    [self.view addSubview:city1.view];
    [self.view addSubview:city2.view];
    
}

-(void) addClouds {
    cloud1 = [[Cloud alloc] initWithName:@"cloud1"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud1"]]
                                 inScene:self ];
    cloud1.speed = - 3.5;
    
    cloud2 = [[Cloud alloc] initWithName:@"cloud2"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud2"]]
                                 inScene:self];
    cloud2.speed = - 4.5;
    
    cloud1.view.frame = CGRectMake(20, 15, 100, 100);
    cloud2.view.frame = CGRectMake(150, 3, 70, 80);
    
    [self addSprites:cloud1];
    [self addSprites:cloud2];

}

-(void) addLamppost {
    
    UIImageView *lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)] ;
    
    
    lpImageView.animationImages = @[[UIImage imageNamed:@"lamppost1"],
                                    [UIImage imageNamed:@"lamppost2"]];
    lpImageView.animationDuration = 1;
    lpImageView.animationRepeatCount = 0;
    [lpImageView startAnimating];
    
    lamppost1 = [[LampPost alloc] initWithName:@"lamppost1"
                                       ownView: lpImageView
                                       inScene:self];
    lamppost1.speed = - 3.0;
    
    lamppost1.view.center = CGPointMake(self.size.width * 0.5, self.size.height - mario.view.bounds.size.height * 0.5 - 105);


    [self addSprites:lamppost1];

    
    
}


-(void) addBlocksToCity: (City*) city {
    if (!city.alreadyHaveBlock && !CGRectIntersectsRect(self.view.bounds, city.view.frame)) {
        
        CGFloat averageStep = 250;
        CGFloat previousBlockXCoordinate = 0.0;
        
        
        int index = 0;
        
        while (previousBlockXCoordinate < city_background_width - 100) {
            Block *block = [[Block alloc] initWithName:[NSString stringWithFormat:@"block%d",index]
                                               inScene:self];
            index++;
            
            CGFloat x = previousBlockXCoordinate + averageStep +arc4random_uniform(30);
            block.view.center = CGPointMake(x, city1.view.bounds.size.height - block.view.bounds.size.height + 0.5 - 59);
            [city.view addSubview:block.view];
            [blocks addObject:block.view];
            previousBlockXCoordinate = x;
        }
        city.alreadyHaveBlock = true;
    }
}


-(void) addCountFireBall {
    
    int x1, y1;
    x1= 400;
    y1 = 40;
    for (int i = 1 ; i <= mario.fireBallCanUse; i++) {
        FireBall *fireball = [[FireBall alloc] initWithName:[NSString stringWithFormat:@"fireBallCount%d", i]
                                                    inScene:self];
        
        fireball.view.frame = CGRectMake(x1, y1, 30, 30);
        x1 += 30;
        [self addSprites:fireball];
    }
    
    

}

#pragma mark - Game Loop

-(void) gameloop {
    [self moveCityBackAtSpeed:marioRunSpeed];
    
    for (Sprite *sprite in self.sprites.allValues) {
        [sprite animate];
    }
    
    
    [self checkCollisionBetweenMarioAndBlocks];
    
    
}

-(void) moveCityBackAtSpeed: (CGFloat) speed {
    city1.view.center = CGPointMake(city1.view.center.x - speed, city1.view.center.y);
    city2.view.center = CGPointMake(city2.view.center.x - speed, city1.view.center.y);
    
    // Kiểm tra City1 vượt qua màn hình bên trái
    if (city1.view.frame.origin.x + citySize.width < 0.0) {
        
        city1.view.frame = CGRectMake(city2.view.frame.origin.x +citySize.width,
                                      city1.view.frame.origin.y,
                                      citySize.width,
                                      citySize.height);
    }
    
    if (city2.view.frame.origin.x +citySize.width < 0.0) {
        city2.view.frame = CGRectMake(city1.view.frame.origin.x + citySize.width,
                                      city1.view.frame.origin.y,
                                      citySize.width,
                                      citySize.height);
    }
    
    [self addBlocksToCity:city1];
    [self addBlocksToCity:city2];
    
}


-(BOOL) checkCollisionBetweenMarioAndBlocks {
    if (!mario.alive) return false;
    
    for (int i = 0; i < blocks.count; i++) {
        UIView* block  = (UIView*)blocks[i];
        CGRect blockRect = [block.superview convertRect: block.frame
                                                 toView: self.view];
        
        if (CGRectIntersectsRect(blockRect, CGRectInset(mario.view.frame, 10 , 0))){

            [mario getKilled];
            marioRunSpeed = 0.0;
            [self gameOver];
            return true;
        }
        
    }
    return false; ;
}


-(void) gameOver {
    UIImageView* dialog = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameover"]];
    
    dialog.center = CGPointMake(self.size.width * 0.5, -dialog.bounds.size.height * 0.5);
    
    [self.view addSubview:dialog];
    
    [UIView animateWithDuration:2 animations:^{
        dialog.center = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    } completion:^(BOOL finished) {
        
    }];
}

@end
