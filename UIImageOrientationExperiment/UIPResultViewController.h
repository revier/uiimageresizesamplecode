//
//  UIPResultViewController.h
//  UIImageOrientationExperiment
//
//  Created by Elvis on 2/25/14.
//  Copyright (c) 2014 Elvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPResultViewController : UIViewController

@property (nonatomic,retain) UIImage *originalImage;
@property (nonatomic,retain) UIImage *editedImage;

@property (nonatomic,weak) IBOutlet UIImageView *originalImageView;
@property (nonatomic,weak) IBOutlet UIImageView *editedImageView;

- (IBAction)goBack:(id)sender;

@end
