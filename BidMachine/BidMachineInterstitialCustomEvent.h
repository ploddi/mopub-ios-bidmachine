//
//  BidMachineInterstitialCustomEvent.h
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/4/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#elif __has_include(<mopub-ios-sdk/MoPub.h>)
#import <mopub-ios-sdk/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
#import <MoPubSDKFramework/MoPub.h>
#else
#import "MPInterstitialCustomEvent.h"
#endif


@interface BidMachineInterstitialCustomEvent : MPInterstitialCustomEvent

@end

