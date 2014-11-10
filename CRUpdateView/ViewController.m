//
//  ViewController.m
//  CRUpdateView
//
//  Created by Corey Roberts on 11/9/14.
//  Copyright (c) 2014 Corey Roberts. All rights reserved.
//

#import "ViewController.h"
#import "CRUpdateView.h"

@interface ViewController ()

@property (nonatomic, strong) CRUpdateView *updateView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.updateView = [[CRUpdateView alloc] initWithFrame:self.view.frame];
    
    self.updateView.updateTitleString = @"What's New?";
    
    self.updateView.firstUpdateString = @"Fixed some pesky bugs!";
    self.updateView.secondUpdateString = @"Data now syncs to iCloud correctly";
    self.updateView.thirdUpdateString = @"Now optimized for iPhone 6 and 6 Plus";
    
    self.updateView.firstUpdateImage = [UIImage imageNamed:@"CheckboxIcon"];
    self.updateView.secondUpdateImage = [UIImage imageNamed:@"CloudIcon"];
    self.updateView.thirdUpdateImage = [UIImage imageNamed:@"PhoneIcon"];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.updateView display];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
