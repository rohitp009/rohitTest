//
//  ViewController.m
//  Medium
//
//  Created by Rohit Kumar on 20/09/17.
//  Copyright © 2017 FRS Labs. All rights reserved.
//

#import "ViewController.h"
#import "RTViewAttachment.h"
#import "RTViewAttachmentTextView.h"

@interface ViewController ()<UITextViewDelegate,RTViewAttachmentTextViewDelegate>

{
    UITextRange *textRange;
    UITextPosition *textStartPos;
    UITextPosition *textEndPo;
    
    NSArray *recipeImages;
    NSMutableDictionary *imageURLDict;
    
    int count;
    BOOL addImage;
}

//@property (nonatomic, assign) IBOutlet RTViewAttachmentTextView *textView;
//@property (nonatomic, assign) IBOutlet UIView *inputAccessoryView;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    count = 1;
   // [_textView becomeFirstResponder];
    addImage = NO;
    
    imageURLDict = [[NSMutableDictionary alloc]init];
    
    recipeImages = [[NSArray alloc ]initWithObjects:@"https://irs1.4sqi.net/img/general/200x200/52258596_RS2iJmMyKVb_lOoY2Q6MCWqlv56tAPQsx1EkrXnTF8Q.jpg",
                    @"https://irs0.4sqi.net/img/general/200x200/13478351_2JXdZ3zQgAjSdTBwUTubjeD0-j4Y8zoqUbcvtxerJwg.jpg",
                    @"https://irs0.4sqi.net/img/general/200x200/41022733_QIcPzfbdOEP9kIQk97ce9VMT0voJjTMEVck61zQLfbM.jpg",
                    @"https://irs2.4sqi.net/img/general/200x200/15747918_fTZuNwGyIIX13RrcggmubgWYUuoQAdnlNU_hpcR0H84.jpg",
                    /*@"http://icongal.com/gallery/image/5904/cycle_bike.png",*/
                    @"https://media-cdn.tripadvisor.com/media/photo-s/04/11/49/72/aquatic-park-part-of.jpg",
                    @"https://media-cdn.tripadvisor.com/media/photo-s/01/86/a1/6e/caption.jpg",
                    @"https://irs0.4sqi.net/img/general/200x200/39336292_W9Z7pnyGA7h06kuVXYAJdw0xmy37kL9I0-IACDR3xpE.jpg",
                    @"https://irs1.4sqi.net/img/general/200x200/9367297_fuNQiQrMtFMjXEs1Bi3Gu8sv8ieOmQhAqtz1LVQki6k.jpg", nil];
    
    for (NSString *imgUrl in recipeImages) {
        
        [self getImageFromNetwork:imgUrl];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)addAttributedImage:(id)sender {
    
    addImage = YES;
    
    NSUInteger location = _textView.selectedRange.location;
    NSLog(@"Rohit addAttributedImage %lu %lu",(unsigned long)_textView.selectedRange.location,(unsigned long)location);
    
    
   // if (textRange == nil) {
        
   // NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"before after"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",count ]];
    
    CGFloat oldWidth = textAttachment.image.size.width;
    
    //I'm subtracting 10px to make the image display nicely, accounting
    //for the padding inside the textView
    CGFloat scaleFactor = oldWidth / (self.textView.frame.size.width - 10);
    textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString replaceCharactersInRange:NSMakeRange(location, 0) withAttributedString:attrStringWithImage];
    _textView.attributedText = attributedString;

    /*
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    UIImage *imageTest=[UIImage imageNamed:@"1-cow-png-image.png"];
    attachment.image = imageTest;
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"My label text "];
    NSMutableAttributedString *myStringWithArrow = [[NSMutableAttributedString alloc]initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
   // [myStringWithArrow appendAttributedString:myString];
    _textView.attributedText = myStringWithArrow;*/
    //}
    NSLog(@"Rohit attributed text is %@",attributedString);
    count++;

}

// Delegates

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
 
    NSLog(@"Rohit Text is %@",textView.attributedText);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSLog(@"Rohit shouldChangeTextInRange : Length : %lu Location : %lu",(unsigned long)range.length,(unsigned long)range.location);
    
    if (addImage) {
        
       /* NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
        NSLog(@"Rohit attributed text is %@",attributedString);
     
            
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed:@"1-cow-png-image.png"];
        
        CGFloat oldWidth = textAttachment.image.size.width;
        
        //I'm subtracting 10px to make the image display nicely, accounting
        //for the padding inside the textView
        CGFloat scaleFactor = oldWidth / (self.textView.frame.size.width - 10);
        textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
        NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [attributedString replaceCharactersInRange:NSMakeRange(range.location, 1) withAttributedString:attrStringWithImage];
        _textView.attributedText = attributedString;
    
        addImage = false;*/
   }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    
    
    NSLog(@"Rohit should interact : Length : %lu Location : %lu",(unsigned long)characterRange.length,(unsigned long)characterRange.location);
    
    
    return YES;
}

-(void) textViewDidBeginEditing:(UITextView *)textView {
    
    NSLog(@"Rohit %lu",(unsigned long)_textView.selectedRange.location);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getImageFromNetwork: (NSString *)image2URL {
    
    // NSString *imageURL = @"http://139.59.34.96/static/uploads/2017-01-18192431.538190.png";
    NSLog(@"Rohit : getImageFromNetwork %@  AND  %@",image2URL,imageURLDict);
    NSString *myImageURL = image2URL;
    if ([imageURLDict objectForKey:myImageURL] == nil) {
        NSLog(@"Rohit : Activity View: Image if nil");
       // self.imageView.image = [UIImage imageNamed:@"Avatar1.png"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:myImageURL]]];
            NSLog(@"Rohit : getImageFromNetwork image is : %@",image);
            if (!image) {
                image = [UIImage imageNamed:@"Avatar1.png"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
              //  self.imageView.image = image;
                
                [imageURLDict setObject:image forKey:myImageURL];
                NSLog(@"Rohit : getImageFromNetwork Dict  is : %@",imageURLDict);
            });
        });
    }
    else{
        NSLog(@"Rohit : Activity View: Image not nil ");
       // self.imageView.image =[imageURLDict objectForKey:myImageURL];
    }
}

- (IBAction)convertButtonPressed:(id)sender {
    
}

- (IBAction)retrieveButtonPressed:(id)sender {
    
}


@end
