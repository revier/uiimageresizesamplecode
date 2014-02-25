//
//  UIPResultViewController.m
//  UIImageOrientationExperiment
//
//  Created by Elvis on 2/25/14.
//  Copyright (c) 2014 Elvis. All rights reserved.
//

#import "UIPResultViewController.h"

@interface UIPResultViewController ()

@end

@implementation UIPResultViewController

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
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidAppear:(BOOL)animated{
    self.originalImageView.image = self.originalImage;
    self.editedImageView.image = self.editedImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

@end
