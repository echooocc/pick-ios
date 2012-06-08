//
//  ViewController.m
//  pick
//
//  Created by Fan Yu on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "imageProcess.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imgV,subView;


#pragma mark-
//-----------------------------view implement-------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    self.view.backgroundColor = [UIColor blackColor];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);

    } else {
        return YES;
    }
}

#pragma mark-
//------------------------helper--------------------------
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"load image");    
     //   UIImage *resizedImg = [imageProcess image:image fitInSize:CGSizeMake(320.0, 480.0)];
      //  NSLog(@"resized image");
        currentImg = image;
        self.imgV.image = image;
        
    }
    
}


-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error 
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark-
//-------------button action implementation---------------
-(IBAction)load:(id)sender
{ if ([UIImagePickerController isSourceTypeAvailable:
       UIImagePickerControllerSourceTypeSavedPhotosAlbum])
{
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = 
    UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:
                              (NSString *) kUTTypeImage,
                              nil];
    imagePicker.allowsEditing = NO;
    [self presentModalViewController:imagePicker animated:YES];
    newMedia = YES;
}
    
    
}

-(IBAction)camera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = 
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker 
                                animated:YES];
        newMedia = YES;
        
    }
    
}


-(IBAction)save:(id)sender
{
    if (newMedia)
        UIImageWriteToSavedPhotosAlbum(imgV.image, 
                                       self,
                                       @selector(image:finishedSavingWithError:contextInfo:),
                                       nil);
}



-(IBAction)effects:(id)sender {
    
    UISegmentedControl *sg = (UISegmentedControl*)sender;
    if(currentImg){
    UIImage *outImage = nil;
    if (sg.selectedSegmentIndex == 0) {
        outImage = [imageProcess monochrome:currentImg];
        self.imgV.image=outImage;
        NSLog(@"monochrome apply");
    } 
    if (sg.selectedSegmentIndex == 1) {
        NSLog(@"seg 1 selected");
        outImage = [imageProcess highlights:currentImg];
        self.imgV.image=outImage;
        NSLog(@"highlights apply");
    }
    if (sg.selectedSegmentIndex == 2) {
        
        NSLog(@"seg 2 selected");
        outImage = [imageProcess comic:currentImg];
        self.imgV.image=outImage;
        NSLog(@"comic apply");
        
    }
    if (sg.selectedSegmentIndex == 3) {
        
        NSLog(@"seg 3 selected");
        outImage = [imageProcess sepia:currentImg];
        self.imgV.image=outImage;
        NSLog(@"sepia apply");
        
    }
    /*  
        if (sg.selectedSegmentIndex == 5) {
            
            NSLog(@"seg 5 selected");
            outImage = [imageProcess cartoon:currentImg];
            self.imgV.image=outImage;
            NSLog(@"cartoon apply");
            
        }    
        if (sg.selectedSegmentIndex == 6) {
            
            NSLog(@"seg 6 selected");
            outImage = [imageProcess monochrome:currentImg];
            self.imgV.image=outImage;
            NSLog(@"monochrome apply");
        }    
        if (sg.selectedSegmentIndex == 7) {
            
            NSLog(@"seg 7 selected");
            outImage = [imageProcess highlights:currentImg];
            self.imgV.image=outImage;
            NSLog(@"highligthts apply");
            
        }
        
      */
    
    }
}


//fake crop methods only apply to original image with fixed rectangle selector
-(IBAction)crop:(id)sender {
    
if(currentImg){
    
    NSData *imageData = UIImagePNGRepresentation(currentImg);
    CIImage *start = [CIImage imageWithData:imageData];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CICrop" 
                                  keysAndValues: kCIInputImageKey, start, 
                        @"inputRectangle", [CIVector vectorWithX:150 Y:150 Z:150 W:150], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    NSLog(@"crop apply");
    [imgV setImage:newImg];
    
    }
}
@end
