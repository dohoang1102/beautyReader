//
//  InAppPurchaseManager.m
//  movieSchool
//
//  Created by zhu zhanping on 12-5-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "InAppPurchaseManager.h"
#import "Reachability.h"

@interface InAppPurchaseManager()

- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful;
- (void)completeTransaction:(SKPaymentTransaction *)transaction;
- (void)restoreTransaction:(SKPaymentTransaction *)transaction;
- (void)failedTransaction:(SKPaymentTransaction *)transaction;
@end

@implementation InAppPurchaseManager

@synthesize productId,inAppPurchaseIndex;

-(void) reqestProUpgradeProductData {
    NSSet *productIdentifiers = [NSSet setWithObject:productId];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSArray *products = response.products;
    proUpgradeProduct = [products count]==1?[[products objectAtIndex:0] retain]:nil;
    if (response.invalidProductIdentifiers && [response.invalidProductIdentifiers count] > 0) {
        //购买失败，无效ID，返回界面错误信息
        for (NSString *invalidProductId in response.invalidProductIdentifiers) {
            //购买失败，无效ID，返回界面错误信息
            NSLog(@"Invalid product id: %@" , invalidProductId);
            [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
        }
    } else {
        if (productsRequest) {
            NSLog(@"Product title: %@" , proUpgradeProduct.localizedTitle);
            NSLog(@"Product description: %@" , proUpgradeProduct.localizedDescription);
            NSLog(@"Product price: %@" , proUpgradeProduct.price);
            NSLog(@"Product id: %@" , proUpgradeProduct.productIdentifier);
            [self purchaseProUpgrade];
        }
    }
    [productsRequest release];
}

-(void)loadStore {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    //检测网络状态是否可用
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if (reachability.currentReachabilityStatus == NotReachable) {//无网络连接
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无可用网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    // restarts any purchases if they were interrupted last time the app was open
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // get the product description (defined in early sections)
    [self reqestProUpgradeProductData];
}

-(BOOL)canMakePurchases {
    return [SKPaymentQueue canMakePayments];
}

-(void)purchaseProUpgrade {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:productId];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver methods

//
// called when the transaction status is updated
//
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

#pragma -
#pragma Purchase helpers

// removes the transaction from the queue and posts a notification with the transaction result
//
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction, @"transaction",[NSString stringWithFormat:@"%d",inAppPurchaseIndex],@"index", nil];
    if (wasSuccessful)
    {
        // send out a notification that we’ve finished the transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:userInfo];
    }
    else
    {
        // send out a notification for the failed transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:userInfo];
    }
}

//
// called when the transaction was successful
//
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
     NSLog(@"%@",NSStringFromSelector(_cmd));
    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has been restored and and successfully completed
//
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
     NSLog(@"%@",NSStringFromSelector(_cmd));
    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has failed
//
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
     NSLog(@"%@",NSStringFromSelector(_cmd));
    if (transaction.error.code != SKErrorPaymentCancelled) {
        // error!
        [self finishTransaction:transaction wasSuccessful:NO];
    } else {
        // this is fine, the user just cancelled, so don’t notify
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

-(void) dealloc {
    [productId release];
    [super dealloc];
}

@end
