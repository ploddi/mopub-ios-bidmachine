//
//  ViewController.m
//  BMIntegrationSample
//
//  Created by Yaroslav Skachkov on 3/1/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "ViewController.h"
#import <mopub-ios-sdk/MoPub.h>

@interface ViewController () <MPAdViewDelegate>
@property (nonatomic, strong) MPAdView *adView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)loadAdButtonTapped:(id)sender {
    self.adView = [[MPAdView alloc] initWithAdUnitId:@"0ac59b0996d947309c33f59d6676399f"
                                                size:MOPUB_BANNER_SIZE];
    self.adView.delegate = self;
    self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2,
                                   self.view.bounds.size.height - MOPUB_BANNER_SIZE.height,
                                   MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
    [self.view addSubview:self.adView];
    [self.adView loadAd];
}

- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view {
    NSLog(@"Banner was loaded!");
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view {
    NSLog(@"Banner failed to load ad");
}

@end
