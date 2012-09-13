//
//  ViewController.h
//  pick
//
//  Created by Echo Yu on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>



@interface ViewController :  UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

{
    bool newMedia;
    UIImage *currentImg;
    UIImage *preImg1;
    UIImage *preImg2;
    UIImage *preImg3;
    UIImage *preImg4;
    UIImage *preImg5;
    
}



@property (nonatomic,retain) IBOutlet UIImageView *imgV;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) IBOutlet UIView *scrollableView;
@property (nonatomic,retain) IBOutlet UIButton *preButton1;
@property (nonatomic,retain) IBOutlet UIButton *preButton2;
@property (nonatomic,retain) IBOutlet UIButton *preButton3;
@property (nonatomic,retain) IBOutlet UIButton *preButton4;
@property (nonatomic,retain) IBOutlet UIButton *preButton5;


-(IBAction)load:(id)sender;
-(IBAction)camera:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)effects:(id)sender;
-(IBAction)crop:(id)sender;

//preview buttons
-(IBAction)preview1:(id)sender;
-(IBAction)preview2:(id)sender;
-(IBAction)preview3:(id)sender;
-(IBAction)preview4:(id)sender;
-(IBAction)preview5:(id)sender;



@end

