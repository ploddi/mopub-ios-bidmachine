//
//  BidMachineInstanceMediationSettings.h
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/5/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mopub-ios-sdk/MoPub.h>

@interface BidMachineInstanceMediationSettings : NSObject<MPMediationSettingsProtocol>

@property (nonatomic, copy) NSString *sellerId;

@end
