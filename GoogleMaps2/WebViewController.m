//
//  WebViewController.m
//  GoogleMaps2
//
//  Created by Rael Kenny on 1/13/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc]init];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.frame
                                           configuration:theConfiguration];

    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    [self.view addSubview:webView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(goBack)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"<- BACK" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 80.0, 40.0);
    [self.view addSubview:button];
    [self.navigationController.navigationBar setHidden:NO];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
