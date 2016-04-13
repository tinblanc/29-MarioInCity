//
//  SuperMario.m
//  MarioInCity
//
//  Created by Tin Blanc on 4/11/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "SuperMario.h"
#import "FireBall.h"

@implementation SuperMario
{
    BOOL isRunning, isJumping;
    CGFloat jumpVelocity, fallAcceleration; // vận tốc , tốc độ rơi
    CGFloat y;
    
    int fireBallCount;
    
}


// Cấu hình nhân vật
-(instancetype) initWithName:(NSString *)name inScene:(Scene *)scene {
    self = [super initWithName:name inScene:scene];
    UIImageView* marioView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 75)];
    marioView.userInteractionEnabled = true; // tương tác với người dùng
    marioView.multipleTouchEnabled = true; // đa chạm
    
    marioView.animationImages = @[[UIImage imageNamed:@"mario1.png"],
                                  [UIImage imageNamed:@"mario2.png"],
                                  [UIImage imageNamed:@"mario3.png"],
                                  [UIImage imageNamed:@"mario4.png"],
                                  [UIImage imageNamed:@"mario5.png"],
                                  [UIImage imageNamed:@"mario6.png"],
                                  [UIImage imageNamed:@"mario7.png"],
                                  [UIImage imageNamed:@"mario8.png"],
                                  [UIImage imageNamed:@"mario9.png"],
                                  [UIImage imageNamed:@"mario10.png"],
                                  [UIImage imageNamed:@"mario11.png"],
                                  [UIImage imageNamed:@"mario12.png"]
                                  ];
    marioView.animationDuration = 0.8;
    [marioView startAnimating];
    self.view = marioView;
    
    fireBallCount = 0;
    self.fireBallCanUse = 7;
    
    [self applyGestureRecognizer];
    self.alive = true;
    
    return self;
}



// Áp dụng nhận dạng cử chỉ Tap
-(void) applyGestureRecognizer {
    [self.scene.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(startJump)]];
    
    
    UISwipeGestureRecognizer* swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(fire)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight; // chọn hướng
    [self.scene.view addGestureRecognizer:swipeRight];
    
    
}

// Khởi tạo vận tốc và gia tốc ban đầu
-(void) startJump {
    if (!isJumping) {
        isJumping = true;
        jumpVelocity = -12.4;
        fallAcceleration = 0.6; // tốc độ rơi
        y = self.view.center.y;
    }
}

// Tính toán tọa độ tâm nhân vật Mario
-(void) jump {
    if (!isJumping) return;
    
    y +=jumpVelocity;
    jumpVelocity += fallAcceleration ;
    
    if (y > self.y0) { // check rơi xuống mặt đất
        y = self.y0;
        isJumping = false;
        
    }
    self.view.center = CGPointMake(self.view.center.x, y);
}

-(void) fire {
    fireBallCount++;
    
    
    if (self.fireBallCanUse <= 0) {
        return;
    }
    
    FireBall *fireball = [[FireBall alloc] initWithName:[NSString stringWithFormat:@"fireball%d", fireBallCount]
                                                inScene:self.scene];
    
    fireball.view.center = CGPointMake(self.view.center.x + 50 , self.view.center.y);
    fireball.fromSprite = self; // Xuất phát từ đối tượng mario
    [self.scene addSprites:fireball];
    [fireball startFly:7.0];
    
    

    [self.scene removeSpriteByName:[NSString stringWithFormat:@"fireBallCount%d",self.fireBallCanUse]];
    NSLog(@"%@", [NSString stringWithFormat:@"fireBallCount%d",self.fireBallCanUse] );
    
    self.fireBallCanUse--;
}


-(void) getKilled {
    UIImageView* view = (UIImageView*) self.view;
    [view stopAnimating];
    self.alive = false;
    
}

// Hoạt hình
-(void) animate {
    if (!self.alive) return;
    [self jump];
}



@end
