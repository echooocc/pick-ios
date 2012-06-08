//
//  ViewController.h
//  pick
//
//  Created by Fan Yu on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>



@interface ViewController :  UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

{
    bool newMedia;
    UIImage *currentImg;
}



@property (nonatomic,retain) IBOutlet UIImageView *imgV;
@property (nonatomic,retain) UIView *subView;
//@property (nonatomic,retain) UIView *scollView;




-(IBAction)load:(id)sender;
-(IBAction)camera:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)effects:(id)sender;
-(IBAction)crop:(id)sender;


@end

