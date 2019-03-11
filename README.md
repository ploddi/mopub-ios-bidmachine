# BidMachine adapter

This folder contains mediation adapters used to mediate BidMachine.

## Getting Started

### Initialization parameters

To initialize BidMachine set your's seller id in MPMoPubConfiguration:

```
MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization: @"AD_UNIT_ID"];
[sdkConfig setNetworkConfiguration:@{@"sellerId" : @"YOUR_SELLER_ID"} forMediationAdapter:@"BidMachineAdapterConfiguration"];
```

### Transfer targeting data to BidMachine

If you want to transfer targeting information you should use custom event's property ***localExtras*** which represents dictionary.
Keys for ***localExtras*** are listed below (Banner and Interstitial):

```
@"userId"   --> Vendor-specific ID for the user (NSString)
@"gender"   --> User gender refer to OpenRTB 2.5 spec (kBDMUserGenderMale, kBDMUserGenderFemale, kBDMUserGenderUnknown)
@"yob"      --> User year of birth (NSNumber)
@"keywords" --> Comma separated list of keywords about the app (NSString)
@"bcat"     --> Blocked advertiser categories using the IAB content categories. Refer to List 5.1 (NSArray <NSString *>)
@"badv"     --> Block list of advertisers by their domains (e.g., “ford.com”) (NSArray <NSString *>)
@"bapps"    --> Block list of applications by their platform-specific exchange- independent application identifiers (NSArray <NSString *>)
@"country"  --> User country (NSString)
@"city"     --> User city (NSString)
@"zip"      --> User zip code (NSString)
@"sturl"    --> Store URL (NSURL)
@"stid"     --> Numeric store id identifier (NSString)
@"paid"     --> Paid version of app (NSNumber: 0-free, 1-paid)
```
***localExtras*** for rewarded video custom event should include one more key:
```
@"location" - User's location (CLLocation)
```
