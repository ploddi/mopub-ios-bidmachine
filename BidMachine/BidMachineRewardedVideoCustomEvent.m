//
//  BidMachineRewardedVideoCustomEvent.m
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/6/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "BidMachineRewardedVideoCustomEvent.h"
#import "Factory+Request.h"
#import <BidMachine/BidMachine.h>

@interface BidMachineRewardedVideoCustomEvent() <BDMRewardedDelegate>

@property (nonatomic, strong) BDMRewarded *rewarded;

@end

@implementation BidMachineRewardedVideoCustomEvent

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info {
    NSNumber *price = info[@"price"];
    CLLocationDegrees lat = [self.localExtras[@"lat"] doubleValue];
    CLLocationDegrees lon = [self.localExtras[@"lon"] doubleValue];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    BDMRewardedRequest *request = [[Factory sharedFactory] rewardedRequestWithLocalExtras:self.localExtras
                                                                                 location:location
                                                                                    price:price];
    [self.rewarded populateWithRequest:request];
}

- (BOOL)hasAdAvailable {
    return [self.rewarded canShow];
}

- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    [self.rewarded presentFromRootViewController:viewController];
}

#pragma mark - Lazy

- (BDMRewarded *)rewarded {
    if (!_rewarded) {
        _rewarded = [BDMRewarded new];
    }
    return _rewarded;
}

- (NSString *)getAdNetworkId {
    return (self.rewarded.auctionInfo) ? self.rewarded.auctionInfo.bidID : @"";
}

#pragma mark - BDMRewardedDelegatge

- (void)rewardedReadyToPresent:(nonnull BDMRewarded *)rewarded {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
}

- (void)rewarded:(nonnull BDMRewarded *)rewarded failedWithError:(nonnull NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
}

- (void)rewardedRecieveUserInteraction:(nonnull BDMRewarded *)rewarded {
    [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
    [self.delegate rewardedVideoWillLeaveApplicationForCustomEvent:self];
    
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
}

- (void)rewardedWillPresent:(nonnull BDMRewarded *)rewarded {
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
    
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
}

- (void)rewarded:(nonnull BDMRewarded *)rewarded failedToPresentWithError:(nonnull NSError *)error {
    MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
}

- (void)rewardedDidDismiss:(nonnull BDMRewarded *)rewarded {
    MPLogAdEvent([MPLogEvent adWillDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
    
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
}

- (void)rewardedFinishRewardAction:(nonnull BDMRewarded *)rewarded {
#warning Rewarded action
}

@end
