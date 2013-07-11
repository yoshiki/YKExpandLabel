//
//  SampleViewController.m
//  YKExpandLabelDemo
//
//  Created by Yoshiki Kurihara on 2013/07/11.
//  Copyright (c) 2013年 Yoshiki Kurihara. All rights reserved.
//

#import "SampleViewController.h"
#import "YKExpandLabel.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *text = @"The Foundation framework introduces several paradigms to avoid confusion in common situations, and to introduce a level of consistency across class hierarchies.";
    CGRect frame = CGRectMake(0.0f, 0.0f, 160.0f, 60.0f);
    YKExpandLabel *label = [[YKExpandLabel alloc] initWithFrame:frame numberOfLines:3 moreText:@" More ▾"];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    [label setFullText:text];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
