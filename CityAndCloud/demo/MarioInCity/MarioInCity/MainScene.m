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
#define city_background_width 1070

@implementation MainScene
{
    City *city1, *city2;
    CGSize citySize;
    NSTimer *timer;
    Cloud *cloud1, *cloud2, *cloud3;
    NSMutableArray *blocks;
    
    CGFloat marioRunSpeed;
    
    LampPost *lamppost1;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat statusNavigationBarheight = [UIApplication sharedApplication].statusBarFrame.size.height +self.navigationController.navigationBar.bounds.size.height;
    
    self.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - statusNavigationBarheight);
    
    [self addCity];
    [self addClouds];
    [self addLamppost];
    
    marioRunSpeed = 3.0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(gameloop)
                                           userInfo:nil
                                            repeats:true];
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
    
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:2];
    UIImageView *lpImageView = [[UIImageView alloc] initWithFrame:self.view.bounds] ;
    
    for (int i = 1; i < 3; i++) {
        NSString *fileName = [NSString stringWithFormat:@"lamppost%d", i];
        [images addObject:[UIImage imageNamed:fileName]];
    }
    
    lpImageView.animationImages = images;
    lpImageView.animationDuration = 1;
    lpImageView.animationRepeatCount = 0;
    [lpImageView startAnimating];
    
    lamppost1 = [[LampPost alloc] initWithName:@"lamppost1"
                                       ownView: lpImageView
                                       inScene:self];
    lamppost1.speed = - 3.0;
    
    lamppost1.view.frame = CGRectMake(300, 230, 80, 80);


    [self addSprites:lamppost1];

    
    
}



-(void) gameloop {
    [self moveCityBackAtSpeed:marioRunSpeed];
    
    for (Sprite *sprite in self.sprites.allValues) {
        [sprite animate];
    }
    
    
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
    
    
    
}


@end
