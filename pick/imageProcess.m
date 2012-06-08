//
//  imageProcess.m
//  pick
//
//  Created by Fan Yu on 12-04-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//   
//  Note: listed methods cited from online source tutorial
//  CreateRGBABitmapContext&
//  RequestImagePixelData(UIImage *inImage)

#import "imageProcess.h"

#include <sys/time.h>
#include <math.h>
#include <stdio.h>
#include <string.h>



@implementation imageProcess


#pragma mark- 
+ (UIImage*)comic:(UIImage*)inImage
{
    
    NSData *imageData = UIImagePNGRepresentation(inImage);
    CIImage *start = [CIImage imageWithData:imageData];
    CIContext *context = [CIContext contextWithOptions:nil];
    /* CIFilter *filter = [CIFilter filterWithName:@"CIVibrance" 
     keysAndValues: kCIInputImageKey, start, 
     @"inputAmount", [NSNumber numberWithFloat:0.5], nil];    */
    CIFilter *filter = [CIFilter filterWithName:@"CIToneCurve" 
                                  keysAndValues: kCIInputImageKey, start, 
                        @"inputPoint0", [CIVector vectorWithX:0.7 Y:0.7],
                        @"inputPoint1", [CIVector vectorWithX:0.3 Y:0.3],
                        @"inputPoint2", [CIVector vectorWithX:0.7 Y:0.3],
                        @"inputPoint3", [CIVector vectorWithX:0.75 Y:0.75],
                        @"inputPoint4", [CIVector vectorWithX:0.5 Y:0.5],
                        nil]; 
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    return newImg;

}

+ (UIImage*)sepia:(UIImage *)inImage
{
    NSData *imageData = UIImagePNGRepresentation(inImage);
    CIImage *start = [CIImage imageWithData:imageData];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" 
                                  keysAndValues: kCIInputImageKey, start, 
                        @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    return newImg;

}

+ (UIImage*)highlights:(UIImage *)inImage
{
    NSData *imageData = UIImagePNGRepresentation(inImage);
    CIImage *start = [CIImage imageWithData:imageData];
    CIContext *context = [CIContext contextWithOptions:nil];
     CIFilter *filter = [CIFilter filterWithName:@"CIVibrance" 
                                   keysAndValues: kCIInputImageKey, start, 
                         @"inputAmount", [NSNumber numberWithFloat:-1.0], nil];    
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    return newImg;
    
}

+ (UIImage*)monochrome:(UIImage *)inImage
{
    NSData *imageData = UIImagePNGRepresentation(inImage);
    CIImage *start = [CIImage imageWithData:imageData];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome" 
                                  keysAndValues: kCIInputImageKey, start, 
                        @"inputIntensity", [NSNumber numberWithFloat:1.0], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];  
    return newImg;
}


@end
