//
//  BidMachineInterstitialCustomEvent.m
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/4/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "BidMachineInterstitialCustomEvent.h"
#import "BidMachineFactory+Request.h"
#import <BidMachine/BidMachine.h>

@interface BidMachineInterstitialCustomEvent() <BDMInterstitialDelegate>

@property (nonatomic, strong) BDMInterstitial *interstitial;

@end

@implementation BidMachineInterstitialCustomEvent

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    NSNumber *price = info[@"price"];
    BDMInterstitialRequest *request = [[BidMachineFactory sharedFactory] interstitialRequestWithLocalExtras:self.localExtras
                                                                              location:self.delegate.location
                                                                                 price:price];
    [self.interstitial populateWithRequest:request];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    [self.interstitial presentFromRootViewController:rootViewController];
}

- (NSString *)getAdNetworkId {
    return (self.interstitial.auctionInfo) ? self.interstitial.auctionInfo.bidID : @"";
}

#pragma mark - Lazy

- (BDMInterstitial *)interstitial {
    if (!_interstitial) {
        _interstitial = [BDMInterstitial new];
    }
    return _interstitial;
}

#pragma mark - BDMInterstitialDelegate

- (void)interstitialReadyToPresent:(nonnull BDMInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didLoadAd:self];
}

- (void)interstitial:(nonnull BDMInterstitial *)interstitial failedWithError:(nonnull NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)interstitialWillPresent:(nonnull BDMInterstitial *)interstitial {
    MPLogAdEvent(MPLogEvent.adShowSuccess, [self getAdNetworkId]);
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate interstitialCustomEventDidAppear:self];
    [self.delegate trackImpression];
    
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
}

- (void)interstitial:(nonnull BDMInterstitial *)interstitial failedToPresentWithError:(nonnull NSError *)error {
    MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
}

- (void)interstitialDidDismiss:(nonnull BDMInterstitial *)interstitial {
    [self.delegate interstitialCustomEventDidDisappear:self];
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
}

- (void)interstitialRecieveUserInteraction:(nonnull BDMInterstitial *)interstitial {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
}

@end
