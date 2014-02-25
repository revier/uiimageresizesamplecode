//
//  UIImage+Resize.m
//
//  Created by Elvis Shu on 2012/10/17.
//  Revised by Elvis Shu on 2014/2/12

#import "UIImage+Resize.h"

#define radians( degrees ) ( degrees * M_PI / 180 )

@implementation UIImage (Resize)

// this function works for photo taken from camera. Photos from other sources may have different situations.
- (UIImage *)resizeToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    
    
    NSLog(@"targetedSize: width %f , height %f", targetSize.width,targetSize.height);
    NSLog(@"originalImage Size: width %f , height %f", self.size.width,self.size.height);
    
    CGFloat targetWidth;
    CGFloat targetHeight;
    
    CGImageRef imageRef = [sourceImage CGImage];
    NSLog(@"imageRef Size: width %zu , height %zu", CGImageGetWidth(imageRef),CGImageGetHeight(imageRef));
    
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = (CGBitmapInfo)kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        
        targetWidth = targetSize.width;
        targetHeight = targetSize.height;
        bitmap = CGBitmapContextCreate(NULL, targetSize.width, targetSize.height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    }
    else {
        
        targetWidth = targetSize.height;
        targetHeight = targetSize.width;
        //Bytes per row can be anything as long as it is sufficient to hold the image bounds
        bitmap = CGBitmapContextCreate(NULL, targetSize.width, targetSize.height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    }
    
    // transform
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    }
    else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    }
    else if (sourceImage.imageOrientation == UIImageOrientationUp) {
    }
    else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, radians(-180.));
    }

    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextDrawImage(bitmap, CGRectMake(0, 0, targetSize.width, targetSize.height), imageRef);
    }
    else{
        CGContextDrawImage(bitmap, CGRectMake(0, 0, targetSize.height, targetSize.width), imageRef);
    }
    

    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage;
    
}


@end
