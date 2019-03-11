//
//  BidMachineBannerCustomEvent.m
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/1/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "BidMachineBannerCustomEvent.h"
#import "BidMachineAdapterConfiguration.h"
#import "BidMachineFactory+Request.h"

#import <BidMachine/BidMachine.h>

@interface BidMachineBannerCustomEvent() <BDMBannerDelegate>

@property (nonatomic, strong) BDMBannerView *bannerView;

@end

@implementation BidMachineBannerCustomEvent

- (instancetype)init {
    self = [super init];
    if (self) {
        self.bannerView.delegate = self;
    }
    return self;
}

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    [BidMachineAdapterConfiguration updateInitializationParameters:info];
    NSNumber * price = info[@"price"];
    BDMBannerRequest * request = [[BidMachineFactory sharedFactory] setupBannerRequestWithSize:size
                                                                         LocalExtras:self.localExtras
                                                                            location:self.delegate.location
                                                                               price:price];
    [self.bannerView populateWithRequest:request];
}

#pragma mark - Lazy

- (BDMBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [BDMBannerView new];
    }
    return _bannerView;
}

- (NSString *)getAdNetworkId {
    return (self.bannerView.latestAuctionInfo) ? self.bannerView.latestAuctionInfo.bidID : @"";
}

#pragma mark - BDMBannerDelegate

- (void)bannerViewReadyToPresent:(nonnull BDMBannerView *)bannerView {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate bannerCustomEvent:self didLoadAd:bannerView];
}

- (void)bannerView:(nonnull BDMBannerView *)bannerView failedWithError:(nonnull NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)bannerViewRecieveUserInteraction:(nonnull BDMBannerView *)bannerView {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
}

- (void)bannerViewWillLeaveApplication:(BDMBannerView *)bannerView {
    MPLogAdEvent([MPLogEvent adWillLeaveApplication], [self getAdNetworkId]);
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

- (void)bannerViewWillPresentScreen:(BDMBannerView *)bannerView {
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)bannerViewDidDismissScreen:(BDMBannerView *)bannerView {
    MPLogAdEvent([MPLogEvent adDidDisappear], [self getAdNetworkId]);
    [self.delegate bannerCustomEventDidFinishAction:self];
}

@end
