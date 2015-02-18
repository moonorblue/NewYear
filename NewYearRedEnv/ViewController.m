

//
//  ViewController.m
//  NewYearRedEnv
//
//  Created by KaeJer Cho on 2015/2/18.
//  Copyright (c) 2015年 KaeJer Cho. All rights reserved.
//
#define INITIAL_DELAY 0.001
#import "ViewController.h"

@interface ViewController ()
@end
NSMutableArray *imgArray;
NSTimer *timer;
NSInteger lastIndex = 0;
int changeCount = 0;
int objCountLimit = 0;
float delay = INITIAL_DELAY;
@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initArray];

  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonClick:(id)sender {
  [self shuffle:imgArray];
  [self runtimer];
  //  objCountLimit = 5 * [imgArray count];
}

- (void)shuffle:(NSMutableArray *)ary {
  NSUInteger count = [ary count];
  for (NSUInteger i = 0; i < count; ++i) {
    NSInteger remainingCount = count - i;
    NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);
    [ary exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
  }
}
- (void)initArray {
  imgArray = [[NSMutableArray alloc] init];
  int x;
  for (x = 1; x <= 10; x++) {
    NSString *str =
        [[NSString stringWithFormat:@"%d", x] stringByAppendingString:@".jpg"];
    UIImage *img = [UIImage imageNamed:str];
    [imgArray addObject:img];
  }
}

- (void)showHeadViewWithArray:(NSMutableArray *)ary {
  NSUInteger count = [ary count];
  if (count == 0) return;
  NSInteger r = arc4random_uniform((u_int32_t)count);
  self.headView.image = [ary objectAtIndex:r];
  lastIndex = r;
}

- (void)runtimer {
  timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)delay
                                           target:self
                                         selector:@selector(timerTriggered:)
                                         userInfo:nil
                                          repeats:NO];
  delay = delay * 1.1;
}
- (void)timerTriggered:(NSTimer *)timer {
  [self showHeadViewWithArray:imgArray];
  //  changeCount++;
  //  NSLog(@"%d",changeCount);
  NSLog(@"%f",delay);
  if (delay >= 0.4) {
    [timer invalidate];
    delay = INITIAL_DELAY;
    if ([imgArray count] > 0) [imgArray removeObjectAtIndex:lastIndex];
  }
  else {
    [timer invalidate];
    [self runtimer];
  }
}
@end
