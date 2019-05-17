//
//  BidMachineFactory+Request.h
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/6/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "BidMachineFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidMachineFactory (Request)

- (BDMBannerRequest *)setupBannerRequestWithSize:(CGSize)size
                                       extraInfo:(NSDictionary *)extraInfo
                                        location:(CLLocation *)location
                                     priceFloors:(NSArray *)priceFloors;

- (BDMInterstitialRequest *)interstitialRequestWithExtraInfo:(NSDictionary *)extraInfo
                                                    location:(CLLocation *)location
                                                 priceFloors:(NSArray *)priceFloors;

- (BDMRewardedRequest *)rewardedRequestWithExtraInfo:(NSDictionary *)extraInfo
                                            location:(CLLocation *)location
                                         priceFloors:(NSArray *)priceFloors;

@end

NS_ASSUME_NONNULL_END
