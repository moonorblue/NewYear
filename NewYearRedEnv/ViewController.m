

//
//  ViewController.m
//  NewYearRedEnv
//
//  Created by KaeJer Cho on 2015/2/18.
//  Copyright (c) 2015年 KaeJer Cho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end
NSMutableArray *imgArray;
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
  [self showHeadViewWithArray:imgArray];
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
        [[NSString stringWithFormat:@"%d", x] stringByAppendingString:@".png"];
    UIImage *img = [UIImage imageNamed:str];
    [imgArray addObject:img];
  }
}

- (void)showHeadViewWithArray:(NSMutableArray *)ary {
  for (id i in ary) {
    self.headView.image = i;
  }
}
@end
