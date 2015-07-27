//
//  resourceViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 24/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "resourceViewController.h"
#import "AppDelegate.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface resourceViewController ()

@end

@implementation resourceViewController

@synthesize webView, shareButtonRef;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *nextPDFView = AppDelegate.nextPDFView;
    
    // Do any additional setup after loading the view.
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:nextPDFView ofType:@"pdf"]]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [webView loadRequest:[NSURLRequest alloc]];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //now traverse to specific page
    int pages = AppDelegate.nextPDFPage;
    NSLog(@"%d", pages);
    [self performSelector:@selector(traverseInWebViewWithPage:) withObject:[NSNumber numberWithInt:pages] afterDelay:0.1];
}


- (void)traverseInWebViewWithPage: (int) nextPage {
    NSString *strPDFFilePath = [[NSBundle mainBundle] pathForResource:AppDelegate.nextPDFView ofType:@"pdf"];
    NSInteger totalPDFPages = [self getTotalPDFPages:strPDFFilePath];
    
    CGFloat totalPDFHeight = webView.scrollView.contentSize.height;
    NSLog ( @"TfEL Maths: Presentation - total pdf height: %f", totalPDFHeight);
    
    NSInteger horizontalPaddingBetweenPages = 10*(totalPDFPages+1);
    CGFloat pageHeight = (totalPDFHeight-horizontalPaddingBetweenPages)/(CGFloat)totalPDFPages; // Should be about 700
    NSLog ( @"TfEL Maths: Presentation - pdf page height: %f", pageHeight);
    
    NSInteger specificPageNo = nextPage;
    if(specificPageNo <= totalPDFPages)
    {
        //calculate offset point in webView
        CGPoint offsetPoint = CGPointMake(0, (10*(specificPageNo-1))+(pageHeight*(specificPageNo-1)));
        //set offset in webView
        [webView.scrollView setContentOffset:offsetPoint];
    }
}

-(NSInteger)getTotalPDFPages:(NSString *)strPDFFilePath
{
    NSURL *pdfUrl = [NSURL fileURLWithPath:strPDFFilePath];
    CGPDFDocumentRef document = CGPDFDocumentCreateWithURL((CFURLRef)pdfUrl);
    size_t pageCount = CGPDFDocumentGetNumberOfPages(document);
    return pageCount;
}

- (IBAction)shareButton:(id)sender {
    NSData *sheetData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AppDelegate.nextPDFView ofType:@"pdf"]];
    NSString *sheetDescription = [NSString stringWithFormat:@"TfEL Maths Pedagogy Resource Sheet %@.", AppDelegate.nextPDFView];
    NSArray *shareSheetItems = @[sheetDescription, sheetData];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:shareSheetItems applicationActivities:nil];
    
    UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
    
    [popup presentPopoverFromRect:[[self.shareButtonRef valueForKey:@"view"] frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

@end
