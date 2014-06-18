//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-17.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

//overrides abstract parent method
- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

//overrides abstract parent method
- (int)numberOfCardsToMatch
{
    return 3;
}

@end
