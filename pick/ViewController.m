//
//  ViewController.m
//  pick
//
//  Created by Echo Yu on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "imageProcess.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imgV,scrollView;


#pragma mark-
//-----------------------------view implement-------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.contentSize = _scrollableView.frame.size;
        
    

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
        
        
        //set all preveiw image as background image on buttons
       
        preImg1 = currentImg;
        [_preButton1 setImage:preImg1 forState:UIControlStateNormal];
        NSLog(@"original image load");
        
        
        preImg2 = [imageProcess sepia:currentImg];
        [_preButton2 setImage:preImg2 forState:UIControlStateNormal];
        NSLog(@"sepia effect load");
        
       
        preImg3 = [imageProcess monochrome:currentImg];
        [_preButton3 setImage:preImg3 forState:UIControlStateNormal];
        NSLog(@"monochrome effect load");
        
      
        preImg4 = [imageProcess highlights:currentImg];
        [_preButton4 setImage:preImg4 forState:UIControlStateNormal];
        NSLog(@"highlights effect load");
        
        preImg5 = [imageProcess comic:currentImg];
        [_preButton5 setImage:preImg5 forState:UIControlStateNormal];
        NSLog(@"comic effect load");
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SAVE" message:@"Image has been successfully saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    NSLog(@"save successfully");
}

-(IBAction)preview1:(id)sender
{
 
    if (currentImg) {
        self.imgV.image = preImg1;
        NSLog(@"original image");
    }
    
}

-(IBAction)preview2:(id)sender
{
    if (currentImg) {
        self.imgV.image = preImg2;
        NSLog(@"sepia image");
    }
}

-(IBAction)preview3:(id)sender
{
    if (currentImg) {
        self.imgV.image = preImg3;
        NSLog(@"mono image");
    }
}

-(IBAction)preview4:(id)sender
{
    if (currentImg) {
        self.imgV.image = preImg4;
        NSLog(@"higlights image");
    }
}

-(IBAction)preview5:(id)sender
{
    if (currentImg) {
        self.imgV.image = preImg5;
        NSLog(@"comic image");
    }
}

#pragma mark-
//segament bar for old version
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
