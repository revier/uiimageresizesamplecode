//
//  UIPCameraViewController.h
//  UIImageProcess
//
//  Created by Elvis on 2/25/14.
//  Copyright (c) 2014 Elvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPCameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) IBOutlet UIButton *button;

-(IBAction)pushme:(id)sender;

@end
