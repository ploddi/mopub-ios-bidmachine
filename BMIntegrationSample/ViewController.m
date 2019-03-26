//
//  ViewController.m
//  BMIntegrationSample
//
//  Created by Yaroslav Skachkov on 3/1/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "ViewController.h"
#import <mopub-ios-sdk/MoPub.h>

@interface ViewController () <MPAdViewDelegate, MPRewardedVideoDelegate>
@property (nonatomic, strong) MPAdView *adView;
@property (nonatomic, strong) MPInterstitialAdController *interstitial;
@property (nonatomic, strong) MPRewardedVideo *rewarded;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)loadAdButtonTapped:(id)sender {
    self.adView = [[MPAdView alloc] initWithAdUnitId:@"1832ce06de91424f8f81f9f5c77f7efd"
                                                size:MOPUB_BANNER_SIZE];
    self.adView.delegate = self;
    self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2,
                                   self.view.bounds.size.height - MOPUB_BANNER_SIZE.height,
                                   MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
    [self.adView.centerXAnchor constraintEqualToSystemSpacingAfterAnchor:self.view.centerXAnchor multiplier:1];
    [self.adView.centerYAnchor constraintEqualToSystemSpacingBelowAnchor:self.view.centerYAnchor multiplier:1/3];
    [self.view addSubview:self.adView];
    [self.adView setLocalExtras:@{@"ad_unit_id": @"b94009cbb6b7441eb097142f1cb5e642"}];
    [self.adView loadAd];
}

- (IBAction)loadInterstitialButtonTapped:(id)sender {
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"ec95ba59890d4fda90a4acf0071ed8b5"];
    [self.interstitial loadAd];
    [self.interstitial showFromViewController:self];
}

- (IBAction)loadRewardedButtonTapped:(id)sender {
    [MPRewardedVideo setDelegate:self forAdUnitId:@"b94009cbb6b7441eb097142f1cb5e642"];
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:@"b94009cbb6b7441eb097142f1cb5e642" withMediationSettings:nil];
    [MPRewardedVideo presentRewardedVideoAdForAdUnitID:@"b94009cbb6b7441eb097142f1cb5e642" fromViewController:self withReward:nil];
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

- (void)rewardedVideoAdDidLoadForAdUnitID:(NSString *)adUnitID {
    NSLog(@"Rewarded video did load ad for ad unit id %@", adUnitID);
}

@end
