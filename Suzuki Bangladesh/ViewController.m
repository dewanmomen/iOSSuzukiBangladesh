//
//  ViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 3/21/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "ViewController.h"
#import "QuizCells.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)call:(id)sender {
    /*NSString *phoneNumber = [@"tel://" stringByAppendingString:@"123"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];*/
    [self callWithString:@"123"];
}

- (void)callWithString:(NSString *)phoneString {
    [self callWithURL:[NSURL URLWithString:[NSString
                                            stringWithFormat:@"tel:%@",phoneString]]];
}

- (void)callWithURL:(NSURL *)url {
    static UIWebView *webView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webView = [UIWebView new];
    });
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
