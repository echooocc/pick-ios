//
//  imageProcess.h
//  pick
//
//  Created by Fan Yu on 12-04-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#include <OpenGLES/ES1/gl.h>
#include <OpenGLES/ES1/glext.h>

@interface imageProcess : NSObject 

//cumstom rgb caculate 
+ (UIImage*)blackWhite:(UIImage*)inImage;
+ (UIImage*)cartoon:(UIImage*)inImage;
+ (UIImage*)pop:(UIImage*)inImage;


#pragma mark -
//fliters implement
+ (UIImage*)comic:(UIImage*)inImage;
+ (UIImage*)sepia:(UIImage*)inImage;
+ (UIImage*)highlights:(UIImage *)inImage;
+ (UIImage*)monochrome:(UIImage *)inImage;



@end
