//
//  WelcomeViewController.h
//  lq0578
//
//  Created by 汤维炜 on 16/2/28.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WelcomeViewControllerDelegate  <NSObject>

- (void)closeWelcomeGuiderUI;

@end

@interface WelcomeViewController : UIViewController

@property (nonatomic,weak) id<WelcomeViewControllerDelegate>delegate;

@end
