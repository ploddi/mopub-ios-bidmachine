//
//  BidMachineInstanceMediationSettings.h
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/5/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#elif __has_include(<mopub-ios-sdk/MoPub.h>)
#import <mopub-ios-sdk/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
#import <MoPubSDKFramework/MoPub.h>
#else
#import "MPMediationSettingsProtocol.h"
#endif


@interface BidMachineInstanceMediationSettings : NSObject<MPMediationSettingsProtocol>

@property (nonatomic, copy) NSString *sellerId;

@end
