//
//  UIPCameraViewController.m
//  UIImageProcess
//
//  Created by Elvis on 2/25/14.
//  Copyright (c) 2014 Elvis. All rights reserved.
//

#import "UIPCameraViewController.h"
#import "UIPResultViewController.h"
#import "UIImage+Resize.h"

@interface UIPCameraViewController ()
@property (nonatomic,strong) UIImagePickerController *picker;
@property (nonatomic,strong) UIPResultViewController *resultViewController;
@end

@implementation UIPCameraViewController

- (void)dealloc{
    self.picker = nil;
    self.resultViewController = nil;
}

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
    self.view.backgroundColor = [UIColor yellowColor];
    self.picker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    self.picker.delegate = self;
    self.picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    self.resultViewController = [[UIPResultViewController alloc] initWithNibName:@"UIPResultViewController" bundle:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushme:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self presentViewController:self.picker animated:TRUE completion:NULL];
    }
    else{
        UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Push me on a real device with camera." message:Nil delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alertview show];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.resultViewController.originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.resultViewController.editedImage = [self.resultViewController.originalImage resizeToSize:CGSizeMake(640, 720)];
    
    // below code is for checking the image saved in local file system.
    NSString *dirPath;
    NSArray *dirArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE);
    dirPath = [dirArray objectAtIndex:0];
    NSString *originalFilePath = [dirPath stringByAppendingPathComponent:@"original.png"];
    NSString *editedFilePath = [dirPath stringByAppendingPathComponent:@"edited.png"];
    
    NSData *originalData = UIImagePNGRepresentation(self.resultViewController.originalImage);
    [originalData writeToFile:originalFilePath atomically:TRUE];
    NSData *editedData = UIImagePNGRepresentation(self.resultViewController.editedImage);
    [editedData writeToFile:editedFilePath atomically:TRUE];
    
    [self.picker pushViewController:self.resultViewController animated:TRUE];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:TRUE completion:NULL];
}
@end
