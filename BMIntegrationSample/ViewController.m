//
//  ViewController.m
//  BMIntegrationSample
//
//  Created by Yaroslav Skachkov on 3/1/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "ViewController.h"
#import <mopub-ios-sdk/MoPub.h>

@interface ViewController () <MPAdViewDelegate, MPInterstitialAdControllerDelegate, MPRewardedVideoDelegate>
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
    [self.view addSubview:self.adView];
    NSDictionary *localExtras = @{@"seller_id": @"1",
                                  @"coppa": @"true",
                                  @"logging_enabled": @"true",
                                  @"test_mode": @"true",
                                  @"banner_width": @"320",
                                  @"userId": @"user123",
                                  @"gender": @"F",
                                  @"yob": @"2000",
                                  @"keywords": @"Keyword_1,Keyword_2,Keyword_3,Keyword_4",
                                  @"country": @"Russia",
                                  @"city": @"Kirov",
                                  @"zip": @"610000",
                                  @"sturl": @"https://store_url.com",
                                  @"paid": @"true",
                                  @"bcat": @"IAB-1,IAB-3,IAB-5",
                                  @"badv": @"https://domain_1.com,https://domain_2.org",
                                  @"bapps": @"com.test.application_1,com.test.application_2,com.test.application_3",
                                  @"priceFloors": @[@{
                                                        @"id_1": @300.06
                                                        }, @{
                                                        @"id_2": @1000
                                                        },
                                                    @302.006,
                                                    @1002
                                                    ]
                                  };
    [self.adView setLocalExtras:localExtras];
    [self.adView loadAd];
}

- (IBAction)loadInterstitialButtonTapped:(id)sender {
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"ec95ba59890d4fda90a4acf0071ed8b5"];
    self.interstitial.delegate = self;
    NSDictionary *localExtras = @{@"seller_id": @"1",
                                  @"coppa": @"true",
                                  @"logging_enabled": @"true",
                                  @"test_mode": @"true",
                                  @"ad_content_type": @"All",
                                  @"userId": @"user123",
                                  @"gender": @"F",
                                  @"yob": @"2000",
                                  @"keywords": @"Keyword_1,Keyword_2,Keyword_3,Keyword_4",
                                  @"country": @"Russia",
                                  @"city": @"Kirov",
                                  @"zip": @"610000",
                                  @"sturl": @"https://store_url.com",
                                  @"paid": @"true",
                                  @"bcat": @"IAB-1,IAB-3,IAB-5",
                                  @"badv": @"https://domain_1.com,https://domain_2.org",
                                  @"bapps": @"com.test.application_1,com.test.application_2,com.test.application_3",
                                  @"priceFloors": @[@{
                                                        @"id_1": @300.06
                                                        }, @{
                                                        @"id_2": @1000
                                                        },
                                                    @302.006,
                                                    @1002
                                                    ]
                                  };
    [self.interstitial setLocalExtras:localExtras];
    [self.interstitial loadAd];
    [self.interstitial showFromViewController:self];
}

- (IBAction)loadRewardedButtonTapped:(id)sender {
    [MPRewardedVideo setDelegate:self forAdUnitId:@"b94009cbb6b7441eb097142f1cb5e642"];
    NSDictionary *localExtras = @{@"seller_id": @"1",
                                  @"coppa": @"true",
                                  @"logging_enabled": @"true",
                                  @"test_mode": @"true",
                                  @"userId": @"user123",
                                  @"gender": @"F",
                                  @"yob": @"2000",
                                  @"keywords": @"Keyword_1,Keyword_2,Keyword_3,Keyword_4",
                                  @"country": @"Russia",
                                  @"city": @"Kirov",
                                  @"zip": @"610000",
                                  @"sturl": @"https://store_url.com",
                                  @"paid": @"true",
                                  @"bcat": @"IAB-1,IAB-3,IAB-5",
                                  @"badv": @"https://domain_1.com,https://domain_2.org",
                                  @"bapps": @"com.test.application_1,com.test.application_2,com.test.application_3",
                                  @"priceFloors": @[@{
                                                        @"id_1": @300.06
                                                        }, @{
                                                        @"id_2": @1000
                                                        },
                                                    @302.006,
                                                    @1002
                                                    ]
                                  };
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:@"b94009cbb6b7441eb097142f1cb5e642" keywords:nil userDataKeywords:nil location:nil customerId:nil mediationSettings:nil localExtras:localExtras];
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
